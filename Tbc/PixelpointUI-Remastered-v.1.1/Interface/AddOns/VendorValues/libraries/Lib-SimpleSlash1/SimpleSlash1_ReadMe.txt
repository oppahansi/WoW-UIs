
/\_*_/\_*_/\_*_/\ -- SimpleSlash1 ReadMe -- /\_*_/\_*_/\_*_/\

Addon type: Library
Libraries used:
	none



-- == -- == -- Description of Functionality -- == -- == --

This embeddable addon is a library that allows for slash command management. It is intended
for use by developers to do three things: increase efficiency by sharing a single slash command
management architecture; increase ease of development by handling most of the feedback and
parsing needed; and increase the ease with which users can learn the slash commands by
making a common format and layout standard across multiple addons.



-- == -- == -- History of Changes -- == -- == --

1.4.2 (Apr 14, 2008):
	- Changed the behaviour of non-option-based subcommand handlers with no statusText to
		avoid using the default GENERIC_STATUS string. Previously they did, and the contents
		of that string only refer to option-based subcommands, so it made no contextual sense.


1.4.1 (Apr 11, 2008):
	- Changed "status" specifier to "+status" to avoid collisions with client subcommands.


1.4.0 (Mar 28, 2008):
	- Added support for setting a handlerObj for each subcommand handler. If present, this
		will be used instead of the command-wide handlerObj.
	
	- Added support for omitting the inverted status argument on option-type subcommands,
		by means of the "noStatusInversion" subcommand handler property.
	
	- Added support for new "extraGetStartArg", "extraGetStartArgs", "extraGetEndArg",
		"extraGetEndArgs", "extraSetStartArg", "extraSetStartArgs", "extraSetEndArg", and
		"extraSetEndArgs" subcommand handler properties.
	
	- Cleaned up argument dispatch code for efficiency.


1.3.0 (Mar 9, 2008):
	- Added support for new "extraStartArg", "extraStartArgs", "extraEndArg", and "extraEndArgs"
		subcommand handler properties.
	
	- Miscellaneous code style updates.


1.2.1 (Jan 17, 2008):
	- If there is no custom error text associated with a subcommand when it encounters an error,
		then the actual error text will be used instead.
	
	- Once-only subcommands will now simply mark themselves as having already fired and produce
		an appropriate feedback message when triggered again instead of just deleting themselves
		outright.


1.2.0 (Jan 16, 2008):
	- Added new developer option: onceOnly. If true, the subcommand will delete itself after
		being triggered once.


1.1.0 (Dec 2, 2007):
	- Now supports multiple arguments per subcommand. Check the updated documentation.
		This change is backwards compatible.


1.0.1 (Nov 27, 2007):
	- Now properly takes over clients from earlier versions when upgrading in-place during load.


1.0.0 (Nov 13, 2007):
	- Initial release.



-- == -- == -- Developer Notes -- == -- == --

