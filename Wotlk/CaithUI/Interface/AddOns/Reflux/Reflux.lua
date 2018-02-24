local emulated_default_addons = {
	
}
-- DeepCopy function.
local function DeepCopy(t, lookup_table)
	local copy = {}
	if type(t) ~= "table" then return t end
	for i,v in pairs(t) do
		if type(v) ~= "table" then
			copy[i] = v
		else
			lookup_table = lookup_table or {}
			lookup_table[t] = copy
			if lookup_table[v] then
				copy[i] = lookup_table[v] -- we already copied this table. reuse the copy.
			else
				copy[i] = DeepCopy(v,lookup_table) -- not yet copied. copy it.
			end
		end
	end
	return copy
end

local function loadAceLibs()
	if IsAddOnLoadOnDemand("Ace2") and not IsAddOnLoaded("Ace2") then
		print("Loading Ace2 since it is configured as LoadOnDemand and NOT loaded")
		LoadAddOn("Ace2")
	end
	if IsAddOnLoadOnDemand("Ace3") and not IsAddOnLoaded("Ace3") then	
		print("Loading Ace3, since it is configured as LoadOnDemand and NOT loaded")
		LoadAddOn("Ace3")
	end
	if IsAddOnLoadOnDemand("LibRock-1.0") and not IsAddOnLoaded("LibRock-1.0") then	
		print("Loading LibRock-1.0, since it is configured as LoadOnDemand and NOT loaded")
		LoadAddOn("LibRock-1.0")
	end
end
-- Setup ace profiles if we find any
local function setAceProfile(profile, addon)
	--loadAceLibs()
	local LibStub = _G["LibStub"]
	local AceLibrary = _G["AceLibrary"]
	local Rock = _G["Rock"]
	
	local ls_ace = false
	-- Ace DB 3 check
	if LibStub then
		local AceDB = LibStub:GetLibrary("AceDB-3.0",true)
		if AceDB and AceDB.db_registry then
			for db in pairs(AceDB.db_registry) do
				if not db.parent then --db.sv is a ref to the saved vairable name
					if addon then
						if addon and db.sv == addon then
							db:SetProfile(profile)
						end
					else
						db:SetProfile(profile)
					end
				end
			end
		end
	end
	-- Ace DB 2 check is thoery we shoul dbe able to check this via LibStub
	-- However someone may have some anceitn copy of Ace2 that was never upgraded to LibStub
	-- AceLibrary delegate to LibStub so its all good
	if AceLibrary and AceLibrary:HasInstance("AceDB-2.0") then
		local AceDB = AceLibrary("AceDB-2.0")
		if AceDB and AceDB.registry then
			for db in pairs(AceDB.registry) do
				if addon then
					if addon and db.db.name == addon then
						db:SetProfile(profile)
					end
				else 
					if db:IsActive() then
						db:SetProfile(profile)
					else
						db:ToggleActive(true)
						db:SetProfile(profile)
						db:ToggleActive(false)
					end
				end
			end
		end
	end	
	-- Rock loading
	if Rock and Rock:HasLibrary("LibRockDB-1.0") then
		local RockDB = Rock:GetLibrary("LibRockDB-1.0",false,false)
		if RockDB and RockDB.data then
			for db in pairs(RockDB.data) do
				if addon then
					if addon and db.dbName == addon then
						db:SetProfile(profile)
					end
				else
					db:SetProfile(profile)
				end
			end
		end
	end
