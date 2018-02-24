if ( not ArenaUnitFrames ) then
	return
end
local auf = ArenaUnitFrames;
auf.Options = {};
local opponents = auf.opponents;
local party = auf.party;
local config;

local selectedButton = 1;
local selectedModifier = 1;
local modifiers = {
	[1] = "none",
	[2] = "shift",
	[3] = "ctrl",
	[4] = "alt",
};

auf.Options.alertPage = 1;

auf.Options.options = {
	{
		name = "lockFrame",
		panel = "General",
	},
	{
		name = "buffScan",
		panel = "General",
	},
	{
		name = "rangeIndicator",
		panel = "General",
		onClick = function()
			for i = 1, 5 do
				_G["ArenaUnitFrame"..i.."RangeIconIcon"]:SetTexture(nil);
				_G["ArenaUnitFramePet"..i.."RangeIconIcon"]:SetTexture(nil);
			end
		end,
	},
	{
		name = "drMonitor",
		panel = "General",
	},
	{
		name = "showPetFrames",
		panel = "General",
		onClick = function()
			auf.ArrangeFrames();
		end,
	},
	{
		name = "showBuffs",
		panel = "General",
		onClick = function()
			auf.ResizeUnitFrames();
		end,
	},
	{
		name = "showDebuffs",
		panel = "General",
		onClick = function()
			auf.ResizeUnitFrames();
		end,
	},
	{
		name = "showToT",
		panel = "General",
		onClick = function()
			auf.ResizeUnitFrames();
		end,
	},
	{
		name = "showCastbar",
		panel = "General",
		onClick = function()
			auf.ResizeUnitFrames();
		end,
	},
	{
		name = "showTrinket",
		panel = "General",
		onClick = function()
			if ( not InCombatLockdown() ) then
				for i = 1, 5 do
					auf.SetFrameWidgets(_G["ArenaUnitFrame"..i]);
				end
			end
		end,
	},
	{
		name = "lockAlerts",
		panel = "General",
		onClick = function()
			if ( config["options"]["lockAlerts"] ) then
				ArenaUnitFramesAlertDragFrame:Hide();
			else
				ArenaUnitFramesAlertDragFrame:Show();
			end
		end,
	},
	{
		name = "colorize",
		panel = "General",
	},
	{
		name = "countdownPrecision",
		panel = "General",
	},
	{
		name = "showMyDebuffsOnly",
		panel = "Buffs",
		x = 250,
		y = -6,
	},
	{
		name = "showStealableOnly",
		panel = "Buffs",
		x = 250,
		y = -26,
	},
};

auf.defaults = {
	["options"] = {
		["lockFrame"] = false,
		["buffScan"] = true,
		["scale"] = .75,
		["rangeIndicator"] = false,
		["drMonitor"] = true,
		["showBuffs"] = true,
		["showDebuffs"] = true,
		["showToT"] = true,
		["showCastbar"] = true,
		["showMyDebuffsOnly"] = false,
		["showStealableOnly"] = false,
		["showTrinket"] = false,
		["lockAlerts"] = true,
		["colorize"] = false,
		["countdownPrecision"] = false,
		["targetColor"] = { 0.0, 0.8, 0.8, 1.0 },
		["focusColor"] = { 0.5, 0.5, 0.5, 1.0 },
	},
	["lists"] = {
		["buffs"] = {
			["which"] = 1,
			["white"] = "",
			["black"] = "",
		},
		["debuffs"] = {
			["which"] = 1,
			["white"] = "",
			["black"] = "",
		},
	},
	["buttons"] = {
		[1] = {
			["none"] = {
				["default"] = {
					action = "target",
				},
			},
		},
		[2] = {
			["none"] = {
				["default"] = {
					action = "focus",
				},
			},
		},
		[3] = {
		},
		[4] = {
		},
		[5] = {
		},
	},
};

local VariablesLoadedHook = auf.events.VARIABLES_LOADED;
local function VariablesLoaded()
	config = ArenaUnitFrames_Config;

	local function RecursiveCopy(s, d)
		local k, v;
		for k, v in pairs(s) do
			if ( type(v) == "table" ) then
				if ( not d[k] ) then
					d[k] = {};
				end
				RecursiveCopy(v, d[k]);
			elseif ( type(d[k]) == "nil" ) then
				d[k] = v;
			end
		end
	end
	RecursiveCopy(auf.defaults, config);



	VariablesLoadedHook();
end
auf.events.VARIABLES_LOADED = VariablesLoaded;

local colorPickingOption;
local colorPickingFrame;

----------------------------------------------------------------------------------------------
--	Option Check Box Functions
----------------------------------------------------------------------------------------------

