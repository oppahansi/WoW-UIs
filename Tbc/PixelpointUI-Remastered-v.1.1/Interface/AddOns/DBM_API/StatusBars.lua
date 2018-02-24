-- this code sucks since I added the "enlarge bars" feature, I will rewrite the bar engine soon

DBMStatusBars_DragFrameFunctions = { --we need these functions because we have to re-create the drag frame dynamically when we want to change the design
	["OnLoad"] = function(frame)
		frame.isMoving = false;
		frame.elapsed = 0;
		frame.timer = 20;
		frame:RegisterEvent("PLAYER_ENTERING_WORLD");
		getglobal(frame:GetName().."Bar"):SetMinMaxValues(0, 20);
		getglobal(frame:GetName().."BarText"):SetText("Drag me!");
		getglobal(frame:GetName().."BarTimer"):SetText(DBM.SecondsToTime(this.timer));
	end,
	["OnUpdate"] = function()
		this.elapsed = this.elapsed + arg1;
		if this.elapsed >= this.timer then
			this.elapsed = 0;
			this.timer = 20;
			this:Hide();
			getglobal(this:GetName().."BarTimer"):SetText(DBM.SecondsToTime(this.timer));					
		else
			getglobal(this:GetName().."BarTimer"):SetText(DBM.SecondsToTime(this.timer - this.elapsed));
			
			if DBM.Options.FillUpStatusBars then
				getglobal(this:GetName().."Bar"):SetValue(this.elapsed);
			else
				getglobal(this:GetName().."Bar"):SetValue(this.timer - this.elapsed);
			end
		end				
		
		if this:GetName() == "DBM_StatusBarTimerDrag" then
			if DBM_StatusBarTimer1 and DBM_StatusBarTimer1:IsShown() and DBM_StatusBarTimer1:GetAlpha() >= 0.1 then
				DBM_StatusBarTimer1:SetAlpha(0);
				if DBM_StatusBarTimer1.table and DBM_StatusBarTimer1.table.isFlashing then
					UIFrameFadeRemoveFrame(DBM_StatusBarTimer1Bar);
					UIFrameFlashRemoveFrame(DBM_StatusBarTimer1Bar);
					DBM_StatusBarTimer1Bar.flashTimer = nil;
					DBM_StatusBarTimer1Bar.fadeInTime = nil;
					DBM_StatusBarTimer1Bar.fadeOutTime = nil;
					DBM_StatusBarTimer1Bar.flashDuration = nil;
					DBM_StatusBarTimer1Bar.showWhenDone = nil;
					DBM_StatusBarTimer1Bar.flashTimer = nil;
					DBM_StatusBarTimer1Bar.flashMode = nil;
					DBM_StatusBarTimer1Bar.flashInHoldTime = nil;
					DBM_StatusBarTimer1Bar.flashOutHoldTime = nil;
					DBM_StatusBarTimer1Bar.fadeInfo = nil;
					DBM_StatusBarTimer1.table.isFlashing = nil;
				end
				DBM.Schedule(20.1, function() DBM_StatusBarTimer1:SetAlpha(1); end)
			end
		elseif this:GetName() == "DBM_StatusBarTimerDrag2" then
			if DBM_HugeBar1 and DBM_HugeBar1:IsShown() and DBM_HugeBar1:GetAlpha() >= 0.1 then
				DBM_HugeBar1:SetAlpha(0);
				if DBM_HugeBar1.table and DBM_HugeBar1.table.isFlashing then
					UIFrameFadeRemoveFrame(DBM_HugeBar1Bar);
					UIFrameFlashRemoveFrame(DBM_HugeBar1Bar);
					DBM_HugeBar1Bar.flashTimer = nil;
					DBM_HugeBar1Bar.fadeInTime = nil;
					DBM_HugeBar1Bar.fadeOutTime = nil;
					DBM_HugeBar1Bar.flashDuration = nil;
					DBM_HugeBar1Bar.showWhenDone = nil;
					DBM_HugeBar1Bar.flashTimer = nil;
					DBM_HugeBar1Bar.flashMode = nil;
					DBM_HugeBar1Bar.flashInHoldTime = nil;
					DBM_HugeBar1Bar.flashOutHoldTime = nil;
					DBM_HugeBar1Bar.fadeInfo = nil;
					DBM_HugeBar1.table.isFlashing = nil;
				end
				DBM.Schedule(20.1, function() DBM_HugeBar1:SetAlpha(1); end)
			end
		end
		
		local minValue, maxValue;
		minValue, maxValue = getglobal(this:GetName().."Bar"):GetMinMaxValues();
		if DBM.Options.FillUpStatusBars then
			getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", getglobal(this:GetName().."Bar"), "LEFT", (((getglobal(this:GetName().."Bar"):GetValue() - arg1) / maxValue) * getglobal(this:GetName().."Bar"):GetWidth()), DBMStatusBars_Designs[DBM.Options.StatusBarDesign].sparkOffset);
		else
			getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", getglobal(this:GetName().."Bar"), "LEFT", ((getglobal(this:GetName().."Bar"):GetValue() / maxValue) * getglobal(this:GetName().."Bar"):GetWidth()), DBMStatusBars_Designs[DBM.Options.StatusBarDesign].sparkOffset);
		end
	end,	
	["OnHide"] = function()
		if this.isMoving then
			DBM_StatusBarTimerAnchor:StopMovingOrSizing();
			DBM_HugeStatusBarTimerAnchor:StopMovingOrSizing();
			this.isMoving = false;
		end
		this.elapsed = 0;
		this.timer = 20;
		getglobal(this:GetName().."BarTimer"):SetText(DBM.SecondsToTime(this.timer));
		if this:GetName() == "DBM_StatusBarTimerDrag" then
			if DBM_StatusBarTimer1 then
				DBM_StatusBarTimer1:SetAlpha(1);
			end
		elseif this:GetName() == "DBM_StatusBarTimerDrag2" then
			if DBM_HugeBar1 then
				DBM_HugeBar1:SetAlpha(1);
			end
		end
	end,
	["OnEvent"] = function()
		if event == "PLAYER_ENTERING_WORLD" then
			this:ClearAllPoints();
			if this:GetName() == "DBM_StatusBarTimerDrag" then
				this:SetPoint("CENTER", "DBM_StatusBarTimerAnchor", "CENTER");
			elseif this:GetName() == "DBM_StatusBarTimerDrag2" then
				this:SetPoint("CENTER", "DBM_HugeStatusBarTimerAnchor", "CENTER");
			end
		end
	end,
	["OnMouseUp"] = function()
		if this.isMoving then
			if this:GetName() == "DBM_StatusBarTimerDrag" then
				DBM_StatusBarTimerAnchor:StopMovingOrSizing();
			elseif this:GetName() == "DBM_StatusBarTimerDrag2" then
				DBM_HugeStatusBarTimerAnchor:StopMovingOrSizing();
			end
			this.isMoving = false;
		end
		if arg1 == "RightButton" then
			this:Hide();
		end
	end,	
	["OnMouseDown"] = function()
		if arg1 == "LeftButton" then
			if this:GetName() == "DBM_StatusBarTimerDrag" then
				DBM_StatusBarTimerAnchor:StartMoving();
			elseif this:GetName() == "DBM_StatusBarTimerDrag2" then
				DBM_HugeStatusBarTimerAnchor:StartMoving();
			end
			this.isMoving = true;
		end
	end,
	["OnEnter"] = function()
	end,
	["OnLeave"] = function()
	end,
};

