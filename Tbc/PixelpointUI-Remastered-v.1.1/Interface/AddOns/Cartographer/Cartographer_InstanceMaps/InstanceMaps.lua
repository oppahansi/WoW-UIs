assert(Cartographer, "Cartographer not found!")
local Cartographer = Cartographer
local revision = tonumber(string.sub("$Revision: 56068 $", 12, -3))
if revision > Cartographer.revision then
	Cartographer.version = "r" .. revision
	Cartographer.revision = revision
	Cartographer.date = string.sub("$Date: 2007-11-26 15:54:07 -0500 (Mon, 26 Nov 2007) $", 8, 17)
end

local L = Rock("LibRockLocale-1.0"):GetTranslationNamespace("Cartographer-InstanceMaps")

L:AddTranslations("enUS", function() return {
	["Instance Maps"] = true,
	["Module which provides maps of instances."] = true,
	
	["Instances"] = true,
	
	["%d-man"] = true,
} end)

L:AddTranslations("deDE", function() return {
	["Instance Maps"] = "Instanzkarten",
	["Module which provides maps of instances."] = "Modul, das Instanzkarten zur Verfügung stellt.",
  
	["Instances"] = "Instanzen",
	["%d-man"] = "%d Spieler",
} end)

L:AddTranslations("frFR", function() return {
	["Instance Maps"] = "Cartes d'instance",
	["Module which provides maps of instances."] = "Module fournissant des cartes pour les instances.",

	--["Instances"] = true,
	["%d-man"] = "%dj",
} end)

L:AddTranslations("koKR", function() return {
	["Instance Maps"] = "인스턴스 지도",
	["Module which provides maps of instances."] = "인스턴스 던전의 지도를 표시합니다.",
	
	["Instances"] = "인스턴스",
	["%d-man"] = "%d명",
} end)

L:AddTranslations("zhTW", function() return {
	["Instance Maps"] = "副本地圖",
	["Module which provides maps of instances."] = "提供副本地圖的模組。",
	
	["Instances"] = "副本",	
	
	["%d-man"] = "%d人",
} end)

L:AddTranslations("zhCN", function() return {
	["Instance Maps"] = "副本地图",
	["Module which provides maps of instances."] = "显示副本地图",

	["Instances"] = "副本",
	["%d-man"] = "%d人",
} end)

L:AddTranslations("esES", function() return {
	["Instance Maps"] = "Mapas de Instancia",
	["Module which provides maps of instances."] = "M\195\179dulo que provee mapas de instancias",
	
	["Instances"] = "Instancias",
	["%d-man"] = "%d-hombres",
} end)

local Dewdrop = AceLibrary("Dewdrop-2.0")

local MapData, Rotations, Floors = Cartographer_InstanceMaps_MapData, Cartographer_InstanceMaps_Rotations, Cartographer_InstanceMaps_Floors
Cartographer_InstanceMaps_MapData, Cartographer_InstanceMaps_Rotations, Cartographer_InstanceMaps_Floors = nil, nil, nil

Cartographer_InstanceMaps = Cartographer:NewModule("InstanceMaps", "LibRockHook-1.0", "LibRockEvent-1.0", "LibRockTimer-1.0")
local Cartographer_InstanceMaps = Cartographer_InstanceMaps

local BZ = Rock("LibBabble-Zone-3.0")
local BZL = BZ:GetLookupTable()
local BZR = BZ:GetReverseLookupTable()
local Tourist = Rock("LibTourist-3.0")

local path
function Cartographer_InstanceMaps:OnInitialize()
	path = debugstack(1, 1, 0)
	if path:find("grapher\\") then
		path = "Interface\\AddOns\\Cartographer\\Cartographer_InstanceMaps\\Artwork\\"
	elseif path:find("grapher_InstanceMaps\\") then
		path = "Interface\\AddOns\\Cartographer_InstanceMaps\\Artwork\\"
	else
		error("Cannot determine path of artwork")
	end
	self.name = L["Instance Maps"]
	self.title = L["Instance Maps"]
	Cartographer.options.args.InstanceMaps = {
		name = L["Instance Maps"],
		desc = L["Module which provides maps of instances."],
		type = 'group',
		args = {
			toggle = {
				name = Cartographer.L["Enabled"],
				desc = Cartographer.L["Suspend/resume this module."],
				type = "toggle",
				order = -1,
				get = function() return Cartographer:IsModuleActive(self) end,
				set = function() Cartographer:ToggleModuleActive(self) end
			},
		},
		handler = self,
	}
