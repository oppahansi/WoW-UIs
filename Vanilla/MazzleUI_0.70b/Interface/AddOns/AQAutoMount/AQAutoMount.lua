AQMOUNT_VERSION = 1.8;
AQMOUNT_TITLE = "Ahn'Qiraj Auto Mount";
AQMOUNT_COLORPREF = "Color Preference :";
AQMOUNT_OVERRIDE = "Disable Overrides :";

local AQMOUNT_RANDOM = "Any";
local AQMOUNT_BLACK = "Black";
local AQMOUNT_BLUE = "Blue";
local AQMOUNT_GREEN = "Green";
local AQMOUNT_RED = "Red";
local AQMOUNT_YELLOW = "Yellow";
	
local AQMOUNT_AQ = "Ahn'Qiraj";

local AQMOUNT_USE = "^Use: Summons and dismisses";
local AQMOUNT_INCREASES = "Increases speed by";
local AQMOUNT_SUMMONS = {
	["Summon Felsteed"] = 1,
	["Summon Dreadsteed"] = 1,
	["Summon Warhorse"] = 1,
	["Summon Charger"] = 1,
	};

if ( GetLocale() == "frFR" ) then
	AQMOUNT_USE = "^Use: Invoque et renvoie";
	AQMOUNT_INCREASES = "Augmente la vitesse de";
	AQMOUNT_SUMMONS = {
		["Invoquer un Destrier maudit"] = 1,
		["Summon Dreadsteed"] = 1, -- Don't know proper localization for this
		["Invocation d'un Cheval de bataille"] = 1,
		["Summon Charger"] = 1, -- Don't know proper localization for this
	};
elseif ( GetLocale() == "deDE" ) then
	AQMOUNT_USE = "^Benutzen: Beschw\195\182rt ein.* reitbare.*";
	AQMOUNT_INCREASES = "Erh\195\182ht Tempo um";
	AQMOUNT_SUMMONS = {
		["Teufelsross beschw\195\182ren"] = 1,
		["Schreckensross herbeirufen"] = 1,
		["Schlachtross beschw\195\182ren"] = 1,
		["Streitross beschw\195\182ren"] = 1,
		};
end

AQAutoMount_Saved = {};

UIPanelWindows["AQAutoMountFrame"] = { area = "center", pushable = 0, whileDead = 1 };

local AQMOUNT_ICONPATH = "Interface\\Icons\\INV_Misc_QirajiCrystal_0";
local AQMOUNT_HASACTION;

-- Color Dropdown Menu selection list
local AQMOUNT_COLORS = {
	AQMOUNT_RANDOM,
	AQMOUNT_BLACK,
	AQMOUNT_BLUE,
	AQMOUNT_GREEN,
	AQMOUNT_RED,
	AQMOUNT_YELLOW,
	};

-- Color to dropdown list id
local AQMOUNT_DROPDOWN = {
	[AQMOUNT_RANDOM] = 1,
	[AQMOUNT_BLACK] = 2,
	[AQMOUNT_BLUE] = 3,
	[AQMOUNT_GREEN] = 4,
	[AQMOUNT_RED] = 5,
	[AQMOUNT_YELLOW] = 6,
	};

-- Color to AQ Mount texture id
local AQMOUNT_CRYSTALS = {
	AQMOUNT_YELLOW,
	AQMOUNT_RED,
	AQMOUNT_GREEN,
	AQMOUNT_BLUE,
	AQMOUNT_BLACK,
	};

-- Hook wow functions
AQMount_origUseAction = UseAction;
function AQMount_newUseAction(action,cursor,onSelf)
	if ( not AQMOUNT_HASACTION ) then
		if ( not AQAutoMount_Saved.disable and GetRealZoneText() == AQMOUNT_AQ ) then
			if ( AQMount_Go(action) ) then
				return;
			end
		end
	end
	AQMount_origUseAction(action,cursor,onSelf);
end
UseAction = AQMount_newUseAction;

AQMount_origUseContainerItem = UseContainerItem;
function AQMount_newUseContainerItem(bag,slot)
	if ( not AQAutoMount_Saved.disable and GetRealZoneText() == AQMOUNT_AQ ) then
		if ( AQMount_Go(bag,slot) ) then
			return;
		end
	end
	AQMount_origUseContainerItem(bag,slot);
