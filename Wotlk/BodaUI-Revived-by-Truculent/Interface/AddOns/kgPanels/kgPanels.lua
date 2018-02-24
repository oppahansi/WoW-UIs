--[[
All Hello Kitty intellectual property and materials are © Sanrio
]]
local kgPanels = LibStub("AceAddon-3.0"):NewAddon("kgPanels", "AceConsole-3.0")
local LSM = LibStub:GetLibrary("LibSharedMedia-3.0",true)
local DataBroker = LibStub:GetLibrary("LibDataBroker-1.1",true)
--[[
	some defaults
]]
local l_None = "None"
local l_Tooltip = "Blizzard Tooltip"
local l_Dialog = "Blizzard Dialog"
local l_config = "config"
local l_enable = "enable"
local l_disable = "disable"
local l_layout = "layout"
local l_usage = {[[Usage: /kgpanels <command>]],[["config" enter the config screen.]],[["enable" enable the mod.]],[["disable" disable the mod.]],[["layout" "layout name" to change layouts.]]}
local l_not_found = " not found."
local gsub = string.gsub
local default_font="Fonts\\FRIZQT__.TTF"

local defaultPanelOptions = {
	parent = "UIParent",
	x = 0,
	y = 0,
	width = 200,
	height = 100,
	level = 0,
	strata = "BACKGROUND",
	mouse = false,
	rotation = 0,
	vflip=false,
	hflip=false,
	anchor = "UIParent",
	anchorFrom = "CENTER",
	anchorTo = "CENTER",
	border_color = {r=1,g=1,b=1,a=1},
	border_texture = "Blizzard Tooltip",
	border_edgeSize = 16,
	bg_blend = "BLEND",
	bg_style = "SOLID",
	bg_texture = "None",
	bg_alpha = 1,
	bg_color = {r=.3,g=.3,b=.3,a=0.6},
	bg_insets = {t=-4,b=4,l=4,r=-4},
	bg_orientation = "HORIZONTAL",
	gradient_color = {r=1,g=1,b=1,a=0},
	text = {text="", color={r=1,g=1,b=1,a=1}, x=0,y=0,size = 0, justifyV="MIDDLE", justifyH="CENTER", font=""},
	scripts = {},
	tileSize = 0,
	tiling = false,
	absolute_bg = {ULx=0, ULy=0, LLx=0,LLy=1,URx=1,URy=0,LRx=1,LRy=1},
	use_absolute_bg = false,
	crop = false,
}
-- inline localizations
local gameLocale = GetLocale()
if gameLocale == "enGB" then
	gameLocale = "enUS"
end
-- Localizaers add stuff here
if gameLocale == "deDE" then
	l_None = "None"
end
if gameLocale == "esES" then
	l_None = "None"
end
if gameLocale == "frFR" then
	l_None = "Aucun"
	l_Tooltip = "Bulle d'aide de Blizzard"
	l_Dialog = "Fenêtre de dialogue de Blizzard"
	l_config = "config"
	l_enable = "activer"
	l_disable = "désactiver"
	l_layout = "Modèle"
	l_usage = {[[Utilisation : /kgpanels <commande>]],[["config" ouvre la fenêtre de configuration.]],[["activer" active cet addon.]],[["désactiver" désactive cet addon.]],[["modèle" "Nom du modèle" permet de changer de modèle.]]}
	l_not_found = " introuvable."
end
if gameLocale == "koKR" then
	l_None = "None"
end
if gameLocale == "ruRU" then
	l_None = "None"
end
if gameLocale == "zhCN" then
	l_None = "无"
	l_Tooltip = "默认提示信息框"
	l_Dialog = "默认对话框"
end
if gameLocale == "zhTW" then
	l_None = "None"
end
if gameLocale == "ruRU" then
	l_None = "None"
end
-- END localizations

-- end inline localizations
-- db default setup
local dbDefaults = {
	global = {
		artwork = {
			[l_None]  = "Interface\\None"
		},
		border = {
			[l_None]    = "Interface\\None",
			[l_Tooltip] = "Interface\\Tooltips\\UI-Tooltip-Border",
			[l_Dialog]  = "Interface\\DialogFrame\\UI-DialogBox-Border"
		},
		layouts = {
			[l_None] = {},
		}, -- [layout name] = { [framename] = {data}, [framename] = {data} }
		defaultPanel = defaultPanelOptions,
		layout_deps = { 
			["*"] = {}
		}, -- [layout] = "addon"
	},
	profile = {
		layout = l_None,
		enabled = true
	},
}

-- frames belonging to a layout
local activeFrames = {}
local frameCache = {}
-- frames missing a parent
local missingParents = {}
local missingAnchors = {}
local missingBackgrounds = {}
local missingBorders = {}
local missingFonts = {}
-- bad parents
local badParents = {}
-- upvalues
local cos = cos
local sin = sin
local min = math.min
local getglobal = getglobal
local rawset = rawset
local floor = math.floor
local loadstring = loadstring
local panelIndex = 1
local emptyLayout = {}
local strmatch = string.match
local tonumber = tonumber
local ipairs = ipairs
local IsAddOnLoaded = IsAddOnLoaded
local checkFrames = 0
local testingTexture = nil

