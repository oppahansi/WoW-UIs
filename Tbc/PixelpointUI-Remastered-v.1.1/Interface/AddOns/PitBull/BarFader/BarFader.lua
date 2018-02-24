if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))
local DURATION = 0.5

local localization = (GetLocale() == "koKR") and {
	["Adds fading to the health/power bars."] = "생명력/마력 바에 투명도 변경 기능을 추가합니다.",
	["Bar fade time"] = "바 투명도 변경 시간",
	["Set how long the bars should stay faded after gain or loss before being set back to the original alpha."] = "바가 원래의 투명도로 되돌려 설정되기 이전에 채워지거나 비워지고 난 후에 변경된 투명도가 유지되는 시간을 설정합니다.",
	["Enable power"] = "마력 바 활성화",
	["Enable fading/smoothing changes to Power."] = "마력 바에 투명도/유연한 변경 기능을 활성화합니다.",
	["Enable health"] = "생명력 바 활성화",
	["Enable fading/smoothing changes to Health."] = "생명력 바에 투명도/유연한 변경 기능을 활성화합니다.",
	["Fade"] = "투명도 변경",
	["Fade the alpha of the updated piece of the bar."] = "바의 갱신된 부분의 투명도가 변경됩니다.",
	["Smooth"] = "유연함",
	["Smooth the bar changes, making loss and gain move as a progress bar as opposed to whole chunks."] = "바가 유연하게 변경되어, 전체 바가 변경되는 것에 대해 진행 바 처럼 채워지거나 비워지는 것에 따라 움직이게 만듭니다.",
	["Bar fading"] = "바 투명도 변경",
	["Options for fading the bar displays when their values change, as opposed to changing the values instantly."] = "바의 수치가 변경되는 경우에 즉시 수치가 변경되는 것에 대해 바의 명암 표시를 위한 옵션입니다.",
} or (GetLocale() == "zhCN") and {
	["Adds fading to the health/power bars."] = "为PitBull添加生命/能量条平滑渐隐功能。",
	["Bar fade time"] = "渐隐时间",
	["Set how long the bars should stay faded after gain or loss before being set back to the original alpha."] = "设置计量条在增长或者减少数值时，恢复到正常的透明度所需要的时间。",
	["Enable power"] = "为能量条启用",
	["Enable fading/smoothing changes to Power."] = "开启能量条变动时的平滑/渐隐效果。",
	["Enable health"] = "为生命条启用",
	["Enable fading/smoothing changes to Health."] = "开启生命条变动时的平滑/渐隐效果。",
	["Fade"] = "渐隐",
	["Fade the alpha of the updated piece of the bar."] = "为计量条中所更改的那一块做渐隐效果。",
	["Smooth"] = "平滑",
	["Smooth the bar changes, making loss and gain move as a progress bar as opposed to whole chunks."] = "平滑地更改计量条的变动，使得增长或者减少的那一块像一个小型进度条般的移动。",
	["Bar fading"] = "渐隐效果",
	["Options for fading the bar displays when their values change, as opposed to changing the values instantly."] = "在计量条数值有变化的使用，使用平滑或者渐隐动画效果显示其变动，而不是立刻显示出其更改后的值。",
} or (GetLocale() == "frFR") and {
	["Adds fading this to the health/power bars."] = "Ajoute une option de fondu aux barres de vie/énergie.",
	["Adds fading to the health/power bars."] = "Ajoute un fondu aux barres de vie/énergie.",
	["Bar fade time"] = "Temps de fondu de barre",
	["Set how long the bars should stay faded after gain or loss before being set back to the original alpha."] = "Définit le temps qu'une barre doit rester fondue après un gain ou une perte avant de revenir à son opacité d'origine.",
	["Bar fading"] = "Fondu de barre",
	["Options for fading the bar displays when their values change, as opposed to changing the values instantly."] = "Options de fondu de barre lorsque leur valeur change, en opposition à leur changement instantané.",
	["Enable power"] = "Activer sur la barre d'énergie",
	["Enable fading/smoothing changes to Power."] = "Active le fondu/progression sur la barre d'énergie.",
	["Enable health"] = "Activer sur la barre de vie",
	["Enable fading/smoothing changes to Health."] = "Active le fondu/progression sur la barre de vie.",
	["Fade"] = "Fondu",
	["Fade the alpha of the updated piece of the bar."] = "Opacité du fondu sur la partie mise à jour de la barre.",
	["Smooth"] = "Progressif",
	["Smooth the bar changes, making loss and gain move as a progress bar as opposed to whole chunks."] = "Ajoute un effet progressif sur les changements de barre, en opposition aux changements par blocs entiers.",
} or (GetLocale() == "zhTW") and {
	["Adds fading this to the health/power bars."] = "為生命條/能力條增加淡出效果.",
	["Adds fading to the health/power bars."] = "為生命條/能力條增加淡出效果.",
	["Bar fade time"] = "條淡出時間",
	["Set how long the bars should stay faded after gain or loss before being set back to the original alpha."] = "設定條回到原始不透明度的時間.",
	["Bar fading"] = "條淡出中",
	["Options for fading the bar displays when their values change, as opposed to changing the values instantly."] = "當值改變時,直觀的顯示淡出的條,立即替換原有的值.",
	["Enable power"] = "啟用能力條內顯示",
	["Enable fading/smoothing changes to Power."] = "啟用能力條淡出/平滑.",
	["Enable health"] = "啟用生命條內顯示",
	["Enable fading/smoothing changes to Health."] = "啟用能力條淡出/平滑.",
	["Fade"] = "淡出",
	["Fade the alpha of the updated piece of the bar."] = "為條增加淡出效果.",
	["Smooth"] = "平滑",
	["Smooth the bar changes, making loss and gain move as a progress bar as opposed to whole chunks."] = "為條增加平滑效果.",
} or {}

