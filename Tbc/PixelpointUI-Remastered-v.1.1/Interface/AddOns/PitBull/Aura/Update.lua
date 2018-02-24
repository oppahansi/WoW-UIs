if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 69383 $"):match("%d+"))

local PitBull = PitBull
local PitBull_Aura = PitBull:GetModule("Aura")
local self = PitBull_Aura
PitBull:ProvideVersion("$Revision: 69383 $", "$Date: 2008-04-12 19:12:05 -0400 (Sat, 12 Apr 2008) $")

local newList, del = Rock:GetRecyclingFunctions("PitBull", "newList", "del")
local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local configMode = PitBull.configMode

local _G = _G
local table_sort = _G.table.sort
local pairs = _G.pairs
local ipairs = _G.ipairs
local unpack = _G.unpack
local GetTime = _G.GetTime
local GetItemQualityColor = _G.GetItemQualityColor
local GetPlayerBuffTimeLeft = _G.GetPlayerBuffTimeLeft
local GetPlayerBuffDispelType = _G.GetPlayerBuffDispelType
local GetPlayerBuffApplications = _G.GetPlayerBuffApplications
local GetPlayerBuffTexture = _G.GetPlayerBuffTexture
local GetPlayerBuffName = _G.GetPlayerBuffName
local GetPlayerBuff = _G.GetPlayerBuff
local GetItemInfo = _G.GetItemInfo
local GetInventoryItemLink = _G.GetInventoryItemLink
local select = _G.select
local UnitIsFriend = _G.UnitIsFriend
local UnitIsUnit = _G.UnitIsUnit
local UnitBuff = _G.UnitBuff
local UnitDebuff = _G.UnitDebuff
local GetSpellInfo = _G.GetSpellInfo
local math_ceil = _G.math.ceil

local canDispel, friendBuffs, friendDebuffs, selfBuffs, selfDebuffs, petBuffs, petDebuffs, enemyDebuffs
local totalSelfBuffs, totalPetBuffs, totalSelfDebuffs, totalPetDebuffs, allFriendlyBuffs, allFriendlyDebuffs
local shownAuraFrames
_G.table.insert(PitBull_Aura.OnInitialize_funcs, function()
	canDispel = PitBull_Aura.canDispel
	friendBuffs = PitBull_Aura.friendBuffs
	friendDebuffs = PitBull_Aura.friendDebuffs
	selfDebuffs = PitBull_Aura.selfDebuffs
	petBuffs = PitBull_Aura.petBuffs
	petDebuffs = PitBull_Aura.petDebuffs
	enemyDebuffs = PitBull_Aura.enemyDebuffs
	totalSelfBuffs = PitBull_Aura.totalSelfBuffs
	totalPetBuffs = PitBull_Aura.totalPetBuffs
	totalSelfDebuffs = PitBull_Aura.totalSelfDebuffs
	totalPetDebuffs = PitBull_Aura.totalPetDebuffs
	allFriendlyBuffs = PitBull_Aura.allFriendlyBuffs
	allFriendlyDebuffs = PitBull_Aura.allFriendlyDebuffs
	shownAuraFrames = PitBull_Aura.shownAuraFrames
end)

local getPlayerAuraDuration
do
	local buffData = {}
	local debuffData = {}
	function getPlayerAuraDuration(isBuff, key, providedDuration)
		local data = isBuff and buffData or debuffData
		local duration = data[key]
		if not duration then
			for i = 1, 40 do
				local name, _, time
				if isBuff then
					name, _, _, _, time = UnitBuff("player", i)
				else
					name, _, _, _, _, time = UnitDebuff("player", i)
				end
				if not name then
					break
				end
				if name == key then
					duration = time
					break
				end
			end
		end
		if not duration or duration < providedDuration then
			duration = providedDuration
		end
		data[key] = duration
		return duration
	end
end

local guessSpellIcon = _G.setmetatable({}, {__index=function(self, key)
	for i = 1, 50000 do
		local name, _, texture = GetSpellInfo(i)
		if name and name:find(key) then
			self[key] = texture
			return texture
		end
	end
	self[key] = false
	return false
end})

local function UnitAura(isBuff, unit, id, castable)
	if isBuff then
		local name, rank, iconTexture, count, duration, timeLeft =  UnitBuff(unit, id, castable)
		return name, rank, iconTexture, count, nil, duration, timeLeft
	else
		return UnitDebuff(unit, id, castable)
	end
end