DBMStatusBars_Designs = {
	[1] = {
		["name"] = DBM_BAR_STYLE_DEFAULT,
		["template"] = "DBM_StatusBarTimerDefaultTemplate",
		["widthModifier"] = 8,
		["textWidthModifier"] = 59,
		["distance"] = -3,
		["sparkOffset"] = 0,
		["color"] = {
			["r"] = 1.0,
			["g"] = 0.7,
			["b"] = 0.0,
			["a"] = 1.0,
		},
		["iconSize"] = 16,
		["width"] = 170,
		["scale"] = 1,
		["text"] = 11,
		["HugeBars"] = {
			["width"] = 200,
			["scale"] = 1.1,
			["text"] = 12,
			["color"] = {
				["r"] = 1.0,
				["g"] = 0.7,
				["b"] = 0.0,
				["a"] = 1.0,
			},
		},
		["subFrameNames"] = {
			"Bar", "BarText", "BarTimer", "BarSpark", "BarBackground", "BarBar"
		},
		["initialize"] = function(frame)
			getglobal(frame:GetName().."BarSpark"):SetVertexColor(1, 1, 1, 1);
		end
	},
	[2] = {
		["name"] = DBM_BAR_STYLE_MODERN,
		["template"] = "DBM_StatusBarTimerExtraTemplate1",
		["widthModifier"] = 8,
		["textWidthModifier"] = 50,
		["distance"] = 0,
		["sparkOffset"] = -1,
		["color"] = {
			["r"] = 1.0,
			["g"] = 0.7,
			["b"] = 0.0,
			["a"] = 0.95,
		},
		["iconSize"] = 23,
		["iconOffsetX"] = 4,
--		["iconOffsetY"] = 0.5,
		["width"] = 260,
		["scale"] = 0.75,
		["text"] = 13,
		["HugeBars"] = {
			["width"] = 218,
			["scale"] = 1.05,
			["text"] = 11,
			["color"] = {
				["r"] = 1.0,
				["g"] = 0.7,
				["b"] = 0.0,
				["a"] = 0.95,
			},
		},
		["subFrameNames"] = {
			"Bar", "BarText", "BarTimer", "BarSpark", "BarBackground", "BarBar"
		},
		["onColorChanged"] = function(frame, r, g, b, a)
			getglobal(frame:GetParent():GetName().."BarSpark"):SetVertexColor(r, g, b, a);
		end,
		["initialize"] = function(frame)
			getglobal(frame:GetName().."BarSpark"):SetVertexColor(DBMStatusBars_Designs[2].color.r, DBMStatusBars_Designs[2].color.g, DBMStatusBars_Designs[2].color.b, DBMStatusBars_Designs[2].color.a);
		end
	},
	[3] = {
		["name"] = DBM_BAR_STYLE_CLOUDS,
		["template"] = "DBM_StatusBarTimerExtraTemplate2",
		["widthModifier"] = 8,
		["textWidthModifier"] = 50,
		["distance"] = 0,
		["sparkOffset"] = -1,
		["color"] = {
			["r"] = 0.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0,
		},
		["iconSize"] = 23,
		["iconOffsetX"] = 4,
--		["iconOffsetY"] = 0.5,
		["width"] = 260,
		["scale"] = 0.75,
		["text"] = 13,
		["HugeBars"] = {
			["width"] = 218,
			["scale"] = 1.05,
			["text"] = 11,
			["color"] = {
				["r"] = 1.0,
				["g"] = 0.7,
				["b"] = 0.0,
				["a"] = 0.95,
			},
		},
		["subFrameNames"] = {
			"Bar", "BarText", "BarTimer", "BarSpark", "BarBackground", "BarBar"
		},
		["onColorChanged"] = function(frame, r, g, b, a)
			getglobal(frame:GetParent():GetName().."BarSpark"):SetVertexColor(r, g, b, a);
		end,
		["initialize"] = function(frame)
			getglobal(frame:GetName().."BarSpark"):SetVertexColor(DBMStatusBars_Designs[3].color.r, DBMStatusBars_Designs[3].color.g, DBMStatusBars_Designs[3].color.b, DBMStatusBars_Designs[3].color.a);
		end,
	},
	[4] = {
		["name"] = DBM_BAR_STYLE_GLAZE,
		["template"] = "DBM_StatusBarTimerGlazeTemplate",
		["widthModifier"] = 8,
		["textWidthModifier"] = 50,
		["distance"] = 0,
		["sparkOffset"] = -1,
		["color"] = {
			["r"] = 1.0,
			["g"] = 0.7,
			["b"] = 0.0,
			["a"] = 0.95,
		},
		["iconSize"] = 23,
		["iconOffsetX"] = 4,
--		["iconOffsetY"] = 0.5,
		["width"] = 260,
		["scale"] = 0.75,
		["text"] = 13,
		["HugeBars"] = {
			["width"] = 218,
			["scale"] = 1.1,
			["text"] = 11,
			["color"] = {
				["r"] = 1.0,
				["g"] = 0.7,
				["b"] = 0.0,
				["a"] = 1.0,
			},
		},
		["subFrameNames"] = {
			"Bar", "BarText", "BarTimer", "BarSpark", "BarBackground", "BarBar"
		},
		["onColorChanged"] = function(frame, r, g, b, a)
			getglobal(frame:GetParent():GetName().."BarSpark"):SetVertexColor(r, g, b, a);
		end,
		["initialize"] = function(frame)
			getglobal(frame:GetName().."BarSpark"):SetVertexColor(DBMStatusBars_Designs[2].color.r, DBMStatusBars_Designs[2].color.g, DBMStatusBars_Designs[2].color.b, DBMStatusBars_Designs[2].color.a);
		end
	},
	[5] = {
		["name"] = DBM_BAR_STYLE_PERL,
		["template"] = "DBM_StatusBarTimerExtraTemplate3",
		["widthModifier"] = 8,
		["textWidthModifier"] = 59,
		["distance"] = -3,
		["sparkOffset"] = 0,
		["color"] = {
			["r"] = 1.0,
			["g"] = 0.7,
			["b"] = 0.0,
			["a"] = 1.0,
		},
		["iconSize"] = 16,
		["width"] = 195,
		["scale"] = 1,
		["text"] = 11,
		["HugeBars"] = {
			["width"] = 200,
			["scale"] = 1.05,
			["text"] = 12,
			["color"] = {
				["r"] = 1.0,
				["g"] = 0.7,
				["b"] = 0.0,
				["a"] = 0.95,
			},
		},
		["subFrameNames"] = {
			"Bar", "BarText", "BarTimer", "BarSpark", "BarBackground", "BarBar"
		},		
		["initialize"] = function(frame)
			getglobal(frame:GetName().."BarSpark"):SetVertexColor(DBMStatusBars_Designs[4].color.r, DBMStatusBars_Designs[4].color.g, DBMStatusBars_Designs[4].color.b, DBMStatusBars_Designs[4].color.a);
		end,
	},
};


function DBMStatusBars_OnUpdate(elapsed)
	if this and this.isUsed and this.table then

		this.table.elapsed = this.table.elapsed + elapsed;
		if DBM.Options.FillUpStatusBars then
			getglobal(this:GetName().."Bar"):SetValue(this.table.elapsed);
		else
			getglobal(this:GetName().."Bar"):SetValue(this.table.timer - this.table.elapsed);
		end
		
		local goodTimer = this.table.timer - this.table.elapsed;
		if goodTimer < 0 then
			goodTimer = 0;
		end
		
		getglobal(this:GetName().."BarTimer"):SetText(DBM.SecondsToTime(goodTimer));
		if DBM.Options.FlashBars and not this.table.isFlashing and this.table.timer - this.table.elapsed < 7.5 then
			this.table.isFlashing = true;
			UIFrameFlash(getglobal(this:GetName().."Bar"), 0.3, 0.3, this.table.timer - this.table.elapsed, 1, 0, 0.75);
		end
		if this.table.elapsed >= this.table.timer then
			if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == getglobal(this:GetName().."BarText"):GetText() and ((not this.table.repetitions) or this.table.repetitions <= 1) then
				GameTooltip:Hide();
			end
			DBM.EndStatusBarTimer(this.usedBy, true);
			if this:IsShown() and this.table and this.table.frame ~= this then -- to fix a stupid bug where this.table.frame != this
				if this.table and this.table.isFlashing then
					UIFrameFadeRemoveFrame(this);
					UIFrameFlashRemoveFrame(this);
					this:SetAlpha(1.0);
					this.flashTimer = nil;
					this.fadeInTime = nil;
					this.fadeOutTime = nil;
					this.flashDuration = nil;
					this.showWhenDone = nil;
					this.flashTimer = nil;
					this.flashMode = nil;
					this.flashInHoldTime = nil;
					this.flashOutHoldTime = nil;
					this.fadeInfo = nil;
					this.table.isFlashing = nil;
					this.fading = nil;
				end
				this:Hide();
				this.isUsed = false;
				this.syncedBy = "UNKNOWN";
				this.startedBy = "UNKNOWN";
				this.usedBy = "";
				this.isRepeating = false;
				this.repetitions = 0;
				this.table = nil;
				this.specialColor = false;	
				this.fading = nil;
				getglobal(this:GetName().."Bar"):SetStatusBarColor(DBM.Options.StatusBarColor.r, DBM.Options.StatusBarColor.g, DBM.Options.StatusBarColor.b, DBM.Options.StatusBarColor.a);
				getglobal(this:GetName().."Icon"):Hide();
				DBMStatusBars_PullTogether()
			end
			return;
		end
		if DBM.Options.AutoColorBars and this.table and this.table.bossModID ~= "Battlegrounds" and this.table.bossModID ~= "Alterac" and this.table.bossModID ~= "Arathi" and this.table.bossModID ~= "Warsong" and this.table.bossModID ~= "EyeOfTheStorm" then
			local percent = (this.table.timer - this.table.elapsed) / this.table.timer;
			if this.specialColor then
				getglobal(this:GetName().."Bar"):SetStatusBarColor(this.table.color.R + ((1 - this.table.color.R) * (1 - percent)), this.table.color.G * percent, this.table.color.B * percent, this.table.color.A);
			else
				getglobal(this:GetName().."Bar"):SetStatusBarColor(DBM.Options.StatusBarColor.r + ((1 - DBM.Options.StatusBarColor.r) * (1 - percent)), DBM.Options.StatusBarColor.g * percent, DBM.Options.StatusBarColor.b * percent, DBM.Options.StatusBarColor.a);
			end
		end
		local minValue, maxValue;
		minValue, maxValue = getglobal(this:GetName().."Bar"):GetMinMaxValues();
		getglobal(this:GetName().."BarSpark"):ClearAllPoints();
		if DBM.Options.FillUpStatusBars then
			getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", (this:GetName().."Bar"), "LEFT", (((getglobal(this:GetName().."Bar"):GetValue() - elapsed) / maxValue) * getglobal(this:GetName().."Bar"):GetWidth()), DBMStatusBars_Designs[DBM.Options.StatusBarDesign].sparkOffset);
		else
			getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", (this:GetName().."Bar"), "LEFT", (((getglobal(this:GetName().."Bar"):GetValue()) / maxValue) * getglobal(this:GetName().."Bar"):GetWidth()), DBMStatusBars_Designs[DBM.Options.StatusBarDesign].sparkOffset);
		end
		
		if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == getglobal(this:GetName().."BarText"):GetText() then
			if GameTooltipTextRight2 then
				GameTooltipTextRight2:SetText(DBM.SecondsToTime(this.table.timer - this.table.elapsed));
			end
			if GameTooltipTextRight3 then
				GameTooltipTextRight3:SetText(DBM.SecondsToTime(this.table.elapsed));
			end
			if GameTooltipTextLeft5 and GameTooltipTextRight5 and GameTooltipTextLeft5:GetText() == DBM_SBT_REPETITIONS then
				if not this.table.infinite then
					GameTooltipTextRight5:SetText(this.table.repetitions);
				end
			end
		end
		if DBM.Options.HugeBars.EnableStatusBars and not this.enlarging and not this.isRepeating then -- not enabled for repeating timers (only old boss mods are using such timers...so that shouldn't be a problem)
			if (goodTimer < DBM.Options.EnlargeBarsAfterSec
			or (goodTimer/this.table.timer <= DBM.Options.EnlargeBarsAfterPerc/100)) and goodTimer < DBM.Options.EnlargeBarsMaxSec
			and this.usedBy ~= "Alliance wins in"
			and this.usedBy ~= "Horde wins in"
			and this.usedBy ~= "AB_WINALLY"
			and this.usedBy ~= "AB_WINHORDE" then -- filter out bg "win in" timers until :UpdateStatusBarTimer() supports enlarged bars correctly
				UIFrameFlashRemoveFrame(getglobal(this:GetName().."Bar"))
				this:SetAlpha(1)
				this.enlarging = 0.5
				DBMStatusBars_StartImportantBar(this)
			end
		elseif this.enlarging then
			this.enlarging = this.enlarging - elapsed
			if this.enlarging <= 0 then
				this.enlarging = nil
				this:SetAlpha(1)
				if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == getglobal(this:GetName().."BarText"):GetText() then
					GameTooltip:Hide()
				end
				DBM.EndStatusBarTimer(this.usedBy, true, nil, true, true)
			else
				this:SetAlpha(this.enlarging * 1.8 + 0.1)
			end
		end
	end
end

function DBMStatusBars_OnEnter()
	if not this.table then
		return;
	end
	GameTooltip:Hide();
	GameTooltip:ClearLines();
	GameTooltip_SetDefaultAnchor(GameTooltip, UIParent);
	GameTooltip:SetText(getglobal(this:GetName().."BarText"):GetText());
	GameTooltip:AddDoubleLine(DBM_SBT_TIMELEFT, DBM.SecondsToTime(this.table.timer - this.table.elapsed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(DBM_SBT_TIMEELAPSED, DBM.SecondsToTime(this.table.elapsed), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	GameTooltip:AddDoubleLine(DBM_SBT_TOTALTIME, DBM.SecondsToTime(this.table.timer), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	if this.table.isRepeating and this.table.repetitions then
		if this.table.infinite then
			GameTooltip:AddDoubleLine(DBM_SBT_REPETITIONS, DBM_SBT_INFINITE, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		else
			GameTooltip:AddDoubleLine(DBM_SBT_REPETITIONS, this.table.repetitions, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
		end
	end
	if this.table.startedBy and this.table.startedBy ~= "UNKNOWN" then
		GameTooltip:AddDoubleLine(DBM_SBT_BOSSMOD, this.table.startedBy, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	if this.table.syncedBy and this.table.syncedBy ~= DBM_LOCAL then	
		GameTooltip:AddDoubleLine(DBM_SBT_STARTEDBY, this.table.syncedBy, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	else
		GameTooltip:AddDoubleLine(DBM_SBT_STARTEDBY, UnitName("player"), NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
	end
	GameTooltip:AddLine(DBM_SBT_LEFTCLICK, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:AddLine(DBM_SBT_RIGHTCLICK, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
	GameTooltip:Show();
end

function DBMStatusBars_SetDefaultValues()
	DBM.Options.StatusBarColor.r = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.r;
	DBM.Options.StatusBarColor.g = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.g;
	DBM.Options.StatusBarColor.b = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.b;
	DBM.Options.StatusBarColor.a = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.a;
	DBM.Options.StatusBarSize.Width = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].width;
	DBM.Options.StatusBarSize.Scale = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].scale;
	DBM.Options.StatusBarSize.Text = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].text;
	DBM.Options.StatusBarsFlippedOver = false;
	DBM.Options.FillUpStatusBars = true;
	DBM.Options.EnableStatusBars = true;
end
function DBMStatusBars_SetOldDefaultValues()
	DBM.Options.StatusBarColor.r = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.r;
	DBM.Options.StatusBarColor.g = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.g;
	DBM.Options.StatusBarColor.b = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.b;
	DBM.Options.StatusBarColor.a = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.a;
	DBM.Options.StatusBarSize.Width = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].HugeBars.width;
	DBM.Options.StatusBarSize.Scale = 1;
	DBM.Options.StatusBarSize.Text = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].HugeBars.text - 1;
	DBM.Options.StatusBarsFlippedOver = false;
	DBM.Options.FillUpStatusBars = true;
	DBM.Options.EnableStatusBars = true;
	DBM.Options.HugeBars.EnableStatusBars = false;
end
function DBMHugeStatusBars_SetDefaultValues()
	DBM.Options.HugeBars.StatusBarColor.r = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].HugeBars.color.r;
	DBM.Options.HugeBars.StatusBarColor.g = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].HugeBars.color.g;
	DBM.Options.HugeBars.StatusBarColor.b = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].HugeBars.color.b;
	DBM.Options.HugeBars.StatusBarColor.a = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].HugeBars.color.a;
	DBM.Options.HugeBars.StatusBarSize.Width = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].HugeBars.width;
	DBM.Options.HugeBars.StatusBarSize.Scale = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].HugeBars.scale;
	DBM.Options.HugeBars.StatusBarSize.Text = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].HugeBars.text;
	DBM.Options.HugeBars.StatusBarsFlippedOver = false;
	DBM.Options.HugeBars.FillUpStatusBars = true;
	DBM.Options.HugeBars.EnableStatusBars = true;
