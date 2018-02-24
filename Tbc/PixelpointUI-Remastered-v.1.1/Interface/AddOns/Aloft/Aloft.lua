---------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("Aloft")
local SML = AceLibrary("SharedMedia-1.0")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Aloft"] = true,

	["Show Nameplates"] = true,
	["Show nameplates for neutral or hostile units"] = true,
	["Show Friendly Nameplates"] = true,
	["Show nameplates for friendly units"] = true,
	
	["Data Options"] = true,
	["Data options"] = true,

	["Load Options"] = true,
	["Load options for Aloft modules"] = true,

	["Unable to determine module providing data: "] = true,
	["Internal error: Dependency list not resolved - cyclic dependency?"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Aloft"] = "Aloft",

	["Show Nameplates"] = "이름표 표시",
	["Show nameplates for neutral or hostile units"] = "중립적 혹은 적대적 대상에 대한 이름표를 표시합니다.",
	["Show Friendly Nameplates"] = "우호적 이름표 표시",
	["Show nameplates for friendly units"] = "우호적 대상에 대한 이름표를 표시합니다.",
	
	["Data Options"] = "데이터 설정",
	["Data options"] = "데이터에 대한 설정입니다.",

	["Load Options"] = "불러오기 설정",
	["Load options for Aloft modules"] = "Aloft 모듈들에 대한 불러오기 설정입니다.",

	["Unable to determine module providing data: "] = "데이터를 위한 모듈을 결정할 수 없습니다: ",
	["Internal error: Dependency list not resolved - cyclic dependency?"] = "내부적 오류: 목록 의존성이 해결되지 않았습니다 - 순환적인 의존성?",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Aloft"] = "Aloft",

	["Show Nameplates"] = "顯示名牌",
	["Show nameplates for neutral or hostile units"] = "顯示中立或敵對單位的名牌",
	["Show Friendly Nameplates"] = "顯示友好名牌",
	["Show nameplates for friendly units"] = "顯示友好單位的名牌",
	
	["Data Options"] = "資料選項",
	["Data options"] = "資料選項",

	["Load Options"] = "載入選項",
	["Load options for Aloft modules"] = "Aloft 模組的載入選項",

	["Unable to determine module providing data: "] = "不能測定模組。資料: ",
	["Internal error: Dependency list not resolved - cyclic dependency?"] = "內部錯誤: 循環倚靠?",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Aloft"] = "Aloft",

	["Show Nameplates"] = "显示姓名板",
	["Show nameplates for neutral or hostile units"] = "显示中立方或敌对方单位的姓名板",
	["Show Friendly Nameplates"] = "显示友好",
	["Show nameplates for friendly units"] = "显示友好方单位的姓名板",
	
	["Data Options"] = "信息设置",
	["Data options"] = "信息设置",

	["Load Options"] = "读入设置",
	["Load options for Aloft modules"] = "Aloft模块的加载设置",

	["Unable to determine module providing data: "] = "不能测定模块的资料",
	["Internal error: Dependency list not resolved - cyclic dependency?"] = "内部错误：无法确定需求设置，需求循环？",
} end)

-----------------------------------------------------------------------------

Aloft = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0", "AceModuleCore-2.0", "AceHook-2.1")
Aloft.version = "r"..("$Revision: 416 $"):match("%d+")
Aloft.Debug = (UnitName("player") == "Roartindon") and function(_, text) ChatFrame3:AddMessage(text) end or function() end
Aloft:RegisterDB("AloftDB")

-----------------------------------------------------------------------------

