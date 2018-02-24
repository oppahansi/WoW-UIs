local _G = getfenv(0);

TTT_Cache = {};
local cache = TTT_Cache;
local points = {};
local uToken, val;
local lastQuery = 0;
local TALENTS_PREFIX = "Talents:|cffffffff ";

-- GatherTalents
local function GatherTalents(inspect)
	for i = 1, 3 do
		points[i] = select(3,GetTalentTabInfo(i,inspect));
		if (i == 1) or (points[i] > points[val]) then
			val = i;
		end
	end
	-- Set "val" to the desired format
	if (points[val] == 0) then
		val = "No Talents";
	else
		val = GetTalentTabInfo(val,inspect).." ("..points[1].."/"..points[2].."/"..points[3]..")";
	end
--	val = points[1].."/"..points[2].."/"..points[3];
--	val = GetTalentTabInfo(val,true);
	cache.a, cache.b, cache.c = points[1], points[2], points[3];
	for i = 2, GameTooltip:NumLines() do
		if ((_G["GameTooltipTextLeft"..i]:GetText() or ""):find("^"..TALENTS_PREFIX)) then
			_G["GameTooltipTextLeft"..i]:SetText(TALENTS_PREFIX..val);
			GameTooltip:Show(); -- resize
			break;
		end
	end
	-- Organise Cache
	for i = 1, #cache do
		if (cache.name == cache[i].name) then
			tremove(cache,i);
			break;
		end
	end
	if (#cache > 25) then	-- Change cache size here (Default 15)
		tremove(cache,1);
	end
	-- Insert the new entry
	tinsert(cache,{ name = cache.name, talents = val });
end

-- Event Frame
local f = CreateFrame("Frame");
f:SetScript("OnEvent",function(self,event,...)
	f:UnregisterEvent("INSPECT_TALENT_READY");
	GatherTalents(1);
--	ClearInspectPlayer();
end);

-- HOOK: OnTooltipSetUnit
GameTooltip:HookScript("OnTooltipSetUnit",
function(self,...)
	uToken = select(2,self:GetUnit());
	if (not Examiner or not Examiner:IsShown()) and (UnitIsPlayer(uToken)) and (UnitLevel(uToken) > 9 or UnitLevel(uToken) == -1) then
		cache.name = UnitName(uToken);
		if (UnitIsUnit(uToken,"player")) then
			self:AddLine(TALENTS_PREFIX.." Loading...");
			GatherTalents();
		else
			local requestInspectData = (CheckInteractDistance(uToken,1) and CanInspect(uToken) and (GetTime() - lastQuery > 0.25)); 
			if (requestInspectData) then
				f:RegisterEvent("INSPECT_TALENT_READY");
				NotifyInspect(uToken);
				lastQuery = GetTime();
			end
			cache.a, cache.b, cache.c = nil, nil, nil;
			for i = 1, #cache do
				if (cache.name == cache[i].name) then
					self:AddLine(TALENTS_PREFIX..cache[i].talents);
					cache.a, cache.b, cache.c = cache[i].talents:match("(%d+)/(%d+)/(%d+)");
					return;
				end
			end
			if (requestInspectData) then
				self:AddLine(TALENTS_PREFIX.." Loading...");
			end
		end
	end
end
);