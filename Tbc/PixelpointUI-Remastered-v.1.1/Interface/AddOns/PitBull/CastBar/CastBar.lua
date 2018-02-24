if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 67030 $"):match("%d+"))

local PitBull = PitBull
local PitBull_CastBar = PitBull:NewModule("CastBar", "LibRockEvent-1.0")
local self = PitBull_CastBar
if PitBull.revision < VERSION then
	PitBull.version = "r" .. VERSION
	PitBull.revision = VERSION
	PitBull.date = ("$Date: 2008-03-30 01:33:10 -0400 (Sun, 30 Mar 2008) $"):match("%d%d%d%d%-%d%d%-%d%d")
end

local localization = (GetLocale() == "koKR") and {
	["Show a casting bar each of the PitBull unit frames."] = "각 PitBull 유닛 프레임에 시전 바를 보여줍니다.",
	["Cast bar"] = "시전 바",
	["Cast"] = "시전",
	["Casting bar"] = "시전 바",
	["Spell Text"] = "주문 문자",
	["Time Text"] = "시간 문자",
	["Casting"] = "시전중",
	["Channeling"] = "채널링",
	["Complete"] = "완료",
	["Fail"] = "실패",
	["Background"] = "배경",
	["Bottom"] = "하단",
	["Top"] = "상단",
	["Left"] = "좌측",
	["Right"] = "우측",
	["Options for the cast bar."] = "시전 바를 위한 옵션입니다.",
	["Enable"] = "활성화",
	["Enables the cast bar for this unit.\n\nNote that disabling the cast bar for the player does not automatically enable the standard Blizzard cast bar, you must do that in the Hide Blizzard Frames menu."] = "이 유닛에 대해 시전바를 활성화합니다.\n\n기본 블리자드 시전 바를 자동으로 활성화하지 않은 플레이어를 위해서는 숨겨져 있는 블리자드 프레임 메뉴에서 반드시 시전 바를 비활성화시켜야 한다는 것을 유의하십시오.",
	["Show icon"] = "아이콘 보기",
	["Show the icon for the spell which is being cast."] = "현재 시전중인 주문의 아이콘을 보여줍니다.",
	["Icon position"] = "아이콘 위치",
	["Which position the icon should be in."] = "아이콘의 위치를 선택합니다.",
} or (GetLocale() == "zhCN") and {
	["Show a casting bar each of the PitBull unit frames."] = "为每个PitBull单位框体显示一个施法进度条。",
	["Cast bar"] = "施法条",
	["Cast"] = "施法进度",
	["Casting bar"] = "施法条",
	["Spell Text"] = "法术文字",
	["Time Text"] = "时间文字",
	["Casting"] = "施放中",
	["Channeling"] = "引导中",
	["Complete"] = "完成",
	["Fail"] = "失败",
	["Background"] = "背景",
	["Bottom"] = "下",
	["Top"] = "上",
	["Left"] = "左",
	["Right"] = "右",
	["Options for the cast bar."] = "设置施法条。",
	["Enable"] = "启用",
	["Enables the cast bar for this unit.\n\nNote that disabling the cast bar for the player does not automatically enable the standard Blizzard cast bar, you must do that in the Hide Blizzard Frames menu."] = "为此单位类型开启施法条。\n\n要注意关闭施法条功能并不会自动开启暴雪自带的施法条，你必须在“隐藏暴雪框体”模块中手动开启。",
	["Show icon"] = "显示法术图标",
	["Show the icon for the spell which is being cast."] = "显示正在施放的法术图标。",
	["Icon position"] = "图标位置",
	["Which position the icon should be in."] = "图标应该依附在哪个位置。",
} or (GetLocale() == "zhTW") and {
	["Show a casting bar each of the PitBull unit frames."] = "在PitBuff單位框架上顯示施法條",
	["Cast bar"] = "施法條",
	["Casting bar"] = "施法條",
	["Spell Text"] = "法術文字",
	["Time Text"] = "時間文字",
	["Casting"] = "施放中",
	["Channeling"] = "內槽",
	["Complete"] = "完成",
	["Fail"] = "失敗",
	["Background"] = "背景",
	["Top"] = "上",
	["Bottom"] = "下",
	["Left"] = "左",
	["Right"] = "右",
	["Cast"] = "施法條",
	["Options for the cast bar."] = "施法條選項.",
	["Enable"] = "啟用",
	["Enables the cast bar for this unit.\n\nNote that disabling the cast bar for the player does not automatically enable the standard Blizzard cast bar, you must do that in the Hide Blizzard Frames menu."] = "啟用這個單位的施法條.\n\n禁用玩家的施法條並不會自動的啟用遊戲標準施法條,你必須在隱藏的遊戲選單中啟用它.",
	["Show icon"] = "顯示圖示",
	["Show the icon for the spell which is being cast."] = "開始施法時顯示法術圖示.",
	["Icon position"] = "施法圖示位置",
	["Which position the icon should be in."] = "欲將施法圖示置放於何處.",
} or {}