function auf.Options.CreateCheckBoxes(panelName, x, y)
	local boxPrefix = "ArenaUnitFramesOptions"..panelName.."CheckButton";
	local panel = _G["ArenaUnitFramesInterface"..panelName.."Panel"];

	if ( not _G[boxPrefix.."1"] ) then

		-- create check buttons

		local button, lastBox;
		local i = 1;

		for _, option in ipairs(auf.Options.options) do
			if ( option.panel == panelName ) then

				button = CreateFrame("CheckButton", boxPrefix..i, panel, "UICheckButtonTemplate");
				button:SetWidth(option.width or 24);
				button:SetHeight(option.height or 25);
				if ( option.x ) then
					button:SetPoint("TOPLEFT", panel, "TOPLEFT", option.x, option.y);
				elseif ( not lastBox ) then
					button:SetPoint("TOPLEFT", panel, "TOPLEFT", x or 30, y or -50);
					lastBox = i;
				else
					button:SetPoint("TOPLEFT", _G[boxPrefix..lastBox], "BOTTOMLEFT", 0, -4);
					lastBox = i;
				end
				button:SetScript("OnClick", auf.Options.CheckBox_OnClick);
				button:SetScript("OnEnter", auf.Options.CheckBox_OnEnter);
				button:SetScript("OnLeave", auf.Options.CheckBox_OnLeave);
				button:SetScript("OnShow", auf.Options.CheckBox_OnShow);
				_G[button:GetName().."Text"]:SetText(ARENA_UNIT_FRAMES_OPTIONS[option.name].text);

				button.option = option;
				auf.Options.CheckBox_OnShow(button);

			end

			i = i + 1;
		end

	end
end

function auf.Options.CheckBox_OnClick(self)
	PlaySound("igMainMenuOptionCheckBoxOn");

	if ( self:GetChecked() ) then
		config["options"][self.option.name] = true;
	else
		config["options"][self.option.name] = false;
	end

	if ( self.option.onClick ) then
		self.option.onClick();
	end
end

function auf.Options.CheckBox_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
	GameTooltip:SetText(ARENA_UNIT_FRAMES_OPTIONS[self.option.name].tooltipText, nil, nil, nil, nil, 1);
end

function auf.Options.CheckBox_OnLeave(self)
	GameTooltip:Hide();
end

function auf.Options.CheckBox_OnShow(self)
	if ( config["options"][self.option.name] ) then
		self:SetChecked(1);
	else
		self:SetChecked(nil);
	end
end


----------------------------------------------------------------------------------------------
--	General Options
----------------------------------------------------------------------------------------------

function auf.Options.GeneralPanel_OnLoad(panel)
	panel.name = ARENA_UNIT_FRAMES;
	InterfaceOptions_AddCategory(panel);
end

function auf.Options.GeneralPanel_OnShow(self)

	auf.Options.CreateCheckBoxes("General");
end

function auf.Options.SetColorPickingButton(frame, option)
	if ( frame ) then
		_G[frame:GetName().."Texture"]:SetVertexColor(unpack(config["options"][option]));
	else
		_G[colorPickingFrame:GetName().."Texture"]:SetVertexColor(unpack(config["options"][colorPickingOption]));
	end
end

function auf.Options.ColorPickingButton_OnClick(self, option)
	colorPickingOption = option;
	colorPickingFrame = self;

	ColorPickerFrame:SetColorRGB(unpack(config["options"][colorPickingOption]));
	ColorPickerFrame.hasOpacity = false;
	ColorPickerFrame.opacity = 1;
	ColorPickerFrame.previousValues = unpack(config["options"][colorPickingOption]);
	ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = auf.Options.ColorPickerCallback, auf.Options.ColorPickerCallback, auf.Options.ColorPickerCallback;
	ColorPickerFrame:Hide();
	ColorPickerFrame:Show();
end

function auf.Options.ColorPickerCallback(restore)
	if ( restore ) then
		--newR, newG, newB, newA = unpack(restore);
	else
		config["options"][colorPickingOption][1], config["options"][colorPickingOption][2], config["options"][colorPickingOption][3] = ColorPickerFrame:GetColorRGB();
	end

	auf.Options.SetColorPickingButton();
end

----------------------------------------------------------------------------------------------
--	Alert Options
----------------------------------------------------------------------------------------------

function auf.Options.AlertsPanel_OnLoad(panel)
	panel.name = ARENA_UNIT_FRAMES_ALERTS_LABEL;
	panel.parent = ARENA_UNIT_FRAMES;
	InterfaceOptions_AddCategory(panel);
end

function auf.Options.AlertsPanel_OnShow(self)
	auf.Options.AlertPageUpdate();
end

-- delete entire alert table if it is defaults (i.e. off) to save memory
function auf.Options.CleanAlertCfg(alertName)
	local alertCfg = config["Alerts"][alertName];

	if ( not next(alertCfg) ) then
		config["Alerts"][alertName] = nil;
	end
end

function auf.Options.MsgCheckButton_OnClick(self)
	local alert = auf.alerts[self:GetParent().alertIdx];

	if ( not config["Alerts"][alert.name] ) then
		config["Alerts"][alert.name] = {};
	end

	if ( self:GetChecked() ) then
		config["Alerts"][alert.name].displayMsg = true;
	else
		config["Alerts"][alert.name].displayMsg = nil;
	end

	auf.Options.CleanAlertCfg(alert.name);
