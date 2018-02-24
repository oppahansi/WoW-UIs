-- ForteXorcist v1.959.8 by Xus 13-04-2010
local FW = FW;
local FWL = FW.L;
local HS = FW:Module("Healthstone");

local NUM_HS = 6;
local hs = FW:NEW2D();
local _G = _G;
local unpack = unpack;
local ipairs = ipairs;
local pairs = pairs;
local tonumber = tonumber;
local type = type;
local strformat = string.format;

local HealthstoneShow = nil;
local function HS_HealthstoneShow(self,auto)
	if not auto then HealthstoneShow = 1;end
	if FW.Settings.HealthstoneEnable and (not FW.Settings.HealthstoneAuto or FW.Saved.GROUPED) then
	
		if HealthstoneShow or not FWHSFrame:IsShown() then
		
			FWHSBackground:ClearAllPoints();
			if not InCombatLockdown() then
				HealthstoneShow = nil;
				FWHSFrame:Show();
				FWHSBackground:Show();

				FWHSFrame:SetWidth(FW.Settings.HealthstoneWidth+2*FW.BORDER);
				FWHSFrame:SetScale(FW.Settings.FWHSFrame.scale);
				
				FWHSBackground:SetWidth(FW.Settings.HealthstoneWidth+2*FW.BORDER);
				FWHSBackground:SetScale(FW.Settings.FWHSFrame.scale);
				
				FWHSFrame:SetFrameStrata(FW.Settings.HealthstoneStrata);
				FWHSBackground:SetFrameStrata(FW.Settings.HealthstoneStrata);
			
				FW:CorrectPosition(FWHSFrame);
			end
			FWHSFrame:SetAlpha(FW.Settings.FWHSFrame.alpha);
			FWHSBackground:SetAlpha(FW.Settings.FWHSFrame.alpha);
			

			FWHSBackground:SetBackdropColor(unpack(FW.Settings.HealthstoneBgColor));
			FWHSBackground:SetBackdropBorderColor(unpack(FW.Settings.HealthstoneBgColor));

			FWHSFrameAmount1:SetFont(FW.Settings.HealthstoneFont,FW.Settings.HealthstoneFontSize);
			FWHSFrameAmount2:SetFont(FW.Settings.HealthstoneFont,FW.Settings.HealthstoneFontSize);
			
			local r,g,b = unpack(FW.Settings.HealthstoneTextColor);
			for i=1,NUM_HS,1 do
				_G["FWHSBar"..i]:ClearAllPoints();
				
				_G["FWHSBar"..i.."Name"]:SetFont(FW.Settings.HealthstoneFont,FW.Settings.HealthstoneFontSize);
				_G["FWHSBar"..i.."Amount"]:SetFont(FW.Settings.HealthstoneFont,FW.Settings.HealthstoneFontSize);
				
				_G["FWHSBar"..i]:SetWidth(FW.Settings.HealthstoneWidth);
				_G["FWHSBar"..i]:SetHeight(FW.Settings.HealthstoneHeight);
				_G["FWHSBar"..i]:SetStatusBarTexture(FW.Settings.HealthstoneTexture);
				_G["FWHSBar"..i.."Back"]:SetTexture(FW.Settings.HealthstoneTexture);
				_G["FWHSBar"..i.."Name"]:SetTextColor(r,g,b);
				_G["FWHSBar"..i.."Amount"]:SetTextColor(r,g,b);

				_G["FWHSBar"..i.."Spark"]:SetWidth(FW.Settings.HealthstoneHeight);
				_G["FWHSBar"..i.."Spark"]:SetHeight(FW.Settings.HealthstoneHeight*2);
			end
			
			if FW.Settings.HealthstoneExpand then
				FWHSBackground:SetPoint("BOTTOMRIGHT", FWHSFrame, "BOTTOMRIGHT", 0, 0);
				FWHSBar1:SetPoint("BOTTOMLEFT", FWHSBackground, "BOTTOMLEFT", FW.BORDER, 18);

				for i=2,NUM_HS,1 do
					_G["FWHSBar"..i]:SetPoint("BOTTOMLEFT", _G["FWHSBar"..(i-1)], "TOPLEFT", 0, FW.Settings.HealthstoneSpace);
				end
			else
				FWHSBackground:SetPoint("TOPLEFT", FWHSFrame, "TOPLEFT", 0, 0);
				FWHSBar1:SetPoint("TOPLEFT", FWHSBackground, "TOPLEFT", FW.BORDER, -18);

				for i=2,NUM_HS,1 do
					_G["FWHSBar"..i]:SetPoint("TOPLEFT", _G["FWHSBar"..(i-1)], "BOTTOMLEFT", 0, -FW.Settings.HealthstoneSpace);
				end
			end
		end
	else 
		if (HealthstoneShow or FWHSFrame:IsShown()) and not InCombatLockdown() then
			HealthstoneShow = nil;
			FWHSFrame:Hide();
			FWHSBackground:Hide();
		end
	end