Aloft.Options = 
{
	handler = Aloft,
	type = 'group',
	args = 
	{
		show =
		{
			type = 'toggle',
			name = L["Show Nameplates"],
			desc = L["Show nameplates for neutral or hostile units"],
			get = function() return NAMEPLATES_ON end,
			set = function(v) if v then ShowNameplates() else HideNameplates() end NAMEPLATES_ON = v end,
			order = 1
		},
		showFriendly =
		{
			type = 'toggle',
			name = L["Show Friendly Nameplates"],
			desc = L["Show nameplates for friendly units"],
			get = function() return FRIENDNAMEPLATES_ON end,
			set = function(v) if v then ShowFriendNameplates() else HideFriendNameplates() end FRIENDNAMEPLATES_ON = v end,
			order = 2
		},
		moduleSpacer  = 
		{
			type = 'header',
			order = 4,
		},
		dataSpacer = 
		{
			type = 'header',
			order = 500,
		},
		data =
		{
			type = 'group',
			name = L["Data Options"],
			desc = L["Data options"],
			order = 600,
			disabled = function() return not next(Aloft.Options.args.data.args) end,
			args = { },
		}
	},
}

Aloft:RegisterChatCommand("/aloft", Aloft.Options)

-----------------------------------------------------------------------------

Aloft.DataAvailableMethods = { }

-----------------------------------------------------------------------------

local numberOfWorldChildren = 0
local nameplateList = { }
local noTargetNameplate = false
local nameToNameplateMap = { }
local visibleNameplateList = { }
local dataSourceList = { }

-- Since pairs and select are used often and in loops, make them upvalues rather than a global lookup
local pairs, select = pairs, select

-----------------------------------------------------------------------------

local function UpdateAloftData(aloftData)
	for i = 1, #dataSourceList do
		dataSourceList[i]:UpdateData(aloftData)
	end
end

local function UpdateAloftTypeData(aloftData, healthBar)
	aloftData.originalHealthBarR, aloftData.originalHealthBarG, aloftData.originalHealthBarB, a = healthBar:GetStatusBarColor()
	local r, g, b = floor(aloftData.originalHealthBarR * 256), floor(aloftData.originalHealthBarG*256), floor(aloftData.originalHealthBarB*256)

	if r == 255 and g == 0 and b == 0 then
		aloftData.type = "hostile"
	elseif r == 0 and g == 0 and b == 255 then
		aloftData.type = "friendlyPlayer"
	elseif r == 0 and g == 255 and b == 0 then
		aloftData.type = "friendlyNPC"
	elseif r == 255 and g == 255 and b == 0 then
		aloftData.type = "neutral"
	else
--		Aloft:Debug("rgb = "..r.."."..g.."."..b)
	end
end

-----------------------------------------------------------------------------

function Aloft:LoadOptions()
	if Aloft.Options.args.loadOptions then
		for i = 1,GetNumAddOns() do
			if GetAddOnMetadata(i, "X-Aloft-Options") then
				LoadAddOn(i)
			end
		end
		Aloft.Options.args.loadOptions = nil
		self:TriggerEvent("Aloft:LoadOptions")
		collectgarbage('collect')
	end
end

-----------------------------------------------------------------------------

function Aloft:OnInitialize()
	for i = 1,GetNumAddOns() do
		if GetAddOnMetadata(i, "X-Aloft-Options") then
			Aloft.Options.args.loadOptions =
			{
				type = 'execute',
				name = L["Load Options"],
				desc = L["Load options for Aloft modules"],
				func = function() Aloft:LoadOptions() end,
				order = 5
			}
			break
		end
	end
end

function Aloft:OnEnable()
	for _, module in self:IterateModules() do
		self:ToggleModuleActive(module, true)
	end

	self:ScheduleRepeatingEvent("AloftUpdate", self.Update, 0.2, self)
	self:RegisterEvent("PLAYER_TARGET_CHANGED", function() noTargetNameplate = false end)

	self:DetermineDataSources()

	-- Reinstate hooks and update data - this is for when Aloft is disbaled, and later reenabled
	for aloftData in self:IterateNameplates() do
		self:HookNameplate(aloftData)
		if aloftData:IsShown() then
			visibleNameplateList[aloftData] = true
			self:OnNameplateShow(aloftData)
		end
	end
end

function Aloft:OnDisable()
	self:CancelScheduledEvent("AloftUpdate")

	for aloftData in self:IterateVisibleNameplates() do
		self:TriggerEvent("Aloft:OnNameplateHide", aloftData)
	end
	
	for _, module in self:IterateModules() do
		self:ToggleModuleActive(module, false)
		module:DisableDataSource()
	end
	
	self:RedisplayNameplates()
	self:RedisplayFriendlyNameplates()
