--[[
	Magician
--]]

local OmniCC = _G['OmniCC']
assert(OmniCC, 'Could not find an instance of OmniCC')
assert(not OmniCC.OnFinishCooldown, 'Another finish effect is already loaded')


--[[ the shine object ]]--

local Shine = OmniCC:CreateClass('Frame')
local ANIMATION_TEMPLATE = 'OmniCCAnimationTemplate_Shine'
local TEXTURE = [[Interface\Cooldown\star4]]

function Shine:New(parent)
	local f = self:Bind(CreateFrame('Frame', nil, parent)) 
	f:SetAllPoints(parent)
	f:SetToplevel(true)
	f:Hide()
	
	f.ani = f:CreateAnimationGroup(nil, ANIMATION_TEMPLATE)
	f:SetScript('OnHide', f.OnHide)

	local icon = f:CreateTexture(nil, 'OVERLAY')
	icon:SetPoint('CENTER')
	icon:SetBlendMode('ADD')
	icon:SetAllPoints(f)
	icon:SetTexture(TEXTURE)

	return f
end

function Shine:Start()
	if not self.ani:IsPlaying() then
		self:Show()
		self.ani:Play()
	end
end

function Shine:OnHide()
	if self.ani:IsPlaying() then
		self.ani:Finish()
	end
	self:Hide()
end


--[[ omnicc hooks ]]--

do
	local shines = setmetatable({}, {__index = function(t, k)
		local f = Shine:New(k)
		t[k] = f
		return f
	end})

	OmniCC.OnFinishCooldown = function(self, timer)
		local parent = timer:GetParent()
		if parent:IsVisible() then
			shines[parent]:Start()
		end
	end
end