For the API, the following terms can be defined:
	command - The full typed command, such as "/slash foo bar 1".
	prefix - The first word in the command ("/slash"). Multiple prefixes can belong to the same client.
	subcommand - The first word in the command past the prefix ("foo"), or the configuration data
		that is accessed using this word.
	argument - The remaining text in the command past the prefix ("bar 1"). This is the data provided
		to the subcommand's functions, which tells them exactly what to do. This can optionally be
		split into multiple arguments ("bar" and "1", for instance).
		
	option - A configurable subcommand that can have at least two states.
	getFunc - A function used to get the current state of an option. It should accept arguments as
		follows: getFunc([infoTable as described below,] extraStartArg1, extraStartArg2, ..., arg1, arg2,
		..., extraEndArg1, extraEndArg2, ...).
	setFunc - A function used to set the current state of an option. It must return the resulting state
		of the option, as set by the arguments. It should accept arguments as follows: setFunc([infoTable
		as described below,] extraStartArg1, extraStartArg2, ..., arg1, arg2, ...[, invertedStatus], extraEndArg1,
		extraEndArg2, ...). invertedStatus is an inversion of the current status for the option (as returned from
		the getFunc), and is provided merely as a convenience for on/off options; options with more than two
		states can ignore this, or it can be explicitly disabled.
	actionFunc - A function that does not deal with states or options, but instead simply performs an
		action. This is only used for non-option-based subcommands. It should accept arguments in the
		same way as a getFunc.
		
	statusText - A subcommand-specific special feedback string used as a format template for results
		obtained from a getFunc or setFunc, or to confirm actions taken by a actionFunc. This is used for all
		non-error feedback for that subcommand. It may have the following special tokens, which will
		be substituted with the specified data before being printed:
			#i - The argument, as defined above. This is the whole argument, before it is split (if applicable).
			#i<n> - The split arguments, where <n> is each split argument as it was returned from the splitter.
			#c - The subcommand, as defined above.
			#s - Tense. This is either "now" or "currently", as defined in the localization file; the former
				when a toggle has been changed, or the latter when simply checking the current status
				of the toggle. Has no meaning for actionFuncs.
			#r - Result. This is the result option state returned from getFunc or setFunc. Has no meaning
				for actionFuncs.
		If this is absent from a subcommand after a successful getFunc or setFunc call, the GENERIC_STATUS
		statusText (from the localization file) will be used. If it is absent after a successful actionFunc call,
		no statusText will be printed.
		
	errorText - statusText which is appended to the GENERIC_ERROR statusText (from the localization
		file) and printed as the feedback if an error occurs during a getFunc, setFunc, or actionFunc call. This
		should be an explanation as to why the error may have occurred (invalid argument, etcetera). If
		this is absent, then the actual error text will be concatenated instead.
	
	infoTable - A table specifying all of the information for a client.
		The following basic keys will be recognized:
			_handlerObj - A table with keys specified by each individual subcommand that map to
				function values. Unnecessary if every subcommand specifies its own functions
				directly instead of as keys for this table.
			_sendHandler - If true, the _handlerObj will be sent as the first argument to every
				function it contains when those functions are called.
			_r, _g, _b - The RGB values for the feedback text. Optional. Defaults to 1.0, 1.0, 1.0.
			
		Barring those keys, every key in the table will be treated as a subcommand, such that if the
		subcommand was "foo", the full slash command "/slash foo bar" (if "/slash" was a registered
		prefix) would look for configuration data within infoTable["foo"]. Each of these subcommands
		must be a table with the following format:
			isNotToggle - If true, the algorithm will not treat this subcommand as an option.
				Such subcommands have no state, and thus their configuration is different.
				
			Keys for option-based subcommands:
				get - A getFunc, as described above.
				noArgForGet - If true, the argument(s) will not be passed to the getFunc. Useful for on/off
					options.
				getFuncErrorText - errorText, as described above, to use if an error is caught while calling
					the getFunc.
				set - A setFunc, as described above.
				noArgForSet - If true, the argument(s) will not be passed to the setFunc. Useful for on/off
					options.
				setFuncErrorText - errorText, as described above, to use if an error is caught while calling
					the setFunc.
				noStatusInversion - If true, the invertedStatus argument will be omitted from calls to the
					setFunc.
				plainStatus - If true, the result returned from the getFunc or setFunc will not be modified
					in any way before being substituted into the statusText. If not true, the algorithm will
					attempt to look up a string to represent the result by indexing the subcommand with
					the result. For instance, if the result is the number 12, the algorithm will use the value
					found in subcommandData[12]. If no value is present there, the result itself will be used.
				resultFormat - A format string, such as "%02.2f", to apply to the result before substituting
					it into the statusText.
				extraGetStartArg - If non-nil, this value will be added to the start of the arguments list for
					the getFunc, just past the handler (if that is being sent).
				extraGetStartArgs - If non-nil, this array of values will be added in order to the start of the
					arguments list for the getFunc, just past the handler (if that is being sent).
				extraGetEndArg - If non-nil, this value will be added to the end of the arguments list for
					the getFunc.
				extraGetEndArgs - If non-nil, this array of values will be added in order to the end of the
					arguments list for the getFunc.
				extraSetStartArg - If non-nil, this value will be added to the start of the arguments list for
					the setFunc, just past the handler (if that is being sent).
				extraSetStartArgs - If non-nil, this array of values will be added in order to the start of the
					arguments list for the setFunc, just past the handler (if that is being sent).
				extraSetEndArg - If non-nil, this value will be added to the end of the arguments list for
					the setFunc.
				extraSetEndArgs - If non-nil, this array of values will be added in order to the end of the
					arguments list for the setFunc.
				
			Keys for non-option-based subcommands:
				func - An actionFunc, as described above.
				noArg - If true, the argument(s) will not be sent to the actionFunc.
				
			Keys for either type of subcommand:
				handlerObj - If non-nil, this value will be used instead of the command's handlerObj.
				sendHandler - If non-nil, this value will be used instead of the command's sendHandler setting.
				argSplitter - A string or function used to split the argument into multiple arguments, each of
					which will be passed to the applicable function. If this is a string, it should be a pattern as
					would be used in string.match. If it is a function, then the only parameter given to it will
					be the argument, and it should return all split arguments in the order they appeared in
					the main argument string.
				statusText - statusText, as described above, to use to report the results when a
					getFunc, setFunc, or actionFunc is successful.
				noStatusFeedback - If true, no statusText will be printed. However, if an error is caught, it
					will still be printed.
				errorText - errorText, as described above, to use if an error is caught while calling
					the setFunc, getFunc, or actionFunc. If a getFuncErrorText or setFuncErrorText already
					exists in an option-based subcommand, however, that will be used instead of this.
				hasExtraFeedback - If true, and the setFunc, getFunc, or actionFunc called returns a string
					or an array of strings (as the second return for setFunc/getFunc, or the first return
					for actionFunc), then that extra feedback will be printed after the statusText.
				usageText - Help/usage text to display next to the subcommand when listing all subcommands
					for a client. Optional.
				onceOnly - If true, this subcommand will be error, stating that it can only be used once, if it
					is activated again after being used once.
				extraStartArg - If non-nil, this value will be added to the start of the arguments list, just past
					the handler (if that is being sent). This will appear before the extraGetStartArg or the
					extraSetStartArg, respectively, if those are defined too.
				extraStartArgs - If non-nil, this array of values will be added in order to the start of the
					arguments list, just past the handler (if that is being sent). These will appear before the
					extraGetStartArgs or the extraSetStartArgs, respectively, if those are defined too.
				extraEndArg - If non-nil, this value will be added to the end of the arguments list. This will
					appear before the extraGetEndArg or the extraSetEndArg, respectively, if those are defined too.
				extraEndArgs - If non-nil, this array of values will be added in order to the end of the
					arguments list. These will appear before the extraGetEndArgs or the extraSetEndArgs,
					respectively, if those are defined too.


