--[[
	DXE skin by Darth Android / Telroth - The Venture Co.
	
	Skins DXE to look like TelUI.
	
	File version v50.54
	(C)2010 Darth Android / Telroth - The Venture Co.
]]


if not Mod_AddonSkins or not IsAddOnLoaded("DBM-Core") then return end
local DBM = DBM
local _G = getfenv(0)

Mod_AddonSkins:RegisterSkin("DBM",function(Skin, skin, Layout, layout, config)

	function Skin:SkinDBMBar(bardata, frame)
		local bar = _G[frame:GetName().."Bar"]
		-- Override texture
		bar:SetStatusBarTexture(config.normTexture)
		-- Skin the bar
		self:SkinBackgroundFrame(frame)
		-- Adjust the bar
		bar:ClearAllPoints()
		bar:SetPoint("TOPLEFT",config.borderWidth, -config.borderWidth)
		bar:SetPoint("BOTTOMRIGHT",config.borderWidth, -config.borderWidth)
		-- Hide the background
		_G[frame:GetName().."BarBackground"]:SetTexture(nil)
		-- Skin Icons
		local icon1, icon2 = _G[frame:GetName().."BarIcon1"], _G[frame:GetName().."BarIcon2"]
		icon1:SetTexCoord(unpack(config.buttonZoom))
		icon1:ClearAllPoints()
		icon1:SetPoint("RIGHT",bar,"LEFT",-config.borderWidth,0)
		if not icon1.bg then
			icon1.bg = CreateFrame("Frame",nil,bar)
			skin:SkinBackgroundFrame(icon1.bg)
			icon1.bg:SetPoint("TOPLEFT",icon1,-config.borderWidth,config.borderWidth)
			icon1.bg:SetPoint("BOTTOMRIGHT",icon1,config.borderWidth,-config.borderWidth)
		end
		icon2:SetTexCoord(unpack(config.buttonZoom))
		icon2:ClearAllPoints()
		icon2:SetPoint("LEFT",bar,"RIGHT",config.borderWidth,0)
		if not icon2.bg then
			icon2.bg = CreateFrame("Frame",nil,bar)
			skin:SkinBackgroundFrame(icon2.bg)
			icon2.bg:SetPoint("TOPLEFT",icon2,-config.borderWidth,config.borderWidth)
			icon2.bg:SetPoint("BOTTOMRIGHT",icon2,config.borderWidth,-config.borderWidth)
		end
	end

	-- [[ Skin DTB (DBM's bars) ]]
	local DBT = DBM.Bars
	DBT.ApplyStyle_ = DBT.ApplyStyle
	function DBT:ApplyStyle()
		self:ApplyStyle_()
		for bardata in self:GetBarIterator() do
			local spark = getglobal(frame:GetName().."BarSpark")
			local name = getglobal(frame:GetName().."BarName")
			local timer = getglobal(frame:GetName().."BarTimer")
			skin:SkinDBMBar(bardata, frame)
		end
	end
	
	
end)

