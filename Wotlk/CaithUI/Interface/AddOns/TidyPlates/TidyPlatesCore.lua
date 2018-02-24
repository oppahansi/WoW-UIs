TidyPlates = {}
local activetheme, activethemename = {}, "None"
local numChildren = -1
local framenumber = 0
local echoUpdate = 0
local echoSelf = {}
local function SetSelfEcho(plate) echoSelf[plate] = true; end
--local function SetSelfEcho(plate, count) pcount = echoSelf[plate]; if pcount then echoSelf[plate] = max(pcount, count) else echoSelf[plate] = count end; end

local function SetEchoUpdate(echos) echoUpdate = max(echoUpdate,echos) end
local EMPTY_TEXTURE = "Interface\\Addons\\TidyPlates\\Media\\Empty"
local useAutohide = false
local select, pairs = select, pairs
local select = select
local InCombat = false
local ActivePlates = {}
-------------------------------------------------------
-- Object Functions
-------------------------------------------------------
local function SetObjectShape(object, width, height) object:SetWidth(width); object:SetHeight(height) end
local function SetObjectFont(object,  font, size, flags) object:SetFont(font, size, flags) end
local function SetObjectJustify(object, horz, vert) object:SetJustifyH(horz); object:SetJustifyV(vert) end
local function SetObjectShadow(object, shadow) if shadow then object:SetShadowColor(0,0,0,1); object:SetShadowOffset(1, -1) else object:SetShadowColor(0,0,0,0) end  end
local function SetObjectAnchor(object, anchor, anchorTo, x, y) object:ClearAllPoints();object:SetPoint(anchor, anchorTo, anchor, x, y) end
local function SetObjectTexture(object, texture) object:SetTexture(texture); object:SetTexCoord(0,1,0,1)  end
local function SetObjectBartexture(object, texture, orientation) object:SetStatusBarTexture(texture); object:SetOrientation(orientation) end
-- SetFontGroupObject
local function SetFontGroupObject(object, objectstyle) 
	SetObjectFont(object, objectstyle.typeface, objectstyle.size, objectstyle.flags) 
	SetObjectJustify(object, objectstyle.align, objectstyle.vertical)
	SetObjectShadow(object, objectstyle.shadow)
end
-- SetAnchorGroupObject
local function SetAnchorGroupObject(object, objectstyle, anchorTo)
	SetObjectShape(object, objectstyle.width, objectstyle.height) --end				
	SetObjectAnchor(object, objectstyle.anchor, anchorTo, objectstyle.x, objectstyle.y) 
end
-- SetBarGroupObject
local function SetBarGroupObject(object, objectstyle, anchorTo)
	SetObjectShape(object, objectstyle.width, objectstyle.height) --end
	SetObjectAnchor(object, objectstyle.anchor, anchorTo, objectstyle.x, objectstyle.y) --end	
	SetObjectBartexture(object, objectstyle.texture, objectstyle.orientation) --end