kgPanels.eframe = kgPanels.eframe or CreateFrame("Frame","kgPanels_Dep_Frame")
-- default backgrop
local default_backdrop = {bgFile = "",edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = false, tileSize = 0, edgeSize = 16, insets = {left = 0,right = 0,top = 0,bottom = 0}}
-- some memorization data (only do the angle math once for a given angle)
local angles = setmetatable({}, {
	__index = function(t, k)
		local k = floor(k % 360)
		if k == 0 then
			t[k] = {0,0,0,1,1,0,1,1}
			return t[k]
		end
		local A = cos(k)
		local B = sin(k)
		local ULx, ULy = (-0.5 * A - -0.5 * B) + 0.5, (-0.5 * B + -0.5 * A) + 0.5
		local LLx, LLy = (-0.5 * A - 0.5 * B) + 0.5, (-0.5 * B + 0.5 * A) + 0.5
		local URx, URy = (0.5 * A - -0.5 * B) + 0.5, (0.5 * B + -0.5 * A) + 0.5
		local LRx, LRy = (0.5 * A - 0.5 * B) + 0.5, (0.5 * B + 0.5 * A) + 0.5
		t[k] = {ULx,ULy,LLx,LLy,URx,URy,LRx,LRy}
		return t[k]
	end
})
-- When a key lookup is performed, we check to see if the key (a frame name) exists in the parents table
-- If the key doesn't exist, we'll perform a global lookup to see if the frame exists, but just hasn't been added to the table yet
-- If the frame doesn't exist, we'll mark it as dirty in our badParents table
local parents = setmetatable({}, {
	__index = function(t,k)
		local p = getglobal(k)
		if p and type(p) == "table" and type(rawget(p,0)) == "userdata" then
			rawset(t,k,p)
			return p
		end
		return p
	end
})

-- flip a texture
local function flip(texture,horizontal)
	local ULx,ULy,LLx,LLy,URx,URy,LRx,LRy = texture:GetTexCoord()
	if horizontal then
		texture:SetTexCoord(URx, URy, LRx, LRy, ULx, ULy, LLx, LLy)
	else
		texture:SetTexCoord(LLx, LLy,ULx, ULy, LRx, LRy, URx, URy)
	end
end
-- need work, this method currently does jack and shit
local function crop(texture,top,left,bottom,right)
	local ULx,ULy,LLx,LLy,URx,URy,LRx,LRy = texture:GetTexCoord()
	--texture:SetTexCoordModifiesRect(true)
	texture:SetTexCoord(ULx+top,ULy+left,LLx+bottom,LLy+left,URx+top,URy+right,LRx+bottom,LRx+right)
end

local function executeScripts(frame,frameData,name)
	if frameData.scripts then		
		kgPanels:InitScripts(frame,name,frameData)			
	end
end

local function updateChildVisibility(frame)
	local kids = { frame:GetChildren() };
	for _, child in ipairs(kids) do
		child:Show()
	end
end
-- When a frame is created, we want to loop through every one of our panels which are using that frame as a parent/anchor
-- and then to reconfigure the panel to work with the newly created frame
local function reParentCheck(newframe)	
	for frame,mparent in pairs(missingParents) do
		local pf = parents[mparent]
		if not (kgPanels.db.global.layouts[kgPanels.active] and  kgPanels.db.global.layouts[kgPanels.active][frame]) then
			return
		end
		local isPercents = strmatch(kgPanels.db.global.layouts[kgPanels.active][frame].width, "%d+%.?%d*%%") or strmatch(kgPanels.db.global.layouts[kgPanels.active][frame].height, "%d+%.?%d*%%")
		if pf or mparent == newframe then -- the frame we want just got created
			-- make sure we dont parent to outselves
			if activeFrames[frame] == pf then error("Attempting to parent frame to self") end
			if pf then
				if (isPercents and pf:GetWidth() > 0 and pf:GetHeight() > 0) or not isPercents then
					kgPanels:ResetParent(activeFrames[frame],kgPanels.db.global.layouts[kgPanels.active][frame],frame)
					if pf:IsShown() then activeFrames[frame]:Show();updateChildVisibility(activeFrames[frame]) end
					missingParents[frame] = nil
					checkFrames = checkFrames -1
					activeFrames[frame].missing_parent_at_load = false
					activeFrames[frame].scripts_loaded = false
					executeScripts(activeFrames[frame],kgPanels.db.global.layouts[kgPanels.active][frame],frame)
				end
			end
		elseif activeFrames[mparent] and activeFrames[mparent] ~= frame then -- check the list of self frames
			if (isPercents and activeFrames[mparent]:GetWidth() > 0 and activeFrames[mparent]:GetHeight() > 0) or not isPercents then
				kgPanels:ResetParent(activeFrames[frame],kgPanels.db.global.layouts[kgPanels.active][frame],frame)
				if activeFrames[mparent]:IsShown() then activeFrames[frame]:Show();updateChildVisibility(activeFrames[frame]) end
				missingParents[frame] = nil
				checkFrames = checkFrames -1
				activeFrames[frame].missing_parent_at_load = false
				activeFrames[frame].scripts_loaded = false
				executeScripts(activeFrames[frame],kgPanels.db.global.layouts[kgPanels.active][frame],frame)
			end
		end
	end
	for frame,manchor in pairs(missingAnchors) do
		if activeFrames[manchor] and activeFrames[manchor] ~= frame then -- check the list of self frames
			kgPanels:ResetParent(activeFrames[frame],kgPanels.db.global.layouts[kgPanels.active][frame],frame)
			activeFrames[frame]:Show() 
			updateChildVisibility(activeFrames[frame])
			missingAnchors[frame] = nil
			checkFrames = checkFrames - 1
			activeFrames[frame].missing_anchor_at_load = false
			activeFrames[frame].scripts_loaded = false
			executeScripts(activeFrames[frame],kgPanels.db.global.layouts[kgPanels.active][frame],frame)
		elseif parents[manchor] or manchor == newframe then -- the frame we want just got created
			-- make sure we dont anchor to outselves
			if activeFrames[frame] == parents[manchor] then error("Attempting to anchor frame to self") end
			if parents[manchor] then
				kgPanels:ResetParent(activeFrames[frame],kgPanels.db.global.layouts[kgPanels.active][frame],frame)
				activeFrames[frame]:Show(); 
				updateChildVisibility(activeFrames[frame])
				missingAnchors[frame] = nil
				checkFrames = checkFrames -1
				activeFrames[frame].missing_anchor_at_load = false
				activeFrames[frame].scripts_loaded = false
				executeScripts(activeFrames[frame],kgPanels.db.global.layouts[kgPanels.active][frame],frame)
			end
		end
	end