end

local function ColorVal(v)
	return FW:MixColors(v,FW.Settings.HealthstoneMinColor,FW.Settings.HealthstoneMaxColor);
end

local function HS_DrawHealthstone()
	if not FWHSFrame:IsShown() then return; end
	local n=0;
	local Bar;
	for i=1, NUM_HS, 1 do
		Bar = _G["FWHSBar"..i];
		if FW.Settings.HealthstoneDetails and (not FW.Settings.HealthstoneDetailsAuto or FW.Saved.GROUPED) and i <= hs.rows then
			local t1,t2,t3,t4,t5 = unpack(hs[i]);
			if t2 == 0 then
				t2 = 1;
			end
			Bar.title = t3..t5;
			Bar.tip = t4;
			local val = t1/t2;
			local r,g,b = ColorVal(val);
			Bar:SetStatusBarColor(r,g,b);
			_G["FWHSBar"..i.."Back"]:SetVertexColor(r,g,b,0.5);
			_G["FWHSBar"..i.."Name"]:SetText(t3);
			_G["FWHSBar"..i.."Amount"]:SetText(t1);
			Bar:SetValue(val);
			_G["FWHSBar"..i.."Spark"]:SetPoint("CENTER", Bar, "LEFT", val*Bar:GetWidth(), 0);
			if FW.Settings.SparkEnable then
				_G["FWHSBar"..i.."Spark"]:SetVertexColor(unpack(FW.Settings.SparkColor));
			else
				_G["FWHSBar"..i.."Spark"]:SetVertexColor(r,g,b);
			end
			n=n+1;
			Bar:Show();
		else
			Bar:Hide();
		end
	end
	if n>0 then
		FWHSBackground:SetHeight(21+(FW.Settings.HealthstoneHeight+FW.Settings.HealthstoneSpace)*n-FW.Settings.HealthstoneSpace);
	else
		FWHSBackground:SetHeight(20);
	end
end

local function HS_SetHSButton()
	local t1,t3 = FW:BestHealthstone();
	local t2,wrank,id = FW:GotHealthstone();
	local t4=0;
	if id ~= 0 then
		t4 = 1;
	else
		t4 = 0;
	end
	FWHSFrameAmount1:SetText("x"..t4);	
	if not InCombatLockdown() then -- update the use function in case it wasnt loaded properly due to combat or whatever
		if id ~= 0 then FWHSButton:SetAttribute("*item2", t2 ); end
	end
	local t5 = FWHSButton:GetAttribute("*","item","2");
	if t5 and FW:GotThisHealthstone(t5) then
		FWHSButton.title=strformat(FWL.USE_,t5);
		--FWHSButton.tip=strformat(FWL.RIGHT_CLICK_TO_USE_,t5).."\n"..strformat(FWL.LEFT_CLICK_TO_CREATE_,t1);
		FWHSButton.tip=wrank.."\n\n"..strformat(FWL.RIGHT_CLICK_TO_USE_,t5);
		
		FWHSButton:SetNormalTexture("Interface\\AddOns\\Forte_Core\\Textures\\HS2");
	else
		FWHSButton.title=strformat(FWL.CREATE_,t1);
		FWHSButton.tip=FW.ID_HEALTHSTONE[t3][2].."\n\n"..strformat(FWL.LEFT_CLICK_TO_CREATE_,t1);
		
		FWHSButton:SetNormalTexture("Interface\\AddOns\\Forte_Core\\Textures\\HS3");
	end

