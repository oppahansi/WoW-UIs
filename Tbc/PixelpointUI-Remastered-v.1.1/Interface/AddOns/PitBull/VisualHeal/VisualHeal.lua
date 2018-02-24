if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 68199 $"):match("%d+"))

local localization = (GetLocale() == "koKR") and {
	["Visualises healing done by you and your party/raid members directly on the unit frames."] = "유닛 프레임에 직접 자신 및 파티/공격대원에 의한 치유 결과를 시각적으로 보여줍니다.",
	["VisualHeal"] = "시각적 치유량",
	["VisualHeal options."] = "시각적 치유량의 옵션입니다.",
	["Enable Bars"] = "바 활성화",
	["Enables the VisualHeal bars when heals are incoming and/or when you heal units in this group."] = "자신이 속해 있는 그룹에서 자신이 치유를 받은 경우, 혹은 유닛을 자신이 치유한 경우에 시각적 치유량 바를 활성화합니다.",
	["Incoming Color"] = "받은 치유량 색상",
	["The color of the bar that shows incoming heals."] = "받은 치유량을 보여주는 바의 색상을 설정합니다.",
	["Outgoing Color (No overheal)"] = "치유 색상(과다 치유 미포함)",
	["The color of the bar that shows your own heals, when no overhealing is due."] = "충분히 치유하지 못한 경우에 자신의 치유량을 보여주는 바의 색상을 설정합니다.",
	["Outgoing Color (Overheal)"] = "치유 색상(과다 치유 포함)",
	["The color of the bar that shows your own heals, when full overhealing is due."] = "충분히 치유한 경우에 자신의 치유량을 보여주는 바의 색상을 설정합니다.",
	["Auto Luminance"] = "자동 밝기",
	["Automatically adjust the luminance of the color of the outgoing heal bar to max."] = "치유한 바 색상의 밝기를 최대한으로 자동으로 적용합니다.",
} or (GetLocale() == "zhCN") and {
	["Visualises healing done by you and your party/raid members directly on the unit frames."] = "将你和你小队/团队成员的治疗量以可视化形式直接显示在单位框体上。",
	["VisualHeal"] = "可视化治疗量",
	["VisualHeal options."] = "可视化治疗量的选项。",
	["Enable Bars"] = "启用计量条",
	["Enables the VisualHeal bars when heals are incoming and/or when you heal units in this group."] = "当你正在被治疗或者当你治疗别人时启用可视化治疗条。",
	["Incoming Color"] = "被别人治疗时的颜色",
	["The color of the bar that shows incoming heals."] = "当被治疗时计量条的颜色。",
	["Outgoing Color (No overheal)"] = "治疗别人时的颜色(非过量)",
	["The color of the bar that shows your own heals, when no overhealing is due."] = "当你的治疗预期为非过量治疗时计量条的颜色。",
	["Outgoing Color (Overheal)"] = "治疗别人时的颜色(过量)",
	["The color of the bar that shows your own heals, when full overhealing is due."] = "当你的治疗预期为过量治疗时计量条的颜色。",
	["Auto Luminance"] = "自动亮度",
	["Automatically adjust the luminance of the color of the outgoing heal bar to max."] = "自动调节治疗输出条的亮度到最大。",
} or (GetLocale() == "frFR") and {
	["Visualises healing done by you and your party/raid members directly on the unit frames."] = "Soins visuels faits par vous et votre groupe/raid directement sur la fenêtre d'unité.",
	["VisualHeal"] = "Soins visuels",
	["VisualHeal options."] = "Options des soins visuels.",
	["Enable Bars"] = "Activer les barrse",
	["Enables the VisualHeal bars when heals are incoming and/or when you heal units in this group."] = "Active les soins visuels quand des soins vont arriver et/ou quand vous soignez des unités dans ce groupe.",
	["Incoming Color"] = "Couleur des soins qui arrivent",
	["The color of the bar that shows incoming heals."] = "La couleur de la barre qui représente les soins qui arrivent.",
	["Outgoing Color (No overheal)"] = "Vos soins (pas de soins en trop)",
	["The color of the bar that shows your own heals, when no overhealing is due."] = "Couleur de la barre qui affiche vos soins, quand aucun soin en trop n'est fait.",
	["Outgoing Color (Overheal)"] = "Vos soins (soins en trop)",
	["The color of the bar that shows your own heals, when full overhealing is due."] = "Couleur de la barre qui affiche vos soins, lorsque la cible est déjà au maximum de sa vie.",
	["Auto Luminance"] = "Luminescence automatique",
	["Automatically adjust the luminance of the color of the outgoing heal bar to max."] = "Ajuste automatiquement la luminescence de la couleur de la barre de vos soins au maximum.",
} or (GetLocale() == "zhTW") and {
	["Visualises healing done by you and your party/raid members directly on the unit frames."] = "在友方目標框架的左(右)方顯示可視化治療量.",
	["VisualHeal"] = "可視化治療",
	["VisualHeal options."] = "可視化治療選項.",
	["Enable Bars"] = "啟用",
	["Enables the VisualHeal bars when heals are incoming and/or when you heal units in this group."] = "在接受治療或給隊伍中其它人治療時, 啟用可視化治療量.",
	["Incoming Color"] = "被治療的顏色",
	["The color of the bar that shows incoming heals."] = "顯示接受治療量的顏色.",
	["Outgoing Color (No overheal)"] = "輸出治療顏色(非溢補)",
	["The color of the bar that shows your own heals, when no overhealing is due."] = "顯示你自己的治療輸出顏色, 作用在非過量治療.",
	["Outgoing Color (Overheal)"] = "輸出治療顏色(溢補)",
	["The color of the bar that shows your own heals, when full overhealing is due."] = "顯示你自己的治療輸出顏色, 作用在過量治療.",
	["Auto Luminance"] = "自動調整亮度",
	["Automatically adjust the luminance of the color of the outgoing heal bar to max."] = "自動調整輸出治療條的亮度到最大.",
} or {}

