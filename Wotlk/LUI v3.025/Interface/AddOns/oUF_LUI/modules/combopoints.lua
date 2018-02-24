local GetComboPoints = GetComboPoints
local MAX_COMBO_POINTS = MAX_COMBO_POINTS

local Update = function(self, event, unit)
	local ComboPoints = self.ComboPoints
	local cp = GetComboPoints("player", "target")

	if(#ComboPoints == 0) then
		ComboPoints:SetText((cp > 0) and cp)
	else
		for i=1, MAX_COMBO_POINTS do
			if not UnitIsFriend("player", "target") then
				ComboPoints[i]:Show()
			
				if(i <= cp) then
					if CPShowAlways == true then
						ComboPoints[i]:SetValue(1)
					else
						ComboPoints[i]:Show()
					end
				else
					if CPShowAlways == true then
						ComboPoints[i]:SetValue(0)
					else
						ComboPoints[i]:Hide()
					end
				end
			else
				ComboPoints[i]:Hide()
			end
		end
	end
end

local Enable = function(self)
	if(self.ComboPoints) then
		self:RegisterEvent('UNIT_COMBO_POINTS', Update)

		return true
	end
end

local Disable = function(self)
	if(self.ComboPoints) then
		self:UnregisterEvent('UNIT_COMBO_POINTS', Update)
	end
end

oUF:AddElement("ComboPoints",Update,Enable,Disable)
