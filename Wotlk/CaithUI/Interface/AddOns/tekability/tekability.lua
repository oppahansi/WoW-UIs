

local SLOTIDS, FONTSIZE = {}, 12
for _,slot in pairs({"Head", "Shoulder", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands", "MainHand", "SecondaryHand", "Ranged"}) do SLOTIDS[slot] = GetInventorySlotInfo(slot .. "Slot") end
local frame = CreateFrame("Frame", nil, CharacterFrame)
local dataobj = LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject("tekability", {icon = "Interface\\Minimap\\Tracking\\Repair", text = "100%"})
local about = LibStub("tekKonfig-AboutPanel").new(nil, "tekability")


local function RYGColorGradient(perc)
	local relperc = perc*2 % 1
	if perc <= 0 then       return           1,       0, 0
	elseif perc < 0.5 then  return           1, relperc, 0
	elseif perc == 0.5 then return           1,       1, 0
	elseif perc < 1.0 then  return 1 - relperc,       1, 0
	else                    return           0,       1, 0 end
end


local fontstrings = setmetatable({}, {
	__index = function(t,i)
		local gslot = _G["Character"..i.."Slot"]
		assert(gslot, "Character"..i.."Slot does not exist")

		local fstr = gslot:CreateFontString(nil, "OVERLAY")
		local font, _, flags = NumberFontNormal:GetFont()
		fstr:SetFont("Fonts\\ARIALN.ttf", 14, "OUTLINE")  -- font, FONTSIZE, flags)
        fstr:SetShadowOffset(0,0)
		fstr:SetPoint("CENTER", gslot, "BOTTOM", 0, 6)
		t[i] = fstr
		return fstr
	end,
})


function frame:OnEvent(event, arg1)
	if event == "ADDON_LOADED" and arg1:lower() ~= "tekability" then
		for i,fstr in pairs(fontstrings) do
			-- Re-apply the font, so that we catch any changes to NumberFontNormal by addons like ClearFont
			local font, _, flags = NumberFontNormal:GetFont()
			fstr:SetFont("Fonts\\ARIALN.ttf", 14, "OUTLINE")  -- font, FONTSIZE, flags)
            fstr:SetShadowOffset(0,0)
		end
		return
	end

	local min = 1
	for slot,id in pairs(SLOTIDS) do
		local v1, v2 = GetInventoryItemDurability(id)

		if v1 and v2 and v2 ~= 0 then
			min = math.min(v1/v2, min)
			local str = fontstrings[slot]
			str:SetTextColor(RYGColorGradient(v1/v2))
			str:SetText(string.format("%d%%", v1/v2*100))
		else
			local str = rawget(fontstrings, slot)
			if str then str:SetText(nil) end
		end
	end

	local r,g,b = RYGColorGradient(min)
	dataobj.text = string.format("|cff%02x%02x%02x%d%%", r*255, g*255, b*255, min*100)
end


frame:SetScript("OnEvent", frame.OnEvent)
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("UPDATE_INVENTORY_DURABILITY")


------------------------
--      Tooltip!      --
------------------------

local function GetTipAnchor(frame)
	local x,y = frame:GetCenter()
	if not x or not y then return "TOPLEFT", "BOTTOMLEFT" end
	local hhalf = (x > UIParent:GetWidth()*2/3) and "RIGHT" or (x < UIParent:GetWidth()/3) and "LEFT" or ""
	local vhalf = (y > UIParent:GetHeight()/2) and "TOP" or "BOTTOM"
	return vhalf..hhalf, frame, (vhalf == "TOP" and "BOTTOM" or "TOP")..hhalf
end


function dataobj.OnLeave() GameTooltip:Hide() end


function dataobj.OnEnter(self)
 	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint(GetTipAnchor(self))
	GameTooltip:ClearLines()

	GameTooltip:AddLine("tekability")

	for slot,id in pairs(SLOTIDS) do
		local v1, v2 = GetInventoryItemDurability(id)

		if v1 and v2 and v2 ~= 0 then
			GameTooltip:AddDoubleLine(slot, string.format("%d%%", v1/v2*100), 1, 1, 1, RYGColorGradient(v1/v2))
		end
	end

	GameTooltip:Show()
end