local L = PitBull:L("PitBull-BarFader", localization)

local PitBull = PitBull
local PitBull_BarFader = PitBull:NewModule("BarFader", "LibRockHook-1.0", "LibRockTimer-1.0")
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end
PitBull_BarFader.desc = L["Adds fading to the health/power bars."]

local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame
local _abs, _cos, _pi = math.abs, math.cos, math.pi
local PitBull_HealthBar = PitBull:GetModule("HealthBar")
local PitBull_PowerBar = PitBull:GetModule("PowerBar")
local activeframes = {}

function PitBull_BarFader:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("BarFader")
	PitBull:SetDatabaseNamespaceDefaults("BarFader", "profile", {
		fadetime = 0.5,
		color = {0, 0.8, 0, 0.5},
		groups = {
			['*'] = {},
		}
	})
end

function PitBull_BarFader:OnEnable()
	if PitBull_PowerBar then self:AddHook(PitBull_PowerBar, "UpdatePowerValue") end
	if PitBull_HealthBar then self:AddHook(PitBull_HealthBar, "UpdateHealth") end
	self:AddRepeatingTimer(0, "UpdateFaders")
	DURATION = self.db.profile.fadetime
end

function PitBull_BarFader:DrawHealthFader(frame)
	local healthFade
	if frame.healthFade then
		healthFade = frame.healthFade
	else
		healthFade = newFrame("StatusBar", frame)
	end
	frame.healthFade = healthFade
	healthFade.destValue = nil
	healthFade.faderstop = nil
	healthFade:SetOrientation(frame.healthBar:GetOrientation())
	healthFade:SetAllPoints(frame.healthBar)
	healthFade:SetMinMaxValues(frame.healthBar:GetMinMaxValues())
	healthFade:SetValue(frame.healthBar:GetValue())
	healthFade:SetStatusBarTexture(PitBull:GetStatusBarTexture())
	healthFade:Hide()
end