local L = PitBull:L("PitBull-CastBar", localization)

self.desc = L["Show a casting bar each of the PitBull unit frames."]

local newList, del, newDict = Rock:GetRecyclingFunctions("PitBull", "newList", "del", "newDict")
local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

PitBull_CastBar:RegisterPitBullChildFrames('castBar', 'castBarIcon')
PitBull_CastBar:RegisterPitBullBarLayoutHandler("castBar", L["Cast bar"], L["Cast"])

local castData = {}

function PitBull_CastBar:OnInitialize()
	self.db = PitBull:GetDatabaseNamespace("CastBar")
	PitBull:SetDatabaseNamespaceDefaults("CastBar", "profile", {
		groups = {
			['**'] = {
				ignore = false,
				showIcon = true,
				iconPosition = "left",
			},
			["targettarget"] = {
				ignore = true,
			},
			["targettargettarget"] = {
				ignore = true,
			},
			["focustarget"] = {
				ignore = true,
			},
			["focustarget"] = {
				ignore = true,
			},
			["partytarget"] = {
				ignore = true,
			},
			["partypettarget"] = {
				ignore = true,
			},
			["raidtarget"] = {
				ignore = true,
			},
		},
		spelltextcolor = {1, 1, 1},
		timetextcolor = {1, 1, 1},
		castingcolor = {1.0, 0.7, 0.0},
		channelingcolor = {0, 1.0, 0},
		completecolor = {0, 1.0, 0},
		failcolor = {1.0, 0, 0},
		backgroundcolor = { .5, .5, .5, .8 },
	})
end

local timerFrame

function PitBull_CastBar:OnEnable(first)
	self.castData = castData -- for Roartindon so he can read the data.
	if not timerFrame then
		timerFrame = CreateFrame("Frame")
		timerFrame:SetScript("OnUpdate", function(this, elapsed)
			if UIParent:IsShown() then
				self:UpdateAllCastBars()
			end
		end)
	end
	timerFrame:Show()

	self:AddEventListener("UNIT_SPELLCAST_SENT")
	self:AddEventListener("UNIT_SPELLCAST_START")
	self:AddEventListener("UNIT_SPELLCAST_CHANNEL_START")
	self:AddEventListener("UNIT_SPELLCAST_STOP")
	self:AddEventListener("UNIT_SPELLCAST_FAILED")
	self:AddEventListener("UNIT_SPELLCAST_DELAYED")
	self:AddEventListener("UNIT_SPELLCAST_CHANNEL_UPDATE")
	self:AddEventListener("UNIT_SPELLCAST_CHANNEL_STOP")
	self:AddEventListener("UNIT_SPELLCAST_INTERRUPTED")
	self:AddEventListener("UNIT_SPELLCAST_CHANNEL_INTERRUPTED", "UNIT_SPELLCAST_INTERRUPTED")
end

function PitBull_CastBar:OnDisable()
	timerFrame:Hide()
end