end

function Aloft:OnProfileEnable()
	for aloftData in self:IterateVisibleNameplates() do
		self:TriggerEvent("Aloft:OnNameplateHide", aloftData)
	end

	for _, module in self:IterateModules() do
		if module.OnInitialize then
			module:OnInitialize()
		end
	end

	for _, module in self:IterateModules() do
		if module.OnEnable then
			module:OnEnable()
		end
	end

	self:DetermineDataSources()

	for aloftData in self:IterateVisibleNameplates() do
		UpdateAloftData(aloftData)
		self:TriggerEvent("Aloft:OnNameplateShow", aloftData)
	end
end

-----------------------------------------------------------------------------

local function IsNameplateFrame(frame)
	if frame:GetName() then
		return false
	end

	local overlayRegion = frame:GetRegions()
	if not overlayRegion or overlayRegion:GetObjectType() ~= "Texture" or overlayRegion:GetTexture() ~= "Interface\\Tooltips\\Nameplate-Border" then
		return false
	end
	
	return true
end

function Aloft:ProcessChildFrames(...)
	for i = 1, select('#', ...) do
		local frame = select(i, ...)
		if not frame.aloftData and IsNameplateFrame(frame) then 
			self:SetupNameplate(frame)
		end
	end
end

function Aloft:Update()
	local newNumberOfWorldChildren = WorldFrame:GetNumChildren()
	if newNumberOfWorldChildren ~= numberOfWorldChildren then
		numberOfWorldChildren = newNumberOfWorldChildren
		self:ProcessChildFrames(WorldFrame:GetChildren())
	end
	
	for aloftData in pairs(visibleNameplateList) do	
		local healthBar = aloftData.healthBar
		local r, g, b, a = healthBar:GetStatusBarColor()

		-- An awful awful update routine to stop the game overwriting our colors sporadically
		if r ~= aloftData.healthBarR or g ~= aloftData.healthBarG or b ~= aloftData.healthBarB or a ~= aloftData.healthBarA then
			UpdateAloftTypeData(aloftData, healthBar)
			self:TriggerEvent("Aloft:OnHealthBarColorChanged", aloftData)
		end		
	end
end

-----------------------------------------------------------------------------

function Aloft:IterateNameplates()
	return pairs(nameplateList)
end

function Aloft:IterateVisibleNameplates()
	return pairs(visibleNameplateList)
end

-----------------------------------------------------------------------------

local dataNameToModuleMap = { }
local moduleToModuleListMap = { }
local unavailableModuleList = { }

function Aloft:UpdateDataNameToModuleMap(module, ...)
	if not ... then return end
	for i = 1,select('#', ...) do
--		Aloft:Debug(string.format("Added data module: %s (%s)", tostring(select(i, ...)), tostring(module)))
		dataNameToModuleMap[select(i, ...)] = module
	end
	if not module:IsDataAvailable() then
--		Aloft:Debug(string.format("Flagging %s as unavailable\n", tostring(module)))
		unavailableModuleList[module] = true
	end
end

function Aloft:UpdateModuleToModuleListMap(module, ...)
	if not ... then return end
	
	local moduleList = { }
	moduleToModuleListMap[module] = moduleList
	
	for i = 1,select('#', ...) do
		local dataName = select(i, ...)
		local requiredModule = dataNameToModuleMap[dataName]
--		Aloft:Debug(string.format("%s requires %s", tostring(module), dataName))
		if requiredModule then
			moduleList[requiredModule] = true
		else
			self:Print(L["Unable to determine module providing data: "]..dataName)
		end
	end
end

function Aloft:RemoveRequiredModuleFromModuleToModuleListMap(requiredModule)
	for module,moduleList in pairs(moduleToModuleListMap) do
		moduleList[requiredModule] = nil
	end
end