end

-- Called from securly hooked CreateFrame().  Check if the frame being created is one of the frames marked as dirty in 
-- our list of bad parent frames.  If it is, reconfigure the panel to work with the frame and remove it from the dirty list
local parentCheckHook = function(...)
	local _,frame,_,_ = ...
	if frame and checkFrames > 0 then
		reParentCheck(frame)
	end
end


local function recycleFrame(frame)
	-- if we delete a frame, reparent the children to UIParent so they dont just disappear
	local kids = { frame:GetChildren() }
	for _, child in ipairs(kids) do
		child:SetParent(parents["UIParent"])
 	end
	frame:Hide()
	frame:SetScript("OnEvent",nil)
	frame:SetScript("OnUpdate",nil)
	frame:SetScript("OnShow",nil)
	frame:SetScript("OnHide",nil)
	frame:SetScript("OnEnter",nil)
	frame:SetScript("OnLeave",nil)	
	frame:SetScript("OnSizeChanged",nil)
	frame:SetScript("OnReceiveDrag",nil)
	frame:SetScript("OnMouseUp",nil)
	frame:SetScript("OnMouseDown",nil)
	frame.onload_already_exected = false
	frame.missing_parent_at_load = false
	frame.missing_anchor_at_load = false
	frameCache[frame] = true
end
local function injectArt()
	if LSM and LSM.Register then
		for art,path in pairs(kgPanels.db.global.artwork) do
			LSM:Register("background",art,path)
		end
		for art,path in pairs(kgPanels.db.global.border) do
			LSM:Register("border",art,path)
		end		
	end
end

function kgPanels:AddAsset(assetType, assetName, assetPath)
	if assetType == "background" then
		print("Adding "..assetName.." as "..assetPath)
		self.db.global.artwork[assetName] = assetPath
	end
	if assetType == "border" then
		self.db.global.border[assetName] = assetPath
	end
	if LSM and LSM.Register then
		LSM:Register(assetType,assetName,assetPath)
	end
end

local function fetchArt(art,artType)
	if not art then return nil end
	if kgPanels.db.global.artwork[art] and artType == "background"then
		return kgPanels.db.global.artwork[art]
	elseif kgPanels.db.global.border[art] and artType == "border" then
		return kgPanels.db.global.border[art]
	elseif LSM and LSM.Fetch and LSM:Fetch("border",art,true) and artType == "border" then
		return LSM:Fetch("border",art,true)
	elseif LSM and LSM.Fetch and LSM:Fetch("background",art,true) and artType == "background" then
		return LSM:Fetch("background",art,true)
	end
	kgPanels:Print("Failed to find artwork "..art.." type "..artType)
	return nil
end
local function fetchFont(font)
	if font and LSM and LSM.Fetch and LSM:Fetch("font",font,true) then
		return LSM:Fetch("font",font)
	end
	return nil
end
--[[ Helper function for Config so i dont duplicate the code again ]]
function kgPanels:FetchArt(art,artType)
	return fetchArt(art,artType)
end
function kgPanels:FetchFont(font)
	return fetchFont(font)
