-----------------------------------------------------------------------------

local banzai = AceLibrary("LibBanzai-2.0")

-----------------------------------------------------------------------------

local AloftBanzai = Aloft:NewModule("Banzai", "AceEvent-2.0", "AceConsole-2.0", "AceHook-2.1")
AloftBanzai.db = Aloft:AcquireDBNamespace("banzai")
Aloft:RegisterDefaults("banzai", "profile", {
	enable			= false,
	color			= { 1, 0, 1, 1 }
})

-----------------------------------------------------------------------------

local profile

-----------------------------------------------------------------------------

function AloftBanzai:SetAggroColor(healthBar, r, g, b, a)
	local aloftData = healthBar.aloftData
	aloftData.banzaiR, aloftData.banzaiG, aloftData.banzaiB, aloftData.banzaiA = r, g, b, a
	self.hooks[healthBar].SetStatusBarColor(healthBar, unpack(profile.color))
end

function AloftBanzai:HookHealthBar(aloftData)
	local healthBar = aloftData.healthBar
	if not self:IsHooked(healthBar, "SetStatusBarColor") then
		aloftData.banzaiR, aloftData.banzaiG, aloftData.banzaiB, aloftData.banzaiA = healthBar:GetStatusBarColor()
		healthBar:SetStatusBarColor(unpack(profile.color))
		self:Hook(healthBar, "SetStatusBarColor", "SetAggroColor", true)
	end
end

function AloftBanzai:UnhookHealthBar(aloftData)
	if self:IsHooked(aloftData.healthBar, "SetStatusBarColor") then 
		self:Unhook(aloftData.healthBar, "SetStatusBarColor") 
		aloftData.healthBar:SetStatusBarColor(aloftData.banzaiR, aloftData.banzaiG, aloftData.banzaiB, aloftData.banzaiA)
	end 
end

function AloftBanzai:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		if profile.enable then
			self:OnNameplateShow(aloftData)
		else
			self:UnhookHealthBar(aloftData)
		end
	end	
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

local isRegisteredWithBanzai = false

local function Banzai20Callback(aggroGained, unitName)
	if aggroGained == 1 then
		AloftBanzai:OnUnitGainedAggro(unitName)
	else
		AloftBanzai:OnUnitLostAggro(unitName)
	end
end

function AloftBanzai:RegisterEvents()
	if profile.enable and Aloft:IsDataAvailable("unitid") then
		if not isRegisteredWithBanzai then
			isRegisteredWithBanzai = true
			banzai:RegisterCallback(Banzai20Callback)
		end
		self:RegisterEvent("Aloft:OnNameplateShow", "OnNameplateShow")
		self:RegisterEvent("Aloft:OnNameplateHide", "OnNameplateHide")
		self:RegisterEvent("Aloft:OnUnitidChanged", "OnUnitidChanged")
	else
		if isRegisteredWithBanzai then
			isRegisteredWithBanzai = false
			banzai:UnregisterCallback(Banzai20Callback)
		end
	
		self:CancelEvent("Aloft:OnNameplateShow")
		self:CancelEvent("Aloft:OnNameplateHide")
		self:CancelEvent("Aloft:OnUnitidChanged")
	end
end

function AloftBanzai:OnInitialize()
	profile = self.db.profile
end

function AloftBanzai:OnEnable()
	self:UpdateAll()
end

function AloftBanzai:OnDisable()
	self:UnregisterAllEvents()
end

function AloftBanzai:RequiresData()
	self:RegisterEvents()

	if profile.enable and Aloft:IsDataAvailable("unitid") then
		return "unitid"
	end
end

function AloftBanzai:OnNameplateShow(aloftData)
	if aloftData.unitid and banzai:GetUnitAggroByUnitId(aloftData.unitid)  then
		self:HookHealthBar(aloftData)
	end
end

function AloftBanzai:OnNameplateHide(aloftData)
	self:UnhookHealthBar(aloftData)
end

function AloftBanzai:OnUnitidChanged(aloftData)
	self:UnhookHealthBar(aloftData)
	self:OnNameplateShow(aloftData)
end

function AloftBanzai:OnUnitLostAggro(name)
	local aloftData = Aloft:GetNameplate(name)
	if aloftData then
		self:UnhookHealthBar(aloftData)
	end
end

function AloftBanzai:OnUnitGainedAggro(name)
	local aloftData = Aloft:GetUnitNameplate(name)
	if aloftData then
		self:OnNameplateShow(aloftData)
	end
end

-----------------------------------------------------------------------------