end
local hst = {};
local hss = {};
local erase = FW.ERASE;
local function HS_ProcessHealthstone()
	if FWHSFrame:IsShown() then
		hs:erase();
		erase(hst);
		erase(hss);
		--[[local t2,t3,t4 = select(2,FW:BestHealthstone()),0,0; 
		for k, v in ipairs(FW.Healthstone) do -- hs types to track
			local t5 = t2;
			t4 = 0;
			local t1 = 0;
			local s1 = FWL.NOBODY;
			local s2 = "";
			-- make 'made by' info
			for name, data in pairs(FW.Saved.Shards) do
				if data[2] == FW.Saved.Update then -- get active warlocks only
					
					if (FW:HealthstoneSpecc(name)-v)%3==0 then -- the right specc!
						if s2 == "" then
							s2 = s2..name;
						else
							s2 = s2..","..name;
						end
					end
				end
			end
			-- count missing
			for name, data in pairs(FW.Saved.Healthstone) do
				if data ~= -1 then -- players that i have info on
					t4=t4+1;
					if data > 0 then
						t1 = t1 + data;
						if s1==FWL.NOBODY then
							s1=name
						else
							s1 = s1.."\n"..name;
						end
					end
				end
			end
			t3 = t3 + t1;
			if not FW.Settings.HealthstoneTotal then
				hs:insert(t1,t4,FW.ID_HEALTHSTONE[v][2],s1,"\n"..FWL.MADE_BY_.." "..s2);
			end
		end]]
		local players = 0;
		local stones = 0;
		local missing = "";
		for name, data in pairs(FW.Saved.RaidStatus) do
			if data[1] >= FW.FLAG_NORMAL and data[4] and type(data[4])=="string" then -- only count people that are online and have fx
				players = players + 1;
				local hs = FW.Saved.Healthstone[name];
				if hs and hs > 0 then
					stones = stones + 1;
					if hst[ hs ] then
						hst[ hs ] =  hst[ hs ] + 1;
					else
						hst[ hs ] = 1;
						hss[ hs ] = ""; -- create list of warlocks that can make this hs type
						for n, d in pairs(FW.Saved.RaidStatus) do
							if data[3] == "WARLOCK" then
								local t = FW:HealthstoneSpecc(name);
								if t>=hs and (t-hs)%3 == 0 then
									hss[ hs ] = "\n"..n;
								end
							end
						end
						if hss[ hs ] == "" then
							hss[ hs ] = "\n"..FWL.NOBODY;
						end
					end
				else
					missing = missing.."\n"..name;
				end
			end
		end
		if not FW.Settings.HealthstoneTotal then
			local total = FW:Size(hst);
			for t, v in pairs(hst) do
				hs:insert(v,stones,FW.ID_HEALTHSTONE[t][2],strformat(FWL.MADE_BY_,hss[t]),"");
			end
		end
		if missing == "" then
			missing = "\n"..FWL.NOBODY;
		end
		hs:insert(stones,players,FWL.TOTAL,strformat(FWL.MISSING_,missing),"");
		FWHSFrameAmount2:SetText("x"..players-stones);
		HS_DrawHealthstone();
		HS_SetHSButton();
	end
end

local function HS_HealthstoneReceived(id,who)
	--FW:Show("hs "..id.." x"..n.." from "..who);
	FW.Saved.Healthstone[who] = id;
end

--globally accessable

