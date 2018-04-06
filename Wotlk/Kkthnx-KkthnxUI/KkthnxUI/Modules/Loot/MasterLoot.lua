local K, C, L, _ = select(2, ...):unpack()
if C.Loot.Enable ~= true then return end

local format = string.format
local pairs = pairs
local ipairs = ipairs
local select = select
local random = math.random
local RAID_CLASS_COLORS = RAID_CLASS_COLORS

-- MasterLoot module
local hexColors = {}
for k, v in pairs(RAID_CLASS_COLORS) do
	hexColors[k] = format("|cff%02x%02x%02x", v.r * 255, v.g * 255, v.b * 255)
end
hexColors["UNKNOWN"] = format("|cff%02x%02x%02x", 0.6*255, 0.6*255, 0.6*255)

if CUSTOM_CLASS_COLORS then
	local function update()
		for k, v in pairs(CUSTOM_CLASS_COLORS) do
			hexColors[k] = ("|cff%02x%02x%02x"):format(v.r * 255, v.g * 255, v.b * 255)
		end
	end
	CUSTOM_CLASS_COLORS:RegisterCallback(update)
	update()
end

local playerName = UnitName("player")
local unknownColor = { r = .6, g = .6, b = .6 }
local classesInRaid = {}
local randoms = {}
local function CandidateUnitClass(candidate)
	local class, fileName = UnitClass(candidate)
	if class then
		return class, fileName
	end
	return L_ML_UNKNOWN, "UNKNOWN"
end

local function init()
	local candidate, color
	local info = UIDropDownMenu_CreateInfo()

	if UIDROPDOWNMENU_MENU_LEVEL == 2 then
		-- raid class menu
		for i = 1, 40 do
			candidate = GetMasterLootCandidate(i)
			if candidate then
				local class = select(2, CandidateUnitClass(candidate))
				if class == UIDROPDOWNMENU_MENU_VALUE then -- we check for not class adding everyone that left the raid to every menu to prevent not being able to loot to them
					-- Add candidate button
					info.text = candidate -- coloredNames[candidate]
					info.colorCode = hexColors[class] or hexColors["UNKOWN"]
					info.textHeight = 12
					info.value = i
					info.notCheckable = 1
					info.disabled = nil
					info.func = GroupLootDropDown_GiveLoot
					UIDropDownMenu_AddButton(info,UIDROPDOWNMENU_MENU_LEVEL)
				end
			end
		end
		return
	end

	info.isTitle = 1
	info.text = GIVE_LOOT
	info.textHeight = 12
	info.notCheckable = 1
	info.disabled = nil
	info.notClickable = nil
	UIDropDownMenu_AddButton(info)

	if ( GetNumRaidMembers() > 0 ) then
		-- In a raid
		for k, v in pairs(classesInRaid) do
			classesInRaid[k] = nil
		end
		for i = 1, 40 do
			candidate = GetMasterLootCandidate(i)
			if candidate then
				local cname, class = CandidateUnitClass(candidate)
				classesInRaid[class] = cname
			end
		end

		for k, v in pairs(classesInRaid) do
			info.isTitle = nil
			info.text = v -- classColors[k]..v.."|r"
			info.colorCode = hexColors[k] or hexColors["UNKOWN"]
			info.textHeight = 12
			info.hasArrow = 1
			info.notCheckable = 1
			info.value = k
			info.func = nil
			info.disabled = nil
			UIDropDownMenu_AddButton(info)
		end
	else
		-- In a party
		for i=1, MAX_PARTY_MEMBERS + 1, 1 do
			candidate = GetMasterLootCandidate(i)
			if candidate then
				-- Add candidate button
				info.text = candidate -- coloredNames[candidate]
				info.colorCode = hexColors[select(2,CandidateUnitClass(candidate))] or hexColors["UNKOWN"]
				info.textHeight = 12
				info.value = i
				info.notCheckable = 1
				info.hasArrow = nil
				info.isTitle = nil
				info.disabled = nil
				info.func = GroupLootDropDown_GiveLoot
				UIDropDownMenu_AddButton(info)
			end
		end
	end

	for k, v in pairs(randoms) do randoms[k] = nil end
	for i = 1, 40 do
		candidate = GetMasterLootCandidate(i)
		if candidate then
			table.insert(randoms, i)
		end
	end
	if #randoms > 0 then
		info.colorCode = "|cffffffff"
		info.isTitle = nil
		info.textHeight = 12
		info.value = randoms[random(1, #randoms)]
		info.notCheckable = 1
		info.text = "Random"
		info.func = GroupLootDropDown_GiveLoot
		info.icon = nil--"Interface\\Buttons\\UI-GroupLoot-Dice-Up"
		UIDropDownMenu_AddButton(info)
	end
	for i = 1, 40 do
		candidate = GetMasterLootCandidate(i)
		if candidate and candidate == playerName then
			info.colorCode = hexColors[select(2,CandidateUnitClass(candidate))] or hexColors["UNKOWN"]
			info.isTitle = nil
			info.textHeight = 12
			info.value = i
			info.notCheckable = 1
			info.text = "Self"
			info.func = GroupLootDropDown_GiveLoot
			info.icon = nil--"Interface\\Buttons\\UI-GroupLoot-Coin-Up"
			UIDropDownMenu_AddButton(info)
		end
	end
end

UIDropDownMenu_Initialize(GroupLootDropDown, init, "MENU")