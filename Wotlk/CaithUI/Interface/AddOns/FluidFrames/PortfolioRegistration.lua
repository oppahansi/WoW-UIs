-- <= == == == == == == == == == == == == =>
-- => Option Registration
-- <= == == == == == == == == == == == == =>

local Portfolio = LibStub and LibStub("Portfolio")
if not Portfolio then return end

local optionTable = {
	id="FluidFrames";
	subText=FLUIDFRAMES_DESC_FULL;
	options={
		-- Pulls the first header and helptext from the addon toc data
		{
			id = "TempDraggable";
			text = FLUIDFRAMES_TEMP_DRAGGABLE;
			type = CONTROLTYPE_CHECKBOX;
			callback = function(value) 
				FluidFrames.ToggleTempDraggableFrames(value == "1")
			end;
			defaultValue = "1",
		};
		{
			id = "TempDraggableMinimap";
			text = FLUIDFRAMES_TEMP_DRAGGABLE_MINIMAP;
			type = CONTROLTYPE_CHECKBOX;
			callback = function(value) 
				FluidFrames.ToggleTempDraggableMinimap(value == "1")
			end;
			defaultValue = "0",
		};
		{
			id = "Reset";
			text = FLUIDFRAMES_RESET_ALL;
			type = CONTROLTYPE_BUTTON;
			callback = FluidFrames.ResetAll;
			point = {nil, nil, nil, 0, -30};
		};
		{
			id = "Reshow";
			text = FLUIDFRAMES_RESHOW_ALL;
			type = CONTROLTYPE_BUTTON;
			callback = FluidFrames.ReshowAll;
			point = {"TOPLEFT", "Reset", "TOPRIGHT", 40, 0};
		};
		{
			id = "Help";
			text = FLUIDFRAMES_HELP_HEADER;
			subText = FLUIDFRAMES_HELP1..FLUIDFRAMES_NEWLINE..FLUIDFRAMES_NEWLINE
				..FLUIDFRAMES_HELP2..FLUIDFRAMES_NEWLINE
				..FLUIDFRAMES_HELP3..FLUIDFRAMES_NEWLINE
				..FLUIDFRAMES_HELP4..FLUIDFRAMES_NEWLINE
				..FLUIDFRAMES_HELP5..FLUIDFRAMES_NEWLINE..FLUIDFRAMES_NEWLINE
				..FLUIDFRAMES_HELP6..FLUIDFRAMES_NEWLINE..FLUIDFRAMES_NEWLINE
				..FLUIDFRAMES_HELP7..FLUIDFRAMES_NEWLINE..FLUIDFRAMES_NEWLINE
				..FLUIDFRAMES_HELP8;
			type = CONTROLTYPE_HEADER;
			point = {nil, "Reset", nil, nil, -40};
			init = function(header, subtext)
				subtext:SetHeight(140)
			end;
		};
		{
			id = "ResetHeader";
			text = "Modified Frames";
			type = CONTROLTYPE_HEADER;
		};
		{
			id = "ResetIndividual";
			type = CONTROLTYPE_WINDOW;
			height = 160;
			options = {
			};
		};
		{
			id = "ReshowHeader";
			text = "Hidden Frames";
			type = CONTROLTYPE_HEADER;
		};
		{
			id = "ReshowIndividual";
			type = CONTROLTYPE_WINDOW;
			height = 160;
			options = {
			};
		};
	};
	savedVarTable = "FluidFrames_SavedVars";
}

FluidFrames.OptionsFrame = Portfolio.RegisterOptionSet(optionTable)

function FluidFrames.UpdateGUI()
	if (FluidFrames.OptionsFrame) then
		if (not FluidFrames.DoNotUpdateGUI) then
			--TODO: add update options to show hidden and moved frames
			--[[
			local optionsFrame = FluidFrames.OptionsFrame
			local resetWindow = optionsFrame:GetControl("ResetIndividual")
			local frame = _G[frameName]
			local option = {
				id = "Reset-"..frameName;
				text = "Reset";
				type = CONTROLTYPE_BUTTON;
				callback = function() FluidFrames.ResetFrame(frame) end;
				point = {nil, nil, nil, 0, -30};
			}
			local control = resetWindow:RegisterControl(option)
			
			option = {
				id = "Reset-"..frameName;
				text = "Reset";
				type = CONTROLTYPE_BUTTON;
				callback = function() FluidFrames.ResetFrame(frame) end;
				point = {nil, nil, nil, 0, -30};
			}
			local control = resetWindow:RegisterControl(option)
			]]--
		end
	end
end
