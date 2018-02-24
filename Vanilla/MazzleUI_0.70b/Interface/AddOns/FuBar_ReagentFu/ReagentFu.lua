ReagentFu = AceLibrary("AceAddon-2.0"):new("AceEvent-2.0", "AceConsole-2.0", "AceDB-2.0","FuBarPlugin-2.0")

local L = AceLibrary("AceLocale-2.1"):GetInstance("ReagentFu", true);
local dewdrop = AceLibrary("Dewdrop-2.0");
local tablet = AceLibrary("Tablet-2.0");
local crayon = AceLibrary("Crayon-2.0")

local reagentCount = {};

ReagentFu.hasIcon = "Interface\\Icons\\INV_Misc_Book_09"
ReagentFu.defaultPosition = "LEFT"

ReagentFu:RegisterDB("ReagentFuDB")
ReagentFu:RegisterDefaults("profile", {
	showShortNames = false,
});
ReagentFu:RegisterDefaults("char", {
	showReagent = {},
});

local options = {
    type='group',
    args = {
		shortnames = {
			type = "toggle",
			name = L"Show short names",
			desc = L"Show short reagent names in FuBar text",
			get = function() return ReagentFu.db.profile.showShortNames end,
			set = function()
				ReagentFu.db.profile.showShortNames = not ReagentFu.db.profile.showShortNames
				ReagentFu:Update()
			end,
		},

	}
}
ReagentFu:RegisterChatCommand({"/reagentfu"}, options)


	-- Methods
function ReagentFu:IsShowingShortNames()
	return self.db.profile.showShortNames
end

function ReagentFu:ToggleShowingShortNames()
	self.db.profile.showShortNames = not self.db.profile.showShortNames
	self:Update()
	return self.db.profile.showShortNames
end

function ReagentFu:IsShowing(reagent)
	return self.db.char.showReagent[reagent]
end

function ReagentFu:ToggleShowing(reagent)
	self.db.char.showReagent[reagent] = not self.db.char.showReagent[reagent]
	self:Update()
	return self.db.char.showReagent[reagent]
end

function ReagentFu:OnInitialize()
	_,self.char_class = UnitClass("player")
	if self:TCount(self.db.char.showReagent) == 0 then
		if self.char_class == "DRUID" then
			self.db.char.showReagent[L"Wild Berries"] = true
			self.db.char.showReagent[L"Wild Thornroot"] = true
			self.db.char.showReagent[L"Maple Seed"] = true
			self.db.char.showReagent[L"Stranglethorn Seed"] = true
			self.db.char.showReagent[L"Ashwood Seed"] = true
			self.db.char.showReagent[L"Hornbeam Seed"] = true
			self.db.char.showReagent[L"Ironwood Seed"] = true
		elseif self.char_class == "MAGE" then
			self.db.char.showReagent[L"Arcane Powder"] = true
			self.db.char.showReagent[L"Rune of Teleportation"] = true
			self.db.char.showReagent[L"Rune of Portals"] = true
			self.db.char.showReagent[L"Light Feather"] = true
		elseif self.char_class == "PALADIN" then
			self.db.char.showReagent[L"Symbol of Divinity"] = true
			self.db.char.showReagent[L"Symbol of Kings"] = true
		elseif self.char_class == "PRIEST" then
			self.db.char.showReagent[L"Holy Candle"] = true
			self.db.char.showReagent[L"Sacred Candle"] = true
			self.db.char.showReagent[L"Light Feather"] = true
		elseif self.char_class == "ROGUE" then
			self.db.char.showReagent[L"Flash Powder"] = true
			self.db.char.showReagent[L"Blinding Powder"] = true
		    self.db.char.showReagent[L"Thistle Tea"] = true
		    self.db.char.showReagent[L"Instant Poison"] = true
		    self.db.char.showReagent[L"Deadly Poison"] = true
		    self.db.char.showReagent[L"Crippling Poison"] = true
		    self.db.char.showReagent[L"Mind-numbing Poison"] = true
		    self.db.char.showReagent[L"Wound Poison"] = true
		elseif self.char_class == "SHAMAN" then
			self.db.char.showReagent[L"Ankh"] = true
			self.db.char.showReagent[L"Shiny Fish Scales"] = true
			self.db.char.showReagent[L"Fish Oil"] = true
		elseif self.char_class == "WARLOCK" then
			self.db.char.showReagent[L"Soul Shard"] = true
			self.db.char.showReagent[L"Healthstone"] = true
		    self.db.char.showReagent[L"Soulstone"] = true
		    self.db.char.showReagent[L"Spellstone"] = true
		    self.db.char.showReagent[L"Firestone"] = true
		else
			self:Hide()
		end
	end
	self.countValues = {}