end
-- Create (or fetch) a frame for use by a kgPanel, and setup its configuration
local function getFrame()
	local frame = next(frameCache)
	if frame then
		frame:SetParent(UIParent)
		frameCache[frame] = nil
	else
		frame = CreateFrame("Frame","kgPanel"..panelIndex,parents["UIParent"])
		frame.bg = frame:CreateTexture(nil, "PARENT")
		frame.text = frame:CreateFontString(nil, "OVERLAY");
		panelIndex = panelIndex + 1
	end
	frame:SetScript("OnEvent",nil)
	frame:SetScript("OnUpdate",nil)
	frame:SetScript("OnShow",nil)
	frame:SetScript("OnHide",nil)
	frame:SetScript("OnEnter",nil)
	frame:SetScript("OnLeave",nil)
	frame:SetScript("OnSizeChanged",nil)
	frame:SetScript("OnReceiveDrag",nil)
	frame:SetScript("OnMouseUp",nil)
	frame:SetScript("OnMouseDown",nil)
	frame.bg:SetTexture(0.1,0.1,0.1,0.8)
	frame:SetFrameStrata("BACKGROUND")
	frame:SetWidth(200)
	frame:SetHeight(100)
	frame.bg:ClearAllPoints()
	frame.bg:SetPoint("TOPLEFT", frame, "TOPLEFT", 4, -4);
	frame.bg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -4, 4);
	frame:ClearAllPoints()
	frame.text:SetPoint("CENTER",frame,"CENTER",0,0)
	frame:SetBackdrop(default_backdrop)
	frame:SetPoint("CENTER",UIParent,"CENTER",0,0)
	frame.scripts_loaded = false
	frame.missing_parent_at_load = false
	frame.missing_anchor_at_load = false
	frame:Show()
	return frame
end
local launcher

function kgPanels:OnInitialize()
	self.db = LibStub("AceDB-3.0"):New("kgPanelsDB", dbDefaults, "Default")
	self:UpgradeDB()
	self:RegisterChatCommand("kgPanels","CommandLine",true,true)
	self.parents = parents
	self.angles = angles
	self.flip = flip
	if DataBroker then
		local launcher = DataBroker:NewDataObject("kgPanels", {
		    type = "launcher",
		    icon = "Interface\\AddOns\\kgPanels\\icon.tga",
		    OnClick = function(clickedframe, button)
				local loaded = IsAddOnLoaded("kgPanelsConfig")
				if loaded then
					LibStub("AceConfigDialog-3.0"):Open("kgPanelsConfig")
				else
					loaded, reason = LoadAddOn("kgPanelsConfig")
					if loaded then
						LibStub("AceConfigDialog-3.0"):Open("kgPanelsConfig")
					end
				end
		    end,
		})		
	end
	-- Hook the CreateFrame function so that kgPanels set to non-existant parent/anchor frames can be updated if/when those frames are created
	hooksecurefunc("CreateFrame", parentCheckHook)
	injectArt()
	if LSM then
		LSM:RegisterCallback("LibSharedMedia_Registered",self.AddMissingMedia) 
	end
	testingTexture = self.eframe:CreateTexture(nil,"PARENT")
end

function kgPanels:AddMissingMedia(mediaType, key)
	if mediaType == "background" then
		for name,v in pairs(missingBackgrounds) do
			if v == key then
				kgPanels:Print("Missing Background "..v.." has been added .. applying texture to "..name)
				kgPanels:ResetTextures(activeFrames[name],kgPanels.db.global.layouts[kgPanels.active][name],name)
			end
		end
	elseif mediaType == "border" then
		for name,v in pairs(missingBorders) do
			if v == key then
				kgPanels:Print("Missing Border "..v.." has been added .. applying texture to "..name)
				kgPanels:ResetTextures(activeFrames[name],kgPanels.db.global.layouts[kgPanels.active][name],name)
			end
		end
	elseif mediaType == "font" then
		for name,v in pairs(missingFonts) do
			if v == key then
				kgPanels:Print("Missing font "..v.." has been added .. applying font to "..name)
				kgPanels:ResetFont(name,kgPanels.db.global.layouts[kgPanels.active][name])
			end
		end
	end
end

local function checkScriptDeps(addon)
	for k,v in pairs(kgPanels.db.global.layout_deps[self.active]) do
		if v == addon then
			kgPanels:InitScripts(activeFrames[k],k,self.db.global.layouts[k])
		end
	end
end

function kgPanels:OnEnable()
	if self.db.profile.enabled then
		if self.db.profile.layout and self.db.global.layouts[self.db.profile.layout] then
			self.active = self.db.profile.layout
			self:ApplyLayout(self.db.global.layouts[self.active])
			reParentCheck("UIParent") -- perform a check after the layout has been applied
			self.eframe:RegisterEvent("ADDON_LOADED", function(addon) checkScriptDeps(addon) end)
			self.eframe.lastCheck = 0
			self.eframe:SetScript("OnUpdate",function(frame,elapsed) 
				frame.lastCheck = frame.lastCheck + elapsed
				if checkFrames == 0 then frame:SetScript("OnUpdate",nil) end
				if frame.lastCheck > 0.05 and checkFrames > 0 then
					reParentCheck("UIParent")
					frame.lastCheck = 0
					if checkFrames == 0 then
						frame:SetScript("OnUpdate",nil)
					end
				end
			end)
		end
	end