end
-- Attempt to save all current profiles to a Define one
-- this cloning is to make it easier to transition to Reflux management
local function cloneProfiles(profile)
	loadAceLibs()
	local LibStub = _G["LibStub"]
	local AceLibrary = _G["AceLibrary"]
	local ls_ace = false
	-- Ace DB 3 check
	if LibStub then
		local AceDB = LibStub:GetLibrary("AceDB-3.0",true)
		if AceDB and AceDB.db_registry then
			for db in pairs(AceDB.db_registry) do
				if not db.parent then --db.sv is a ref to the saved vairable name
					local currentProfile = db:GetCurrentProfile()
					db:SetProfile(profile)
					db:CopyProfile(currentProfile,false)
					
				end
			end
		end
	end
	-- Ace DB 2 check is thoery we shoul dbe able to check this via LibStub
	-- However someone may have some anceitn copy of Ace2 that was never upgraded to LibStub
	-- AceLibrary delegate to LibStub so its all good
	if AceLibrary and AceLibrary:HasInstance("AceDB-2.0") then
		local AceDB = AceLibrary("AceDB-2.0")
		if AceDB and AceDB.registry then
			for db in pairs(AceDB.registry) do
				local function cp()
					local currentProfile = db:GetProfile()
					db:SetProfile(profile)
					db:CopyProfileFrom(currentProfile)
				end
				if db:IsActive() then
					pcall(cp)
				else
					db:ToggleActive(true)
					pcall(cp)
					db:ToggleActive(false)
				end
			end
		end
	end	
	-- Rock copy profile
	if Rock and Rock:HasLibrary("LibRockDB-1.0") then
		local RockDB = Rock:GetLibrary("LibRockDB-1.0",false,false)
		if RockDB and RockDB.data then
			for db in pairs(RockDB.data) do
				local currentProfile = db:GetProfile();
				db:SetProfile(profile)
				db:CopyProfile(currentProfile)
			end
		end
	end	
	

end
-- Copy ace profiles if we find any
local function copyAceProfile(profile)
	--loadAceLibs()
	local LibStub = _G["LibStub"]
	local AceLibrary = _G["AceLibrary"]
	local ls_ace = false
	-- Ace DB 3 check
	if LibStub then
		local AceDB = LibStub:GetLibrary("AceDB-3.0",true)
		if AceDB and AceDB.db_registry then
			for db in pairs(AceDB.db_registry) do
				if not db.parent then --db.sv is a ref to the saved vairable name
					db:CopyProfile(profile,false)
				end
			end
		end
	end
	-- Ace DB 2 check is thoery we shoul dbe able to check this via LibStub
	-- However someone may have some anceitn copy of Ace2 that was never upgraded to LibStub
	-- AceLibrary delegate to LibStub so its all good
	if AceLibrary and AceLibrary:HasInstance("AceDB-2.0") then
		local AceDB = AceLibrary("AceDB-2.0")
		if AceDB and AceDB.registry then
			for db in pairs(AceDB.registry) do
				local function cp()
					db:CopyProfileFrom(profile)
				end
				if db:IsActive() then
					pcall(cp)
				else
					db:ToggleActive(true)
					pcall(cp)
					db:ToggleActive(false)
				end
			end
		end
	end	
	-- Rock copy profile
	if Rock and Rock:HasLibrary("LibRockDB-1.0") then
		local RockDB = Rock:GetLibrary("LibRockDB-1.0",false,false)
		if RockDB and RockDB.data then
			for db in pairs(RockDB.data) do
				db:CopyProfile(profile)
			end
		end
	end	
end
-- Delete Ace profile
local function deleteAceProfile(profile)
	--loadAceLibs()
	local ls_ace = false
	local LibStub = _G["LibStub"]
	local AceLibrary = _G["AceLibrary"]
	-- Ace DB 3 check
	if LibStub then
		local AceDB = LibStub:GetLibrary("AceDB-3.0",true)
		if AceDB and AceDB.db_registry then
			for db in pairs(AceDB.db_registry) do
				if not db.parent then --db.sv is a ref to the saved vairable name
					db:DeleteProfile(profile,true)
				end
			end
		end
	end
	-- Ace DB 2 check is thoery we shoul dbe able to check this via LibStub
	-- However someone may have some anceitn copy of Ace2 that was never upgraded to LibStub
	-- AceLibrary delegate to LibStub so its all good
	if AceLibrary and AceLibrary:HasInstance("AceDB-2.0") then
		local AceDB = AceLibrary("AceDB-2.0")
		if AceDB and AceDB.registry then
			for db in pairs(AceDB.registry) do
				local function cp()
					db:DeleteProfile(profile,true)
				end
				pcall(cp)
			end
		end
	end	
	-- Rock delete profile
	if Rock and Rock:HasLibrary("LibRockDB-1.0") then
		local RockDB = Rock:GetLibrary("LibRockDB-1.0",false,false)
		if RockDB and RockDB.data then
			for db in pairs(RockDB.data) do
				db:RemoveProfile(profile)
			end
		end
	end
