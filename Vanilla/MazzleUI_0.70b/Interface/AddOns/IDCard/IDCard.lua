IDCard = AceAddon:new{
	name = "IDCard",
	description	= "Adds Item Inventory icons next to item links and optionally shows ",
	releaseDate = "2006-01-17",
	version = "0.3",
	aceCompatible = "103",
	catagory = "inventory",
	author = "tard",

	button = IDCardIcon,
	updateFrame = IDCardFrame,

	cmd = AceChatCmd:new({"/idcard"},{}),
	db = AceDatabase:new("IDCardDB"),
	
	ItemColors = {[0] = "ff9d9d9d","ffffffff","ff1eff00","ff0070dd","ffa335ee","ffff8000","ffe6cc80"},

}

IDCard:RegisterForLoad()

function IDCard:Enable()
	self:Hook(ItemRefTooltip,"SetHyperlink")
end

function IDCard:SetHyperlink(itemID)
	if(not itemID) then return end

	local _,_,_,_,_,_,_,_,texture = GetItemInfo(itemID)
	self.id = itemID
	if(not texture) then
		debugprofilestart()
 		self.updateFrame:Show()
	end

	self.button:SetNormalTexture(texture)
	self.Hooks[ItemRefTooltip].SetHyperlink.orig(ItemRefTooltip,itemID)
end

-- Used to wait out the server lag when filling the ItemCache
-- Rarely runs more than twice before it gets shut off
function IDCard:OnUpdate()
	local _,_,_,_,_,_,_,_,texture = GetItemInfo(self.id)
 	if(texture) then
	 	self.updateFrame:Hide()
		self:debug(debugprofilestop())
		self.button:SetNormalTexture(texture)
	end
end

function IDCard:InsertLink()
	local name,item,quality = GetItemInfo(self.id)
	if not name then return end
	ChatFrameEditBox:Insert("|c"..self.ItemColors[quality].."|H"..item.."|h["..name.."]|h|r")
end