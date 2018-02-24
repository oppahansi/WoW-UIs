if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

if select(2, UnitClass("player")) == "WARRIOR" then
	return
end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_Spark = PitBull:NewModule("Spark", "LibRockEvent-1.0")
local self = PitBull_Spark
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Graceful display of energy ticks and the spellcasting five-second-rule."] = "기력 회복 및 5초 규칙 주문 시전을 우아하게 표시합니다.",
	["Power spark"] = "마력 섬광",
	["Set the color of the power spark."] = "마력 섬광을 위한 색상을 설정합니다.",
	["Enable power spark"] = "마력 섬광 활성화",
	["A spark that travels the length of your power bar, displaying the time left to the next energy tick, or how long until you're outside the five-second rule, depending on your class and current power type."] = "마력바의 길이를 이동하는 하나의 섬광으로 직업 및 마력 유형에 근거해 다음 기력 회복까지 남은 시간을, 혹은 5초 규칙을 벗어나기 까지의 걸린 시간을 표시합니다.",
} or (GetLocale() == "zhCN") and {
	["Graceful display of energy ticks and the spellcasting five-second-rule."] = "以优雅的方式指示能量回复节拍以及施法回魔五秒规则。",
	["Power spark"] = "能量节拍",
	["Set the color of the power spark."] = "设置能量火花的颜色。",
	["Enable power spark"] = "启用能量节拍",
	["A spark that travels the length of your power bar, displaying the time left to the next energy tick, or how long until you're outside the five-second rule, depending on your class and current power type."] = "一个小火花穿过你的能量条，依据你的职业和能量槽类型的不同，指示着你到下一次能量回复的时间，或者是要多久你才能脱离五秒规则。",
} or (GetLocale() == "frFR") and {
	["Graceful display of energy ticks and the spellcasting five-second-rule."] = "Affichage gracieux des ticks d'énergie et de la règle des 5 secondes.",
	["Power spark"] = "Indicateur",
	["Set the color of the power spark."] = "Définit la couleur de l'indicateur.",
	["Enable power spark"] = "Activer l'indicateur",
	["A spark that travels the length of your power bar, displaying the time left to the next energy tick, or how long until you're outside the five-second rule, depending on your class and current power type."] = "Un indicateur qui parcoure la barre d'énergie, affichant le temps restant jusqu'au prochain tick, ou combien de temps il reste avant d'être en dehors de la règle des 5 secondes, dépendant de votre classe et du type d'énergie.",
} or (GetLocale() == "zhTW") and {
	["Graceful display of energy ticks and the spellcasting five-second-rule."] = "顯示能量回復及法術5秒回魔規則的監視條.",
	["Power spark"] = "能力回復監視條",
	["Set the color of the power spark."] = "設定此回復條的顏色",
	["Enable power spark"] = "啟用能力回復監視條顯示",
	["A spark that travels the length of your power bar, displaying the time left to the next energy tick, or how long until you're outside the five-second rule, depending on your class and current power type."] = "一個顯示在你的能力條上的小橫線,顯示距離你下次能量回復的時間,或是五秒回復規則,這取決於你的職業和能力類型.",
} or {}

local L = PitBull:L("PitBull-Spark", localization)

