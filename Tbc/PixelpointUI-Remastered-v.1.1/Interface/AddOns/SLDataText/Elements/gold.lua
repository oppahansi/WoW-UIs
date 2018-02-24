--[[ 		     SLDataText Module: Gold 				]]
--[[ Author: Taffu  RevDate: 01/16/2012  Version: 5.0.0 ]]

local SLDT, MODNAME = SLDataText, "Gold"
if ( SLDT ) then SLDT.Gold = CreateFrame("Frame") end
--local L = SLDT.Locale
local db, realmDB, frame, text, tool

local goldStart, goldEarned, loggedOn, curGold = 0, 0, true, 0
local function convertMoney(moolah, display)
    local g, s, c = abs(moolah/10000), abs(mod(moolah/100, 100)), abs(mod(moolah, 100))
	local cash
    if ( display ) then -- True = Long display
		if ( g < 1 ) then g = "" else g = string.format("%d|cffffd700g|r ", g) end
		if ( s < 1 ) then s = "" else s = string.format("%d|cffc7c7cfs|r ", s) end
		c = string.format("%d|cffeda55fc|r", c)
        cash = string.format("%s%s%s", g, s, c)
    else
        cash = string.format("%.1f|cffffd700g|r", g)
    end
    return cash
end

local function otherFaction(f)
	if ( f == "Horde" ) then return "Alliance" else return "Horde" end
end

local function SetupToolTip()
	tool:SetScript("OnEnter", function(this)
		GameTooltip:SetOwner(this, db.aF)
		local current, sessStart, sessEarn = convertMoney(curGold, true), convertMoney(goldStart, true), convertMoney(goldEarned, true)
		GameTooltip:AddLine(string.format("|cffffffff%s's ".."Wallet".."|r", UnitName("player")))
		GameTooltip:AddDoubleLine("Current", current, 1,1,0,1,1,1)
		GameTooltip:AddDoubleLine("Session Start", sessStart, 1,1,0,1,1,1)
		if ( curGold < goldStart ) then sessEarn = string.format("|cffffff00-(|r%s|cffffff00)|r", sessEarn) end
		GameTooltip:AddDoubleLine("Session Earned", sessEarn, 1,1,0,1,1,1)
		
		if ( db.altMoney ) then
            local lined = false
            for key, val in pairs(realmDB["Horde"]) do
                if ( key ~= UnitName("player") ) then
                    if ( not lined ) then
                        GameTooltip:AddLine(" ")
                        GameTooltip:AddLine("|cffffff00".."Server Gold".."|r")
                        GameTooltip:AddLine("-------------------------", 1, 1, 1)
						GameTooltip:AddLine("|cffff0000".."Horde".."|r")
                        lined = true
                    end
                    
                    local name, gold = key, 0
                    for k, v in pairs(val) do
                        gold = v
                    end
                    GameTooltip:AddDoubleLine(name, convertMoney(gold, true), 1, 1, 1, 1, 1, 1)
                end
            end
			local lined = false
            for key, val in pairs(realmDB["Alliance"]) do
                if ( key ~= UnitName("player") ) then
                    if ( not lined ) then
                        GameTooltip:AddLine(" ")
						GameTooltip:AddLine("|cff0000ff".."Alliance".."|r")
                        lined = true
                    end
                    
                    local name, gold = key, 0
                    for k, v in pairs(val) do
                        gold = v
                    end
                    GameTooltip:AddDoubleLine(name, convertMoney(gold, true), 1, 1, 1, 1, 1, 1)
                end
            end
            
            local totalGold = 0
			local totalGoldH = 0
			local totalGoldA = 0
            for key, val in pairs(realmDB["Horde"]) do
                for k, v in pairs(val) do
                    totalGold = totalGold + v
					totalGoldH =totalGoldH + v
                end
            end
			for key, val in pairs(realmDB["Alliance"]) do
                for k, v in pairs(val) do
                    totalGold = totalGold + v
					totalGoldA = totalGoldA +v
                end
            end
            if ( totalGold > 0 ) then
                GameTooltip:AddLine(" ")
                GameTooltip:AddLine("-------------------------", 1, 1, 1)
                GameTooltip:AddDoubleLine("Total Gold", convertMoney(totalGold, true), 1, 1, 1, 1, 1, 1)
				if( totalGoldH > 0 and totalGoldA > 0) then
					GameTooltip:AddDoubleLine("Total Gold".." |cffff0000".."Horde".."|r", convertMoney(totalGoldH, true), 1, 1, 1, 1, 1, 1)
					GameTooltip:AddDoubleLine("Total Gold".." |cff0000ff".."Alliance".."|r", convertMoney(totalGoldA, true), 1, 1, 1, 1, 1, 1)
				end
            end
		end
		
		GameTooltip:Show()
	end)
	tool:SetScript("OnLeave", function(this) if ( GameTooltip:IsShown() ) then GameTooltip:Hide() end end)
end