function PitBull_BarFader:DrawPowerFader(frame)
	local powerFade
	if frame.powerFade then
		powerFade = frame.powerFade
	else
		powerFade = newFrame("StatusBar", frame)
	end
	frame.powerFade = powerFade
	powerFade.destValue = nil
	powerFade.faderstop = nil
	powerFade:SetOrientation(frame.powerBar:GetOrientation())
	powerFade:SetAllPoints(frame.powerBar)
	powerFade:SetMinMaxValues(frame.powerBar:GetMinMaxValues())
	powerFade:SetValue(frame.powerBar:GetValue())
	powerFade:SetStatusBarTexture(PitBull:GetStatusBarTexture())
	powerFade:Hide()
end

function PitBull_BarFader:OnUpdateStatusBarTexture(texture)
	for _,frame in PitBull:IterateUnitFrames() do
		if frame.healthFade then
			frame.healthFade:SetStatusBarTexture(texture)
		end
		if frame.powerFade then
			frame.powerFade:SetStatusBarTexture(texture)
		end
	end
end

function PitBull_BarFader:OnClearUnitFrame(unit, frame)
	if frame.healthFade then
		activeframes[frame.healthFade] = nil
		frame.healthFade = delFrame(frame.healthFade)
	end
	if frame.powerFade then
		activeframes[frame.powerFade] = nil
		frame.powerFade = delFrame(frame.powerFade)
	end
end

function PitBull_BarFader:OnUpdateLayout(unit, frame)
	if frame.healthFade then
		if (not frame.healthBar) then
			activeframes[frame.healthFade] = nil
			frame.healthFade = delFrame(frame.healthFade)
			return
		end
		frame.healthFade:SetAllPoints(frame.healthBar)
		frame.healthFade:SetOrientation(frame.healthBar:GetOrientation())
		frame.healthBar:SetFrameLevel(3)
		frame.healthFade:SetFrameLevel(4)
		frame.healthFade:SetStatusBarTexture(PitBull:GetStatusBarTexture())
		frame.healthFade:SetMinMaxValues(frame.healthBar:GetMinMaxValues())
		frame.healthFade:Hide()
	end
	if frame.powerFade then
		if (not frame.powerBar) then
			activeframes[frame.powerFade] = nil
			frame.powerFade = delFrame(frame.powerFade)
			return
		end
		frame.powerFade:SetAllPoints(frame.powerBar)
		frame.powerFade:SetOrientation(frame.powerBar:GetOrientation())
		frame.powerBar:SetFrameLevel(3)
		frame.powerFade:SetFrameLevel(4)
		frame.powerFade:SetStatusBarTexture(PitBull:GetStatusBarTexture())
		frame.powerFade:SetMinMaxValues(frame.powerBar:GetMinMaxValues())
		frame.powerFade:Hide()
	end
end

function PitBull_BarFader:UpdateHealth(object, unit, frame)
	local isFading = true
	local db = self.db.profile.groups[frame.group]
	if db.ignore or db.disableHealth or (not db.smooth and not db.fade) then
		return self.hooks[object].UpdateHealth(object,unit,frame)
	end
	if not frame.healthFade then
		self:DrawHealthFader(frame)
	end
	local preValue = frame.healthFade.destValue or frame.healthBar:GetValue()
	self.hooks[object].UpdateHealth(object,unit,frame)
	local destValue = frame.healthBar:GetValue()
	if _abs(destValue - preValue) >= 0.015 then
		local healthFade = frame.healthFade
		if (not healthFade.startValue) then
			isFading = false
			healthFade.startValue = preValue
		end
		healthFade.stop = GetTime() + DURATION
		healthFade.destValue = destValue
		healthFade:SetStatusBarColor(frame.healthBar:GetStatusBarColor())
		if db.smooth and db.fade then
			if preValue < destValue then
				frame.healthBar:SetValue(preValue)
			end
			healthFade:SetAlpha(0)
			if (not isFading) then
				healthFade:SetValue(preValue)
			end
			healthFade.stop = GetTime() + DURATION
			healthFade.style = "both"
		elseif db.smooth then
			if preValue < destValue then
				frame.healthBar:SetValue(preValue)
			end
			if (not isFading) then
				healthFade:SetValue(preValue)
			end
			healthFade:SetAlpha(0.7)
			healthFade.style = "smooth"
		elseif db.fade then
			if preValue < destValue then
				healthFade:SetAlpha(0)
				frame.healthBar:SetValue(preValue)
				if (not isFading) then
					healthFade:SetValue(destValue)
				end
			else
				if (not isFading) then
					healthFade:SetAlpha(0.7)
					healthFade:SetValue(preValue)
				end
			end
			healthFade.style = "flash"
		end
		healthFade:Show()
		activeframes[healthFade] = "healthFade"
	end
