
function PowaAuras:VARIABLES_LOADED(...)
	PowaMisc.disabled = nil;

	-- Ensure PowaMisc gets any new values
	for k, v in pairs(PowaAuras.PowaMiscDefault) do
		if (PowaMisc[k]==nil) then PowaMisc[k] = v; end
	end
	-- Remove redundant settings
	for k in pairs(PowaMisc) do
		if (PowaAuras.PowaMiscDefault[k]==nil) then PowaMisc[k] = nil; end
	end

	if (self.Version~=PowaMisc.Version) then
		self:DisplayText(self.Colors.Purple.."<Power Auras Classic>|r "..self.Colors.Gold..self.Version.."|r - "..self.Text.welcome);
		PowaMisc.Version = self.Version;
	end
	
	PowaOptionsCpuFrame2_OnShow();

	if (not PowaMisc.Disabled) then
		self:RegisterEvents(PowaAuras_Frame);
	end

	if (TestPA==nil) then
		PowaState = {};
	end
	
	_, self.playerclass = UnitClass("player");

	self:LoadAuras();

	for i = 1, 5 do
		getglobal("PowaOptionsList"..i):SetText(PowaPlayerListe[i]);
	end
	for i = 1, 10 do
		getglobal("PowaOptionsList"..i+5):SetText(PowaGlobalListe[i]);
	end
	
	local texi = 1;
	while ( AuraTexture:SetTexture("Interface\\Addons\\PowerAuras\\Auras\\Aura"..texi..".tga") == 1 ) do 
		texi = texi + 1;
	end
	self.maxtextures = texi - 1;

	if (self.maxtextures<100) then
		self:DisplayText(self.Colors.Purple.."<Power Auras Classic>|r "..self.Colors.Gold..self.Version.."|r - "..self.Text.welcome);
		self:DisplayText(self.Colors.Red.."WARNING only "..self.maxtextures.." textures found! Try a /reload to fix this");
	end
	
	PowaBarAuraTextureSlider:SetMinMaxValues(1, self.maxtextures);
	PowaBarAuraTextureSliderHigh:SetText(self.maxtextures);
	
	self:FindAllChildren();
	self:CreateEffectLists();
	
	if (self.SetupDone) then
		self.Initialising = false;
	end
	self.VariablesLoaded = true;
end

function PowaAuras:Setup()
	PowaAuras_Tooltip:SetOwner(UIParent, "ANCHOR_NONE");

	local spellId = self.GCDSpells[PowaAuras.playerclass];
	if (not spellId) then return false; end
	self.GCDSpellName = GetSpellInfo(spellId);
	--self:ShowText("GCD spell = ", self.GCDSpellName, "(", spellId, ") CD=", GetSpellCooldown(self.GCDSpellName));

	-- Look-up spells by spellId for debuff types
	self.DebuffCatSpells = {}
	for k, v in pairs(self.DebuffTypeSpellIds) do
		local spellName = GetSpellInfo(k);
		if spellName then
			self.DebuffCatSpells[spellName] = v
		else
			--self:Debug("Unknown spellId: ", k)
		end
	end	
	
	if UnitIsDeadOrGhost("player") then
		self.WeAreAlive = false;
	end
	
	self.PvPFlagSet = UnitIsPVP("player");

	self.WeAreInRaid = (GetNumRaidMembers() > 0);
	self.WeAreInParty = (GetNumPartyMembers() > 0);

	self.WeAreMounted = (IsMounted()~=nil);
	self.WeAreInVehicle = (UnitInVehicle("player")~=nil);

	self.ActiveTalentGroup = GetActiveTalentGroup();
	
	self.Instance = self:GetInstanceType();
	
	self:GetStances();
	
	self:InitialiseAllAuras();
	
	self:MemorizeActions();
	
	self.DoCheck.All = true;
		
	if (self.VariablesLoaded) then
		self.Initialising = false;
	end
	self.SetupDone = true;

end