end

function auf.Options.AudioRadio_OnClick(self, id)
	local alert = auf.alerts[self:GetParent().alertIdx];
	local parentName = self:GetParent():GetName();

	if ( not config["Alerts"][alert.name] ) then
		config["Alerts"][alert.name] = {};
	end

	if ( id == 1 ) then
		config["Alerts"][alert.name].soundEffect = nil;
		config["Alerts"][alert.name].speech = nil;
		_G[parentName.."SoundEffectRadio"]:SetChecked(nil);
		_G[parentName.."SpeechRadio"]:SetChecked(nil);

	elseif ( id == 2 ) then
		config["Alerts"][alert.name].soundEffect = true;
		config["Alerts"][alert.name].speech = nil;
		_G[parentName.."NoAudioRadio"]:SetChecked(nil);
		_G[parentName.."SpeechRadio"]:SetChecked(nil);

	elseif ( id == 3 ) then
		config["Alerts"][alert.name].speech = true;
		config["Alerts"][alert.name].soundEffect = nil;
		_G[parentName.."NoAudioRadio"]:SetChecked(nil);
		_G[parentName.."SoundEffectRadio"]:SetChecked(nil);
	end

	self:SetChecked(1);
	auf.Options.CleanAlertCfg(alert.name);
end

function auf.Options.SoundEffectPlayButton_OnClick(self)
	local alert = auf.alerts[self:GetParent().alertIdx];

	if ( config["Alerts"][alert.name] and config["Alerts"][alert.name].customSound ) then
		PlaySoundFile("Interface\\AddOns\\ArenaUnitFrames\\Sounds\\Custom\\"..config["Alerts"][alert.name].customSound);
	else
		PlaySoundFile("Interface\\AddOns\\ArenaUnitFrames\\Sounds\\"..alert.soundEffect);
	end
end

function auf.Options.SpeechPlayButton_OnClick(self)
	local alert = auf.alerts[self:GetParent().alertIdx];
	if ( alert.speech ) then
		auf.Speak(alert.speech);
	end
end

function auf.Options.AlertPageUpdate()
	
	local numAlerts = #auf.alerts;
	local maxPages = ceil(numAlerts / 6);
	local alert, frame, frameName, frameId;
	local max = auf.Options.alertPage * 6;
	local min = max - 5;
	if ( min < 1 ) then
		min = 1;
	end

	frameId = 1;
	for i = min, max do
		alert = auf.alerts[i];

		frame = _G["ArenaUnitFramesInterfaceAlertsPanelSelection"..frameId];
		frameName = frame:GetName();
		frame.alertIdx = i;

		if ( not alert ) then
			frame:Hide();
		else

			frame:Show();

			_G[frameName.."Name"]:SetText(ARENA_UNIT_FRAMES_ALERTS[alert.name].text);
			frame.tooltipText = ARENA_UNIT_FRAMES_ALERTS[alert.name].tooltipText;

			if ( alert.options ) then
				_G[frameName.."OptionsButton"]:Show();
			else
				_G[frameName.."OptionsButton"]:Hide();
			end

			if ( alert.excludes ) then
				_G[frameName.."ExcludesButton"]:Show();
			else
				_G[frameName.."ExcludesButton"]:Hide();
			end

			if ( alert.speech ) then
				_G[frameName.."SpeechRadio"]:Show();
				_G[frameName.."SpeechPlayButton"]:Show();
			else
				_G[frameName.."SpeechRadio"]:Hide();
				_G[frameName.."SpeechPlayButton"]:Hide();
			end

			_G[frameName.."MsgCheckButton"]:SetChecked(nil);
			_G[frameName.."NoAudioRadio"]:SetChecked(1);
			_G[frameName.."SoundEffectRadio"]:SetChecked(nil);
			_G[frameName.."SpeechRadio"]:SetChecked(nil);

			if ( config["Alerts"][alert.name] ) then

				if ( config["Alerts"][alert.name].displayMsg ) then
					_G[frameName.."MsgCheckButton"]:SetChecked(1);
				end
				if ( config["Alerts"][alert.name].soundEffect ) then
					_G[frameName.."SoundEffectRadio"]:SetChecked(1);
					_G[frameName.."NoAudioRadio"]:SetChecked(nil);
				end
				if ( config["Alerts"][alert.name].speech ) then
					_G[frameName.."SpeechRadio"]:SetChecked(1);
					_G[frameName.."NoAudioRadio"]:SetChecked(nil);
				end

			end
		end

		frameId = frameId + 1;
	end

	if ( auf.Options.alertPage >= maxPages ) then
		ArenaUnitFramesInterfaceAlertsPanelNextPageButton:Disable();
	else
		ArenaUnitFramesInterfaceAlertsPanelNextPageButton:Enable();
	end

	if ( auf.Options.alertPage == 1 ) then
		ArenaUnitFramesInterfaceAlertsPanelPrevPageButton:Disable();
	else
		ArenaUnitFramesInterfaceAlertsPanelPrevPageButton:Enable();
	end