end
-- Show help
local function showHelp()
	print("/reflux switch [profile name]")
	print("This switches to a given profile. Emulated variables are only touched if you previously created a profile in reflux. This automatically Reloads the UI")
	print("/reflux addons [profile name]")
	print("This restores a previously saved set of addons. Due to technical reasons, it cant switch profiles at the same time. This automatically Reloads the UI")
	print("/reflux create [profile name]")
	print("This created a profile set.")
	print("/reflux add [saved variable]")
	print("This will add a given saved variable to the profile emulation. You will need to get this name from the .toc file")
	print("/reflux save <addons>")
	print("This saves the emulated profiles. Optionally if you can save addon state as well in the profile.")
	print("/reflux cleardb")
	print("This will clear out all Reflux saved information.")
	print("/reflux show")
	print("This will show you what the active profile is, and all emulated variables.")
	print("/reflux copy [profile to copy]")
	print("This will attempt to copy the provide profile to the current profile. This automatically Reloads the UI.")
	print("/reflux delete [profile]")
	print("This is delete a given profile. Please NOTE you can NOT delete the active profile.")
	print("/reflux switchexact addonSVName profile")
	print("This will reset JUST the profiled addonSVname to the given profile. This requires advance knowledge of the addon saved variable name.")
	print("/reflux snapshot [new profile name]")
	print("This will instruct Reflux to scan your profiles and copy them into the new profile name. This command should allow you to snapshot your current config to a new profile")
end
-- Store Addon state
local function storeAddonState(tbl)
	local index = 1
	local count = GetNumAddOns()
	while index < count do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(index)
		tbl[name]=enabled or 0
		index = index + 1
	end
end
local function getAddonSV(tbl)
	local index = 1
	local count = GetNumAddOns()
	while index < count do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(index)
		local variables = GetAddOnMetadata(name,"SavedVariables")
		tbl[name]=variables or ""
		index = index + 1
		if variables then
			print("Addon:"..name.." SV:"..variables)
		end
	end
end	
local function restoreAddonState(tbl)
	for k,v in pairs(tbl) do
		if v == 1 then
			EnableAddOn(k)
		else
			DisableAddOn(k)
		end
	end
	ReloadUI()
end