end
function kgPanels:UpgradeDB()
	if self.db.global.version == 1 then
		for k,v in pairs(self.db.global.layouts) do
			for name,panel in pairs(v) do
				if not panel.absolute_bg then
					panel.absolute_bg = {ULx=0, ULy=0, LLx=0,LLy=1,URx=1,URy=0,LRx=1,LRy=1}
					panel.use_absolute_bg = false
				end
				if not panel.scripts then
					panel.scripts = {}
				end
			end
		end
		self.db.global.version = 2
	end
	if self.db.global.version == 2 then
		for k,v in pairs(self.db.global.layouts) do
			for name,panel in pairs(v) do
				if panel.bg_insets then
					local t,l,r,b
					t = 0
					l = 0
					r = 0
					b = 0
					if panel.bg_insets.l then
						t = panel.bg_insets.l
					end
					if panel.bg_insets.t then
						l = panel.bg_insets.t
					end
					if panel.bg_insets.r then
						b = panel.bg_insets.r
					end
					if panel.bg_insets.b then
						r = panel.bg_insets.b
					end
					panel.bg_insets.t = t
					panel.bg_insets.l = l
					panel.bg_insets.b = b
					panel.bg_insets.r = r
				end
			end
		end	
		self.db.global.version = 3
	end
end
-- add a fetch method to check our library or LSM, and use it in place frame
function kgPanels:OnDisable()
	self:ApplyLayout(emptyLayout)
end

-- handle the slash command
function kgPanels:CommandLine(input)
	local cmd,ly = self:GetArgs(input,2,1)
	if cmd == l_config then
		local loaded = IsAddOnLoaded("kgPanelsConfig")
		if loaded then
			LibStub("AceConfigDialog-3.0"):Open("kgPanelsConfig")
		else
			loaded, reason = LoadAddOn("kgPanelsConfig")
			if loaded then
				LibStub("AceConfigDialog-3.0"):Open("kgPanelsConfig")
			else
				self:Print(reason)
			end
		end
	end
	if cmd == l_enable then
		self.db.profile.enabled = true
		self:OnEnable()
	end
	if cmd == l_disable then
		self.db.profile.enabled = false
		self:OnDisable()
	end
	if cmd == l_layout then
		if ly and self.db.global.layouts[ly] then
			self:ActivateLayout(ly)
			reParentCheck("UIParent") -- perform a check after the layout has been applied
			self.db.profile.layout = ly
		else
			if ly then
				self:Print(ly..l_not_found)
			else
				self:Print(l_not_found)
			end
		end
	end
	if not cmd  then
		for i,k in ipairs(l_usage) do
			self:Print(k)
		end
	end
end


--[[
	A layout if a group of frames
	format:
	{
		["Frame name"] = { data },
	}
	applying a layout of {} will clear the screen
]]
function kgPanels:ActivateLayout(name)
	if name == l_None then
		self.active = L_None
		self:ApplyLayout(emptyLayout)
	else
		self.active = name
		self:ApplyLayout(self.db.global.layouts[name])
	end
end
function kgPanels:ApplyLayout(layoutData)
	for k,v in pairs(activeFrames) do
		self:RemoveFrame(k)
	end
	if layoutData and type(layoutData) == "table" then
		for name,data in pairs(layoutData) do
			if not data.scripts then
				data.scripts = {}
			end
			if not data.absolute_bg then
				data.absolute_bg = {ULx=0, ULy=0, LLx=0,LLy=1,URx=0,URy=0,LRx=0,LRy=1}
				data.use_absolute_bg = false
			end
			self:PlaceFrame(name,data,true)
		end
		for name,data in pairs(layoutData) do
			if self.db.global.layout_deps[self.active] and self.db.global.layout_deps[self.active][name] then
			 	if IsAddOnLoaded(self.db.global.layout_deps[self.active][name]) then		
					self:InitScripts(activeFrames[name],name,data)
				end
			else
				self:InitScripts(activeFrames[name],name,data)			
			end
		end
	end
end
--[[
	Re-Parent a frame
]]
function kgPanels:ReParent(name,newParent,newAnchor)
	if activeFrames[name] then
		data = self.db.global.layouts[self.active][name]
		self:ResetParent(activeFrames[name],data,name,newParent,newAnchor)
	end
end
--[[
	Grab an active frame
]]
function kgPanels:FetchFrame(name)
	return activeFrames[name]
end
--[[
	Remove a frame from the ui
]]
function kgPanels:RemoveFrame(name)
	if activeFrames[name] then
		recycleFrame(activeFrames[name])
	end
	activeFrames[name] = nil
end
--[[
	create function refs for scripts
]]
local function makeRef(extraCode)
	local ref = "local kgPanels = LibStub(\"AceAddon-3.0\"):GetAddon(\"kgPanels\");"
	if extraCode then
		ref = ref..extraCode
	end
	return ref