function PitBull_CastBar:UpdateAllCastBars()
	local frame
	local currentTime = GetTime()
	for unit, data in pairs(castData) do
		local hasOne = false
		for frame in PitBull:IterateUnitFramesForUnit(unit, true) do
			local castBar = frame.castBar
			if castBar then
				hasOne = true
				if data.casting then
					local endTime, startTime = data.endTime, data.startTime
					castBar:SetValue((currentTime - startTime) / (endTime - startTime))
					if currentTime > endTime and not UnitIsUnit("player", unit) then
						data.casting = nil
						data.fadeOut = 1
						data.stopTime = currentTime
					end
				elseif data.channeling then
					local endTime, startTime = data.endTime, data.startTime
					if currentTime > endTime then
						data.channeling = nil
						data.fadeOut = 1
						data.stopTime = currentTime
					end
					castBar:SetValue((endTime - currentTime) / (endTime - startTime))
				elseif data.fadeOut then
					local alpha
					local stopTime = data.stopTime
					if stopTime then
						alpha = stopTime - currentTime + 1
					else
						alpha = 0
					end
					if alpha >= 1 then
						alpha = 1
					end
					if alpha <= 0 then
						castBar:Hide()
						if frame.castBarIcon then
							frame.castBarIcon:Hide()
						end
						castBar:SetValue(0)
						
						castData[unit] = del(data)
						data = nil
						break
					else
						castBar:SetAlpha(alpha)
						if frame.castBarIcon then
							frame.castBarIcon:SetAlpha(alpha)
						end
					end
				else
					if data then
						castData[unit] = del(data)
						data = nil
					end
					break
				end
			end
		end
		if not hasOne and data then
			castData[unit] = del(data)
			data = nil
		end
	end
end

function PitBull_CastBar:UNIT_SPELLCAST_SENT(ns, event, unit, spell, rank, target)
	local hasOne = false
	for frame in PitBull:IterateUnitFramesForUnit(unit, true) do
		if not self.db.profile.groups[frame.group].ignore and frame.castBar then
			hasOne = true
			break
		end
	end
	if not hasOne then
		return
	end
	
	local data = castData[unit]
	if not data then
		data = newList()
		castData[unit] = data
	end

	if target == "" then
		target = nil
	end
	data.target = target
end

function PitBull_CastBar:UNIT_SPELLCAST_START(ns, event, unit)
	local data
	for frame in PitBull:IterateUnitFramesForUnit(unit, true) do
		local castBar = frame.castBar
		if castBar and not self.db.profile.groups[frame.group].ignore then
			if not data then
				local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo(unit)
				if icon == "Interface\\Icons\\Temp" then
					icon = nil
				end
				if not spell then
					return
				end
				data = castData[unit]
				if not data then
					data = newList()
					castData[unit] = data
				end

				data.spell = spell
				data.rank = rank
				data.displayName = displayName
				data.icon = icon
				data.startTime = startTime * 0.001
				data.endTime = endTime * 0.001
				data.delay = 0
				data.casting = 1
				data.channeling = nil
				data.fadeOut = nil
			end

			castBar:SetColor(unpack(self.db.profile.castingcolor))
			castBar:SetAlpha(1.0)
			-- calculate the correct value since this function can be called for wacky units as well.
			castBar:SetValue((GetTime() - data.startTime) / (data.endTime - data.startTime))
			castBar:Show()
			
			local castBarIcon = frame.castBarIcon
			if castBarIcon then
				castBarIcon:SetAlpha(1.0)
				castBarIcon:SetTexture(data.icon)
				castBarIcon:Show()
			end
		end
	end
end

function PitBull_CastBar:UNIT_SPELLCAST_CHANNEL_START(ns, event, unit)
	local data
	for frame in PitBull:IterateUnitFramesForUnit(unit, true) do
		local castBar = frame.castBar
		if castBar and not self.db.profile.groups[frame.group].ignore then
			if not data then
				local spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo(unit)
				if icon == "Interface\\Icons\\Temp" then
					icon = nil
				end
				if not spell then
					return
				end
				
				data = castData[unit]
				if not data then
					data = newDict()
					castData[unit] = data
				end
				
				data.spell = spell
				data.rank = rank
				data.displayName = spell
				data.icon = icon
				data.startTime = startTime * 0.001
				data.endTime = endTime * 0.001
				data.delay = 0
				data.casting = nil
				data.channeling = 1
				data.fadeOut = nil
			end
			castBar:SetColor(unpack(self.db.profile.channelingcolor))
			castBar:SetAlpha(1.0)
			castBar:SetValue((data.endTime - GetTime()) / (data.endTime - data.startTime))
			castBar:Show()
			
			local castBarIcon = frame.castBarIcon
			if castBarIcon then
				castBarIcon:SetAlpha(1.0)
				castBarIcon:SetTexture(data.icon)
				castBarIcon:Show()
			end
		end
	end
