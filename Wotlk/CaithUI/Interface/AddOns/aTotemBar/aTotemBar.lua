-- CONFIG
BlizzardTimers = true 
aTotemBarTimers = true
spacing = 8

--END CONFIG

if select(2, UnitClass("player")) ~= "SHAMAN" then
	print("|cff0000FFaTotemBar: |cffffffffThis addon is designed for level 10 or higher shaman.");
	return
end

local aTotemBar = CreateFrame("Frame","aTotemBar",UIParent)
aTotemBar:SetWidth(190 + (spacing*5))
aTotemBar:SetHeight(38)	
aTotemBar:SetPoint("CENTER","UIParent","CENTER")

MultiCastActionBarFrame:SetParent(aTotemBar)
MultiCastActionBarFrame:SetWidth(0.01)

MultiCastSummonSpellButton:SetParent(aTotemBar)
MultiCastSummonSpellButton:ClearAllPoints()
MultiCastSummonSpellButton:SetPoint("BOTTOMLEFT", aTotemBar, 5, 5)

for i=1, 4 do
	_G["MultiCastSlotButton"..i]:SetParent(aTotemBar)
end
MultiCastSlotButton1:ClearAllPoints()
MultiCastSlotButton1:SetPoint("LEFT", MultiCastSummonSpellButton, "RIGHT", spacing, 0)
for i=2, 4 do
	local b = _G["MultiCastSlotButton"..i]
	local b2 = _G["MultiCastSlotButton"..i-1]
	b:ClearAllPoints()
	b:SetPoint("LEFT", b2, "RIGHT", spacing, 0)
end
		
MultiCastRecallSpellButton:ClearAllPoints()
MultiCastRecallSpellButton:SetPoint("LEFT", MultiCastSlotButton4, "RIGHT", spacing, 0)
		
for i=1, 12 do
	local b = _G["MultiCastActionButton"..i]
	local b2 = _G["MultiCastSlotButton"..(i % 4 == 0 and 4 or i % 4)]
	b:ClearAllPoints()
	b:SetPoint("CENTER", b2, "CENTER", 0, 0)
end
		
local dummy = function() return end
for i=1, 4 do
	local b = _G["MultiCastSlotButton"..i]
	b.SetParent = dummy
	b.SetPoint = dummy
end
MultiCastRecallSpellButton.SetParent = dummy
MultiCastRecallSpellButton.SetPoint = dummy

local defaults = { Anchor = "CENTER", X = 0, Y = 0, Scale = 1.0, Hide = false }

local TotemTimers = {};
TotemTimers[1] = CreateFrame("Cooldown","TotemTimers1",MultiCastSlotButton2)
TotemTimers[2] = CreateFrame("Cooldown","TotemTimers2",MultiCastSlotButton1)
TotemTimers[3] = CreateFrame("Cooldown","TotemTimers3",MultiCastSlotButton3)
TotemTimers[4] = CreateFrame("Cooldown","TotemTimers4",MultiCastSlotButton4)
TotemTimers[1]:SetAllPoints(MultiCastSlotButton2)
TotemTimers[2]:SetAllPoints(MultiCastSlotButton1)
TotemTimers[3]:SetAllPoints(MultiCastSlotButton3)
TotemTimers[4]:SetAllPoints(MultiCastSlotButton4)

aTotemBar:RegisterEvent("VARIABLES_LOADED")
aTotemBar:RegisterEvent("PLAYER_ENTERING_WORLD")
aTotemBar:RegisterEvent("PLAYER_TOTEM_UPDATE")

aTotemBar:ClearAllPoints()
aTotemBar:SetScript("OnEvent", function(self,event,...)
        if ( event == "VARIABLES_LOADED" ) then
                aTotemBar_LoadVariables();
        elseif (event=="PLAYER_ENTERING_WORLD") then
		if HasMultiCastActionBar() == false then
			aTotemBar:Hide()
		else
			aTotemBar:Show()
		end
		for i=1, MAX_TOTEMS do
			aTotemBar_Update(i);
		end
	elseif (event=="PLAYER_TOTEM_UPDATE") then
                aTotemBar_Update(select(1,...));
        end
end)

