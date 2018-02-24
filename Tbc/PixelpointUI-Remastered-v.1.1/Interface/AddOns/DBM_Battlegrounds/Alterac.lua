local Alterac = DBM:NewBossMod("Alterac", DBM_ALTERAC, DBM_BGMOD_LANG["AV_DESCRIPTION"], DBM_OTHER, "Battlegrounds", 1);

Alterac.Version = "2.0";
Alterac.Author = "LeoLeal, Nitram, Tandanu";
Alterac.ExtraGUITab	= "BC Battlegrounds";
Alterac.MinRevision = 862;

Alterac:RegisterEvents(
	"CHAT_MSG_MONSTER_YELL",
	"CHAT_MSG_BG_SYSTEM_ALLIANCE",
	"CHAT_MSG_BG_SYSTEM_HORDE",
	"CHAT_MSG_BG_SYSTEM_NEUTRAL",
	"GOSSIP_SHOW",
	"QUEST_PROGRESS",
	"QUEST_COMPLETE"
);


Alterac.DropdownMenu = { --I don't use :AddOption() here, because I want to use the battleground boss mod's options table
	{
		variable = "DBM.AddOns.Battlegrounds.Options.ShowInviteTimer", 
		text = DBM_BGMOD_LANG.SHOW_INV_TIMER, 
		func = function() DBM.AddOns.Battlegrounds.Options.ShowInviteTimer = not DBM.AddOns.Battlegrounds.Options.ShowInviteTimer; end, 
	},
	
	{
		variable = "DBM.AddOns.Battlegrounds.Options.ColorByClass", 
		text = DBM_BGMOD_LANG.COLOR_BY_CLASS, 
		func = function() DBM.AddOns.Battlegrounds.Options.ColorByClass = not DBM.AddOns.Battlegrounds.Options.ColorByClass; end, 
	},
	
	{
		variable = "DBM.AddOns.Battlegrounds.Options.AutoSpirit", 
		text = DBM_BGMOD_OPTION_AUTOSPIRIT, 
		func = function() DBM.AddOns.Battlegrounds.Options.AutoSpirit = not DBM.AddOns.Battlegrounds.Options.AutoSpirit end, 
	},
};
Alterac:AddOption("AutoTurnIn", true, DBM_BGMOD_LANG.AV_TURNININFO);
Alterac:AddOption("Flash", false, DBM_BGMOD_LANG.AV_OPTION_FLASH);

function Alterac:GetNumItems(id)
	local counter = 0;
	for bag = 0,  4 do
		for slot = 1,  GetContainerNumSlots(bag) do
			local itemLink = GetContainerItemLink(bag, slot);
			local _, _, itemID = string.find(itemLink or "", "(%d+)") -- first number is the item's ID
			if tonumber(itemID) == tonumber(id) then
				local _, itemCount = GetContainerItemInfo(bag, slot);
				counter = counter + (itemCount or 1);
			end
		end
	end
	return counter;
end