function FW:HSFrame_OnClick(button)
	if FW:Moved() then return; end
	
	if button == "LeftButton" then
		if FW.Settings.HealthstoneDetails then
			if FW.Settings.HealthstoneTotal then
				FW.Settings.HealthstoneDetails = false;
			else
				FW.Settings.HealthstoneTotal = true;
			end
		
		else
			FW.Settings.HealthstoneDetails = true;
			FW.Settings.HealthstoneTotal = false;
		end
		HS_DrawHealthstone();
		FW:RefreshOptions();
	else
		FW:ScrollTo(FWL.HEALTHSTONE_SPY);
	end
	PlaySound("igMainMenuOptionCheckBoxOn");
end

function FW:HealthstoneCheck() -- clicked from ui (and time-based)
	FW:SendData(FW.GET_HEALTHSTONE);
end

function FW:HealthstoneOnload()
	-- includes a quick 2.00 fix!
	FWHSFrame.Update = HS_HealthstoneShow;
	FW:RegisterFrame("FWHSFrame",FWHSFrame,1);

	FW:RegisterButtonPress("HS_CREATEHEALTHSTONE","FWHSButton","LeftButton");
	FW:RegisterButtonPress("HS_USEHEALTHSTONE","FWHSButton","RightButton");
	FW:RegisterButtonPress("HS_GETUPDATE","FWSWButton","LeftButton");
	FW:RegisterButtonPress("HS_CREATESOULWELL","FWSWButton","RightButton");
	FW:RegisterButtonPress("HS_OPTIONS","FWHSFrame","RightButton");
	
	FW:RegisterVariablesEvent(function()
		FW:RegisterTimedEvent("HealthstoneInterval",	HS_ProcessHealthstone);
		FW:RegisterTimedEvent("HealthstoneInterval",	function() FWHSFrame:Update(1); end);
	end);
	
	FW:RegisterOnEnterCombat(HS_SetHSButton); -- Hopefully set correct spell just before the buttons are locked if loading up in combat, if it failed during loading the button somehow

	FW:RegisterEnterPartyRaid( function(joined) if joined then FW:HealthstoneCheck();end end );
	
	FW:RegisterMessage(FW.SEND_HEALTHSTONE,
		function(m,f) 
			local _,_,t1 = string.find(m,"^(%d+)$");
			t1=tonumber(t1);
			if t1 then
				HS_HealthstoneReceived(t1,f);
				return 1;
			end
		end,
	nil);
end

FW:SetMainCategory(FWL.HEALTHSTONE_SPY,FW.ICON_HS,7,"HEALTHSTONE","FWHSFrame");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FWL.COMBAT_HINT);
		FW:RegisterOption(FW.INF,2,FW.NON,FWL.ORA_HINT);
		
	FW:SetSubCategory(FWL.BASIC,FW.ICON_BASIC,2);
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.ENABLE,		FWL.HS_ENABLE_TT,	"HealthstoneEnable",		HS_HealthstoneShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.AUTO_HIDE,	FWL.AUTO_HIDE_TT,	"HealthstoneAuto",	HS_HealthstoneShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.AUTO_MINIMIZE,	FWL.AUTO_MINIMIZE_TT,	"HealthstoneDetailsAuto");
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.SHOW_BARS,	FWL.SHOW_BARS_TT,	"HealthstoneDetails");
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.EXPAND_UP,	FWL.EXPAND_UP_TT,	"HealthstoneExpand",	HS_HealthstoneShow);
		
	FW:SetSubCategory(FWL.SPECIFIC,FW.ICON_SPECIFIC,3);	
		FW:RegisterOption(FW.CHK,1,FW.NON,"Only show total","Only show the bar with the total number of Healthstones.",	"HealthstoneTotal");
		--FW:RegisterOption(FW.CHK,1,FW.NON,FWL.SHOW_MISSING,	FWL.SHOW_MISSING_TT,	"HealthstoneMissing",	HS_DrawHealthstone);
		--FW:RegisterOption(FW.NUM,1,FW.NON,FWL.NUM_TYPES,		FWL.NUM_TYPES_TT,		"HealthstoneNumber",nil,0);
		--FW:RegisterOption(FW.CHK,1,FW.NON,FWL.ONLY_TOP_RANK,	FWL.ONLY_TOP_RANK_TT,	"HealthstoneTopRank");

	FW:SetSubCategory(FWL.SIZING,FW.ICON_SIZE,4);	
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.BAR_WIDTH,			"",	"HealthstoneWidth",	HS_HealthstoneShow,0);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.BAR_HEIGHT,			"",	"HealthstoneHeight",	HS_HealthstoneShow,0);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.BAR_SPACING,			"",	"HealthstoneSpace",	HS_HealthstoneShow,0);
		
	FW:SetSubCategory(FWL.BAR_COLORING,FW.ICON_FILTER,5);	
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.LITTLE_HS,			"",	"HealthstoneMin");
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.MANY_HS,				"",	"HealthstoneMax");
		
	FW:SetSubCategory(FWL.APPEARANCE,FW.ICON_APPEARANCE,6);	
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.BAR_TEXT,			"",	"HealthstoneText",	HS_HealthstoneShow);
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.FRAME_BACKGROUND,	"",	"HealthstoneBg",	HS_HealthstoneShow);
		FW:RegisterOption(FW.FNT,2,FW.NON,FWL.BAR_FONT,			"",	"HealthstoneFont",	HS_HealthstoneShow);
		FW:RegisterOption(FW.TXT,2,FW.NON,FWL.BAR_TEXTURE,			"",	"HealthstoneTexture",	HS_HealthstoneShow);

