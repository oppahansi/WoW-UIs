-- Level
if not TukuiCF["datatext"].level == nil or TukuiCF["datatext"].level > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].level, Text)
   
	local int = 1

	local function Update(self, t)
	  int = int - t
	  if int < 0 then
		Text:SetText(hexa.."Level: "..hexb..UnitLevel("player"))
		int = 1
	  end     
	end

	Stat:RegisterEvent("PLAYER_LEVEL_UP")
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end

-- Zone Text
if not TukuiCF["datatext"].zone == nil or TukuiCF["datatext"].zone > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].zone, Text)

	local function Update(self, t)
		Text:SetText(hexa..GetMinimapZoneText()..hexb)
		Text:SetWidth(100)    
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end

-- Player Honor
if not TukuiCF["datatext"].honor == nil or TukuiCF["datatext"].honor > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].honor, Text)

    local function Update(self)
	
	local localized_label, amount, icon_file_name = GetCurrencyInfo(392)
	
		Text:SetText(hexa.."Honor"..hexb..": "..amount)   
	end
   
    Stat:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN")
	Stat:RegisterEvent("PLAYER_PVP_KILLS_CHANGED")
	Stat:RegisterEvent("HONOR_CURRENCY_UPDATE")
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end



-- PVP Lifetime Kills
if not TukuiCF["datatext"].kills == nil or TukuiCF["datatext"].kills > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].kills, Text)
   
	local int = 1

	local function Update(self, t)
	  int = int - t
	  if int < 0 then
		 Text:SetText(hexa.."Kills"..hexb..": "..GetPVPLifetimeStats())
		 int = 1
	  end     
	end

	Stat:RegisterEvent("PLAYER_PVP_KILLS_CHANGED")
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
	
end

-- Mastery
if not TukuiCF["datatext"].mastery == nil or TukuiCF["datatext"].mastery > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].mastery, Text)
   
	local int = 1

	local function Update(self, t)
	  int = int - t
	  if int < 0 then
		 Text:SetText(GetCombatRating(26)..hexa.." Mastery"..hexb)
		 int = 1
	  end     
	end

	Stat:RegisterEvent("PLAYER_PVP_KILLS_CHANGED")
	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
	
end

-- Mastery
if not TukuiCF["datatext"].mastery == nil or TukuiCF["datatext"].mastery > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].mastery, Text)
   
	local function Update(self)
		Text:SetText(hexa.."Mastery"..hexb..": "..GetCombatRating(26))     
	end

	Stat:RegisterEvent("PLAYER_PVP_KILLS_CHANGED")
	Stat:SetScript("OnUpdate", Update)
	Update(Stat)
end

-- Player Hit Rating
if not TukuiCF["datatext"].hit == nil or TukuiCF["datatext"].hit > 0 then
	local Stat = CreateFrame("Frame")

	local Text  = TukuiInfoLeft:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.font, TukuiCF["datatext"].fontsize)
	TukuiDB.PP(TukuiCF["datatext"].hit, Text)
    
	local int = 1

	local function Update(self, t)
	int = int - t
	local base, posBuff, negBuff = UnitAttackPower("player");
	local effective = base + posBuff + negBuff;
	local Rbase, RposBuff, RnegBuff = UnitRangedAttackPower("player");
	local Reffective = Rbase + RposBuff + RnegBuff;

	Rattackpwr = Reffective
	spellpwr = GetSpellBonusDamage(7)
	attackpwr = effective

	if int < 0 then
			if attackpwr > spellpwr and select(2, UnitClass("Player")) ~= "HUNTER" then
				Text:SetText(format("%.2f", GetCombatRatingBonus(6)).."%"..hexa.." Hit"..hexb)
			elseif select(2, UnitClass("Player")) == "HUNTER" then
				Text:SetText(format("%.2f", GetCombatRatingBonus(7)).."%"..hexa.." Hit"..hexb)
			else
				Text:SetText(format("%.2f", GetCombatRatingBonus(8)).."%"..hexa.." Hit"..hexb)
			end
			int = 1
		end     
	end

	Stat:SetScript("OnUpdate", Update)
	Update(Stat, 10)
end

-- ZONE BACKGROUND
if TukuiCF.datatext.topzone then
	ZoneBackground = CreateFrame("Frame", "ZoneBackground", UIParent)
	TukuiDB.CreatePanel(ZoneBackground, TukuiDB.Scale(120), TukuiDB.Scale(18), "TOP", UIParent, "TOP", 0, TukuiDB.Scale(-10))
	ZoneBackground:SetFrameLevel(2)
	HydraDB.SetBorder(ZoneBackground)
	TukuiDB.CreateShadow(ZoneBackground)

	ZoneToggle = CreateFrame("Frame", "ZoneToggle", UIParent)
	TukuiDB.CreatePanel(ZoneToggle, TukuiDB.Scale(120), TukuiDB.Scale(18), "CENTER", ZoneBackground, "CENTER", 0, 0)
	ZoneToggle:SetAlpha(0)
	ZoneToggle:SetFrameStrata("HIGH")
	ZoneToggle:EnableMouse(true)
	AnimGroup(ZoneBackground, 0, TukuiDB.Scale(150), 0.4)
	AnimGroup(ZoneToggle, 0,  TukuiDB.Scale(150), 0.4)
	ZoneToggle:SetScript("OnMouseDown", function(self)
		if not ZoneBackground:IsVisible() then
			SlideIn(ZoneBackground)
		else
			SlideOut(ZoneBackground)
		end
	end)

	local TukuiZone = CreateFrame("Frame")
	ZoneText = ZoneBackground:CreateFontString(nil, "LOW")
	ZoneText:SetFont(TukuiCF.media.font, 12)
	ZoneText:SetPoint("CENTER", ZoneBackground, 0, 0)
	ZoneText:SetShadowColor(0, 0, 0)
	ZoneText:SetShadowOffset(1.25, -1.25)

	local function ZoneUpdate(self)
		if GetMinimapZoneText() == "Putricide's Laboratory of Alchemical Horrors and Fun" then
			ZoneText:SetText(hexa.."Putricide's Laboratory"..hexb)
		else
			ZoneText:SetText(hexa..GetMinimapZoneText()..hexb)
		end
		ZoneBackground:SetWidth(ZoneText:GetWidth() + TukuiDB.Scale(16))  
	end
	TukuiZone:SetScript("OnUpdate", ZoneUpdate)
	ZoneUpdate(TukuiZone, 10)
	ZoneToggle:SetWidth(ZoneBackground:GetWidth())
end