end


-- Options Button Functions --------------------------------------------------------------------------

function auf.Options.AlertOptionsButton_OnClick(self)
	local parent = self:GetParent();

	AreaUnitFramesAlertOptionsFrame.alertIdx = parent.alertIdx;

	local alert = auf.alerts[AreaUnitFramesAlertOptionsFrame.alertIdx];
	local height = 60;
	local sliders, editBoxes = 0, 0;
	local anchor, widget, value, labelName;

	for index, option in ipairs(alert.options) do

		if ( option.type == "slider" ) then
			
			sliders = sliders + 1;
			widget = _G["ArenaUnitFramesAlertOptionsFrameSlider"..sliders];
			if ( not widget ) then
				widget = CreateFrame("Slider", "ArenaUnitFramesAlertOptionsFrameSlider"..sliders, AreaUnitFramesAlertOptionsFrame, "OptionsSliderTemplate");
			end

			if ( anchor ) then
				widget:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -5);
			else
				widget:SetPoint("TOPLEFT", AreaUnitFramesAlertOptionsFrame, "TOPLEFT", 20, -25);
			end
			anchor = widget;

			if ( config["Alerts"][alert.name] and config["Alerts"][alert.name]["options"] and config["Alerts"][alert.name]["options"][option.name] ) then
				value = config["Alerts"][alert.name]["options"][option.name];
			else
				value = option.value;
			end

			widget:SetMinMaxValues(option.min, option.max);
			widget:SetValueStep(option.step);
			widget:SetValue(value);
			_G[widget:GetName().."Text"]:SetText(option.text);
			_G[widget:GetName().."Low"]:SetText(option.lowText);
			_G[widget:GetName().."High"]:SetText(option.highText);

			height = height + 40;


		elseif ( option.type == "edit box" ) then

			editBoxes = editBoxes + 1;
			widget = _G["ArenaUnitFramesAlertOptionsFrameEditBox"..editBoxes];
			if ( not widget ) then
				widget = CreateFrame("EditBox", "ArenaUnitFramesAlertOptionsFrameEditBox"..editBoxes, AreaUnitFramesAlertOptionsFrame, "InputBoxTemplate");
			end

			if ( anchor ) then
				widget:SetPoint("TOPLEFT", anchor, "BOTTOMLEFT", 0, -20);
			else
				widget:SetPoint("TOPLEFT", AreaUnitFramesAlertOptionsFrame, "TOPLEFT", 20, -30);
			end
			anchor = widget;

			if ( config["Alerts"][alert.name] and config["Alerts"][alert.name]["options"] and config["Alerts"][alert.name]["options"][option.name] ) then
				value = config["Alerts"][alert.name]["options"][option.name];
			else
				value = option.value;
			end

			widget:SetHeight(16);
			widget:SetWidth(option.width);
			widget:SetMaxLetters(option.maxLetters or 100);
			widget:SetText(value or "");

			labelName = "ArenaUnitFramesExcludesFrameEditBox"..editBoxes.."LabelText";
			widget:CreateFontString(labelName, "OVERLAY");
			_G[labelName]:SetFontObject(GameFontNormalSmall);
			_G[labelName]:SetText(option.label);
			_G[labelName]:SetPoint("BOTTOMLEFT", widget, "TOPLEFT", 0, 3);

			height = height + 40;

		end

		widget.name = option.name;
		widget.index = index;
		widget:Show();
	end


	-- hide unused sliders
	local i = sliders + 1;
	widget = _G["ArenaUnitFramesAlertOptionsFrameSlider"..i];
	while ( widget ) do
		widget:Hide();
		widget.index = nil;

		i = i + 1;
		widget = _G["ArenaUnitFramesAlertOptionsFrameSlider"..i];
	end

	-- hide unused edit boxes
	i = editBoxes + 1;
	widget = _G["ArenaUnitFramesAlertOptionsFrameEditBox"..i];
	while ( widget ) do
		widget:Hide();
		widget.index = nil;

		widget = _G["ArenaUnitFramesAlertOptionsFrameEditBox"..i];
		i = i + 1;
	end

	AreaUnitFramesAlertOptionsFrame:SetWidth(200);
	AreaUnitFramesAlertOptionsFrame:SetHeight(height);

	AreaUnitFramesAlertOptionsFrame:ClearAllPoints();
	AreaUnitFramesAlertOptionsFrame:SetPoint("TOPRIGHT", parent, "TOPLEFT");

	AreaUnitFramesAlertOptionsFrame:Show();
end