end

function DBMStatusBars_FlipOver()
	if DBM.Options.StatusBarsFlippedOver then
		for i = 2, DBM.StatusBarCount do
			getglobal("DBM_StatusBarTimer"..i):ClearAllPoints()
			getglobal("DBM_StatusBarTimer"..i):SetPoint("BOTTOM", "DBM_StatusBarTimer"..(i - 1), "TOP", 0, DBMStatusBars_Designs[DBM.Options.StatusBarDesign].distance);
		end
	else
		for i = 2, DBM.StatusBarCount do
			getglobal("DBM_StatusBarTimer"..i):ClearAllPoints()
			getglobal("DBM_StatusBarTimer"..i):SetPoint("TOP", "DBM_StatusBarTimer"..(i - 1), "BOTTOM", 0, -DBMStatusBars_Designs[DBM.Options.StatusBarDesign].distance);
		end
	end
	if DBM.Options.HugeBars.StatusBarsFlippedOver then
		local i = 2
		while getglobal("DBM_HugeBar"..i) do
			getglobal("DBM_HugeBar"..i):ClearAllPoints()
			getglobal("DBM_HugeBar"..i):SetPoint("BOTTOM", "DBM_HugeBar"..(i - 1), "TOP", 0, DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].distance);
			i = i + 1
		end
	else
		local i = 2
		while getglobal("DBM_HugeBar"..i) do
			getglobal("DBM_HugeBar"..i):ClearAllPoints()
			getglobal("DBM_HugeBar"..i):SetPoint("TOP", "DBM_HugeBar"..(i - 1), "BOTTOM", 0, -DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].distance);
			i = i + 1
		end
	end
end

function DBMStatusBars_PullTogether()
	for i = 2, DBM.StatusBarCount do
		if getglobal("DBM_StatusBarTimer"..i).isUsed and (not getglobal("DBM_StatusBarTimer"..(i-1)).isUsed) then
			local j = i - 1;
			if getglobal("DBM_StatusBarTimer"..i).specialColor then
				getglobal("DBM_StatusBarTimer"..i.."Bar"):SetStatusBarColor(DBM.Options.StatusBarColor.r, DBM.Options.StatusBarColor.g, DBM.Options.StatusBarColor.b, DBM.Options.StatusBarColor.a);
			end
			
			for index, value in pairs(getglobal("DBM_StatusBarTimer"..i)) do
				if type(value) ~= "userdata" then
					getglobal("DBM_StatusBarTimer"..j)[index] = value;
				end
			end
			
			getglobal("DBM_StatusBarTimer"..i):Hide();	
			local iconWasShown = getglobal("DBM_StatusBarTimer"..i.."Icon"):IsShown();
			getglobal("DBM_StatusBarTimer"..i.."Icon"):Hide();
			getglobal("DBM_StatusBarTimer"..i).isUsed = false;
			getglobal("DBM_StatusBarTimer"..i).usedBy = "";
			getglobal("DBM_StatusBarTimer"..i).isRepeating = false;
			getglobal("DBM_StatusBarTimer"..i).repetitions = 0;
			getglobal("DBM_StatusBarTimer"..i).specialColor = false;
			if getglobal("DBM_StatusBarTimer"..i).table.isFlashing then
				UIFrameFadeRemoveFrame(getglobal("DBM_StatusBarTimer"..i.."Bar"));
				UIFrameFlashRemoveFrame(getglobal("DBM_StatusBarTimer"..i.."Bar"));
				getglobal("DBM_StatusBarTimer"..i.."Bar"):SetAlpha(1);
				getglobal("DBM_StatusBarTimer"..i.."Bar").flashTimer = nil;
				getglobal("DBM_StatusBarTimer"..i.."Bar").fadeInTime = nil;
				getglobal("DBM_StatusBarTimer"..i.."Bar").fadeOutTime = nil;
				getglobal("DBM_StatusBarTimer"..i.."Bar").flashDuration = nil;
				getglobal("DBM_StatusBarTimer"..i.."Bar").showWhenDone = nil;
				getglobal("DBM_StatusBarTimer"..i.."Bar").flashTimer = nil;
				getglobal("DBM_StatusBarTimer"..i.."Bar").flashMode = nil;
				getglobal("DBM_StatusBarTimer"..i.."Bar").flashInHoldTime = nil;
				getglobal("DBM_StatusBarTimer"..i.."Bar").flashOutHoldTime = nil;
				getglobal("DBM_StatusBarTimer"..i.."Bar").fadeInfo = nil;
				UIFrameFlash(getglobal("DBM_StatusBarTimer"..j.."Bar"), 0.3, 0.3, getglobal("DBM_StatusBarTimer"..i).table.timer - getglobal("DBM_StatusBarTimer"..i).table.elapsed, 1, 0, 0.75);
			else
				UIFrameFadeRemoveFrame(getglobal("DBM_StatusBarTimer"..j.."Bar"));
				UIFrameFlashRemoveFrame(getglobal("DBM_StatusBarTimer"..j.."Bar"));
				getglobal("DBM_StatusBarTimer"..j.."Bar"):SetAlpha(1);
				getglobal("DBM_StatusBarTimer"..j.."Bar").flashTimer = nil;
				getglobal("DBM_StatusBarTimer"..j.."Bar").fadeInTime = nil;
				getglobal("DBM_StatusBarTimer"..j.."Bar").fadeOutTime = nil;
				getglobal("DBM_StatusBarTimer"..j.."Bar").flashDuration = nil;
				getglobal("DBM_StatusBarTimer"..j.."Bar").showWhenDone = nil;
				getglobal("DBM_StatusBarTimer"..j.."Bar").flashTimer = nil;
				getglobal("DBM_StatusBarTimer"..j.."Bar").flashMode = nil;
				getglobal("DBM_StatusBarTimer"..j.."Bar").flashInHoldTime = nil;
				getglobal("DBM_StatusBarTimer"..j.."Bar").flashOutHoldTime = nil;
				getglobal("DBM_StatusBarTimer"..j.."Bar").fadeInfo = nil;
			end
			if getglobal("DBM_StatusBarTimer"..i).enlarging then
				getglobal("DBM_StatusBarTimer"..j).enlarging = getglobal("DBM_StatusBarTimer"..i).enlarging
				getglobal("DBM_StatusBarTimer"..i).enlarging = nil
				getglobal("DBM_StatusBarTimer"..j):SetAlpha(getglobal("DBM_StatusBarTimer"..j).enlarging * 1.8 + 0.1)
				getglobal("DBM_StatusBarTimer"..i):SetAlpha(1)
			end
			getglobal("DBM_StatusBarTimer"..i).table = nil;

			if getglobal("DBM_StatusBarTimer"..j).specialColor and getglobal("DBM_StatusBarTimer"..j).table and type(getglobal("DBM_StatusBarTimer"..j).table.color) == "table" then
				getglobal("DBM_StatusBarTimer"..j.."Bar"):SetStatusBarColor(getglobal("DBM_StatusBarTimer"..j).table.color.R, getglobal("DBM_StatusBarTimer"..j).table.color.G, getglobal("DBM_StatusBarTimer"..j).table.color.B, getglobal("DBM_StatusBarTimer"..j).table.color.A);
			else
				getglobal("DBM_StatusBarTimer"..j.."Bar"):SetStatusBarColor(DBM.Options.StatusBarColor.r, DBM.Options.StatusBarColor.g, DBM.Options.StatusBarColor.b, DBM.Options.StatusBarColor.a);
			end
			getglobal("DBM_StatusBarTimer"..j.."Bar"):SetMinMaxValues(0, getglobal("DBM_StatusBarTimer"..j).table.timer);
			
			if type(DBM_SBT[getglobal("DBM_StatusBarTimer"..j).usedBy]) == "string" then
				getglobal("DBM_StatusBarTimer"..j.."BarText"):SetText(DBM_SBT[getglobal("DBM_StatusBarTimer"..j).usedBy]);
			elseif getglobal("DBM_StatusBarTimer"..j).table and getglobal("DBM_StatusBarTimer"..j).table.bossModID and type(DBM_SBT[getglobal("DBM_StatusBarTimer"..j).table.bossModID]) == "table" then
				local tempname = getglobal("DBM_StatusBarTimer"..j).usedBy;
				for index, value in pairs(DBM_SBT[getglobal("DBM_StatusBarTimer"..j).table.bossModID]) do
					tempname = string.gsub(tempname, value[1], value[2]);
				end
				getglobal("DBM_StatusBarTimer"..j.."BarText"):SetText(tempname);
			else
				getglobal("DBM_StatusBarTimer"..j.."BarText"):SetText(getglobal("DBM_StatusBarTimer"..j).usedBy);
			end

			getglobal("DBM_StatusBarTimer"..j.."BarTimer"):SetText(DBM.SecondsToTime(getglobal("DBM_StatusBarTimer"..j).table.timer));
			if iconWasShown then
				getglobal("DBM_StatusBarTimer"..j.."Icon"):SetTexture(getglobal("DBM_StatusBarTimer"..i.."Icon"):GetTexture());
				getglobal("DBM_StatusBarTimer"..j.."Icon"):Show();
			end
			getglobal("DBM_StatusBarTimer"..j):Show();
	
			getglobal("DBM_StatusBarTimer"..j).table.barId = j;
			getglobal("DBM_StatusBarTimer"..j).table.frame = getglobal("DBM_StatusBarTimer"..j);
		end
	end
