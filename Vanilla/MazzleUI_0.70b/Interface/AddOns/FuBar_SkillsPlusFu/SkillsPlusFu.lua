SkillsPlusFu = AceLibrary("AceAddon-2.0"):new("FuBarPlugin-2.0",
                                              "AceConsole-2.0", 
                                              "AceDB-2.0",
                                              "AceEvent-2.0",
                                              "AceHook-2.0"
                                              )
-- variables
local L       = AceLibrary("AceLocale-2.1"):GetInstance("SkillsPlusFu", true)
local BS      = AceLibrary("Babble-Spell-2.0")
local crayon  = AceLibrary("Crayon-2.0")
local tablet  = AceLibrary("Tablet-2.0")
local dewdrop = AceLibrary("Dewdrop-2.0")
local toonSaveKey = ''
                                              
-- set properties                                             
SkillsPlusFu.clickableTooltip = true
SkillsPlusFu.canHideText      = true
SkillsPlusFu.defaultPosition  = "RIGHT"
SkillsPlusFu.hasIcon          = BS:GetSpellIcon("Engineering")
SkillsPlusFu.hasNoColor       = true

-- register stuff
SkillsPlusFu:RegisterDB("SkillsPlusFuDB")
SkillsPlusFu:RegisterDefaults("char", {hidden = {}} )
SkillsPlusFu:RegisterDefaults("profile", {
                                -- flags
                                showBooleanSkills = false,
                                -- lists
                                toonSave = {},} 
                             )

-- methods

function SkillsPlusFu:IsShowingBooleanSkills()
	return self.db.profile.showBooleanSkills
end

function SkillsPlusFu:ToggleShowingBooleanSkills()
	self.db.profile.showBooleanSkills = not self.db.profile.showBooleanSkills
	self:UpdateTooltip()
	return self.db.profile.showBooleanSkills
end

function SkillsPlusFu:OnInitialize()
    self.labelName = L["FUBAR_LABEL"]
	self.skillList = {}
end

function SkillsPlusFu:OnEnable()
    -- skills management
	self:RegisterEvent("SKILL_LINES_CHANGED","Update")
	self:RegisterEvent("PLAYER_LEVEL_UP","Update") 
    -- variables
    toonSaveKey = GetCVar('realmName')..'|'..UnitName('player')
    self:UpdateToonInfo()
end

-- toon management
function SkillsPlusFu:UpdateToonInfo()
    if (self.db.profile.toonSave[toonSaveKey] == nil) then
        self.db.profile.toonSave[toonSaveKey] = {}
    end
    if (self.labelName == L["FUBAR_LABEL"]) and
       (self.db.profile.toonSave[toonSaveKey].LastUsed ~= nil) then
        self.labelName = self.db.profile.toonSave[toonSaveKey].LastUsed
    else
        self.db.profile.toonSave[toonSaveKey].LastUsed = self.labelName
    end
end

-- skills management
function SkillsPlusFu:ToggleCategory(id, button)
	if self.db.char.hidden[id] then
		self.db.char.hidden[id] = false
	else
		self.db.char.hidden[id] = true
	end
	-- Refresh in place
	self:UpdateTooltip()
end