end
--[[
	Place a frame in the UI
	format:
	parent = "UIParent"|"kgPanel name",
	x = integer,
	y = integer,
	width = integer,
	height = integer,
	level = integer,
	strata = BACKGROUND"|LOW|MEDIUM|HIGH|DIALOG|TOOLTIP
	mouse = boolean,
	rotation = 0..360,
	flip=HORIZONTAL|VERTICAL|NONE
	anchor = "UIParent"|"kgPanel name",
	anchorFrom = CENTER|LEFT|RIGHT|TOP|BOTTOM|BOTTOMLEFT|BOTTOMRIGHT|TOPLEFT|TOPRIGHT,
	anchorTo = CENTER|LEFT|RIGHT|TOP|BOTTOM|BOTTOMLEFT|BOTTOMRIGHT|TOPLEFT|TOPRIGHT,
	border_color = {r=1,g=1,b=1,a=1},
	border_texture = "library texture name"
	border_edgeSize = 16,
	bg_blend = BLEND|ADD|MOD|ALPHAKEY
	bg_style = SOLID|GRADIENT|TEXTURE
	bg_texture = "library texture name"
	bg_alpha = 0..1
	bg_color = {r=.3,g=.3,b=.3,a=0.6}
	bg_insets = {t=4,b=4,l=4,r=4}
	bg_orientation = HORIZONTAL|VERTICAL
	gradient_color = {r=1,g=1,b=1,a=0}
	text = {text="", color={r=1,g=1,b=1,a=1}, x=0,y=0,size = 0, justifyV=TOP|BOTTOM|MIDDLE, justifyH=LEFT|RIGHT|CENTER, font="font path"}
	scripts = { [name]={
		[hook = EVENT|UPDATE|SHOW|HIDE|ENTER|LEAVE|LOAD] = "code" all code can use the this reference to for the frame, .bg is the background texture .text if the font string
	}}
	use_absolute_bg=boolean
	absolute_bg={ULx,ULy,LLx,LLy,URx,URy,LRx,LRy},
	crop=false
	:end format
]]
function kgPanels:PlaceFrame(name,frameData, delay)
	local frame = getFrame()
	-- Mark our kgPanel as being active
	activeFrames[name] = frame
	self:ResetParent(frame,frameData,name)
	self:ResetTextures(frame,frameData,name)
	frame:EnableMouse(frameData.mouse)
	self:ResetFont(name,frameData.text)
	frame:Show()
	self:InitScripts(frame,name,frameData)
	if frame.missing_parent_at_load or frame.missing_anchor_at_load then
		frame:Hide()
	end
end
function kgPanels:InitScripts(frame,name,frameData)
	if frameData.scripts then		
	-- do onload first
		--if frame.scripts_loaded then
		--	self:Print("Frame scripts already loaded skipping")
		--	return
		--end
		if not frame.missing_parent_at_load and not frame.missing_anchor_at_load then
			if frameData.scripts["LOAD"] then
				self:SetupScript(frame,"LOAD",frameData.scripts["LOAD"],name)
			end
			for hook,code in pairs(frameData.scripts) do
				if hook ~= "LOAD" then
					self:SetupScript(frame,hook,code,name)
				end
			end
			--frame.scripts_loaded = true
		end
	end
end

function kgPanels:ResetParent(frame,frameData,name,overrideParent,overrideAnchor)
	local parent = parents[frameData.parent]
	if overrideParent then
		parent = overrideParent
	end
	if not parent then
		-- are we trying to parent ot one of our other layout frames?
		-- dont allow self parenting
		if activeFrames[frameData.parent] and activeFrames[frameData.parent] ~= frame then
			parent = activeFrames[frameData.parent]
		else
			missingParents[name] = frameData.parent
			checkFrames = checkFrames + 1
			parent = parents["UIParent"]
			frame.missing_parent_at_load = true
			frame:Hide()
		end
	end
	frame:SetParent(parent)
	frame:ClearAllPoints()
	-- Percentage size support
	if strmatch(frameData.width, "%d+%.?%d*%%") then
		local pWidth = parent:GetWidth()
		local fWidth = strmatch(frameData.width, "%d+%.?%d*")
		frame:SetWidth(pWidth * (fWidth / (100.0)))
	elseif strmatch(frameData.width, "%d+") then
		local pWidth = strmatch(frameData.width,"%d+")
		frame:SetWidth(pWidth)
	end
	if strmatch(frameData.height, "%d+%.?%d*%%") then
		local pHeight = parent:GetHeight()
		local fHeight = strmatch(frameData.height, "%d+%.?%d*")
		frame:SetHeight(pHeight * (fHeight / (100.0)))
	elseif strmatch(frameData.height, "%d+") then
		local pHeight = strmatch(frameData.height,"%d+")
		frame:SetHeight(pHeight)
	end
	if frameData.scale then
		frame:SetScale(frameData.scale)
	end
	local anchor = parents[frameData.anchor]
	if overrideAnchor then
		anchor = overrideAnchor
	end
	-- setup the kgPanel's anchor.  If anchor doesn't exist, we'l attach it to the UIParent for now
	if anchor then
		frame:SetPoint(frameData.anchorFrom,anchor,frameData.anchorTo,frameData.x,frameData.y)
	else
		-- check to see if we are tryin to parent of own of our own frames
		-- dont all self refering anchors
		if activeFrames[frameData.anchor] and activeFrames[frameData.anchor] ~= frame then
			frame:SetPoint(frameData.anchorFrom,activeFrames[frameData.anchor],frameData.anchorTo,frameData.x,frameData.y)
		else
			missingAnchors[name] = frameData.anchor
			checkFrames = checkFrames + 1
			frame:SetPoint(frameData.anchorFrom,parents["UIParent"],frameData.anchorTo,frameData.x,frameData.y)
			frame.missing_anchor_at_load = true
			frame:Hide()
		end
	end
	if frameData.level < 0 then
		frameData.level = 0
	end
	frame:SetFrameLevel(frameData.level)
	frame:SetFrameStrata(frameData.strata)
