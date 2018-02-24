local FormatTime = AzCastBar.FormatTime;
local GetMirrorTimerProgress = GetMirrorTimerProgress;

-- Icons
local MirrorTimerIcons = {
	[0] = "Interface\\Icons\\Spell_Shadow_SoulLeech_2",
	BREATH = "Interface\\Icons\\Spell_Shadow_DemonBreath",
	FEIGNDEATH = "Interface\\Icons\\Ability_Rogue_FeignDeath",
};

-- Extra Options
local extraOptions = {
	{
		[0] = "Colors",
		{ type = "Color", var = "colNormal", default = { 0.4, 0.6, 0.8 }, label = "Mirror Bar Color" },
	},
};

-- Plugin
local plugin = AzCastBar.CreateMainBar("Frame","Mirror",extraOptions,true);

--------------------------------------------------------------------------------------------------------
--                                           Frame Scripts                                            --
--------------------------------------------------------------------------------------------------------

local function OnUpdate(self,elapsed)
	-- Progression
	if (not self.fadeTime) then
		self.timeLeft = (GetMirrorTimerProgress(self.ident) / 1000);
		self.timeLeft = (self.timeLeft < 0 and 0) or (self.timeLeft < self.duration and self.timeLeft) or (self.duration);
		self.status:SetValue(self.timeLeft);
		self:SetTimeText(self.timeLeft);
	-- FadeOut
	elseif (self.fadeElapsed < self.fadeTime) then
		self.fadeElapsed = (self.fadeElapsed + elapsed);
		self:SetAlpha(self.cfg.alpha - self.fadeElapsed / self.fadeTime * self.cfg.alpha);
	else
		self.ident = nil;
		self:Hide();
	end
end

-- Entering World
function plugin:PLAYER_ENTERING_WORLD(event)
	for i = 1, MIRRORTIMER_NUMTIMERS do
		local ident, value, maxvalue, step, pause, label = GetMirrorTimerInfo(i);
		if (ident and ident ~= "UNKNOWN") then
			self:ShowTimer(ident,label,maxvalue / 1000);
		end
	end
end

-- Timer Start
function plugin:MIRROR_TIMER_START(event,ident,value,maxvalue,step,pause,label)
	self:ShowTimer(ident,label,maxvalue / 1000);
end

-- Timer Stop
function plugin:MIRROR_TIMER_STOP(event,ident)
	for index, bar in ipairs(self.bars) do
		if (bar.ident == ident) then
			bar.fadeTime = self.cfg.fadeTime;
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                                Code                                                --
--------------------------------------------------------------------------------------------------------

-- ConfigureBar
function plugin:ConfigureBar(bar)
	bar = (bar or self);
	bar:SetScript("OnUpdate",OnUpdate);
	return bar;
end

-- Show Timer
function plugin:ShowTimer(ident,label,duration)
	local bar;
	-- Get a Usable Bar
	for index, b in ipairs(self.bars) do
		if (not b.ident) or (b.ident == ident) then
			bar = b;
			break;
		end
	end
	if (not bar) then
		bar = self:ConfigureBar(AzCastBar.CreateBar("Frame",self));
	end
	-- Init Bar
	bar.ident = ident;
	bar.duration = duration;
	bar.totalTimeText = (self.cfg.showTotalTime and " / "..FormatTime(duration) or nil);

	bar.status:SetMinMaxValues(0,duration);
	bar.status:SetStatusBarColor(unpack(self.cfg.colNormal));

	bar.name:SetText(label);
	bar.icon:SetTexture(MirrorTimerIcons[ident] or MirrorTimerIcons[0]);

	bar.fadeTime = nil;
	bar.fadeElapsed = 0;
	bar:SetAlpha(self.cfg.alpha);
	bar:Show();
end

-- Config Changed
function plugin:OnConfigChanged(cfg)
	-- Our Mirror
	if (cfg.enabled) then
		self:RegisterEvent("MIRROR_TIMER_START");
		self:RegisterEvent("MIRROR_TIMER_STOP");
		self:RegisterEvent("PLAYER_ENTERING_WORLD");
		self:PLAYER_ENTERING_WORLD();
	else
		self:UnregisterAllEvents();
		for index, bar in ipairs(self.bars) do
			bar.fadeTime = self.cfg.fadeTime;
		end
	end
	-- Blizz Mirror
	if (cfg.enabled) then
		UIParent:UnregisterEvent("MIRROR_TIMER_START");
		for i = 1, MIRRORTIMER_NUMTIMERS do
			_G["MirrorTimer"..i]:UnregisterAllEvents();
			_G["MirrorTimer"..i]:Hide();
		end
	else
		UIParent:RegisterEvent("MIRROR_TIMER_START");
		for i = 1, MIRRORTIMER_NUMTIMERS do
			local bar = _G["MirrorTimer"..i];
			bar:RegisterEvent("MIRROR_TIMER_STOP");
			bar:RegisterEvent("MIRROR_TIMER_PAUSE");
			bar:RegisterEvent("PLAYER_ENTERING_WORLD");
			if (bar:GetScript("OnEvent")) then
				bar:GetScript("OnEvent")(bar,"PLAYER_ENTERING_WORLD");
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                          Initialise Plugin                                         --
--------------------------------------------------------------------------------------------------------

plugin:ConfigureBar();