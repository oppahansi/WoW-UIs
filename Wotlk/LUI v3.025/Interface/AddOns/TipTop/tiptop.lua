--CREATE FRAMES--
TipTop = CreateFrame("FRAME", nil, GameTooltip)
	local TipTop = TipTop
local tt = GameTooltip
local ttSBar = GameTooltipStatusBar
local ttSBarBG = CreateFrame("Frame", nil, ttSBar)
local ttHealth = ttSBar:CreateFontString("ttHealth", "OVERLAY")
	ttHealth:SetPoint("CENTER")
local raidIcon = ttSBar:CreateTexture(nil, "OVERLAY")

--OTHER LOCALS--
local LSM = LibStub("LibSharedMedia-3.0")
local player = UnitName("player")
local server = GetRealmName()
local _, db, BGPosition, color, font
local talents = {}
local tooltips = {	GameTooltip,
					ItemRefTooltip,
					ShoppingTooltip1,
					ShoppingTooltip2,
					ShoppingTooltip3,
					WorldMapTooltip}

--UPVALUES--
local table_sort = _G.table.sort
local GetItemInfo = _G.GetItemInfo
local GetItemQualityColor = _G.GetItemQualityColor
local GetRaidTargetIndex = _G.GetRaidTargetIndex
local GetTalentTabInfo = _G.GetTalentTabInfo
local SetRaidTargetIconTexture = _G.SetRaidTargetIconTexture
local UnitClass = _G.UnitClass
local UnitClassification = _G.UnitClassification
local UnitExists = _G.UnitExists
local UnitHealth = _G.UnitHealth
local UnitIsAFK = _G.UnitIsAFK
local UnitIsConnected = _G.UnitIsConnected
local UnitIsDead = _G.UnitIsDead
local UnitIsDND = _G.UnitIsDND
local UnitIsTapped = _G.UnitIsTapped
local UnitIsTappedByPlayer = _G.UnitIsTappedByPlayer
local UnitLevel = _G.UnitLevel
local UnitHealthMax = _G.UnitHealthMax
local UnitName = _G.UnitName
local UnitPlayerControlled = _G.UnitPlayerControlled


function TipTop:SetBackgrounds()
	local backdrop = {	bgFile = LSM:Fetch("background", db.bg),
						insets = {left=db.inset, right=db.inset, top=db.inset, bottom=db.inset},
						edgeFile = LSM:Fetch("border", db.border),
						edgeSize = db.borderWidth	}
	for i = 1, #tooltips do
		tooltips[i]:SetScale(db.scale)
		tooltips[i]:SetBackdrop(backdrop)
		tooltips[i]:SetBackdropColor(db.bgColor.r, db.bgColor.g, db.bgColor.b, db.alpha)
		tooltips[i]:SetBackdropBorderColor(db.borderColor.r, db.borderColor.g, db.borderColor.b, db.borderColor.a)
	end
	TipTop:SetBackdrop(backdrop)
	TipTop:SetBackdropColor(db.bgColor.r, db.bgColor.g, db.bgColor.b, db.alpha)
	TipTop:SetBackdropBorderColor(db.borderColor.r, db.borderColor.g, db.borderColor.b, db.borderColor.a)
	TipTop:SetFrameLevel(tt:GetFrameLevel() - 1)	--make sure the tooltip isn't overlapped by the bg frame
	
	--make the tooltip transparent to see the TipTop frame behind it
	tt:SetBackdrop({})
	--make other frames look like TipTop's tooltips if they imitate the tooltip
	tt.GetBackdrop = function() return backdrop end
	tt.GetBackdropColor = function() return db.bgColor.r, db.bgColor.g, db.bgColor.b, db.alpha end
	tt.GetBackdropBorderColor = function() return db.borderColor.r, db.borderColor.g, db.borderColor.b, db.borderColor.a end
--	TOOLTIP_DEFAULT_COLOR = db.borderColor
--	TOOLTIP_DEFAULT_BACKGROUND_COLOR = db.bgColor
	-- make the map's tooltip always match (will reset itself on every OnShow)
	WorldMapTooltip.SetBackdropColor = function() end
	WorldMapTooltip.SetBackdropBorderColor = function() end
end