end

local CartographerInstanceFrame
function Cartographer_InstanceMaps:OnEnable()
	self:AddSecureHook("SetMapZoom")
	self:AddHook("SetMapToCurrentZone")
	self:AddEventListener("PLAYER_LEVEL_UP")
	self:AddEventListener("LibRockEvent-1.0", "FullyInitialized", "PLAYER_LEVEL_UP")
	self:PLAYER_LEVEL_UP()
	
	CartographerInstanceFrame = CreateFrame("Button", "CartographerInstanceFrame", WorldMapFrame)
	CartographerInstanceFrame:Hide()
end

function Cartographer_InstanceMaps:OnDisable()
	self:HideInstanceFrame()
end

function Cartographer_InstanceMaps:PLAYER_LEVEL_UP()
	Cartographer.gotoOptions.args.Instances = {
		name = L["Instances"],
		desc = L["Instances"],
		type = 'group',
		args = {},
		hidden = function() return not Cartographer:IsModuleActive(self) end
	}
	for i = 1, 4 do
		local validate = {}
		local func
		local name
		if i == 1 then
			func = Tourist.IsInKalimdor
			name = "Kalimdor"
		elseif i == 2 then
			func = Tourist.IsInEasternKingdoms
			name = "Eastern Kingdoms"
		elseif i == 3 then
			func = Tourist.IsInOutland
			name = "Outland"
		end
		if i ~= 4 then
			for k in pairs(MapData) do
				if func(Tourist, BZL[k]) then
					validate[k] = BZL[k]
				end
			end
		else
			name = "Unknown"
			for k, v in pairs(MapData) do
				if not Tourist:IsInKalimdor(BZL[k]) and not Tourist:IsInEasternKingdoms(BZL[k]) and not Tourist:IsInOutland(BZL[k]) then
					validate[k] = BZL[k]
				end
			end
		end
	
		for k,v in pairs(validate) do
			local text = v
			local low, high = Tourist:GetLevel(v)
			local r, g, b = Tourist:GetLevelColor(v)
			local levelText
			if low == 0 then
				levelText = ""
			elseif low == high then
				levelText = (" |cff%02x%02x%02x[%d]|r"):format(r * 255, g * 255, b * 255, high)
			else
				levelText = (" |cff%02x%02x%02x[%d-%d]|r"):format(r * 255, g * 255, b * 255, low, high)
			end
			local r, g, b = Tourist:GetFactionColor(v)
			local complex = Tourist:GetComplex(v)
			if complex then
				text = complex .. " - " .. text
			end
			text = ("|cff%02x%02x%02x%s|r%s"):format(r*255, g*255, b*255, text, levelText)
			local groupSize = Tourist:GetInstanceGroupSize(v)
			if groupSize > 0 then
				text = text .. " " .. L["%d-man"]:format(groupSize)
			end
			validate[k] = text
		end
	
		if next(validate) then
			local lname = i == 4 and UNKNOWN or BZL[name]
			Cartographer.gotoOptions.args.Instances.args[name] = {
				name = lname,
				desc = lname,
				type = 'text',
				get = function()
					return Cartographer:GetCurrentInstance()
				end,
				set = "ShowInstance",
				validate = validate,
				handler = self
			}
		end
	end
end

function Cartographer_InstanceMaps:SetMapToCurrentZone()
	local zoneText = GetRealZoneText()
	if zoneText == BZL["Tempest Keep"] then
		zoneText = BZL["The Eye"]
	end
	if IsInInstance() and BZR[zoneText] and MapData[BZR[zoneText]] then
		self:ShowInstance(BZR[zoneText])
	else
		self:HideInstanceFrame()
		return self.hooks.SetMapToCurrentZone()
	end
end

