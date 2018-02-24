local dewdrop = DewdropLib:GetInstance('1.0')
local tablet = TabletLib:GetInstance('1.0')

FuBar_PetInfo = FuBarPlugin:GetInstance("1.2"):new({
	name          = FuBar_PetInfoLocals.NAME,
	description   = FuBar_PetInfoLocals.DESCRIPTION,
	version       = "1.0.6",
	releaseDate   = "06-05-2006",
	aceCompatible = 103,
	author        = "Corgi",
	email         = "corgiwow@gmail.com",
	website       = "http://corgi.wowinterface.com/",
	category      = "interface",
	db            = AceDatabase:new("FuBar_PetInfoDB"),
	defaults      = DEFAULT_OPTIONS,
	cmd           = AceChatCmd:new(FuBar_PetInfoLocals.COMMANDS, FuBar_PetInfoLocals.CMD_OPTIONS),
	loc 		  = FuBar_PetInfoLocals,
	hasIcon		  = TRUE,
	hasNoText	  = FALSE,
	canHideText	  = TRUE,
	hasNoColor	  = TRUE,
})

function FuBar_PetInfo:Enable()
	self:RegisterEvent("PLAYER_ENTERING_WORLD", "Update")
	--self:RegisterEvent("PET_UI_CLOSE", "Update")
	--self:RegisterEvent("PET_UI_UPDATE", "Update")
	self:RegisterEvent("PLAYER_PET_CHANGED", "Update")
	self:RegisterEvent("UNIT_PET", "Update")
	--self:RegisterEvent("PET_BAR_UPDATE", "Update")
	self:RegisterEvent("UNIT_PET_EXPERIENCE", "Update")
	self:RegisterEvent("UNIT_PET_TRAINING_POINTS", "Update")
	self:RegisterEvent("UNIT_HAPPINESS", "Update")
end

function FuBar_PetInfo:OnClick()
	FuBar_PetInfo:callDismissPet()
end
	
function FuBar_PetInfo:MenuSettings(level, value)
	if ( level == 1 ) then
		if ( self:isHunter() ) then
			--UIDropDownMenu_AddButton({
			--	text = self.loc.PETINFO_MENU_CALLDISMISSPET,
			--	func = function()
			--		self:callDismissPet()
			--	end,
			--	keepShowOnClick = TRUE
			--})
			dewdrop:AddLine(
				'text', self.loc.PETINFO_MENU_CALLDISMISSPET,
				'func', function()
					FuBar_PetInfo:callDismissPet()
				end
			)
		end
	end
end
	
function FuBar_PetInfo:UpdateData()
	local petIcon = GetPetIcon()
	if ( petIcon ~= nil ) then
		self:SetIcon(petIcon)
	end
	--self:SetText("TESTING2")
end
			