end

function DBMHugeStatusBars_PullTogether()
	local i = 2
	while getglobal("DBM_HugeBar"..i) do
		if getglobal("DBM_HugeBar"..i).isUsed and (not getglobal("DBM_HugeBar"..(i-1)).isUsed) then
			local j = i - 1;
			
			if getglobal("DBM_HugeBar"..i).specialColor then
				getglobal("DBM_HugeBar"..i.."Bar"):SetStatusBarColor(DBM.Options.HugeBars.StatusBarColor.r, DBM.Options.HugeBars.StatusBarColor.g, DBM.Options.HugeBars.StatusBarColor.b, DBM.Options.HugeBars.StatusBarColor.a);
			end
			
			for index, value in pairs(getglobal("DBM_HugeBar"..i)) do
				if type(value) ~= "userdata" then
					getglobal("DBM_HugeBar"..j)[index] = value;
				end
			end
			
			getglobal("DBM_HugeBar"..i):Hide();	
			local iconWasShown = getglobal("DBM_HugeBar"..i.."Icon"):IsShown();
			getglobal("DBM_HugeBar"..i.."Icon"):Hide();
			getglobal("DBM_HugeBar"..i).isUsed = false;
			getglobal("DBM_HugeBar"..i).usedBy = "";
			getglobal("DBM_HugeBar"..i).isRepeating = false;
			getglobal("DBM_HugeBar"..i).repetitions = 0;
			getglobal("DBM_HugeBar"..i).specialColor = false;
			if getglobal("DBM_HugeBar"..i).table.isFlashing then
				UIFrameFadeRemoveFrame(getglobal("DBM_HugeBar"..i.."Bar"));
				UIFrameFlashRemoveFrame(getglobal("DBM_HugeBar"..i.."Bar"));
				getglobal("DBM_HugeBar"..i.."Bar"):SetAlpha(1);
				getglobal("DBM_HugeBar"..i.."Bar").flashTimer = nil;
				getglobal("DBM_HugeBar"..i.."Bar").fadeInTime = nil;
				getglobal("DBM_HugeBar"..i.."Bar").fadeOutTime = nil;
				getglobal("DBM_HugeBar"..i.."Bar").flashDuration = nil;
				getglobal("DBM_HugeBar"..i.."Bar").showWhenDone = nil;
				getglobal("DBM_HugeBar"..i.."Bar").flashTimer = nil;
				getglobal("DBM_HugeBar"..i.."Bar").flashMode = nil;
				getglobal("DBM_HugeBar"..i.."Bar").flashInHoldTime = nil;
				getglobal("DBM_HugeBar"..i.."Bar").flashOutHoldTime = nil;
				getglobal("DBM_HugeBar"..i.."Bar").fadeInfo = nil;
				UIFrameFlash(getglobal("DBM_HugeBar"..j.."Bar"), 0.3, 0.3, getglobal("DBM_HugeBar"..i).table.timer - getglobal("DBM_HugeBar"..i).table.elapsed, 1, 0, 0.75);
			else
				UIFrameFadeRemoveFrame(getglobal("DBM_HugeBar"..j.."Bar"));
				UIFrameFlashRemoveFrame(getglobal("DBM_HugeBar"..j.."Bar"));
				getglobal("DBM_HugeBar"..j.."Bar"):SetAlpha(1);
				getglobal("DBM_HugeBar"..j.."Bar").flashTimer = nil;
				getglobal("DBM_HugeBar"..j.."Bar").fadeInTime = nil;
				getglobal("DBM_HugeBar"..j.."Bar").fadeOutTime = nil;
				getglobal("DBM_HugeBar"..j.."Bar").flashDuration = nil;
				getglobal("DBM_HugeBar"..j.."Bar").showWhenDone = nil;
				getglobal("DBM_HugeBar"..j.."Bar").flashTimer = nil;
				getglobal("DBM_HugeBar"..j.."Bar").flashMode = nil;
				getglobal("DBM_HugeBar"..j.."Bar").flashInHoldTime = nil;
				getglobal("DBM_HugeBar"..j.."Bar").flashOutHoldTime = nil;
				getglobal("DBM_HugeBar"..j.."Bar").fadeInfo = nil;
			end
			getglobal("DBM_HugeBar"..i).table = nil;

			if getglobal("DBM_HugeBar"..j).specialColor and getglobal("DBM_HugeBar"..j).table and type(getglobal("DBM_HugeBar"..j).table.color) == "table" then
				getglobal("DBM_HugeBar"..j.."Bar"):SetStatusBarColor(getglobal("DBM_HugeBar"..j).table.color.R, getglobal("DBM_HugeBar"..j).table.color.G, getglobal("DBM_HugeBar"..j).table.color.B, getglobal("DBM_HugeBar"..j).table.color.A);
			else
				getglobal("DBM_HugeBar"..j.."Bar"):SetStatusBarColor(DBM.Options.HugeBars.StatusBarColor.r, DBM.Options.HugeBars.StatusBarColor.g, DBM.Options.HugeBars.StatusBarColor.b, DBM.Options.HugeBars.StatusBarColor.a);
			end
			getglobal("DBM_HugeBar"..j.."Bar"):SetMinMaxValues(0, getglobal("DBM_HugeBar"..j).table.timer);
			if type(DBM_SBT[getglobal("DBM_HugeBar"..j).usedBy]) == "string" then
				getglobal("DBM_HugeBar"..j.."BarText"):SetText(DBM_SBT[getglobal("DBM_HugeBar"..j).usedBy]);

			elseif type(DBM_SBT[getglobal("DBM_HugeBar"..j).startedBy]) == "table" then
				local tempname = getglobal("DBM_HugeBar"..j).usedBy;
				for index, value in pairs(DBM_SBT[getglobal("DBM_HugeBar"..j).startedBy]) do
					tempname = string.gsub(tempname, value[1], value[2]);
				end
				getglobal("DBM_HugeBar"..j.."BarText"):SetText(tempname);
			else
				getglobal("DBM_HugeBar"..j.."BarText"):SetText(getglobal("DBM_HugeBar"..j).usedBy);
			end
			getglobal("DBM_HugeBar"..j.."BarTimer"):SetText(DBM.SecondsToTime(getglobal("DBM_HugeBar"..j).table.timer));
			if iconWasShown then
				getglobal("DBM_HugeBar"..j.."Icon"):SetTexture(getglobal("DBM_HugeBar"..i.."Icon"):GetTexture());
				getglobal("DBM_HugeBar"..j.."Icon"):Show();
			end
			getglobal("DBM_HugeBar"..j):Show();
	
			getglobal("DBM_HugeBar"..j).table.barId = j;
		end
		i = i + 1
	end
end