function Alterac:OnEvent()
	if (event == "GOSSIP_SHOW" or event=="QUEST_PROGRESS") and GetRealZoneText() == DBM_ALTERAC and self.Options.AutoTurnIn then
		local target = UnitName("target");
		
		if target == DBM_BGMOD_LANG.AV_NPC.SMITHREGZAR or target == DBM_BGMOD_LANG.AV_NPC.MURGOTDEEPFORGE then
			local Upgrade = GetGossipOptions();
			if string.find(string.lower(Upgrade or ""), DBM_BGMOD_LANG.UPGRADETROOPS) then
				SelectGossipOption(1);
			elseif self:GetNumItems(17422) >= 20 then -- Armor Scraps
				SelectGossipAvailableQuest(1);
			end
			
		elseif target == DBM_BGMOD_LANG.AV_NPC.PRIMALISTTHURLOGA then
			local numItems = self:GetNumItems(17306); -- Stormpike Soldier's Blood
			if numItems >= 5 then
				SelectGossipAvailableQuest(2);
			elseif numItems > 0 then
				SelectGossipAvailableQuest(1);
			end
			
		elseif target == DBM_BGMOD_LANG.AV_NPC.ARCHDRUIDRENFERAL then
			local numItems = self:GetNumItems(17423); -- Storm Crystal
			if numItems >= 5 then
				SelectGossipAvailableQuest(2);
			elseif numItems > 0 then
				SelectGossipAvailableQuest(1);
			end
			
		elseif target == DBM_BGMOD_LANG.AV_NPC.STORMPIKERAMRIDERCOMMANDER then
			if self:GetNumItems(17643) > 0 then -- Frostwolf Hide
				SelectGossipAvailableQuest(1);
			end
			
		elseif target == DBM_BGMOD_LANG.AV_NPC.FROSTWOLFWOLFRIDERCOMMANDER then
			if self:GetNumItems(17642) > 0 then -- Alterac Ram Hide
				SelectGossipAvailableQuest(1);
			end
		end
		
		if event == "QUEST_PROGRESS" then
			if target == DBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERJEZTOR and self:GetNumItems(17327) == 0 then -- Stormpike Lieutenant's Flesh
				return;
			elseif target == DBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERGUSE and self:GetNumItems(17326) == 0 then -- Stormpike Soldier's Flesh
				return;
			elseif target == DBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERMULVERICK and self:GetNumItems(17328) == 0 then -- Stormpike Commander's Flesh
				return;
			elseif target == DBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERVIPORE and self:GetNumItems(17503) == 0 then -- Frostwolf Lieutenant's Medal
				return;
			elseif target == DBM_BGMOD_LANG.AV_NPC.WINDCOMMANDERSLIDORE and self:GetNumItems(17502) == 0 then -- Frostwolf Soldier's Medal
				return;
			elseif target == DBM_BGMOD_LANG.AV_NPC.WINGCOMMANDERICHMAN and self:GetNumItems(17504) == 0 then -- Frostwolf Commander's Medal
				return;
			else			
				CompleteQuest();
			end
		end
		
	elseif event == "QUEST_COMPLETE" and GetRealZoneText() == DBM_ALTERAC and self.Options.AutoTurnIn then
		local target = UnitName("target");
		for index, value in pairs(DBM_BGMOD_LANG.AV_NPC) do
			if (target == value) then
				GetQuestReward(0);
			end
		end
		
	elseif event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" then --"game starts in.." timers
		if arg1 == DBM_BGMOD_LANG.AV_START60SEC then
			self:SendSync("Start60")
		elseif arg1 == DBM_BGMOD_LANG.AV_START30SEC then		
			self:SendSync("Start30")
		end
		
	elseif event == "CHAT_MSG_BG_SYSTEM_ALLIANCE" then
		if string.find(string.lower(arg1), string.lower(DBM_BGMOD_LANG.AV_TARGETS[8])) then -- first Snowfall capture (Alliance)
			self:SendSync("AG8")
		end
		
	elseif event == "CHAT_MSG_BG_SYSTEM_HORDE" then
		if string.find(string.lower(arg1), string.lower(DBM_BGMOD_LANG.AV_TARGETS[8])) then -- first Snowfall capture (Horde)
			self:SendSync("HG8")
		end
		
	elseif event == "CHAT_MSG_MONSTER_YELL" then
	
		--zhCN translations...WTF
		if string.find(arg1, "西霜狼哨塔被部落占领了") then
			self:SendSync("DEF13")
			DBM.Announce(string.format(DBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, "西侧霜狼哨塔"));
			if self.Options.Flash then
				local oldFlashColor = DBM.Options.FlashColor;
				DBM.Options.FlashColor = "red";
				DBM.AddSpecialWarning("", false, true);
				DBM.Options.FlashColor = oldFlashColor;
			end
		elseif string.find(arg1, "东霜狼哨塔被部落占领了") then
			self:SendSync("DEF14")
			DBM.Announce(string.format(DBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, "东侧霜狼哨塔"));
			if self.Options.Flash then
				local oldFlashColor = DBM.Options.FlashColor;
				DBM.Options.FlashColor = "red";
				DBM.AddSpecialWarning("", false, true);
				DBM.Options.FlashColor = oldFlashColor;
			end
		elseif string.find(arg1, "西侧防御塔点被部落占领了") then
			self:SendSync("DEF11")
			DBM.Announce(string.format(DBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, "哨塔高地"));
			if self.Options.Flash then
				local oldFlashColor = DBM.Options.FlashColor;
				DBM.Options.FlashColor = "red";
				DBM.AddSpecialWarning("", false, true);
				DBM.Options.FlashColor = oldFlashColor;
			end
		elseif string.find(arg1, "石炉墓地受到攻击！如果我们不尽快采取措施的话，部落会([^%s]+)它的！") then
			self:SendSync("HG6")
		elseif string.find(arg1, "石炉墓地受到攻击！如果我们不尽快采取措施的话，联盟会([^%s]+)它的！") then
			self:SendSync("AG6")
		elseif string.find(arg1, "冰翼工事被联盟占领了！") then
			self:SendSync("DEF5")
			DBM.Announce(string.format(DBM_BGMOD_LANG.ALLI_TAKE_ANNOUNCE, "冰翼碉堡"));
			if self.Options.Flash then
				local oldFlashColor = DBM.Options.FlashColor;
				DBM.Options.FlashColor = "blue";
				DBM.AddSpecialWarning("", false, true);
				DBM.Options.FlashColor = oldFlashColor;
			end
		end
		-------------------------------------------------

		for index, value in ipairs(DBM_BGMOD_LANG.AV_TARGETS) do
			if string.find(string.lower(arg1), string.lower(value)) then
				if string.find(arg1, DBM_BGMOD_LANG.AV_UNDERATTACK) then
					local icon;
					if DBM_BGMOD_LANG.AV_TARGET_TYPE and DBM_BGMOD_LANG.AV_TARGET_TYPE[index] then
						if DBM_BGMOD_LANG.AV_TARGET_TYPE[index] == "tower" then
							if string.find(arg1, DBM_BGMOD_LANG.HORDE) then
								icon = "Interface\\AddOns\\DBM_API\\Textures\\GuardTower";
							elseif string.find(arg1, DBM_BGMOD_LANG.ALLIANCE) then
								icon = "Interface\\AddOns\\DBM_API\\Textures\\OrcTower"; --orc tower, because the alliance captures horde towers, so the bar is for a horde tower if the alliance captured a tower!
							end
						elseif DBM_BGMOD_LANG.AV_TARGET_TYPE[index] == "graveyard" then								
							icon = "Interface\\Icons\\Spell_Shadow_AnimateDead";
						end
					end
					
					if string.find(arg1, DBM_BGMOD_LANG.HORDE) then 
						if icon == "Interface\\AddOns\\DBM_API\\Textures\\GuardTower" then
							self:SendSync("HT"..index)
						elseif icon == "Interface\\Icons\\Spell_Shadow_AnimateDead" then
							self:SendSync("HG"..index)
						end
					elseif string.find(arg1, DBM_BGMOD_LANG.ALLIANCE) then
						if icon == "Interface\\AddOns\\DBM_API\\Textures\\OrcTower" then
							self:SendSync("AT"..index)
						elseif icon == "Interface\\Icons\\Spell_Shadow_AnimateDead" then
							self:SendSync("AG"..index)
						end

					end
					
				elseif string.find(arg1, DBM_BGMOD_LANG.AV_WASDESTROYED) or string.find(arg1, DBM_BGMOD_LANG.AV_WASTAKENBY) then
					
					local oldFlashColor = DBM.Options.FlashColor;
					if string.find(arg1, DBM_BGMOD_LANG.ALLIANCE) then
						self:Announce(string.format(DBM_BGMOD_LANG.ALLI_TAKE_ANNOUNCE, value));						
						DBM.Options.FlashColor = "blue";
					elseif string.find(arg1, DBM_BGMOD_LANG.HORDE) then
						self:Announce(string.format(DBM_BGMOD_LANG.HORDE_TAKE_ANNOUNCE, value));
						DBM.Options.FlashColor = "red";
					end
					if self.Options.Flash then
						self:AddSpecialWarning("", true);
					end
					DBM.Options.FlashColor = oldFlashColor;
					
					self:SendSync("DEF"..index)
				end
			end
		end
		
		if string.find(string.lower(arg1), string.lower(DBM_BGMOD_LANG.AV_IVUS)) then -- Forest and Ice Lord
			self:StartStatusBarTimer(603,  "Ivus spawn", "Interface\\Icons\\INV_BannerPVP_02.blp", true);
		elseif string.find(string.lower(arg1), string.lower(DBM_BGMOD_LANG.AV_ICEY)) then
			self:StartStatusBarTimer(603,  "Ice spawn", "Interface\\Icons\\INV_BannerPVP_01.blp", true);
		end
	end