function FuBar_PetInfo:UpdateTooltip()
				
		if ( HasPetUI() ) then
			local petType = UnitCreatureFamily("pet")
			local totalTP, usedTP = GetPetTrainingPoints()
			local freeTP = totalTP - usedTP
			local atkSpeed = UnitAttackSpeed("pet")
			local atkRate = UnitAttackBothHands("pet")
			local lowDmg, hiDmg, offlowDmg, offhiDmg, posBuff, negBuff, percentMod = UnitDamage("pet");
			local listedDPS = (((lowDmg + hiDmg) * .5 + posBuff + negBuff) * percentMod) / atkSpeed;
			local petName = UnitName("pet");
			local petLevel = UnitLevel("pet");
			
			--local petSex = ""
			--if UnitSex("pet") == 2 then
			--	petSex = PETINFO_MENU_FEMALE;
			--else
			--	petSex = PETINFO_MENU_MALE;
			--end
			
			local cat = tablet:AddCategory(
				'columns', 2,
				'child_textR', 0,
				'child_textG', 1,
				'child_textB', 0,
				'child_text2R', 1,
				'child_text2G', 1,
				'child_text2B', 0
			)
			
			--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_PETNAME, petName, 0, 1, 0, 1, 1, 0)
			cat:AddLine(
				'text', self.loc.PETINFO_BUTTON_LABEL_PETNAME,
				'text2', petName
			)
			
			--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_PETLEVEL, petLevel, 0, 1, 0, 1, 1, 0)
			cat:AddLine(
				'text', self.loc.PETINFO_BUTTON_LABEL_PETLEVEL,
				'text2', petLevel
			)
			
			if ( self:isHunter() ) then
				--self.tooltip:AddBlankLine(nil)
				cat:AddLine()
				cat:AddLine()
				cat:AddLine()
				
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_TYPE, petType, 0, 1, 0, 1, 1, 0)
				cat:AddLine(
					'text', self.loc.PETINFO_BUTTON_LABEL_TYPE,
					'text2', petType
				)
				
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_MENU_GENDER, petSex, 0, 1, 0, 1, 1, 0)
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_FOOD, BuildListString(GetPetFoodTypes()), 0, 1, 0, 1, 1, 0) 
				cat:AddLine(
					'text', self.loc.PETINFO_BUTTON_LABEL_FOOD,
					'text2', BuildListString(GetPetFoodTypes())
				)
				
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_LOYALTY, GetPetLoyalty(), 0, 1, 0, 1, 1, 0)
				--local ltext = GetLoyalty()
				cat:AddLine(
					'text', self.loc.PETINFO_BUTTON_LABEL_LOYALTY,
					'text2', GetPetLoyalty()
				)
				
				--self.tooltip:AddBlankLine(nil)
				cat:AddLine()
				cat:AddLine()
				cat:AddLine()
				
				local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
				local happyText = ""
				local loyaltyText = ""
				
				if ( happiness == 1 ) then
				  happyText = self.loc.PETINFO_UNHAPPY_TEXT
				elseif ( happiness == 2 ) then
				  happyText = self.loc.PETINFO_CONTENT_TEXT
				elseif ( happiness == 3 ) then
				  happyText = self.loc.PETINFO_HAPPY_TEXT
				end
				
				if ( loyaltyRate > 0 ) then
					loyaltyText = self.loc.PETINFO_GAININGLOYALTY_TEXT
				else
					loyaltyText = self.loc.PETINFO_LOSINGLOYALTY_TEXT
				end
				
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_HAPPINESS, happyText, 0, 1, 0, 1, 1, 0)
				cat:AddLine(
					'text', self.loc.PETINFO_BUTTON_LABEL_HAPPINESS,
					'text2', happyText
				)
				
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_DAMAGEPERCT, damagePercentage.."%", 0, 1, 0, 1, 1, 0)
				cat:AddLine(
					'text', self.loc.PETINFO_BUTTON_LABEL_DAMAGEPERCT,
					'text2', damagePercentage.."%"
				)
				
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_LOYALTYRATE, loyaltyText, 0, 1, 0, 1, 1, 0)
				cat:AddLine(
					'text', self.loc.PETINFO_BUTTON_LABEL_LOYALTYRATE,
					'text2', loyaltyText
				)
				
				local currentXP, totalXP, toLevelXP = self:PetInfo_GetPetExperience()
				local currentXPPercent = currentXP / totalXP * 100
				local toLevelXPPercent = toLevelXP / totalXP * 100
				
				--self.tooltip:AddBlankLine(nil)
				cat:AddLine()
				cat:AddLine()
				cat:AddLine()
				
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_CURRENT_XP, format(self.loc.PETINFO_PERCENT_FORMAT, currentXP, currentXPPercent), 0, 1, 0 , 1, 1, 0)
				cat:AddLine(
					'text', self.loc.PETINFO_BUTTON_LABEL_CURRENT_XP, 
					'text2', format(self.loc.PETINFO_PERCENT_FORMAT, currentXP, currentXPPercent)
				)
				
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_NEEDED_XP, format(self.loc.PETINFO_PERCENT_FORMAT, toLevelXP, toLevelXPPercent), 0, 1, 0 , 1, 1, 0)
				cat:AddLine(
					'text', self.loc.PETINFO_BUTTON_LABEL_NEEDED_XP, 
					'text2', format(self.loc.PETINFO_PERCENT_FORMAT, toLevelXP, toLevelXPPercent)
				)
				
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_TOTAL_XP, totalXP, 0, 1, 0 , 1, 1, 0)
				cat:AddLine(
					'text', self.loc.PETINFO_BUTTON_LABEL_TOTAL_XP, 
					'text2', totalXP
				)
				
				--self.tooltip:AddBlankLine(nil)
				cat:AddLine()
				cat:AddLine()
				cat:AddLine()
				
				--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_TRAINING_POINTS, freeTP, 0, 1, 0, 1, 1, 0)
				cat:AddLine(
					'text', self.loc.PETINFO_BUTTON_LABEL_TRAINING_POINTS, 
					'text2', freeTP
				)
			end
				
			--self.tooltip:AddBlankLine(nil)
			cat:AddLine()
			cat:AddLine()
			cat:AddLine()
			
			--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_ARMOR_CLASS, UnitArmor("pet"), 0, 1, 0, 1, 1, 0)
			cat:AddLine(
				'text', self.loc.PETINFO_BUTTON_LABEL_ARMOR_CLASS, 
				'text2', UnitArmor("pet")
			)
			
			--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_ATTACK_RATE, atkRate, 0, 1, 0, 1, 1, 0)
			cat:AddLine(
				'text', self.loc.PETINFO_BUTTON_LABEL_ATTACK_RATE,
				'text2', atkRate
			)
			
			--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_ATTACK_SPEED, format(self.loc.PETINFO_AS_FORMAT, atkSpeed), 0, 1, 0, 1, 1, 0)
			cat:AddLine(
				'text', self.loc.PETINFO_BUTTON_LABEL_ATTACK_SPEED, 
				'text2', format(self.loc.PETINFO_AS_FORMAT, atkSpeed)
			)
			
			--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_DPS_LISTED, format(self.loc.PETINFO_DPS_FORMAT, listedDPS), 0, 1, 0, 1, 1, 0)
			cat:AddLine(
				'text', self.loc.PETINFO_BUTTON_LABEL_DPS_LISTED, 
				'text2', format(self.loc.PETINFO_DPS_FORMAT, listedDPS)
			)
			
			--self.tooltip:AddDoubleLine(nil,self.loc.PETINFO_BUTTON_LABEL_DPS_ACTUAL, format(self.loc.PETINFO_DPS_FORMAT, actualDPS), 0, 1, 0, 1, 1, 0)
			
			--self.tooltip:AddBlankLine(nil)
			cat:AddLine()
			cat:AddLine()
			cat:AddLine()
			
			for i=1, NUM_PET_STATS, 1 do
				local label = getglobal("PetStatFrame"..i.."Label")
				local text = getglobal("PetStatFrame"..i.."StatText")
				local frame = getglobal("PetStatFrame"..i)
				local stat
				local effectiveStat
				local posBuff
				local negBuff
				local statStr = ""
				local attrStr = ""
				
				attrbStr = TEXT(getglobal("SPELL_STAT"..(i-1).."_NAME"))..":"
				
				stat, effectiveStat, posBuff, negBuff = UnitStat("pet", i)
		
				if ( ( posBuff == 0 ) and ( negBuff == 0 ) ) then
					statStr = effectiveStat
				else 
					-- If there are any negative buffs then show the main number in red even if there are
					-- positive buffs. Otherwise show in green.
					if ( negBuff < 0 ) then
						statStr = FuBarUtils.Red(effectivestat)
					else
						statStr = FuBarUtils.Green(effectiveStat)
					end
				end
				--self.tooltip:AddDoubleLine(nil, attrbStr, statStr, 0, 1, 0, 1, 1, 0)
				cat:AddLine(
					'text', attrbStr,
					'text2', statStr
				)
			end
			
		else
			--self.tooltip:AddLine(nil,self.loc.PETINFO_BUTTON_LABEL_NOPET, 0, 1, 0)
			local cat = tablet:AddCategory(
				'columns', 1,
				'child_textR', 0,
				'child_textG', 1,
				'child_textB', 0
			)
			
			cat:AddLine(
				'text', self.loc.PETINFO_BUTTON_LABEL_NOPET
			)
		end
		--self.tooltip:SetHint(self.loc.TOOLTIP_HINT_TEXT)