self.desc = L["Graceful display of energy ticks and the spellcasting five-second-rule."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local GetTime = GetTime
local UnitMana = UnitMana

PitBull_Spark:RegisterPitBullModuleDependencies("PowerBar")
PitBull_Spark:RegisterPitBullChildFrames('powerSpark')

-- Frames, stored locally since there's only one copy of each that we care about.
local powerSpark, powerBar

-- Status and event time storage
local energy_lasttick, spellcast_finish_time = 0, 0
local class = select(2, UnitClass("player"))
local current_energy, power, current_mana = 0, 0, 0
local last_spellcast = 0

local LDM = class == "DRUID" and Rock("LibDruidMana-1.0", false, true)

-- functions
local manaOnUpdate, energyOnUpdate

-- constants
local energyticklength = 2
local fiveseclength = 5

function manaOnUpdate(frame)
	frame:ClearAllPoints()
	local timediff = GetTime() - spellcast_finish_time
	if timediff > fiveseclength then
		frame:Hide()
	else
		if powerBar.orientation == "VERTICAL" then
			frame:SetPoint('BOTTOM', powerBar, 'BOTTOM', 0, (timediff / fiveseclength) * (powerBar:GetHeight() - 1))
		else
			frame:SetPoint('LEFT', powerBar, 'LEFT', (timediff / fiveseclength) * (powerBar:GetWidth() - 1), 0)
		end
	end
end

function energyOnUpdate(frame)
	frame:ClearAllPoints()
	local timediff = GetTime() - energy_lasttick
	if timediff > energyticklength then
		energy_lasttick = energy_lasttick + energyticklength
	end
	
	if powerBar.orientation == "VERTICAL" then
		frame:SetPoint('BOTTOM', powerBar, 'BOTTOM', 0, (timediff / energyticklength) * (powerBar:GetHeight() - 1))
	else
		frame:SetPoint('LEFT', powerBar, 'LEFT', (timediff / energyticklength) * (powerBar:GetWidth() - 1), 0)
	end
end


function PitBull_Spark:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("Spark")
	PitBull:SetDatabaseNamespaceDefaults("Spark", "profile", {
		color = {1, 1, 1, 0.3},
		enable = true,
	})
end

function PitBull_Spark:OnEnable()
	if self.db.profile.enable then
		self:DoRegistrations()
	end
end

local didDruidManaReg = false;
function PitBull_Spark:DoRegistrations()
	if class == "ROGUE" or class == "DRUID" then
		current_energy = 0
		self:AddEventListener("UNIT_ENERGY")
		self:AddEventListener("PLAYER_TARGET_CHANGED")
		self:AddEventListener("PLAYER_REGEN_ENABLED")
		self:AddEventListener("PLAYER_REGEN_DISABLED")
		self:AddEventListener("UNIT_FACTION")
		self:AddEventListener("PLAYER_DEAD", "PLAYER_TARGET_CHANGED")
		self:AddEventListener("PLAYER_ALIVE", "PLAYER_TARGET_CHANGED")
		if class == "DRUID" then
			self:AddEventListener("UNIT_DISPLAYPOWER")
			if LDM and not didDruidManaReg then
				LDM:AddListener(function(currMana, maxMana)
					if self.db.profile.enable then self:UpdateDruidMana(currMana, maxMana) end
				end)
				didDruidManaReg = true
			end
		end
	end
	if class ~= "ROGUE" then
		current_mana = UnitMana('player')
		self:AddEventListener("UNIT_SPELLCAST_SUCCEEDED")
		if not LDM then self:AddEventListener("UNIT_MANA") end --LibDruidMana-1.0 handles this event for us
	end
end

if class == "ROGUE" or class == "DRUID" then --energy-users functions
	local inCombat = false
	function PitBull_Spark:PLAYER_REGEN_ENABLED()
		inCombat = false
		if powerSpark and power == 3 and UnitIsDeadOrGhost("player") or (UnitMana("player") == UnitManaMax("player") and (not UnitCanAttack("player", "target") or UnitIsDeadOrGhost("target"))) then
			powerSpark:Hide()
		end
	end

	function PitBull_Spark:PLAYER_REGEN_DISABLED()
		inCombat = true
		if powerSpark and power == 3 then
			powerSpark:Show()
		end
	end

	function PitBull_Spark:PLAYER_TARGET_CHANGED()
		if not powerSpark or power ~= 3 then
			return
		end
		if UnitIsDeadOrGhost("player") or (UnitMana("player") == UnitManaMax("player") and (not UnitCanAttack("player", "target") or UnitIsDeadOrGhost("target")) and not inCombat) then
			powerSpark:Hide()
		else	
			powerSpark:Show()
		end
	end

	function PitBull_Spark:UNIT_FACTION(ns, event, unit)
		if (unit ~= 'player' and unit ~= 'target') or not powerSpark or power ~= 3 then
			return
		end
		self:PLAYER_TARGET_CHANGED()
	end

	function PitBull_Spark:UNIT_ENERGY(ns, event, unit)
		if unit ~= 'player' or not powerSpark or power ~= 3 then
			return
		end
		local newenergy = UnitMana('player')
		if newenergy > current_energy then
			energy_lasttick = GetTime()
			if UnitIsDeadOrGhost("player") or (newenergy == UnitManaMax("player") and (not UnitCanAttack("player", "target") or UnitIsDeadOrGhost("target")) and not inCombat) then
				powerSpark:Hide()
			else
				powerSpark:Show()
			end
		end
		current_energy = newenergy
	end
end --end energy-users functions

if class ~= "ROGUE" then --mana-users functions
	function PitBull_Spark:UNIT_MANA(ns, event, unit)
		if unit ~= 'player' or not powerSpark or power ~= 0 then
			return
		end
		local newmana = UnitMana('player')
		if newmana == UnitManaMax('player') then
			powerSpark:Hide()
		elseif newmana < current_mana and GetTime() - last_spellcast < 0.25 then
			powerSpark:Show()
			spellcast_finish_time = last_spellcast
		end
		current_mana = newmana
	end
	
	function PitBull_Spark:UNIT_SPELLCAST_SUCCEEDED(ns, event, unit)
		if unit == 'player' and powerSpark then
			last_spellcast = GetTime()
		end
	end
end --end mana-users functions

if class == "DRUID" then --druid-only functions
	local UnitPowerType = UnitPowerType
	function PitBull_Spark:UpdateDruidMana(mana, maxMana)
		power = UnitPowerType('player')
		if mana == maxMana then
			if power == 0 and powerSpark then
				powerSpark:Hide()
			end
		elseif mana < current_mana and GetTime() - last_spellcast < 0.25 then
			if power == 0 and powerSpark then
				powerSpark:Show()
			end
			spellcast_finish_time = last_spellcast
		end
		current_mana = mana
	end
	
	function PitBull_Spark:UNIT_DISPLAYPOWER(ns, event, unit)
		if unit == 'player' and powerSpark then
			power = UnitPowerType('player')
			if power == 3 then
				-- kitty form
				energy_lasttick = GetTime()
				current_energy = UnitMana('player')
				powerSpark:SetScript('OnUpdate', energyOnUpdate)
			elseif power == 0 then
				current_mana = UnitMana('player')
				powerSpark:SetScript('OnUpdate', manaOnUpdate)
				powerSpark:Show()
			else
				-- bare fite
				powerSpark:SetScript('OnUpdate', function(this) this:Hide() end)
			end
		end
	end
end --end druid-only functions

function PitBull_Spark:OnPopulateUnitFrame(unit, frame)
	if unit == 'player' and self.db.profile.enable and frame.powerBar and not powerSpark then
		powerBar = frame.powerBar
		
		powerSpark = newFrame("Frame", frame)
		frame.powerSpark = powerSpark
		
		local texture = newFrame("Texture", powerSpark, "OVERLAY")
		powerSpark.texture = texture
		texture:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
		texture:SetVertexColor(unpack(self.db.profile.color))
		texture:SetBlendMode('ADD')
		texture:Show()
		
		power = UnitPowerType('player')
		if power == 3 then
			powerSpark:SetScript('OnUpdate', energyOnUpdate)
		elseif power == 0 then
			powerSpark:SetScript('OnUpdate', manaOnUpdate)
		end
	end
end

function PitBull_Spark:OnUpdateLayout(unit, frame)
	if unit == 'player' and powerSpark and self.db.profile.enable then
		powerBar = frame.powerBar
		
		if not powerBar then
			return self:OnClearUnitFrame(unit, frame)
		end
		
		powerSpark:SetFrameLevel(powerBar:GetFrameLevel() + 2)
		
		-- reassign frame heights/anchors etc, since this (which fires on combat enter/leave) will stop the bar otherwise
		local tex = powerSpark.texture
		if powerBar.orientation == "VERTICAL" then
			tex:SetPoint('CENTER', powerSpark, 'BOTTOM')
			powerSpark:SetHeight(20)
			tex:SetHeight(20)
			
			local width = powerBar:GetWidth() * 2
			powerSpark:SetWidth(width)
			tex:SetWidth(width)
			
			tex:SetTexCoord(1, 0, 0, 0, 1, 1, 0, 1)
		else
			tex:SetPoint('CENTER', powerSpark, 'LEFT')
			powerSpark:SetWidth(20)
			tex:SetWidth(20)
			
			local height = powerBar:GetHeight() * 2
			powerSpark:SetHeight(height)
			tex:SetHeight(height)
			
			tex:SetTexCoord(0, 0, 0, 1, 1, 0, 1, 1)
		end
		
		tex:Show()
		
		if power == 3 then
			self:UNIT_ENERGY(nil, nil, 'player')
		end
	end
end

function PitBull_Spark:OnClearUnitFrame(unit, frame)
	if unit == 'player' and frame.powerSpark then
		frame.powerSpark.texture = delFrame(frame.powerSpark.texture)
		powerSpark:SetScript('OnUpdate', nil)
		frame.powerSpark = delFrame(frame.powerSpark)
		powerSpark = nil
	end
end

-- Options stuff
local function enabled_get()
	return PitBull_Spark.db.profile.enable
end
local function enabled_set(v)
	PitBull_Spark.db.profile.enable = v
	if v then
		if not powerSpark then
			for frame in PitBull:IterateUnitFrames("player") do
				PitBull_Spark:OnPopulateUnitFrame('player', frame)
			end
		end
		for frame in PitBull:IterateUnitFrames("player") do
			PitBull_Spark:OnUpdateLayout('player', frame)
		end
		PitBull_Spark:DoRegistrations()
		powerSpark:Hide()
	else
		PitBull_Spark:RemoveAllEventListeners()
		if powerSpark then
			powerSpark:Hide()
		end
	end
end

PitBull:RegisterGlobalSetting("colors", "args", "spark", function() return "@cache", {
	type = 'color',
	name = L["Power spark"],
	desc = L["Set the color of the power spark."],
	get = function()
		return unpack(PitBull_Spark.db.profile.color)
	end,
	set = function(r,g,b,a)
		PitBull_Spark.db.profile.color = {r,g,b,a}
		if powerSpark then
			powerSpark.texture:SetVertexColor(r,g,b,a)
		end
	end,
	hasAlpha = true,
} end)

PitBull_Spark:RegisterPitBullOptionsMethod(function(group)
	if group ~= 'player' then
		return
	end
	return {
		type = 'boolean',
		name = L["Enable power spark"],
		desc = L["A spark that travels the length of your power bar, displaying the time left to the next energy tick, or how long until you're outside the five-second rule, depending on your class and current power type."],
		get = enabled_get,
		set = enabled_set,
	}
end)