end

function ReagentFu:OnEnable()
	if (self.char_class == "DRUID") then
		self:SetIcon("Interface\\Icons\\INV_Misc_Branch_01")
	elseif (self.char_class == "MAGE") then
		self:SetIcon("Interface\\Icons\\INV_Misc_Dust_01")
	elseif (self.char_class == "PALADIN") then
		self:SetIcon("Interface\\Icons\\INV_Stone_WeightStone_05")
	elseif (self.char_class == "PRIEST") then
		self:SetIcon("Interface\\Icons\\INV_Misc_Candle_03")
	elseif (self.char_class == "ROGUE") then
		self:SetIcon("Interface\\Icons\\INV_Misc_Powder_Purple")
	elseif (self.char_class == "SHAMAN") then
		self:SetIcon("Interface\\Icons\\INV_Jewelry_Talisman_06")
	elseif (self.char_class == "WARLOCK") then
		self:SetIcon("Interface\\Icons\\INV_Misc_Gem_Amethyst_02")
	else
		self:SetIcon("Interface\\Icons\\INV_Misc_Book_09")
	end
	self:RegisterEvent("BAG_UPDATE", "OnBagUpdate")
end

function ReagentFu:OnMenuRequest(level, value, inTooltip)
	if level == 1 then
		dewdrop:AddLine(
			'text', L"Show short names",
			'arg1', self,
			'func', "ToggleShowingShortNames",
			'checked', self:IsShowingShortNames(),
			'closeWhenClicked', false
		)
		
		dewdrop:AddLine()

		dewdrop:AddLine(
			'text', L"Reagents",
			'hasArrow', true,
			'value', "filter"
		)

		dewdrop:AddLine()

	elseif level == 2 then
		if value == "filter" then
			for reagent, t in pairs(self.db.char.showReagent) do
				dewdrop:AddLine(
					'text', reagent,
					'arg1', self,
					'func', "ToggleShowing",
					'arg2', reagent,
					'checked', self:IsShowing(reagent)
				)
			end
		end
	end
end

function ReagentFu:OnBagUpdate()
	self:Update()
end

function ReagentFu:OnDataUpdate()
	if (self.char_class == "DRUID") then
		self:GetDruidCount();
		self.countValues[1] = { item = L"Wild Berries", full = 20, short = L"Berry: " }
		self.countValues[2] = { item = L"Wild Thornroot", full = 20, short = L"Thornroot: " }
		self.countValues[3] = { item = L"Maple Seed", full = 20, short = L"Maple: " }
		self.countValues[4] = { item = L"Stranglethorn Seed", full = 20, short = L"Stranglethorn: " }
		self.countValues[5] = { item = L"Ashwood Seed", full = 20, short = L"Ashwood: " }
		self.countValues[6] = { item = L"Hornbeam Seed", full = 20, short = L"Hornbeam: " }
		self.countValues[7] = { item = L"Ironwood Seed", full = 20, short = L"Ironwood: " }
	elseif (self.char_class == "MAGE") then
		self:GetMageCount();
		self.countValues[1] = { item = L"Arcane Powder", full = 20, short = L"Powder: " }
		self.countValues[2] = { item = L"Rune of Teleportation", full = 10, short = L"Teleport: " }
		self.countValues[3] = { item = L"Rune of Portals", full = 10, short = L"Portal: " }
		self.countValues[4] = { item = L"Light Feather", full = 20, short = L"Feather: " }
	elseif (self.char_class == "PALADIN") then
		self:GetPallyCount();
		self.countValues[1] = { item = L"Symbol of Divinity", full = 20, short = L"Divinity: " }
		self.countValues[2] = { item = L"Symbol of Kings", full = 20, short = L"Kings: " }
	elseif (self.char_class == "PRIEST") then
		self:GetPriestCount();
		self.countValues[1] = { item = L"Holy Candle", full = 20, short = L"Holy: " }
		self.countValues[2] = { item = L"Sacred Candle", full = 20, short = L"Sacred: " }
		self.countValues[3] = { item = L"Light Feather", full = 20, short = L"Feather: " }
	elseif (self.char_class == "ROGUE") then
		self:GetRogueCount();
		self.countValues[1] = { item = L"Flash Powder", full = 10, short = L"Flash: " }
		self.countValues[2] = { item = L"Blinding Powder", full = 20, short = L"Blinding: " }
		self.countValues[3] = { item = L"Thistle Tea", full = 10, short = L"Thistle: " }
		self.countValues[4] = { item = L"Instant Poison", full = 10, short = L"Poison: " }
		self.countValues[5] = { item = L"Deadly Poison", full = 10, short = L"Poison: " }
		self.countValues[6] = { item = L"Crippling Poison", full = 10, short = L"Poison: " }
		self.countValues[7] = { item = L"Mind-numbing Poison", full = 10, short = L"Poison: " }
		self.countValues[8] = { item = L"Wound Poison", full = 10, short = L"Poison: " }
	elseif (self.char_class == "SHAMAN") then
		self:GetShamanCount();
		self.countValues[1] = { item = L"Ankh", full = 5, short = L"Ankh: " }
		self.countValues[2] = { item = L"Shiny Fish Scales", full = 20, short = L"Scales: " }
		self.countValues[3] = { item = L"Fish Oil", full = 20, short = L"Oil: " }
	elseif (self.char_class == "WARLOCK") then
		self:GetLockCount();
		self.countValues[1] = { item = L"Soul Shard", full = 10, short = L"Soul Shard" }
		self.countValues[2] = { item = L"Soulstone", full = 1, short = L"Soulstone" }
		self.countValues[3] = { item = L"Healthstone", full = 1, short = L"Healthstone" }
		self.countValues[4] = { item = L"Firestone", full = 1, short = L"Firestone" }
		self.countValues[5] = { item = L"Spellstone", full = 1, short = L"Spellstone" }
	end