end
-------------------------------------------------------
-- UpdateStyle
-------------------------------------------------------
local UpdateStyle
do
	-- UpdateStyle Variables
	local index, content, extended, bars, regions, style
	local objectstyle, objectname, objectregion
	-- Style Property Groups
	local fontgroup = {"name", "level", "specialText", "specialText2"}
	local anchorgroup = {"healthborder", "threatborder", "castborder", "castnostop",
						"name",  "specialText", "specialText2", "level",
						"specialArt", "spellicon", "raidicon", "dangerskull"}
	local bargroup = {"castbar", "healthbar"}
	-------------------------------------------------------
	-- Main Function: UpdateStyle 
	-------------------------------------------------------
	function UpdateStyle(plate)
		extended = plate.extended
		bars, regions, style = extended.bars, extended.regions, extended.style
		-- Hitbox
		if not InCombat then objectstyle = style.hitbox; SetObjectShape(plate, objectstyle.width, objectstyle.height) end
		-- Frame
		SetAnchorGroupObject(extended, style.frame, plate)
		-- Anchorgroup
		for i = 1, #anchorgroup do objectname = anchorgroup[i]; SetAnchorGroupObject(regions[objectname], style[objectname], extended) end
		-- Bars
		for i = 1, #bargroup do objectname = bargroup[i]; SetBarGroupObject(bars[objectname], style[objectname], extended) end
		-- Texture
		SetObjectTexture(regions.castborder, style.castborder.texture)
		SetObjectTexture(regions.castnostop, style.castnostop.texture)
		-- Font Group
		for i = 1, #fontgroup do objectname = fontgroup[i];SetFontGroupObject(regions[objectname], style[objectname]) end
		-- Note: Highlight is taken care of during UpdatePlate, since it gets reset OnShow
		-- Show/Hide
		if style.options.showName then regions.name:Show() else regions.name:Hide() end
		if style.options.showSpecialText then regions.specialText:Show() else regions.specialText:Hide() end
		if style.options.showSpecialText2 then regions.specialText2:Show() else regions.specialText2:Hide() end
		if style.options.showSpecialArt then regions.specialArt:Show() else regions.specialArt:Hide() end
		--if not style.options.showspellicon then regions.spellicon:SetAlpha(0) end
		if style.options.showDangerSkull then else regions.dangerskull:SetAlpha(0) end
	end
end
-------------------------------------------------------
-- UpdatePlateIndicators
-------------------------------------------------------
local UpdatePlateIndicators
do
	local color = {}
	local extended, unit, style, bars, regions, aggroregion, alpha, platealpha, forcealpha, scale
	-- SetIndicatorElite 	-- Set Border and Aggro Glow Textures
	local function SetIndicatorElite()
		if unit.isElite then regions.healthborder:SetTexture( style.healthborder.elitetexture)
			aggroregion:SetTexture(style.threatborder.elitetexture)
		else regions.healthborder:SetTexture( style.healthborder.texture)
			aggroregion:SetTexture(style.threatborder.texture) end
	end
	-------------------------------------------------------
	-- UpdatePlateIndicators: Updates the nameplate information depending on unit conditions
	-------------------------------------------------------
	function UpdatePlateIndicators(plate)
		extended = plate.extended
		style, bars, regions, scale = extended.style, extended.bars, extended.regions, extended.scale
		unit, unitcache = extended.unit, extended.unitcache
		aggroregion = regions.threatborder
		alpha, platealpha, forcealpha = 1, 1, false 
		-- Set Alpha, Scale, Elite, Aggro
		if activetheme.SetAlpha then 
			alpha, forcealpha = activetheme.SetAlpha(unit)
			if not forcealpha then platealpha = plate:GetAlpha() end
			extended:SetAlpha((alpha or 1) * platealpha ) 
		else extended:SetAlpha(plate:GetAlpha()) end
		--if alpha == 0 then return end
		-- Scale
		if activetheme.SetScale then scale = activetheme.SetScale(unit); if scale then extended:SetScale( scale )end; end
		--if activetheme.SetScale then scale = activetheme.SetScale(unit) or 1 else scale = 1 end
		--extended:SetScale(scale)
		-- Elite Graphics
		if (unit.isElite == nil ) or unit.isElite ~= unitcache.isElite then SetIndicatorElite() end
		-- Set Aggro Region
		if  style.options.showAggroGlow and InCombat and unit.reaction ~= "FRIENDLY" and unit.type == "NPC" then
			color = style.threatcolor[unit.threatSituation]
			aggroregion:Show()
			aggroregion:SetVertexColor(color.r, color.g, color.b, color.a)
		else aggroregion:Hide() end
		-- Set Special-Case Regions
		if style.options.showSpecialText and activetheme.SetSpecialText then
			regions.specialText:SetText(activetheme.SetSpecialText(unit)) end
		if style.options.showSpecialText2 and activetheme.SetSpecialText2 then
			regions.specialText2:SetText(activetheme.SetSpecialText2(unit)) end
		if style.options.showSpecialArt and activetheme.SetSpecialArt then
			regions.specialArt:SetTexture(activetheme.SetSpecialArt(unit)) end
		-- Set Health Bar
		if activetheme.SetHealthbarColor then
			bars.healthbar:SetStatusBarColor(activetheme.SetHealthbarColor(unit))
		else bars.healthbar:SetStatusBarColor(bars.health:GetStatusBarColor()) end	
		bars.healthbar:SetMinMaxValues(bars.health:GetMinMaxValues())
		bars.healthbar:SetValue(bars.health:GetValue())
	end
