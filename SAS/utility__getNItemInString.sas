/* ===========================================================================================
	AUTHOR: Nicole M. Lindner-Miles (N DOT Lindner PLUSSIGN Sas AT Gmail DOT com)

	PURPOSE:
		*	Count number of "items" in the input &string, if &string is delimited by &inDlm
			-	Returns zero if the string is blank or equals the inDlm
			-	Returns 1 if string is a single-item list (does not contain inDlm)

	EXAMPLE CALLS:
		%let i = 1;
		%let expectResult = 3;
		%let testResult = %getItemCountInString(intVarA charVar2 dateVar3, inDlm=%str( ));
		%put Test&i &TestResult passes: %eval(&expectResult = &TestResult);
		%put * Test&i is still here;

		%let i = 2;
		%let expectResult = 3;
		%let testResult = %getItemCountInString(%nrbquote(Label & Stuff|Why Defect%|NormalLabelHere)
				, inDlm=%str(|));
		%put Test&i &TestResult passes: %eval(&expectResult = &TestResult);
		%put * Test&i is still here;	

	CHANGE LOG
		2016.05.09 NLM (Nicole Lindner-Miles) 
			*	Initial version

	OWNERSHIP:
		*	This idea does not originate with me, it is adapted from SAS Sample 26152 
			(http://support.sas.com/kb/26/152.html)
		*	This code was developed by me, Nicole M. Lindner-Miles, on my own time without 
			company resources or proprietary/confidential information.

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

%put * compiling getItemCountInString.sas 2016.05.09;

%macro getItemCountInString(string, inDlm=%str( ));

	%local NItem;
	%let NItem = 0;

	%if 
		%nrstr(&string) ^=
		AND %nrstr(&string) ^= %str(&inDlm)
	%then %do;
		%let NItem = %sysfunc(COUNTW(%nrbquote(&string), %str(&inDlm)));
	%end;

	&NItem

%mend;