end

function ReagentFu:OnTextUpdate()
	local count_string = ""
	local itemcount = 0;
	if not (self.char_class == "ROGUE") then
		for i, t in ipairs(self.countValues) do
			if self:IsShowing(t.item) then
				if not (count_string == "") then
					count_string = count_string.."/"
				end
				if self:IsShowingShortNames() then
					count_string = count_string..t.short
				end
				if reagentCount[t.item] ~= nil then
					itemcount = reagentCount[t.item];
				else
					itemcount = 0;
				end
				count_string = count_string..format("|cff%s%d|r", crayon:GetThresholdHexColor(itemcount / t.full), itemcount)
			end
		end
	else
		local flash = self.countValues[1]
		local blind = self.countValues[2]
		local thistle = self.countValues[3]
		local instant = self.countValues[4]
		local deadly = self.countValues[5]
		local crippling = self.countValues[6]
		local mindnumb = self.countValues[7]
		local wound = self.countValues[8]
		if self:IsShowing(flash.item) then
			if not (count_string == "") then
				count_string = count_string.."/"
			end
			if self:IsShowingShortNames() then
				count_string = count_string..flash.short
			end
			count_string = count_string..format("|cff%s%d|r", crayon:GetThresholdHexColor(reagentCount[flash.item] / flash.full), reagentCount[flash.item])
		end
		if self:IsShowing(blind.item) then
			if not (count_string == "") then
				count_string = count_string.."/"
			end
			if self:IsShowingShortNames() then
				count_string = count_string..blind.short
			end
			count_string = count_string..format("|cff%s%d|r", crayon:GetThresholdHexColor(reagentCount[blind.item] / blind.full), reagentCount[blind.item])
		end
		if self:IsShowing(thistle.item) then
			if not (count_string == "") then
				count_string = count_string.."/"
			end
			if self:IsShowingShortNames() then
				count_string = count_string..thistle.short
			end
			count_string = count_string..format("|cff%s%d|r", crayon:GetThresholdHexColor(reagentCount[thistle.item] / thistle.full), reagentCount[thistle.item])
		end
		if (self:IsShowing(L"Instant Poison") or self:IsShowing(L"Deadly Poison") or
				self:IsShowing(L"Crippling Poison") or self:IsShowing(L"Mind-numbing Poison") or
				self:IsShowing(L"Wound Poison")) then
			local poisons = 0;
			if self:IsShowing(L"Instant Poison") then
				poisons = poisons + reagentCount[L"Instant Poison"]
			end
			if self:IsShowing(L"Deadly Poison") then
				poisons = poisons + reagentCount[L"Deadly Poison"]
			end
			if self:IsShowing(L"Crippling Poison") then
				poisons = poisons + reagentCount[L"Crippling Poison"]
			end
			if self:IsShowing(L"Mind-numbing Poison") then
				poisons = poisons + reagentCount[L"Mind-numbing Poison"]
			end
			if self:IsShowing(L"Wound Poison") then
				poisons = poisons + reagentCount[L"Wound Poison"]
			end
			if not (count_string == "") then
				count_string = count_string.."/"
			end
			if self:IsShowingShortNames() then
				count_string = count_string..L"Poison: "
			end
			count_string = count_string..format("|cff%s%d|r", crayon:GetThresholdHexColor(poisons / 10), poisons)
		end
	end
	
	self:SetText(count_string)
