﻿--$Id: OneBag.lua 56918 2007-12-13 05:21:34Z next96 $
OneBag = OneCore:NewModule("OneBag", "AceEvent-2.0", "AceHook-2.1", "AceDebug-2.0", "AceConsole-2.0", "AceDB-2.0")
 
local L = AceLibrary("AceLocale-2.2"):new("OneBag") 

function OneBag:OnInitialize()

    self:RegisterDB("OneBagDB")
   
    if self.db.profile.locale then
        L:SetLocale(self.db.profile.locale)
    end
  
    self:RegisterDefaults('profile', OneCore:GetDefaults())
    
    local baseArgs = OneCore:GetFreshOptionsTable(self)

    local customArgs = {
        ["0"] = {
            name = L["Backpack"], type = 'toggle', order = 5,
            desc = L["Turns display of your backpack on and off."],
            get = function() return self.db.profile.show[0] end,
            set = function(v) 
                self.db.profile.show[0] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["1"] = {
            name = L["First Bag"], type = 'toggle', order = 6,
            desc = L["Turns display of your first bag on and off."],
            get = function() return self.db.profile.show[1] end,
            set = function(v) 
                self.db.profile.show[1] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["2"] = {
            name = L["Second Bag"], type = 'toggle', order = 7,
            desc = L["Turns display of your second bag on and off."],
            get = function() return self.db.profile.show[2] end,
            set = function(v) 
                self.db.profile.show[2] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["3"] = {
            name = L["Third Bag"], type = 'toggle', order = 8,
            desc = L["Turns display of your third bag on and off."],
            get = function() return self.db.profile.show[3] end,
            set = function(v) 
                self.db.profile.show[3] = v 
                self:OrganizeFrame(true)
            end,
        },
        ["4"] = {
            name = L["Fourth Bag"], type = 'toggle', order = 9,
            desc = L["Turns display of your fourth bag on and off."],
            get = function() return self.db.profile.show[4] end,
            set = function(v) 
                self.db.profile.show[4] = v 
                self:OrganizeFrame(true)
            end,
        },
    }
    
    OneCore:CopyTable(customArgs, baseArgs.args.show.args)
	
    OneCore:LoadOptionalCommands(baseArgs, self)
    
    OneCore:LoadLocaleCommands(baseArgs, self, L)
       
	self:RegisterChatCommand({"/ob", "/OneBag"}, baseArgs, string.upper(self.title))
	
	--self:SetDebugging(true)
	self.fBags			= {0, 1, 2, 3, 4}
    self.rBags          = {4, 3, 2, 1, 0}
	
	OneBagFrameName:SetText(UnitName("player").. L["'s Bags"])
	
	self.frame = OneBagFrame
	self.frame.handler = self
    
    self.frame.bagFrame = OBBagFram
	self.frame.bagFrame.handler = self
    
    self.frame.bags = {}
		
	self:RegisterDewdrop(baseArgs)
end

function OneBag:OnEnable()	
	self:SecureHook("IsBagOpen")
	self:Hook("ToggleBag", true)
	self:Hook("OpenBag", true)
	self:Hook("CloseBag", true)
	self:Hook("OpenBackpack", "OpenBag", true)
	self:Hook("CloseBackpack", "CloseBag", true)
	self:Hook("ToggleBackpack", "ToggleBag", true)
	
	local open = function() self:OpenBag() end
	local close = function() self:CloseBag() end
	
	self:RegisterEvent("AUCTION_HOUSE_SHOW", 	open)
	self:RegisterEvent("AUCTION_HOUSE_CLOSED", 	close)
	self:RegisterEvent("BANKFRAME_OPENED", 		open)
	self:RegisterEvent("BANKFRAME_CLOSED", 		close)
	self:RegisterEvent("MAIL_CLOSED", 			close)
	self:RegisterEvent("MERCHANT_SHOW", 		open)
	self:RegisterEvent("MERCHANT_CLOSED", 		close)
	self:RegisterEvent("TRADE_SHOW", 			open)
	self:RegisterEvent("TRADE_CLOSED", 			close)
	self:RegisterEvent("GUILDBANKFRAME_OPENED", 			open)
	self:RegisterEvent("GUILDBANKFRAME_CLOSED", 			close)	
    
    self:RegisterEvent(string.format("%s_Locale_Changed", tostring(self)), "UpdateLocale")
end

function OneBag:OnDisable()
	for id=1, 12 do
		local frame = getglobal("ContainerFrame"..id)
		frame:ClearAllPoints()
		frame:SetScale(1)
		frame:SetAlpha(1)        
	end
end

function OneBag:OnKeyRingButtonClick()
	if (CursorHasItem()) then
		PutKeyInKeyRing();
	else
		ToggleKeyRing();
	end
	local shownContainerID = IsBagOpen(KEYRING_CONTAINER)
	if ( shownContainerID ) then
		local frame = getglobal("ContainerFrame"..shownContainerID)
		frame:ClearAllPoints()
		frame:SetPoint("BOTTOMLEFT", this:GetParent():GetName() , "TOPLEFT", -9, 0)
		frame:SetScale(OneBag.db.profile.scale)
		frame:SetAlpha(OneBag.db.profile.alpha)
    else
        for id=1, 12 do
            local frame = getglobal("ContainerFrame"..id)
            frame:ClearAllPoints()
            frame:SetScale(1)
            frame:SetAlpha(1)        
        end
	end
end

--Hook responses
function OneBag:ToggleBag(bag)
	if bag and (bag < 0 or bag > 4) then
		return self.hooks.ToggleBag(bag)
	end
	
	if self.frame:IsVisible() then
		self.frame:Hide()
	else
		self.frame:Show()
	end
end

function OneBag:IsBagOpen(bag)
	self:Debug(L["Checking if bag %s is open"], bag)
	if bag < 0 or bag > 4 then
		return 
		-- Commented out when using SecureHook, by Ammo
		-- self.hooks.IsBagOpen(bag)
	end
	
	if self.frame:IsVisible() then
		return bag
	else
		return nil	
	end
end

function OneBag:OpenBag(bag)
	self:Debug(L["Opening bag %s"], bag)
	if bag and (bag < 0 or bag > 4) then
		return self.hooks.OpenBag(bag)
	end
	
	self.frame:Show()
end


function OneBag:CloseBag(bag)
	self:Debug(L["Closing bag %s"], bag)
	if bag and (bag < 0 or bag > 4) then
		return self.hooks.CloseBag(bag)
	end
	
	self.frame:Hide()
end

function OneBag:UpdateAllBags()
	for i = 0, 4 do
		self:UpdateBag(i)
	end
end

function OneBag:OnCustomShow() 
    if self.db.profile.point then
        local point = self.db.profile.point
        this:ClearAllPoints()
        this:SetPoint("TOPLEFT", point.parent, "BOTTOMLEFT", point.left, point.top)
    end
    
    self:RegisterEvent("BAG_UPDATE",			  "UpdateBag")
	self:RegisterEvent("BAG_UPDATE_COOLDOWN",	  "UpdateBag")
	self:RegisterEvent("UPDATE_INVENTORY_ALERTS", "UpdateAllBags")
end

function OneBag:OnCustomHide()
    local shownContainerID = IsBagOpen(KEYRING_CONTAINER)
    if ( shownContainerID ) then
        getglobal("ContainerFrame"..shownContainerID):Hide()
    end
    for id=1, 12 do
		local frame = getglobal("ContainerFrame"..id)
		frame:ClearAllPoints()
		frame:SetScale(1)
		frame:SetAlpha(1)        
	end
    
    self:UnregisterEvent("BAG_UPDATE")
    self:UnregisterEvent("BAG_UPDATE_COOLDOWN")
    self:UnregisterEvent("UPDATE_INVENTORY_ALERTS")
end

function OneBag:UpdateLocale(locale)
    L:SetLocale(locale)
    OneBagFrameConfigButton:SetText(L["Menu"])
    OneBagFrameName:SetText(UnitName("player").. L["'s Bags"])
    self:DoSlotCounts()
end