end

function PitBull_BarFader:UpdatePowerValue(object, unit, frame)
	local isFading = true
	local db = self.db.profile.groups[frame.group]
	if db.ignore or db.disablePower or (not db.smooth and not db.fade) or not frame.powerBar then
		return self.hooks[object].UpdatePowerValue(object,unit,frame)
	end
	if not frame.powerFade then
		self:DrawPowerFader(frame)
	end
	local preValue = frame.powerFade.destValue or frame.powerBar:GetValue()
	self.hooks[object].UpdatePowerValue(object,unit,frame)
	local destValue = frame.powerBar:GetValue()
	if _abs(destValue - preValue) >= 0.015 then
		local powerFade = frame.powerFade
		if (not powerFade.startValue) then
			powerFade.startValue = preValue
			isFading = false
		end
		powerFade.stop = GetTime() + DURATION
		powerFade.destValue = destValue
		powerFade:SetStatusBarColor(frame.powerBar:GetStatusBarColor())
		if (db.smooth and db.fade) then
			if preValue < destValue then
				frame.powerBar:SetValue(preValue)
			end
			if (not isFading) then
				powerFade:SetValue(preValue)
			end
			powerFade:SetAlpha(0)
			powerFade.style = 'both'
		elseif db.smooth then
			if preValue < destValue then
				frame.powerBar:SetValue(preValue)
			end
			if (not isFading) then
				powerFade:SetValue(preValue)
			end
			powerFade:SetAlpha(0.7)
			powerFade.style = "smooth"
		elseif db.fade then
			if preValue < destValue then
				powerFade:SetAlpha(0)
				frame.powerBar:SetValue(preValue)
				if (not isFading) then
					powerFade:SetValue(destValue)
				end
			else
				if (not isFading) then
					powerFade:SetAlpha(0.7)
					powerFade:SetValue(preValue)
				end
			end
			powerFade.style = "flash"
		end
		powerFade:Show()
		activeframes[powerFade] = "powerFade"
	end
end

local function CosineInterpolate(y1, y2, mu)
	local mu2 = (1-_cos(mu*_pi))/2
	return y1*(1-mu2)+y2*mu2
end

function PitBull_BarFader:UpdateFaders()
	local now, stop, alpha = GetTime()
	for frame, field in pairs(activeframes) do
		stop, alpha = frame.stop
		if stop < now then
			-- done.  set both bar values to the dest value, nuke entry in activeframes, set alpha to 0
			activeframes[frame] = nil
			local parent = frame:GetParent()
			if field == "healthFade" then
				PitBull_BarFader.hooks[PitBull_HealthBar].UpdateHealth(PitBull_HealthBar, parent:GetUnit(), parent)
			elseif field == "powerFade" then
				PitBull_BarFader.hooks[PitBull_PowerBar].UpdatePowerValue(PitBull_PowerBar, parent:GetUnit(), parent)
			end
			frame.startValue = nil
			frame.destValue = nil
			frame:Hide()
			return
		end
		if frame.startValue < frame.destValue then
			alpha = (1 - ((stop - now) / DURATION))*0.7
		else
			alpha = ((stop - now) / DURATION)*0.7
		end
		if frame.style == "flash" then
			frame:SetAlpha(alpha)
		elseif frame.style == 'both' then
			frame:SetAlpha(alpha)
			local cVal = frame:GetValue()
			cVal = CosineInterpolate(cVal,frame.destValue, 1 - ((stop - now) / DURATION) )
			frame:SetValue(cVal)
		elseif frame.style == 'smooth' then
			local cVal = frame:GetValue()
			cVal = CosineInterpolate(cVal,frame.destValue, 1 - ((stop - now) / DURATION) )
			frame:SetValue(cVal)
		end
	end
