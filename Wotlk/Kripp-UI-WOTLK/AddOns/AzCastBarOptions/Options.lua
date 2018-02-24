local modName = "AzCastBar";
local f = CreateFrame("Frame",modName.."Options",UIParent);
local p = CreateFrame("Frame",nil,f);

-- Config
AzCastBar_Profiles = {};
local cfg = AzCastBar_Config;

-- Lists
local CategoryList = {};
local ITEM_HEIGHT = 18;
local ignoreConfigUpdate;

-- Options
local DROPDOWN_LABEL_ALIGNMENT = { Left = "LEFT", Center = "CENTER", Right = "RIGHT" };
local DROPDOWN_FONT_FLAGS = { ["|cffffa0a0None"] = "", ["Outline"] = "OUTLINE", ["Thick Outline"] = "THICKOUTLINE" };
local activePage, subPage = 1, 1;
local frames = {};
local options = {
	{
		[0] = "General",
		{ type = "Check", var = "enabled", label = "Enable Bar Plugin", tip = "Enable or disable this bar plugin", y = 12 },
		{ type = "Check", var = "reverseGrowth", label = "Reverse StatusBar Growth", tip = "Reverse Growth" },
		{ type = "Check", var = "showSpark", label = "Show StatusBar Spark", tip = "Shows a spark on the statusbar", y = 28 },
		{ type = "Slider", var = "fadeTime", label = "Fade Out Time", min = 0, max = 6, step = 0.1 },
		{ type = "Slider", var = "alpha", label = "Alpha", min = 0, max = 1, step = 0.01, y = 28 },
		{ type = "DropDown", label = "Copy Settings From", init = AzCastBarDropDowns.CopyPluginSettings_Init },
		{ type = "DropDown", label = "Layout Template", init = AzCastBarDropDowns.LayoutTemplate_Init },
	},
	{
		[0] = "Name Label",
		{ type = "Check", var = "showLabel", label = "Show Name Label", tip = "Show bar label on the left side of the bar", y = 16 },
		{ type = "DropDown", var = "nameFontFace", label = "Font Face", media = "font" },
		{ type = "DropDown", var = "nameFontFlags", label = "Font Flags", list = DROPDOWN_FONT_FLAGS },
		{ type = "Slider", var = "nameFontSize", label = "Font Size", min = 4, max = 29, step = 1, y = 16 },
		{ type = "DropDown", var = "nameLabelAlign", label = "Name Label Alignment", list = DROPDOWN_LABEL_ALIGNMENT, y = 12 },
		{ type = "Color", var = "colNameLabel", label = "Name Label Color" },
		{ type = "Slider", var = "nameOffsetX", label = "Name Label Offset X", min = -300, max = 300, step = 1 },
		{ type = "Slider", var = "nameOffsetY", label = "Name Label Offset Y", min = -300, max = 300, step = 1, y = 16 },
	},
	{
		[0] = "Time Label",
		{ type = "Check", var = "showTime", label = "Show Time Label", tip = "Show the time on the right side of the bar", y = 16 },
		{ type = "DropDown", var = "timeFontFace", label = "Font Face", media = "font" },
		{ type = "DropDown", var = "timeFontFlags", label = "Font Flags", list = DROPDOWN_FONT_FLAGS },
		{ type = "Slider", var = "timeFontSize", label = "Font Size", min = 4, max = 29, step = 1, y = 16 },
		{ type = "DropDown", var = "timeLabelAlign", label = "Time Label Alignment", list = DROPDOWN_LABEL_ALIGNMENT, y = 12 },
		{ type = "Color", var = "colTimeLabel", label = "Time Label Color" },
		{ type = "Slider", var = "timeOffsetX", label = "Time Label Offset X", min = -300, max = 300, step = 1 },
		{ type = "Slider", var = "timeOffsetY", label = "Time Label Offset Y", min = -300, max = 300, step = 1, y = 8 },
		{ type = "Check", var = "showTotalTime", label = "Also Show Total Duration", tip = "Show the total time of the cast" },
	},
	{
		[0] = "Appearance",
		{ type = "DropDown", var = "texture", label = "Bar Texture", media = "statusbar" },
		{ type = "Check", var = "useSameBGTexture", label = "Use Bar Texture as Background Texture", tip = "Enable this to have the background use the same texture as the bar. If disabled, a plain white texture is used instead", y = 8 },
		{ type = "Color", var = "colBackGround", label = "Background Color", y = 16 },
		{ type = "Color", var = "colBackdrop", label = "Backdrop Color" },
		{ type = "DropDown", var = "bgFile", label = "Backdrop Background", media = "background" },
--		{ type = "DropDown", var = "edgeFile", label = "Backdrop Border", media = "border", y = 8 },
--		{ type = "Slider", var = "edgeSize", label = "Backdrop Edge Size", min = -20, max = 60, step = 0.5 },
		{ type = "Slider", var = "backdropIndent", label = "Backdrop Indent", min = -20, max = 60, step = 0.5, y = 12 },
	},
	{
		[0] = "Position",
		{ type = "DropDown", var = "strata", label = "Frame Strata", list = { Low = "LOW", Medium = "MEDIUM", High = "HIGH" }, y = 12 },
		{ type = "Slider", var = "left", label = "Left Offset", min = 0, max = 2048, step = 1 },
		{ type = "Slider", var = "bottom", label = "Bottom Offset", min = 0, max = 1536, step = 1, y = 16 },
		{ type = "Slider", var = "width", label = "Width", min = 1, max = 2048, step = 1 },
		{ type = "Slider", var = "height", label = "Height", min = 1, max = 120, step = 1 },
	},
	{
		[0] = "Anchors",
		{ type = "DropDown", var = "anchorPoint", label = "Anchor Direction", list = { Upwards = "TOP", Downwards = "BOTTOM", Left = "LEFT", Right = "RIGHT" } },
		{ type = "Slider", var = "anchorOffset", label = "Anchor Offset", min = -40, max = 40, step = 1, y = 28 },
		{ type = "DropDown", var = "iconAnchor", label = "Icon Anchor", list = { Left = "LEFT", Right = "RIGHT", ["|cffffa0a0None"] = "NONE" } },
		{ type = "Slider", var = "iconOffset", label = "Icon Offset", min = 0, max = 20, step = 0.5 },
		{ type = "Check", var = "hideIconBorder", label = "Hide Icon Border", tip = "Checking this will hide the borders around spell icons" },
	},
};