end
function kgPanels:ResetTextures(frame,frameData,name)
	frame.bg:SetTexCoord(0,1,0,1)
	local ULx,ULy,LLx,LLy,URx,URy,LRx,LRy = frame.bg:GetTexCoord()
	--frame.bg:SetTexCoordModifiesRect(false)
	frame.bg:SetBlendMode(frameData.bg_blend)
	frame.bg:SetAlpha(frameData.bg_alpha)
	-- need to adjust background alpha to be multiplicitive of the main frame alpha
	local alpha_override = frameData.bg_alpha
	if frameData.bg_style == "SOLID" then
		frame.bg:SetGradientAlpha(frameData.bg_orientation,frameData.bg_color.r,frameData.bg_color.g,frameData.bg_color.b,min(frameData.bg_color.a,alpha_override),frameData.bg_color.r,frameData.bg_color.g,frameData.bg_color.b,min(frameData.bg_color.a,alpha_override))
		frame.bg:SetTexture(frameData.bg_color.r,frameData.bg_color.g,frameData.bg_color.b,min(frameData.bg_color.a,alpha_override))
	elseif frameData.bg_style == "GRADIENT" then
		frame.bg:SetGradientAlpha(frameData.bg_orientation,frameData.bg_color.r,frameData.bg_color.g,frameData.bg_color.b,min(frameData.bg_color.a,alpha_override),frameData.gradient_color.r,frameData.gradient_color.g,frameData.gradient_color.b,min(frameData.gradient_color.a,alpha_override))
		frame.bg:SetTexture(1,1,1,1)
	end
	if frameData.bg_texture and strlen(frameData.bg_texture) > 0 then
		local path = fetchArt(frameData.bg_texture,"background")
		frame.bg:SetTexture(path)
		local t = frame.bg:GetTexture()
		if not t then
			if  path then
				self:Print("Background Texture "..frameData.bg_texture.."("..path..") failed to load.")
			else
				missingBackgrounds[name]=frameData.bg_texture
				frame.bg:SetTexture("Interface\\Buttons\\WHITE8x8")
				self:Print("Texture not found "..frameData.bg_texture.." in kgPanels or SharedMedia setting to solid white")
			end
		end
	end
	if frameData.border_texture and strlen(frameData.border_texture) > 0 then 
		local path = fetchArt(frameData.border_texture,"border")
		if frameData.border_texture ~= l_None then
			local nonePath = fetchArt(L_None,"border")
			if not path then
				missingBorders[name]=frameData.border_texture
				self:Print("Border "..frameData.border_texture.." was not found in kgPanels or SharedMedia.")
			else
				testingTexture:SetTexture(path)
				if not testingTexture:GetTexture() and path ~= nonePath then
					self:Print("Border texture "..frameData.border_texture.." ("..path..") failed to load.")
				end
				testingTexture:SetTexture(nil)
			end
		end
	end
	if frameData.tiling then
		frame.bg:SetTexture(nil)
		frame:SetBackdrop({	bgFile = fetchArt(frameData.bg_texture,"background"),edgeFile = fetchArt(frameData.border_texture,"border"),edgeSize = frameData.border_edgeSize,tile = true,tileSize = frameData.tileSize,insets = {left = frameData.bg_insets.l,right = frameData.bg_insets.r,top = frameData.bg_insets.t,bottom = frameData.bg_insets.b}})
	else
		frame:SetBackdrop({	bgFile = "",edgeFile = fetchArt(frameData.border_texture,"border"),edgeSize = frameData.border_edgeSize,tile = false,tileSize = 0,insets = {left = 0,right = 0,	top = 0,bottom = 0}})
	end
	frame:SetBackdropColor(frameData.bg_color.r,frameData.bg_color.g,frameData.bg_color.b,frameData.bg_color.a)
	frame:SetBackdropBorderColor(frameData.border_color.r,frameData.border_color.g,frameData.border_color.b,frameData.border_color.a)
	frame.bg:SetPoint("TOPLEFT", frame, "TOPLEFT", frameData.bg_insets.l, frameData.bg_insets.t);
	frame.bg:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", frameData.bg_insets.r, frameData.bg_insets.b);
	-- only use the backdrop for border.
	-- rotating and flipping can only be done on a texture
	frame.bg:SetTexCoord(unpack(angles[frameData.rotation]))
	if frameData.use_absolute_bg and not frameData.tiling then
		local coord = frameData.absolute_bg
		--if frameData.crop then
		--	frame.bg:SetTexCoordModifiesRect(crop)
		--end
		frame.bg:SetTexCoord(coord.ULx,coord.ULy,coord.LLx,coord.LLy,coord.URx,coord.URy,coord.LRx,coord.LRy)
	end
	if frameData.hflip then
		flip(frame.bg,true)
	end
	if frameData.vflip then
		flip(frame.bg,false)
	end
	frame:SetFrameLevel(frameData.level)
	frame:SetFrameStrata(frameData.strata)
	frame.bg:SetDrawLayer("BACKGROUND")
end