function PowaAuras:GetInstanceType()
	local _, instanceType = IsInInstance();
	if (instanceType=="pvp") then
		instanceType = "Bg";
	elseif (instanceType=="arena") then
		instanceType = "Arena";
	elseif (instanceType=="party" or instanceType=="raid") then
		instanceDifficulty = GetInstanceDifficulty();
		if (instanceType=="party") then
			if (instanceDifficulty==1) then
				instanceType = "5Man";
			else
				instanceType = "5ManHeroic";
			end
		else
			if (instanceDifficulty==1) then
				instanceType = "10Man";
			elseif (instanceDifficulty==2) then
				instanceType = "25Man";
			elseif (instanceDifficulty==3) then
				instanceType = "10ManHeroic";
			else
				instanceType = "25ManHeroic";
			end
		end
	else
		instanceType = "None";
	end
	--self:ShowText("Instance type set to "..instanceType);
	return instanceType;
end

function PowaAuras:PLAYER_ENTERING_WORLD(...)
	self:Setup();
end

function PowaAuras:GetStances()
	for iForm=1, GetNumShapeshiftForms() do
		self.PowaStance[iForm] = select(2,GetShapeshiftFormInfo(iForm));
	end
end
		
function PowaAuras:ACTIVE_TALENT_GROUP_CHANGED(...)
	self.ActiveTalentGroup = GetActiveTalentGroup();
	if (self.ModTest == false) then
		--self:ShowText("ACTIVE_TALENT_GROUP_CHANGED");
		self.PendingRescan = GetTime() + 1;
	end
end

function PowaAuras:PLAYER_TALENT_UPDATE(...)
	if (self.ModTest == false) then
		--self:ShowText("PLAYER_TALENT_UPDATE");
		self.PendingRescan = GetTime() + 1;
	end
end
		
function PowaAuras:PLAYER_UPDATE_RESTING(...)
	if (self.ModTest == false) then
		self.DoCheck.All = true;
	end
end

function PowaAuras:PARTY_MEMBERS_CHANGED(...)	  
	if (self.ModTest == false) then
		self.DoCheck.PartyBuffs = true;
		self.DoCheck.GroupOrSelfBuffs = true;
		self.DoCheck.PartyHealth = true;
		self.DoCheck.PartyMana = true;
	end
	self.WeAreInParty = (GetNumPartyMembers() > 0);
end
		
function PowaAuras:RAID_ROSTER_UPDATE(...)
	if (self.ModTest == false) then
		self.DoCheck.RaidBuffs = true;
		self.DoCheck.GroupOrSelfBuffs = true;
		self.DoCheck.RaidHealth = true;
		self.DoCheck.RaidMana = true;	
	end
	self.WeAreInRaid = (GetNumRaidMembers() > 0);
end
				
function PowaAuras:UNIT_HEALTH(...)
	local unit = ...;
	self:SetCheckResource("Health", unit);
end
		
function PowaAuras:UNIT_MAXHEALTH(...)
	local unit = ...;
	self:SetCheckResource("Health", unit);
end
		
function PowaAuras:UNIT_MANA(...)
	local unit = ...;
	self:SetCheckResource("Mana", unit);
end
		
function PowaAuras:UNIT_MAXMANA(...)
	local unit = ...;
	self:SetCheckResource("Mana", unit);
end

function PowaAuras:UNIT_RAGE(...)
	local unit = ...;
	self:SetCheckResource("RageEnergy", unit);
end

function PowaAuras:UNIT_ENERGY(...)
	local unit = ...;
	self:SetCheckResource("RageEnergy", unit);
end

function PowaAuras:UNIT_MAXENERGY(...)
	local unit = ...;
	self:SetCheckResource("RageEnergy", unit);
end

function PowaAuras:UNIT_RUNIC_POWER(...)
	local unit = ...;
	self:SetCheckResource("RageEnergy", unit);
end

