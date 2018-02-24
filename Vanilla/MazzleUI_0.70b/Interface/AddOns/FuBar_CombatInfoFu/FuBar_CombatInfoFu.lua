local tablet = TabletLib:GetInstance('1.0')
local dewdrop = DewdropLib:GetInstance('1.0')

FuBar_CombatInfoFu = FuBarPlugin:new({
	loc           = FuBar_CombatInfoFuLocals,
	name          = FuBar_CombatInfoFuLocals.NAME,
	description   = FuBar_CombatInfoFuLocals.DESCRIPTION,
	version       = "0.61",
	releaseDate   = "05-10-2006",
	aceCompatible = 103,
	fuCompatible  = 102,
	author        = "_dire_",
	email         = "",
	website       = "",
	category      = "combat",
	db            = AceDatabase:new("FuBar_CombatInfoFuDB"),
	defaults      = {
		showValue 		= nil,
		showStatLabel	= true
	},
	cmd           = AceChatCmd:new(FuBar_CombatInfoFuLocals.COMMANDS, FuBar_CombatInfoFuLocals.CMD_OPTIONS),
	hasIcon       = FuBar_CombatInfoFuLocals.BUTTON_ICON,

	-- Methods

	GetCritChance=function(self)
		local attackSpell = GetSpellName(1,BOOKTYPE_SPELL)
		local i=1
		if ( attackSpell ~= self.loc.LOCALE.CRIT_ATTACKTEXT ) then
			local name, texture, offset, numSpells = GetSpellTabInfo(1)
			while (GetSpellName(i,BOOKTYPE_SPELL) ~= self.loc.LOCALE.CRIT_ATTACKTEXT and i<=numSpells) do
				i=i+1
			end
		end
		FumbatTip:ClearLines()
		FumbatTip:SetSpell(i, BOOKTYPE_SPELL)
		spellName = getglobal("FumbatTipTextLeft2"):GetText()
		return string.sub(spellName,0,string.find(spellName, "%s")-2)
	end,
	
	CanParry=function(self)
		local parrySpell = GetSpellName(1,BOOKTYPE_SPELL)
		local i=1
		if ( parrySpell ~= self.loc.LOCALE.SPELLBOOK_PARRY ) then
			local name, texture, offset, numSpells = GetSpellTabInfo(1)
			while (GetSpellName(i,BOOKTYPE_SPELL) ~= self.loc.LOCALE.SPELLBOOK_PARRY and i<=numSpells) do
				i=i+1
			end
		end
		if(GetSpellName(i,BOOKTYPE_SPELL)==self.loc.LOCALE.SPELLBOOK_PARRY) then
			return true
		end
		return nil
	end,
	
	GetHunterExtraRangedCrit=function(self)
		local lclass,eclass=UnitClass("player")
		if(eclass=="Hunter") then
			_, _, _, _, currRank, _= GetTalentInfo(2,4);
			return currRank
		end
		return 0
--[[ iterative version...
		local locclass,engclass=UnitClass("player")
		if(engclass~="Hunter") then
			return 0
		end

		local numTabs = GetNumTalentTabs();
		for t=1, numTabs do
			local numTalents = GetNumTalents(t);
			for i=1, numTalents do
				local nameTalent, icon, iconx, icony, currRank, maxRank= GetTalentInfo(t,i);
				if(nameTalent=="Lethal Shots")then return currRank end
			end
		end
		return 0
]]--
	end,

	ToggleShowValue=function(self,value)
		if(self.data.showValue==value) then
			self.data.showValue=nil
		else
			self.data.showValue=value
		end
		self.datachanged=1
		self:UpdateText()
		return self.data.showValue
	end,

	ToggleShowStatLabel=function(self)
		self.data.showStatLabel=not self.data.showStatLabel
		self.datachanged=1
		self:UpdateText()
		return self.data.showStatLabel
	end,
	
	Initialize = function(self)
	end,
	
	RegisterEvents = function(self)
		local i=1
		while(self.loc.EVENTS[i])do
			self:RegisterEvent(self.loc.EVENTS[i],"Update")
			i=i+1
		end
	end,
	
	UnregisterEvents = function(self)
		local i=1
		while(self.loc.EVENTS[i])do
			self:UnregisterEvent(self.loc.EVENTS[i])
			i=i+1
		end
		self:RegisterEvent("PLAYER_ENTERING_WORLD","RegisterEvents")
	end,

	Enable = function(self)
		self:RegisterEvents()
		self:RegisterEvent("PLAYER_LEAVING_WORLD","UnregisterEvents")
	end,
	
	Disable = function(self)
	end,
	
	MenuSettings = function(self)
		
		dewdrop:AddLine(
			'text',self.loc.LOCALE.OPTIONS_SHOWBLOCK_TEXT,
			'arg1',self,
			'arg2',self.loc.MENU_BLOCK,
			'func',"ToggleShowValue",
			'checked',(self.data.showValue==self.loc.MENU_BLOCK)
		)
		
		dewdrop:AddLine(
			'text',self.loc.LOCALE.OPTIONS_SHOWCRIT_TEXT,
			'arg1',self,
			'arg2',self.loc.MENU_CRIT,
			'func',"ToggleShowValue",
			'checked',(self.data.showValue==self.loc.MENU_CRIT)
		)
		dewdrop:AddLine(
			'text',self.loc.LOCALE.OPTIONS_SHOWDODGE_TEXT,
			'arg1',self,
			'arg2',self.loc.MENU_DODGE,
			'func',"ToggleShowValue",
			'checked',(self.data.showValue==self.loc.MENU_DODGE),
			'disabled',(self.data.parryChance=="0.00")
		)
		dewdrop:AddLine(
			'text',self.loc.LOCALE.OPTIONS_SHOWPARRY_TEXT,
			'arg1',self,
			'arg2',self.loc.MENU_PARRY,
			'func',"ToggleShowValue",
			'checked',(self.data.showValue==self.loc.MENU_PARRY)
		)
		dewdrop:AddLine(
			'text',self.loc.LOCALE.OPTIONS_SHOWAVOIDANCE_TEXT,
			'arg1',self,
			'arg2',self.loc.MENU_AVOID,
			'func',"ToggleShowValue",
			'checked',(self.data.showValue==self.loc.MENU_AVOID)
		)
		dewdrop:AddLine(
			'text',self.loc.LOCALE.OPTIONS_SHOWRCRIT_TEXT,
			'arg1',self,
			'arg2',self.loc.MENU_RCRIT,
			'func',"ToggleShowValue",
			'checked',(self.data.showValue==self.loc.MENU_RCRIT)
		)
		dewdrop:AddLine(
			'text',self.loc.LOCALE.OPTIONS_SHOWARMORPERC_TEXT,
			'arg1',self,
			'arg2',self.loc.MENU_ARMORPERC,
			'func',"ToggleShowValue",
			'checked',(self.data.showValue==self.loc.MENU_ARMORPERC)
		)
		dewdrop:AddLine(
			'text',self.loc.LOCALE.OPTIONS_SHOWARMOR_TEXT,
			'arg1',self,
			'arg2',self.loc.MENU_ARMOR,
			'func',"ToggleShowValue",
			'checked',(self.data.showValue==self.loc.MENU_ARMOR)
		)		
		dewdrop:AddLine(
			'text',self.loc.LOCALE.OPTIONS_SHOWAP_TEXT,
			'arg1',self,
			'arg2',self.loc.MENU_AP,
			'func',"ToggleShowValue",
			'checked',(self.data.showValue==self.loc.MENU_AP)
		)		
		dewdrop:AddLine(
			'text',self.loc.LOCALE.OPTIONS_SHOWRAP_TEXT,
			'arg1',self,
			'arg2',self.loc.MENU_RAP,
			'func',"ToggleShowValue",
			'checked',(self.data.showValue==self.loc.MENU_RAP)
		)
	
		dewdrop:AddLine()
		
		dewdrop:AddLine(
			'text',self.loc.LOCALE.OPTIONS_SHOWSTATLABEL_TEXT,
			'arg1',self,
			'func',"ToggleShowStatLabel",
			'checked',self.data.showStatLabel
		)
		
	end,

	UpdateData = function(self)
		if(arg1) then
			local i=1
			while(self.loc.DONT_PROCESS_UNIT[i])do
				if(strfind(arg1,self.loc.DONT_PROCESS_UNIT[i]))then
					return
				end
				i=i+1
			end
		end
	
		self.update=GetTime()
		if(not self.lastupdate) then
			self.lastupdate=0
		end
		if(self.lastupdate>=self.update+1) then
			return
		end
		self.lastupdate=GetTime()

		self.blockChance=format("%.2f",GetBlockChance())
		self.critChance=self:GetCritChance()
		self.dodgeChance=format("%.2f",GetDodgeChance())
		if(self:CanParry()) then
			self.parryChance=format("%.2f",GetParryChance())
		else
			self.parryChance="0.00"
		end
	
		self.playerLevel=UnitLevel("player")

		self.meleeAPbase, self.meleeAPpos, self.meleeAPneg=UnitAttackPower("player")
		self.meleeAPtotal=self.meleeAPbase+self.meleeAPpos+self.meleeAPneg
		self.meleeAPpos=nil
		self.meleeAPneg=nil
		
		self.meleeMainSpeed, self.meleeOffSpeed = UnitAttackSpeed("player")
		self.meleeOffHasWeapon = OffhandHasWeapon()
		self.meleeMainLowDmg, self.meleeMainHiDmg, self.meleeOffLowDmg, self.meleeOffHiDmg, self.meleePosDmg, self.meleeNegDmg, self.percent = UnitDamage("player")
		self.meleeMainAvgDmg = ((self.meleeMainHiDmg + self.meleeMainLowDmg)*.5) / self.meleeMainSpeed
		self.meleeMainLowDmg=floor(self.meleeMainLowDmg)
		self.meleeMainHiDmg=floor(self.meleeMainHiDmg)
		
		self.meleeOffhand=OffhandHasWeapon()
		if(self.meleeOffhand) then
			self.meleeOffAvgDmg = ((self.meleeOffHiDmg + self.meleeOffLowDmg)*.5) / self.meleeOffSpeed
			self.meleeOffHiDmg = ceil(self.meleeOffHiDmg)
			self.meleeOffLowDmg = floor(self.meleeOffLowDmg)
		end
		
		self.meleeMainSkillBase, self.meleeMainSkillMod, self.meleeOffhandSkillBase, self.meleeOffhandSkillMod=UnitAttackBothHands("player")
		self.meleeMainSkill=self.meleeMainSkillBase+self.meleeMainSkillMod
		self.meleeOffhandSkill=self.meleeOffhandSkillBase+self.meleeOffhandSkillMod
		self.meleeMainSkillMod=nil
		self.meleeOffhandSkillMod=nil
		
		self.rangedAPbase, self.rangedAPpos, self.rangedAPneg=UnitRangedAttackPower("player")
		self.rangedAPtotal=self.rangedAPbase+self.rangedAPpos+self.rangedAPneg
		self.rangedAPpos=nil
		self.rangedAPneg=nil
		
		self.rangedBase, self.rangedModifier = UnitRangedAttack("player")
		self.rangedSpeed, self.rangedLowDmg, self.rangedHiDmg = UnitRangedDamage("player")
		self.rangedBaseDamage = (self.rangedLowDmg + self.rangedHiDmg) * 0.5
		self.rangedFullDamage = (self.rangedBaseDamage + self.meleePosDmg + self.meleeNegDmg) * self.percent
		self.rangedAvgDmg = (max(self.rangedFullDamage,1) / self.rangedSpeed)
		self.rangedBonus = (self.rangedFullDamage - self.rangedBaseDamage)
		self.rangedLowDmg = max(floor(self.rangedLowDmg + self.rangedBonus),1)
		self.rangedHiDmg = max(ceil(self.rangedHiDmg + self.rangedBonus),1)
		self.rangedBonus=nil
		
		self.rangedSkillBase, self.rangedSkillMod = UnitRangedAttack("player")
		self.rangedSkill=self.rangedSkillBase+self.rangedSkillMod
		self.rangedSkillMod=nil
		
		self.armorBase, self.armorEffective, _, _, _ = UnitArmor("player")
		self.armorReduction = self.armorEffective/((85 * self.playerLevel) + 400)
		self.armorReduction = 100 * (self.armorReduction/(self.armorReduction + 1))
		
		self.defenseBase, self.defenseMod=UnitDefense("player")
		self.defenseTotal=self.defenseBase+self.defenseMod
		self.defenseMod=nil
		
		self.rangedCrit=self.critChance+self:GetHunterExtraRangedCrit()

		self.datachanged=1
	end,
	
	UpdateText = function(self)
		if(arg1) then
			local i=1
			while(self.loc.DONT_PROCESS_UNIT[i])do
				if(strfind(arg1,self.loc.DONT_PROCESS_UNIT[i]))then
					return
				end
				i=i+1
			end
		end

		local stattext, statlabel, color
		color="|cffffffff"
		if(self.data.showValue==self.loc.MENU_BLOCK) then
			stattext=self.blockChance.."%"
			statlabel=self.loc.LOCALE.BLOCK_TEXT
			self:SetIcon(self.loc.BLOCK_ICON)
		elseif(self.data.showValue==self.loc.MENU_CRIT) then
			stattext=self.critChance.."%"
			statlabel=self.loc.LOCALE.CRIT_TEXT
			self:SetIcon(self.loc.CRIT_ICON)
		elseif(self.data.showValue==self.loc.MENU_DODGE) then
			stattext=self.dodgeChance.."%"
			statlabel=self.loc.LOCALE.DODGE_TEXT
			self:SetIcon(self.loc.DODGE_ICON)
		elseif(self.data.showValue==self.loc.MENU_PARRY) then
			stattext=self.parryChance.."%"
			statlabel=self.loc.LOCALE.PARRY_TEXT
			self:SetIcon(self.loc.PARRY_ICON)
		elseif(self.data.showValue==self.loc.MENU_ARMORPERC) then
			stattext=format("%.1f%%",self.armorReduction)
			statlabel=self.loc.LOCALE.ARMORPERC_TEXT..": "
			if(self.armorEffective<self.armorBase) then
				color="|cffff0000"
			elseif(self.armorEffective>self.armorBase) then
				color="|cff00ff00"
			end
			self:SetIcon(self.loc.ARMORPERC_ICON)
		elseif(self.data.showValue==self.loc.MENU_ARMOR) then
			stattext=self.armorEffective
			statlabel=self.loc.LOCALE.ARMOR_TEXT..": "
			if(self.armorEffective<self.armorBase) then
				color="|cffff0000"
			elseif(self.armorEffective>self.armorBase) then
				color="|cff00ff00"
			end
			self:SetIcon(self.loc.ARMOR_ICON)
		elseif(self.data.showValue==self.loc.MENU_AP) then
			stattext=self.meleeAPtotal
			statlabel=self.loc.LOCALE.AP_TEXT
			if(self.meleeAPtotal<self.meleeAPbase) then
				color="|cffff0000"
			elseif(self.meleeAPtotal>self.meleeAPbase) then
				color="|cff00ff00"
			end
			self:SetIcon(self.loc.AP_ICON)
		elseif(self.data.showValue==self.loc.MENU_RAP) then
			stattext=self.rangedAPtotal
			statlabel=self.loc.LOCALE.RAP_TEXT
			if(self.rangedAPtotal<self.rangedAPbase) then
				color="|cffff0000"
			elseif(self.rangedAPtotal>self.rangedAPbase) then
				color="|cff00ff00"
			end
			self:SetIcon(self.loc.RAP_ICON)
		elseif(self.data.showValue==self.loc.MENU_AVOID) then
			stattext=self.dodgeChance+self.parryChance.."%"
			statlabel=self.loc.LOCALE.AVOIDANCE_TEXT
			self:SetIcon(self.loc.AVOID_ICON)
		elseif(self.data.showValue==self.loc.MENU_RCRIT) then
			stattext=self.rangedCrit.."%"
			statlabel=self.loc.LOCALE.RCRIT_TEXT
			self:SetIcon(self.loc.CRIT_ICON)
		else
			stattext=""
			statlabel=self.loc.LOCALE.BUTTON_LABEL
			self:SetIcon(self.loc.BUTTON_ICON)
		end
		if(self.data.showStatLabel) then
			self:SetText(statlabel..color..stattext.."|r")
		else
			self:SetText(color..stattext.."|r")
		end

		self.datachanged=nil
	end,

	UpdateTooltip = function(self)
-- chances
		local cat=tablet:AddCategory(
			'columns', 2,
			'child_textR', 1,
			'child_textG', 1,
			'child_textB', 0,
			'child_text2R', 1,
			'child_text2G', 1,
			'child_text2B', 1
		)
		cat:AddLine(
			'text',self.loc.LOCALE.CRIT_TEXT,
			'text2',self.critChance.."%"
		)
		cat:AddLine(
			'text',self.loc.LOCALE.BLOCK_TEXT,
			'text2',self.blockChance.."%"
		)
		cat:AddLine(
			'text',self.loc.LOCALE.DODGE_TEXT,
			'text2',self.dodgeChance.."%"
		)
		cat:AddLine(
			'text',self.loc.LOCALE.PARRY_TEXT,
			'text2',self.parryChance.."%"
		)
		cat:AddLine(
			'text',self.loc.LOCALE.AVOIDANCE_TEXT,
			'text2',format("%.2f",self.dodgeChance+self.parryChance).."%"
		)

-- melee
		cat=tablet:AddCategory(
			'columns', 2,
			'child_textR', 1,
			'child_textG', 1,
			'child_textB', 0,
			'child_text2R', 1,
			'child_text2G', 1,
			'child_text2B', 1
		)
		cat:AddLine(
			'text',self.loc.LOCALE.MELEE_TEXT,
			'text2',format(" (+%.1f DPS)",self.meleeAPtotal/self.loc.AP2DPS)
		)
		cat:AddLine(
			'text',self.loc.LOCALE.MELEE_POWER_TEXT,
			'text2',self.meleeAPtotal.." ("..self.meleeAPbase.." base)"
		)
		cat:AddLine(
			'text',self.loc.LOCALE.MELEE_MAINSKILL_TEXT,
			'text2',self.meleeMainSkill.." ("..self.meleeMainSkillBase.." base)"
		)
		cat:AddLine(
			'text',self.loc.LOCALE.MELEE_MAINSPEED_TEXT,
			'text2',format("%.2f",self.meleeMainSpeed)
		)
		cat:AddLine(
			'text',self.loc.LOCALE.MELEE_MAINDMG_TEXT,
			'text2',self.meleeMainLowDmg.." - "..self.meleeMainHiDmg
		)
		cat:AddLine(
			'text',self.loc.LOCALE.MELEE_MAINAVGDMG_TEXT,
			'text2',format("%.1f",self.meleeMainAvgDmg)
		)
	
		--offhand
		if(self.meleeOffhand) then
		cat:AddLine(
			'text',self.loc.LOCALE.MELEE_OFFHANDSKILL_TEXT,
			'text2',self.meleeOffhandSkill.." ("..self.meleeOffhandSkillBase.." base)"
		)
		cat:AddLine(
			'text',self.loc.LOCALE.MELEE_OFFHANDSPEED_TEXT,
			'text2',format("%.2f",self.meleeOffSpeed)
		)
		cat:AddLine(
			'text',self.loc.LOCALE.MELEE_OFFHANDDMG_TEXT,
			'text2',self.meleeOffLowDmg.." - "..self.meleeOffHiDmg
		)
		cat:AddLine(
			'text',self.loc.LOCALE.MELEE_OFFHANDDMG_TEXT,
			'text2',format("%.1f",self.meleeOffAvgDmg)
		)
		end

-- ranged
		if(self.rangedSpeed>0) then
		cat=tablet:AddCategory(
			'columns', 2,
			'child_textR', 1,
			'child_textG', 1,
			'child_textB', 0,
			'child_text2R', 1,
			'child_text2G', 1,
			'child_text2B', 1
		)
		cat:AddLine(
			'text',self.loc.LOCALE.RCRIT_TEXT,
			'text2',self.rangedCrit.."%"
		)
		cat:AddLine(
			'text',self.loc.LOCALE.RANGE_TEXT,
			'text2',format(" (+%.1f DPS)",self.rangedAPtotal/self.loc.AP2DPS)
		)
		cat:AddLine(
			'text',self.loc.LOCALE.RANGEPWR_TEXT,
			'text2',self.rangedAPtotal.." ("..self.rangedAPbase.." base)"
		)
		cat:AddLine(
			'text',self.loc.LOCALE.RANGESKILL_TEXT,
			'text2',self.rangedSkill.." ("..self.rangedSkillBase.." base)"
		)
		cat:AddLine(
			'text',self.loc.LOCALE.RANGEATTACKSPEED,
			'text2',format("%.2f",self.rangedSpeed)
		)
		cat:AddLine(
			'text',self.loc.LOCALE.RANGEDMG_TEXT,
			'text2',self.rangedLowDmg.." - "..self.rangedHiDmg
		)
		cat:AddLine(
			'text',self.loc.LOCALE.RANGEAVGDMG_TEXT,
			'text2',format("%.1f",self.rangedAvgDmg)
		)
		end

-- armor
		cat=tablet:AddCategory(
			'columns', 2,
			'child_textR', 1,
			'child_textG', 1,
			'child_textB', 0,
			'child_text2R', 1,
			'child_text2G', 1,
			'child_text2B', 1
		)
		cat:AddLine(
			'text',self.loc.LOCALE.ARMOR_TEXT,
			'text2',self.armorEffective.." ("..self.armorBase.." base)"
		)
		cat:AddLine(
			'text',"Dmg vs. lvl "..self.playerLevel.." reduced by: ",
			'text2',format("%.1f%%",self.armorReduction)
		)
		cat:AddLine(
			'text',self.loc.LOCALE.DEFENSE_TEXT,
			'text2',self.defenseTotal.." ("..self.defenseBase.." base)"
		)
	end,
})

FuBar_CombatInfoFu:RegisterForLoad()