local L = PitBull:L("PitBull-VisualHeal", localization)

local PitBull = PitBull
local PitBull_VisualHeal = PitBull:NewModule("VisualHeal", "LibRockHook-1.0")
PitBull_VisualHeal.desc = L["Visualises healing done by you and your party/raid members directly on the unit frames."]
PitBull_VisualHeal:RegisterPitBullModuleDependencies("HealthBar")
PitBull_VisualHeal:RegisterPitBullChildFrames('playerHealBar', 'incomingHealBar')
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-04-05 21:15:48 -0400 (Sat, 05 Apr 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local PitBull_HealthBar

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local playerName = UnitName("player")
local LibHealComm

function PitBull_VisualHeal:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("VisualHeal")
	PitBull:SetDatabaseNamespaceDefaults("VisualHeal", "profile", {
		incomingColor = {0.4, 0.6, 0.4, 0.75},
		outgoingColorN = {0, 1, 0, 1.00},
		outgoingColorF = {1, 0, 0, 0.65},
		autoLuminance = true,
		groups = {
			['pettarget'] = {enabled = false},
			['partytarget'] = {enabled = false},
			['maintanktarget'] = {enabled = false},
			['maintanktargettarget'] = {enabled = false},
			['mainassisttarget'] = {enabled = false},
			['mainassisttargettarget'] = {enabled = false},
			['*'] = {enabled = true},
		},
	})
end

function PitBull_VisualHeal:OnEnable()
	LibHealComm = Rock("LibHealComm-3.0", false, true)
	if not LibHealComm then
		error("PitBull_VisualHeal requires LibHealComm-3.0 to be available.")
	end
	PitBull_HealthBar = PitBull:GetModule("HealthBar")
	
	self:AddHook(PitBull_HealthBar, "UpdateHealth")
	
	LibHealComm.RegisterCallback(self, "HealComm_DirectHealStart")
	LibHealComm.RegisterCallback(self, "HealComm_DirectHealUpdate")
	LibHealComm.RegisterCallback(self, "HealComm_DirectHealStop")
	LibHealComm.RegisterCallback(self, "HealComm_HealModifierUpdate")
end

function PitBull_VisualHeal:OnDisable()
	LibHealComm.UnregisterAllCallbacks(self)
end

local maxHealthEstimate = {
	WARRIOR = 4100,
	PALADIN = 4000,
	SHAMAN = 3500,
	ROGUE = 3100,
	HUNTER = 3100,
	DRUID = 3100,
	WARLOCK = 2300,
	MAGE = 2200,
	PRIEST = 2100,
}
local function EstimateUnitHealthMax(unit)
	local _, class = UnitClass(unit)
	local level = UnitLevel(unit) or 60
	
	return (maxHealthEstimate[class] or 4000) * level / 60
end

local playerIsCasting = false
local playerHealingTargetName = nil
local playerHealingSize = 0
local playerEndTime = 0

function PitBull_VisualHeal:UpdateBars(unit, frame)
	local healthBar = frame.healthBar
	local playerHealBar = frame.playerHealBar
	local incomingHealBar = frame.incomingHealBar
	local incomingHeal
	local isCastingOnThisUnit
	
	-- Bail out early if VisualHeal bars are not enabled for this frame 
	if not healthBar or not self.db.profile.groups[frame.group].enabled then
		self:OnClearUnitFrame(unit, frame)
		return
	end

	if playerIsCasting then
		isCastingOnThisUnit = playerHealingTargetName == frame:GetUnitName()
	end

	if isCastingOnThisUnit then
		incomingHeal = LibHealComm:UnitIncomingHealGet(unit, playerEndTime)
	else
		incomingHeal = select(2, LibHealComm:UnitIncomingHealGet(unit, GetTime()))
	end 
	
	-- Bail out early if nothing going on for this unit
	if not isCastingOnThisUnit and not incomingHeal then
		self:OnClearUnitFrame(unit, frame)
		return
	end

	local healModifier = LibHealComm:UnitHealModifierGet(unit)

	local unitHealthMax = UnitHealthMax(unit)
	if unitHealthMax == 100 then
		-- Estimate
		unitHealthMax = EstimateUnitHealthMax(unit)
	end

	local deficit = healthBar:GetDeficit()
	local currentPercent = healthBar:GetValue()
	
	local incomingPercent = incomingHeal and healModifier * incomingHeal / unitHealthMax or 0
	local playerPercent = isCastingOnThisUnit and healModifier * playerHealingSize / unitHealthMax or 0
	
	local frameLevel = healthBar:GetFrameLevel()
	local texture = PitBull:GetStatusBarTexture()
	local height, width = healthBar:GetHeight(), healthBar:GetWidth()
	local orientation = healthBar:GetOrientation()
	local reverse = not not healthBar:GetReverse()
	
	if incomingPercent > 0 then
		if not incomingHealBar then
			incomingHealBar = newFrame("Frame", healthBar)
			frame.incomingHealBar = incomingHealBar
			local incomingHealBar_texture = newFrame("Texture", incomingHealBar, "BACKGROUND")
			incomingHealBar.texture = incomingHealBar_texture
			incomingHealBar_texture:SetTexture(texture)
			incomingHealBar_texture:SetAllPoints(incomingHealBar)
			
			local incomingHealBar_spark = newFrame("Texture", incomingHealBar, "OVERLAY")
			incomingHealBar.spark = incomingHealBar_spark
			incomingHealBar_spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
			incomingHealBar_spark:SetBlendMode('ADD')
			if orientation ~= "VERTICAL" then
				incomingHealBar_spark:SetPoint('CENTER', incomingHealBar, reverse ~= deficit and "RIGHT" or "LEFT")
				incomingHealBar_spark:SetWidth(16)
				incomingHealBar_spark:SetHeight(height*2)
			else
				incomingHealBar_spark:SetPoint('CENTER', incomingHealBar, reverse ~= deficit and "TOP" or "BOTTOM")
				incomingHealBar_spark:SetHeight(16)
				incomingHealBar_spark:SetWidth(width*2)
				incomingHealBar_spark:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
			end
		end
		incomingHealBar:ClearAllPoints()
		incomingHealBar.texture:SetVertexColor(unpack(self.db.profile.incomingColor))
		
		if orientation ~= "VERTICAL" then
			incomingHealBar:SetWidth(width * incomingPercent)
			incomingHealBar:SetHeight(height)
			if reverse ~= deficit then
				incomingHealBar.texture:SetTexCoord(incomingPercent, 0, incomingPercent, 1, 0, 0, 0, 1)
			else
				incomingHealBar.texture:SetTexCoord(0, 0, 0, 1, incomingPercent, 0, incomingPercent, 1)
			end
			local n = width * currentPercent
			if reverse ~= deficit then
				incomingHealBar:SetPoint("RIGHT", healthBar, "RIGHT", -n, 0)
			else
				incomingHealBar:SetPoint("LEFT", healthBar, "LEFT", n, 0)
			end
		else
			incomingHealBar:SetWidth(width)
			incomingHealBar:SetHeight(height * incomingPercent)
			if reverse ~= deficit then
				incomingHealBar.texture:SetTexCoord(0, 0, incomingPercent, 0, 0, 1, incomingPercent, 1)
			else
				incomingHealBar.texture:SetTexCoord(incomingPercent, 0, 0, 0, incomingPercent, 1, 0, 1)
			end
			local n = height * currentPercent
			if reverse ~= deficit then
				incomingHealBar:SetPoint("TOP", healthBar, "TOP", 0, -n)
			else
				incomingHealBar:SetPoint("BOTTOM", healthBar, "BOTTOM", 0, n)
			end
		end
	else
		if incomingHealBar then
			incomingHealBar.texture = delFrame(incomingHealBar.texture)
			incomingHealBar.spark = delFrame(incomingHealBar.spark)
			frame.incomingHealBar = delFrame(incomingHealBar)
		end
	end
	
	if playerPercent > 0 then
		if not playerHealBar then
			playerHealBar = newFrame("Frame", healthBar)
			frame.playerHealBar = playerHealBar
			local playerHealBar_texture = newFrame("Texture", playerHealBar, "BACKGROUND")
			playerHealBar.texture = playerHealBar_texture
			playerHealBar_texture:SetTexture(texture)
			playerHealBar_texture:SetAllPoints(playerHealBar)
			
			playerHealBar:SetWidth(width)
			playerHealBar:SetHeight(height)
			
			local playerHealBar_spark = newFrame("Texture", playerHealBar, "OVERLAY")
			playerHealBar.spark = playerHealBar_spark
			playerHealBar_spark:SetTexture([[Interface\CastingBar\UI-CastingBar-Spark]])
			playerHealBar_spark:SetBlendMode('ADD')
			if orientation ~= "VERTICAL" then
				playerHealBar_spark:SetPoint('CENTER', playerHealBar, reverse ~= deficit and "RIGHT" or "LEFT")
				playerHealBar_spark:SetWidth(16)
				playerHealBar_spark:SetHeight(height*2)
			else
				playerHealBar_spark:SetPoint('CENTER', playerHealBar, reverse ~= deficit and "TOP" or "BOTTOM")
				playerHealBar_spark:SetWidth(width*2)
				playerHealBar_spark:SetHeight(16)
				playerHealBar_spark:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
			end
		end
		local waste
		if currentPercent + incomingPercent > 1 then
			waste = 1
		else
			waste = currentPercent + incomingPercent + playerPercent - 1
			if waste > 0 then
				waste = waste / playerPercent
			else
				waste = 0
			end
		end

		-- Calculate color for overheal severity
		local outgoingColorF = self.db.profile.outgoingColorF
		local red, green, blue, alpha = unpack(self.db.profile.outgoingColorN)
		local iwaste = 1 - waste
		red = red * iwaste + waste * outgoingColorF[1]
		green = green * iwaste + waste * outgoingColorF[2]
		blue = blue * iwaste + waste * outgoingColorF[3]
		alpha = alpha * iwaste + waste * outgoingColorF[4]

		if self.db.profile.autoLuminance then
			local max = math.max(red, green, blue) 
			red, green, blue = red / max, green / max, blue / max
		end

		-- Set color for heal
		playerHealBar.texture:SetVertexColor(red, green, blue, alpha)

		playerHealBar:ClearAllPoints()
		
		if orientation ~= "VERTICAL" then
			playerHealBar:SetWidth(width * playerPercent)
			playerHealBar:SetHeight(height)
			if reverse ~= deficit then
				playerHealBar.texture:SetTexCoord(playerPercent, 0, playerPercent, 1, 0, 0, 0, 1)
			else
				playerHealBar.texture:SetTexCoord(0, 0, 0, 1, playerPercent, 0, playerPercent, 1)
			end
			
			local n = width * (currentPercent + incomingPercent)
			if reverse ~= deficit then
				playerHealBar:SetPoint("RIGHT", healthBar, "RIGHT", -n, 0)
			else
				playerHealBar:SetPoint("LEFT", healthBar, "LEFT", n, 0)
			end
		else
			playerHealBar:SetWidth(width)
			playerHealBar:SetHeight(height * playerPercent)
			if reverse ~= deficit then
				playerHealBar.texture:SetTexCoord(0, 0, playerPercent, 0, 0, 1, playerPercent, 1)
			else
				playerHealBar.texture:SetTexCoord(playerPercent, 0, 0, 0, playerPercent, 1, 0, 1)
			end
			local n = height * (currentPercent + incomingPercent)
			if reverse ~= deficit then
				playerHealBar:SetPoint("TOP", healthBar, "TOP", 0, -n)
			else
				playerHealBar:SetPoint("BOTTOM", healthBar, "BOTTOM", 0, n)
			end
		end
	else
		if playerHealBar then
			playerHealBar.texture = delFrame(playerHealBar.texture)
			playerHealBar.spark = delFrame(playerHealBar.spark)
			frame.playerHealBar = delFrame(playerHealBar)
		end
	end
end

function PitBull_VisualHeal:UpdateHealth(object, unit, frame)
	self.hooks[object].UpdateHealth(object, unit, frame)
	self:UpdateBars(unit, frame)
end

function PitBull_VisualHeal:OnUpdateLayout(unit, frame)
	self:OnClearUnitFrame(unit, frame)
	self:UpdateBars(unit, frame)
end

function PitBull_VisualHeal:OnClearUnitFrame(unit, frame)
	if frame.playerHealBar then
		frame.playerHealBar.texture = delFrame(frame.playerHealBar.texture)
		frame.playerHealBar.spark = delFrame(frame.playerHealBar.spark)
		frame.playerHealBar = delFrame(frame.playerHealBar)
	end
	if frame.incomingHealBar then
		frame.incomingHealBar.texture = delFrame(frame.incomingHealBar.texture)
		frame.incomingHealBar.spark = delFrame(frame.incomingHealBar.spark)
		frame.incomingHealBar = delFrame(frame.incomingHealBar)
	end
end

function PitBull_VisualHeal:OnUpdateStatusBarTexture(texture)
	for unit,frame in PitBull:IterateUnitFrames() do
		if frame.playerHealBar then
			frame.playerHealBar.texture:SetTexture(texture)
		end
		if frame.incomingHealBar then
			frame.incomingHealBar.texture:SetTexture(texture)
		end
	end
end

function PitBull_VisualHeal:HealComm_DirectHealStart(event, healerName, healSize, endTime, ...)
	if healerName == playerName then
		playerIsCasting = true
		playerHealingTargetName = ... 
		playerHealingSize = healSize
		playerEndTime = endTime
	end
	
	for i = 1, select('#', ...) do
		local targetName = select(i, ...)
		for frame in PitBull:IterateUnitFramesForUnitName(targetName) do
			self:UpdateBars(frame:GetUnit(), frame)
		end 
	end
end

function PitBull_VisualHeal:HealComm_DirectHealUpdate(event, healerName, healSize, endTime, ...)
	if healerName == playerName then
		playerEndTime = endTime
	end

	for i = 1, select('#', ...) do
		local targetName = select(i, ...)
		for frame in PitBull:IterateUnitFramesForUnitName(targetName) do
			self:UpdateBars(frame:GetUnit(), frame)
		end
	end
end

function PitBull_VisualHeal:HealComm_DirectHealStop(event, healerName, healSize, succeeded, ...)
	if healerName == playerName then
		playerIsCasting = false
	end

	for i = 1, select('#', ...) do
		local targetName = select(i, ...)
		for frame in PitBull:IterateUnitFramesForUnitName(targetName) do
			self:UpdateBars(frame:GetUnit(), frame)
		end
	end
end

function PitBull_VisualHeal:HealComm_HealModifierUpdate(event, unit, targetName, healModifier)
	for frame in PitBull:IterateUnitFramesForUnit(unit) do			  
		self:UpdateBars(unit, frame)
	end
end

-- Global Options
PitBull:RegisterGlobalSetting("VisualHeal", function() return "@cache", {
	type = 'group',
	name = L["VisualHeal"],
	desc = L["VisualHeal options."],
	hidden = function() return not PitBull_VisualHeal:IsActive() end,
	args = {
		incomingColor = {
			type = 'color',
			name = L["Incoming Color"],
			desc = L["The color of the bar that shows incoming heals."],
			get = function() return unpack(PitBull_VisualHeal.db.profile.incomingColor) end,
			set = function(r, g, b, a) PitBull_VisualHeal.db.profile.incomingColor = {r, g, b, a} end,
			hasAlpha = true,
			order = 1,
		},
		outgoingColorN = {
			type = 'color',
			name = L["Outgoing Color (No overheal)"],
			desc = L["The color of the bar that shows your own heals, when no overhealing is due."],
			get = function() return unpack(PitBull_VisualHeal.db.profile.outgoingColorN) end,
			set = function(r, g, b, a) PitBull_VisualHeal.db.profile.outgoingColorN = {r, g, b, a} end,
			hasAlpha = true,
			order = 2,
		},
		outgoingColorF = {
			type = 'color',
			name = L["Outgoing Color (Overheal)"],
			desc = L["The color of the bar that shows your own heals, when full overhealing is due."],
			get = function() return unpack(PitBull_VisualHeal.db.profile.outgoingColorF) end,
			set = function(r, g, b, a) PitBull_VisualHeal.db.profile.outgoingColorF = {r, g, b, a} end,
			hasAlpha = true,
			order = 3,
		},
		autoLuminance = {
			name = L["Auto Luminance"],
			desc = L["Automatically adjust the luminance of the color of the outgoing heal bar to max."],
			type = 'boolean',
			get = function() return PitBull_VisualHeal.db.profile.autoLuminance end,
			set = function(value) PitBull_VisualHeal.db.profile.autoLuminance = value end,
			passValue = group,
			order = 4,
		},
	},
} end)

-- Unit/Group Specific Options
PitBull_VisualHeal:RegisterPitBullOptionsMethod(function(group)
	return {
		name = L["VisualHeal"],
		desc = L["VisualHeal options."],
		type = 'group',
		args = {
			enabled = {
				type = 'boolean',
				name = L["Enable Bars"],
				desc = L["Enables the VisualHeal bars when heals are incoming and/or when you heal units in this group."],
				get = function(group) return PitBull_VisualHeal.db.profile.groups[group].enabled end,
				set = function(group, value) PitBull_VisualHeal.db.profile.groups[group].enabled = value end,
				passValue = group,
				order = 1,
			},
		}
	}
end)