aTotemBar:SetScript("OnMouseDown",function()
	aTotemBar:StartMoving()
end)

aTotemBar:SetScript("OnMouseUp",function()
	aTotemBar:StopMovingOrSizing()
end)


function aTotemBar_Destroy(self, button)
	if (button ~= "RightButton") then return end
	if (self:GetName() == "MultiCastActionButton1") or (self:GetName() == "MultiCastActionButton5") or (self:GetName() == "MultiCastActionButton9") then
		DestroyTotem(2);
	elseif (self:GetName() == "MultiCastActionButton2") or (self:GetName() == "MultiCastActionButton6") or (self:GetName() == "MultiCastActionButton10") then
		DestroyTotem(1);
	elseif (self:GetName() == "MultiCastActionButton3") or (self:GetName() == "MultiCastActionButton7") or (self:GetName() == "MultiCastActionButton11") then
		DestroyTotem(3);
	elseif (self:GetName() == "MultiCastActionButton4") or (self:GetName() == "MultiCastActionButton8") or (self:GetName() == "MultiCastActionButton12") then
		DestroyTotem(4);
	end
end

for i = 1, 12 do
	hooker = _G["MultiCastActionButton"..i];
	hooker:HookScript("OnClick", aTotemBar_Destroy)
end

function aTotemBar_LoadVariables(event)
	if not aTotemBarDB then
		aTotemBarDB = defaults
	end 
	db = aTotemBarDB

	aTotemBar:SetScale(db.Scale)
	aTotemBar:SetPoint(db.Anchor,"UIParent",db.Anchor,db.X, db.Y)
	
	if (db.Hide == true) then
		aTotemBar:SetScale(0.0001)
		aTotemBar:SetAlpha(0.0)
	end
end


function aTotemBar_Update(totemN)
	if BlizzardTimers == false then
		TotemFrame:Hide()
	end
	if aTotemBarTimers == true then
		haveTotem, totemName, startTime, duration = GetTotemInfo(totemN)
       		if (duration == 0) then
			TotemTimers[totemN]:SetCooldown(0, 0);
		else
			TotemTimers[totemN]:SetCooldown(startTime, duration)
		end
	end
end


SLASH_ATOTEMBAR1 = '/atbar';
local function handler(msg, editbox)
	if HasMultiCastActionBar() then
		local command, rest = msg:match("^(%S*)%s*(.-)$");
 		if command == 'hide' then
			if (aTotemBarDB.Hide == false) then
  				aTotemBar:SetScale(0.0001)
				aTotemBar:SetAlpha(0.0)
				db.Hide = true
			else
  				aTotemBar:SetScale(db.Scale)
				aTotemBar:SetAlpha(1.0)
				db.Hide = false
			end	
		elseif command == 'lock' then
			if (aTotemBar:IsMovable()) then
				aTotemBar:SetMovable(false)
				aTotemBar:EnableMouse(false)
				aTotemBar:SetBackdrop(nil)
				local point, relativeTo, relativePoint, xOfs, yOfs = aTotemBar:GetPoint()
				db.Anchor = point
				db.X = xOfs
				db.Y = yOfs
			else
				aTotemBar:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",nil, 
                                            tile = true, tileSize = 16, edgeSize = 16, 
                                            insets = { left = 0, right = 0, top = 0, bottom = 0 }});
				aTotemBar:SetBackdropColor(0,0,0,1);		
				aTotemBar:SetMovable(true)
				aTotemBar:EnableMouse(true)
			end
		elseif command == 'scale' then
			if rest ~= "" then
				aTotemBar:SetScale(rest)
				db.Scale = rest
			else
				print("|cff0000FFaTotembar: |cffffffffTo Set the Scale: /atbar scale X.X");
				print("|cff0000FFaTotembar: |cffffffffChange X.X to a value between 0.1 and 2.0");
			end
		else
			print("|cff0000FFaTotembar: |cffffffffTo Toggle the Position Lock: /atbar lock");
			print("|cff0000FFaTotembar: |cffffffffTo Toggle Visbiiity: /atbar hide");
			print("|cff0000FFaTotembar: |cffffffffTo Set the Scale: /atbar scale 0.9");
 		end
	end
end
SlashCmdList["ATOTEMBAR"] = handler;