function Cartographer_InstanceMaps:ShowInstanceFrame()
	if not CartographerInstanceFrame.init then
		CartographerInstanceFrame.init = true
		CartographerInstanceFrame:SetPoint("CENTER", WorldMapButton, "CENTER")
		CartographerInstanceFrame:SetWidth(WorldMapButton:GetWidth())
		CartographerInstanceFrame:SetHeight(WorldMapButton:GetHeight())
		CartographerInstanceFrame:Hide()
		CartographerInstanceFrame:RegisterForClicks("LeftButtonUp", "RightButtonUp")
		CartographerInstanceFrame:SetScript("OnClick", function()
			if arg1 == "RightButton" then
				local zone = BZL[Cartographer:GetCurrentInstance()]
				if Tourist:IsInKalimdor(zone) then
					SetMapZoom(1)
				elseif Tourist:IsInEasternKingdoms(zone) then
					SetMapZoom(2)
				elseif Tourist:IsInOutland(zone) then
					SetMapZoom(3)
				else
					SetMapZoom(0)
				end
			end
		end)
		local bgf = CreateFrame("Frame", nil, WorldMapFrame)
		local bg = bgf:CreateTexture(nil, "BACKGROUND")
		CartographerInstanceFrame.backgroundframe = bgf
		bgf:Hide()
		CartographerInstanceFrame.background = bg
		bg:SetTexture(0,0,0)
		bg:SetPoint("CENTER", CartographerInstanceFrame, "CENTER")
		bg:SetWidth(CartographerInstanceFrame:GetWidth())
		bg:SetHeight(CartographerInstanceFrame:GetHeight())
		Cartographer:RegisterInstanceWorldMapButton(CartographerInstanceFrame)
	end
	if CartographerInstanceFrame:IsShown() then
		return
	end
	CartographerInstanceFrame:Show()
	CartographerInstanceFrame.backgroundframe:Show()
	WorldMapDetailFrame:Hide()
	WorldMapButton:Hide()
	ShowWorldMapArrowFrame(nil)
	if CartographerLookNFeelOverlayHolder then CartographerLookNFeelOverlayHolder:DisableDrawLayer("ARTWORK") end	-- Forcibly hide ALL map overlays. Just hiding them individually does not work since they get re-shown when we get new map events (i.e. due to zoning).
end

function Cartographer_InstanceMaps:HideInstanceFrame()
	Cartographer:SetCurrentInstance(nil)
	if not CartographerInstanceFrame or not CartographerInstanceFrame:IsShown() then
		return
	end
	CartographerInstanceFrame:Hide()
	CartographerInstanceFrame.backgroundframe:Hide()
	WorldMapDetailFrame:Show()
	WorldMapButton:Show()
	ShowWorldMapArrowFrame(1)
	if CartographerLookNFeelOverlayHolder then CartographerLookNFeelOverlayHolder:EnableDrawLayer("ARTWORK") end
end

local cos, sin, abs = cos, sin, math.abs
local function smallRotate(angle, x, y)
	local A = cos(angle)
	local B = sin(angle)
	return x * A - y * B, x * B + y * A
end

local function rotate(angle)
	local A = cos(angle)
	local B = sin(angle)
	local ULx, ULy = -0.5 * A - -0.5 * B, -0.5 * B + -0.5 * A
	local LLx, LLy = -0.5 * A - 0.5 * B, -0.5 * B + 0.5 * A
	local URx, URy = 0.5 * A - -0.5 * B, 0.5 * B + -0.5 * A
	local LRx, LRy = 0.5 * A - 0.5 * B, 0.5 * B + 0.5 * A
	return ULx+0.5, ULy+0.5, LLx+0.5, LLy+0.5, URx+0.5, URy+0.5, LRx+0.5, LRy+0.5
end

local initializeMapData
local num_tiles = 0
function Cartographer_InstanceMaps:ShowInstance(realZone)
	if not MapData[realZone] then
		return
	end
	local zone = BZL[realZone]