local auraSort__isFriend
local auraSort__isBuff
local function auraSort(alpha, bravo)
	-- id, name, iconTexture, count, debuffType, duration, timeLeft, itemSlot, quality
	
	if not alpha then
		return false
	elseif not bravo then
		return true
	end
	
	if auraSort__isBuff then
		-- item buffs first
		local alpha_itemSlot, bravo_itemSlot = alpha[8], bravo[8]
		if alpha_itemSlot and not bravo_itemSlot then
			return true
		elseif not alpha_itemSlot and bravo_itemSlot then
			return false
		elseif alpha_itemSlot and bravo_itemSlot then
			return alpha_itemSlot < bravo_itemSlot
		end
	else
		if auraSort__isFriend then
			-- sort by dispel type
			local alpha_dispelType, bravo_dispelType = alpha[5], bravo[5]
			if alpha_dispelType ~= bravo_dispelType then
				if not alpha_dispelType then
					return false
				elseif not bravo_dispelType then
					return true
				end
				local canDispel_alpha_dispelType = canDispel[alpha_dispelType]
				if not canDispel_alpha_dispelType ~= not canDispel[bravo_dispelType] then
					-- show debuffs you can dispel first
					if canDispel_alpha_dispelType then
						return true
					else
						return false
					end
				end
				return alpha_dispelType < bravo_dispelType
			end
		end
	end
	
	-- sort by name
	local alpha_name, bravo_name = alpha[2], bravo[2]
	if alpha_name ~= bravo_name then
		if not alpha_name then
			return false
		elseif not bravo_name then
			return true
		end
		if auraSort__isBuff then
			if auraSort__isFriend then
				-- show buffs you can cast first
				local alpha_isMyBuff = allFriendlyBuffs[alpha_name]
				local bravo_isMyBuff = allFriendlyBuffs[bravo_name]
				if not alpha_isMyBuff ~= not bravo_isMyBuff then
					if alpha_isMyBuff then
						return true
					else
						return false
					end
				end
			end
		else
			if auraSort__isFriend then
				-- show debuffs you can cast first
				local alpha_isMyDebuff = allFriendlyDebuffs[alpha_name]
				local bravo_isMyDebuff = allFriendlyDebuffs[bravo_name]
				if not alpha_isMyDebuff ~= not bravo_isMyDebuff then
					if alpha_isMyDebuff then
						return true
					else
						return false
					end
				end
			else	
				local alpha_isMyDebuff = enemyDebuffs[alpha_name]
				local bravo_isMyDebuff = enemyDebuffs[bravo_name]
				if not alpha_isMyDebuff ~= not bravo_isMyDebuff then
					if alpha_isMyDebuff then
						return true
					else
						return false
					end
				end
			end
		end
		return alpha_name < bravo_name
	end
	
	-- show your own buffs first
	local alpha_timeLeft, bravo_timeLeft = alpha[7], bravo[7]
	if not alpha_timeLeft ~= not bravo_timeLeft then
		if alpha_timeLeft then
			return true
		else
			return false
		end
	end
	
	-- keep ID order
	local alpha_id, bravo_id = alpha[1], bravo[1]
	if not alpha_id then
		return false
	elseif not bravo_id then
		return true
	end
	return alpha_id < bravo_id
end