Clients API:
	RegisterClient(name, infoTable)
		Args:
			name - The name of the client registering. Must be a string.
			infoTable - As described above.
		Description:
			Registers a client with the system.
		
	infoTable = GetClient(name)
		Args:
			name - The name of the client to register.
		Returns:
			infoTable - As described above.
		
	UnregisterClient(name)
		Args:
			name - The name of the client unregistering.
		Description:
			Unregisters a client with the system.


Prefixes API:
	RegisterPrefix(name, prefix)
		Args:
			name - The name of the client registering. This must be the same as the name provided
				to RegisterClient().
			prefix - The actual prefix, including the starting slash ("/").
		Description:
			Registers a slash command prefix (for example "/slash") with the system.
		
	isRegistered = IsPrefixRegistered(prefix)
		Args:
			prefix - A prefix to check, including the starting slash ("/").
		Returns:
			isRegistered - True if the prefix is registered, false otherwise.
		Description:
			If this returns true, the prefix may not be registered again without having been
			unregistered first.
		
	UnregisterPrefix(name, prefix)
		Args:
			name - The name of the client unregistering. This must be the same as the name provided
				to RegisterClient().
			prefix - The prefix to unregister, including the starting slash ("/").
		Description:
			Unregisters a slash command prefix (for example "/slash") from the system.



-- == -- == -- License and Contact Information -- == -- == --

This addon may be used or modified in any way which exhibits full compliance with the
World of Warcraft Terms of Service (TOS) and End User License Agreement (EULA), as well
as the rules of the website from which the files were downloaded. You may redistribute this
addon, but only if it is completely unchanged from the way it was found in the zip file. If you
wish to distribute a modified version, you must first obtain permission directly from me.

If you found a bug in this addon, want to provide feedback, want to help translate it, or even
just want to ask a question, please contact me using one of these methods:

Email address: saeris.sanoora@gmail.com
ICQ number: 119161819
AIM screenname: SaerisSanoora
Penny Arcade forums name: Saeris

If you use any other method, it might take me significantly longer to see your message and reply.

If you wish to support my efforts, you can donate via PayPal by following this link:
http://tinyurl.com/yo4asg



-- == -- == -- Addon Type System -- == -- == --

This addon uses a system in which there are three distinct types:
	Interface - These addons actually provide functionality to the user. They may be entirely self-
		contained, or they may make use of Library-type and Plugin-type. They are always top-level,
		meaning that they appear in the addons configuration menu at the character selection screen.
	
	Library - These addons exist simply to provide functionality to other addons of any type, and
		as their type name suggests, they may be shared between multiple other addons as a single,
		efficient source of the aforementioned functionality. A Library type addon may be embedded
		(included in a subdirectory folder with the client addon, usually "\libraries\" or something similar)
		or non-embedded (existing as a top-level addon, such that it appears in the addons configuration
		menu at the character selection screen). Both types have their advantages, but if you wish to
		reduce login time and monitor memory and CPU usage properly, you must use non-embedded
		Libraries. To do this, simply ensure that only a single copy of the Library is present in the entirety
		of the "Interface\AddOns" directory structure, and that this single copy is at the top level, as
		explained before. For convenience, all Library-type addons are prefixed with "Lib-" to identify
		them from the other types of addons.
	
	Plugin - These addons are generally optional, and "plug in" to Interface-type addons to provide
		additional functionality. They are always top-level, meaning that they appear in the addons
		configuration menu at the character selection screen. Most Interface-type addons which use
		plugins will not actually provide any significant functionality on their own. Generally, Plugins
		will include the name of their parent Interface addon in their own name to help identify them.

An addon's type and any libraries it uses are listed at the top of its readme file.



-- == -- == -- Versioning System -- == -- == --

This addon adheres to a #.#.# versioning format:

The first number (the 1 in 1.2.3) denotes the current major version. This number is
incremented when the addon's functionality or style of code changes so significantly
as to barely resemble previous versions. For Library-type addons, which provide
functionality to client addons, this number is also a guarantee that every release
within this major version will be backwards compatible with previous releases that
are also within this major version. In these cases, this number is actually a suffix on the
library's name. This is done so newer major versions of libraries will not overwrite
older ones, since those may still be in use by other clients.

The second number (the 2 in 1.2.3) denotes the current minor version. This number
is incremented when functionality is added, modified, or removed.

The third number (the 3 in 1.2.3) denotes the current subminor version. This number is
incremented when a release's purpose is to fix bugs or errors, or to increase efficiency
in some way, or to make a minor cosmetic adjustment.
