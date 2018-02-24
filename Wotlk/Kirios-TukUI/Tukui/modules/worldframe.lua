if TukuiCF["frames"].world ~= true then return end

local TukuiWorldFrame = CreateFrame("Frame", nil, UIParent)

TukuiWorldFrame:RegisterEvent("ADDON_LOADED")
TukuiWorldFrame:SetScript("OnEvent", function(self, event, addon)
	if (addon == "Tukui") then
    self:UnregisterEvent("ADDON_LOADED")

    local wsupbutton = CreateFrame("Button", "WorldFrameButton", WorldStateAlwaysUpFrame)
    TukuiDB.CreatePanel(wsupbutton, 40, 10, "BOTTOM", WorldStateAlwaysUpFrame, "TOP", 0, 0)
    wsupbutton:Hide()

    local wsup = WorldStateAlwaysUpFrame
    local wsupmove = false 

		wsup:SetMovable(true)
		wsup:SetClampedToScreen(false)
		wsup:ClearAllPoints()
		wsup:SetPoint("TOPLEFT", UIParent, "TOPLEFT", TukuiDB.Scale(-80), TukuiDB.Scale(-25))
		wsup:SetSize(TukuiCF["panels"].tinfowidth * TukuiCF["general"].uiscale, TukuiCF["panels"].tinfowidth * 0.5)
		wsup:SetUserPlaced(true)
		wsup.SetPoint = TukuiDB.dummy
		wsup.ClearAllPoints = TukuiDB.dummy

		local function WORLDFRAMELOCK()
			if wsupmove == false then
				wsupmove = true
				print("WorldFrame unlock")
				wsup:EnableMouse(true);
				wsup:RegisterForDrag("LeftButton");
				wsup:SetScript("OnDragStart", wsup.StartMoving);
				wsup:SetScript("OnDragStop", wsup.StopMovingOrSizing);
				wsupbutton:Show()
			elseif wsupmove == true then
				wsup:EnableMouse(false);
				wsupmove = false
				wsupbutton:Hide()
				print("WorldFrame lock")
			end
		end

		SLASH_WORLDFRAMELOCK1 = "/wsup"
		SlashCmdList["WORLDFRAMELOCK"] = WORLDFRAMELOCK
	end
end)