--------------------------------------------------------------------------------------------------------
--                                        Options Category List                                       --
--------------------------------------------------------------------------------------------------------

-- Builds the Category List from Core and Plugin options
local function BuildSubCategoryList()
	wipe(CategoryList);
	for index, tbl in ipairs(options) do
		CategoryList[#CategoryList + 1] = { name = tbl[0], options = tbl, index = index };
	end
	if (type(AzCastBar.frames[activePage].options) == "table") then
		for index, tbl in ipairs(AzCastBar.frames[activePage].options) do
			CategoryList[#CategoryList + 1] = { name = tbl[0], options = tbl, index = index, custom = 1 };
		end
	end
	if (subPage > #CategoryList) then
		subPage = 1;
	end
end

-- Update Plugins
local function UpdatePluginList()
	FauxScrollFrame_Update(AzCastBarPluginsScroll,#AzCastBar.frames,#f.plugins,ITEM_HEIGHT);
	local width = (f.outline:GetWidth() - (#AzCastBar.frames > #f.plugins and 26 or 11));
	local button, plugin;
	local index = f.scroll.offset;
	for i = 1, #f.plugins do
		index = (index + 1);
		button = f.plugins[i];
		plugin = AzCastBar.frames[index];
		if (plugin) then
			button.text:SetText(plugin.token);
			button.index = index;
			if (index == activePage) then
				button:LockHighlight();
				button.text:SetTextColor(1,1,1);
			else
				button:UnlockHighlight();
				button.text:SetTextColor(1,0.82,0);
			end
			button:SetWidth(width);
			button:Show();
		else
			button:Hide();
		end
	end
end

-- Update Option List
local function UpdateCategoryList()
	FauxScrollFrame_Update(AzCastBarCategoryScroll,#CategoryList,#f.categories,ITEM_HEIGHT);
	local width = (f.outline2:GetWidth() - (#CategoryList > #f.categories and 26 or 11));
	local button, cat;
	local index = f.scroll2.offset;
	for i = 1, #f.categories do
		index = (index + 1);
		button = f.categories[i];
		cat = CategoryList[index];
		if (cat) then
			button.text:SetText((cat.custom and "|cff00ff00*|r " or "")..cat.name);
			button.index = index;
			if (index == subPage) then
				button:LockHighlight();
				button.text:SetTextColor(1,1,1);
			else
				button:UnlockHighlight();
				button.text:SetTextColor(1,0.82,0);
			end
			button:SetWidth(width);
			button:Show();
		else
			button:Hide();
		end
	end
end

--------------------------------------------------------------------------------------------------------
--                                          Initialize Frame                                          --
--------------------------------------------------------------------------------------------------------

f:SetWidth(460);
f:SetHeight(416);
f:SetBackdrop({ bgFile = "Interface\\ChatFrame\\ChatFrameBackground", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16, insets = { left = 3, right = 3, top = 3, bottom = 3 } });
f:SetBackdropColor(0.1,0.22,0.35,1);
f:SetBackdropBorderColor(0.1,0.1,0.1,1);
f:EnableMouse(1);
f:SetMovable(1);
f:SetFrameStrata("DIALOG");
f:SetToplevel(1);
f:SetClampedToScreen(1);
f:SetScript("OnShow",function() if (#AzCastBar.frames > 0) then UpdatePluginList(); BuildSubCategoryList(); UpdateCategoryList(); f:BuildCategoryPage(); f:SetScript("OnShow",nil); end end);
f:Hide();

f.outline = CreateFrame("Frame",nil,f);
f.outline:SetBackdrop({ bgFile = "Interface\\Tooltips\\UI-Tooltip-Background", edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4 } });
f.outline:SetBackdropColor(0.1,0.1,0.2,1);
f.outline:SetBackdropBorderColor(0.8,0.8,0.9,0.4);
f.outline:SetPoint("TOPLEFT",12,-12);
f.outline:SetWidth(120);

f.outline2 = CreateFrame("Frame",nil,f);
f.outline2:SetBackdrop(f.outline:GetBackdrop());
f.outline2:SetBackdropColor(0.1,0.1,0.2,1);
f.outline2:SetBackdropBorderColor(0.8,0.8,0.9,0.4);
f.outline2:SetPoint("TOPLEFT",f.outline,"BOTTOMLEFT",0,-8);
f.outline2:SetPoint("BOTTOMLEFT",12,12);
f.outline2:SetWidth(120);

f:SetScript("OnMouseDown",f.StartMoving);
f:SetScript("OnMouseUp",function() f:StopMovingOrSizing(); cfg.optionsLeft = f:GetLeft(); cfg.optionsBottom = f:GetBottom(); end);

if (cfg.optionsLeft) and (cfg.optionsBottom) then
	f:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",cfg.optionsLeft,cfg.optionsBottom);
else
	f:SetPoint("CENTER");
end

f.header = f:CreateFontString(nil,"ARTWORK","GameFontHighlight");
f.header:SetFont(GameFontNormal:GetFont(),22,"THICKOUTLINE");
f.header:SetPoint("TOPLEFT",f.outline,"TOPRIGHT",10,-4);
f.header:SetText(modName.." Options");

f.vers = f:CreateFontString(nil,"ARTWORK","GameFontNormal");
f.vers:SetPoint("TOPRIGHT",-20,-20);
f.vers:SetText(GetAddOnMetadata(modName,"Version"));
f.vers:SetTextColor(1,1,0.5);

local function Reset_OnClick()
	for index, option in ipairs(CategoryList[subPage].options) do
		if (option.var) then
			cfg[f.activeBar.token][option.var] = nil;
		end
	end
	AzCastBar.CheckSettings();
	AzCastBar.ApplyBarSettings(f.activeBar);
	f:BuildCategoryPage();
end

local function Profiles_OnClick()
	if (f.profilesFrame:IsShown()) then
		f.profilesFrame:Hide();
	else
		f.profilesFrame:Show();
		f.profilesFrame:BuildProfileList();
	end
end

f.btnClose = CreateFrame("Button",nil,f,"UIPanelButtonTemplate");
f.btnClose:SetWidth(68);
f.btnClose:SetHeight(24);
f.btnClose:SetPoint("BOTTOMRIGHT",-15,15);
f.btnClose:SetScript("OnClick",function() f:Hide(); f.profilesFrame:Hide(); end);
f.btnClose:SetText("Close");

f.btnReset = CreateFrame("Button",nil,f,"UIPanelButtonTemplate");
f.btnReset:SetWidth(68);
f.btnReset:SetHeight(24);
f.btnReset:SetPoint("RIGHT",f.btnClose,"LEFT",-4,0);
f.btnReset:SetScript("OnClick",Reset_OnClick);
f.btnReset:SetText("Reset");

f.btnProfiles = CreateFrame("Button",nil,f,"UIPanelButtonTemplate");
f.btnProfiles:SetWidth(68);
f.btnProfiles:SetHeight(24);
f.btnProfiles:SetPoint("RIGHT",f.btnReset,"LEFT",-4,0);
f.btnProfiles:SetScript("OnClick",Profiles_OnClick);
f.btnProfiles:SetText("Profiles");

UISpecialFrames[#UISpecialFrames + 1] = f:GetName();
f.activeBar = AzCastBar.frames[activePage];

--------------------------------------------------------------------------------------------------------
--                                      Plugin & Category Entries                                     --
--------------------------------------------------------------------------------------------------------

-- OnClicks
local function List_OnClick(self,button)
	PlaySound("igMainMenuOptionCheckBoxOn");
	activePage = self.index;
	f.activeBar = AzCastBar.frames[activePage];
    BuildSubCategoryList();
	UpdatePluginList();
	UpdateCategoryList();
	f:BuildCategoryPage();
end

local function List2_OnClick(self,button)
	PlaySound("igMainMenuOptionCheckBoxOn");
	subPage = self.index;
	UpdateCategoryList();
	f:BuildCategoryPage();
end

-- Plugins
f.plugins = {};
for i = 1, 12 do
	local b = CreateFrame("Button",nil,f.outline);
	b:SetHeight(ITEM_HEIGHT);
	b:SetScript("OnClick",List_OnClick);
	b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	b:GetHighlightTexture():SetAlpha(0.7);

	b.text = b:CreateFontString(nil,"ARTWORK","GameFontNormal");
	b.text:SetPoint("LEFT",3,0);

	if (i == 1) then
		b:SetPoint("TOPLEFT",5,-6);
	else
		b:SetPoint("TOPLEFT",f.plugins[i - 1],"BOTTOMLEFT");
	end

	f.plugins[i] = b;
end

f.scroll = CreateFrame("ScrollFrame","AzCastBarPluginsScroll",f.outline,"FauxScrollFrameTemplate");
f.scroll:SetPoint("TOPLEFT",f.plugins[1]);
f.scroll:SetPoint("BOTTOMRIGHT",f.plugins[#f.plugins],-6,-1);
f.scroll:SetScript("OnVerticalScroll",function(self,offset) FauxScrollFrame_OnVerticalScroll(self,offset,ITEM_HEIGHT,UpdatePluginList) end);

f.outline:SetHeight(#f.plugins * ITEM_HEIGHT + 12);

-- Categories
f.categories = {};
for i = 1, 8 do
	local b = CreateFrame("Button",nil,f.outline2);
	b:SetHeight(ITEM_HEIGHT);
	b:SetScript("OnClick",List2_OnClick);
	b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	b:GetHighlightTexture():SetAlpha(0.7);

	b.text = b:CreateFontString(nil,"ARTWORK","GameFontNormal");
	b.text:SetPoint("LEFT",3,0);
	b.text:SetTextColor(0.45,0.83,0.67);

	if (i == 1) then
		b:SetPoint("TOPLEFT",5,-6);
	else
		b:SetPoint("TOPLEFT",f.categories[i - 1],"BOTTOMLEFT");
	end

	f.categories[i] = b;
end

f.scroll2 = CreateFrame("ScrollFrame","AzCastBarCategoryScroll",f.outline2,"FauxScrollFrameTemplate");
f.scroll2:SetPoint("TOPLEFT",f.categories[1]);
f.scroll2:SetPoint("BOTTOMRIGHT",f.categories[#f.categories],-6,-1);
f.scroll2:SetScript("OnVerticalScroll",function(self,offset) FauxScrollFrame_OnVerticalScroll(self,offset,ITEM_HEIGHT,UpdateCategoryList) end);

--------------------------------------------------------------------------------------------------------
--                                              Edit Mode                                             --
--------------------------------------------------------------------------------------------------------

-- EditModeBar: OnUpdate
local function EditModeBar_OnUpdate(self,elapsed)
	local time = (GetTime() % 2.36);
	self.status:SetValue(time);
	self:SetTimeText(time);
end

-- Stop Moving a Bar
local function EditModeBar_OnMouseUp(self,button)
	if (button == "RightButton") then
		self:ClearAllPoints();
		self:SetPoint("CENTER");
	end
	self:StopMovingOrSizing();
	-- Save New Position & Set The Real Bars Position
	self.cfg.left = self:GetLeft();
	self.cfg.bottom = self:GetBottom();
	self.realFrame:SetPoint("BOTTOMLEFT",UIParent,"BOTTOMLEFT",self:GetLeft(),self:GetBottom());
	-- Reflect Change in Options if Visible
	if (f:IsVisible()) and (self.cfg == f.activeBar.cfg) then
		f:BuildCategoryPage();
	end
end

-- Create EditMode Bars
local function CreateEditModeBar(frame)
	local b = AzCastBar.CreateBar("Button");
	b.token = frame.token;
	b.realFrame = frame;

	b:EnableMouse(1);
	b:SetMovable(1);
	b:SetToplevel(1);
	b:SetFrameStrata("DIALOG");

	b.status:SetMinMaxValues(0,2.36);
	b.name:SetText(frame.token);
	b.icon:SetTexture("Interface\\Icons\\Spell_Nature_UnrelentingStorm");

	b:SetScript("OnUpdate",EditModeBar_OnUpdate);
	b:SetScript("OnMouseUp",EditModeBar_OnMouseUp);
	b:SetScript("OnMouseDown",b.StartMoving);

	return b;
end

-- Toggle EditMode
local function EditMode_OnClick(self,button)
	local editMode = self:GetChecked();
	for index, frame in ipairs(AzCastBar.frames) do
		if (editMode) and (frame.cfg.enabled) then
			if (not frame.editModeBar) then
				frame.editModeBar = CreateEditModeBar(frame);
			end
			AzCastBar.ApplyBarSettingsSpecific(frame.editModeBar);
			frame.editModeBar.totalTimeText = (frame.cfg.showTotalTime and " / "..AzCastBar.FormatTime(2.36,1) or nil);
			frame.editModeBar.status:SetStatusBarColor(frame.status:GetStatusBarColor());
			frame.editModeBar:Show();
		elseif (frame.editModeBar) then
			frame.editModeBar:Hide();
		end
	end
end

-- Edit Mode CheckButton
f.editMode = CreateFrame("CheckButton",nil,f,"OptionsSmallCheckButtonTemplate");
f.editMode:SetWidth(26);
f.editMode:SetHeight(26);
f.editMode:SetScript("OnEnter",nil);
f.editMode:SetScript("OnLeave",nil);
f.editMode:SetScript("OnClick",EditMode_OnClick);
f.editMode:SetPoint("BOTTOMLEFT",f.outline2,"BOTTOMRIGHT",8,2);
f.editMode.text = select(6,f.editMode:GetRegions());
f.editMode.text:SetText("Edit Mode");

--------------------------------------------------------------------------------------------------------
--                                   Profiles: Button + Edit Scripts                                  --
--------------------------------------------------------------------------------------------------------

-- Load
local function Button_Load_OnClick(self,button)
	local left, bottom = cfg.optionsLeft, cfg.optionsBottom;
	wipe(cfg);
	cfg.optionsLeft, cfg.optionsBottom = left, bottom;
	for token, tbl in next, AzCastBar_Profiles[p.edit:GetText()] do
		for _, plugin in ipairs(AzCastBar.frames) do
			if (token == plugin.token) then
				cfg[token] = CopyTable(tbl);
			end
		end
	end
	AzCastBar.CheckSettings();
	AzCastBar.ApplyAllSettings();
	f:BuildCategoryPage();
end

-- Save
local function Button_Save_OnClick(self,button)
	AzCastBar_Profiles[p.edit:GetText()] = CopyTable(cfg);
	p:BuildProfileList();
end

-- Delete
local function Button_Delete_OnClick(self,button)
	AzCastBar_Profiles[p.edit:GetText()] = nil;
	p:BuildProfileList();
end

-- Text Changed
local function Edit_OnTextChanged(self)
	local name = p.edit:GetText();
	-- save
	if (name == "") then
		p.btnSave:Disable();
	else
		p.btnSave:Enable();
	end
	-- load & delete
	if (AzCastBar_Profiles[name]) then
		p.btnLoad:Enable();
		p.btnDelete:Enable();
	else
		p.btnLoad:Disable();
		p.btnDelete:Disable();
	end
end

--------------------------------------------------------------------------------------------------------
--                                       Profiles: Create Window                                      --
--------------------------------------------------------------------------------------------------------

p:SetWidth(198);
p:SetHeight(256);
p:SetPoint("CENTER",UIParent);
p:SetBackdrop(f:GetBackdrop());
p:SetBackdropColor(0.1,0.22,0.35,1);
p:SetBackdropBorderColor(0.1,0.1,0.1,1);
p:EnableMouse(1);
p:SetMovable(1);
p:SetToplevel(1);
p:SetClampedToScreen(1);
p:SetScript("OnMouseDown",function() p:StartMoving() end);
p:SetScript("OnMouseUp",function() p:StopMovingOrSizing(); end);
p:Hide();

p.header = p:CreateFontString(nil,"ARTWORK","GameFontHighlight");
p.header:SetFont(p.header:GetFont(),22,"THICKOUTLINE");
p.header:SetPoint("TOPLEFT",12,-12);

p.close = CreateFrame("Button",nil,p,"UIPanelCloseButton");
p.close:SetWidth(24);
p.close:SetHeight(24);
p.close:SetPoint("TOPRIGHT",-5,-5);
p.close:SetScript("OnClick",function() p:Hide(); end)

p.outline = CreateFrame("Frame",nil,p);
p.outline:SetHeight(158);
p.outline:SetPoint("TOPLEFT",12,-38);
p.outline:SetPoint("BOTTOMRIGHT",-12,62);
p.outline:SetBackdrop(f.outline:GetBackdrop());
p.outline:SetBackdropColor(0.1,0.1,0.2,1);
p.outline:SetBackdropBorderColor(0.8,0.8,0.9,0.4);

p.edit = CreateFrame("EditBox","AzCastBarOptionsProfilesEdit",p,"InputBoxTemplate");
p.edit:SetWidth(110);
p.edit:SetHeight(21);
p.edit:SetPoint("TOPLEFT",p.outline,"BOTTOMLEFT",7,-1);
p.edit:SetPoint("TOPRIGHT",p.outline,"BOTTOMRIGHT",-2,-1);
p.edit:SetScript("OnTextChanged",Edit_OnTextChanged);
p.edit:SetAutoFocus(nil);

p.btnLoad = CreateFrame("Button",nil,p,"UIPanelButtonTemplate");
p.btnLoad:SetWidth(56);
p.btnLoad:SetHeight(24);
p.btnLoad:SetPoint("BOTTOMLEFT",12,12);
p.btnLoad:SetScript("OnClick",Button_Load_OnClick);
p.btnLoad:SetText("Load");

p.btnSave = CreateFrame("Button",nil,p,"UIPanelButtonTemplate");
p.btnSave:SetWidth(56);
p.btnSave:SetHeight(24);
p.btnSave:SetPoint("LEFT",p.btnLoad,"RIGHT",2,0);
p.btnSave:SetScript("OnClick",Button_Save_OnClick);
p.btnSave:SetText("Save");

p.btnDelete = CreateFrame("Button",nil,p,"UIPanelButtonTemplate");
p.btnDelete:SetWidth(56);
p.btnDelete:SetHeight(24);
p.btnDelete:SetPoint("LEFT",p.btnSave,"RIGHT",2,0);
p.btnDelete:SetScript("OnClick",Button_Delete_OnClick);
p.btnDelete:SetText("Delete");

f.profilesFrame = p;

--------------------------------------------------------------------------------------------------------
--                                        Profiles: Build List                                        --
--------------------------------------------------------------------------------------------------------

local profilesList = {};
local profilesButtons = {};

-- Entry OnClick
local function Entry_OnClick(self,button)
	p.edit:SetText(profilesList[self.index]);
end

-- Create Entry Button
local function CreateEntryButton()
	local b = CreateFrame("Button",nil,p.outline);
	b:SetWidth(p.outline:GetWidth() - 8);
	b:SetHeight(18);
	b:SetScript("OnClick",Entry_OnClick);

	b:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");

	b.text = b:CreateFontString(nil,"ARTWORK","GameFontNormal");
	b.text:SetPoint("LEFT",3,0);

	profilesButtons[#profilesButtons + 1] = b;
	return b;
end

-- Build List
function p:BuildProfileList()
	wipe(profilesList);
	for entryName in next, AzCastBar_Profiles do
		profilesList[#profilesList + 1] = entryName;
	end
	sort(profilesList);
	p.header:SetText("Profiles ("..#profilesList..")");
	p:SetHeight(max(8,#profilesList) * 18 + 112);

	local entry;
	for i = 1, #profilesList do
		entry = profilesButtons[i] or CreateEntryButton();
		entry.text:SetText(profilesList[i]);
		entry.index = i;
		entry:ClearAllPoints();
		if (i == 1) then
			entry:SetPoint("TOPLEFT",5,-6);
		else
			entry:SetPoint("TOPLEFT",profilesButtons[i - 1],"BOTTOMLEFT");
		end
		entry:Show();
	end

	for i = (#profilesList + 1), #profilesButtons do
		profilesButtons[i]:Hide();
	end

	Edit_OnTextChanged();
end

--------------------------------------------------------------------------------------------------------
--                                        Build Option Objects                                        --
--------------------------------------------------------------------------------------------------------

-- Change Setting Func
local function ChangeSettingFunc(self,var,value)
	if (not ignoreConfigUpdate) then
		cfg[f.activeBar.token][var] = value;
		AzCastBar.ApplyBarSettings(f.activeBar);
		-- Update EditMode bars if enabled status was toggled
		if (f.editMode:GetChecked()) and (var == "enabled") then
			EditMode_OnClick(f.editMode);
		end
	end
end

local factory = AzOptionsFactory:New(f,nil,ChangeSettingFunc);

-- Build Page
function f:BuildCategoryPage()
	factory:ResetObjectUse();
	AzDropDown:HideMenu();
	local frame;
	local yOffset = -38;
	-- Loop Through Options
	ignoreConfigUpdate = 1;
	for index, option in ipairs(CategoryList[subPage].options) do
		if (option.type) and (not option.restrict or AzCastBar.EntryInTable(option.restrict,f.activeBar.token)) then
			-- Init & Setup the Frame
			frame = factory:GetObject(option.type);
			frame.option = option;
			frame.text:SetText(option.label);
			-- slider
			if (option.type == "Slider") then
				frame.slider:SetMinMaxValues(option.min,option.max);
				frame.slider:SetValueStep(option.step);
				frame.slider:SetValue(cfg[f.activeBar.token][option.var]);
				frame.edit:SetNumber(cfg[f.activeBar.token][option.var]);
				frame.low:SetText(option.min);
				frame.high:SetText(option.max);
			-- check
			elseif (option.type == "Check") then
				frame:SetHitRectInsets(0,frame.text:GetWidth() * -1,0,0);
				frame:SetChecked(cfg[f.activeBar.token][option.var]);
			-- color
			elseif (option.type == "Color") then
				frame:SetHitRectInsets(0,frame.text:GetWidth() * -1,0,0);
				if (option.subType == 2) then
					frame.color[1], frame.color[2], frame.color[3], frame.color[4] = factory:HexStringToRGBA(cfg[f.activeBar.token][option.var]);
				else
					frame.color[1], frame.color[2], frame.color[3], frame.color[4] = unpack(cfg[f.activeBar.token][option.var]);
				end
				frame.texture:SetVertexColor(frame.color[1],frame.color[2],frame.color[3],frame.color[4] or 1);
			-- dropdown
			elseif (option.type == "DropDown") then
				frame.InitFunc = (option.init or option.media and AzCastBarDropDowns.SharedMediaLib_Init or AzCastBarDropDowns.Default_Init);
				frame:InitSelectedItem(cfg[f.activeBar.token][option.var]);
			-- text
			elseif (option.type == "Text") then
				frame:SetText(cfg[f.activeBar.token][option.var]:gsub("|","||"));
			end
			-- Anchor the Frame
			frame:ClearAllPoints();
			frame:SetPoint("TOPLEFT",f.outline,"TOPRIGHT",factory.objectOffsetX[option.type] + (option.x or 0),yOffset);
			yOffset = (yOffset - frame:GetHeight() - factory.objectOffsetY[option.type] - (option.y or 0));
			-- Show
			frame:Show();
		end
	end
	-- Reset
	ignoreConfigUpdate = nil;
end