end
UseContainerItem = AQMount_newUseContainerItem;

AQMount_origCastSpell = CastSpell;
function AQMount_newCastSpell(spellId, booktype)
	if ( not AQAutoMount_Saved.disable and GetRealZoneText() == AQMOUNT_AQ ) then
		if ( booktype == BOOKTYPE_SPELL and AQMOUNT_SUMMONS[GetSpellName(spellId, booktype)] ) then
			if ( AQMount_Go() ) then
				return;
			end
		end
	end
	AQMount_origCastSpell(spellId, booktype);
end
CastSpell = AQMount_newCastSpell;

AQMount_origCastSpellByName = CastSpellByName;
function AQMount_newCastSpellByName(spell,onSelf)
	if ( not AQAutoMount_Saved.disable and GetRealZoneText() == AQMOUNT_AQ ) then
		for k, v in AQMOUNT_SUMMONS do
			if ( string.find(string.lower(spell), string.lower(k)) ) then
				if ( AQMount_Go() ) then
					return;
				end
				break;
			end
		end
	end
	AQMount_origCastSpellByName(spell,onSelf);			
end
CastSpellByName = AQMount_newCastSpellByName;

-- Check if an item / buff is a Battle Tank and return it's color
function AQMount_TextureCheck(texture)
	if ( string.sub(texture, 1, 40) == AQMOUNT_ICONPATH ) then
		local num = tonumber(string.sub(texture, 41));
		return AQMOUNT_CRYSTALS[num];
	end
end

-- Check if the player is currently mounted on any mount and dismount them
function AQMount_UnMount()
	local i = 0;
	local buffIndex = GetPlayerBuff(i, "HELPFUL")
	local texture = GetPlayerBuffTexture(buffIndex);
	local length = strlen(AQMOUNT_INCREASES);
	while texture do
		if ( AQMount_TextureCheck(texture) ) then
			CancelPlayerBuff(buffIndex);
			return 1;
		end
		AQAutoMountTooltip:SetPlayerBuff(buffIndex);
		local text = AQAutoMountTooltipTextLeft2:GetText();
		if ( text and string.sub(text, 1, length) == AQMOUNT_INCREASES  ) then
			CancelPlayerBuff(buffIndex);
			return 1;
		end
		i = i+1;
		buffIndex = GetPlayerBuff(i, "HELPFUL")
		texture = GetPlayerBuffTexture(buffIndex);
		AQAutoMountTooltip:ClearLines();
	end
end

-- Check if an item or action is a non-aq mount
function AQMount_IsMount(i,j)
	local name;
	local use;
	local num;
	if ( j ) then
		AQAutoMountTooltip:SetBagItem(i,j);
	else
		AQAutoMountTooltip:SetAction(i);
		name = AQAutoMountTooltipTextLeft1:GetText();
	end
	num = AQAutoMountTooltip:NumLines();
	if ( num > 0 ) then
		use = getglobal("AQAutoMountTooltipTextLeft"..num):GetText();
	end
	if ( (use and string.find(use, AQMOUNT_USE))
		or (name and AQMOUNT_SUMMONS[name]) ) then
		return 1;
	end
end

-- Find any Qiraji Resonating Crystals in the player's bags
function AQMount_Find(prefcolor)
	local slots;
	local lastbag, lastslot;
	local all = {};
	for i=0, 4 do
		slots = GetContainerNumSlots(i);
		for j=1, slots do
			local texture = GetContainerItemInfo(i,j);
			if ( texture ) then
				local color = AQMount_TextureCheck(texture);
				if ( color ) then
					if ( prefColor and prefColor == color ) then
						return {i,j,color};
					else
						tinsert(all, {i,j,color});
					end
				end
			end
		end
	end
	return all;
end

-- Check if player is in Ahn'Qiraj and dismount them or mount them if they are
function AQMount_Go(i,j)
	if ( not i or AQMount_IsMount(i,j) ) then
		if ( AQMount_UnMount() ) then
			return 1;
		end
		local mounts = AQMount_Find(AQAutoMount_Saved.color);
		local num = getn(mounts);
		if ( num > 0 ) then
			local bag, slot, color = unpack(mounts[math.random(1,num)]);
			AQMount_origUseContainerItem(bag,slot);
			return 1;
		end
	end