function TipTop:SetFonts()
	font = LSM:Fetch("font", db.font)	--grab font from LSM
	ttHealth:SetFont(font, 12, "OUTLINE")
	GameTooltipHeaderText:SetFont(font, 12 + 2, db.fontFlag)
	GameTooltipText:SetFont(font, 12, db.fontFlag)
	GameTooltipTextSmall:SetFont(font, 12 - 2, db.fontFlag)
	ShoppingTooltip1TextLeft1:SetFont(font, 12 -2, db.fontFlag)
	ShoppingTooltip1TextLeft2:SetFont(font, 12, db.fontFlag)
	ShoppingTooltip1TextLeft3:SetFont(font, 12 -2, db.fontFlag)
	ShoppingTooltip2TextLeft1:SetFont(font, 12 -2, db.fontFlag)
	ShoppingTooltip2TextLeft2:SetFont(font, 12, db.fontFlag)
	ShoppingTooltip2TextLeft3:SetFont(font, 12 -2, db.fontFlag)
	ShoppingTooltip3TextLeft1:SetFont(font, 12 -2, db.fontFlag)
	ShoppingTooltip3TextLeft2:SetFont(font, 12, db.fontFlag)
	ShoppingTooltip3TextLeft3:SetFont(font, 12 -2, db.fontFlag)
	--these were in the tips' onshow before - need to check later
	for i = 1, ShoppingTooltip1:NumLines() do
		_G["ShoppingTooltip1TextRight"..i]:SetFont(font, 12 -2, db.fontFlag)
	end
	for i = 1, ShoppingTooltip2:NumLines() do
		_G["ShoppingTooltip2TextRight"..i]:SetFont(font, 12 -2, db.fontFlag)
	end
	for i = 1, ShoppingTooltip3:NumLines() do
		_G["ShoppingTooltip3TextRight"..i]:SetFont(font, 12 -2, db.fontFlag)
	end
	if GameTooltipMoneyFrame1 then
		GameTooltipMoneyFrame1PrefixText:SetFont(font, 12, db.fontFlag)
		GameTooltipMoneyFrame1SuffixText:SetFont(font, 12, db.fontFlag)
		GameTooltipMoneyFrame1CopperButtonText:SetFont(font, 12, db.fontFlag)
		GameTooltipMoneyFrame1SilverButtonText:SetFont(font, 12, db.fontFlag)
		GameTooltipMoneyFrame1GoldButtonText:SetFont(font, 12, db.fontFlag)
	end
end

function TipTop:SBarCustom()
	ttSBar:SetStatusBarTexture(LSM:Fetch("statusbar", db.healthBar))
	ttSBar:SetStatusBarColor(db.sbarcolor.r, db.sbarcolor.g, db.sbarcolor.b, db.sbarcolor.a)
	ttSBarBG:SetAllPoints()
	ttSBarBG:SetFrameLevel(ttSBar:GetFrameLevel() - 1)
	ttSBarBG:SetBackdrop({bgFile = LSM:Fetch("statusbar", db.sbarbg)})
	ttSBarBG:SetBackdropColor(db.sbarbgcolor.r, db.sbarbgcolor.g, db.sbarbgcolor.b, db.sbarbgcolor.a)
end