end

function PitBull_CastBar:UNIT_SPELLCAST_STOP(ns, event, unit)
	local data = castData[unit]
	if not data or not data.casting then
		return
	end
	data.casting = nil
	data.fadeOut = 1
	data.stopTime = GetTime()
	
	for frame in PitBull:IterateUnitFramesForUnit(unit, true) do
		local castBar = frame.castBar
		if castBar then
			castBar:SetColor(unpack(self.db.profile.completecolor))
		end
	end
end

function PitBull_CastBar:UNIT_SPELLCAST_FAILED(ns, event, unit)
	local data = castData[unit]
	if not data or data.fadeOut then
		return
	end
	data.casting = nil
	data.channeling = nil
	data.fadeOut = 1
	data.stopTime = GetTime()

	for frame in PitBull:IterateUnitFramesForUnit(unit, true) do
		local castBar = frame.castBar
		if castBar then
			castBar:SetColor(unpack(self.db.profile.failcolor))
			castBar:SetAlpha(1.0)
			castBar:SetValue(1.0)
			castBar:Show()
		end
	end
end

function PitBull_CastBar:UNIT_SPELLCAST_INTERRUPTED(ns, event, unit)
	local data = castData[unit]
	if not data then
		return
	end
	data.casting = nil
	data.channeling = nil
	data.fadeOut = 1
	data.stopTime = GetTime()

	for frame in PitBull:IterateUnitFramesForUnit(unit, true) do
		local castBar = frame.castBar
		if castBar then
			castBar:SetColor(unpack(self.db.profile.failcolor))
			castBar:SetAlpha(1.0)
			castBar:SetValue(1.0)
			castBar:Show()
		end
	end
end

function PitBull_CastBar:UNIT_SPELLCAST_DELAYED(ns, event, unit)
	local data = castData[unit]
	if not data or not data.casting then
		return
	end
	
	local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo(unit)

	if not spell or not startTime or not endTime then
		return
	end

	local oldStart = castData[unit].startTime

	data.startTime = startTime * 0.001
	data.endTime = endTime * 0.001

	data.delay = data.delay + data.startTime - oldStart
end

function PitBull_CastBar:UNIT_SPELLCAST_CHANNEL_UPDATE(ns, event, unit)
	local data = castData[unit]
	if not data then
		return
	end
	
	local spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo(unit)
	
	if not spell then
		castData[unit] = del(data)
	end	

	local oldStart = data.startTime
	data.startTime = startTime * 0.001
	data.endTime = endTime * 0.001
	data.delay = data.delay + oldStart - data.startTime
	
	if not spell then
		for frame in PitBull:IterateUnitFramesForUnit(unit) do
			if frame.castBar then
				if frame.castBarIcon then
					frame.castBarIcon:Hide()
				end
				frame.castBar:Hide()
				return
			end
		end
	end
end

function PitBull_CastBar:UNIT_SPELLCAST_CHANNEL_STOP(ns, event, unit)
	local data = castData[unit]
	if not data then
		return
	end
	
	castData[unit].channeling = nil
	castData[unit].casting = nil
	castData[unit].fadeOut = 1
	castData[unit].stopTime = GetTime()
end

function PitBull_CastBar:OnUpdateFrame(unit, frame)
	if not frame.castBar or self.db.profile.groups[frame.group].ignore then
		return
	end

	if PitBull.IsWackyUnit[unit] then
		-- We have a non-event driven wacky unit with a castBar that's not ignored
		-- We manually call the start and stop functions for those units
		local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo(unit)
		if displayName then
			self:UNIT_SPELLCAST_START(nil, nil, unit)
			return
		end
		spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo(unit)
		if displayName then
			self:UNIT_SPELLCAST_CHANNEL_START(nil, nil, unit)
			return
		end
		if castData[unit] then
			if castData[unit].channeling then
				self:UNIT_SPELLCAST_CHANNEL_STOP(nil, nil, unit)
			elseif castData[unit].casting then
				self:UNIT_SPELLCAST_STOP(nil, nil, unit)
			end
		end
	elseif unit == "target" or unit == "focus" then
		-- This occurs when the player has selected a new target or focus.
		local spell, rank, displayName, icon, startTime, endTime = UnitCastingInfo(unit)
		if displayName then
			self:UNIT_SPELLCAST_START(nil, nil, unit)
			return
		end
		spell, rank, displayName, icon, startTime, endTime = UnitChannelInfo(unit)
		if displayName then
			self:UNIT_SPELLCAST_CHANNEL_START(nil, nil, unit)
			return
		end
		if castData[unit] then
			castData[unit] = del(castData[unit])
			if frame.castBarIcon then
				frame.castBarIcon:SetTexture(nil)
			end
			frame.castBar:SetValue(0)
		end
	end
