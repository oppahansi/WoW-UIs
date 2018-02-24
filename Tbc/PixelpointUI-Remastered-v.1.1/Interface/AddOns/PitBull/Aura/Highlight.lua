if select(6, GetAddOnInfo("PitBull_" .. (debugstack():match("[i%.][t%.][B%.]ull\\Modules\\(.-)\\") or debugstack():match("[i%.][t%.][B%.]ull\\(.-)\\") or ""))) ~= "MISSING" then return end

local VERSION = tonumber(("$Revision: 63000 $"):match("%d+"))

local PitBull = PitBull
local PitBull_Aura = PitBull:GetModule("Aura")
local self = PitBull_Aura
PitBull:ProvideVersion("$Revision: 63000 $", "$Date: 2008-02-26 16:46:17 -0500 (Tue, 26 Feb 2008) $")

local newList, del = Rock:GetRecyclingFunctions("PitBull", "newList", "del")
local newFrame, delFrame = PitBull.newFrame, PitBull.delFrame

local _G = _G
local unpack = _G.unpack
local UnitDebuff = _G.UnitDebuff
local UnitIsFriend = _G.UnitIsFriend

local canDispel
_G.table.insert(PitBull_Aura.OnInitialize_funcs, function()
	canDispel = PitBull_Aura.canDispel
end)

local debuffHighlight_path, debuffHighlightBorder_path, debuffHighlightThinBorder_path
do
	local path = "Interface\\AddOns\\" .. _G.debugstack():match("[d%.][d%.][O%.]ns\\(.-)\\[A-Za-z0-9]-%.lua")
	debuffHighlight_path = path .. "\\debuffHighlight"
	debuffHighlightBorder_path = path .. "\\debuffHighlightBorder"
	debuffHighlightThinBorder_path = path .. "\\debuffHighlightThinBorder"
end

local function UpdateFrameHighlight(unit, frame)
	local debuffHighlight = frame.debuffHighlight
	
	local profile = self.db.profile
	local db = profile[frame.group]
	local frameHighlight = db.frameHighlight
	
	local hasHighlight
	
	if frameHighlight ~= "Cureable by me" and frameHighlight ~= "Cureable" or UnitIsFriend("player", unit) then
	local _, htexture, hdispel
		for i = 1, 40 do
			_, _, htexture, _, hdispel = UnitDebuff(unit, i) -- ignore the raidfilter for frame highlighting
			if htexture then
				if not hdispel then -- no dispel type set
					if frameHighlight == "All Debuffs" then -- only set highlight to "nil"  if we want to show all debuffs
						hasHighlight = "nil" -- we specifically continue here to find an optional cureable or cureable by me debuff which has priority for highlighting
					end
				elseif frameHighlight == "Cureable" or frameHighlight == "All Debuffs" then
					hasHighlight = hdispel
					if canDispel[hdispel] then
						break -- break here, we"ve got a cureable by me debuff...
					end
				elseif frameHighlight == "Cureable by me" and canDispel and canDispel[hdispel] then
					hasHighlight = hdispel
					break -- break here, we"ve got a cureable by me debuff...
				end
			else
				break
			end
		end
	end
	
	if hasHighlight then
		if not debuffHighlight then
			debuffHighlight = newFrame("Texture", frame.overlay, "OVERLAY")
			frame.debuffHighlight = debuffHighlight
			if db.highlightStyle == "border" then
				debuffHighlight:SetTexture(debuffHighlightBorder_path)
			elseif db.highlightStyle == "thinborder" then
				debuffHighlight:SetTexture(debuffHighlightThinBorder_path)
			else
				debuffHighlight:SetTexture(debuffHighlight_path)
			end
			debuffHighlight:SetBlendMode("ADD")
			debuffHighlight:SetAlpha(0.75)
			debuffHighlight:SetAllPoints(frame)
		end
		debuffHighlight:SetVertexColor(unpack(profile.colors.debuffs[hasHighlight], 1, 3))
	else
		if debuffHighlight then
			frame.debuffHighlight = delFrame(debuffHighlight)
		end
	end
end
PitBull_Aura.UpdateFrameHighlight = UpdateFrameHighlight