function PowaAuras:SetCheckResource(resourceType, unitType)
	if (self.ModTest == false) then
		if (unitType == "target") then
			self.DoCheck["Target"..resourceType] = true;				
		elseif (unitType == "focus") then             
			self.DoCheck["Focus"..resourceType] = true;				
		elseif ("party" == string.sub(unitType, 1, 5)) then 
			self.DoCheck["Party"..resourceType] = true;  	
			self.DoCheck["NamedUnit"..resourceType] = true;			
		elseif ("raid" == string.sub(unitType, 1, 4)) then              
			self.DoCheck["Raid"..resourceType] = true;		
			self.DoCheck["NamedUnit"..resourceType] = true;		
		elseif (unitType == "pet") then
			self.DoCheck["NamedUnit"..resourceType] = true;
		elseif (unitType == "player") then
			self.DoCheck[resourceType] = true;	
		end
	end
end

function PowaAuras:UNIT_MAXRUNIC_POWER(...)
	local unit = ...;
	self:SetCheckResource("RageEnergy", unit);
end

function PowaAuras:SpellcastEvent(unit)
	if (self.ModTest == false) then
		--- spell alert handling
		if unit and not UnitIsDead(unit) then
			if UnitIsUnit(unit, "player") then
				self.DoCheck.PlayerSpells = true;
			elseif (UnitCanAttack(unit, "player")) then
				if UnitIsUnit(unit, "target") then
					self.DoCheck.TargetSpells = true;
				end
				if UnitIsUnit(unit, "focus") then
					self.DoCheck.FocusSpells = true;
				end
				self.DoCheck.Spells = true; --- party/raidscan for casting units in this case
			end
		end
	end
end

function PowaAuras:UNIT_SPELLCAST_SUCCEEDED(...)	  
	if (self.ModTest == false) then
		local unit, spell = ...;
		--self:ShowText("UNIT_SPELLCAST_SUCCEEDED ",unit, " ", spell);
		--- druid shapeshift special case
		if (unit == "player") then
			if ( (spell == GetSpellInfo(768)) or (spell == GetSpellInfo(5487)) or (spell == GetSpellInfo(9634)) ) then
				self.DoCheck.Mana = true;
				self.DoCheck.RageEnergy = true;
			end			
			for _, auraId in pairs(self.AurasByType.OwnSpells) do	
				--self:ShowText("Pending set for OwnSpells ", auraId);
				self.DoCheck.OwnSpells = true;
				self.Pending[auraId] = GetTime() + 0.5; -- Allow 0.5 sec for client to update or time may be wrong
			end
		else
			PowaAuras:SpellcastEvent(unit);
		end
	end
end

function PowaAuras:UNIT_SPELLCAST_START(...)
	local unit = ...;
	PowaAuras:SpellcastEvent(unit);
end

function PowaAuras:UNIT_SPELLCAST_CHANNEL_START(...)
	local unit = ...;
	PowaAuras:SpellcastEvent(unit);
end

function PowaAuras:UNIT_SPELLCAST_DELAYED(...)
	local unit = ...;
	PowaAuras:SpellcastEvent(unit);
end

function PowaAuras:UNIT_SPELLCAST_CHANNEL_UPDATE(...)
	local unit = ...;
	PowaAuras:SpellcastEvent(unit);
end

function PowaAuras:UNIT_SPELLCAST_STOP(...)
	local unit = ...;
	PowaAuras:SpellcastEvent(unit);
end

function PowaAuras:UNIT_SPELLCAST_FAILED(...)
	local unit = ...;
	PowaAuras:SpellcastEvent(unit);
end

function PowaAuras:UNIT_SPELLCAST_INTERRUPTED(...)
	local unit = ...;
	PowaAuras:SpellcastEvent(unit);
end

function PowaAuras:UNIT_SPELLCAST_CHANNEL_STOP(...)
	local unit = ...;
	PowaAuras:SpellcastEvent(unit);
end


function PowaAuras:RUNE_POWER_UPDATE(...)
	if (self.ModTest == false) then
		--self:ShowText("PLAYER_TOTEM_UPDATE slot=", slot);
		self.DoCheck.Runes = true;
	end
end