function DBMStatusBars_Resize()
	DBM_StatusBarTimerDrag:SetScale(DBM.Options.StatusBarSize.Scale);
	DBM_StatusBarTimerDrag:SetWidth(DBM.Options.StatusBarSize.Width);
	DBM_StatusBarTimerDragBar:SetWidth(DBM.Options.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.StatusBarDesign].widthModifier);
	DBM_StatusBarTimerDragBarTimer:SetJustifyH("RIGHT");
	DBM_StatusBarTimerDragBarText:SetWidth(DBM.Options.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.StatusBarDesign].textWidthModifier);	
	DBM_StatusBarTimerDragBarText:SetFont(STANDARD_TEXT_FONT, DBM.Options.StatusBarSize.Text);
	DBM_StatusBarTimerDragBarText:SetFont(STANDARD_TEXT_FONT, DBM.Options.StatusBarSize.Text);	
	DBM_StatusBarTimerDrag2:SetScale(DBM.Options.HugeBars.StatusBarSize.Scale);
	DBM_StatusBarTimerDrag2:SetWidth(DBM.Options.HugeBars.StatusBarSize.Width);
	DBM_StatusBarTimerDrag2Bar:SetWidth(DBM.Options.HugeBars.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].widthModifier);
	DBM_StatusBarTimerDrag2BarTimer:SetJustifyH("RIGHT");
	DBM_StatusBarTimerDrag2BarText:SetWidth(DBM.Options.HugeBars.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].textWidthModifier);
	DBM_StatusBarTimerDrag2BarText:SetFont(STANDARD_TEXT_FONT, DBM.Options.HugeBars.StatusBarSize.Text);
	DBM_StatusBarTimerDrag2BarText:SetFont(STANDARD_TEXT_FONT, DBM.Options.HugeBars.StatusBarSize.Text);	
	for i = 1, DBM.StatusBarCount do
		getglobal("DBM_StatusBarTimer"..i):SetScale(DBM.Options.StatusBarSize.Scale);
		getglobal("DBM_StatusBarTimer"..i):SetWidth(DBM.Options.StatusBarSize.Width);
		getglobal("DBM_StatusBarTimer"..i.."Bar"):SetWidth(DBM.Options.StatusBarSize.Width -  DBMStatusBars_Designs[DBM.Options.StatusBarDesign].widthModifier);
		getglobal("DBM_StatusBarTimer"..i.."BarText"):SetWidth(DBM.Options.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.StatusBarDesign].textWidthModifier);
		getglobal("DBM_StatusBarTimer"..i.."BarText"):SetFont(STANDARD_TEXT_FONT, DBM.Options.StatusBarSize.Text);
		getglobal("DBM_StatusBarTimer"..i.."BarTimer"):SetFont(STANDARD_TEXT_FONT, DBM.Options.StatusBarSize.Text);		
	end
	local i = 1
	while getglobal("DBM_HugeBar"..i) do
		getglobal("DBM_HugeBar"..i):SetScale(DBM.Options.HugeBars.StatusBarSize.Scale);
		getglobal("DBM_HugeBar"..i):SetWidth(DBM.Options.HugeBars.StatusBarSize.Width);
		getglobal("DBM_HugeBar"..i.."Bar"):SetWidth(DBM.Options.HugeBars.StatusBarSize.Width -  DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].widthModifier);
		getglobal("DBM_HugeBar"..i.."BarText"):SetWidth(DBM.Options.HugeBars.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].textWidthModifier);
		getglobal("DBM_HugeBar"..i.."BarText"):SetFont(STANDARD_TEXT_FONT, DBM.Options.HugeBars.StatusBarSize.Text);
		getglobal("DBM_HugeBar"..i.."BarTimer"):SetFont(STANDARD_TEXT_FONT, DBM.Options.HugeBars.StatusBarSize.Text);
		i = i + 1
	end
end

function DBMStatusBars_CreateNewBar()
	if (DBM.StatusBarCount + 1) > DBM.Options.MaxStatusBars then
		return;
	end
	DBM.StatusBarCount = DBM.StatusBarCount + 1;
	local newBar = CreateFrame("Frame", "DBM_StatusBarTimer"..DBM.StatusBarCount, UIParent, DBMStatusBars_Designs[DBM.Options.StatusBarDesign].template);
	newBar:SetScale(DBM.Options.StatusBarSize.Scale);
	newBar:SetWidth(DBM.Options.StatusBarSize.Width);
	getglobal(newBar:GetName().."Bar"):SetWidth(DBM.Options.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.StatusBarDesign].widthModifier);
	getglobal(newBar:GetName().."Bar"):SetStatusBarColor(DBM.Options.StatusBarColor.r, DBM.Options.StatusBarColor.g, DBM.Options.StatusBarColor.b, DBM.Options.StatusBarColor.a);
	getglobal(newBar:GetName().."BarText"):SetWidth(DBM.Options.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.StatusBarDesign].textWidthModifier);
	getglobal(newBar:GetName().."BarText"):SetFont(STANDARD_TEXT_FONT, DBM.Options.StatusBarSize.Text);
	getglobal(newBar:GetName().."BarTimer"):SetFont(STANDARD_TEXT_FONT, DBM.Options.StatusBarSize.Text);
	getglobal(newBar:GetName().."BarTimer"):SetParent(newBar)
	getglobal(newBar:GetName().."BarText"):SetParent(newBar)
	
	--icon stuff
	local newIcon = newBar:CreateTexture("DBM_StatusBarTimer"..DBM.StatusBarCount.."Icon", "OVERLAY");
	newIcon:SetHeight(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconSize or 18);
	newIcon:SetWidth(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconSize or 18);
	if DBM.Options.IconRight then
		newIcon:SetPoint("LEFT", "DBM_StatusBarTimer"..DBM.StatusBarCount, "RIGHT", -(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconOffsetX or 0), DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconOffsetY or 0);
	else
		newIcon:SetPoint("RIGHT", "DBM_StatusBarTimer"..DBM.StatusBarCount, "LEFT", DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconOffsetX or 0, DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconOffsetY or 0);
	end
	----
	
	if DBM.StatusBarCount == 1 then
		newBar:SetPoint("CENTER", "DBM_StatusBarTimerDrag", "CENTER", 0, 0);
	else
		if DBM.Options.StatusBarsFlippedOver then
			newBar:SetPoint("BOTTOM", "DBM_StatusBarTimer"..(DBM.StatusBarCount - 1), "TOP", 0, DBMStatusBars_Designs[DBM.Options.StatusBarDesign].distance);
		else
			newBar:SetPoint("TOP", "DBM_StatusBarTimer"..(DBM.StatusBarCount - 1), "BOTTOM", 0, -DBMStatusBars_Designs[DBM.Options.StatusBarDesign].distance);
		end
	end
	
	if type(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].initialize) == "function" then
		DBMStatusBars_Designs[DBM.Options.StatusBarDesign].initialize(getglobal("DBM_StatusBarTimer"..DBM.StatusBarCount));
	end
		
	if not DBM.Hooks.oldSetStatusBarColor then
		DBM.Hooks.oldSetStatusBarColor = getglobal("DBM_StatusBarTimer"..DBM.StatusBarCount.."Bar").SetStatusBarColor;
	end
	if not DBM.Hooks.oldSetMinMaxValues then
		DBM.Hooks.oldSetMinMaxValues = getglobal("DBM_StatusBarTimer"..DBM.StatusBarCount.."Bar").SetMinMaxValues;
	end
	if not DBM.Hooks.oldSetValue then
		DBM.Hooks.oldSetValue = getglobal("DBM_StatusBarTimer"..DBM.StatusBarCount.."Bar").SetValue;
	end
		
	getglobal("DBM_StatusBarTimer"..DBM.StatusBarCount.."Bar").SetStatusBarColor = function(frame, r, g, b, a)
		if type(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onColorChanged) == "function" then
			DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onColorChanged(frame, r, g, b, a);
		end
		DBM.Hooks.oldSetStatusBarColor(frame, r, g, b, a);
	end
	
	getglobal("DBM_StatusBarTimer"..DBM.StatusBarCount.."Bar").SetMinMaxValues = function(frame, minValue, maxValue)
		if type(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onSetMinMaxValues) == "function" then
			DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onSetMinMaxValues(frame, minValue, maxValue);
		end
		DBM.Hooks.oldSetMinMaxValues(frame, minValue, maxValue);
	end
	
	getglobal("DBM_StatusBarTimer"..DBM.StatusBarCount.."Bar").SetValue = function(frame, value)
		if type(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onSetValue) == "function" then
			DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onSetValue(frame, value);
		end
		DBM.Hooks.oldSetValue(frame, value);
	end
	
	DBMGuiUpdateStatusbars();
	
	return DBM.StatusBarCount;
end