function TipTop:SBarPosition()
	ttSBar:ClearAllPoints()
	if db.insideBar then
		if db.topBar then
			ttSBar:SetPoint("TOPRIGHT", tt, "TOPRIGHT", -7, 3)
			ttSBar:SetPoint("TOPLEFT", tt, "TOPLEFT", 10, 3)
			BGPosition = function()	--make the TipTop bg frame resize around the health bar
					if ttSBar:IsShown() then
						TipTop:ClearAllPoints()
						TipTop:SetPoint("BOTTOMRIGHT", tt, "BOTTOMRIGHT")
						TipTop:SetPoint("TOPLEFT", ttSBar, "TOPLEFT", -7, 10)
					else
						TipTop:ClearAllPoints()
						TipTop:SetAllPoints(tt)
					end
				end
		else
			ttSBar:SetPoint("BOTTOMRIGHT", tt, "BOTTOMRIGHT", -7, -5)
			ttSBar:SetPoint("BOTTOMLEFT", tt, "BOTTOMLEFT", 10, -5)
			BGPosition = function()	--make the TipTop bg frame resize around the health bar
					if ttSBar:IsShown() then
						TipTop:ClearAllPoints()
						TipTop:SetPoint("TOPRIGHT", tt, "TOPRIGHT")
						TipTop:SetPoint("BOTTOMLEFT", ttSBar, "BOTTOMLEFT", -7, -7)
					else
						TipTop:ClearAllPoints()
						TipTop:SetAllPoints(tt)
					end
				end
		end
	else
		if db.topBar then
			ttSBar:SetPoint("BOTTOMLEFT", tt, "TOPLEFT", 0, 4)
			ttSBar:SetPoint("BOTTOMRIGHT", tt, "TOPRIGHT", 0, 4)
		else
			ttSBar:SetPoint("TOPLEFT", tt, "BOTTOMLEFT", 0, -4)
			ttSBar:SetPoint("TOPRIGHT", tt, "BOTTOMRIGHT", 0, -4)
		end
		BGPosition = function() end
		TipTop:ClearAllPoints()
		TipTop:SetAllPoints(tt)
	end
end

function TipTop:RaidIcon()
	raidIcon:SetWidth(db.raidIconSize)
	raidIcon:SetHeight(db.raidIconSize)
	raidIcon:SetTexture("Interface\\TARGETINGFRAME\\UI-RaidTargetingIcons")
	raidIcon:SetPoint("CENTER", tt, db.raidIconPosition, db.raidIconX, db.raidIconY)
	raidIcon:Hide()
end

local function RaidIconUpdate()
	local icon = GetRaidTargetIndex("mouseover")
	if icon then
		SetRaidTargetIconTexture(raidIcon, icon)
		raidIcon:Show()
	else
		raidIcon:Hide()
	end
end

local function FadedTip()	--grays out tooltip if unit is tapped or dead
	local tapped = false
	if not UnitPlayerControlled("mouseover") then
		if UnitIsTapped("mouseover") and not UnitIsTappedByPlayer("mouseover") then
			tapped = true
		end
	end
	if UnitIsDead("mouseover") or tapped or not UnitIsConnected("mouseover") then
		local borderColor = db.borderColor
		TipTop:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
		local bgColor = db.bgColor
		TipTop:SetBackdropColor(bgColor.r + .2, bgColor.g +.2, bgColor.b + .2, db.alpha-.1)
	end
end

local function Appendices()	--appends info to the name of the mob - ALSO sets elite graphic
	local classif = UnitClassification("mouseover")
	if db.elite and not elitetexture then
		elitetexture = TipTop:CreateTexture(nil, "OVERLAY")
		elitetexture:SetHeight(70)
		elitetexture:SetWidth(70)
		elitetexture:SetPoint("CENTER", TipTop, "TOPLEFT", 8, -18)
		elitetexture:Hide()
	end
	if classif == "rare" or classif == "rareelite" then
		tt:AppendText(" (Rare)")
		if db.elite and classif == "rarelite" then
			elitetexture:SetTexture("Interface\\AddOns\\TipTop\\media\\rare_graphic")
			elitetexture:Show()
		end
	elseif classif == "elite" or classif == "worldboss" or classif == "boss" then 
		if db.elite then
			elitetexture:SetTexture("Interface\\AddOns\\TipTop\\media\\elite_graphic")
			elitetexture:Show()
		end
	end
	if UnitIsAFK("mouseover") then
		tt:AppendText(" (AFK)")
	elseif UnitIsDND("mouseover") then
		tt:AppendText(" (DND)")
	end
end

local function BorderClassColor()	--colors tip border by unit's class
	local _,class = UnitClass("mouseover")
	if db.classColor and class then
		TipTop:SetBackdropBorderColor(color[class].r - .2, color[class].g - .2, color[class].b - .2, db.borderColor.a)
	else
		local borderColor = db.borderColor
		TipTop:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
	end
	if db.classIcon then
		local text = GameTooltipTextLeft1:GetText()
		local path = "Interface\\AddOns\\TipTop\\media\\"
		GameTooltipTextLeft1:SetText("|T"..path..class..":24|t "..text)
		tt:Show()
	end
end