function kgPanels:ResetFont(name,fontdata)
	local f = self:FetchFrame(name)
	if not f then return end
	if fontdata.size == 0  or fontdata.size == nil then
		fontdata.size = 12
	end
	local font = fetchFont(fontdata.font)
	if not font then
		missingFonts[name]=fontdata.font
		font = default_font
	end
	f.text:SetFont(font,fontdata.size)
	f.text:SetPoint("CENTER", f.bg, "CENTER", fontdata.x, fontdata.y)
	f.text:SetJustifyV(fontdata.justifyV)
	f.text:SetJustifyH(fontdata.justifyH)
	f.text:SetTextColor(fontdata.color.r,fontdata.color.g,fontdata.color.b,fontdata.color.a)
	f.text:SetText(gsub(fontdata.text,'||','\124'))
end
function kgPanels:SetupScript(frame,hook,code,name,initial)
--	self:Print("Setting up scripts for "..hook.." ("..name..")")
	if not frame then return end
	local code,subs = gsub(code, '||','\124')
	if hook == "EVENT" and strlen(code) > 1 then
		local func, errorMessage = loadstring("return function(self,event,arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10) "..makeRef().." "..code.." end",name.."_OnEvent")
		if func then
			frame:SetScript("OnEvent",func())
		else
			self:Print(errorMessage)
		end
	elseif hook == "EVENT" and strlen(code) < 1 then
		frame:SetScript("OnEvent",nil)
	end
	if hook == "UPDATE" and strlen(code) > 1 then
		local func, errorMessage = loadstring("return function(self,time) "..makeRef().." "..code.." end",name.."_OnUpdate")
		if func then
			frame:SetScript("OnUpdate",func())
		else
			self:Print(errorMessage)
		end
	elseif hook == "UPDATE" and strlen(code) < 1 then
		frame:SetScript("OnUpdate",nil)
	end
	if hook  == "SHOW" and strlen(code) > 1 then
		local func, errorMessage = loadstring("return function(self) "..makeRef().." " ..code.." end",name.."_OnShow")
		if func then
			frame:SetScript("OnShow",func())
		else
			self:Print(errorMessage)
		end
	elseif hook == "SHOW" and strlen(code) < 1 then
		frame:SetScript("OnShow",nil)
	end
	if hook == "HIDE" and strlen(code) > 1 then
		local func, errorMessage = loadstring("return function(self) "..makeRef().." "..code.." end",name.."_OnHide")
		if func then
			frame:SetScript("OnHide",func())
		else
			self:Print(errorMessage)
		end
	elseif hook == "HIDE" and strlen(code) < 1 then
		frame:SetScript("OnHide",nil)
	end
	if hook == "ENTER" and strlen(code) > 1 then
		local func, errorMessage = loadstring("return function(self) "..makeRef().." "..code.." end",name.."_OnEnter")
		if func then
			frame:SetScript("OnEnter",func())
		else
			self:Print(errorMessage)
		end
	elseif hook == "ENTER" and strlen(code) < 1 then
		frame:SetScript("OnEnter",nil)
	end
	if hook == "LEAVE" and strlen(code) > 1 then
		local func, errorMessage = loadstring("return function(self) "..makeRef().." "..code.." end",name.."_OnLeave")
		if func then
			frame:SetScript("OnLeave",func())
		else
			self:Print(errorMessage)
		end
	elseif hook == "LEAVE" and strlen(code) < 1 then
		frame:SetScript("OnLeave",nil)
	end
	if hook == "CLICK" and strlen(code) > 1 then
		local funcD, errorMessage = loadstring("return function(self,button) "..makeRef(" local pressed=true;").." "..code.." end",name.."_OnClickDown")
		local funcU, errorMessage = loadstring("return function(self,button) "..makeRef(" local released=true;").." "..code.." end",name.."_OnClickUp")
		if funcD then
			frame:SetScript("OnMouseDown",funcD())
		else
			self:Print(errorMessage)
		end	
		if funcU then
			frame:SetScript("OnMouseUp",funcU())
		else 
			self:Print(errorMessage)
		end
	elseif hook == "CLICK" and strlen(code) < 1 then
		frame:SetScript("OnMouseDown",nil)
		frame:SetScript("OnMouseUp",nil)
	end
	if hook == "RESIZE" and strlen(code) > 1 then
		local func, errorMessage = loadstring("return function(self,height,width) "..makeRef().." "..code.." end",name.."_OnResize")
		if func then
			frame:SetScript("OnSizeChanged",func())
		else
			self:Print(errorMessage)
		end	
	elseif hook == "RESIZE" and strlen(code) < 1 then
		frame:SetScript("OnSizeChanged",nil)
	end
	if hook == "DROP" and strlen(code) > 1 then
		local func, errorMessage = loadstring("return function(self) "..makeRef().." "..code.." end",name.."_OnResize")
		if func then
			frame:SetScript("OnReceiveDrag",func())
		else
			self:Print(errorMessage)
		end	
	elseif hook == "DROP" and strlen(code) < 1 then
		frame:SetScript("OnReceiveDrag",nil)
	end
	if hook == "LOAD" and strlen(code) > 1 then
		local func, errorMessage = loadstring("return function(self, kgPanels) "..code.." end",name.."_OnLoad")
		if func then
			local y = func() -- untested
			y(frame,kgPanels)
		else
			self:Print(errorMessage)
		end
	end
end