end
-------------------------------------------------------
-- UpdatePlate- Gather Data
-------------------------------------------------------
local UpdatePlate
do
	local ClassReference = {}
	local _, stylename, unitchanged, extended, bars, regions, unit, unitcache, style
	-- ColorToString: Converts a color to a string with a C- prefix
	local function ColorToString(r,g,b) return "C"..math.floor((100*r) + 0.5)..math.floor((100*g) + 0.5)..math.floor((100*b) + 0.5) end
	-- GetUnitCombatStatus: Determines if a unit is in combat by checking the name text color
	local function GetUnitCombatStatus(r, g, b) return (r > .5 and g < .5) end
	-- GetUnitAggroStatus: Determines if a unit is attacking, by looking at aggro glow region
	local GetUnitAggroStatus
	do
		local shown 
		local red, green, blue
		function GetUnitAggroStatus( region)
			shown = region:IsShown()
			if not shown then return "LOW" end
			red, green, blue = region:GetVertexColor()
			if green > .7 then return "MEDIUM" end
			if red > .7 then return "HIGH" end
		end
	end
	-- GetUnitReaction: Determines the reaction, and type of unit from the health bar color
	local function GetUnitReaction(red, green, blue)																											
		if red < .01 and blue < .01 and green > .99 then return "FRIENDLY", "NPC" 
		elseif red < .01 and blue > .99 and green < .01 then return "FRIENDLY", "PLAYER"
		elseif red > .99 and blue < .01 and green > .99 then return "NEUTRAL", "NPC"
		elseif red > .99 and blue < .01 and green < .01 then return "HOSTILE", "NPC"
		else return "HOSTILE", "PLAYER" end
	end
	-- Populates the class color lookup table
	for classname, color in pairs(RAID_CLASS_COLORS) do 
		ClassReference[ColorToString(color.r, color.g, color.b)] = classname end
	-------------------------------------------------------
	-- UpdatePlate: Gathers Information about the unit, and requests updates, if needed
	-------------------------------------------------------
	UpdatePlate = function(plate, force)
		unitchanged = false
		extended = plate.extended
		--if not ( framenumber > extended.frameupdated) then return end
		bars = extended.bars
		regions = extended.regions 
		unit = extended.unit
		unitcache = extended.unitcache
		-- Populate Basic Unit Information Table
		unit.name = regions.name:GetText()
		
		unit.level = regions.level:GetText()
		unit.health = bars.health:GetValue()
		_, unit.healthmax = bars.health:GetMinMaxValues()
		unit.isCasting = bars.castbar:IsShown()
		if InCombat then unit.threatSituation = GetUnitAggroStatus(regions.threatGlow) else unit.threatSituation = "LOW" end
		unit.isMarked = regions.raidicon:IsShown()
		unit.alpha = plate:GetAlpha()
		--unit.isTarget = (unit.alpha == 1) and UnitExists("target") 
		unit.isTarget = (unit.alpha == 1) and unit.name == UnitName("target")
		unit.isMouseover = regions.highlight:IsShown()
		unit.isInCombat = GetUnitCombatStatus(regions.name:GetTextColor())
		unit.red, unit.green, unit.blue = bars.health:GetStatusBarColor()
		unit.reaction, unit.type = GetUnitReaction(unit.red, unit.green, unit.blue)
		unit.red, unit.green, unit.blue = bars.health:GetStatusBarColor()
		unit.reaction, unit.type = GetUnitReaction(unit.red, unit.green, unit.blue)
		-- Static Info
		if unit.name ~= unitcache.name or unit.reaction ~= unitcache.reaction then
			unit.isBoss = regions.dangerskull:IsShown()
			unit.isDangerous = unit.isBoss
			unit.isElite = regions.eliteicon:IsShown()
			if unit.type =="PLAYER" and unit.reaction == "HOSTILE" then 
				unit.class = ClassReference[ColorToString(unit.red, unit.green, unit.blue)] or "UNKNOWN"
			else unit.class = "UNKNOWN" end
		end
		-- Cast Info
		if unit.isCasting then
			unit.castbar = bars.castbar:GetValue()
			_, unit.castmax = bars.castbar:GetMinMaxValues()
		end
		-- Check UnitCache
		for key, value in pairs(unit) do if unitcache[key] ~= value then unitchanged = true end end
		-- Update Appearance
		if unitchanged or force then 
			if activetheme.multiStyle then stylename = activetheme.SetStyle(unit); extended.style = activetheme[stylename]
			else extended.style = activetheme; stylename = tostring(activetheme) end
			if extended.stylename ~= stylename or force then UpdateStyle(plate); extended.stylename = stylename; end
			
		end	
				
		-- These regions get reanchored/retextured after OnShow, so we reset them every update...
		style = extended.style
		regions.highlight:SetTexture(style.healthborder.glowtexture)
		regions.highlight:SetAllPoints(regions.healthborder)
		SetAnchorGroupObject(regions.level, style.level, extended) 
		SetAnchorGroupObject(regions.spellicon, style.spellicon, extended) 
		SetAnchorGroupObject(bars.castbar, style.castbar, extended) 
		if style.options.showLevel and (not regions.dangerskull:IsShown()) then regions.level:Show() else regions.level:Hide() end
		-- Update Indicators
		UpdatePlateIndicators(plate)
		if activetheme.OnUpdate then activetheme.OnUpdate(extended, unit) end
		-- Update Unit Cache
		for key, value in pairs(unit) do unitcache[key] = value end
	end