function auf.Options.AlertOptionsOkayButton_OnClick(self)

	local alert = auf.alerts[AreaUnitFramesAlertOptionsFrame.alertIdx];

	if ( not config["Alerts"][alert.name] ) then
		config["Alerts"][alert.name] = {};
	end
	if ( not config["Alerts"][alert.name]["options"] ) then
		config["Alerts"][alert.name]["options"] = {};
	end

	local allDefaults = true;
	local widget, value;

	local i = 1;
	widget = _G["ArenaUnitFramesAlertOptionsFrameSlider"..i];

	while ( widget and widget.index ) do
		value = widget:GetValue();

		config["Alerts"][alert.name]["options"][widget.name] = value;
		if ( value ~= alert.options[widget.index].value ) then
			allDefaults = false;
		end

		i = i + 1;
		widget = _G["ArenaUnitFramesAlertOptionsFrameSlider"..i];
	end

	i = 1;
	widget = _G["ArenaUnitFramesAlertOptionsFrameEditBox"..i];
	while ( widget and widget.index ) do
		value = widget:GetText();

		config["Alerts"][alert.name]["options"][widget.name] = value;
		if ( value ~= alert.options[widget.index].value ) then
			allDefaults = false;
		end

		widget = _G["ArenaUnitFramesAlertOptionsFrameEditBox"..i];
		i = i + 1;
	end

	if ( allDefaults ) then
		config["Alerts"][alert.name]["options"] = nil;
	end

	auf.Options.CleanAlertCfg(alert.name);
	self:GetParent():Hide();
end


-- Exclude Button Functions --------------------------------------------------------------------------

function auf.Options.ExcludesButton_OnClick(self)

	local parent = self:GetParent();

	AreaUnitFramesExcludesFrame.alertIdx = parent.alertIdx;

	local alert = auf.alerts[AreaUnitFramesExcludesFrame.alertIdx];
	local numExcludes = 0;
	local button;

	for str, value in pairs(alert.excludes) do
		numExcludes = numExcludes + 1;

		-- create check boxes dynamically
		if ( not _G["ArenaUnitFramesExcludesFrameCheckButton"..numExcludes] ) then

			button = CreateFrame("CheckButton", "ArenaUnitFramesExcludesFrameCheckButton"..numExcludes, AreaUnitFramesExcludesFrame, "UICheckButtonTemplate");
			button:SetWidth(24);
			button:SetHeight(25);
			if ( numExcludes > 1 ) then
				button:SetPoint("TOPLEFT", "ArenaUnitFramesExcludesFrameCheckButton"..(numExcludes - 1), "BOTTOMLEFT");
			else
				button:SetPoint("TOPLEFT", AreaUnitFramesExcludesFrame, "TOPLEFT", 15, -15);
			end
			button:SetScript("OnClick", auf.Options.ExcludeCheckBox_OnClick);
		else
			button = _G["ArenaUnitFramesExcludesFrameCheckButton"..numExcludes];
		end

		_G[button:GetName().."Text"]:SetText(str);

		button.value = value;
		button:Show();

		if ( config["Alerts"][alert.name] and config["Alerts"][alert.name]["excludes"] and config["Alerts"][alert.name]["excludes"][value] ) then
			button:SetChecked(1);
		else
			button:SetChecked(nil);
		end
	end

	-- hide unused boxes
	local i = numExcludes + 1;
	while ( _G["ArenaUnitFramesExcludesFrameCheckButton"..i] ) do
		_G["ArenaUnitFramesExcludesFrameCheckButton"..i]:Hide();
		i = i + 1;
	end

	AreaUnitFramesExcludesFrame:SetWidth(225);
	AreaUnitFramesExcludesFrame:SetHeight(55 + numExcludes * 25);

	AreaUnitFramesExcludesFrame:ClearAllPoints();

	if ( numExcludes > 10 ) then
		AreaUnitFramesExcludesFrame:SetPoint("LEFT", parent, "RIGHT");
	else
		AreaUnitFramesExcludesFrame:SetPoint("TOPLEFT", parent, "TOPRIGHT");
	end

	AreaUnitFramesExcludesFrame:Show();
end

function auf.Options.ExcludeCheckBox_OnClick(self)

	local alert = auf.alerts[AreaUnitFramesExcludesFrame.alertIdx];

	if ( not config["Alerts"][alert.name] ) then
		config["Alerts"][alert.name] = {};
	end
	if ( not config["Alerts"][alert.name]["excludes"] ) then
		config["Alerts"][alert.name]["excludes"] = {};
	end

	if ( self:GetChecked() ) then
		config["Alerts"][alert.name]["excludes"][self.value] = true;
	else
		config["Alerts"][alert.name]["excludes"][self.value] = nil;
	end
end

function auf.Options.ExcludesOkayButton_OnClick(self)

	local alert = auf.alerts[AreaUnitFramesExcludesFrame.alertIdx];

	if ( config["Alerts"][alert.name] and config["Alerts"][alert.name]["excludes"] and not next(config["Alerts"][alert.name]["excludes"]) ) then
		config["Alerts"][alert.name]["excludes"] = nil;
	end

	auf.Options.CleanAlertCfg(alert.name);
	self:GetParent():Hide();
end


-- Custom Button Functions --------------------------------------------------------------------------