end

-- Global Options
PitBull:RegisterGlobalSetting("barfader", function() return "@cache", {
	type = 'number',
	name = L["Bar fade time"],
	desc = L["Set how long the bars should stay faded after gain or loss before being set back to the original alpha."],
	min = 0.1,
	max = 5,
	step = 0.1,
	get = function()
		return PitBull_BarFader.db.profile.fadetime
	end,
	set = function(value)
		PitBull_BarFader.db.profile.fadetime = value
		DURATION = value
	end,
} end)


-- Unit/Group Specific Options
local function getFade(group)
	return PitBull_BarFader.db.profile.groups[group].fade
end
local function setFade(group, value)
	PitBull_BarFader.db.profile.groups[group].fade = value
end
local function getSmooth(group)
	return PitBull_BarFader.db.profile.groups[group].smooth
end
local function setSmooth(group, value)
	PitBull_BarFader.db.profile.groups[group].smooth = value
end
local function getEnablePower(group)
	return not PitBull_BarFader.db.profile.groups[group].disablePower
end
local function setEnablePower(group, value)
	PitBull_BarFader.db.profile.groups[group].disablePower = not value
	
	if PitBull_BarFader.db.profile.groups[group].disableHealth and PitBull_BarFader.db.profile.groups[group].disablePower then
		PitBull_BarFader.db.profile.groups[group].ignore = true
	else
		PitBull_BarFader.db.profile.groups[group].ignore = false
	end
end
local function getEnableHealth(group)
	return not PitBull_BarFader.db.profile.groups[group].disableHealth
end
local function setEnableHealth(group, value)
	PitBull_BarFader.db.profile.groups[group].disableHealth = not value
	
	if PitBull_BarFader.db.profile.groups[group].disableHealth and PitBull_BarFader.db.profile.groups[group].disablePower then
		PitBull_BarFader.db.profile.groups[group].ignore = true
	else
		PitBull_BarFader.db.profile.groups[group].ignore = false
	end
end
local function getDisabled(group)
	return PitBull_BarFader.db.profile.groups[group].ignore
end

local barFading_args = {
	power = {
		type = 'boolean',
		name = L["Enable power"],
		desc = L["Enable fading/smoothing changes to Power."],
		get = getEnablePower,
		set = setEnablePower,
		order = 1,
	},
	health = {
		type = 'boolean',
		name = L["Enable health"],
		desc = L["Enable fading/smoothing changes to Health."],
		get = getEnableHealth,
		set = setEnableHealth,
		order = 1,
	},
	fade = {
		type = 'boolean',
		name = L["Fade"],
		desc = L["Fade the alpha of the updated piece of the bar."],
		get = getFade,
		set = setFade,
		disabled = getDisabled,
	},
	smooth = {
		type = 'boolean',
		name = L["Smooth"],
		desc = L["Smooth the bar changes, making loss and gain move as a progress bar as opposed to whole chunks."],
		get = getSmooth,
		set = setSmooth,
		disabled = getDisabled,
	},
}

PitBull_BarFader:RegisterPitBullOptionsMethod(function(group)
	return {
		name = L["Bar fading"],
		desc = L["Options for fading the bar displays when their values change, as opposed to changing the values instantly."],
		type = 'group',
		child_passValue = group,
		args = barFading_args
	}
end)
