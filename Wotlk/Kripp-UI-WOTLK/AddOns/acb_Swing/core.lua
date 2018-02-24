local class = select(2,UnitClass("player"));
if (class == "MAGE" or class == "WARLOCK" or class == "PRIEST") then
	return;
end

local GetTime = GetTime;
local FormatTime = AzCastBar.FormatTime;

-- Extra Options
local extraOptions = {
	{
		[0] = "Colors",
		{ type = "Color", var = "colNormal", default = { 0.4, 0.6, 0.8 }, label = "Normal Swing Color" },
		{ type = "Color", var = "colParry", default = { 1, 0.75, 0.5 }, label = "Parry Color" },
	},
};

-- Variables
local plugin = AzCastBar.CreateMainBar("Frame","Swing",extraOptions);
local pName = UnitName("player");

-- Localized Names
local slam = GetSpellInfo(1464);
local autoShot = GetSpellInfo(75);
local wandShot = GetSpellInfo(5019);
local meleeSwing = GetLocale() == "enUS" and "Melee Swing" or GetSpellInfo(6603);
local spellSwingReset = {
	[GetSpellInfo(78)] = true,		-- Heroic Strike
	[GetSpellInfo(845)] = true,		-- Cleave
	[GetSpellInfo(2973)] = true,	-- Raptor Strike
	[GetSpellInfo(6807)] = true,	-- Maul
	[GetSpellInfo(56815)] = true,	-- Rune Strike
};

--------------------------------------------------------------------------------------------------------
--                                           Frame Scripts                                            --
--------------------------------------------------------------------------------------------------------

local function OnUpdate(self,elapsed)
	-- No update on slam suspend
	if (self.slamStart) then
		return;
	-- Progression
	elseif (not self.fadeTime) then
		self.timeLeft = max(0,self.startTime + self.duration - GetTime());
		self.status:SetValue(self.duration - self.timeLeft);
		self:SetTimeText(self.timeLeft);
		if (self.timeLeft == 0) then
			self.fadeTime = self.cfg.fadeTime;
		end
	-- FadeOut
	elseif (self.fadeElapsed < self.fadeTime) then
		self.fadeElapsed = (self.fadeElapsed + arg1);
		self:SetAlpha(self.cfg.alpha - self.fadeElapsed / self.fadeTime * self.cfg.alpha);
	else
		self:Hide();
	end
end

--------------------------------------------------------------------------------------------------------
--                                           Event Handling                                           --
--------------------------------------------------------------------------------------------------------

local function StartSwing(time,text)
	plugin.duration = time;
	plugin.name:SetText(text);
	plugin.startTime = GetTime();
	plugin.status:SetMinMaxValues(0,time);
	plugin.status:SetStatusBarColor(unpack(plugin.cfg.colNormal));
	plugin.totalTimeText = (plugin.cfg.showTotalTime and " / "..FormatTime(time,1) or nil);
	plugin.fadeTime = nil;
	plugin.fadeElapsed = 0;
	plugin:SetAlpha(plugin.cfg.alpha);
	plugin:Show();
end

-- Combat Log Parser
function plugin:COMBAT_LOG_EVENT_UNFILTERED(event,time,type,sourceGUID,sourceName,sourceFlags,destGUID,destName,destFlags,...)
	-- Something our Player does
	if (sourceName == pName) then
		local prefix, suffix = type:match("(.-)_(.+)");
		if (prefix == "SWING") then
			StartSwing(UnitAttackSpeed("player"),meleeSwing);
		end
	-- Something Happens to our Player
	elseif (destName == pName) then
		local prefix, suffix = type:match("(.-)_(.+)");
		local missType = ...;
		-- Az: the info on wowwiki seemed obsolete, so this might not be 100% correct, I had to ignore the 20% rule as that didn't seem to be correct from tests
		if (prefix == "SWING") and (suffix == "MISSED") and (self.duration) and (missType == "PARRY") then
			local newDuration = (self.duration * 0.6);
--			local newTimeLeft = (self.startTime + newDuration - GetTime());
			self.duration = newDuration;
			self.status:SetMinMaxValues(0,self.duration);
			self.status:SetStatusBarColor(unpack(self.cfg.colParry));
			self.totalTimeText = (self.cfg.showTotalTime and " / "..FormatTime(self.duration,1) or nil);
		end
	end
end

-- Spell Cast Succeeded
function plugin:UNIT_SPELLCAST_SUCCEEDED(event,unit,spell,id)
	if (unit == "player") then
		if (spell == autoShot) or (spell == wandShot) then
			StartSwing(UnitRangedDamage("player"),spell);
		elseif (spell == slam) and (self.slamStart) then
			self.startTime = (self.startTime + GetTime() - self.slamStart);
			self.slamStart = nil;
		elseif (spellSwingReset[spell]) then
			StartSwing(UnitAttackSpeed("player"),meleeSwing);
		end
	end
end

-- Warrior Only
if (class == "WARRIOR") then
	-- Spell Cast Start
	function plugin:UNIT_SPELLCAST_START(event,unit,spell,id)
		if (unit == "player") and (spell == slam) then
			self.slamStart = GetTime();
		end
	end
	-- Spell Cast Interrupted
	function plugin:UNIT_SPELLCAST_INTERRUPTED(event,unit,spell,id)
		if (unit == "player") and (spell == slam) and (self.slamStart) then
			self.slamStart = nil;
		end
	end
end

-- OnConfigChanged
function plugin:OnConfigChanged(cfg)
	if (cfg.enabled) then
		self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
		if (class == "WARRIOR") then
			self:RegisterEvent("UNIT_SPELLCAST_START");
			self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
		end
	else
		self:UnregisterAllEvents();
	end
end

--------------------------------------------------------------------------------------------------------
--                                          Initialise Plugin                                         --
--------------------------------------------------------------------------------------------------------

plugin.icon:SetTexture("Interface\\Icons\\Spell_Shadow_SoulLeech_2");
plugin:SetScript("OnUpdate",OnUpdate);