function PowaAuras:RUNE_TYPE_UPDATE(...)
	local runeId = ...;
	if (self.ModTest == false) then
		--self:ShowText("PLAYER_TOTEM_UPDATE slot=", slot);
		self.DoCheck.Runes = true;
	end
end
	
function PowaAuras:PLAYER_FOCUS_CHANGED(...)	  
	if (self.ModTest == false) then
		self.DoCheck.FocusBuffs = true;
		self.DoCheck.FocusHealth = true;
		self.DoCheck.FocusMana = true;
		self.DoCheck.FocusRageEnergy = true;
		self.DoCheck.FocusSpells = true;
		self.DoCheck.StealableFocusSpells = true;
		self.DoCheck.PurgeableFocusSpells = true;
	end
end

function PowaAuras:BuffsChanged(unit)
	if (not self.ModTest) then
		--self:ShowText("==>BuffsChanged ", unit, " uip=", UnitIsPlayer(unit));
		--if (unit ~= "player" and UnitIsPlayer(unit)) then
		--	unit = "player";
		--	self:ShowText("!!Set to Player!!");
		--end
		self.ChangedUnits.Buffs[unit] = true;
		--self:ShowText("ChangedUnits empty=", self:TableEmpty(self.ChangedUnits.Buffs));
		if (unit == "target") then
			self.DoCheck.TargetBuffs = true;
			self.DoCheck.StealableTargetSpells = true;
			self.DoCheck.PurgeableTargetSpells = true;
		elseif ("party" == string.sub(unit, 1, 5)) then 
			self.DoCheck.PartyBuffs = true;
			self.DoCheck.GroupOrSelfBuffs = true;
		elseif (unit == "focus") then
			self.DoCheck.FocusBuffs = true;
			self.DoCheck.StealableFocusSpells = true;
			self.DoCheck.PurgeableFocusSpells = true;
		elseif (string.sub(unit, 1, 4) == "raid") then
			self.DoCheck.RaidBuffs = true;       
			self.DoCheck.GroupOrSelfBuffs = true;
		elseif (unit == "player") then
			self.DoCheck.Buffs = true;
			self.DoCheck.GroupOrSelfBuffs = true;
		else
			self.DoCheck.UnitBuffs = true;
			self.DoCheck.StealableSpells = true;
			self.DoCheck.PurgeableSpells = true;
		end
	end
end

function PowaAuras:UNIT_AURA(...)
	local unit = select(1, ...);
	--self:ShowText("UNIT_AURA ", unit);
	self:BuffsChanged(unit);
end

function PowaAuras:UNIT_AURASTATE(...)
	local unit = select(1, ...);
	--self:ShowText("UNIT_AURASTATE ", unit);
	self:BuffsChanged(unit);
end

function PowaAuras:PLAYER_DEAD(...)
	if (self.ModTest == false) then
		self.DoCheck.All = true;
	end
	self.WeAreMounted = false;
	self.WeAreInVehicle = false;
	self.WeAreAlive = false;
end
	
function PowaAuras:PLAYER_ALIVE(...)
	if not UnitIsDeadOrGhost("player") then
		self.WeAreAlive = true;
		if (self.ModTest == false) then
			self.DoCheck.All = true;
		end
	end
end
	
function PowaAuras:PLAYER_UNGHOST(...)
	if not UnitIsDeadOrGhost("player") then
		self.WeAreAlive = true;
		if (self.ModTest == false) then
			self.DoCheck.All = true;
		end
	end
end
 
function PowaAuras:PLAYER_TARGET_CHANGED(...)
	if (self.ModTest == false) then
		--self:ShowText("PLAYER_TARGET_CHANGED");
		self.DoCheck.TargetBuffs = true;
		self.DoCheck.TargetHealth = true;
		self.DoCheck.TargetMana = true;
		self.DoCheck.TargetRageEnergy = true;
		self.ResetTargetTimers = true;
		self.DoCheck.Actions = true;
		self.DoCheck.TargetSpells = true;
		self.DoCheck.Combo = true;
		self.DoCheck.StealableTargetSpells = true;
		self.DoCheck.PurgeableTargetSpells = true;
	end
