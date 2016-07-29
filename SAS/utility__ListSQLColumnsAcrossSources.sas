/* ===========================================================================================
   AUTHOR: Nicole M. Lindner-Miles (N DOT Lindner PLUSSIGN SasUtility AT Gmail DOT COM)

   PURPOSE:
      *  Generate a list of SQL SELECT items, by iterating across a list of columns 
         and then across a list of sources for each column
      *  Useful when comparing multiple similar (or...supposed to be identical) 
         data sources. 

   NOTES:
      *  label='' (blank) overrides SAS setting the original field name as
         the aliased fields label
      *  All &Cross... input parameters must have the same number of items. 
         No DQ checks are done here, so mind your own macro calls.

   EXAMPLE:
      CREATE TABLE work.dataSrcCompare AS
         SELECT
             COALESCE(old.Field_PK, new.Field_PK) AS Field_PK
            ,%ListSQLColumnsAcrossSources(
                columns=charVarA intVarA dateVarA
               ,aliases=char_Var_A int_Var_A date_Var_A
               ,formats=$32. comma12.0 datetime20.
               ,dlm=%str( )
               ,CrossPrefixes=old. new.
               ,CrossAliasSuffixes=_old _new
               )
         FROM
            work.dataSrcOld old
            FULL JOIN work.dataSrcNew new
               ON new.Field_PK = old.Field_PK;

      * SELECT for the above example call evaluates to
         SELECT
             COALESCE(old.Field_PK, new.Field_PK) AS Field_PK
            ,old.charVarA AS char_Var_A_old label='' format=$32.
            ,new.charVarA AS char_Var_A_new label='' format=$32.
            ,old.intVarA AS int_Var_A_old label='' format=comma12.
            ,new.intVarA AS int_Var_A_new label='' format=comma12.
            ,old.dateVarA AS date_Var_A_old label='' format=datetime20.
            ,new.dateVarA AS date_Var_A_new label='' format=datetime20.
            ,...

   CHANGE LOG:
      2016.05.09 NLM (Nicole Lindner-Miles) 
         *  Initial version

   OWNERSHIP:
      *  This code was developed by me, Nicole M. Lindner-Miles, on my own time 
         without company resources or proprietary/confidential information.

   LICENSE:
      Copyright (c) 2016 Nicole M. Lindner-Miles

      Permission is hereby granted, free of charge, to any person obtaining a copy
      of this software and associated documentation files (the "Software"), to deal
      in the Software without restriction, including without limitation the rights
      to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
      copies of the Software, and to permit persons to whom the Software is
      furnished to do so, subject to the following conditions:

      The above copyright notice and this permission notice shall be included in all
      copies or substantial portions of the Software.

      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
      FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
      AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
      LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
      OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
      SOFTWARE.   
=========================================================================================== */

%put * compiling ListSQLColumnsAcrossSources.sas 2016.07.29;

%macro ListSQLColumnsAcrossSources(columns=, aliases=, formats=, dlm=%str( ), CrossPrefixes=, CrossAliasSuffixes=);

   %local sqlList i_N j_N i j iWord iAlias iFmt jDlm jPrefix jAliasSuffix;

   %let i_N = %getItemCountInString(&columns, inDlm=&dlm);
   %let j_N = %getItemCountInString(&CrossPrefixes, inDlm=&dlm);


   /* basic DQ check */
   %if &i_N > 0
   %then %do;
      %let sqlList =;

      %do i = 1 %to &i_N;

         %let iWord = %scan(&columns, &i, &dlm);

         %if %bquote(&formats) ^= %str()
         %then %do;
            %let iFmt = %scan(&formats, &i, &dlm);
         %end;
         %else %do;
            %let iFmt =;
         %end;

         %if %bquote(&aliases) ^= %str() 
         %then %do;
            %let iAlias = %scan(&aliases, &i, &dlm);
         %end;
         %else %do;
            %let iAlias = &iWord;
         %end;

         %do j = 1 %to &j_N;

            %let jPrefix = %scan(&CrossPrefixes, &j, &dlm);
            %let jAliasSuffix = %scan(&CrossAliasSuffixes, &j, &dlm);

            %if &i = 1 AND &j = 1
            %then %do;
               %let jDlm=;
            %end;
            %else %do;
               %let jDlm=%bquote(, );
            %end;

            %let sqlList = &sqlList&jDlm &jPrefix&iWord AS &iAlias&jAliasSuffix label='';

            %if %bquote(&iFmt) ^= %str()
            %then %do;
               %let sqlList = &sqlList format=&iFmt;
            %end;

         %end;    

         %let sqlList = %unquote(&sqlList);
      %end;
   %end;
   
   &sqlList

%mend;