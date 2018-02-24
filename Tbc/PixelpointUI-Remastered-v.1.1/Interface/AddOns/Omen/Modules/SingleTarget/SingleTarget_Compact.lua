do return end -- not ready for this yet

local SingleTargetCompact = Omen:NewModule("SingleTarget_Compact", Omen:GetModule("SingleTarget"))
local bars
local table_sort = _G.table.sort

local function sortBars(a, b)
	if a.value > b.value then
		return true
	end
	return false
end

function SingleTargetCompact:OnInitialize()
	self:Super("OnInitialize")
	self.icon = select(3, GetSpellInfo(30451))
end

function SingleTargetCompact:ArrangeBars()
	bars = bars or self.bars
	
	table_sort(bars, sortBars)
	local maxThreat = nil
	for i = 1, 1 do		-- A raid of 40 hunters!
		local bar = bars[i]
		if not bar then break end
		maxThreat = maxThreat or bar.value
		if bar.value > 0 then
			if not self:AddBar(bar) then break end
			local pct = bar.value / maxThreat
			bar:SetPercent(pct)
			bar:SetLabel("%", ("%2.1f%%"):format(pct*100))
		else
			bar.frame:Hide()
		end
	end
end

function SingleTargetCompact:Hint()
	return "Single Target (Compact)\n|cffffffffShows your threat compared to the tanks' threat.|r"
end
