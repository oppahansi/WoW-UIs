if TukuiCF.unitframes.playerauras == true then return end

local mainhand, _, _, offhand = GetWeaponEnchantInfo()
local rowbuffs = 16

TemporaryEnchantFrame:ClearAllPoints()
TemporaryEnchantFrame:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, TukuiDB.Scale(-16))
TemporaryEnchantFrame.SetPoint = TukuiDB.dummy

ConsolidatedBuffs:ClearAllPoints()
ConsolidatedBuffs:SetPoint("LEFT", Minimap, "LEFT", TukuiDB.Scale(0), TukuiDB.Scale(0))
ConsolidatedBuffs:SetSize(12, 12)
ConsolidatedBuffsIcon:SetTexture(nil)
ConsolidatedBuffs.SetPoint = TukuiDB.dummy

for i = 1, 2 do
	local f = CreateFrame("Frame", nil, _G["TempEnchant"..i])
	TukuiDB.CreatePanel(f, 28, 28, "CENTER", _G["TempEnchant"..i], "CENTER", 0, 0)	
	_G["TempEnchant"..i.."Border"]:Hide()
	_G["TempEnchant"..i.."Icon"]:SetTexCoord(.08, .92, .08, .92)
	_G["TempEnchant"..i.."Icon"]:SetPoint("TOPLEFT", _G["TempEnchant"..i], TukuiDB.Scale(2), TukuiDB.Scale(-2))
	_G["TempEnchant"..i.."Icon"]:SetPoint("BOTTOMRIGHT", _G["TempEnchant"..i], TukuiDB.Scale(-2), TukuiDB.Scale(2))
	_G["TempEnchant"..i]:SetHeight(TukuiDB.Scale(28))
	_G["TempEnchant"..i]:SetWidth(TukuiDB.Scale(28))	
	_G["TempEnchant"..i.."Duration"]:ClearAllPoints()
	_G["TempEnchant"..i.."Duration"]:SetPoint("BOTTOM", 0, TukuiDB.Scale(-13))
	_G["TempEnchant"..i.."Duration"]:SetFont(TukuiCF["media"].minimal, 10, "OUTLINEMONOCHROME")
	TukuiDB.CreateShadow(_G["TempEnchant"..i])
end

local function StyleBuffs(buttonName, index, debuff)
	local buff		= _G[buttonName..index]
	local icon		= _G[buttonName..index.."Icon"]
	local border	= _G[buttonName..index.."Border"]
	local duration	= _G[buttonName..index.."Duration"]
	local count 	= _G[buttonName..index.."Count"]
	if icon and not _G[buttonName..index.."Panel"] then
		icon:SetTexCoord(.08, .92, .08, .92)
		icon:SetPoint("TOPLEFT", buff, TukuiDB.Scale(2), TukuiDB.Scale(-2))
		icon:SetPoint("BOTTOMRIGHT", buff, TukuiDB.Scale(-2), TukuiDB.Scale(2))
		
		buff:SetHeight(TukuiDB.Scale(28))
		buff:SetWidth(TukuiDB.Scale(28))
		TukuiDB.CreateShadow(buff)
				
		duration:ClearAllPoints()
		duration:SetPoint("BOTTOM", 0, TukuiDB.Scale(-13))
		duration:SetFont(TukuiCF["media"].minimal, 10, "OUTLINEMONOCHROME")
		
		local inInstance, instanceType = IsInInstance()
		if not inInstance then
			AnimGroup(buff, 0, TukuiDB.Scale(150), 0.2)
			buff:HookScript("OnShow", function(self, ...)
				SlideIn(buff)
			end)
		end
		
		count:ClearAllPoints()
		count:SetPoint("TOPLEFT", TukuiDB.Scale(1), TukuiDB.Scale(-2))
		count:SetFont(TukuiCF["media"].minimal, 10, "OUTLINEMONOCHROME")
		
		local panel = CreateFrame("Frame", buttonName..index.."Panel", buff)
		TukuiDB.CreatePanel(panel, 28, 28, "CENTER", buff, "CENTER", 0, 0)
		panel:SetFrameLevel(buff:GetFrameLevel() - 1)
		panel:SetFrameStrata(buff:GetFrameStrata())
	end
	if border then border:Hide() end
end