local function ItemQualityBorder(tip)	--colors tip border by item quality
	if db.itemColor then
		local _,item = tip:GetItem()	--tip is whatever tooltip called the OnTooltipSetItem script
		if item then
			local _,_,quality = GetItemInfo(item)
			if quality then
				local r, g, b = GetItemQualityColor(quality)
				if r and g and b then
					if tip == tt then
						TipTop:SetBackdropBorderColor(r - .2, g - .2, b - .2, db.borderColor.a)
					else
						tip:SetBackdropBorderColor(r - .2, g - .2, b - .2, db.borderColor.a)
					end
				end
			end
		end
	end
end

local function CalcHealth(_,hp)	--sets health text on status bar
	if db.healthText then
		local maxhp = UnitHealthMax("mouseover")
		if maxhp == 0 then ttHealth:SetText(" ") return end	--or... if maxhp == 0 then maxhp = 1 end
		local hp = hp or UnitHealth("mouseover")
		local per = (hp/maxhp) * 100
		if db.textformat == "100/100" then
			ttHealth:SetFormattedText("%d / %d", hp, maxhp)
		elseif db.textformat == "100%" then
			if per >= 0 then	--gives funny negative numbers when tooltip fades
				ttHealth:SetFormattedText("%d%%", per)
			end
		elseif db.textformat == "100/100 (100%)" then
			if per >= 0 then
				ttHealth:SetFormattedText("%d / %d (%d%%)", hp, maxhp, per)
			end
		end
	end
end

local function TargetTextUpdate()	--shows and updates target text
	if db.showTargetText then
		local target, tserver = UnitName("mouseovertarget")
		local _,tclass = UnitClass("mouseovertarget")
		if target and target ~= UNKNOWN and tclass then
			local targetLine
			for i=1, GameTooltip:NumLines() do	--scan tip to see if Target line is already added
				local left, right, leftText, rightText
				left = _G[GameTooltip:GetName().."TextLeft"..i]
				leftText = left:GetText()
				right = _G[GameTooltip:GetName().."TextRight"..i]
				if leftText == "Target:" then	--if already present, then just update it
					if db.you and target == player and (tserver == nil or tserver == server) then
						right:SetText("<<YOU>>")
						right:SetTextColor(.9, 0, .1)
					else
						right:SetText(target)
						right:SetTextColor(color[tclass].r,color[tclass].g,color[tclass].b)
					end
					tt:Show()
					targetLine = true
				end
			end
			if targetLine ~= true then	--if not present, then add it
				if db.you and target == player and (tserver == nil or tserver == server) then
					tt:AddDoubleLine("Target:", "<<YOU>>", nil, nil, nil, .9, 0, .1)
				else
					local tcolor = color[tclass]
					if tcolor then	--sometimes get an error about tcolor being nil - maybe from tips appearing/disappearing too fast?
						tt:AddDoubleLine("Target:", target, nil,nil,nil,tcolor.r,tcolor.g,tcolor.b)
					end
				end
				tt:Show()
			else 
				targetLine = false
			end
		end
	end
end

local function TalentQuery()	--send request for talent info
	if CanInspect("mouseover") and db.showTalentText then
		if UnitName("mouseover") ~= player and UnitLevel("mouseover") > 9 then
			local talentline = nil
			for i=1, tt:NumLines() do
				local left, leftText
				left = _G["GameTooltipTextLeft"..i]
				leftText = left:GetText()
				if leftText == "Talents:" then
					talentline = 1
				end
			end
			if not talentline then
				if InspectFrame and InspectFrame:IsShown() then	--to not step on default UI's toes
					tt:AddDoubleLine("Talents:", "Inspect Frame is open", nil,nil,nil, 1,0,0)
				elseif Examiner and Examiner:IsShown() then		--same thing with Examiner
					tt:AddDoubleLine("Talents:", "Examiner frame is open", nil,nil,nil, 1,0,0)
				else
					NotifyInspect("mouseover")
					TipTop:RegisterEvent("INSPECT_TALENT_READY")
					tt:AddDoubleLine("Talents:", "...")	--adds the Talents line with a placeholder for info
				end
				tt:Show()
			end
		end
	end
end

local function TalentsSort(a,b)	--the spec table is a copy of the talents table
	return a.pnts > b.pnts		--this sorts the spec table to see what tree has the most talent points