end

function ReagentFu:OnTooltipUpdate()
	local cat = tablet:AddCategory('columns', 2, 'child_textR', 0, 'child_textG', 1, 'child_textB', 0)
	local r, g, b
	local lines_added = false
	local itemcount = 0;
	for i, t in ipairs(self.countValues) do
		if self:IsShowing(t.item) then
			if reagentCount[t.item] ~= nil then
				itemcount = reagentCount[t.item];
			else
				itemcount = 0;
			end
			r, g, b = crayon:GetThresholdColor(itemcount / t.full)
			cat:AddLine('text',t.item..":", 'text2', itemcount, 'text2R', r, 'text2G', g, 'text2B', b)
			lines_added = true
		end
	end
	if lines_added == false then
		cat:AddLine('text', L"No reagents to track.")
	end
end

function ReagentFu:GetMageCount()
	local powder = 0;
	local teleport = 0;
	local portal = 0;
	local feather = 0;
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot = 1, size, 1 do
				local _,itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = self:NameFromLink(GetContainerItemLink(bag, slot));
					if ((itemName) and (itemName ~= "")) then
						if (itemName == L"Arcane Powder") then
							powder = powder + itemCount;
						elseif (itemName == L"Rune of Teleportation") then
							teleport = teleport + itemCount;
						elseif (itemName == L"Rune of Portals") then
							portal = portal + itemCount;
						elseif (itemName == L"Light Feather") then
							feather = feather + itemCount;
						end
					end
				end
			end
		end
	end
	reagentCount[L"Arcane Powder"] = powder;
	reagentCount[L"Rune of Teleportation"] = teleport;
	reagentCount[L"Rune of Portals"] = portal;
	reagentCount[L"Light Feather"] = feather;
end

function ReagentFu:GetRogueCount()
	local flash = 0
	local blind = 0
	local thistle = 0
	local instant = 0
	local deadly = 0
	local crippling = 0
	local mindnumb = 0
	local wound = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local _,itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = self:NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
						if (itemName == L"Flash Powder") then
							flash  = flash + itemCount;
						elseif (itemName == L"Blinding Powder") then
							blind  = blind + itemCount;
						elseif (itemName == L"Thistle Tea") then
							thistle  = thistle + itemCount;
						elseif (string.find(itemName,L"Instant Poison",1,true)) then
							instant  = instant + itemCount;
						elseif (string.find(itemName,L"Deadly Poison",1,true)) then
							deadly  = deadly + itemCount;
						elseif (string.find(itemName,L"Crippling Poison",1,true)) then
							crippling  = crippling + itemCount;
						elseif (string.find(itemName,L"Mind-numbing Poison",1,true)) then
							mindnumb  = mindnumb + itemCount;
						elseif (string.find(itemName,L"Wound Poison",1,true)) then
							wound  = wound + itemCount;
						end
					end
				end            
			end
		end
	end
	reagentCount[L"Flash Powder"] = flash;
	reagentCount[L"Blinding Powder"] = blind;
	reagentCount[L"Thistle Tea"] = thistle;
	reagentCount[L"Instant Poison"] = instant;
	reagentCount[L"Deadly Poison"] = deadly;
	reagentCount[L"Crippling Poison"] = crippling;
	reagentCount[L"Mind-numbing Poison"] = mindnumb;
	reagentCount[L"Wound Poison"] = wound;
end

function ReagentFu:GetLockCount()
	local shard = 0
	local soulstone = 0
	local firestone = 0
	local healthstone = 0
	local spellstone = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local _,itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = self:NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
						if (itemName == L"Soul Shard") then
							shard  = shard + itemCount;
						elseif (string.find(itemName,L"Soulstone",1,true)) then
							soulstone  = soulstone + itemCount;
						elseif (string.find(itemName,L"Firestone",1,true)) then
							firestone  = firestone + itemCount;
						elseif (string.find(itemName,L"Healthstone",1,true)) then
							healthstone  = healthstone + itemCount;
						elseif (string.find(itemName,L"Spellstone",1,true)) then
							spellstone  = spellstone + itemCount;
						end
					end
				end
			end            
		end
	end	
	reagentCount[L"Soul Shard"] = shard;
	reagentCount[L"Soulstone"] = soulstone;
	reagentCount[L"Firestone"] = firestone;
	reagentCount[L"Healthstone"] = healthstone;
	reagentCount[L"Spellstone"] = spellstone;
