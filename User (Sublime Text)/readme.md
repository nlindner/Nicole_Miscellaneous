# My Configuration/Settings for Sublime Text

These are my core Sublime setting files and snippets

	Preferences.sublime-settings
	- My preferred settings.
	- Add "SQL" to "ignored_packages" if you want to install my Packages/User/SQL package instead.
	- To get some additional SAS syntax/keyword highlighting, add  "color_scheme": "Packages/User/SublimeColors Solarized Light Customized.tmTheme",

	bh_core.sublime-settings
	- Dependent on:	BracketHighlighter package
	- My user settings. If you have your own, then at minimum, need to add "sas_mac" to your user_brackets section.

	Batch File.sublime-settings
	- Installed so that SOME syntax highlighting will be applied to *.cmd files

	reg_replace.sublime-settings
	- Dependent on: Reg Replace plugin.
	- These are the Regex patterns that I search for to clean Notes, Info and Error messages from SAS macro (when I use *put to write extra messages to the SAS log).
	- The DB2 replacements are dependent on applying some parsing to the text returned when querying DB2 Stored Procedures (from syscat.routines)
	
	Default.sublime-commands
	- Dependent on: Reg Replace plugin. See that plugin's documentation
	- These combine the replacement REGEX queries from reg_replace.sublime-settings
	
	All files ending in .sublime-snippet
	- Templates/auto-insert text. Believe that once you add any of these, Ctrl+Shift+p, starts autocompletion of Snippet and inserts these code snippets wherever your cursor is located in the current code window.

	Sublimerge.sublime-settings
	- Dependent on: Sublimerge plugin (I have the Pro version, so it doesn't pester me to buy a license, but that's not required)
	