end
-------------------------------------------------------
-- ApplyPlateExtension
-------------------------------------------------------
local ApplyPlateExtension
do
	local regionPosition = { "threatGlow", "healthborder", "castborder", "castnostop", 
					"spellicon", "highlight", "name", "level",
					"dangerskull", "raidicon", "eliteicon" }
	-- GetRegionReferences: populates the Tidy Plates region cache with the Blizz regions
	local GetRegionReferences
	do
		local index, region, position
		local select = select
		function GetRegionReferences(regions, ...)
			for index = 1, select( "#", ... ) do
				region = select( index, ... )
				position = regionPosition[index]
				if region and position then regions[regionPosition[index]] = region end
			end
		end
	end
	-------------------------------------------------------
	-- ApplyPlateExtension: Applies scripts, hooks, and adds additional frame variables and elements
	-------------------------------------------------------
	do
		local bars, regions, health, castbar, healthbar
		function ApplyPlateExtension(plate)
			plate.extended = CreateFrame("Frame")
			local extended = plate.extended
			extended:SetPoint("CENTER", plate)
			
			--extended.frameupdated = -1 -- testing
			extended.style, extended.unit, extended.unitcache, extended.stylecache, extended.widgets = {}, {}, {}, {}, {}
			extended.regions, extended.bars, extended.objects = {}, {}, {}
			bars = extended.bars
			bars.health, bars.castbar = plate:GetChildren()
			--extended.stylename, extended.scale = "", 1
			extended.stylename = ""
			regions = extended.regions
			-- Create new objects
			bars.healthbar = CreateFrame("StatusBar", nil, extended) 
			regions.threatborder = extended:CreateTexture(nil, "ARTWORK")
			regions.specialArt = extended:CreateTexture(nil, "OVERLAY")
			regions.specialText = extended:CreateFontString(nil, "OVERLAY")
			regions.specialText2 = extended:CreateFontString(nil, "OVERLAY")
			health, castbar, healthbar = bars.health, bars.castbar, bars.healthbar
			-- Set Frame Levels and Reparent
			extended:SetFrameLevel(2)  -- ALF
			extended:SetFrameStrata("BACKGROUND")  -- ALF
			healthbar:SetFrameLevel(1)
			castbar:SetParent(extended)
			castbar:SetFrameLevel(1)
			GetRegionReferences(regions, plate:GetRegions())
			for index, region in pairs(regions) do region:SetParent(extended) end
			extended:EnableDrawLayer( "HIGHLIGHT" );
			-- Will they stick?  We'll see.. maybe have to move them back to UpdateStyle or something
			regions.castborder:SetDrawLayer("ARTWORK")		
			regions.castnostop:SetDrawLayer("ARTWORK")
			regions.raidicon:SetDrawLayer("OVERLAY")
			regions.spellicon:SetDrawLayer("OVERLAY")
			regions.spellicon:SetTexCoord(.07, 1-.07, .08, 1-.07)  -- obj:SetTexCoord(left,right,top,bottom) -- From TopLeft = 0,0, botomright = 1,1 for full - Works!
			--regions.highlight.show = function() print("Showing")end
			-- Hide redundant items
			regions.threatGlow:SetTexture(EMPTY_TEXTURE )
			regions.eliteicon:SetAlpha(0)
			bars.health:SetStatusBarTexture(EMPTY_TEXTURE )
			-- For adding additionl plate sub-objects 
			if activetheme.OnInitialize then activetheme.OnInitialize(extended) end
			-- Update Immediately
			UpdatePlate(plate, true)
			-- Hook for Updates
			health:HookScript("OnValueChanged", function () UpdatePlate(plate, false) end) 
			--health:HookScript("OnShow", function ()  extended:Show(); UpdatePlate(plate, true); end)  -- ALF
			health:HookScript("OnShow", function () SetSelfEcho(plate) ; extended:Show(); UpdatePlate(plate, true); end)  -- Apparently, the alpha changes sometimes after OnShow - Individual Plate Echo solution?
			health:HookScript("OnHide", function () extended:Hide(); extended.unitcache = wipe(extended.unitcache) end) -- ALF
			--health:HookScript("OnHide", function () extended:Hide(); wipe(extended.unitcache) end) -- ALF
			--health:HookScript("OnHide", function () extended:Hide();  end) -- Risky
			health:HookScript("OnSizeChanged", function() extended:SetScale( plate:GetScale() )  end)  -- ALF -- This is for Virtual Plates compatability; Need to improve
			castbar:HookScript("OnShow", function () UpdatePlate(plate, true) end) 
			castbar:HookScript("OnValueChanged", function () UpdatePlate(plate, false) end) 
			--castbar:HookScript("OnHide", function () UpdatePlate(plate, true); SetEchoUpdate(1) end) 
			castbar:HookScript("OnHide", function () UpdatePlate(plate, false); end) 
		end
	end
