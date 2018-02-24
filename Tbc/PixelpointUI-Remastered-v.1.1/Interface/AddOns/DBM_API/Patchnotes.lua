DBM_PN = {
	["en"] = {
		[322] = {
			"localization/ruRU: added basic support for russian clients",
			"Sunwell/Kalecgos: fixed a bug that could cause the spectral realm frame to stick to your cursor",
			"Sunwell/Kalecgos: the spectral realm frame will now remember its position",
			"Sunwell/Eredar Twins: added a sound warning for conflag (PVPFlagTaken + HoodWolfTransformPlayer01 (\"Run away little girl!\"))",
			"cleaned up some localization files by removing old unused strings",
			"some minor tweaks and bug fixes"
		},
		[321] = {
			"updated the void reaver mod",
		}
	},
}

StaticPopupDialogs["COPY_DBM_URL"] = {
	text = DBM_COPY_PASTE_NOW,
	button1 = DBM_CLOSE,
	hasEditBox = 1,	
	button2 = "",
	
	OnShow = function()
		getglobal(this:GetName().."EditBox"):SetText("http://www.deadlybossmods.com");
		getglobal(this:GetName().."EditBox"):SetFocus();
		getglobal(this:GetName().."EditBox"):HighlightText();
		getglobal(this:GetName().."Button2"):Hide();
		getglobal(this:GetName().."Button1"):ClearAllPoints();
		getglobal(this:GetName().."Button1"):SetPoint("TOP", getglobal(this:GetName().."EditBox"), "BOTTOM", 0, -8);		
	end,
	OnHide = function()
		if ( ChatFrameEditBox:IsVisible() ) then
			ChatFrameEditBox:SetFocus();
		end
		getglobal(this:GetName().."EditBox"):SetText("");
		getglobal(this:GetName().."Button2"):Show();
	end,
	EditBoxOnEnterPressed = function()
		this:GetParent():Hide();
	end,
	EditBoxOnEscapePressed = function()
		this:GetParent():Hide();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
	hideOnEscape = 1
};

StaticPopupDialogs["OLD_VERSION_DETECTED"] = {
	text = DBM_ERROR_LVBM_STILL_LOADED,
	button1 = DBM_DISABLE_AND_RELOAD,
	
	OnAccept = function()
		DisableAddOn("LVBM_API");
		ReloadUI();
	end,
	
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
};