SlashCmdList["REFLUX"] = function (msg)
	local cmd, arg = strmatch(msg, "%s*([^%s]+)%s*(.*)");
	if cmd == nil or strlen(cmd) < 1 then
		showHelp()
		return
	end
	-- Create or use the existing saved varaibles.
	-- We are never used till after a player logs in.
	RefluxDB = RefluxDB or { profiles = { }, activeProfile=false, emulated={}, addons = {} }
	if cmd == "show" then
		if RefluxDB.activeProfile then
			print("Active Profile is "..RefluxDB.activeProfile)
		else
			print("There is no active profile")
		end
		for k,v in pairs(RefluxDB.profiles) do
			print(k.." is an available profile.")
		end
		if RefluxDB.emulated then
			if #RefluxDB.emulated == 0 then
				print("Nothing is being emulated")
			end
			for index,var in pairs(RefluxDB.emulated) do
				print(var.." is being emulated.")
			end
		end
		if RefluxDB.addons and RefluxDB.activeProfile and RefluxDB.addons[RefluxDB.activeProfile] then
			print("Addon state for the active profile")
			if not RefluxDB.addons[RefluxDB.activeProfile] then
				RefluxDB.addons[RefluxDB.activeProfile] = {}
			end
			for k,v in pairs(RefluxDB.addons[RefluxDB.activeProfile]) do
				local state = "off"
				if v == 1 then
					state = "on"
				end
				print(k..":"..state)
			end
		else
			print("Addon state is not being saved.")
		end
		local tbl = {}
		getAddonSV(tbl)
	elseif cmd == "switchexact" then
		local addon,profile = strmatch(arg, "%s*([^%s]+)%s*(.*)");
		if not addon or not profile then
			showHelp()
			return
		end
		setAceProfile(profile,addon)
		-- We dont switch emulated profiles Ace profiles only since we are NOT reloadiing the UI
		-- this is hacky
	elseif cmd == "switch" then
		if not arg or strlen(arg) < 1 then
			showHelp()
			return
		end
		-- Check RefluxDB to see if we have a createdProfile called xxx
		if RefluxDB.profiles[arg] then
			-- do a dep copy of all the saved off tables
			for k,v in pairs(RefluxDB.profiles[arg]) do
				if v and k then
					setglobal(k,DeepCopy(v))
				end
			end
		end
		setAceProfile(arg)
		RefluxDB.activeProfile=arg
		ReloadUI()
	elseif cmd == "addons" then
		if not arg or strlen(arg) < 1 then
			showHelp()
			return
		end
		if RefluxDB.addons[arg] then
			restoreAddonState(RefluxDB.addons[arg])
		end
	elseif cmd == "cleardb" then
		RefluxDB = { profiles = { }, activeProfile=false, emulated={},addons = {} }
		print("Reflux database cleared.")
	elseif cmd == "save" then
		if not RefluxDB.activeProfile then
			print("No profiles are active, please create or switch to one.")
			return
		end
		if RefluxDB.profiles[RefluxDB.activeProfile] then
			for index,var in ipairs(RefluxDB.emulated) do
				RefluxDB.profiles[RefluxDB.activeProfile][var]=getglobal(var)
				print("Saving "..var)
			end
		else
			print("No emulations saved.")
		end
		if arg == "addons" then
			RefluxDB.addons[RefluxDB.activeProfile] = {}
			storeAddonState(RefluxDB.addons[RefluxDB.activeProfile])
			print("Saving addons")
		end
	elseif cmd == "create" and strlen(arg) > 2 then
		setAceProfile(arg)
		RefluxDB.profiles[arg] = {}
		RefluxDB.activeProfile=arg
		for index,var in ipairs(RefluxDB.emulated) do
			setglobal(var,nil)
		end
		ReloadUI()
	elseif cmd == "snapshot" and strlen(arg) > 2 then
		cloneProfiles(arg)
		if not RefluxDB.activeProfile then
			RefluxDB.profiles[arg] = {}
			RefluxDB.activeProfile=arg
			RefluxDB.addons[arg] = {}
			for index,var in ipairs(RefluxDB.emulated) do
				setglobal(var,nil)
			end
		end
		if RefluxDB.profiles[arg] then
			RefluxDB.profiles[RefluxDB.activeProfile] = DeepCopy(RefluxDB.profiles[arg])
			RefluxDB.addons[RefluxDB.activeProfile] = DeepCopy(RefluxDB.addons[arg])
			for k,v in pairs(RefluxDB.profiles[RefluxDB.activeProfile]) do
				if v and k then
					setglobal(k,DeepCopy(v))
				end
			end
		end
		RefluxDB.activeProfile = arg
	--[[
		Clone command will create a new profile based off of existing profiles
		To accomplish this, we will go through each Ace2/3 profile figure out the curent profile name
		then we will create a new profile and ask each addond to copy their previous profile
		to the new profile.
	--]]	
		
	elseif cmd == "copy" and strlen(arg) > 2 then
		if not RefluxDB.activeProfile then
			print("You need to activate a profile before you can copy from another profile")
			return
		end
		copyAceProfile(arg)
		if RefluxDB.profiles[arg] then
			RefluxDB.profiles[RefluxDB.activeProfile] = DeepCopy(RefluxDB.profiles[arg])
			RefluxDB.addons[RefluxDB.activeProfile] = DeepCopy(RefluxDB.addons[arg])
			for k,v in pairs(RefluxDB.profiles[RefluxDB.activeProfile]) do
				if v and k then
					setglobal(k,DeepCopy(v))
				end
			end
		end
		ReloadUI()
	elseif cmd == "delete" and strlen(arg) > 2 then
		if RefluxDB.profiles[arg] then
			RefluxDB.profiles[arg] = nil
			RefluxDB.addons[arg] = nil
		end
		if arg == RefluxDB.activeProfile then
			RefluxDB.activeProfile = false
		end
		deleteAceProfile(arg)
	elseif cmd == "add" and strlen(arg) > 2 then
		if RefluxDB.emulated then
			if getglobal(arg) then
				tinsert(RefluxDB.emulated,arg)
				print(arg.." Added to emulation list.")
			else
				print(arg.." not found, please check the spelling it is case sensistive.")
			end
		end
	else
		showHelp()
	end
end

SLASH_REFLUX1 = "/reflux"