function auf.Options.CustomButton_OnClick(self)
	AreaUnitFramesCustomSoundFrame:ClearAllPoints();
	AreaUnitFramesCustomSoundFrame:SetPoint("TOPLEFT", self:GetParent(), "BOTTOMLEFT");
	AreaUnitFramesCustomSoundFrame.alertIdx = self:GetParent().alertIdx;

	local alert = auf.alerts[AreaUnitFramesCustomSoundFrame.alertIdx];
	if ( config["Alerts"][alert.name] and config["Alerts"][alert.name].customSound ) then
		AreaUnitFramesCustomSoundFrameEditBox:SetText(config["Alerts"][alert.name].customSound);
	else
		AreaUnitFramesCustomSoundFrameEditBox:SetText("");
	end

	AreaUnitFramesCustomSoundFrame:Show();
end

function auf.Options.CustomSoundOkayButton_OnClick(self)

	local alert = auf.alerts[AreaUnitFramesCustomSoundFrame.alertIdx];
	local fileName = AreaUnitFramesCustomSoundFrameEditBox:GetText();

	if ( not fileName or fileName == "" ) then
		if ( config["Alerts"][alert.name] ) then
			config["Alerts"][alert.name].customSound = nil;
		end
	else
		if ( not config["Alerts"][alert.name] ) then
			config["Alerts"][alert.name] = {};
		end
		config["Alerts"][alert.name].customSound = fileName;
	end

	auf.Options.CleanAlertCfg(alert.name);
	self:GetParent():Hide();
end


----------------------------------------------------------------------------------------------
--	Button Options
----------------------------------------------------------------------------------------------

function auf.Options.ButtonsPanel_OnLoad(panel)
	panel.name = ARENA_UNIT_FRAMES_BUTTONS;
	panel.parent = ARENA_UNIT_FRAMES;
	InterfaceOptions_AddCategory(panel);
end

function auf.Options.ButtonsPanel_OnShow()
	UIDropDownMenu_Initialize( ArenaUnitFramesButtonConfigButtonsDropDown, auf.Options.ButtonsPanelButtonDropDown_Initialize );
	UIDropDownMenu_SetWidth( ArenaUnitFramesButtonConfigButtonsDropDown, 110 );
	UIDropDownMenu_SetSelectedID( ArenaUnitFramesButtonConfigButtonsDropDown, selectedButton );

	UIDropDownMenu_Initialize( ArenaUnitFramesButtonConfigModifierDropDown, auf.Options.ButtonsPanelModifierDropDown_Initialize );
	UIDropDownMenu_SetWidth( ArenaUnitFramesButtonConfigModifierDropDown, 60 );
	UIDropDownMenu_SetSelectedID( ArenaUnitFramesButtonConfigModifierDropDown, selectedModifier );

	auf.Options.ButtonsPanelUpdate();
end

function auf.Options.ButtonsPanelButtonDropDown_Initialize()
	local i, v;

	for i, v in ipairs(ARENA_UNIT_FRAMES_BUTTON_LABELS) do
		UIDropDownMenu_AddButton( {
			text = v,
			value = i,
			func = auf.Options.ButtonsDropDown_OnClick,
		} );
	end

end

function auf.Options.ButtonsDropDown_OnClick(self)

	UIDropDownMenu_SetSelectedID( ArenaUnitFramesButtonConfigButtonsDropDown, self.value );
	selectedButton = UIDropDownMenu_GetSelectedID( ArenaUnitFramesButtonConfigButtonsDropDown );

	auf.Options.ButtonsPanelUpdate();
end

function auf.Options.ButtonsPanelModifierDropDown_Initialize()
	local i, v;
	for i, v in ipairs(ARENA_UNIT_FRAMES_MODIFIER_LABELS) do
		UIDropDownMenu_AddButton( {
			text = v,
			value = i,
			func = auf.Options.ButtonsPanelModifierDropDown_OnClick,
		} );
	end

end

function auf.Options.ButtonsPanelModifierDropDown_OnClick(self)

	UIDropDownMenu_SetSelectedID( ArenaUnitFramesButtonConfigModifierDropDown, self.value );
	selectedModifier = UIDropDownMenu_GetSelectedID( ArenaUnitFramesButtonConfigModifierDropDown );

	auf.Options.ButtonsPanelUpdate();
end

