--------------------------------------------------------------------------
-- localization.lua 
--------------------------------------------------------------------------

BINDING_HEADER_FLUIDFRAMES				= "FluidFrames";
BINDING_NAME_HIGHLIGHTMOUSEFRAME			= "Highlight Mouse Frame";
BINDING_NAME_HIGHLIGHTALLMOUSEFRAMES		= "Highlight All Mouse Frames";

if (not SHOW) then
	SHOW = "Show";
end

local frame = LIGHTYELLOW_FONT_COLOR_CODE.."%s"..FONT_COLOR_CODE_CLOSE

FLUIDFRAMES_CANT_FIND_STORED = "Can't Find "..frame.." to set its stored location."
FLUIDFRAMES_CANT_MOVE_IN_COMBAT = "Can't Move "..frame.." in combat."
FLUIDFRAMES_DELAYING_EXCEPTION_FRAME = "Delaying init of exception frame "..frame.."."
FLUIDFRAMES_CANT_RESIZE_IN_COMBAT = frame.." cannot be resized or moved in combat."
FLUIDFRAMES_CANT_RESCALE_IN_COMBAT = frame.." cannot be rescaled or moved in combat."
FLUIDFRAMES_CANT_MOVE_IN_COMBAT = frame.." cannot be moved in combat."
FLUIDFRAMES_START_RESIZE = "Starting to resize "..frame.."."
FLUIDFRAMES_STOP_RESIZE = "Stopped resizing "..frame.."."
FLUIDFRAMES_NO_MOVABLE_FRAMES = "No movable frames found under the cursor."
FLUIDFRAMES_HIGHLIGHT = "Highlighting: "..frame.." Parent: "..frame
FLUIDFRAMES_CANT_IMMOBILIZE_NOT_UIPARENT = "Can't Immobilize "..frame..". Not anchored to UIParent."
FLUIDFRAMES_CANT_IMMOBILIZE_NO_DEFAULT = "Can't Immobilize "..frame..". Default location not saved."
FLUIDFRAMES_CANT_IMMOBILIZE_UNNAMED = "Can't Immobilize Unamed Frame."
FLUIDFRAMES_UNNAMED_ANCHOR = frame.." may not reset properly after logging out, because it is anchored to an unnamed frame. If you want to reset it later you will probably have to \"/console reloadui\"."
FLUIDFRAMES_CANT_RESET_UNNAMED = "Can't Reset Unamed Frame."
FLUIDFRAMES_CANT_RESET_NO_DEFAULT = "Can't Reset "..frame..". Default location not saved. \"/console reloadui\" might reset it."
FLUIDFRAMES_CANT_RESET_NOT_FOUND = "Can't Reset "..frame..". The frame cannot be found."
FLUIDFRAMES_RESET = "Frame Reset: "..frame
FLUIDFRAMES_NIL = "(nil)"
FLUIDFRAMES_REPARENTING = "Reparenting "..frame.." from "..frame.." to "..frame.."."
FLUIDFRAMES_REPARENTING_SIBLING = "Reparenting sibling "..frame.." from "..frame.." to "..frame.."."
FLUIDFRAMES_CANT_HIDE = "Can't hide "..frame..", data not stored."

--Khaos Texts
FLUIDFRAMES_HEADER = "FluidFrames"
FLUIDFRAMES_HEADER_WITH_VERSION = "FluidFrames v%.2f"
FLUIDFRAMES_DESC = "Move, Resize, Rescale!"
FLUIDFRAMES_DESC_FULL = "Move, resize, and scale frames with independent x&y axes."
FLUIDFRAMES_HELP_HEADER = "Usage Instructions"
FLUIDFRAMES_HELP1 = "• Assign key bindings to select and highlight frames:"
FLUIDFRAMES_HELP2 = "  · Binding #1: cycle through highlighting frames under the cursor "
FLUIDFRAMES_HELP3 = "  · Binding #2: cycle through highlighting all frames under the cursor, including unnamed frames"
FLUIDFRAMES_HELP4 = "  · Hold shift to cycle backwards when using a binding."
FLUIDFRAMES_HELP5 = "  · Note: To drag some bars you have to drag the 1st button."
FLUIDFRAMES_HELP6 = "• Right-click to reset a moved/resized/rescaled frame once highlighted."
FLUIDFRAMES_HELP7 = "• Hold shift and drag from the sides or corners to resize."
FLUIDFRAMES_HELP8 = "• Hold shift and drag the bottom right re-scale icon to re-scale."
FLUIDFRAMES_RESHOW_HELP = "Disable permenent hiding of %s"
FLUIDFRAMES_RESHOW_FEEDBACK = "%s has been re-shown."
FLUIDFRAMES_RESHOW = "Re-Show"
FLUIDFRAMES_RESHOW_ALL = "Re-Show All"
FLUIDFRAMES_RESHOW_ALL_FINISHED = "All frames have been re-shown."
FLUIDFRAMES_RESET_HEADER = "Reset Modified Frames";
FLUIDFRAMES_RESET_ALL = "Reset All"
FLUIDFRAMES_RESET_ALL_FRAMES = "Reset all frames."
FLUIDFRAMES_RESET_ALL_FINISHED = "All frames have been reset."
FLUIDFRAMES_RESET_HELP = "Re-show and reset the location of %s"
FLUIDFRAMES_RESET_FEEDBACK = "%s has been reset."
FLUIDFRAMES_TEMP_DRAGGABLE = "Enable temporary dragging of UI Panels"
FLUIDFRAMES_TEMP_DRAGGABLE_MINIMAP = "Enable temporary dragging of Minimap"

FLUIDFRAMES_NEWLINE = "\n"

--Slash commands
SLASH_FLUIDFRAMESSLASH1 = "/resetframes"