
/\_*_/\_*_/\_*_/\ -- ConfigManager1 ReadMe -- /\_*_/\_*_/\_*_/\

Addon type: Library
Libraries used:
	EventsManager1



-- == -- == -- Description of Functionality -- == -- == --

This addon is a library designed to manage and streamline the numerous get/set operations
performed on the configuration tables many other addons use to store saved settings.



-- == -- == -- History of Changes -- == -- == --

1.2.0 (Apr 19, 2008):
	- Now runs onChange handlers on load (if specified) AFTER the onLoad handler when
		initializing a config table.
	
	- Now requires "nil" to be specified in the valid[Input/Accessor]Types string for nil values
		to be allowed.


1.1.0 (Apr 11, 2008):
	- Added "runOnChangeOnLoad" handler option and config option.


1.0.0 (Mar 8, 2008):
	- Initial release.



-- == -- == -- Developer Notes -- == -- == --

Important: When using nested tables, the client is responsible for maintaining the overall table
structure. ConfigManager will neither create nor destroy nested tables, and will error if a
non-present nested table is trying to be accessed.


For the purposes of the API, these terms can be defined as such:
	handler - A set of rules for determining how to handle get/set operations
		for a given property (key/value pair) in a configuration table.
	
	validator - A table containing information that is used as an extra validity
		check for either the input or the table accessor during a given value-setting
		operation. All validators have two keys in common, which determine the
		type of validator ("validatorType") and the text to display if the validator
		fails ("invalidText"). The various accepted values for the former, and
		their respective formats, are as follows:
			"index-table": This validator takes a table and uses the input or the
				accessor as an index into that table; the result is compared to a given
				value to determine validity. If it matches, the validator passes.
				Keys for this type of validator:
					tableToIndex = table: The table to index for a value to match
						against the pre-determined value.
					expectedValue = any type: The value to match against the
						result of the indexing operation.
			"number-comparison": This validator takes low and high numbers, or optionally
				just one or the other, and compares them to the input or accessor. If they are
				within range, the validator passes.
					low = number or nil: The low end of the comparison. Optional.
					lowInclusive = true or nil: If true, >= will be used instead of >.
					high = number or nil: The high end of the comparison. Optional.
					highInclusive = true or nil: If true, <= will be used instead of <.
			"string-comparison": This validator takes a string and uses it as the second
				argument to string.match, with the first argument being the input or
				accessor. If the result is non-nil, the validator passes.
					stringMatcher = string: The string to match against the input or
						accessor.
			"custom": This validator calls a custom function and uses the first return
				to determine whether it passes. If true, the validator passes.
					func = function: The custom function to call. The only argument given
						to the function is the input or accessor being validated.
		All validators are placed into one of two categories in each handler. For example:
			extraInputValidators = {
				matchOne = {
					validator1,
					validator2
				};
				matchAll = {
					validator1,
					validator2
				};
			};
		Validators in the matchOne category will be matched until one validator PASSES. If any
		pass, the input/accessor is considered valid. Validators in the matchAll category will be
		matched until one validator FAILS. If any fail, the input/accessor is considered invalid.
		Both categories are always checked (if present), but the matchOne category is checked first.


