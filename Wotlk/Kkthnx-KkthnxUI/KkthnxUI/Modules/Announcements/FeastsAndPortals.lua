local K, C, L, _ = select(2, ...):unpack()

local function InGroup()
	return (GetNumPartyMembers() > 0 or GetNumRaidMembers() > 0) and true or false
end

-- Announce Feasts/Souls/Repair Bots/Portals/Ritual of Summoning
-- It's better to use (self, event, ...) in the function, than put local _, subEvent, blabla = ... later, then it's easier to get the right arguments for each game client
local frame = CreateFrame("Frame")
frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
frame:SetScript("OnEvent", function(self, _, ...)
	local _, subEvent, _, srcName, _, _, destName, _, spellID = ...
	if not InGroup() or InCombatLockdown() or not subEvent or not spellID or not srcName then return end
	if not UnitInRaid(srcName) and not UnitInParty(srcName) then return end

	local srcName = srcName:gsub("%-[^|]+", "")
	if subEvent == "SPELL_CAST_SUCCESS" then
		-- Feasts
		if C.Announcements.Feasts and (spellID == 46887 or spellID == 43015 or spellID == 43478 or spellID == 34753 or spellID == 45279 or spellID == 43480) then
			SendChatMessage(format(L_ANNOUNCE_FP_PRE, srcName, GetSpellLink(spellID)), K.CheckChat(true))
		-- Refreshment Table
		elseif C.Announcements.Feasts and (spellID == 43987) then
			SendChatMessage(format(L_ANNOUNCE_FP_PRE, srcName, GetSpellLink(spellID)), K.CheckChat(true))
		-- Ritual of Summoning and Ritual of Souls
		elseif C.Announcements.Portals and (spellID == 698 or spellID == 29893 or spellID == 58887) then
			SendChatMessage(format(L_ANNOUNCE_FP_CLICK, srcName, GetSpellLink(spellID)), K.CheckChat(true))
		-- Piccolo of the Flaming Fire
		elseif C.Announcements.Toys and (spellID == 18400) then
			SendChatMessage(format(L_ANNOUNCE_FP_USE, srcName, GetSpellLink(spellID)), K.CheckChat(true))
		end
	elseif subEvent == "SPELL_SUMMON" then
		-- Repair Bots
		if C.Announcements.Feasts and (K.AnnounceBots[spellID]) then
			SendChatMessage(format(L_ANNOUNCE_FP_PUT, srcName, GetSpellLink(spellID)), K.CheckChat(true))
		end
	elseif subEvent == "SPELL_CREATE" then
		-- MOLL-E
		if C.Announcements.Feasts and (spellID == 54710) then
			SendChatMessage(format(L_ANNOUNCE_FP_PUT, srcName, GetSpellLink(spellID)), K.CheckChat(true))
		-- Toys
		elseif C.Announcements.Toys and (K.AnnounceToys[spellID]) then
			SendChatMessage(format(L_ANNOUNCE_FP_PUT, srcName, GetSpellLink(spellID)), K.CheckChat(true))
		-- Portals
		elseif C.Announcements.Portals and (K.AnnouncePortals[spellID]) then
			SendChatMessage(format(L_ANNOUNCE_FP_CAST, srcName, GetSpellLink(spellID)), K.CheckChat(true))
		end
	elseif subEvent == "SPELL_AURA_APPLIED" then
		-- Turkey Feathers and Party G.R.E.N.A.D.E.
		if C.Announcements.Toys and (spellID == 61781 or ((spellID == 51508 or spellID == 51510) and destName == K.Name)) then
			SendChatMessage(format(L_ANNOUNCE_FP_USE, srcName, GetSpellLink(spellID)), K.CheckChat(true))
		end
	end
end)