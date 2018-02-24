--Regester new addon object
Mendeleev = AceLibrary("AceAddon-2.0"):new("AceConsole-2.0", "AceEvent-2.0", "AceDB-2.0", "AceHook-2.1", "AceDebug-2.0")
Mendeleev:RegisterDB("MendeleevDB")
local L = AceLibrary("AceLocale-2.2"):new("Mendeleev")

------------
-- HOOKS ---
------------

local linkFuncs = {
	SetAuctionItem     = GetAuctionItemLink,
	SetBagItem         = GetContainerItemLink,
	SetCraftItem       = function(skill, id) return (id) and GetCraftReagentItemLink(skill, id) or GetCraftItemLink(skill) end,
	SetHyperlink       = function(link) return link end,
	SetInventoryItem   = function(type, slot) return (type) and GetInventoryItemLink(type, slot) or GetContainerItemLink(BANK_CONTAINER,this:GetID()) end,
	SetLootItem        = GetLootSlotLink,
	SetMerchantItem    = GetMerchantItemLink,
	SetQuestItem       = GetQuestItemLink,
	SetQuestLogItem    = GetQuestLogItemLink,
	SetTradePlayerItem = GetTradePlayerItemLink,
	SetTradeSkillItem  = function(skill, id) return (id) and GetTradeSkillReagentItemLink(skill, id) or GetTradeSkillItemLink(skill) end,
	SetTradeTargetItem = GetTradeTargetItemLink,
	SetInboxItem       = function(index) return Mendeleev:FindItemID(GetInboxItem(index)) end,
	SetLootRollItem    = function(index) return GetLootRollItemLink(index) end,
}

function Mendeleev:SetItemRef(link, text, button)
	self.hooks["SetItemRef"](link, text, button)
	if (not strfind(link, "item") or IsControlKeyDown() or IsShiftKeyDown()) then return; end
	self:ParseTooltip(ItemRefTooltip, link)
end

function Mendeleev:FindItemID(name)
	if not name then return end
	if self.linkcache[name] then return self.linkcache[name] end

	local i, max = 1, 50000

	repeat
		if GetItemInfo(i) == name then
			local _, link = GetItemInfo(i)
			self.linkcache[name] = link
			return link
		end
		i = i+1
	until i > max
end

function Mendeleev:HookTooltips()
	for key, value in pairs(linkFuncs) do
		local orig, linkFunc = key,value
		local func = function(tooltip,a,b,c)
			local r1,r2,r3 = self.hooks[tooltip][orig](tooltip,a,b,c)
			self:ParseTooltip(tooltip,linkFunc(a,b,c))
			return r1,r2,r3
		end
		self:Hook(GameTooltip, orig, func)
	end
	self:Hook("SetItemRef")
end

--Ace methods
function Mendeleev:OnInitialize()
	if (KC_Items and KC_Items.tooltip) then
		if(self.db.profile.KCI == true)then
			KC_Items.tooltip:RegisterFunc(self, "DisplayTooltip")
		else
			self:HookTooltips()
		end
	else
		self:HookTooltips()
	end

	self.link = ""
	self.TT = {}
	self.linkcache = {}
	setmetatable(self.linkcache, {__mode = "k"})

	self.compost = AceLibrary("Compost-2.0")
	self.PT = PeriodicTableEmbed:GetInstance("1")
	self.PTTrade = PTTradeskillsEmbed:GetInstance("1")

	self:BuildOptions()
	self:RegisterChatCommand({"/mend", "/mendeleev"}, self.options)
end

function Mendeleev:Disable()
	if (KC_Items and KC_Items.tooltip) then
		if(self.db.profile.KCI == true)then
			KC_Items.tooltip:UnregisterFunc(self, "DisplayTooltip")
		else
			self:UnhookAll()
		end
	else
		self:UnhookAll()
	end
end

--Mendeleev methods
function Mendeleev:DrawTooltip(frame)

	for _,z in ipairs(self.TT) do
		if (KC_Items and KC_Items.tooltip) then
			KC_Tooltip:AddTextLine(frame, z.Stringa, z.Stringb, " ", "|cffffffff")
		else
			frame:AddDoubleLine(z.Stringa,z.Stringb,1,1,1,1,1,1)
		end
	end
	frame:Show()
end

function Mendeleev:DisplayTooltip(tooltip, code, lcode, qty, hooker)
	self:ParseTooltip(tooltip,"item:"..lcode)
end

function Mendeleev:AddLine(Stringa,Stringb)
	local i = table.getn(self.TT) + 1
	local t = self.compost:Acquire()
	t.Stringa = Stringa
	t.Stringb = Stringb
	table.insert(self.TT, t)
end

function Mendeleev:ParseTooltip(frame,link,id)
	if(link == nil) then
		return
	end

	local _, _, tid = string.find(link, "item:(%d+):%d+:%d+:%d+")
	local id = tonumber(tid)

	if(link == self.link) then
		self:DrawTooltip(frame)
		return
	elseif(tid == nil) then
		return
	else
		self.link = link
		self.compost:Reclaim(self.TT, 1)
		self.TT = self.compost:Acquire()
	end

	Mendeleev:DoTooltip(frame,link,id)

	self:DrawTooltip(frame)
end