function auf.Options.ButtonsPanelUpdate()

	local modifier, frame, click, class, classText, macroFontString, i;
	local numMacros = 0;

	for i = 1, 10 do
		getglobal("ArenaUnitFramesOptionsFrameClass"..i.."Class"):SetText("");
		getglobal("ArenaUnitFramesOptionsFrameClass"..i.."Macro"):SetText("");
	end


	modifier = modifiers[selectedModifier];
	if ( not config["buttons"][selectedButton][modifier] ) then
		config["buttons"][selectedButton][modifier] = {};
	end
	click = config["buttons"][selectedButton][modifier];

	i = 1;
	class = "default";
	classText = DEFAULT;
	local loops = #CLASS_SORT_ORDER + 1;
	while ( i <= loops ) do
		if ( i > 1 ) then
			class = CLASS_SORT_ORDER[i - 1];
			classText = LOCALIZED_CLASS_NAMES_MALE[CLASS_SORT_ORDER[i - 1]];
		end
		frame = getglobal("ArenaUnitFramesOptionsFrameClass"..i);
		getglobal("ArenaUnitFramesOptionsFrameClass"..i.."Class"):SetText(classText);
		getglobal("ArenaUnitFramesOptionsFrameClass"..i).class = class;
		macroFontString = getglobal("ArenaUnitFramesOptionsFrameClass"..i.."Macro");

		frame:SetHeight(35);
		if ( click[class] ) then
			if ( click[class].action == "default" ) then
				macroFontString:SetText(USE.." "..DEFAULT);
				macroFontString:SetTextColor(0.5, 0.5, 0.5);
			elseif ( click[class].action == "target" ) then
				macroFontString:SetText(TARGET..ARENA_UNIT_FRAMES_UNIT);
				macroFontString:SetTextColor(1.0, 1.0, 1.0);

			elseif ( click[class].action == "focus" ) then
				macroFontString:SetText(FOCUS..ARENA_UNIT_FRAMES_UNIT);
				macroFontString:SetTextColor(1.0, 1.0, 1.0);

			elseif ( click[class].action == "cast" ) then
				macroFontString:SetText(ARENA_UNIT_FRAMES_CAST.." "..click[class].spell);
				macroFontString:SetTextColor(1.0, 1.0, 0.0);

			elseif ( click[class].action == "macro" ) then
				frame:SetHeight(75);
				numMacros = numMacros + 1;
				macroFontString:SetText(click[class].macro);
				macroFontString:SetTextColor(.8, .8, .8);
			end

		elseif ( class ~= "default" ) then
			macroFontString:SetText(USE.." "..DEFAULT);
			macroFontString:SetTextColor(0.5, 0.5, 0.5);
		else
			macroFontString:SetText(NONE);
			macroFontString:SetTextColor(0.5, 0.5, 0.5);
		end
		i = i + 1;
	end

	ArenaUnitFramesButtonConfigScrollBarChildFrame:SetHeight(35 * 11 + numMacros * 40);
end

function auf.Options.ButtonsPanelEditButton_OnClick(class)
	ArenaUnitFramesOptionsEditFrame.class = class;
	ArenaUnitFramesOptionsEditFrame:Show();
end

function auf.Options.ButtonsPanelEditFrame_OnShow(self)

	local modifier = modifiers[selectedModifier];
	local modifierText = "";

	-- set frame header text
	if ( modifier ~= "none" ) then	
		modifierText = "["..ARENA_UNIT_FRAMES_MODIFIER_LABELS[selectedModifier].."] ";
	end
	ArenaUnitFramesOptionsEditFrameTitle:SetText(
		modifierText..ARENA_UNIT_FRAMES_BUTTON_LABELS[selectedButton]..
		" - "..(LOCALIZED_CLASS_NAMES_MALE[self.class] or DEFAULT)
	);

	local classAction = config["buttons"][selectedButton][modifier][self.class];

	-- new?
	if ( not classAction ) then
		config["buttons"][selectedButton][modifier][self.class] = {};
		classAction = config["buttons"][selectedButton][modifier][self.class];
		classAction.action = "default";
	end

	-- set edit boxes
	if ( classAction.spell ) then
		ArenaUnitFramesOptionsEditFrameSpellEditBox:SetText(classAction.spell);
	else
		ArenaUnitFramesOptionsEditFrameSpellEditBox:SetText("");
	end
	if ( classAction.macro ) then
		ArenaUnitFramesOptionsEditFrameScrollFrameText:SetText(classAction.macro);
	else
		ArenaUnitFramesOptionsEditFrameScrollFrameText:SetText("");
	end

	-- default action's first radio is "none" class specific actions first radio is "default"
	if ( self.class == "default" ) then
		ArenaUnitFramesOptionsEditFrameDefaultRadioText:SetText(NONE);
	else
		ArenaUnitFramesOptionsEditFrameDefaultRadioText:SetText(DEFAULT);
	end

	if ( classAction.action == "default" ) then
		auf.Options.ButtonsPanelEditFrameRadio_OnClick(1);
	elseif ( classAction.action == "target" ) then
		auf.Options.ButtonsPanelEditFrameRadio_OnClick(2);
	elseif ( classAction.action == "focus" ) then
		auf.Options.ButtonsPanelEditFrameRadio_OnClick(3);
	elseif ( classAction.action == "cast" ) then
		auf.Options.ButtonsPanelEditFrameRadio_OnClick(4);
	elseif ( classAction.action == "macro" ) then
		auf.Options.ButtonsPanelEditFrameRadio_OnClick(5);
	end

end

function auf.Options.ButtonsPanelEditFrame_OnHide()
	auf.Options.ButtonsPanelUpdate();
end