function SkillsPlusFu:IsProfession(skillName)
        if (skillName == BS"Alchemy") then
       		dewdrop:AddLine(
        		'text', BS"Alchemy",
	        	'func', function() CastSpellByName(BS"Alchemy")
                                   self:UpdateText(BS"Alchemy",BS:GetSpellIcon("Alchemy"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Blacksmithing") then
       		dewdrop:AddLine(
        		'text', BS"Blacksmithing",
	        	'func', function() CastSpellByName(BS"Blacksmithing")
                                   self:UpdateText(BS"Blacksmithing",BS:GetSpellIcon("Blacksmithing"))
                         end,
      			'arg1', self
                )
        end
        if (skillName == BS"Cooking") then
       		dewdrop:AddLine(
        		'text', BS"Cooking",
	        	'func', function() CastSpellByName(BS"Cooking")
                                   self:UpdateText(BS"Cooking",BS:GetSpellIcon("Cooking"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Enchanting") then
       		dewdrop:AddLine(
        		'text', BS"Disenchant",
	        	'func', function() CastSpellByName(BS"Disenchant")
                                   self:UpdateText(BS"Disenchant",BS:GetSpellIcon("Disenchant"))
                        end,
       			'arg1', self
                )
       		dewdrop:AddLine(
        		'text', BS"Enchanting",
	        	'func', function() CastSpellByName(BS"Enchanting")
                                   self:UpdateText(BS"Enchanting",BS:GetSpellIcon("Enchanting"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Engineering") then
       		dewdrop:AddLine(
        		'text', BS"Engineering",
	        	'func', function() CastSpellByName(BS"Engineering")
                                   self:UpdateText(BS"Engineering",BS:GetSpellIcon("Engineering"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"First Aid") then
       		dewdrop:AddLine(
        		'text', BS"First Aid",
	        	'func', function() CastSpellByName(BS"First Aid")
                                   self:UpdateText(BS"First Aid",BS:GetSpellIcon("First Aid"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Fishing") then
       		dewdrop:AddLine(
        		'text', BS"Fishing",
	        	'func', function() CastSpellByName(BS"Fishing")
                                   self:UpdateText(BS"Fishing",BS:GetSpellIcon("Fishing"))
                         end,
      			'arg1', self
                )
        end
        if (skillName == BS"Leatherworking") then
       		dewdrop:AddLine(
        		'text', BS"Leatherworking",
	        	'func', function() CastSpellByName(BS"Leatherworking")
                                   self:UpdateText(BS"Leatherworking",BS:GetSpellIcon("Leatherworking"))
                         end,
      			'arg1', self
                )
        end
        if (skillName == BS"Lockpicking") then
       		dewdrop:AddLine(
        		'text', BS"Lockpicking",
	        	'func', function() CastSpellByName(BS"Pick Lock")
                                   self:UpdateText(BS"Pick Lock",BS:GetSpellIcon("Pick Lock"))
                         end,
      			'arg1', self
                )
        end
        if (skillName == BS"Mining") then
       		dewdrop:AddLine(
        		'text', BS"Smelting",
	        	'func', function() CastSpellByName(BS"Smelting")
                                   self:UpdateText(BS"Smelting",BS:GetSpellIcon("Smelting"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Poisons") then
       		dewdrop:AddLine(
        		'text', BS"Poisons",
	        	'func', function() CastSpellByName(BS"Poisons")
                                   self:UpdateText(BS"Poisons",BS:GetSpellIcon("Poisons"))
                        end,
       			'arg1', self
                )
        end
        if (skillName == BS"Tailoring") then
       		dewdrop:AddLine(
        		'text', BS"Tailoring",
	        	'func', function() CastSpellByName(BS"Tailoring")
                                   self:UpdateText(BS"Tailoring",BS:GetSpellIcon("Tailoring"))
                        end,
       			'arg1', self
                )
        end
end

function SkillsPlusFu:OnMenuRequest(level, value)
	if level == 1 then
        	for _,category in self.skillList do
	        	if category.nonBooleanSkills > 0 then
        		        for _,skill in category.skills do
                                        self:IsProfession(skill.name)
                                end
                        end
                end
       		if (GetNumSkillLines() > 0) then dewdrop:AddLine() end
		dewdrop:AddLine(
			'text', L["MENU_SHOW_BOOLEAN_SKILLS"],
			'func', 'ToggleShowingBooleanSkills',
			'arg1', self,
			'checked', self:IsShowingBooleanSkills()
		)
	end
end

function SkillsPlusFu:OnDataUpdate()
	local skillIndex = 0
	local skillList = {}
	local headerIndex = 0
	
	local numSkills = GetNumSkillLines()
	
	for skillIndex=1, numSkills do
		local skillName, isHeader, isExpanded, skillRank, numTempPoints, skillModifier, skillMaxRank, isAbandonable, stepCost, rankCost, minLevel, skillCostType, skillDesc = GetSkillLineInfo(skillIndex)
		
		if isHeader then
			headerIndex = headerIndex + 1
			table.insert(skillList, {category=skillName, skills={}, nonBooleanSkills = 0})
		else
			if skillMaxRank > 1 then skillList[headerIndex].nonBooleanSkills = skillList[headerIndex].nonBooleanSkills + 1 end
			table.insert(skillList[headerIndex].skills, {name = skillName,  rank = skillRank,  maxrank = skillMaxRank, rankbonus = skillModifier})
		end
	end
	self.skillList = skillList
end

function SkillsPlusFu:UpdateText(newLabel,newIcon)
    if newIcon ~= nil then self:SetIcon(newIcon) end
    if newLabel ~= nil then
       self.labelName = newLabel
       self:UpdateToonInfo()
    end
    self:SetText(self.labelName)
	dewdrop:Close()
end

function SkillsPlusFu:OnTooltipUpdate()
	tablet:SetHint(L["TOOLTIP_HINT"])
	
	for _,category in self.skillList do
		if category.nonBooleanSkills > 0 or self:IsShowingBooleanSkills() then
			local cat = tablet:AddCategory(
				'id', category.category, 'columns', 2,
				'text', category.category,
				'func', 'ToggleCategory', 'arg1', self, 'arg2', category.category,
				'child_textR', 1, 'child_textG', 1, 'child_textB', 0,
				'showWithoutChildren', true,
				'checked', true, 'hasCheck', true, 'checkIcon', self.db.char.hidden[category.category] and "Interface\\Buttons\\UI-PlusButton-Up" or "Interface\\Buttons\\UI-MinusButton-Up"
			)
			if not self.db.char.hidden[category.category] then
				for _,skill in category.skills do
					if skill.maxrank > 1 then
						local rank = skill.rank
						if skill.rankbonus > 0  then
							rank = rank.."(+"..skill.rankbonus..")"
						end
						rank = rank.."/"..skill.maxrank
						local r,g,b = crayon:GetThresholdColor((skill.rank+(skill.rankbonus or 0)) / skill.maxrank)
						cat:AddLine(
							'text', skill.name, 'text2', rank, 
							'text2R', r, 'text2G', g, 'text2B', b)
					elseif self:IsShowingBooleanSkills() then
						cat:AddLine('text', skill.name)
					end
				end
			end
		end
	end
end

function SkillsPlusFu:OnClick()
        if self.labelName == L["FUBAR_LABEL"] then
            ToggleCharacter("SkillFrame")
        else
        	CastSpellByName(self.labelName)
        end

end