--[[	if Tourist:IsInKalimdor(zone) then
		SetMapZoom(1, 1)
	elseif Tourist:IsInEasternKingdoms(zone) then
		SetMapZoom(2, 1)
	elseif Tourist:IsInOutland(zone) then
		SetMapZoom(3, 1)
	else
		SetMapZoom(0)
	end
	]]
	if initializeMapData(realZone) then
		return
	end
	Cartographer_InstanceMaps:ShowInstanceFrame()
	Cartographer:SetCurrentInstance(realZone)
	
	local map = MapData[realZone]
	
	local angle = Rotations[realZone] or 0
	angle = angle - 90
	local ULx, ULy, LLx, LLy, URx, URy, LRx, LRy = rotate(angle)
	
	for i,v in ipairs(map) do
		local tex
		if i > num_tiles then
			num_tiles = num_tiles + 1
			tex = CartographerInstanceFrame:CreateTexture("CartographerInstanceFrameTexture" .. i, "ARTWORK")
			CartographerInstanceFrame[i] = tex
		else
			tex = CartographerInstanceFrame[i]
		end
		local file, x, y, w, h = unpack(v)
		tex:SetTexture("textures\\Minimap\\" .. file)
		local A, B = abs(cos(angle)), abs(sin(angle))
		w, h = w*A + h*B, w*B + h*A
		tex:SetWidth(w)
		tex:SetHeight(h)
		tex:SetPoint("CENTER", CartographerInstanceFrame, "CENTER", smallRotate(angle, x, y))
		tex:SetTexCoord(ULx, ULy, LLx, LLy, URx, URy, LRx, LRy)
		tex:Show()
	end
	for i = #map+1, num_tiles do
		local tex = CartographerInstanceFrame[i]
		tex:SetTexture(nil) -- get rid of memory
		tex:Hide()
	end
end

local math_floor = math.floor
local function unpackfloat(D, C, B, A)
	local negative = A >= 128 and -1 or 1
	local exponent = 2*(A%128) + math_floor(B/128) - 127
	local mantissa = 1 + (65536*(B%128) + 256*C + D) / 2^23
	return negative * 2^exponent * mantissa
end

local widthData, heightData
local initialized = {}
local intermediateInitializeMapData
local realInitializeMapData
local maxNum
function initializeMapData(zone)
	if initialized[zone] then
		return
	end
	if widthData or heightData then
		return true
	end
	widthData, heightData = {}, {}
	local s = MapData[zone]
	local compressed = type(s) == "string"
	for i = 1, num_tiles do
		CartographerInstanceFrame[i]:SetWidth(0)
		CartographerInstanceFrame[i]:SetHeight(0)
		CartographerInstanceFrame[i]:Hide()
	end
	for i = 1, compressed and s:len()/28 or #s do
		local tex
		if not compressed then
			tex = s[i][1]
		else
			local offset = 28*(i-1)
			tex = ("%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"):format(s:byte(offset + 1, offset + 16))
		end
		if num_tiles < i then
			num_tiles = i
			CartographerInstanceFrame[i] = CartographerInstanceFrame:CreateTexture("CartographerInstanceFrameTexture" .. i, "ARTWORK")
		end
		CartographerInstanceFrame[i]:SetTexture("textures\\Minimap\\" .. tex)
	end
	maxNum = compressed and s:len()/28 or #s
	Cartographer_InstanceMaps:AddRepeatingTimer("Cartographer_InstanceMaps-initializeMapData", 0, intermediateInitializeMapData, zone)
	return intermediateInitializeMapData(zone)
end
function intermediateInitializeMapData(zone)
	local good = true
	for i = 1, maxNum do
		if CartographerInstanceFrame[i]:GetWidth() == 0 then
			good = false
			break
		end
	end
	if good then
		for i = 1, maxNum do
			widthData[i] = CartographerInstanceFrame[i]:GetWidth()
			heightData[i] = CartographerInstanceFrame[i]:GetHeight()
		end
		Cartographer_InstanceMaps:RemoveTimer("Cartographer_InstanceMaps-initializeMapData")
		return realInitializeMapData(zone)
	end
	return true
