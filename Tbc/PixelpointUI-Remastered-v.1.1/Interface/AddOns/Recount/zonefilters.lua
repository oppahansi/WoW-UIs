-- Elsia: This handles filters for zones/instances

function Recount:SetZoneFilter(instanceType)
	
	if not instanceType then return end
	
	if Recount.db.profile.ZoneFilters[instanceType] then
		if Recount.db.profile.HideCollect and not Recount.CurrentDataCollect then
			Recount.MainWindow:Show()
		end
		Recount.CurrentDataCollect = true
	else
		if Recount.db.profile.HideCollect and Recount.CurrentDataCollect then
			Recount.MainWindow:Hide()
		end
		Recount.CurrentDataCollect = false
	end
end
