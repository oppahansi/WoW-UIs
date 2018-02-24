-----------------------------------------------------------------------------

local AloftAlpha = Aloft:NewModule("Alpha", "AceEvent-2.0", "AceHook-2.1")
AloftAlpha.db = Aloft:AcquireDBNamespace("Alpha")
Aloft:RegisterDefaults("Alpha", "profile", {
	targetEnable		= false,
	targetAlpha			= 1.0,
	defaultEnable		= false,
	defaultAlpha		= 1.0,
	nonTargetEnable		= false,
	nonTargetAlpha		= 0.80,
})

-----------------------------------------------------------------------------

local profile
local updateMethodName
local targetNameplate
local targetExists

local function GetUpdateMethodName()
	if profile.targetEnable then
		if profile.defaultEnable then
			if profile.nonTargetEnable then
				return "UpdateAllEnabled"
			else
				return "UpdateAllButNon"
			end
		elseif profile.nonTargetEnable then
			return "UpdateAllButDefault"
		else
			return "UpdateTargetOnly"
		end
	elseif profile.defaultEnable then
		if profile.nonTargetEnable then
			return "UpdateAllButTarget"
		else
			return "UpdateDefaultOnly"
		end
	elseif profile.nonTargetEnable then
		return "UpdateNonOnly"
	end
	return nil
end


function AloftAlpha:RegisterEvents()
	self:UnregisterAllEvents()
	self:UnhookAll()

	updateMethodName = GetUpdateMethodName()
	
	if updateMethodName then
		self:RegisterEvent("Aloft:SetupFrame", "SetupFrame")

		-- Since Aloft requires alpha information to determine target nameplates, 
		-- and this module adjusts them, this module then needs to take over
		-- responsibility for determining the target nameplate
		self:RegisterEvent("PLAYER_TARGET_CHANGED")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:Hook(Aloft, "GetTargetNameplate", "GetTargetNameplate")
	
		for aloftData in Aloft:IterateNameplates() do
			self:HookScript(aloftData.nameplateFrame, "OnUpdate", updateMethodName)
		end
	end
end

function AloftAlpha:EnableChange()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftAlpha:OnInitialize()
	profile = self.db.profile
end

function AloftAlpha:OnEnable()
	self:RegisterEvents()
end

function AloftAlpha:OnDisable()
end

-----------------------------------------------------------------------------

function AloftAlpha:GetTargetNameplate(this)
	-- Since Aloft requires alpha information to determine target nameplates, 
	-- and this module adjusts them, this module then needs to take over
	-- responsibility for determining the target nameplate
	return targetNameplate
end

function AloftAlpha:PLAYER_TARGET_CHANGED()
	targetNameplate = nil
	targetExists = UnitExists("target")
end

-----------------------------------------------------------------------------

function AloftAlpha:UpdateAllEnabled(this)
	if this:GetAlpha() ~= 1 then		--non-target, target selected
		this:SetAlpha(profile.nonTargetAlpha)
	elseif targetExists then	--target, target selected
		targetNameplate = this.aloftData
		this:SetAlpha(profile.targetAlpha)
	else					--all units, no target selected
		this:SetAlpha(profile.defaultAlpha)
	end
	self.hooks[this]["OnUpdate"](this)
end

function AloftAlpha:UpdateAllButNon(this)
	if not targetExists then --default
		this:SetAlpha(profile.defaultAlpha)
	elseif this:GetAlpha() == 1 then --target
		targetNameplate = this.aloftData
		this:SetAlpha(profile.targetAlpha)
	end
	self.hooks[this]["OnUpdate"](this)
end

function AloftAlpha:UpdateAllButDefault(this)
	if this:GetAlpha() ~= 1 then
		this:SetAlpha(profile.nonTargetAlpha)
	elseif targetExists then
		targetNameplate = this.aloftData
		this:SetAlpha(profile.targetAlpha)
	end
	self.hooks[this]["OnUpdate"](this)
end

function AloftAlpha:UpdateTargetOnly(this)
	if targetExists and this:GetAlpha() == 1 then
		targetNameplate = this.aloftData
		this:SetAlpha(profile.targetAlpha)
	end
	self.hooks[this]["OnUpdate"](this)
end

function AloftAlpha:UpdateAllButTarget(this)
	if not targetExists then
		this:SetAlpha(profile.defaultAlpha)
	elseif this:GetAlpha() ~= 1 then
		this:SetAlpha(profile.nonTargetAlpha)
	else
		targetNameplate = this.aloftData
	end
	self.hooks[this]["OnUpdate"](this)
end

function AloftAlpha:UpdateDefaultOnly(this)
	if not targetExists then
		this:SetAlpha(profile.defaultAlpha)
	elseif this:GetAlpha() == 1 then
		targetNameplate = this.aloftData
	end
	self.hooks[this]["OnUpdate"](this)
end

function AloftAlpha:UpdateNonOnly(this)
	if this:GetAlpha() ~= 1 then
		this:SetAlpha(profile.nonTargetAlpha)
	elseif targetExists then
		targetNameplate = this.aloftData
	end
	self.hooks[this]["OnUpdate"](this)
end

-----------------------------------------------------------------------------

function AloftAlpha:SetupFrame(aloftData)
	self:HookScript(aloftData.nameplateFrame, "OnUpdate", updateMethodName)
end

function AloftAlpha:OnNameplateHide(aloftData)
	if targetNameplate == aloftData then
		targetNameplate = nil
	end
end

-----------------------------------------------------------------------------