function Aloft:DetermineDataSources()
	-- 1. Iterate all modules, flag them to be disabled and gather provided data
	for _,module in self:IterateModules() do
		module.needToDisable = true
		self:UpdateDataNameToModuleMap(module, module:ProvidesData())
	end

	-- Iterate all of the modules for data that they require, resolve them to the modules that provide them
	for name,module in self:IterateModules() do
		self:UpdateModuleToModuleListMap(module, module:RequiresData())
	end

	-- Clear our old data sources
	for i = 1, #dataSourceList do
		dataSourceList[i] = nil
	end

	-- Iterate to remove purely data modules
	local iterationCount = 0	-- A safety factor
	local requiredModules = { }
	while iterationCount < 100 and next(moduleToModuleListMap) do
		for module, moduleList in pairs(moduleToModuleListMap) do
			for requiredModule in pairs(moduleList) do
				requiredModules[requiredModule] = true
			end
		end
		local moduleRemoved = false
		for module, _ in pairs(moduleToModuleListMap) do
			if module:IsPurelyData() and not requiredModules[module] then
--				Aloft:Debug("Not required: "..tostring(module))
				moduleToModuleListMap[module] = nil
				self:RemoveRequiredModuleFromModuleToModuleListMap(module)
				moduleRemoved = true
			end
		end
		if not moduleRemoved then break end
		for k in pairs(requiredModules) do
			requiredModules[k] = nil
		end
		iterationCount = iterationCount + 1
	end

	-- Iterate our moduleToModuleListMap 
	iterationCount = 0	-- A safety factor
	while iterationCount < 100 and next(moduleToModuleListMap) do
		for module, moduleList in pairs(moduleToModuleListMap) do
			for requiredModule in pairs(moduleList) do
				if unavailableModuleList[requiredModule] then
--					Aloft:Debug(string.format("%s is unavailable. Flagging %s as unavailable", tostring(requiredModule), tostring(module)))
					unavailableModuleList[module] = true
					moduleList[requiredModule] = nil
				elseif not moduleToModuleListMap[requiredModule] then
					-- The required module isn't dependent on anything! Put it into our dataSourceList and remove from all modules that request it
					table.insert(dataSourceList, requiredModule)
					requiredModule:EnableDataSource()
					requiredModule.needToDisable = nil