function SLDT.Gold:Enable()
	if ( db.enabled ) then
		SLDT:UpdateBaseText(self, db)
		self:RegisterEvent("PLAYER_MONEY")
		self:RegisterEvent("SEND_MAIL_MONEY_CHANGED")
		self:RegisterEvent("SEND_MAIL_COD_CHANGED")
		self:RegisterEvent("PLAYER_TRADE_MONEY")
		self:RegisterEvent("TRADE_MONEY_CHANGED")
		self:SetScript("OnEvent", function(self, event) self:Refresh() end)
	end
	self:Refresh()
end

function SLDT.Gold:Disable()
	if ( not db.enabled ) then
		self:UnregisterEvent("PLAYER_MONEY")
		self:UnregisterEvent("SEND_MAIL_MONEY_CHANGED")
		self:UnregisterEvent("SEND_MAIL_COD_CHANGED")
		self:UnregisterEvent("PLAYER_TRADE_MONEY")
		self:UnregisterEvent("TRADE_MONEY_CHANGED")
		self:SetScript("OnEvent", nil)
	end
	self:Refresh()
end

function SLDT.Gold:Refresh()
	if ( db.enabled or SLDataText.db.profile.configMode ) then
		if ( not self.firstRun ) then self.firstRun = true; SLDT:UpdateBaseText(self, db) end
		
		curGold = GetMoney()
		realmDB[UnitFactionGroup("player")][UnitName("player")].gold = curGold
		
		local moneyTxt = convertMoney(curGold, db.display)
		if ( loggedOn ) then 
			goldStart = curGold; loggedOn = false
		else
			if ( curGold - goldStart ~= 0 ) then goldEarned = curGold - goldStart end
		end
		text:SetText(moneyTxt)
		
		SLDT:UpdateBaseFrame(SLDT.Gold, db)
	else
		if ( frame:IsShown() and not SLDataText.db.profile.configMode ) then frame:Hide() end
	end
end

SLDT.Gold.optsTbl = {
	[1] = { [1] = "toggle", [2] = "Enabled", [3] = "enabled" },
	[2] = { [1] = "toggle", [2] = "Global Font", [3] = "gfont" },
	[3] = { [1] = "toggle", [2] = "Outline", [3] = "outline" },
	[4] = { [1] = "toggle", [2] = "Force Shown", [3] = "forceShow" },
	[5] = { [1] = "toggle", [2] = "Tooltip On", [3] = "tooltipOn" },
	[6] = { [1] = "toggle", [2] = "Display Style", [3] = "display" },
	[7] = { [1] = "toggle", [2] = "Alt Money", [3] = "altMoney" },
	[8] = { [1] = "range", [2] = "Font Size", [3] = "fontSize", [4] = 6, [5] = 40, [6] = 1 },
	[9] = { [1] = "select", [2] = "Font", [3] = "font", [4] = SLDT.fontTbl },
	[10] = { [1] = "select", [2] = "Justify", [3] = "aP", [4] = SLDT.justTbl },
	[11] = { [1] = "text", [2] = "Parent", [3] = "anch" },
	[12] = { [1] = "select", [2] = "Anchor", [3] = "aF", [4] = SLDT.anchTbl },
	[13] = { [1] = "text", [2] = "X Offset", [3] = "xOff" },
	[14] = { [1] = "text", [2] = "Y Offset", [3] = "yOff" },
	[15] = { [1] = "select", [2] = "Frame Strata", [3] = "strata", [4] = SLDT.stratTbl },
}

local function OnInit()
	SLDT.Gold.db = SLDT.db:RegisterNamespace(MODNAME)
    SLDT.Gold.db:RegisterDefaults({
        profile = {
			name = "Gold",
			enabled = true,
			display = false,
			forceShow = false,
			altMoney = true,
			aP = "CENTER",
			anch = "UIParent",
			aF = "BOTTOMLEFT",
			xOff = 324,
			yOff = 177,
			strata = "LOW",
			gfont = false,
			fontSize = 12,
			font = "Arial Narrow",
			outline = false,
			tooltipOn = true,
        },
		realm = {
			[UnitFactionGroup("player")] = {
				[UnitName("player")] = {
					gold = 0,
				},
			},
			[otherFaction(UnitFactionGroup("player"))] = {
			},
        },
    })
	db = SLDT.Gold.db.profile
	realmDB = SLDT.Gold.db.realm
	
	SLDT.Modules = SLDT.Modules or {}
	if ( not SLDT.Modules[MODNAME] ) then table.insert(SLDT.Modules, { MODNAME, db }) end
	frame, text, tool = SLDT:SetupBaseFrame(SLDT.Gold)
	SetupToolTip()
	
	SLDT.Gold:UnregisterEvent("PLAYER_ENTERING_WORLD")
	SLDT.Gold:Enable()
end

SLDT.Gold:RegisterEvent("PLAYER_ENTERING_WORLD")
SLDT.Gold:SetScript("OnEvent", OnInit)