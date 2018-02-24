


DENNIE_CCP_INOPTION = false;

local DENNIE_CCP_INCOMBAT = 0;
local DENNIE_CCP_COLORDELAY = 0;

local CCP_lastupdate = 0;

local CCP_InitFinished = 0;
local CCP_HelpFinished = 0;

local CCP_CPPOS = {{-73.4,-189},{-39,-189},{-5,-189},{28,-189},{61.5,-189}};

CCP_PlayerCfg = nil;

function CCP_Debug(msg)
	DEFAULT_CHAT_FRAME:AddMessage(msg);
end

function CCP_SetValue(opt,mEvt)
--this:RegisterForClicks("LeftButtonUp", "RightButtonUp");	

	
end

function CCP_MouseUp(opt)
	if ( this.isMoving ) then
		this:StopMovingOrSizing();
		this.isMoving = false;
		if opt == "TBOptions" or opt == "TBTextOptions" then return;end
		local theframe = getglobal(opt);
		local theWorldframe = getglobal("UIParent");
		local screenW = (theWorldframe:GetRight() - theWorldframe:GetLeft()) / 2;
		local screenH = (theWorldframe:GetTop() - theWorldframe:GetBottom()) / 2;
		local tx = theframe:GetLeft() + (theframe:GetRight() - theframe:GetLeft()) / 2 - (screenW + CCP_Get("CCP_GlobalX"));
		local ty = theframe:GetBottom() + (theframe:GetTop() - theframe:GetBottom()) / 2 - (screenH + CCP_Get("CCP_GlobalY"));
		if theframe.attPoint then 
			if theframe.attPoint == "BOTTOM" then ty = theframe:GetBottom() - (screenH + CCP_Get("CCP_GlobalY"));end
		end
		CCP_Set(opt.."",{x= tx,y = ty});
		CCP_Debug(opt.." "..ty);
	end
end

function CCP_MouseDown(button)
	if button == "LeftButton" then
		this:StartMoving();
		this.isMoving = true;		
	end
end

function CCP_ShowOption()
	PlaySound("igMainMenuOpen");
	ShowUIPanel(TBOptions);
	--ShowUIPanel(TBTextOptions);
	local tbopt = getglobal("CCPOptionsSave");
	tbopt:Show();

	local tframe;
	for i = 1,5 do
		tframe = getglobal("CCP_CP_"..i);
		tframe:EnableMouse(true);
		tframe:Show();
	end
	
	DENNIE_CCP_INOPTION = true;
end

function CCP_Reset()
	CCP_CONFIG[UnitName("player").." of "..GetCVar("realmName")] = nil;
	CCP_CONFIG[UnitName("player").." of "..GetCVar("realmName")] = CCP_TableCopy(CCP_DEFAULT_CONFIG);
	CCP_InitAll();
	CCP_HideOption();
end

function CCP_HideOption()
	DENNIE_CCP_INOPTION = false;
	PlaySound("igMainMenuOpen");
	HideUIPanel(TBOptions);
	--HideUIPanel(TBTextOptions);
	CCP_InitFinished = 0;
	CCP_InitAll();
	
	local tframe;
	for i = 1,5 do
		tframe = getglobal("CCP_CP_"..i);
		tframe:EnableMouse(false);
		tframe:Hide();
	end
end

function CCP_QuickInitCP(name,x,y,id)
	local buffbutton = getglobal(name);
	local texture = getglobal(name.."_Texture");	
	texture:SetAlpha(1);	
	buffbutton:Hide();
	buffbutton:SetHeight(CCP_TEXTURE_CP["CCP_TEXTURE_CP"..id.."_HEIGHT"]);
	buffbutton:SetWidth(CCP_TEXTURE_CP["CCP_TEXTURE_CP"..id.."_WIDTH"]);
	buffbutton:ClearAllPoints();
	buffbutton:SetPoint("CENTER", "UIParent","CENTER",x,y);	
	buffbutton:EnableMouse(false);
	texture:SetTexture("Interface\\AddOns\\ColorComboPoints\\CustomTextures\\Cp"..id);