function DBMStatusBars_ChangeDesign(designID, forceReload)
	local oldDesign = DBM.Options.StatusBarDesign;
	local oldBarCount = DBM.StatusBarCount;
	local oldFrameSettings;
	if oldDesign == designID and not forceReload then
		return;
	end
	if oldDesign ~= designID then --don't need to reset the options if we forced a re-creation of the frames
		DBM.Options.StatusBarDesign = designID;
		DBM.StatusBarCount = 0;
		DBM.Options.StatusBarColor.r = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.r;
		DBM.Options.StatusBarColor.g = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.g;
		DBM.Options.StatusBarColor.b = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.b;
		DBM.Options.StatusBarColor.a = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].color.a;
		if DBM.Options.HugeBars.EnableStatusBars then
			DBM.Options.StatusBarSize.Scale = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].scale;
			DBM.Options.StatusBarSize.Width = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].width;
			DBM.Options.StatusBarSize.Text = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].text;
		else
			DBM.Options.StatusBarSize.Scale = 1;
			DBM.Options.StatusBarSize.Width = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].HugeBars.width;
			DBM.Options.StatusBarSize.Text = DBMStatusBars_Designs[DBM.Options.StatusBarDesign].HugeBars.text - 1;
		end
	end
	if DBM_StatusBarTimerDrag then
		DBM_StatusBarTimerDrag:Hide();
	end

	for index, value in pairs(DBMStatusBars_Designs[oldDesign].subFrameNames) do
		setglobal("DBM_StatusBarTimerDrag"..value, nil);
	end
	setglobal("DBM_StatusBarTimerDragIcon", nil);
	setglobal("DBM_StatusBarTimerDrag", nil);

	local newDragBar = CreateFrame("Frame", "DBM_StatusBarTimerDrag", UIParent, DBMStatusBars_Designs[DBM.Options.StatusBarDesign].template);
	newDragBar:SetScale(DBM.Options.StatusBarSize.Scale);
	newDragBar:SetWidth(DBM.Options.StatusBarSize.Width);
	getglobal(newDragBar:GetName().."Bar"):SetWidth(DBM.Options.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.StatusBarDesign].widthModifier);
	getglobal(newDragBar:GetName().."Bar"):SetStatusBarColor(DBM.Options.StatusBarColor.r, DBM.Options.StatusBarColor.g, DBM.Options.StatusBarColor.b, DBM.Options.StatusBarColor.a);
	getglobal(newDragBar:GetName().."BarText"):SetWidth(DBM.Options.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.StatusBarDesign].textWidthModifier);
	getglobal(newDragBar:GetName().."BarText"):SetFont(STANDARD_TEXT_FONT, DBM.Options.StatusBarSize.Text);
	getglobal(newDragBar:GetName().."BarTimer"):SetFont(STANDARD_TEXT_FONT, DBM.Options.StatusBarSize.Text);	
	newDragBar:EnableMouse(true);
	newDragBar:SetMovable(true);
	newDragBar:SetFrameStrata("HIGH");
	newDragBar:CreateTexture("DBM_StatusBarTimerDragIcon", "OVERLAY");

	getglobal(newDragBar:GetName().."Icon"):SetTexture("Interface\\Icons\\Spell_Nature_WispSplode");
	getglobal(newDragBar:GetName().."Icon"):SetHeight(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconSize or 18);
	getglobal(newDragBar:GetName().."Icon"):SetWidth(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconSize or 18);
	
	if DBM.Options.IconRight then
		getglobal(newDragBar:GetName().."Icon"):SetPoint("LEFT", "DBM_StatusBarTimerDrag", "RIGHT", -(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconOffsetX or 0), DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconOffsetY or 0);
	else
		getglobal(newDragBar:GetName().."Icon"):SetPoint("RIGHT", "DBM_StatusBarTimerDrag", "LEFT", DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconOffsetX or 0, DBMStatusBars_Designs[DBM.Options.StatusBarDesign].iconOffsetY or 0);
	end
	
	for index, value in pairs(DBMStatusBars_DragFrameFunctions) do
		newDragBar:SetScript(index, value);
	end
	
	DBMStatusBars_DragFrameFunctions["OnLoad"](DBM_StatusBarTimerDrag);
	if type(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].initialize) == "function" then
		DBMStatusBars_Designs[DBM.Options.StatusBarDesign].initialize(DBM_StatusBarTimerDrag);
	end	
	
	if not DBM.Hooks.oldSetStatusBarColor then
		DBM.Hooks.oldSetStatusBarColor = newDragBar.SetStatusBarColor;
	end
	if not DBM.Hooks.oldSetMinMaxValues then
		DBM.Hooks.oldSetMinMaxValues = newDragBar.SetMinMaxValues;
	end
	if not DBM.Hooks.oldSetValue then
		DBM.Hooks.oldSetValue = newDragBar.SetValue;
	end
		
	newDragBar.SetStatusBarColor = function(frame, r, g, b, a)
		if type(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onColorChanged) == "function" then
			DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onColorChanged(frame, r, g, b, a);
		end
		DBM.Hooks.oldSetStatusBarColor(frame, r, g, b, a);
	end
	
	newDragBar.SetMinMaxValues = function(frame, minValue, maxValue)
		if type(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onSetMinMaxValues) == "function" then
			DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onSetMinMaxValues(frame, minValue, maxValue);
		end
		DBM.Hooks.oldSetMinMaxValues(frame, minValue, maxValue);
	end
	
	newDragBar.SetValue = function(frame, value)
		if type(DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onSetValue) == "function" then
			DBMStatusBars_Designs[DBM.Options.StatusBarDesign].onSetValue(frame, value);
		end
		DBM.Hooks.oldSetValue(frame, value);
	end	
	
	newDragBar:SetPoint("CENTER", "DBM_StatusBarTimerAnchor", "CENTER");	
	
	for i = 1, oldBarCount do
		local minValue, maxValue = getglobal("DBM_StatusBarTimer"..i.."Bar"):GetMinMaxValues();
		oldFrameSettings = {
			["isUsed"] = getglobal("DBM_StatusBarTimer"..i).isUsed,
			["usedBy"] = getglobal("DBM_StatusBarTimer"..i).usedBy,
			["syncedBy"] = getglobal("DBM_StatusBarTimer"..i).syncedBy,
			["startedBy"] = getglobal("DBM_StatusBarTimer"..i).startedBy,
			["isRepeating"] = getglobal("DBM_StatusBarTimer"..i).isRepeating,
			["repetitions"] = getglobal("DBM_StatusBarTimer"..i).repetitions,
			["specialColor"] = getglobal("DBM_StatusBarTimer"..i).specialColor,
			["text"] = getglobal("DBM_StatusBarTimer"..i.."BarText"):GetText(),
			["timerText"] = getglobal("DBM_StatusBarTimer"..i.."BarTimer"):GetText(),
			["table"] = getglobal("DBM_StatusBarTimer"..i).table,
			["minValue"] = minValue,
			["maxValue"] = maxValue,
			["value"] = getglobal("DBM_StatusBarTimer"..i.."Bar"):GetValue(),
			["shown"] = getglobal("DBM_StatusBarTimer"..i):IsShown(),
			["iconShown"] = getglobal("DBM_StatusBarTimer"..i.."Icon"):IsShown(),
			["iconTexture"] = getglobal("DBM_StatusBarTimer"..i.."Icon"):GetTexture(),
		};		

		for index, value in pairs(DBMStatusBars_Designs[oldDesign].subFrameNames) do
			setglobal("DBM_StatusBarTimer"..i..value, nil);
		end
		getglobal("DBM_StatusBarTimer"..i):Hide(); --there is no way to delete frames! but a status bar needs ony a few kb memory, so old hidden bars are no problem :)
		setglobal("DBM_StatusBarTimer"..i.."Icon", nil);
		setglobal("DBM_StatusBarTimer"..i, nil); --wtf? i need to set the old variables to nil before I create a new frame...

		DBMStatusBars_CreateNewBar();
		if getglobal("DBM_StatusBarTimer"..i) then
			getglobal("DBM_StatusBarTimer"..i).isUsed = oldFrameSettings.isUsed;
			getglobal("DBM_StatusBarTimer"..i).usedBy = oldFrameSettings.usedBy;
			getglobal("DBM_StatusBarTimer"..i).syncedBy = oldFrameSettings.syncedBy;
			getglobal("DBM_StatusBarTimer"..i).startedBy = oldFrameSettings.startedBy;
			getglobal("DBM_StatusBarTimer"..i).isRepeating = oldFrameSettings.isRepeating;
			getglobal("DBM_StatusBarTimer"..i).repetitions = oldFrameSettings.repetitions;
			getglobal("DBM_StatusBarTimer"..i).specialColor = oldFrameSettings.specialColor;
			getglobal("DBM_StatusBarTimer"..i).table = oldFrameSettings.table;
			if getglobal("DBM_StatusBarTimer"..i).table and getglobal("DBM_StatusBarTimer"..i).table.frame then
				getglobal("DBM_StatusBarTimer"..i).table.frame = getglobal("DBM_StatusBarTimer"..i);
			end
			getglobal("DBM_StatusBarTimer"..i.."BarText"):SetText(oldFrameSettings.text);
			getglobal("DBM_StatusBarTimer"..i.."BarTimer"):SetText(oldFrameSettings.timerText);
			getglobal("DBM_StatusBarTimer"..i.."Bar"):SetMinMaxValues(oldFrameSettings.minValue, oldFrameSettings.maxValue);
			getglobal("DBM_StatusBarTimer"..i.."Bar"):SetValue(oldFrameSettings.value);
			if oldFrameSettings.shown then
				getglobal("DBM_StatusBarTimer"..i):Show();
			end
			if oldFrameSettings.iconShown then
				getglobal("DBM_StatusBarTimer"..i.."Icon"):Show();
				getglobal("DBM_StatusBarTimer"..i.."Icon"):SetTexture(""); --clear texture before setting a new one to prevent an old icon to be displayed when the new texture does not exist
				getglobal("DBM_StatusBarTimer"..i.."Icon"):SetTexture(oldFrameSettings.iconTexture);
			end
		end
	end
end