FW:SetMainCategory(FWL.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
	FW:SetSubCategory(FWL.HEALTHSTONE_SPY,FW.ICON_DEFAULT,2);
		FW:RegisterOption(FW.MS0,1,FW.NON,FWL.FRAME_LEVEL,	"",	"HealthstoneStrata", HS_HealthstoneShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.HEALTHSTONE_CHECK_TIME,		"",	"HealthstoneCheckTime",nil,10);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.HEALTHSTONE_DRAW_INTERVAL,	"",	"HealthstoneInterval",nil,0.5,5);

		
FW.Default.HealthstoneInterval = 2;
FW.Default.HealthstoneCheckTime = 60;
FW.Default.HealthstoneStrata = FW.Default.Strata;

FW.Default.HealthstoneTextColor =	{1.00,1.00,1.00};
FW.Default.HealthstoneBgColor =		{0.31,0.00,0.62,0.75};
FW.Default.HealthstoneMinColor = 	{0.93,1.00,0.00};
FW.Default.HealthstoneMaxColor = 	{0.53,1.00,0.00};

FW.Default.HealthstoneFont = FW.Default.Font;
FW.Default.HealthstoneFontSize = FW.Default.FontSize;
FW.Default.HealthstoneTexture = FW.Default.Texture;
FW.Default.HealthstoneEnable = true;
FW.Default.HealthstoneDetails = true;
FW.Default.HealthstoneDetailsAuto = false;
FW.Default.HealthstoneAuto = false;
FW.Default.HealthstoneMax = 5;
FW.Default.HealthstoneWidth = 100;
FW.Default.HealthstoneHeight = 12;
FW.Default.HealthstoneSpace = 1;
FW.Default.HealthstoneExpand = false;
FW.Default.HealthstoneMissing = true;
FW.Default.HealthstoneTotal = false;

BINDING_HEADER_HEALTHSTONE = FWL.HEALTHSTONE_SPY;
BINDING_NAME_HS_CREATEHEALTHSTONE = FW:SpellName(47878);
BINDING_NAME_HS_USEHEALTHSTONE = FWL.USE_HEALTHSTONE;
BINDING_NAME_HS_GETUPDATE = FWL.UPDATE_NOW;
BINDING_NAME_HS_CREATESOULWELL = FW:SpellName(60429);
BINDING_NAME_HS_OPTIONS = FWL.TOGGLE_OPTIONS;