end

function Alterac:OnSync(msg)
	if msg == "Start60" then
		self:StartStatusBarTimer(62, "Begins")
	elseif msg == "Start30" then
		if not self:GetStatusBarTimerTimeLeft("Begins") then
			self:StartStatusBarTimer(62, "Begins")
		end
		self:UpdateStatusBarTimer("Begins", 31, 62)
	elseif msg:sub(0, 2) == "AG" then
		msg = msg:sub(3)
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AV_TARGETS"][msg] then
			local t = DBM_BGMOD_AV_BARS[msg] or DBM_BGMOD_LANG["AV_TARGETS"][msg]
			self:EndStatusBarTimer(t, true)
			self:StartStatusBarTimer(243, t, "Interface\\Icons\\Spell_Shadow_AnimateDead", true, nil, 0, 0, 1)
		end
	elseif msg:sub(0, 2) == "AT" then
		msg = msg:sub(3)
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AV_TARGETS"][msg] then
			local t = DBM_BGMOD_AV_BARS[msg] or DBM_BGMOD_LANG["AV_TARGETS"][msg]
			self:EndStatusBarTimer(t, true)
			self:StartStatusBarTimer(243, t, "Interface\\AddOns\\DBM_API\\Textures\\OrcTower", true, nil, 0, 0, 1)
		end
	elseif msg:sub(0, 2) == "HG" then
		msg = msg:sub(3)
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AV_TARGETS"][msg] then
			local t = DBM_BGMOD_AV_BARS[msg] or DBM_BGMOD_LANG["AV_TARGETS"][msg]
			self:EndStatusBarTimer(t, true)
			self:StartStatusBarTimer(243, t, "Interface\\Icons\\Spell_Shadow_AnimateDead", true, nil, 1, 0, 0)
		end
	elseif msg:sub(0, 2) == "HT" then
		msg = msg:sub(3)
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AV_TARGETS"][msg] then
			local t = DBM_BGMOD_AV_BARS[msg] or DBM_BGMOD_LANG["AV_TARGETS"][msg]
			self:EndStatusBarTimer(t, true)
			self:StartStatusBarTimer(243, t, "Interface\\AddOns\\DBM_API\\Textures\\GuardTower", true, nil, 1, 0, 0)
		end
	elseif msg:sub(0, 3) == "DEF" then
		msg = msg:sub(4)
		msg = tonumber(msg)
		if msg and DBM_BGMOD_LANG["AV_TARGETS"][msg] then
			local t = DBM_BGMOD_AV_BARS[msg] or DBM_BGMOD_LANG["AV_TARGETS"][msg]
			self:EndStatusBarTimer(t, true)
		end
	end
end