end
function realInitializeMapData(zone)
	initialized[zone] = true
	if num_tiles == 0 then
		num_tiles = 1
		CartographerInstanceFrame[1] = CartographerInstanceFrame:CreateTexture("CartographerInstanceFrameTexture1", "ARTWORK")
	end
	local left, right, top, bottom = nil
	local floors = Floors[zone]
	local z_axis = floors and {}
	local s = MapData[zone]
	local compressed = type(s) == "string"
	if compressed then
		MapData[zone] = {}
	end
	for i = 1, compressed and s:len()/28 or #s do
		local v
		local tex, x, y, z
		if not compressed then
			v = s[i]
			tex, x, y, z = v[1], v[2], v[3], v[4]
		else
			local offset = 28*(i-1)
			tex = ("%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x"):format(s:byte(offset + 1, offset + 16))
			x = unpackfloat(s:byte(offset + 17, offset + 20))
			y = unpackfloat(s:byte(offset + 21, offset + 24))
			z = unpackfloat(s:byte(offset + 25, offset + 28))
			v = {tex, 0, 0, 0, 0}
			MapData[zone][i] = v
		end
		if z_axis then
			z_axis[i] = z
		end
		local width = widthData[i]
		local height = heightData[i]
		v[4] = width
		v[5] = height
		local left_p = x
		local bottom_p = y
		local right_p = left_p + width
		local top_p = bottom_p + height
		v[2] = left_p + width/2
		v[3] = bottom_p + height/2
		if not left or left_p < left then
			left = left_p
		end
		if not bottom or bottom_p < bottom then
			bottom = bottom_p
		end
		if not right or right_p > right then
			right = right_p
		end
		if not top or top_p > top then
			top = top_p
		end
	end
	widthData = nil
	heightData = nil
	if compressed then
		MapData[zone] = { unpack(MapData[zone]) } -- fun hack to make it smaller.
	end
	local map_width = right - left
	local map_height = top - bottom
	
	local x_p = left + map_width/2
	local y_p = bottom + map_height/2
	local deg = Rotations[zone] or 0
	local A, B = abs(cos(deg)), abs(sin(deg))
	local scale_x = (A * map_width + B * map_height) / (980 * 2/3)
	local scale_y = (B * map_width + A * map_height) / 980
	local scale = math.max(scale_x, scale_y)
	
	for i,v in ipairs(MapData[zone]) do
		v[2] = v[2] - x_p
		v[3] = v[3] - y_p
		v[2] = v[2] / scale
		v[3] = v[3] / scale
		v[4] = v[4] / scale
		v[5] = v[5] / scale
	end
	
	if floors then
		if #floors+1 == 2 then
			for i,v in ipairs(MapData[zone]) do
				if z_axis[i] < floors[1] then
					v[3] = v[3] - 490
				else
					v[3] = v[3] + 490
				end
				v[2] = v[2] / 2
				v[3] = v[3] / 2
				v[4] = v[4] / 2
				v[5] = v[5] / 2
			end
		elseif #floors+1 == 3 then
			for i,v in ipairs(MapData[zone]) do
				if z_axis[i] < floors[1] then
					v[2] = v[2] - 490 * 2/3
					v[3] = v[3] - 490
				elseif z_axis[i] < floors[2] then
					v[2] = v[2] - 490 * 2/3
					v[3] = v[3] + 490
				else
					v[2] = v[2] + 490 * 2/3
				end
				v[2] = v[2] / 2
				v[3] = v[3] / 2
				v[4] = v[4] / 2
				v[5] = v[5] / 2
			end
		elseif #floors+1 == 4 then
			for i,v in ipairs(MapData[zone]) do
				if z_axis[i] < floors[1] then
					v[2] = v[2] - 490 * 2/3
					v[3] = v[3] - 490
				elseif z_axis[i] < floors[2] then
					v[2] = v[2] - 490 * 2/3
					v[3] = v[3] + 490
				elseif z_axis[i] < floors[3] then		
					v[2] = v[2] + 490 * 2/3
					v[3] = v[3] - 490
				else
					v[2] = v[2] + 490 * 2/3
					v[3] = v[3] + 490
				end
				v[2] = v[2] / 2
				v[3] = v[3] / 2
				v[4] = v[4] / 2
				v[5] = v[5] / 2
			end
		end
		Floors[zone] = nil
	end
	Cartographer_InstanceMaps:ShowInstance(zone)
	Dewdrop:Refresh(1)
	Dewdrop:Refresh(2)
	Dewdrop:Refresh(3)
	Dewdrop:Refresh(4)
	Dewdrop:Refresh(5)
end

function Cartographer_InstanceMaps:SetMapZoom()
	self:HideInstanceFrame()
end