local hugeBarCount = 0
function DBMHugeStatusBars_ChangeDesign(designID, forceReload)
	local oldDesign = DBM.Options.HugeBars.StatusBarDesign;
	local oldBarCount = 0
	local i = 1
	while getglobal("DBM_HugeBar"..i) do
		oldBarCount = oldBarCount + 1
		i = i + 1
	end
	local oldFrameSettings;
	if oldDesign == designID and not forceReload then
		return;
	end
	if oldDesign ~= designID then
		DBM.Options.HugeBars.StatusBarDesign = designID;
		hugeBarCount = 0;
		DBM.Options.HugeBars.StatusBarColor.r = DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].HugeBars.color.r;
		DBM.Options.HugeBars.StatusBarColor.g = DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].HugeBars.color.g;
		DBM.Options.HugeBars.StatusBarColor.b = DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].HugeBars.color.b;
		DBM.Options.HugeBars.StatusBarColor.a = DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].HugeBars.color.a;
		DBM.Options.HugeBars.StatusBarSize.Width = DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].HugeBars.width;
		DBM.Options.HugeBars.StatusBarSize.Scale = DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].HugeBars.scale;
	end
	if DBM_StatusBarTimerDrag2 then
		DBM_StatusBarTimerDrag2:Hide();
	end

	for index, value in pairs(DBMStatusBars_Designs[oldDesign].subFrameNames) do
		setglobal("DBM_StatusBarTimerDrag2"..value, nil);
	end
	setglobal("DBM_StatusBarTimerDragIcon2", nil);
	setglobal("DBM_StatusBarTimerDrag2", nil);
	local newDragBar2 = CreateFrame("Frame", "DBM_StatusBarTimerDrag2", UIParent, DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].template);
	newDragBar2:SetScale(DBM.Options.HugeBars.StatusBarSize.Scale);
	newDragBar2:SetWidth(DBM.Options.HugeBars.StatusBarSize.Width);
	getglobal(newDragBar2:GetName().."Bar"):SetWidth(DBM.Options.HugeBars.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].widthModifier);
	getglobal(newDragBar2:GetName().."Bar"):SetStatusBarColor(DBM.Options.HugeBars.StatusBarColor.r, DBM.Options.HugeBars.StatusBarColor.g, DBM.Options.HugeBars.StatusBarColor.b, DBM.Options.HugeBars.StatusBarColor.a);
	getglobal(newDragBar2:GetName().."BarText"):SetWidth(DBM.Options.HugeBars.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].textWidthModifier);
	getglobal(newDragBar2:GetName().."BarText"):SetFont(STANDARD_TEXT_FONT, DBM.Options.HugeBars.StatusBarSize.Text);
	getglobal(newDragBar2:GetName().."BarTimer"):SetFont(STANDARD_TEXT_FONT, DBM.Options.HugeBars.StatusBarSize.Text);	
	newDragBar2:EnableMouse(true);
	newDragBar2:SetMovable(true);
	newDragBar2:SetFrameStrata("HIGH");
	newDragBar2:CreateTexture("DBM_StatusBarTimerDrag2Icon", "OVERLAY");

	getglobal(newDragBar2:GetName().."Icon"):SetTexture("Interface\\Icons\\Spell_Nature_WispSplode");
	getglobal(newDragBar2:GetName().."Icon"):SetHeight(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconSize or 18);
	getglobal(newDragBar2:GetName().."Icon"):SetWidth(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconSize or 18);
	
	if DBM.Options.HugeBars.IconRight then
		getglobal(newDragBar2:GetName().."Icon"):SetPoint("LEFT", "DBM_StatusBarTimerDrag2", "RIGHT", -(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconOffsetX or 0), DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconOffsetY or 0);
	else
		getglobal(newDragBar2:GetName().."Icon"):SetPoint("RIGHT", "DBM_StatusBarTimerDrag2", "LEFT", DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconOffsetX or 0, DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconOffsetY or 0);
	end
	
	for index, value in pairs(DBMStatusBars_DragFrameFunctions) do
		newDragBar2:SetScript(index, value);
	end
	
	DBMStatusBars_DragFrameFunctions["OnLoad"](DBM_StatusBarTimerDrag2);
	if type(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].initialize) == "function" then
		DBMStatusBars_Designs[DBM.Options.StatusBarDesign].initialize(DBM_StatusBarTimerDrag2);
	end	
	
	if not DBM.Hooks.oldSetStatusBarColor then
		DBM.Hooks.oldSetStatusBarColor = newDragBar2.SetStatusBarColor;
	end
	if not DBM.Hooks.oldSetMinMaxValues then
		DBM.Hooks.oldSetMinMaxValues = newDragBar2.SetMinMaxValues;
	end
	if not DBM.Hooks.oldSetValue then
		DBM.Hooks.oldSetValue = newDragBar2.SetValue;
	end
		
	newDragBar2.SetStatusBarColor = function(frame, r, g, b, a)
		if type(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onColorChanged) == "function" then
			DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onColorChanged(frame, r, g, b, a);
		end
		DBM.Hooks.oldSetStatusBarColor(frame, r, g, b, a);
	end
	
	newDragBar2.SetMinMaxValues = function(frame, minValue, maxValue)
		if type(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onSetMinMaxValues) == "function" then
			DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onSetMinMaxValues(frame, minValue, maxValue);
		end
		DBM.Hooks.oldSetMinMaxValues(frame, minValue, maxValue);
	end
	
	newDragBar2.SetValue = function(frame, value)
		if type(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onSetValue) == "function" then
			DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onSetValue(frame, value);
		end
		DBM.Hooks.oldSetValue(frame, value);
	end	
	
	newDragBar2:SetPoint("CENTER", "DBM_HugeStatusBarTimerAnchor", "CENTER");
	
	
	for i = 1, oldBarCount do
		local minValue, maxValue = getglobal("DBM_HugeBar"..i.."Bar"):GetMinMaxValues();
		oldFrameSettings = {
			["isUsed"] = getglobal("DBM_HugeBar"..i).isUsed,
			["usedBy"] = getglobal("DBM_HugeBar"..i).usedBy,
			["syncedBy"] = getglobal("DBM_HugeBar"..i).syncedBy,
			["startedBy"] = getglobal("DBM_HugeBar"..i).startedBy,
			["isRepeating"] = getglobal("DBM_HugeBar"..i).isRepeating,
			["repetitions"] = getglobal("DBM_HugeBar"..i).repetitions,
			["specialColor"] = getglobal("DBM_HugeBar"..i).specialColor,
			["text"] = getglobal("DBM_HugeBar"..i.."BarText"):GetText(),
			["timerText"] = getglobal("DBM_HugeBar"..i.."BarTimer"):GetText(),
			["table"] = getglobal("DBM_HugeBar"..i).table,
			["minValue"] = minValue,
			["maxValue"] = maxValue,
			["value"] = getglobal("DBM_HugeBar"..i.."Bar"):GetValue(),
			["shown"] = getglobal("DBM_HugeBar"..i):IsShown(),
			["iconShown"] = getglobal("DBM_HugeBar"..i.."Icon"):IsShown(),
			["iconTexture"] = getglobal("DBM_HugeBar"..i.."Icon"):GetTexture(),
		};		

		for index, value in pairs(DBMStatusBars_Designs[oldDesign].subFrameNames) do
			setglobal("DBM_HugeBar"..i..value, nil);
		end
		getglobal("DBM_HugeBar"..i):Hide(); --there is no way to delete frames! but a status bar needs ony a few kb memory, so old hidden bars are no problem :)
		setglobal("DBM_HugeBar"..i.."Icon", nil);
		setglobal("DBM_HugeBar"..i, nil); --wtf? i need to set the old variables to nil before I create a new frame...

		DBMHugeStatusBars_CreateNewBar();
		if getglobal("DBM_HugeBar"..i) then
			getglobal("DBM_HugeBar"..i).isUsed = oldFrameSettings.isUsed;
			getglobal("DBM_HugeBar"..i).usedBy = oldFrameSettings.usedBy;
			getglobal("DBM_HugeBar"..i).syncedBy = oldFrameSettings.syncedBy;
			getglobal("DBM_HugeBar"..i).startedBy = oldFrameSettings.startedBy;
			getglobal("DBM_HugeBar"..i).isRepeating = oldFrameSettings.isRepeating;
			getglobal("DBM_HugeBar"..i).repetitions = oldFrameSettings.repetitions;
			getglobal("DBM_HugeBar"..i).specialColor = oldFrameSettings.specialColor;
			getglobal("DBM_HugeBar"..i).table = oldFrameSettings.table;
--			if getglobal("DBM_HugeBar"..i).table and getglobal("DBM_HugeBar"..i).table.frame then
--				getglobal("DBM_HugeBar"..i).table.frame = getglobal("DBM_HugeBar"..i);
--			end
			getglobal("DBM_HugeBar"..i.."BarText"):SetText(oldFrameSettings.text);
			getglobal("DBM_HugeBar"..i.."BarTimer"):SetText(oldFrameSettings.timerText);
			getglobal("DBM_HugeBar"..i.."Bar"):SetMinMaxValues(oldFrameSettings.minValue, oldFrameSettings.maxValue);
			getglobal("DBM_HugeBar"..i.."Bar"):SetValue(oldFrameSettings.value);
			if oldFrameSettings.shown then
				getglobal("DBM_HugeBar"..i):Show();
			end
			if oldFrameSettings.iconShown then
				getglobal("DBM_HugeBar"..i.."Icon"):Show();
				getglobal("DBM_HugeBar"..i.."Icon"):SetTexture(""); --clear texture before setting a new one to prevent an old icon to be displayed when the new texture does not exist
				getglobal("DBM_HugeBar"..i.."Icon"):SetTexture(oldFrameSettings.iconTexture);
			end
		end
	end
end


function DBMStatusBars_AnnounceToChat(bar)
	local msg;
	msg = getglobal(bar:GetName().."BarText"):GetText().." - "..DBM.SecondsToTime(bar.table.timer - bar.table.elapsed, nil, true);
	local isBattlegroundBar = false;
	
	if bar.table and (bar.table.bossModID == "Battlegrounds" or bar.table.bossModID == "Alterac" or bar.table.bossModID == "Arathi" or bar.table.bossModID == "Warsong" or bar.table.bossModID == "EyeOfTheStorm") then
		isBattlegroundBar = true;
		msg = string.gsub(msg, ": %- (%d+):(%d+)", " %- %1:%2");
	end
	
	if isBattlegroundBar and bar.table.color and bar.usedBy and not string.find(getglobal(bar:GetName().."BarText"):GetText(), ": ") then
		if bar.table.color.R == 1 and bar.table.color.G == 0 and bar.table.color.B == 0 then
			msg = "<"..DBM_HORDE.."> "..msg;
		elseif bar.table.color.R == 0 and bar.table.color.G == 0 and bar.table.color.B == 1 then
			msg = "<"..DBM_ALLIANCE.."> "..msg;
		end
	end
	
	if ChatFrameEditBox:IsShown() then
		ChatFrameEditBox:Insert(msg);
	else
		if isBattlegroundBar then
			SendChatMessage(msg, "BATTLEGROUND");
		else
			SendChatMessage(msg, "RAID");
		end
	end
end



function DBMStatusBars_StartImportantBar(frame, noFade)
	if not frame then return end
	local barId
	local i = 1
	while getglobal("DBM_HugeBar"..i) do
		if not getglobal("DBM_HugeBar"..i).isUsed then
			barId = i
			break
		end
		i = i + 1
	end
	if not barId then
		barId = DBMHugeStatusBars_CreateNewBar()
	end
	if not barId or not getglobal("DBM_HugeBar"..barId) then
		return false
	end
	local bar = getglobal("DBM_HugeBar"..barId)

	bar.table = { -- clone the table!
		timer = frame.table.timer,
		elapsed = frame.table.elapsed,
		color = frame.table.color,
		bossModID = frame.table.bossModID,
		syncedBy = frame.table.syncedBy,
		syncedBar = frame.table.syncedBar,
		startedBy = frame.table.startedBy,
		icon = frame.table.icon
	}

	if bar.specialColor and not frame.specialColor then 
		getglobal(bar:GetName().."Bar"):SetStatusBarColor(DBM.Options.HugeBars.StatusBarColor.r, DBM.Options.HugeBars.StatusBarColor.g, DBM.Options.HugeBars.StatusBarColor.b, DBM.Options.HugeBars.StatusBarColor.a)
	end
	bar.isUsed = true
	bar.usedBy = frame.usedBy or ""
	bar.syncedBy = frame.syncedBy
	bar.startedBy = frame.startedBy
	bar.isRepeating = frame.isRepeating
	bar.repetitions = frame.repetitions
	bar.specialColor = frame.specialColor
	getglobal(bar:GetName().."Bar"):SetMinMaxValues(0, frame.table.timer)
	getglobal(bar:GetName().."BarText"):SetText(getglobal(frame:GetName().."BarText"):GetText())
	getglobal(bar:GetName().."BarTimer"):SetText(DBM.SecondsToTime(frame.table.timer))
	if frame.specialColor then
		getglobal(bar:GetName().."Bar"):SetStatusBarColor(frame.table.color.R, frame.table.color.G, frame.table.color.B, frame.table.color.A)
	end
	
	if frame.table.icon and DBM.Options.ShowIcon and getglobal(bar:GetName().."Icon") then
		getglobal(bar:GetName().."Icon"):SetTexture("") --clear texture because we don't want to see the old icon if the new texture does not exist
		getglobal(bar:GetName().."Icon"):SetTexture(frame.table.icon)
		getglobal(bar:GetName().."Icon"):Show()
	end
	
	getglobal(bar:GetName().."Bar"):SetAlpha(1)
	bar:SetAlpha(0.1)
	bar:Show()
	if not noFade then
		UIFrameFadeIn(bar, 0.5, 0.1, 1)
	else
		bar:SetAlpha(1.0)
	end
	
	return true
end

