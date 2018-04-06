local K, C, L, _ = select(2, ...):unpack()
if IsAddOnLoaded("!BlizzBugsSuck") then return end

local _G = _G
local type, pairs = type, pairs
local hooksecurefunc = hooksecurefunc
local GetFrameLevel = GetFrameLevel
local InCombatLockdown = InCombatLockdown
local GetMinMaxValues = GetMinMaxValues

-- UIDropDownMenu FrameLevels do not properly follow their parent and need to be
-- fixed to prevent the button being under the background.
do
	local function FixMenuFrameLevels()
		for l = 1,UIDROPDOWNMENU_MAXLEVELS do
			for b = 1,UIDROPDOWNMENU_MAXBUTTONS do
				local button = _G["DropDownList"..l.."Button"..b]
				if button then
					local button_parent = button:GetParent()
					if button_parent then
						local button_level = button:GetFrameLevel()
						local parent_level = button_parent:GetFrameLevel()
						if button_level <= parent_level then
							button:SetFrameLevel(parent_level + 2)
						end
					end
				end
			end
		end
	end
	hooksecurefunc("UIDropDownMenu_CreateFrames", FixMenuFrameLevels)
end

-- Fix incorrect translations in the German Locale. For whatever reason
-- Blizzard changed the oneletter time abbreviations to be 3 letter in
-- the German Locale.
if K.Client == "deDE" then
	MINUTE_ONELETTER_ABBR = "%d m"
	DAY_ONELETTER_ABBR = "%d d"
end

-- fixes the issue with InterfaceOptionsFrame_OpenToCategory not actually opening the Category (and not even scrolling to it)
do
	local doNotRun = false
	local function get_panel_name(panel)
		local cat = INTERFACEOPTIONS_ADDONCATEGORIES
		if ( type(panel) == "string" ) then
			for i, p in pairs(cat) do
				if p.name == panel then
					if p.parent then
						return get_panel_name(p.parent)
					else
						return panel
					end
				end
			end
		elseif ( type(panel) == "table" ) then
			for i, p in pairs(cat) do
				if p == panel then
					if p.parent then
						return get_panel_name(p.parent)
					else
						return panel.name
					end
				end
			end
		end
	end

	local function InterfaceOptionsFrame_OpenToCategory_Fix(panel)
		if InCombatLockdown() then return end
		if doNotRun then
			doNotRun = false
			return
		end
		local panelName = get_panel_name(panel)
		if not panelName then return end -- if its not part of our list return early
		local noncollapsedHeaders = {}
		local shownpanels = 0
		local mypanel
		local t = {}
		for i, panel in ipairs(INTERFACEOPTIONS_ADDONCATEGORIES) do
			if not panel.parent or noncollapsedHeaders[panel.parent] then
				if panel.name == panelName then
					panel.collapsed = true
					t.element = panel
					InterfaceOptionsListButton_ToggleSubCategories(t)
					noncollapsedHeaders[panel.name] = true
					mypanel = shownpanels + 1
				end
				if not panel.collapsed then
					noncollapsedHeaders[panel.name] = true
				end
				shownpanels = shownpanels + 1
			end
		end
		local Smin, Smax = InterfaceOptionsFrameAddOnsListScrollBar:GetMinMaxValues()
		InterfaceOptionsFrameAddOnsListScrollBar:SetValue((Smax/(shownpanels-15))*(mypanel-2))
		doNotRun = true
		InterfaceOptionsFrame_OpenToCategory(panel)
	end
	hooksecurefunc("InterfaceOptionsFrame_OpenToCategory", InterfaceOptionsFrame_OpenToCategory_Fix)
end

-- Fix for minimap ping points not updating as your character moves.
-- Original code taken from AntiRadarJam by Lombra with permission.
do
	MinimapPing:HookScript("OnUpdate", function(self, elapsed)
		if self.fadeOut or self.timer > MINIMAPPING_FADE_TIMER then
			Minimap_SetPing(Minimap:GetPingPosition())
		end
	end)
end