end
-------------------------------------------------------
-- World Update Functions
-------------------------------------------------------
local OnUpdate, UpdateAll
do
	local plate, curChildren
	local WorldFrameChildren = {}
	-- pack: Packs the return arguments of a function into an array
	local function pack(...) return {...} end
	-- IsFrameNameplate: Checks to see if the frame is a Blizz nameplate
	local function IsFrameNameplate(frame)
		local region = frame:GetRegions()
		return region and region:GetObjectType() == "Texture" and region:GetTexture() == "Interface\\TargetingFrame\\UI-TargetingFrame-Flash" 
	end
	-- OnWorldFrameChange: Checks for new Blizz Plates, and sends them to get 'Tidy Plated'
	local function OnWorldFrameChange()
		for index = 1, #WorldFrameChildren do
			plate = WorldFrameChildren[index]
			if IsFrameNameplate(plate) and not plate.extended then ApplyPlateExtension(plate) end
		end
	end
		
	-- UpdateAll: Requests an update on all Tidy Plates Frames
	do
		local Index, extended
		function UpdateAll(force)
			for Index = 1, #WorldFrameChildren do
				plate = WorldFrameChildren[Index]
				if plate.extended then
					extended = plate.extended
					if type(extended) == 'table' and extended:IsShown() then
						if force then extended.unitcache = wipe(extended.unitcache) end
						UpdatePlate(plate, force)
					end
				end
			end
		end
		--
	end
	-- OnUpdate: This function will look for new frames under the WorldFrame
	function OnUpdate(self)
		framenumber = framenumber + 1
		curChildren = WorldFrame:GetNumChildren()
		if (curChildren ~= numChildren) then
			numChildren = curChildren
			WorldFrameChildren = pack(WorldFrame:GetChildren())
			OnWorldFrameChange() 
		end	
		if echoUpdate > 0 then echoUpdate = echoUpdate - 1;  TidyPlates:Update() end
		for Index, Value in pairs(echoSelf) do if Value then UpdatePlate(Index, false); echoSelf[Index] = nil end; end
	end