end

function PitBull_CastBar:OnPopulateUnitFrame(unit, frame)
	if frame.castBar or self.db.profile.groups[frame.group].ignore then
		return
	end
	local castBar = newFrame("FakeStatusBar", frame)
	frame.castBar = castBar
	castBar:SetTexture(PitBull:GetStatusBarTexture())
	local data = castData[unit]
	castBar:SetValue(0)
	castBar:SetColor(unpack(self.db.profile.completecolor))
	castBar:SetAlpha(0)

	if self.db.profile.groups[frame.group].showIcon then
		local castBarIcon = newFrame("Texture", castBar, "BACKGROUND")
		frame.castBarIcon = castBarIcon
		castBarIcon:SetPoint( "RIGHT", castBar, "LEFT", 0, 0)
		castBarIcon:Hide()
	end
	
	if data then
		if data.casting then
			castBar:SetColor(unpack(self.db.profile.castingcolor))
			castBar:SetAlpha(1)
		elseif data.channeling then
			castBar:SetColor(unpack(self.db.profile.channelingcolor))
			castBar:SetAlpha(1)
		end
		if data.icon and frame.castBarIcon then
			frame.castBarIcon:SetAlpha(1.0)
			frame.castBarIcon:SetTexture(data.icon)
			frame.castBarIcon:Show()
		end
	end
end

function PitBull_CastBar:OnUpdateStatusBarTexture(texture)
	for _,frame in PitBull:IterateUnitFrames() do
		if frame.castBar then
			frame.castBar:SetTexture(texture)
		end
	end
end

function PitBull_CastBar:OnClearUnitFrame(unit, frame)
	if frame.castBar then
		if frame.castBarIcon then
			frame.castBarIcon = delFrame(frame.castBarIcon)
		end
		frame.castBar = delFrame(frame.castBar)
	end
end

function PitBull_CastBar:OnUpdateLayout(unit, frame)
	if frame.castBarIcon then
		local vert = frame.castBar:GetOrientation() == "VERTICAL"
		local size
		local point, altPoint
		local changeX, changeY = 0, 0
		if vert then
			size = frame.castBar:GetWidth()
			if self.db.profile.groups[frame.group].iconPosition == "left" then
				-- bottom
				point, altPoint = "BOTTOM", "TOP"
				changeY = size
			else
				-- top
				point, altPoint = "TOP", "BOTTOM"
				changeY = -size
			end
		else
			size = frame.castBar:GetHeight()
			if self.db.profile.groups[frame.group].iconPosition == "left" then
				point, altPoint = "LEFT", "RIGHT"
				changeX = size
			else
				point, altPoint = "RIGHT", "LEFT"
				changeX = -size
			end
		end
		for i = 1, frame.castBar:GetNumPoints() do
			local p, attach, relpoint, x, y = frame.castBar:GetPoint(i)
			if p == point then
				frame.castBar:SetPoint(p, attach, relpoint, x + changeX, y + changeY)
			end
		end
		frame.castBarIcon:SetHeight(size - 1)
		frame.castBarIcon:SetWidth(size - 1)
		frame.castBarIcon:ClearAllPoints()
		frame.castBarIcon:SetPoint(altPoint, frame.castBar, point)
		frame.castBarIcon:SetTexCoord(0.07, 0.93, 0.07, 0.93)
	end
end