API:
	client = RegisterClient(configTableName, handlers, defaults[, configMetatable][, onLoadFunc][, runOnChangeOnLoad])
		Args:
			configTableName - The name of your configuration table in the global scope.
			handlers - A table consisting of key/value pairs where each key corresponds to
				an identical key in your configuration table, and each value is a handler as
				defined above. Each handler looks like this:
					handler = {
						validInputTypes = string or nil: A comma-separated string list of all valid input types
							for this property; if absent, all types are valid.
						inputModifiers = table or nil: An optional array containing functions or strings,
							each of which will modify the input. Functions will be called with the input as
							their only argument. Strings will be used as the first argument in string.format.
							This can be just a single function or string, instead of an array, if applicable.
						extraInputValidators = table or nil: A series of extra, more specific tests than
							simple type comparisons to determine the validity of input; the format of
							these structures is described above.
						storeFalseAsNil = true or nil: True if this property should be translated to and from
							nil when it is really false, to save memory.
						validAccessorTypes = string or nil: A comma-separated string list of all the valid
							accessor / index types for this property if it is a table; if absent, all types are
							valid.
						accessorModifiers = table or nil: An optional array containing functions or strings,
							each of which will modify the accessor. Functions will be called with the accessor
							as their only argument. Strings will be used as the first argument in string.format.
							This can be just a single function or string, instead of an array, if applicable.
						extraAccessorValidators = table or nil: A series of extra, more specific tests than
							simple type comparisons to determine the validity of the accessor; the format of
							these structures is described above.
						realTableIndex = anything: If this is non-nil on a table property, the table will be indexed
							with this value to find the real table to use. If the real table is nil, this is ONE case
							where it will be created.
						onChange = function or nil: This function will be called any time this property's value is
							changed. The new and old values are supplied as the first and second arguments,
							and the third argument is the key in the table.
						runOnChangeOnLoad = true or nil: If this is true, the onChange function will be run
							when the table is loaded. The first argument will be the current value, and the second
							argument will always be nil. This option will NOT work for handlers within the subHandlers
							table.
						subHandlers = table or nil: If there are nested tables within the property this handler
							is for, then each of those tables's key/value pairs may have handlers represented
							here. A key of "<any>" will handle any of the pairs which do not have an explicit handler.
							If this table is absent but there are nested tables, the parent handler will be used.
					};
			defaults - A table consisting of key/value pairs where each key corresponds to
				an identical key in your configuration table, and each value is the default value
				for that key. As a special case, values which default to blank tables should use
				the special token "<blank table>" instead of the actual table object.
			[configMetatable] - The metatable to set to the configTable once it is loaded.
			[onLoadFunc] - The function to call with the configTable as the first argument
				once the configTable is loaded.
			[runOnChangeOnLoad] - If true, all handlers provided will have their onChange
				function called when the config table is loaded. This option will NOT work for
				handlers within the subHandlers tables of each handler.
		Returns:
			client - The client, as it is used internally by ConfigManager. Its key/value pairs are identical
				to the arguments supplied to RegisterClient(), with the exception that it additionally stores
				a pointer to the configuration table (as the key configTable). It also has :SetValue() and
				:GetValue() methods.
	
	client = GetClient(configTableName)
		Args:
			configTableName - The name of your configuration table in the global scope.
		Returns:
			client - The client, as it is used internally by ConfigManager. Its key/value pairs are identical
				to the arguments supplied to RegisterClient(), with the exception that it additionally stores
				a pointer to the configuration table (as the key configTable). It also has :SetValue() and
				:GetValue() methods.
	
	handler = CreateGenericHandler(validInputTypes, storeFalseAsNil)
		Args:
			validInputTypes - string: A comma-separated string list of all valid input types
				for this property.
			storeFalseAsNil - true or nil: True if this property should be translated to and from
				nil when it is really false, to save memory.
		Returns:
			handler - The generic handler.
		Description:
			Use this function to create generic handlers for very basic properties which
			require nothing more than an input-type check and a false-to-nil specification.
			These generic handlers are shared between all clients to save memory.
	
	value = GetValue(configTableName, propertyName[, ...])
		Description:
			Same as GetClient(configTableName):GetValue(propertyName[, ...]).
	
	value = client:GetValue(propertyName[, ...])
		Args:
			configTableName - The name of your configuration table in the global scope.
			propertyName - The name of the property (key) in your table for which you
				wish to obtain the value, using the handler defined for the property at
				registration.
			... - The series of table indexes to use to arrive at the desired value. For
				instance, if you wanted to read the value "test" in the following table,
				these args would be supplied in order: "val1", "val2", "val3".
					configTable = {
						[propertyName] = {
							val1 = {
								val2 = {
									val3 = "test";
								};
							};
						};
					};
				These args are only needed to access values in nested tables. The final
				arg is simply the key in the key/value pair that is being read.
		Returns:
			value - The value retrieved from your configuration table.
	
	value = SetValue(configTableName, propertyName[, ...], newValue)
		Description:
			Same as GetClient(configTableName):SetValue(propertyName[, ...], newValue).
	
	value = client:SetValue(propertyName[, ...], newValue)
		Args:
			configTableName - The name of your configuration table in the global scope.
			propertyName - The name of the property (key) in your table for which you
				wish to set the value, using the handler defined for the property at
				registration.
			... - The series of table indexes to use to arrive at the desired value. For
				instance, if you wanted to change the value "test" in the following table,
				these args would be supplied in order: "val1", "val2", "val3".
					configTable = {
						[propertyName] = {
							val1 = {
								val2 = {
									val3 = "test";
								};
							};
						};
					};
				These args are only needed to set values in nested tables. The final
				arg is simply the key in the key/value pair that is being changed.
			newValue - The value to which the given index in the table should be changed.
		Returns:
			value - The new value from the configuration table, as it was just set.



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
