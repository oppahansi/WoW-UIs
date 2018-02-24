local FRL = FinderReminderLocals
local defaults = {
	hideInBG = false,
}
FinderReminder = AceAddon:new{
	name 			= "FinderReminder",
	description 	= FRL.desc,
	version			= "1.6",
	author			= "tard",
	email			= "tardmrr@gmail.com",
	releaseDate		= "03/24/06",
	aceCompatible	= "103",
	category		= "professions",
	defaults		= defaults,
	
	cmd 			= AceChatCmd:new({"/finderreminder","/fremind"},FRL.cmdOptions),
	db 				= AceDatabase:new("FinderReminderDB"),
	
}

FinderReminder:RegisterForLoad()

ace:RegisterFunctions(FinderReminder,{
	version = 1.0,
	
	Get = function(self, var)
		return self.db:get(self.profilePath, var)
   	end,

     TogC = function(self, v, c)
      	self.cmd:result(format(c, self.db:toggle(self.profilePath, v) and 
			"|cff00ff00"..ACEG_ON.."|r" or "|cffff0000"..ACEG_OFF.."|r"))
     end,
})


function FinderReminder:Enable()

	local f = CreateFrame("Frame",nil,UIParent)
	f:SetHeight(40)
	f:SetWidth(1)
	f:Hide()
	self.frame = f
	
	self.trackingbuttons = {}
	setmetatable(self.trackingbuttons,{__index = function(t,k)
		t[k] = self.buttonClass:new(self.frame)
		self:AnchorButtons()
		return t[k]
	end})
	
	--self:AnchorButtons()
	
	StaticPopupDialogs["FINDER_REMINDER"] = {
		text = FRL.reminder,
		button1 = CANCEL,
		timeout = 0,
		OnShow = function() self:OnShow() end,
		OnHide = function() self:OnHide() end,
		hideOnEsc = true,
	}
	
	self:RegisterEvent("PLAYER_AURAS_CHANGED")
end

function FinderReminder:Disable()
	StaticPopupDialogs["FINDER_REMINDER"] = nil
end
	
function FinderReminder:PLAYER_AURAS_CHANGED()
	self:UnregisterEvent("PLAYER_AURAS_CHANGED")
	
	self:RegisterEvent("PLAYER_ENTERING_WORLD","CheckTracking")
	self:RegisterEvent("PLAYER_ALIVE","CheckTracking")
	self:RegisterEvent("PLAYER_UNGHOST","CheckTracking")
	self:CheckTracking()
	
end

function FinderReminder:AnchorButtons()
	
	local prevb = self.frame
	for i,b in pairs(self.trackingbuttons) do
		if(prevb) then
			b:SetPoint("TOPLEFT",prevb,"TOPRIGHT",3,0)
		end
		prevb = b
	end
end

function FinderReminder:CheckTracking()
	if(not GetTrackingTexture() and not (self:IsInBG() and self:Get("hideInBG"))) then
		self:Remind()
	end
end

function FinderReminder:Remind()
	if(self.frame:IsVisible()) then return end
	self:BuildSpellList()
	local numSpells = table.getn(self.spellList)
	if(numSpells == 0) then return end
	
	local numButtons = table.getn(self.trackingbuttons)
	
	for i=1,(numSpells < numButtons and numButtons or numSpells) do
		self.trackingbuttons[i]:SetSpell(self.spellList[i])
	end
	StaticPopup_Show("FINDER_REMINDER")	
end

function FinderReminder:BuildSpellList()
	self.spellList = {}
	for i=1,MAX_SPELLS do
		local n = GetSpellName(i,"spell")
		if(not n) then break end
		
		if(FRL.trackingspells[n]) then
			table.insert(self.spellList,i)
		end
	end
end

function FinderReminder:OnShow()
	
	self.frame:SetParent(this)
	
	local w = this:GetWidth()
	local sw = table.getn(self.spellList)*33 + 30
	w = w < sw and sw or w
	this:SetWidth(w)
	this:SetHeight(100)
    
	
	self.frame:Show()
	self.frame:ClearAllPoints()
	self.frame:SetPoint("BOTTOMLEFT",(w - sw + 30)/2 + 1,27)
	self.frame:SetFrameLevel(this:GetFrameLevel() + 1)
    
	local b = getglobal(this:GetName().."Button1")
	b:ClearAllPoints()
	b:SetPoint("BOTTOM",0,15)
	self:Hook("StaticPopup_Resize")
end

function FinderReminder:OnHide()
	getglobal(this:GetName().."Button1"):ClearAllPoints()
	self.frame:Hide()
	GameTooltip:Hide()
end

function FinderReminder:ToggleBG()
	self:TogC("hideInBG",FRL.bghidemsg)
end

function FinderReminder:IsInBG()
	for i = 1, MAX_BATTLEFIELD_QUEUES do
		local status = GetBattlefieldStatus(i)
		if(status == "active") then
			return true
		end
	end
end

function FinderReminder:StaticPopup_Resize()
	self:Unhook("StaticPopup_Resize")
end
