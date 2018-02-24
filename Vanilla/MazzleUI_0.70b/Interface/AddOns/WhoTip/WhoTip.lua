--------------------------------------------------------------------------
-- WhoTip.lua 
--------------------------------------------------------------------------
--[[
WhoTip

author: AnduinLothar KarlKFI@cosmosui.org

-Shift-clicking on a user name in chat shows a tooltip with their information.

WHO_NUM_RESULTS = "%d player total";	--Found in english globalstrings.lua
WHO_NUM_RESULTS_P1 = "%d players total";	--Found in english globalstrings.lua

Change Log:
v1.1
-Back to life
v1.0
-Initial Release
-If you want to make the tooltip attach to your mouse and don't have Khaos (gui options) use "/script WhoTip_Mouse = true" or make it nil to make it show the same place as normal tooltips (default).

]]--
local WHO_NUM_RESULTS_SUFFIX = strsub(format(WHO_NUM_RESULTS, 1), 3)
local WHO_NUM_RESULTS_P1_SUFFIX = strsub(format(WHO_NUM_RESULTS, 2), 3)
WhoTip_NameWaiting = nil;
WhoTip_Mouse = nil;

function WhoTip_SetItemRef (link, text, button)
	if (strsub(link, 1, 6) == "player") then
		local name = strsub(link, 8);
		if ( name and (strlen(name) > 0) ) then
			if ( IsShiftKeyDown() ) then
				WhoTip_NameWaiting = name;
			end
		end
	end
end

function WhoTip_ShowTip()
	local numWhos, totalCount = GetNumWhoResults();
	local name, guild, level, race, class, zone, group;
	if (numWhos > 0) then
		for i=1, numWhos do
			name, guild, level, race, class, zone, group = GetWhoInfo(i);
			if (name == WhoTip_NameWaiting) then
				break;
			end
		end
	else
		return;
	end
	if (WhoTip_Mouse) then
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR");
	else
		GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	end
	
	GameTooltip:AddLine(name, GameTooltip_UnitColor("player"));
	GameTooltip:AddLine(format(ITEM_LEVEL, level).." "..race.." "..class, 1, 1, 1);
	if (guild ~= "") then
		GameTooltip:AddLine("<"..guild..">", 1, .8, 0);
	end
	GameTooltip:AddLine(zone, 1, 1, 1);
	GameTooltip:Show();
	--GameTooltip:FadeOut();
end

function WhoTip_OnLoad()
	Sea.util.hook("SetItemRef", "WhoTip_SetItemRef", "after");
	if (Khaos) then
		WhoTip_Register_Khaos();
	end
	this:RegisterEvent("CHAT_MSG_SYSTEM");
end

-- From Sea
local function endsWith( text, suffix )
	if ( strfind(text, suffix.."$") ) then
		return true;
	end
end


function WhoTip_OnEvent(event)
	if (event == "CHAT_MSG_SYSTEM") then
		if (WhoTip_NameWaiting) then
			if (arg1 == format(WHO_NUM_RESULTS_P1, 0)) then
				WhoTip_NameWaiting = nil;
			elseif (endsWith(arg1, WHO_NUM_RESULTS_SUFFIX)) or (endsWith(arg1, WHO_NUM_RESULTS_P1_SUFFIX)) then
				WhoTip_ShowTip()
				WhoTip_NameWaiting = nil;
			end
		end
	end
end

function WhoTip_Register_Khaos()
	local optionSet = {
		id="WhoTip";
		text=WHOTIP_CONFIG_HEADER;
		helptext=WHOTIP_CONFIG_HEADER_INFO;
		feedback=function(state) return WHOTIP_ENABLED_INFO; end;
		difficulty=1;
		default=true;
		callback=function(checked)
			if (checked) then
				Sea.util.hook("SetItemRef", "WhoTip_SetItemRef", "after");
			else
				Sea.util.unhook("SetItemRef", "WhoTip_SetItemRef", "after");
			end
		end;
		options={
			{
				id="Header";
				text=WHOTIP_CONFIG_HEADER;
				helptext=WHOTIP_CONFIG_HEADER_INFO;
				type=K_HEADER;
				difficulty=1;
			};
			{
				id="WhoTipMouse";
				type=K_TEXT;
				text=WHOTIP_MOUSE;
				helptext=WHOTIP_MOUSE_ON;
				callback=function(state)
					if (state.checked) then
						WhoTip_Mouse = true;
					else
						WhoTip_Mouse = nil;
					end
				end;
				feedback=function(state)
					if (state.checked) then
						return WHOTIP_MOUSE_ON;
					else
						return WHOTIP_MOUSE_OFF;
					end
				end;
				check=true;
				default={checked=false};
				disabled={checked=false};
			};
		};
	};
	Khaos.registerOptionSet(
		"chat",
		optionSet
	);
end