local function UpdateBuffAnchors()
	buttonName = "BuffButton"
	local buff, previousBuff, aboveBuff;
	local numBuffs = 0;
	
	if Minimap:IsVisible() then
		TempEnchant1:ClearAllPoints()
		TempEnchant1:SetPoint("TOPRIGHT", UIParent, TukuiDB.Scale(-157), TukuiDB.Scale(-10))
	else
		TempEnchant1:ClearAllPoints()
		TempEnchant1:SetPoint("TOPRIGHT", UIParent, TukuiDB.Scale(-10), TukuiDB.Scale(-10))
	end
	TempEnchant2:ClearAllPoints()
	TempEnchant2:SetPoint("RIGHT", TempEnchant1, "LEFT", TukuiDB.Scale(-5), 0)
	
	for index=1, BUFF_ACTUAL_DISPLAY do
		local buff = _G[buttonName..index]
		StyleBuffs(buttonName, index, false)
		
		if ( buff.consolidated ) then
			if ( buff.parent == BuffFrame ) then
				buff:SetParent(ConsolidatedBuffsContainer)
				buff.parent = ConsolidatedBuffsContainer
			end
		else
			numBuffs = numBuffs + 1
			index = numBuffs
			buff:ClearAllPoints()
			if ( (index > 1) and (mod(index, rowbuffs) == 1) ) then
				if ( index == rowbuffs+1 ) then
					if Minimap:IsVisible() then 
						buff:SetPoint("TOPRIGHT", UIParent, TukuiDB.Scale(-157), TukuiDB.Scale(-67))
					else
						if Minimap:IsVisible() then
							buff:SetPoint("TOPRIGHT", UIParent, TukuiDB.Scale(-157), TukuiDB.Scale(-67)) -- 10
						else
							buff:SetPoint("TOPRIGHT", UIParent, TukuiDB.Scale(-10), TukuiDB.Scale(-67))
						end
					end
				else
					buff:SetPoint("TOPRIGHT", UIParent, TukuiDB.Scale(-157), TukuiDB.Scale(-67))
				end
				aboveBuff = buff;
			elseif ( index == 1 ) then
				local mainhand, _, _, offhand, _, _, hand3 = GetWeaponEnchantInfo()
					if (mainhand and offhand and hand3) and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant3, "LEFT", TukuiDB.Scale(-5), 0)
					elseif ((mainhand and offhand) or (mainhand and hand3) or (offhand and hand3)) and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant2, "LEFT", TukuiDB.Scale(-5), 0)
					elseif ((mainhand and not offhand and not hand3) or (offhand and not mainhand and not hand3) or (hand3 and not mainhand and not offhand)) and not UnitHasVehicleUI("player") then
						buff:SetPoint("RIGHT", TempEnchant1, "LEFT", TukuiDB.Scale(-5), 0)
					else
						if Minimap:IsVisible() then
							buff:SetPoint("TOPRIGHT", UIParent, TukuiDB.Scale(-157), TukuiDB.Scale(-10))
						else
							buff:SetPoint("TOPRIGHT", UIParent, TukuiDB.Scale(-10), TukuiDB.Scale(-10))
						end
					end
			else
				buff:SetPoint("RIGHT", previousBuff, "LEFT", TukuiDB.Scale(-4), 0)
			end
			previousBuff = buff
		end		
	end
end

local function UpdateDebuffAnchors(buttonName, index)
	local debuff = _G[buttonName..index];
	StyleBuffs(buttonName, index, true)
	local dtype = select(5, UnitDebuff("player",index))      
	local color
	--debuff:SetWidth(TukuiDB.Scale(26)
	--debuff:SetHeight(TukuiDB.Scale(26)
	if (dtype ~= nil) then
		color = DebuffTypeColor[dtype]
	else
		color = DebuffTypeColor["none"]
	end
	_G[buttonName..index.."Panel"]:SetBackdropBorderColor(color.r * 0.6, color.g * 0.6, color.b * 0.6)
	debuff:ClearAllPoints()
	if index == 1 then
		if Minimap:IsVisible() then
			debuff:SetPoint("TOPRIGHT", UIParent, TukuiDB.Scale(-157), TukuiDB.Scale(-125))
		else
			debuff:SetPoint("TOPRIGHT", UIParent, TukuiDB.Scale(-10), TukuiDB.Scale(-125))
		end
	else
		debuff:SetPoint("RIGHT", _G[buttonName..(index-1)], "LEFT", TukuiDB.Scale(-5), 0)
	end
end

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function() mainhand, _, _, offhand = GetWeaponEnchantInfo() end)
f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f:RegisterEvent("PLAYER_EVENTERING_WORLD")

hooksecurefunc("BuffFrame_UpdateAllBuffAnchors", UpdateBuffAnchors)
hooksecurefunc("DebuffButton_UpdateAnchors", UpdateDebuffAnchors)

local HyBuffUpdater = CreateFrame("Frame")
HyBuffUpdater:SetScript("OnUpdate", UpdateBuffAnchors)