end
	 
function PowaAuras:PLAYER_REGEN_DISABLED(...)
	self.WeAreInCombat = true;
	if (self.ModTest == false) then
		--self:ShowText("PLAYER_REGEN_DISABLED");
		self.DoCheck.All = true;
	end	   
end
	   
function PowaAuras:PLAYER_REGEN_ENABLED(...)
	self.WeAreInCombat = false;
	if (self.ModTest == false) then
		--self:ShowText("PLAYER_REGEN_ENABLED");
		self.DoCheck.All = true;
	end
end   


function PowaAuras:ZONE_CHANGED_NEW_AREA()
	local instanceType = self:GetInstanceType();
	if (self.Instance == instanceType) then return; end
	self.Instance = instanceType;
	if (self.ModTest == false) then
		--self:ShowText("ZONE_CHANGED_NEW_AREA ", self.InInstance, " - ", self.InstanceType);
		self.DoCheck.All = true;
	end
end

function PowaAuras:UNIT_COMBO_POINTS(...)
	local unit = ...;
	if (unit ~= "player") then return; end
	if (self.ModTest == false) then
		--self:ShowText("UNIT_COMBO_POINTS");
		self.DoCheck.Combo = true;
	end
end

function PowaAuras:UNIT_PET(...)
	local unit = ...;
	if (unit ~= "player") then return; end
	if (self.ModTest == false) then
		--self:ShowText("UNIT_PET");
		self.DoCheck.Pet = true;
	end
end

function PowaAuras:PLAYER_TOTEM_UPDATE(...)
	local slot = ...;
	if (self.ModTest == false) then
		--self:ShowText("PLAYER_TOTEM_UPDATE slot=", slot, " class=", self.playerclass);
		if (self.playerclass=="SHAMAN") then
			self.TotemSlots[slot] = true;
			self.DoCheck.Totems = true;
		elseif (self.playerclass=="DEATHKNIGHT" and not self.MasterOfGhouls) then
			--self:ShowText("Ghoul (temp version)");
			self.DoCheck.Pet = true;
		end
	end
end

function PowaAuras:VehicleCheck(unit, entered)
	if unit ~= "player" then return; end
	if (self.ModTest == false) then
		self.DoCheck.All = true;
	end	
	self.WeAreInVehicle = entered;
end
		
function PowaAuras:UNIT_ENTERED_VEHICLE(...)
	local unit = ...;
	self:VehicleCheck(unit, true)
end

function PowaAuras:UNIT_EXITED_VEHICLE(...)
	local unit = ...;
	self:VehicleCheck(unit, false)
end
	
function PowaAuras:UNIT_FACTION(...) --- GetPVPTimer() returns the time until unflag in ms
	local unit = ...;
	--self:ShowText("UNIT_FACTION unit = ",unit);
	if (unit == "player") then
		local flag = UnitIsPVP("player");
		if (flag ~= self.PvPFlagSet) then
			self.PvPFlagSet = flag;
			--self:ShowText("UNIT_FACTION Player PvP = ",flag);
			if (self.ModTest == false) then
				self.DoCheck.All = true;
			end
		end
		return;
	end
	if (self.ModTest == false) then
		if (unit == "target") then
			self.DoCheck.TargetPvP = true;
		end

		for i=1,GetNumPartyMembers() do
			if (unit == "party"..i) then
				self.DoCheck.PartyPvP = true;
				break;
			end
		end
		for i=1, GetNumRaidMembers() do
			if (unit == "raid"..i) then
				self.DoCheck.RaidPvP = true;
				break;
			end
		end
	end