function Mendeleev:DoTooltip(frame,link,id)
	--Add the fixed Category information, Can be found in MendeleevGlobals.ua
	for _,v in ipairs(MendeleevLocals.infosets) do
		if(not self.db.profile[v.setindex]) then
			local z = self.PT:ItemInSets(link, v.setindex)
			local filter = v.filter and not self.PT:ItemInSet(link, v.filter)
            if z and not filter then
				local tline, header
				local colour = v.colour or "|cffffffff"

				for t,tt in pairs(z) do
					if v.sets[tt] then
						local val = self.PT:ItemInSet(link, tt)
						local valstr = val and v.useval and v.useval(val, link) or ""
						tline = (not tline and "") or tline..", "
						tline = tline.. v.sets[tt].. valstr
					else self:Debug(L["NoClue"]..tt)
					end

					if( t <= 2) then
						header = v.header
					else
						header = " "
					end
					header = colour..header.."|r"

					if(math.mod(t,2) == 0 and tline ~= nil) then
						self:AddLine(header,colour..tline.."|r")
						tline = nil
					end
				end
				if(tline and string.len(tline) > 0) then
					self:AddLine(header,colour..tline.."|r")
				end
				header = nil
			end
			self.compost:Reclaim(z)
		end
	end

	--Add the Trade recepies information.
	if (not self.db.profile.crafting) then
		self.rid2data = self.compost:Acquire()
		self.inTree = self.compost:Acquire()
		local t = self:GetUsedInTree(id)
		local l = self:GetUsedInList(t[2], 1)
		local header = L["Used in"]
		local ln = table.getn(l)
		if ln > 15 then ln = 14 end
		for i = 1, ln do
			if header then
				self:AddLine(header)
				header = nil
			end
			self:AddLine(l[i])
		end
		if table.getn(l) > 15 then
			self:AddLine("     ...")
		end
		self.compost:Reclaim(t)
		self.compost:Reclaim(l)
		self.compost:Reclaim(self.rid2data)
		self.rid2data = nil
		self.compost:Reclaim(self.inTree)
		self.inTree = nil
	end

	if (not self.db.profile.stacksize) then
		local _,_,_,_,_,_,stack = GetItemInfo(id)
		if(stack  and stack > 1)then
			self:AddLine(L["Stacksize"], stack)
		end
	end

	if (not self.db.profile.itemid) then
		self:AddLine(L["Item ID"], id)
	end
end

local function SortUsedInTree(a,b)
	if (not a or not b) then
		return true
	end
	if (a[3] > b[3]) then
		return true
	end
	if (a[3] < b[3]) then
		return false
	end
	if (a[1] < b[1]) then
		return true
	else
		return false
	end
end

function Mendeleev:GetUsedInTree(id, selfskill)
	local rt = self.compost:Acquire()
	local z = self.PTTrade:GetRecepieUse(id)
	local skill = selfskill or 0
	if z then
		for x,y in z do
			if not self.rid2data[x] then
				self.rid2data[x] = y
			end
			if y[2] > skill then
				skill = y[2]
			end
			if not self.inTree[x] then
				self.inTree[x] = true
				local data = self:GetUsedInTree(x, y[2])
				table.insert(rt, data)
				self.inTree[x] = nil
				if data[3] > skill then
					skill = data[3]
				end
			else
				table.insert(rt, self.compost:Acquire(x, "...", y[2]))
			end
		end
	end
	table.sort(rt, SortUsedInTree)
	return self.compost:Acquire(id, rt, skill)
end

function Mendeleev:GetUsedInList(tree, level)
	local colour = {
		[0] = "|cffbbbbbb",
		[1] = "|cff00cc00",
		[2] = "|cffffff00",
		[3] = "|cffFF6600",
		[4] = "|cffff0000",
	}

	local list = self.compost:Acquire()
	for _, v in tree do
		if level < 2 or v[3] > 0 then
			table.insert(list, string.rep("     ", level).."- "..colour[self.rid2data[v[1]][2]]..self.rid2data[v[1]][1].."|r")
			if type(v[2]) == "table" then
				local slist = self:GetUsedInList(v[2], level+1)
				if table.getn(slist) > 0 then
					if v[3] > 0 then
						for _, line in slist do
							table.insert(list, line)
						end
					else
						table.insert(list, string.rep("    ", level+1).."- "..colour[0].."...|r")
					end
				end
			elseif v[2] == "..." then
				table.insert(list, string.rep("    ", level+1).."  ...")
			end
		end
	end
	return list
end

function Mendeleev:BuildOptions()
	self.options = {
		type = "group",
		args = {
			[L["sets"]] = {
				name = L["toggle"],
				desc = L["Toggle Sets"],
				type = "group",
				args = {
				},
			},
			[L["integrate"]] = {
				type = "toggle",
				name = L["KCI Integration"],
				desc = L["Integrate into the KCI tooltip"],
				get  = function() return self.db.profile.KCI end,
				set  = function(v) self.db.profile.KCI = v end,
			},
		},
	}

	local t = self.options.args[L["sets"]].args

	for _, v in ipairs(MendeleevLocals.infosets) do
		local key = v.setindex
		t[key] = {
			name = v.name,
			desc = v.name,
			type = "toggle",
			get  = function() return not self.db.profile[key] end,
			set  = function(val) self.db.profile[key] = not val end,
		}
	end

	for _, v in ipairs(MendeleevLocals.custominfosets) do
		local key = v
		t[key] = {
			name = key,
			desc = key,
			type = "toggle",
			get  = function() return not self.db.profile[key] end,
			set  = function(val) self.db.profile[key] = not val end,
		}
	end
end