-- Global Options
PitBull:RegisterGlobalSetting("colors", "args", "castbar", function() return "@cache", {
	type = 'group',
	name = L["Casting bar"],
	desc = L["Casting bar"],
	child_get = function(field)
		return unpack(PitBull_CastBar.db.profile[field])
	end,
	child_set = function(field,r,g,b)
		PitBull_CastBar.db.profile[field] = {r,g,b}
	end,
	child_type = 'color',
	args = {
		spelltextcolor = {
			name = L["Spell Text"],
			desc = L["Spell Text"],
			passValue = 'spelltextcolor',
		},
		timetextcolor = {
			name = L["Time Text"],
			desc = L["Time Text"],
			passValue = 'timetextcolor',
		},
		castingcolor = {
			name = L["Casting"],
			desc = L["Casting"],
			passValue = 'castingcolor',
		},
		channelingcolor = {
			name = L["Channeling"],
			desc = L["Channeling"],
			passValue = 'channelingcolor',
		},
		completecolor = {
			name = L["Complete"],
			desc = L["Complete"],
			passValue = 'completecolor',
		},
		failcolor = {
			name = L["Fail"],
			desc = L["Fail"],
			passValue = 'failcolor',
		},
		backgroundcolor = {
			name = L["Background"],
			desc = L["Background"],
			hasAlpha = true,
			passValue = 'backgroundcolor',
		},
	},
} end)
-- Unit/Group Specific Options
local function getDisabled(group)
	return PitBull_CastBar.db.profile.groups[group].ignore
end
local function getEnabled(group)
	return not PitBull_CastBar.db.profile.groups[group].ignore
end
local function setEnabled(group, value)
	value = not value
	PitBull_CastBar.db.profile.groups[group].ignore = value
	if value then
		for unit,frame in PitBull:IterateUnitFramesByGroup(group) do
			if frame.castBar then
				PitBull_CastBar:OnClearUnitFrame(unit, frame)
				castData[unit] = nil
				PitBull:UpdateLayout(frame)
			end
		end
	else
		for unit,frame in PitBull:IterateUnitFramesByGroup(group) do
			if not frame.castBar then
				PitBull_CastBar:OnPopulateUnitFrame(unit, frame)
				PitBull:UpdateLayout(frame)
			end
		end
	end
end
local function getShowIcon(group)
	return PitBull_CastBar.db.profile.groups[group].showIcon
end
local function setShowIcon(group, value)
	PitBull_CastBar.db.profile.groups[group].showIcon = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		if frame.castBar then
			PitBull_CastBar:OnClearUnitFrame(unit, frame)
			PitBull_CastBar:OnPopulateUnitFrame(unit, frame)
			PitBull:UpdateLayout(frame)
		end
	end
end
local function iconPosition_get(group)
	return PitBull_CastBar.db.profile.groups[group].iconPosition
end
local function iconPosition_set(group, value)
	PitBull_CastBar.db.profile.groups[group].iconPosition = value
	for unit, frame in PitBull:IterateUnitFramesByGroup(group) do
		if frame.castBar then
			PitBull:UpdateLayout(frame)
		end
	end
end

local function iconPosition_disabled(group)
	return PitBull_CastBar.db.profile.groups[group].ignore or not PitBull_CastBar.db.profile.groups[group].showIcon
end

local function iconPosition_choices(group)
	if PitBull.MetaLayout.db.profile[group].bars.castBar.side ~= "center" then
		return '@dict',
			'left', L["Bottom"],
			'right', L["Top"]
	else
		return '@dict',
			'left', L["Left"],
			'right', L["Right"]
	end
end

PitBull_CastBar:RegisterPitBullOptionsMethod(function(group)
	return {
		type = 'group',
		name = L["Cast"],
		desc = L["Options for the cast bar."],
		args = {
			enable = {
				type = 'boolean',
				name = L["Enable"],
				desc = L["Enables the cast bar for this unit.\n\nNote that disabling the cast bar for the player does not automatically enable the standard Blizzard cast bar, you must do that in the Hide Blizzard Frames menu."],
				get = getEnabled,
				set = setEnabled,
				passValue = group,
				order = 1,
			},
			showIcon = {
				type = 'boolean',
				name = L["Show icon"],
				desc = L["Show the icon for the spell which is being cast."],
				get = getShowIcon,
				set = setShowIcon,
				passValue = group,
				disabled = getDisabled,
			},
			iconPosition = {
				type = 'choice',
				name = L["Icon position"],
				desc = L["Which position the icon should be in."],
				get = iconPosition_get,
				set = iconPosition_set,
				choices = iconPosition_choices,
				passValue = group,
				disabled = iconPosition_disabled,
			}
		},
	}
end)