end
	
	
function PowaAuras:COMBAT_LOG_EVENT_UNFILTERED(...)
	local timestamp,event,sourceGUID,sourceName,sourceFlags,destGUID,destName,destFlags, spellId, spellName, _, spellType = ...;
	--self:ShowText("COMBAT_LOG_EVENT_UNFILTERED ", event);
	if (not self.ModTest) then
		if (destGUID and destGUID==UnitGUID("player") and spellName) then
			if (event == "ENVIRONMENTAL_DAMAGE") then
				--self:ShowText("ENVIRONMENTAL_DAMAGE type=", spellId, " size=", spellName);					
				if  (spellId ~= "FALLING") then
					self.AoeAuraAdded[0] = spellId;
					self.DoCheck.Aoe = true;
				end
			elseif ((event=="SPELL_PERIODIC_DAMAGE"
				  or event=="SPELL_DAMAGE"
				  or ((event=="SPELL_AURA_APPLIED" or event=="SPELL_AURA_APPLIED_DOSE") and spellType=="DEBUFF"))) then
				--self:ShowText("SPELL_PERIODIC_DAMAGE ", spellId, " ", spellName);
					self.AoeAuraAdded[spellId] = spellName;
					if (not self.AoeAuraTexture[spellName]) then
						self.AoeAuraTexture[spellId] = select(3, GetSpellInfo(spellId));
					end
					self.DoCheck.Aoe = true;
			end
		end
	end
end

function PowaAuras:ACTIONBAR_SLOT_CHANGED(...)
	local actionIndex = ...;
	self:MemorizeActions(actionIndex);
end
	
function PowaAuras:UPDATE_SHAPESHIFT_FORMS(...)
	self:GetStances();
	if (self.ModTest) then return; end
	
	self.DoCheck.Stance = true;
end
	
function PowaAuras:ACTIONBAR_UPDATE_COOLDOWN(...)
	if (self.ModTest == false) then
		--self:ShowText("ACTIONBAR_UPDATE_COOLDOWN");
		self.DoCheck.Actions = true;
		self.DoCheck.Stance = true;
	end	
end
		
function PowaAuras:ACTIONBAR_UPDATE_USABLE(...)
	if (self.ModTest == false) then
		--self:ShowText("ACTIONBAR_UPDATE_USABLE");
		self.DoCheck.Actions = true;
		self.DoCheck.Stance = true;
	end
end
	
function PowaAuras:SPELL_UPDATE_COOLDOWN(...)
	if (self.ModTest == false) then
		--self:ShowText("SPELL_UPDATE_COOLDOWN");
		self.DoCheck.OwnSpells = true;
	end	
end
		
function PowaAuras:UPDATE_SHAPESHIFT_FORM(...)
	if (self.ModTest == false) then
		--self:ShowText("UPDATE_SHAPESHIFT_FORM");
		self.DoCheck.Stance = true;
		self.DoCheck.Actions = true;
	end  
end

function PowaAuras:BAG_UPDATE_COOLDOWN(...)
	if (self.ModTest == false) then
		--self:ShowText("BAG_UPDATE_COOLDOWN");
	end  
end

function PowaAuras:UNIT_INVENTORY_CHANGED(...)
	if (self.ModTest == false) then
		local unit = ...;
		--self:ShowText("UNIT_INVENTORY_CHANGED ", unit);
		if (unit=="player") then
			for _, auraId in pairs(self.AurasByType.Enchants) do
				--self:ShowText("Pending set for Enchants ", auraId);
				self.Pending[auraId] = GetTime() + 0.25; -- Allow time for client to update or timer will be wrong
			end
		end			
	end  
end

function PowaAuras:UNIT_THREAT_SITUATION_UPDATE(...)
	local unit = ...;
	if (self.ModTest == false) then
		--self:ShowText("UNIT_THREAT_SITUATION_UPDATE ", unit);
		if unit == "player" then
			self.DoCheck.Aggro = true;
			return;
		end

		for i=1,GetNumPartyMembers() do
			if unit == "party"..i then
				self.DoCheck.PartyAggro = true;
				break;
			end
		end
		for i=1, GetNumRaidMembers() do
			if unit == "raid"..i then
				self.DoCheck.RaidAggro = true;
				break;
			end
		end
	end
end