function DBMStatusBars_EndImportantBar(frame)
	if not frame.isUsed then
		return
	end
	UIFrameFadeRemoveFrame(getglobal(frame:GetName().."Bar"))
	UIFrameFlashRemoveFrame(getglobal(frame:GetName().."Bar"))
	getglobal(frame:GetName().."Bar").flashTimer = nil
	getglobal(frame:GetName().."Bar").fadeInTime = nil
	getglobal(frame:GetName().."Bar").fadeOutTime = nil
	getglobal(frame:GetName().."Bar").flashDuration = nil
	getglobal(frame:GetName().."Bar").showWhenDone = nil
	getglobal(frame:GetName().."Bar").flashTimer = nil
	getglobal(frame:GetName().."Bar").flashMode = nil
	getglobal(frame:GetName().."Bar").flashInHoldTime = nil
	getglobal(frame:GetName().."Bar").flashOutHoldTime = nil
	getglobal(frame:GetName().."Bar").fadeInfo = nil
	getglobal(frame:GetName().."Bar").fading = nil
	frame.table.isFlashing = nil
	frame:SetAlpha(1)	
	frame.isUsed = false
	frame.syncedBy = "UNKNOWN"
	frame.startedBy = "UNKNOWN"
	frame.usedBy = ""
	frame.table = nil
	frame.specialColor = false;
	frame.fading = nil
	getglobal(frame:GetName().."Bar"):SetStatusBarColor(DBM.Options.StatusBarColor.r, DBM.Options.StatusBarColor.g, DBM.Options.StatusBarColor.b, DBM.Options.StatusBarColor.a)
	getglobal(frame:GetName().."Icon"):Hide()
	frame:Hide()
	DBMHugeStatusBars_PullTogether();
end

function DBMHugeStatusBars_CreateNewBar()
	if hugeBarCount + 1 > DBM.Options.MaxStatusBars then
		return
	end
	hugeBarCount = hugeBarCount + 1
	local newBar = CreateFrame("Frame", "DBM_HugeBar"..hugeBarCount, UIParent, DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].template)
	newBar:SetScript("OnUpdate", function() this.elapsed = this.elapsed + arg1; if this.elapsed >= 0.03 then DBMHugeStatusBars_OnUpdate(this.elapsed) this.elapsed = 0 end end)
	newBar:SetScale(DBM.Options.HugeBars.StatusBarSize.Scale)
	newBar:SetWidth(DBM.Options.HugeBars.StatusBarSize.Width)
	getglobal(newBar:GetName().."Bar"):SetWidth(DBM.Options.HugeBars.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].widthModifier)
	getglobal(newBar:GetName().."Bar"):SetStatusBarColor(DBM.Options.HugeBars.StatusBarColor.r, DBM.Options.HugeBars.StatusBarColor.g, DBM.Options.HugeBars.StatusBarColor.b, DBM.Options.HugeBars.StatusBarColor.a)
	getglobal(newBar:GetName().."BarText"):SetWidth(DBM.Options.HugeBars.StatusBarSize.Width - DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].textWidthModifier)
	getglobal(newBar:GetName().."BarText"):SetFont(STANDARD_TEXT_FONT, DBM.Options.HugeBars.StatusBarSize.Text)
	getglobal(newBar:GetName().."BarTimer"):SetFont(STANDARD_TEXT_FONT, DBM.Options.HugeBars.StatusBarSize.Text)
	getglobal(newBar:GetName().."BarTimer"):SetParent(newBar)
	getglobal(newBar:GetName().."BarText"):SetParent(newBar)
	
	--icon stuff
	local newIcon = newBar:CreateTexture("DBM_HugeBar"..hugeBarCount.."Icon", "OVERLAY")
	newIcon:SetHeight(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconSize or 18)
	newIcon:SetWidth(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconSize or 18)
	if DBM.Options.HugeBars.IconRight then
		newIcon:SetPoint("LEFT", "DBM_HugeBar"..hugeBarCount, "RIGHT", -(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconOffsetX or 0), DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconOffsetY or 0)
	else
		newIcon:SetPoint("RIGHT", "DBM_HugeBar"..hugeBarCount, "LEFT", DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconOffsetX or 0, DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].iconOffsetY or 0)
	end
	----
	
	if hugeBarCount == 1 then
		newBar:SetPoint("CENTER", "DBM_StatusBarTimerDrag2", "CENTER", 0, 0)
	else
		if DBM.Options.HugeBars.StatusBarsFlippedOver then
			newBar:SetPoint("BOTTOM", "DBM_HugeBar"..(hugeBarCount - 1), "TOP", 0, DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].distance)
		else
			newBar:SetPoint("TOP", "DBM_HugeBar"..(hugeBarCount - 1), "BOTTOM", 0, -DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].distance)
		end
	end
	
	if type(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].initialize) == "function" then
		DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].initialize(getglobal("DBM_HugeBar"..hugeBarCount))
	end
		
	if not DBM.Hooks.oldSetStatusBarColor then
		DBM.Hooks.oldSetStatusBarColor = getglobal("DBM_HugeBar"..hugeBarCount.."Bar").SetStatusBarColor
	end
	if not DBM.Hooks.oldSetMinMaxValues then
		DBM.Hooks.oldSetMinMaxValues = getglobal("DBM_HugeBar"..hugeBarCount.."Bar").SetMinMaxValues
	end
	if not DBM.Hooks.oldSetValue then
		DBM.Hooks.oldSetValue = getglobal("DBM_HugeBar"..hugeBarCount.."Bar").SetValue
	end
		
	getglobal("DBM_HugeBar"..hugeBarCount.."Bar").SetStatusBarColor = function(frame, r, g, b, a)
		if type(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onColorChanged) == "function" then
			DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onColorChanged(frame, r, g, b, a)
		end
		DBM.Hooks.oldSetStatusBarColor(frame, r, g, b, a)
	end
	
	getglobal("DBM_HugeBar"..hugeBarCount.."Bar").SetMinMaxValues = function(frame, minValue, maxValue)
		if type(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onSetMinMaxValues) == "function" then
			DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onSetMinMaxValues(frame, minValue, maxValue)
		end
		DBM.Hooks.oldSetMinMaxValues(frame, minValue, maxValue)
	end
	
	getglobal("DBM_HugeBar"..hugeBarCount.."Bar").SetValue = function(frame, value)
		if type(DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onSetValue) == "function" then
			DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].onSetValue(frame, value)
		end
		DBM.Hooks.oldSetValue(frame, value)
	end
	
	DBMGuiUpdateStatusbars()
	
	return hugeBarCount
end

function DBMHugeStatusBars_OnUpdate(elapsed)
	if this and this.isUsed and this.table then
		this.table.elapsed = this.table.elapsed + elapsed;
		
		if DBM.Options.HugeBars.FillUpStatusBars then
			getglobal(this:GetName().."Bar"):SetValue(this.table.elapsed);
		else
			getglobal(this:GetName().."Bar"):SetValue(this.table.timer - this.table.elapsed);
		end
		
		local goodTimer = this.table.timer - this.table.elapsed;
		if goodTimer < 0 then
			goodTimer = 0;
		end
		
		getglobal(this:GetName().."BarTimer"):SetText(DBM.SecondsToTime(goodTimer));
		if this.table.elapsed >= this.table.timer then
			if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == getglobal(this:GetName().."BarText"):GetText() then
				GameTooltip:Hide();
			end
			DBMStatusBars_EndImportantBar(this);
			return;
		end
		if DBM.Options.HugeBars.FlashBars and not this.table.isFlashing and this.table.timer - this.table.elapsed < 7.5 then
			this.table.isFlashing = true;
			UIFrameFlash(getglobal(this:GetName().."Bar"), 0.3, 0.3, this.table.timer - this.table.elapsed, 1, 0, 0.75);
		end
		if DBM.Options.HugeBars.AutoColorBars and this.table and this.table.bossModID ~= "Battlegrounds" and this.table.bossModID ~= "Alterac" and this.table.bossModID ~= "Arathi" and this.table.bossModID ~= "Warsong" and this.table.bossModID ~= "EyeOfTheStorm" then
			local percent = (this.table.timer - this.table.elapsed) / this.table.timer;
			if this.specialColor then
				getglobal(this:GetName().."Bar"):SetStatusBarColor(this.table.color.R + ((1 - this.table.color.R) * (1 - percent)), this.table.color.G * percent, this.table.color.B * percent, this.table.color.A);
			else
				getglobal(this:GetName().."Bar"):SetStatusBarColor(DBM.Options.HugeBars.StatusBarColor.r + ((1 - DBM.Options.HugeBars.StatusBarColor.r) * (1 - percent)), DBM.Options.HugeBars.StatusBarColor.g * percent, DBM.Options.HugeBars.StatusBarColor.b * percent, DBM.Options.HugeBars.StatusBarColor.a);
			end
		end
		local minValue, maxValue;
		minValue, maxValue = getglobal(this:GetName().."Bar"):GetMinMaxValues();
		getglobal(this:GetName().."BarSpark"):ClearAllPoints();
		if DBM.Options.HugeBars.FillUpStatusBars then
			getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", (this:GetName().."Bar"), "LEFT", (((getglobal(this:GetName().."Bar"):GetValue() - elapsed) / maxValue) * getglobal(this:GetName().."Bar"):GetWidth()), DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].sparkOffset);
		else
			getglobal(this:GetName().."BarSpark"):SetPoint("CENTER", (this:GetName().."Bar"), "LEFT", (((getglobal(this:GetName().."Bar"):GetValue()) / maxValue) * getglobal(this:GetName().."Bar"):GetWidth()), DBMStatusBars_Designs[DBM.Options.HugeBars.StatusBarDesign].sparkOffset);
		end
		
		if GameTooltip:IsShown() and GameTooltipTextLeft1 and GameTooltipTextLeft1:GetText() == getglobal(this:GetName().."BarText"):GetText() then
			if GameTooltipTextRight2 then
				GameTooltipTextRight2:SetText(DBM.SecondsToTime(this.table.timer - this.table.elapsed));
			end
			if GameTooltipTextRight3 then
				GameTooltipTextRight3:SetText(DBM.SecondsToTime(this.table.elapsed));
			end
		end
	end
end

function DBMGui_GetStatusBarTimerByID(id)
	for i, v in pairs(DBM.StatusBarData) do
		if v.frame.usedBy == id then
			return v.frame
		end
	end
end
function DBMStatusBars_GetImportantBar(name)
	local i = 1
	while getglobal("DBM_HugeBar"..i) do
		if getglobal("DBM_HugeBar"..i).usedBy == name then
			if getglobal("DBM_HugeBar"..i).isUsed and getglobal("DBM_HugeBar"..i).table then
				return (getglobal("DBM_HugeBar"..i).table.timer or 0) - (getglobal("DBM_HugeBar"..i).table.elapsed or 0)
			end
		end
		i = i + 1
	end
end