local function UpdateAuraType(unit, frame, isBuff)
	local auraContainer
	if isBuff then
		auraContainer = frame.auraContainer
	else
		auraContainer = frame.auraContainer2 or frame.auraContainer
	end
	if not auraContainer then
		return
	end
	local auraContainer_auras
	if isBuff then
		auraContainer_auras = auraContainer.buffs
		if not auraContainer_auras then
			auraContainer_auras = newList()
			auraContainer.buffs = auraContainer_auras
		end
	else
		auraContainer_auras = auraContainer.debuffs
		if not auraContainer_auras then
			auraContainer_auras = newList()
			auraContainer.debuffs = auraContainer_auras
		end
	end
	
	local profile = PitBull_Aura.db.profile
	local db = profile[frame.group]
	
	local sorting = db.sort
	local hasBorder = db.border[isBuff and "Buffs" or "Debuffs"]
	local colorBorder, borderColors, weaponBuffItemQuality
	if hasBorder then
		colorBorder = db.borderType[isBuff and "Buffs" or "Debuffs"]
		borderColors = PitBull_Aura.db.profile.colors[isBuff and "buffs" or "debuffs"]
		weaponBuffItemQuality = PitBull_Aura.db.profile.colors.weaponBuffItemQuality
	end
	local maxAuras = db[isBuff and "maxbuffs" or "maxdebuffs"]

	local isPlayer = UnitIsUnit(unit, "player")
	local isPet = not isPlayer and UnitIsUnit(unit, "pet")
	local isFriend = isPlayer or isPet or UnitIsFriend("player", unit)
	
	local filtering = db[isBuff and "buffFilter" or "debuffFilter"]
	local filterSelection, extraFilterSelection
	if filtering then
		if isBuff then
			if isFriend then
				filterSelection = profile.filter.buffs
				extraFilterSelection = profile.filter.extraBuffs
			else
				-- don't filter enemy buffs, ever
				filtering = false
			end
		else
			if isFriend then
				filterSelection = profile.filter.friendDebuffs
				extraFilterSelection = profile.filter.extraFriendDebuffs
			else
				filterSelection = profile.filter.enemyDebuffs
				extraFilterSelection = profile.filter.extraEnemyDebuffs
			end
		end
	end
	
	local list = newList()
	if unit == "player" then
		if isBuff and not profile.player.hiddenWeaponBuffs then
			if #list < maxAuras then
				local mainhandItemBuff, mainhandTimeLeft, mainhandCount = PitBull_Aura:GetMainHandItemBuffInfo()
				if mainhandItemBuff then
					local link = GetInventoryItemLink("player", 16)
					if link then
						local weapon, _, quality, _, _, _, _, _, _, texture = GetItemInfo(GetInventoryItemLink("player", 16))
						if profile.weaponBuffSpellIcon then
							texture = guessSpellIcon[mainhandItemBuff] or select(10, GetItemInfo(weapon)) or texture
						end
						local duration = getPlayerAuraDuration(true, mainhandItemBuff, mainhandTimeLeft)
						list[#list + 1] = newList(0, weapon, texture, mainhandCount, nil, duration, mainhandTimeLeft, 16, quality)
					end
				end
			end
			if #list < maxAuras then
				local offhandItemBuff, offhandTimeLeft, offhandCount = PitBull_Aura:GetOffHandItemBuffInfo()
				if offhandItemBuff then
					local link = GetInventoryItemLink("player", 17)
					if link then
						local weapon, _, quality, _, _, _, _, _, _, texture = GetItemInfo(GetInventoryItemLink("player", 17))
						if profile.weaponBuffSpellIcon then
							texture = guessSpellIcon[offhandItemBuff] or select(10, GetItemInfo(weapon)) or texture
						end
						local duration = getPlayerAuraDuration(true, offhandItemBuff, offhandTimeLeft)
						list[#list + 1] = newList(0, weapon, texture, offhandCount, nil, duration, offhandTimeLeft, 17, quality)
					end
				end
			end
		end
		local i = 1
		local id
		while true do
			if not sorting and #list >= maxAuras then
				break
			end
			id = GetPlayerBuff(i, isBuff and "HELPFUL" or "HARMFUL")
			if id == 0 then
				break
			end
			local name, iconTexture, count, debuffType, timeLeft = GetPlayerBuffName(id), GetPlayerBuffTexture(id), GetPlayerBuffApplications(id), GetPlayerBuffDispelType(id), GetPlayerBuffTimeLeft(id)
			local duration = getPlayerAuraDuration(isBuff, name, timeLeft)
			
			local filtered = false
			if filtering and not extraFilterSelection[name] then
				if not filterSelection[name] then
					filtered = true
				elseif isBuff then
					filtered = not totalSelfBuffs[name]
				else
					filtered = not canDispel[debuffType] and not totalSelfDebuffs[name]
				end
			end
			if not filtered then
				list[#list+1] = newList(i, name, iconTexture, count, debuffType, duration, timeLeft)
			end
			i = i + 1
		end
	else
		local id = 1
		while true do
			if not sorting and #list >= maxAuras then
				break
			end
			local name, rank, iconTexture, count, debuffType, duration, timeLeft = UnitAura(isBuff, unit, id)
			if not name then
				break
			end
			local filtered = false
			if filtering and not extraFilterSelection[name] then
				if not filterSelection[name] then
					filtered = true
				elseif isBuff then
					if isPet then
						filtered = not totalPetBuffs[name]
					elseif isFriend then
					 	filtered = not friendBuffs[name]
					end
				else
					if isPet then
						filtered = not canDispel[debuffType] and not totalPetDebuffs[name]
					elseif isFriend then
						filtered = not canDispel[debuffType] and not friendDebuffs[name]
					else
						filtered = not enemyDebuffs[name]
					end
				end
			end
			if not filtered then
				list[#list+1] = newList(id, name, iconTexture, count, debuffType, duration, timeLeft)
			end
			id = id + 1
		end
	end

	if sorting then
		auraSort__isFriend = isFriend
		auraSort__isBuff = isBuff
		local len = #list
		table_sort(list, auraSort)
		if len ~= #list then
			error(("Sorting issue, please report to ckknight. (%d, %d, %s, %s, %s, %s)"):format(len, #list, tostring(unit), tostring(isFriend), tostring(isBuff), tostring(filtering)))
		end
		
		for i = maxAuras+1, #list do
			list[i] = del(list[i])
		end
	end
	
	if configMode then
		for i = #list+1, maxAuras do
			list[i] = newList(0, "Test", isBuff and [[Interface\Icons\Temp]] or [[Interface\Icons\INV_Misc_Bone_HumanSkull_01]], i)
		end
	end
	
	for i = #auraContainer_auras, #list+1, -1 do
		auraContainer_auras[i] = delFrame(auraContainer_auras[i])
	end

	if #list == 0 then
		list = del(list)
		if isBuff then
			auraContainer.buffs = del(auraContainer_auras)
		else
			auraContainer.debuffs = del(auraContainer_auras)
		end
		return
	end
	
	for i,v in ipairs(list) do
		local aura = auraContainer_auras[i]
		if not aura then
			aura = newFrame("AuraFrame", auraContainer, unit, isBuff)
			auraContainer_auras[i] = aura
		end
		
		local id, name, iconTexture, count, debuffType, duration, timeLeft, itemSlot, itemQuality = unpack(v)
		
		aura.id = id
		aura.itemSlot = itemSlot
		aura.isPlayer = isPlayer
		aura.icon:SetTexture(iconTexture)
		
		aura.applicationText:SetText(count > 1 and count or "")
		local font, _, style = aura.applicationText:GetFont()
		aura.applicationText:SetFont(font, db.fontSize, style)

		
		if hasBorder then
			local border = aura.border
			border:Show()
			if colorBorder then
				if isBuff then
					if itemQuality then
						if weaponBuffItemQuality then
							local r, g, b = GetItemQualityColor(itemQuality)
							border:SetVertexColor(r, g, b, 1)
						else
							border:SetVertexColor(unpack(borderColors.Weapon))
						end
					elseif duration and duration > 0 and not isPlayer then
						border:SetVertexColor(unpack(borderColors.Own))
					else
						border:SetVertexColor(unpack(borderColors["nil"]))
					end
				else
					if debuffType then
						border:SetVertexColor(unpack(borderColors[debuffType]))
					else
						border:SetVertexColor(unpack(borderColors["nil"]))
					end
				end
			else
				border:SetVertexColor(unpack(borderColors["nil"]))
			end
		else
			aura.border:Hide()
		end
		
		if duration and duration > 0 then
			local finishTime = GetTime() + timeLeft
			if profile.cooldown then
				aura.cooldown:Show()
				aura.cooldown:SetCooldown(finishTime - duration, duration)
			else
				aura.cooldown:Hide()
			end
			
			if profile.cooldownText then
				aura.cooldownTextFrame:Show()
				local cooldownText = aura.cooldownText
				cooldownText.finishTime = finishTime
				local font, _, style = cooldownText:GetFont()
				cooldownText:SetFont(font, db.fontSize, style)
			else
				aura.cooldownTextFrame:Hide()
				aura.cooldownText.finishTime = nil
			end
		else
			aura.cooldown:Hide()
			
			aura.cooldownTextFrame:Hide()
			aura.cooldownText.finishTime = nil
		end
	end
	list = del(list)
end
PitBull_Aura.UpdateAuraType = UpdateAuraType

function PitBull_Aura:OnChangeConfigMode(value)
	configMode = value
	for unit, frame in PitBull:IterateUnitFrames() do
		self:UpdateAuras(unit, frame)
	end
end

local HOUR_ONELETTER_ABBR = _G.HOUR_ONELETTER_ABBR:gsub("%s", "") -- "%dh"
local MINUTE_ONELETTER_ABBR = _G.MINUTE_ONELETTER_ABBR:gsub("%s", "") -- "%dm"
local function formatTime(seconds)
	if seconds >= 3600 then
		return HOUR_ONELETTER_ABBR:format(math_ceil(seconds/3600))
	elseif seconds >= 180 then
		return MINUTE_ONELETTER_ABBR:format(math_ceil(seconds/60))
	elseif seconds > 60 then
		seconds = math_ceil(seconds)
		return ("%d:%d"):format(seconds/60, seconds%60)
	else
		return ("%d"):format(math_ceil(seconds))
	end
end
local function UpdateAllCooldownTexts()
	local currentTime = GetTime()
	for frame in pairs(shownAuraFrames) do
		local cooldownText = frame.cooldownText
		local finishTime = cooldownText.finishTime
		if finishTime then
			local timeLeft = finishTime - currentTime
			if timeLeft >= 1 then
				cooldownText:SetText(formatTime(timeLeft))
			else
				cooldownText:SetText("")
			end
		end
	end
end

_G.table.insert(PitBull_Aura.OnEnable_funcs, function()
	PitBull_Aura:AddRepeatingTimer(0.2, UpdateAllCooldownTexts)
end)