function auf.Options.ButtonsPanelEditFrameRadio_OnClick(id)
	ArenaUnitFramesOptionsEditFrameDefaultRadio:SetChecked(0);
	ArenaUnitFramesOptionsEditFrameTargetRadio:SetChecked(0);
	ArenaUnitFramesOptionsEditFrameFocusRadio:SetChecked(0);
	ArenaUnitFramesOptionsEditFrameCastRadio:SetChecked(0);
	ArenaUnitFramesOptionsEditFrameMacroRadio:SetChecked(0);

	local modifier = modifiers[selectedModifier];
	local classAction = config["buttons"][selectedButton][modifier][ArenaUnitFramesOptionsEditFrame.class];

	if ( id == 1 ) then
		ArenaUnitFramesOptionsEditFrameDefaultRadio:SetChecked(1);
		classAction.action = "default";

	elseif ( id == 2 ) then
		ArenaUnitFramesOptionsEditFrameTargetRadio:SetChecked(1);
		classAction.action = "target";

	elseif ( id == 3 ) then
		ArenaUnitFramesOptionsEditFrameFocusRadio:SetChecked(1);
		classAction.action = "focus";

	elseif ( id == 4 ) then
		ArenaUnitFramesOptionsEditFrameCastRadio:SetChecked(1);
		classAction.action = "cast";
		if ( not classAction.spell ) then
			classAction.spell = "";
		end

	elseif ( id == 5 ) then
		ArenaUnitFramesOptionsEditFrameMacroRadio:SetChecked(1);
		classAction.action = "macro";
		if ( not classAction.macro ) then
			classAction.macro = "";
		end
	end
end

function auf.Options.ButtonsPanelEditFrameDoneButton_OnClick(self)
	local modifier = modifiers[selectedModifier];
	local class = ArenaUnitFramesOptionsEditFrame.class;
	local classAction = config["buttons"][selectedButton][modifier][class];

	classAction.spell = ArenaUnitFramesOptionsEditFrameSpellEditBox:GetText();
	classAction.macro = ArenaUnitFramesOptionsEditFrameScrollFrameText:GetText();

	-- delete empty tables
	if (	classAction.action == "default" and
		(not classAction.spell or classAction.spell == "" ) and
		(not classAction.macro or classAction.macro == "" )
	) then
		config["buttons"][selectedButton][modifier][class] = nil;
	end
	local n = 0;
	for _ in pairs(config["buttons"][selectedButton][modifier]) do
		n = n + 1;
	end
	if ( n == 0 ) then
		config["buttons"][selectedButton][modifier] = nil;
	end

	HideUIPanel(self:GetParent());
end


----------------------------------------------------------------------------------------------
--	Buff/Debuff Filters Options
----------------------------------------------------------------------------------------------

function auf.Options.BuffsPanel_OnLoad(panel)
	panel.name = ARENA_UNIT_FRAMES_BUFF_DISPLAY;
	panel.parent = ARENA_UNIT_FRAMES;
	InterfaceOptions_AddCategory(panel);
end

function auf.Options.BuffsListsRadio_OnClick(id)
	config["lists"]["buffs"]["which"] = id;
	if ( id == 1 ) then
		ArenaUnitFramesOptionsBuffsBlackListRadio:SetChecked(1);
		ArenaUnitFramesOptionsBuffsWhiteListRadio:SetChecked(0);
	else
		ArenaUnitFramesOptionsBuffsBlackListRadio:SetChecked(0);
		ArenaUnitFramesOptionsBuffsWhiteListRadio:SetChecked(1);
	end
end

function auf.Options.DebuffsListsRadio_OnClick(id)
	config["lists"]["debuffs"]["which"] = id;
	if ( id == 1 ) then
		ArenaUnitFramesOptionsDebuffsBlackListRadio:SetChecked(1);
		ArenaUnitFramesOptionsDebuffsWhiteListRadio:SetChecked(0);
	else
		ArenaUnitFramesOptionsDebuffsBlackListRadio:SetChecked(0);
		ArenaUnitFramesOptionsDebuffsWhiteListRadio:SetChecked(1);
	end
end

function auf.Options.BuffsPanel_OnShow()
	
	auf.Options.CreateCheckBoxes("Buffs");

	ArenaUnitFramesOptionsBuffsWhiteListRadio:SetChecked(0);
	ArenaUnitFramesOptionsBuffsBlackListRadio:SetChecked(0);

	ArenaUnitFramesOptionsDebuffsWhiteListRadio:SetChecked(0);
	ArenaUnitFramesOptionsDebuffsBlackListRadio:SetChecked(0);

	if ( config["lists"]["buffs"]["which"] == 1 ) then
		ArenaUnitFramesOptionsBuffsBlackListRadio:SetChecked(1);
	else
		ArenaUnitFramesOptionsBuffsWhiteListRadio:SetChecked(1);
	end

	if ( config["lists"]["debuffs"]["which"] == 1 ) then
		ArenaUnitFramesOptionsDebuffsBlackListRadio:SetChecked(1);
	else
		ArenaUnitFramesOptionsDebuffsWhiteListRadio:SetChecked(1);
	end
end