end

function ReagentFu:GetShamanCount()
	local ankh = 0
	local scales = 0
	local fishoil = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local _,itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = self:NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
						if (itemName == L"Ankh") then
							ankh  = ankh + itemCount;
						elseif (itemName == L"Shiny Fish Scales") then
							scales = scales + itemCount;
						elseif (itemName == L"Fish Oil") then
							fishoil  = fishoil + itemCount;
						end
					end
				end
			end            
		end
	end	
	reagentCount[L"Ankh"] = ankh;
	reagentCount[L"Shiny Fish Scales"] = scales;
	reagentCount[L"Fish Oil"] = fishoil;
end

function ReagentFu:GetPallyCount()
	local divinity = 0
	local kings = 0
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local _,itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = self:NameFromLink(GetContainerItemLink(bag, slot));
					if ((itemName) and (itemName ~= "")) then
						if (itemName == L"Symbol of Divinity") then
							divinity  = divinity + itemCount;
						elseif (itemName == L"Symbol of Kings") then
							kings = kings + itemCount;
						end
					end
				end
			end            
		end
	end	
	reagentCount[L"Symbol of Divinity"] = divinity;
	reagentCount[L"Symbol of Kings"] = kings;
	return divinity,kings
end

function ReagentFu:GetPriestCount()
	local holy = 0;
	local sacred = 0;
	local feather = 0;
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local _,itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = self:NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
						if (itemName == L"Holy Candle") then
							holy = holy + itemCount;
						elseif (itemName == L"Sacred Candle") then
							sacred = sacred + itemCount;
						elseif (itemName == L"Light Feather") then
							feather = feather + itemCount;
						end
					end
				end
			end   
		end
	end	
	reagentCount[L"Holy Candle"] = holy;
	reagentCount[L"Sacred Candle"] = sacred;
	reagentCount[L"Light Feather"] = feather;
end

function ReagentFu:GetDruidCount()
	local wildberry = 0;
	local thornroot = 0;
	local maple = 0;
	local strangle = 0;
	local ash = 0;
	local horn = 0;
	local iron = 0;
	for bag = 4, 0, -1 do
		local size = GetContainerNumSlots(bag);
		if (size > 0) then
			for slot=1, size, 1 do
				local _,itemCount = GetContainerItemInfo(bag, slot);
				if (itemCount) then
					local itemName = self:NameFromLink(GetContainerItemLink(bag, slot));	
					if  ((itemName) and (itemName ~= "")) then
						if (itemName == L"Wild Berries") then
							wildberry = wildberry + itemCount;
						elseif (itemName == L"Wild Thornroot") then
							thornroot = thornroot + itemCount;
						elseif (itemName == L"Maple Seed") then
							maple = maple + itemCount;
						elseif (itemName == L"Stranglethorn Seed") then
							strangle = strangle + itemCount;
						elseif (itemName == L"Ashwood Seed") then
							ash = ash + itemCount;
						elseif (itemName == L"Hornbeam Seed") then
							horn = horn + itemCount;
						elseif (itemName == L"Ironwood Seed") then
							iron = iron + itemCount;
						end
					end
				end
			end            
		end
	end	
	reagentCount[L"Wild Berries"] = wildberry;
	reagentCount[L"Wild Thornroot"] = thornroot;
	reagentCount[L"Maple Seed"] = maple;
	reagentCount[L"Stranglethorn Seed"] = strangle;
	reagentCount[L"Ashwood Seed"] = ash;
	reagentCount[L"Hornbeam Seed"] = horn;
	reagentCount[L"Ironwood Seed"] = iron;
end

function ReagentFu:NameFromLink(link)
	if (link) then
		return GetItemInfo(tonumber(string.gsub(link, "|cff%x%x%x%x%x%x|Hitem:(%d+):%d+:%d+:%d+|h.*", "%1") or 0))
	end
end

function ReagentFu:TCount(tab)
	local n=0;
	for _ in pairs(tab) do
		n=n+1;
	end
	return n;
end