--					Aloft:Debug(#dataSourceList..": "..tostring(requiredModule))

					self:RemoveRequiredModuleFromModuleToModuleListMap(requiredModule)
				end
			end
			if not next(moduleList) or unavailableModuleList[module] then
				moduleToModuleListMap[module] = nil
			end
		end
		iterationCount = iterationCount + 1
	end

	if next(moduleToModuleListMap) then
		self:Print(L["Internal error: Dependency list not resolved - cyclic dependency?"])
		for k in pairs(moduleToModuleListMap) do
			moduleToModuleListMap[k] = nil
		end
	end
	-- Empty our maps
	for k in pairs(dataNameToModuleMap) do
		dataNameToModuleMap[k] = nil
	end
	for k in pairs(unavailableModuleList) do
		unavailableModuleList[k] = nil
	end

	for _,module in self:IterateModules() do
		if module.needToDisable then
			module:DisableDataSource()
		end
	end
	
	for aloftData in self:IterateVisibleNameplates() do
		UpdateAloftData(aloftData)
	end
end

-----------------------------------------------------------------------------

function Aloft:GetTargetNameplate()
	if noTargetNameplate then return end

	-- Do quick lookup first
	local unitName = UnitName("target")
	if not unitName then return end
	
	local aloftData = nameToNameplateMap[unitName]
	if aloftData and aloftData.nameplateFrame:GetAlpha() == 1 then
		return aloftData
	end
	
	-- Do nameplate search
	for aloftData in pairs(visibleNameplateList) do
		if aloftData.nameplateFrame:GetAlpha() == 1 then
			-- And store it as our future reference
			nameToNameplateMap[unitName] = aloftData
			return aloftData
		end
	end
	noTargetNameplate = true
	return nil
end

function Aloft:GetNameplate(unitName)
	return nameToNameplateMap[unitName]
end

function Aloft:GetUnitNameplate(unitid)
	local unitName = UnitName(unitid)
	if unitName then
		return self:GetNameplate(unitName)
	end
end

-----------------------------------------------------------------------------

function Aloft:OnHealthBarValueChanged(aloftData, value, maxValue)
	if aloftData.nameplateFrame:IsShown() then
		aloftData.healthBarValue = value
		aloftData.healthBarMaxValue = maxValue
		self:TriggerEvent("Aloft:OnHealthBarValueChanged", aloftData)
	end
end

function Aloft:OnNameplateShow(aloftData)
	-- When a nameplate is first shown, grab some data about it
	local nameTextRegion = aloftData.nameTextRegion
	local newNameText = self.hooks[nameTextRegion].GetText(nameTextRegion)
	if aloftData.nameTextRegionText ~= newNameText then
		nameToNameplateMap[aloftData.name] = nil
		aloftData.name = newNameText
		nameToNameplateMap[aloftData.name] = aloftData
		aloftData.nameTextRegionText = name
	end

	local healthBar = aloftData.healthBar
	aloftData.healthBarValue = healthBar:GetValue()
	_, aloftData.healthBarMaxValue = healthBar:GetMinMaxValues()

	aloftData.isBoss = aloftData.bossIconRegion:IsShown()
	local levelTextRegion = aloftData.levelTextRegion
	if levelTextRegion:IsShown() then
		aloftData.level = tonumber(levelTextRegion:GetText()) or nil
		aloftData.levelTextR, aloftData.levelTextG, aloftData.levelTextB = levelTextRegion:GetTextColor()
	else
		aloftData.level = nil
		aloftData.levelTextR, aloftData.levelTextG, aloftData.levelTextB = 1, 1, 1
	end

	UpdateAloftTypeData(aloftData, healthBar)
	UpdateAloftData(aloftData)

	self:TriggerEvent("Aloft:OnNameplateShow", aloftData)
end

function Aloft:OnNameplateHide(aloftData)
	self:TriggerEvent("Aloft:OnNameplateHide", aloftData)

	nameToNameplateMap[aloftData.name] = nil
	aloftData.name = "[invalid]"
	aloftData.nameTextRegionText = nil
	aloftData.level = nil
	aloftData.type = "unknown"
end

function Aloft:OnCastBarValueChanged(aloftData, castBar)
	if castBar:IsShown() then
		self:TriggerEvent("Aloft:OnCastBarValueChanged", aloftData)
	end
end

function Aloft:OnCastBarShow(aloftData, castBar)
	self:TriggerEvent("Aloft:OnCastBarShow", aloftData)
end

function Aloft:OnCastBarHide(aloftData)
	self:TriggerEvent("Aloft:OnCastBarHide", aloftData)
end

-----------------------------------------------------------------------------

function Aloft:OnNameplateShowScript(this)
	local aloftData = this.aloftData
	noTargetNameplate = false
	visibleNameplateList[aloftData] = true
	self:OnNameplateShow(aloftData)
	self.hooks[this]["OnShow"](this)
end

function Aloft:OnNameplateHideScript(this)
	local aloftData = this.aloftData
	self:OnNameplateHide(aloftData)
	visibleNameplateList[aloftData] = nil
	self.hooks[this]["OnHide"](this)
end

function Aloft:OnHealthBarValueChangedScript(this, value)
	local _, maxValue = this:GetMinMaxValues()
	self:OnHealthBarValueChanged(this.aloftData, value, maxValue)
	self.hooks[this]["OnValueChanged"](this, value)
end

function Aloft:OnCastBarValueChangedScript(this, value)
	self:OnCastBarValueChanged(this.aloftData, this)
	self.hooks[this]["OnValueChanged"](this, value)
end

function Aloft:OnCastBarShowScript(this)
	self:OnCastBarShow(this.aloftData, this)
	self.hooks[this]["OnShow"](this)
end

function Aloft:OnCastBarHideScript(this)
	self:OnCastBarHide(this.aloftData)	
	self.hooks[this]["OnHide"](this)
end

-----------------------------------------------------------------------------

function Aloft:SetHealthBarColor(this, r, g, b, a)
	local aloftData = this.aloftData
	self.hooks[this].SetStatusBarColor(this, r, g, b, a)
	-- We read it back, because rounding seems to kick in and prevent them from being exactly what we sent..
	aloftData.healthBarR, aloftData.healthBarG, aloftData.healthBarB, aloftData.healthBarA = this:GetStatusBarColor()
end

function Aloft:SetNameTextRegionText(this, text)
	local aloftData = this.aloftData
	aloftData.nameTextRegionText = text
	self.hooks[this].SetText(this, text)
end

function Aloft:GetLevelTextFrameText(this)
	local level = this.aloftData.level
	if level then return level end
	return self.hooks[this].GetText(this)
end

function Aloft:GetNameTextRegionText(this)
	local name = this.aloftData.name
	if name ~= "[invalid]" then return name end
	return self.hooks[this].GetText(this)
end

-----------------------------------------------------------------------------

local function AloftDataIsTarget(aloftData) return aloftData.nameplateFrame:GetAlpha() == 1 and aloftData.name == UnitName("target") end
local function AloftDataIsShown(aloftData) return aloftData.nameplateFrame:IsShown() end

local function AloftDataCreateFontString(aloftData)	return aloftData.nameplateFrame:CreateFontString(nil, "OVERLAY") end
local function AloftDataCreateTexture(aloftData) return aloftData.nameplateFrame:CreateTexture(nil, "OVERLAY") end

function Aloft:SetupNameplate(frame)
	local aloftData = { type = "unknown", name = "[invalid]", IsTarget = AloftDataIsTarget, IsShown = AloftDataIsShown, CreateFontString = AloftDataCreateFontString, CreateTexture = AloftDataCreateTexture }
	frame.aloftData = aloftData
	noTargetNameplate = false
	nameplateList[aloftData] = true
	visibleNameplateList[aloftData] = true

	local overlayRegion, castBarOverlayRegion, spellIconRegion, highlightRegion, nameTextRegion, levelTextRegion, bossIconRegion, raidIconRegion = frame:GetRegions()
	local healthBar, castBar = frame:GetChildren()

	-- Reference all of these now
	aloftData.healthBar = healthBar
	aloftData.castBar = castBar
	
	aloftData.overlayRegion = overlayRegion
	aloftData.castBarOverlayRegion = castBarOverlayRegion
	aloftData.spellIconRegion = spellIconRegion
	aloftData.highlightRegion = highlightRegion
	aloftData.nameTextRegion = nameTextRegion
	aloftData.levelTextRegion = levelTextRegion
	aloftData.bossIconRegion = bossIconRegion
	aloftData.raidIconRegion = raidIconRegion
	
	aloftData.nameplateFrame = frame

	healthBar.aloftData = aloftData
	castBar.aloftData = aloftData
	nameTextRegion.aloftData = aloftData
	levelTextRegion.aloftData = aloftData

	self:HookNameplate(aloftData)

	self:TriggerEvent("Aloft:SetupFrame", aloftData)

	self:OnNameplateShow(aloftData)
	if castBar:IsShown() then
		self:OnCastBarShow(aloftData, castBar)
	end
end

function Aloft:HookNameplate(aloftData)
	local nameplateFrame = aloftData.nameplateFrame
	self:HookScript(nameplateFrame, "OnShow", "OnNameplateShowScript")
	self:HookScript(nameplateFrame, "OnHide", "OnNameplateHideScript")

	local healthBar = aloftData.healthBar
	self:HookScript(healthBar, "OnValueChanged", "OnHealthBarValueChangedScript")
	self:Hook(healthBar, "SetStatusBarColor", "SetHealthBarColor", true)

	local castBar = aloftData.castBar
	self:HookScript(castBar, "OnShow", "OnCastBarShowScript")
	self:HookScript(castBar, "OnHide", "OnCastBarHideScript")
	self:HookScript(castBar, "OnValueChanged", "OnCastBarValueChangedScript")

	local nameTextRegion = aloftData.nameTextRegion
	self:Hook(nameTextRegion, "SetText", "SetNameTextRegionText", true)
	self:Hook(nameTextRegion, "GetText", "GetNameTextRegionText", true)

	local levelTextRegion = aloftData.levelTextRegion
	self:Hook(levelTextRegion, "GetText", "GetLevelTextFrameText", true)
end

-----------------------------------------------------------------------------

function Aloft.modulePrototype:PrepareText(textFrame, data)
	textFrame:SetFont(SML:Fetch("font", data.font), data.fontSize, data.outline)
	if data.shadow then
		textFrame:SetShadowOffset(1, -1)
	else
		textFrame:SetShadowOffset(0, 0)
	end
	if data.alignment then
		textFrame:SetJustifyH(data.alignment)
	end
	if data.color then
		textFrame:SetTextColor(unpack(data.color))
	end
end

function Aloft.modulePrototype:PlaceFrame(frame, relativeFrame, data)
	if data.enable then
		frame:ClearAllPoints()
		frame:SetPoint(data.point, relativeFrame, data.relativeToPoint, data.offsetX, data.offsetY)
		
		if data.size then
			frame:SetWidth(data.size)
			frame:SetHeight(data.size)
		else
			if data.width then
				frame:SetWidth(data.width)
			end
			if data.height then
				frame:SetWidth(data.width)
			end
		end
		frame:SetAlpha(data.alpha or 1.0)
	else
		frame:SetAlpha(0)
	end
end

-----------------------------------------------------------------------------

-- Provide these functions mainly for Visibiltiy module. ReportStatusChanges can hook them so that the log doesn't fill up
function Aloft:RedisplayNameplates()
	HideNameplates()
	self:ScheduleEvent("AloftRedisplayNameplates", ShowNameplates, 0.1)
end

function Aloft:RedisplayFriendlyNameplates()
	HideFriendNameplates()
	self:ScheduleEvent("AloftRedisplayFriendNameplates", ShowFriendNameplates, 0.1)
end

-----------------------------------------------------------------------------

function Aloft.modulePrototype:RequiresData()
	-- eg. return "class", "isPetName", "isGuildMember"
end

function Aloft.modulePrototype:ProvidesData()
end

function Aloft.modulePrototype:EnableDataSource()
end

function Aloft:IsDataAvailable(name)
	local dataAvailableMethod = Aloft.DataAvailableMethods[name]
	if dataAvailableMethod then
--		Aloft:Debug(string.format("%s: %s", name, dataAvailableMethod() and "true" or "false"))
		return dataAvailableMethod()
	end
	return true
end

function Aloft.modulePrototype:IsPurelyData()
	return self:ProvidesData() ~= nil
end

function Aloft.modulePrototype:IsOneOfDataListAvailable(...)
	for i=1,select('#', ...) do
		if Aloft:IsDataAvailable(select(i, ...)) then
			return true
		end
	end
	return false
end

function Aloft.modulePrototype:IsDataAvailable()
	return self:IsOneOfDataListAvailable(self:ProvidesData())
end

function Aloft.modulePrototype:RemoveAloftData(name)
	for aloftData in Aloft:IterateNameplates() do
		aloftData[name] = nil
	end
end

function Aloft.modulePrototype:RemoveProvidedData(...)
	for i=1,select('#', ...) do
		self:RemoveAloftData(select(i, ...))
	end
end

function Aloft.modulePrototype:DisableDataSource()
	local dataName = self:ProvidesData()
	if dataName then
		self:UnregisterAllEvents()
		self:CancelAllScheduledEvents()
 		if self.UnhookAll then
			self:UnhookAll()
		end
		self:RemoveProvidedData(self:ProvidesData())
	end
end

function Aloft.modulePrototype:UpdateData(aloftData)
	DEFAULT_CHAT_FRAME:AddMessage("Internal error: DataSource's UpdateData not overriden.")
end

function Aloft.modulePrototype:CancelEvent(eventName)
	if self:IsEventRegistered(eventName) then
		self:UnregisterEvent(eventName)
	end
end

function Aloft.modulePrototype:IsArrayEqual(a, b)
	if #a ~= #b then return false end
	for i=1,#a do
		if a[i] ~= b[i] then return false end
	end
	return true
end

-----------------------------------------------------------------------------
