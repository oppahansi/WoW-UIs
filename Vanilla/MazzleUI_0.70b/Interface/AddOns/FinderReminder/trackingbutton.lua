
local button = {}
-- FinderReminderTrackingButton = button
FinderReminder.buttonClass = button
-- button.__index = button


function button:new(parent)
	
	local f = CreateFrame("CheckButton",nil,parent)

	f:SetWidth(30)
	f:SetHeight(30)
	
	local t = f:CreateTexture(nil,"BORDER")
	t:SetAllPoints(f)
	f.icon = t
	
	t = f:CreateTexture(nil,"ARTWORK")
	t:SetWidth(51)
	t:SetHeight(52)
	t:SetTexture("Interface\\Buttons\\UI-Quickslot2")
	t:SetPoint("CENTER",0,0)
	f:SetNormalTexture(t)
	
	f:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")
	
	t = f:CreateTexture(nil,"HIGHLIGHT")
	t:SetAllPoints(f)
	t:SetTexture("Interface\\Buttons\\ButtonHilight-Square")
	t:SetBlendMode("ADD")
		
	local index = getmetatable(f).__index
	setmetatable(f,{__index = function(t,k)
		return self[k] or index(t,k)
	end})
	
	f:SetScript("OnEnter",function()f:OnEnter()end)
	f:SetScript("OnLeave",function()f:OnLeave()end)
	f:SetScript("OnClick",function()f:OnClick()end)

	return f
end


function button:OnEnter()
	if(not self.id) then return end
	local t = GameTooltip
	t:SetOwner(self,"ANCHOR_RIGHT")
	t:SetSpell(self.id,"spell")
	t:Show()
end

function button:OnLeave()
	if(GameTooltip:IsOwned(self)) then
		GameTooltip:Hide()
	end
end

function button:SetSpell(i)
	if(i) then
		self.id = i
		self.icon:SetTexture(GetSpellTexture(i,"spell"))
		self:Show()
	else
		self:Hide()
	end
end

function button:OnClick()
	if(not self.id) then return end
	CastSpell(self.id,"spell")
	self:GetParent():GetParent():Hide()
end