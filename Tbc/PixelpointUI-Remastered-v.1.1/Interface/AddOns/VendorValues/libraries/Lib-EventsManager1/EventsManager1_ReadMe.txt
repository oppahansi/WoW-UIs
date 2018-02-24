
/\_*_/\_*_/\_*_/\ -- EventsManager1 ReadMe -- /\_*_/\_*_/\_*_/\

Addon type: Library
Libraries used:
	none



-- == -- == -- Description of Functionality -- == -- == --

This embeddable addon is a library that allows for event management. It is intended for use
by developers to do two things: increase efficiency by sharing a single event dispatch frame,
and allow elegant inter-addon communication via an event-based architecture.



-- == -- == -- History of Changes -- == -- == --

1.2.1 (Mar 5, 2008):
	- Miscellaneous code style updates.


1.2.0 (Feb 3, 2008):
	- Added the ability to send extra arguments with a registered event handler. These arguments
		take priority over the event's arguments and the sendEvent option, but not over the sendHandler
		option.
	
	- Removed the big list of events in DefaultEvents.lua. Instead, the validity of events is now determined
		dynamically by checking to see whether a frame accepts it as a valid argument to :RegisterEvent().
	
	- Removed EventsManager1_EVENT_REGISTERED and EventsManager1_EVENT_UNREGISTERED custom
		events.
	
	- Removed return value from EventsManager1.DispatchEvent().


1.1.0 (Dec 23, 2007):
	- Various efficiency improvements.


1.0.0 (Nov 13, 2007):
	- Initial release.



-- == -- == -- Developer Notes -- == -- == --

For the purposes of all API functions, the following terms can be defined as such:
	handlerObj - A function, or a table with a function, responsible for handling all events
		for which it is registered. If it is a table, handlerObj[handlerKey] (or handlerObj["OnEvent"]
		if the other doesn't exist) will be indexed for a function to call with the arguments to the
		event. If it is a function, it will be called directly.
	keyName - A string used to index handlerObj (if it is a table) to find the function responsible
		for handling an event. If handlerKey isn't specified during event registration, and handlerObj
		is not a function, then it will be ("OnEvent_" .. eventName).

API functions:
	EventsManager1.DispatchEvent (event, ...)
		Usage:
			Triggers an event for dispatch to all registered handlers. The handlers will be called
			with all additional arguments given to this function. If specified during registration in
			RegisterForEvent, a given handler may receive itself and/or the event name and/or
			a list of custom arguments at the start of the overall arguments list.
		Args:
			1 - string: the name of the event to dispatch.
			... - anything: all arguments related to the event, in order.
		Returns:
			none
	
	EventsManager1.RegisterForEvent (handlerObj [, keyName], event [, sendHandler] [, sendEvent] [, ...])
		Usage:
			Create and register an event handler.
		Args:
			1 - handlerObj as defined above.
			[2] - keyName as defined above.
			3 - string: event name which should be registered to handlerObj.
			[4] - boolean: true if the handlerObj should be passed to the function during dispatch. It
				will be the first argument if so.
			[5] - boolean: true if the event should be passed to the function during dispatch. If the
				handlerObj is also being passed, this will be after that; otherwise this will be the first
				argument.
			[...] - Any additional arguments to provide to the function. If these exist, they will be at the
				start of the arguments list, but AFTER the handlerObj if that is being sent as well.
		Returns:
			none
	
	EventsManager1.UnregisterForEvent (handlerObj, event)
		Usage:
			Unregister an event handler which was registered by EventsManager1.RegisterForEvent().
		Args:
			1 - handlerObj as defined above.
			2 - string: event name which should be unregistered from handlerObj.
		Returns:
			none
	
	EventsManager1.UnregisterForAllEvents (handlerObj)
		Args:
			1 - handlerObj as defined above.
		Returns:
			none
	
	EventsManager1.GetHandlerData (handlerObj, event)
		Args:
			1 - handlerObj as defined above.
			2 - string: event name for which to check handlerObj for registration status.
		Returns:
			1 - keyName as defined above or nil: blank string if handlerObj is a function, nil if
				not registered.
			2 - boolean or nil: true if the handlerObj is set to receive itself as an argument during
				dispatch, false if not, nil if not registered.
			3 - boolean or nil: true if the handlerObj is set to receive the event name as an argument
				during dispatch, false if not, nil if not registered.
			... - Any additional arguments associated with this handler.
	
	EventsManager1.AddCustomEvent (event)
		Usage:
			Add a custom event to the system (which can be triggered by your addon calling
			EventsManager1.DispatchEvent(event, ...)) for other addons to register and receive.
			Custom events are recommended to the follow the format of "<addon name>_<event>".
			This function triggers the EventsManager1_CUSTOM_EVENT_ADDED event.
		Args:
			1 - string: the custom event's name.
		Returns:
			none
	
	EventsManager1.RemoveCustomEvent (event)
		Usage:
			Removes a custom event from the system which was added by EventsManager1.AddCustomEvent().
			This function triggers the EventsManager1_CUSTOM_EVENT_REMOVED event.
		Args:
			1 - string: the custom event's name.
		Returns:
			none
	
	EventsManager1.IsCustomEventAvailable (event)
		Args:
			1 - string: the custom event's name.
		Returns:
			1 - boolean: true if the custom event has been added and is available, false otherwise.
			2 - boolean or nil: true if the custom event is a once-only event, false if not, nil if it doesn't
				exist.


EventsManager1 custom events:
	EventsManager1_CUSTOM_EVENT_ADDED
		Description:
			Triggers when a custom event becomes available for registration.
		Args:
			1 - string: the event's name.
			2 - boolean: true if this custom event is a once-only event, false otherwise.
	
	EventsManager1_CUSTOM_EVENT_REMOVED
		Description:
			Triggers when a custom event becomes unavailable for registration.
		Args:
			1 - string: the event's name.
			2 - boolean: true if this custom event was a once-only event, false otherwise.



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