end

-------------------------------------------------------
-- Internal Commands
-------------------------------------------------------
local function Update() UpdateAll(false) end
local function ForceUpdate() UpdateAll(true) end
local function ForceUpdateFrame(self, frametarget) if frametarget and type(frametarget) == "table" and type(frametarget.secureframe) == "table" then UpdatePlate(frametarget, true) end end
-------------------------------------------------------
-- Event Handlers
-------------------------------------------------------
do
	local events = {}
	local PlateHandler = CreateFrame("Frame")
	PlateHandler:SetScript("OnEvent", function(self, event, ...) events[event]() end)
	-- Events
	function events:PLAYER_ENTERING_WORLD() framenumber = 0; PlateHandler:SetScript("OnUpdate", OnUpdate) end
	--function events:PLAYER_REGEN_ENABLED() InCombat = false; ForceUpdate(); if useAutoHide then SetCVar("nameplateShowEnemies", 0) end end
	function events:PLAYER_REGEN_ENABLED() InCombat = false; SetEchoUpdate(1); if useAutoHide then SetCVar("nameplateShowEnemies", 0) end end
	--function events:PLAYER_REGEN_DISABLED() InCombat = true; ForceUpdate(); if useAutoHide then SetCVar("nameplateShowEnemies", 1) end end
	function events:PLAYER_REGEN_DISABLED() InCombat = true; SetEchoUpdate(1); if useAutoHide then SetCVar("nameplateShowEnemies", 1) end end
	function events:PLAYER_TARGET_CHANGED() SetEchoUpdate(1) end
	function events:RAID_TARGET_UPDATE() SetEchoUpdate(1) end
	function events:UNIT_THREAT_LIST_UPDATE() SetEchoUpdate(1) end
	function events:UNIT_LEVEL() SetEchoUpdate(1) end
	function events:CURSOR_UPDATE() SetEchoUpdate(1) end
	-- Event Registration
	for eventname in pairs(events) do PlateHandler:RegisterEvent(eventname) end
	GameTooltip:HookScript("OnTooltipSetUnit", function(self) SetEchoUpdate(1) end)
end
-------------------------------------------------------
-- External/P-API Commands
-------------------------------------------------------
TidyPlates.ForceUpdate = ForceUpdate
TidyPlates.ForceUpdateFrame = ForceUpdateFrame
TidyPlates.Update = Update
function TidyPlates:UseAutoHide(option) useAutoHide = option; if useAutoHide and (not InCombat) then SetCVar("nameplateShowEnemies", 0) end end
function TidyPlates:ActivateTheme(theme) if theme and type(theme) == 'table' then activetheme = theme; end end

-- Perf
TPT = {}
TPT.UpdatePlate = UpdatePlate
TPT.UpdatePlateIndicators = UpdatePlateIndicators
TPT.UpdateStyle = UpdateStyle
TPT.OnUpdate = OnUpdate
TPT.OnCreateChildFrames = G_OnWorldFrameChange
TPT.UpdateAll = UpdateAll
TPT.ApplyPlateExtension = ApplyPlateExtension
			