end

-- AQ Auto Mount initialization
function AQMount_OnLoad()
	this:RegisterEvent("ACTIONBAR_SHOWGRID");
	this:RegisterEvent("ACTIONBAR_HIDEGRID");
	SlashCmdList["AQAUTOMOUNT"] = AQMount_Console;
	SLASH_AQAUTOMOUNT1 = "/aqmount";
end

-- AQ Auto Mount 
function AQMount_OnEvent()
	if ( event == "ACTIONBAR_SHOWGRID" ) then
		AQMOUNT_HASACTION = 1;
	else
		AQMOUNT_HASACTION = nil;
	end
end

-- AQ Auto Mount Options functions
function AQMount_Console(msg)
	if ( string.lower(string.sub(msg, 1, 2)) == "on" or string.lower(string.sub(msg, 1, 6)) == "enable" ) then
		AQAutoMount_Saved.disable = nil;
	elseif ( string.lower(string.sub(msg, 1, 3)) == "off" or string.lower(string.sub(msg, 1, 7)) == "disable" ) then
		AQAutoMount_Saved.disable = true;
	elseif ( string.lower(string.sub(msg, 1, 6)) == "toggle" ) then
		AQAutoMount_Saved.disable = not AQAutoMount_Saved.disable;
	elseif ( string.lower(string.sub(msg, 1, 4)) == "show" ) then
		AQMount_Show();
	elseif ( msg ~= "" ) then
		local status = "enabled";
		if ( AQAutoMount_Saved.disable ) then
			status = "disabled";
		end
		DEFAULT_CHAT_FRAME:AddMessage(AQMOUNT_TITLE.." "..AQMOUNT_VERSION.." - status : "..status);
		DEFAULT_CHAT_FRAME:AddMessage(" on / off / toggle - to enable, disable, or toggle overriding normal mount use.");
		DEFAULT_CHAT_FRAME:AddMessage(" show / (nothing) - display the options menu");
	else
		AQMount_Show();
	end
end

function AQMount_Show()
	ShowUIPanel(AQAutoMountFrame);
	AQAutoMount_Saved.override = nil;
end

function AQMount_ColorDropDown_OnLoad()
	UIDropDownMenu_Initialize(this, AQMount_ColorDropDown_Init);
	if ( AQAutoMount_Saved.color ) then
		UIDropDownMenu_SetSelectedName( this, AQAutoMount_Saved.color );
		UIDropDownMenu_SetSelectedID( this, AQMOUNT_DROPDOWN[AQAutoMount_Saved.color] );
	else
		UIDropDownMenu_SetSelectedID( this, 1 );
	end
	UIDropDownMenu_SetWidth(80);
	UIDropDownMenu_SetButtonWidth(24);
end

function AQMount_ColorDropDown_Init()
	local mounts = AQMount_Find();
	aqcolors = {};
	local info = {};
	for i=1, getn(mounts) do
		aqcolors[mounts[i][3]] = 1;
	end
	info.text = AQMOUNT_COLORS[1]
	info.func = AQMount_ColorDropDown_OnClick;
	if ( not AQAutoMount_Saved.color ) then
		this.checked = 1;
	end
	UIDropDownMenu_AddButton(info);
	for i=2, 6 do
		info = {};
		info.text = AQMOUNT_COLORS[i];
		if ( AQAutoMount_Saved.color == info.text ) then
			this.checked = 1;
		end
		if ( not aqcolors[info.text] ) then
			info.textR = 0.5;
			info.textG = 0.5;
			info.textB = 0.5;
		end
		info.func = AQMount_ColorDropDown_OnClick;
		UIDropDownMenu_AddButton(info);
	end
end

function AQMount_ColorDropDown_OnClick()
	local color = this:GetText();
	if ( color ~= AQMOUNT_RANDOM ) then
		AQAutoMount_Saved.color = color;
		prefcolor = color;
	else
		AQAutoMount_Saved.color = nil;
	end
	UIDropDownMenu_SetSelectedID(AQAutoMountFrameColorDropDown, this:GetID());
end

function AQMount_DisableCB()
	AQAutoMount_Saved.disable = this:GetChecked();
end