end

function CCP_Main_OnLoad()
	
	this:RegisterEvent("PLAYER_COMBO_POINTS");
	this:RegisterEvent("PLAYER_TARGET_CHANGED");
	
	this:RegisterEvent("PLAYER_ENTERING_WORLD");
	this:RegisterEvent("VARIABLES_LOADED");
	this:RegisterEvent("ADDON_LOADED");
	
	-- Add Slash Commands
	SlashCmdList["CCP"] = CCP_ShowOption;
	SLASH_CCP1 = "/ccp";
	SLASH_CCP2 = "/colorcombopoints";
end

function CCP_UpdataCp()
	local cpC = GetComboPoints();
	for i = 1,5 do
		local texture = getglobal("CCP_CP_"..i);
		if i <= cpC then
			texture:Show();
		else
			texture:Hide();
		end
	end
end

function CCP_InitAll()
	if CCP_InitFinished == 1 and event ~="PLAYER_ENTERING_WORLD" then return;end

	DENNIE_CCP_INCOMBAT = 0;
	--DENNIE_CCP_INOPTION = false;
	
	if CCP_CONFIG == nil then
		--get a new clean one
		CCP_CONFIG = {};
	end
	
	CCP_PlayerCfg = CCP_GetConfig();

	for i = 1,5 do
		CCP_QuickInitCP("CCP_CP_"..i,CCP_Get("CCP_CP_"..i).x + CCP_Get("CCP_GlobalX"),CCP_Get("CCP_CP_"..i).y + CCP_Get("CCP_GlobalY"),i);
	end

	
	CCP_InitFinished = 1;
end

function CCP_OnEvent()
	if (event == "VARIABLES_LOADED") or ( event == "ADDON_LOADED" and arg1 == "TurboStatus" ) or (event=="PLAYER_ENTERING_WORLD") then
		CCP_InitAll();
		return;
	end
	
	if CCP_Get("CCP_ShowMode") == 3 then
		return;
	end
	
	if event == "PLAYER_COMBO_POINTS" then
		CCP_UpdataCp();
		return;
	end
	
	if CCP_Get("CCP_ShowMode") == 1 and DENNIE_CCP_INCOMBAT == 0 then return;end
	
	if event=="PLAYER_TARGET_CHANGED" then	
		CCP_UpdataCp();
		return;	
	end
	
end

function CCP_OnUpdata()
	if CCP_Get("CCP_ShowMode") == 1 and DENNIE_CCP_INCOMBAT == 0 then return;end
	if CCP_Get("CCP_ShowMode") == 3 then
		return;
	end
end

function CCP_TableCopy(t)
	local new = {};
	local i, v = next(t, nil);
	while i do
	if type(v)=="table" then 
		v=CCP_TableCopy(v);
	end 
	new[i] = v;
	i, v = next(t, i);
	end
	return new;
end

function CCP_Get(opt)
	if (CCP_PlayerCfg ~= nil) and (CCP_PlayerCfg[opt] ~= nil) then
		return CCP_PlayerCfg[opt];
	else
		if CCP_DEFAULT_CONFIG[opt] ~= nil then return CCP_DEFAULT_CONFIG[opt];else return 0;end
	end
end

function CCP_Set(option, newVal)
	if (CCP_PlayerCfg ~= nil) then
		if ( option ) then
			CCP_PlayerCfg[option] = newVal;
		end
	end
end

function CCP_GetConfig()
	if (CCP_CONFIG[UnitName("player").." of "..GetCVar("realmName")] == nil) then
		CCP_CONFIG[UnitName("player").." of "..GetCVar("realmName")] = CCP_TableCopy(CCP_DEFAULT_CONFIG);
	end
	return CCP_CONFIG[UnitName("player").." of "..GetCVar("realmName")];
end