end

local function TalentText()
	if UnitExists("mouseover") then
		local pnts, tree
		local active = GetActiveTalentGroup(1)
		for i=1,3 do
			tree,_,pnts = GetTalentTabInfo(i, 1, nil, active)
			talents[i] = {tree = tree, pnts = pnts}
		end
		local points = talents[1].pnts.."/"..talents[2].pnts.."/"..talents[3].pnts
		local spec = talents	--copies the table to be able to sort, but still keep talents in correct order
		table_sort(spec, TalentsSort)
		for i=1, GameTooltip:NumLines() do
			local left = _G[GameTooltip:GetName().."TextLeft"..i]
			local leftText = left:GetText()
			if leftText == "Talents:" then	--finds the Talents line and updates with info
				local right = _G[GameTooltip:GetName().."TextRight"..i]
				right:SetText(spec[1].tree.." ("..points..")")
			end
			tt:Show()
		end
	end
	tt:UnregisterEvent("INSPECT_TALENT_READY")
end

local function MouseoverTargetUpdate()	--do this stuff whenever the mouseover unit is changed
	--sets min size for aesthetics and for extended health text
	if tt:GetWidth() < 175 and db.healthText and db.textformat == "100/100 (100%)" then
		tt:SetWidth(175)
	elseif tt:GetWidth() < 125 then
		tt:SetWidth(125)
	end
	BorderClassColor()
	CalcHealth()
	RaidIconUpdate()
	TalentQuery()
	Appendices()
	FadedTip()
end

local function TipShow()	--do this stuff whenever the tip is shown
	if not tt:GetUnit() and not tt:GetItem() then
		local borderColor = db.borderColor
		TipTop:SetBackdropBorderColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
	end
	local bgColor = db.bgColor
	TipTop:SetBackdropColor(bgColor.r, bgColor.g, bgColor.b, db.alpha)
	BGPosition()
	if elitetexture then
		elitetexture:Hide()	--hide this in case tip isn't showing a unit or the unit is not elite/rare atm
	end
end

local function PlayerLogin()
	if TipTopPCDB.charSpec then
		db = TipTopPCDB
	else
		db = TipTopDB
	end
	TipTop:SetBackgrounds()
	TipTop:SBarCustom()
	TipTop:SBarPosition()
	TipTop:SetFonts()
	TipTop:RaidIcon()
	
	color = CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS	--support for CUSTOM_CLASS_COLORS addons
	if CUSTOM_CLASS_COLORS then
		CUSTOM_CLASS_COLORS:RegisterCallback(function() color = CUSTOM_CLASS_COLORS end)
	end

	--moves tooltip
	hooksecurefunc("GameTooltip_SetDefaultAnchor", function (tooltip, parent)
			if db.onCursor then
				tt:SetOwner(parent, "ANCHOR_CURSOR")
			else
				tt:SetOwner(parent, "ANCHOR_NONE")
				tt:SetPoint(db.anchor, UIParent, db.anchor, db.offsetX, db.offsetY)
			end
		end)
	
	TipTop:UnregisterEvent("PLAYER_LOGIN")
	TipTop:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
	TipTop:SetScript("OnEvent", function(_, event)
				if event == "UPDATE_MOUSEOVER_UNIT" then
					MouseoverTargetUpdate()
				elseif event == "INSPECT_TALENT_READY" then
					TalentText()
				end
			end)
	local moneyfontset
	for i=1,#tooltips do
		tooltips[i]:HookScript("OnTooltipSetItem", function(tip)
				ItemQualityBorder(tip)
				--the vendor price strings don't exist until the first time they're needed
				if GameTooltipMoneyFrame1 and not moneyfontset then
					TipTop:SetFonts()
					moneyfontset = true
				end
			end)
	end
	ttSBar:HookScript("OnValueChanged", CalcHealth)
	ttSBar:HookScript("OnUpdate", TargetTextUpdate)
	
	PlayerLogin = nil	--let this function be garbage collected
end


TipTop:RegisterEvent("PLAYER_LOGIN")
TipTop:SetScript("OnEvent", PlayerLogin)
TipTop:SetScript("OnShow", TipShow)