end
	
function FuBar_PetInfo:UpdateText()
	if ( HasPetUI() ) then
		local petName = UnitName("pet")
		local petLevel = UnitLevel("pet")
		if ( petName ~= nil and petLevel ~= nil ) then
			if ( petName == UNKNOWNOBJECT ) then
				petName = "UO"
			end
			self:SetText(petName..": "..petLevel)
		else
			self:SetText(self.loc.PETINFO_BUTTON_LABEL_NOPET)
			self:SetIcon("Interface\\AddOns\\FuBar_PetInfo\\icon")
		end
	else
		self:SetText(self.loc.PETINFO_BUTTON_LABEL_NOPET)
		self:SetIcon("Interface\\AddOns\\FuBar_PetInfo\\icon")
	end
	--self:SetText(self.loc.PETINFO_TOOLTIP)
	--self:SetText("TESTING")
end
	
function FuBar_PetInfo:PetInfo_GetPetExperience()
	local currentXP, totalXP = GetPetExperience()
	local toLevelXP = totalXP - currentXP
	return currentXP, totalXP, toLevelXP
end
	
function FuBar_PetInfo:isHunter()
	local hunterFlag = FALSE
	local playerClass, englishClass = UnitClass("player")
	if englishClass == "HUNTER" then
		hunterFlag = TRUE
	end
	return hunterFlag
end
	
function FuBar_PetInfo:isWarlock()
	local warlockFlag = FALSE
	local playerClass, englishClass = UnitClass("player")
	if englishClass == "WARLOCK" then
		warlockFlag = True
	end
	return warlockFlag
end
	
function FuBar_PetInfo:callDismissPet()
	if ( self:isHunter() ) then
		if ( HasPetUI() ) then
			CastSpellByName("Dismiss Pet")
		else
			CastSpellByName("Call Pet")
		end
	end
end	

FuBar_PetInfo:RegisterForLoad()