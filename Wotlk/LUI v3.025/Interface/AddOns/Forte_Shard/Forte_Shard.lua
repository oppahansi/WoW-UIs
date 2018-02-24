-- ForteXorcist v1.959.8 by Xus 13-04-2010
local FW = FW;
local FWL = FW.L;
local SH = FW:Module("Shard");
local _G = _G;
local unpack = unpack;

local MaxShards = 32;
local sh = FW:NEW2D();
local NUM_SHARDS = 10;

local SORT_SHARD_ORDER =	{5,2};
local SORT_SHARD_ASC =	{false,true};

local function SH_ShardShow(self,auto) -- with auto set, will only refresh the frame if it's not hidden/shown properly yet

	if FW.Settings.ShardEnable and (not FW.Settings.ShardAuto or FW.Saved.GROUPED) then
	
		if not auto or not FWSHFrame:IsShown() then
		
			FWSHFrame:Show();
			FWSHFrame:SetAlpha(FW.Settings.FWSHFrame.alpha);
			FWSHBackground:Show();
			FWSHBackground:SetAlpha(FW.Settings.FWSHFrame.alpha);
			FWSHBackground:ClearAllPoints();
			
			FWSHFrame:SetWidth(FW.Settings.ShardWidth+2*FW.BORDER);
			FWSHBackground:SetWidth(FW.Settings.ShardWidth+2*FW.BORDER);
			FWSHFrame:SetScale(FW.Settings.FWSHFrame.scale);
			FWSHBackground:SetScale(FW.Settings.FWSHFrame.scale);
			
			FW:CorrectPosition(FWSHFrame);
			
			FWSHBackground:SetBackdropColor(unpack(FW.Settings.ShardBgColor));
			FWSHBackground:SetBackdropBorderColor(unpack(FW.Settings.ShardBgColor));

			FWSHFrameAmount:SetFont(FW.Settings.ShardFont,FW.Settings.ShardFontSize);
			FWSHFrameInfo:SetFont(FW.Settings.ShardFont,FW.Settings.ShardFontSize);
			
			FWSHFrame:SetFrameStrata(FW.Settings.ShardStrata);
			FWSHBackground:SetFrameStrata(FW.Settings.ShardStrata);
			
			local r,g,b = unpack(FW.Settings.ShardTextColor);
			for i=1,NUM_SHARDS,1 do
				_G["FWSHBar"..i]:ClearAllPoints();
				
				_G["FWSHBar"..i.."Name"]:SetFont(FW.Settings.ShardFont,FW.Settings.ShardFontSize);
				_G["FWSHBar"..i.."Amount"]:SetFont(FW.Settings.ShardFont,FW.Settings.ShardFontSize);
				
				_G["FWSHBar"..i]:SetWidth(FW.Settings.ShardWidth);
				_G["FWSHBar"..i]:SetHeight(FW.Settings.ShardHeight);
				_G["FWSHBar"..i]:SetStatusBarTexture(FW.Settings.ShardTexture);
				_G["FWSHBar"..i.."Back"]:SetTexture(FW.Settings.ShardTexture);
				_G["FWSHBar"..i.."Name"]:SetTextColor(r,g,b);
				_G["FWSHBar"..i.."Amount"]:SetTextColor(r,g,b);

				_G["FWSHBar"..i.."Spark"]:SetWidth(FW.Settings.ShardHeight);
				_G["FWSHBar"..i.."Spark"]:SetHeight(FW.Settings.ShardHeight*2);

			end
			
			if FW.Settings.ShardExpand then
				FWSHBackground:SetPoint("BOTTOMRIGHT", FWSHFrame, "BOTTOMRIGHT", 0, 0);
				FWSHBar1:SetPoint("BOTTOMLEFT", FWSHBackground, "BOTTOMLEFT", FW.BORDER, 18);

				for i=2,NUM_SHARDS,1 do
					_G["FWSHBar"..i]:SetPoint("BOTTOMLEFT", _G["FWSHBar"..(i-1)], "TOPLEFT", 0, FW.Settings.ShardSpace);
				end
			else
				FWSHBackground:SetPoint("TOPLEFT", FWSHFrame, "TOPLEFT", 0, 0);
				FWSHBar1:SetPoint("TOPLEFT", FWSHBackground, "TOPLEFT", FW.BORDER, -18);

				for i=2,NUM_SHARDS,1 do
					_G["FWSHBar"..i]:SetPoint("TOPLEFT", _G["FWSHBar"..(i-1)], "BOTTOMLEFT", 0, -FW.Settings.ShardSpace);
				end
			end
		end
	else 
		if not auto or FWSHFrame:IsShown() then
	
			FWSHFrame:Hide();
			FWSHBackground:Hide();
		end
	end
end

local function ColorVal(v,flag)
	
	if flag == FW.FLAG_NORMAL then
		return FW:MixColors(v,FW.Settings.ShardMinColor,FW.Settings.ShardMaxColor);
	elseif flag == FW.FLAG_DEAD then
		return unpack(FW.Settings.ShardDeadColor);
	elseif flag == FW.FLAG_OFFLINE then
		return unpack(FW.Settings.ShardOfflineColor);
	elseif flag == FW.FLAG_UNKNOWN then
		return unpack(FW.Settings.ShardUnknownColor);
	end
end

local function SH_DrawShard()
	if not FWSHFrame:IsShown() then return; end
	local n=0;
	local Bar;
	for i=1, NUM_SHARDS, 1 do
		Bar = _G["FWSHBar"..i];
		if FW.Settings.ShardDetails and (not FW.Settings.ShardDetailsAuto or FW.Saved.GROUPED) and i <= FW.Settings.ShardMax and i <= sh.rows then
			local t1,t2,t3,t4 = unpack(sh[i]);
			local r,g,b = ColorVal(t1,t4);
			
			Bar:SetStatusBarColor(r,g,b);
			_G["FWSHBar"..i.."Back"]:SetVertexColor(r,g,b,0.5);
			
			_G["FWSHBar"..i.."Name"]:SetText(t2);
			_G["FWSHBar"..i.."Amount"]:SetText(t3);

			Bar:SetValue(t1);
			_G["FWSHBar"..i.."Spark"]:SetPoint("CENTER", Bar, "LEFT", t1*Bar:GetWidth(), 0);
			if FW.Settings.SparkEnable then
				_G["FWSHBar"..i.."Spark"]:SetVertexColor(unpack(FW.Settings.SparkColor));
			else
				_G["FWSHBar"..i.."Spark"]:SetVertexColor(r,g,b);
			end
			n=n+1;
			Bar:Show();
		else
			Bar:Hide();
		end

	end
	if n>0 then
		FWSHBackground:SetHeight(21+(FW.Settings.ShardHeight+FW.Settings.ShardSpace)*n-FW.Settings.ShardSpace);
	else
		FWSHBackground:SetHeight(20);
	end
end

local function SH_ProcessShard()
	if FW.Settings.ShardEnable then--no combat problems
		sh:erase();
		local t4 = 0;
		FWSHFrameAmount:SetText("x"..(FW.Saved.Shards[FW.PLAYER] or 0));
		for name, data in pairs(FW.Saved.RaidStatus) do
			local t3 = data[1];
			if t3 >= FW.FLAG_OFFLINE and data[3] == "WARLOCK" then
				local t1 = FW.Saved.Shards[name] or -1;
				local t2 = t1/MaxShards;
				if t1 == -1 then -- no data
					t1 = "??";
					t2=1;
					if t3 == FW.FLAG_NORMAL then
						t3 = FW.FLAG_UNKNOWN;
					end
				else
					t4 = t4 + t1;
				end
				if t2 > 1 then t2 = 1 end;
				sh:insert(t2,name,t1,t3,num);
			end
		end
		FWSHFrameInfo:SetText(string.format(FWL._TOTAL,t4));
		sh:sort(SORT_SHARD_ORDER,SORT_SHARD_ASC); -- sort viewable data

		SH_DrawShard();
	end
end

local function SH_ShardsReceived(n,who)
	if who ~= FW.PLAYER then
		FW.Saved.Shards[who] = n;
	end
end

--globally accessable

function FW:SHFrame_OnClick(button)
	if FW:Moved() then return; end
	if button == "LeftButton" then
		FW.Settings.ShardDetails = not FW.Settings.ShardDetails;
		SH_DrawShard();
		FW:RefreshOptions();
	else
		FW:ScrollTo(FWL.SHARD_SPY);
	end
	PlaySound("igMainMenuOptionCheckBoxOn");
end

function FW:ShardCheck() -- clicked from ui (and time-based)
	FW:SendData(FW.GET_SHARDS);
end

function FW:ShardOnload()
	-- includes a quick 2.00 fix!
	FWSHFrame.Update = SH_ShardShow;
	FW:RegisterFrame("FWSHFrame",FWSHFrame);
	
	FW:RegisterButtonPress("SH_GETUPDATE","FWSHButton","LeftButton");
	FW:RegisterButtonPress("SH_OPTIONS","FWSHFrame","RightButton");

	FW:RegisterVariablesEvent(function()
		FW:RegisterTimedEvent("ShardInterval",		SH_ProcessShard);
		FW:RegisterTimedEvent("ShardInterval",		function() FWSHFrame:Update(1); end);
	end);
	
	FW:RegisterEnterPartyRaid( function(joined) if joined then FW:ShardCheck();end end );
	
	FW:RegisterMessage(FW.SEND_SHARDS,
		function(m,f) 
			SH_ShardsReceived(tonumber(m),f);
			return 1;
		end,
	nil);
	--FW:Show("Shard Module Loaded");
end
FW:SetMainCategory(FWL.SHARD_SPY,FW.ICON_SH,6,"SHARD","FWSHFrame");
	FW:SetSubCategory(FW.NIL,FW.NIL,1);
		FW:RegisterOption(FW.INF,2,FW.NON,FWL.ORA_HINT);
		
	FW:SetSubCategory(FWL.BASIC,FW.ICON_BASIC,2);
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.ENABLE,		FWL.SH_ENABLE_TT,	"ShardEnable",		SH_ShardShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.AUTO_HIDE,	FWL.AUTO_HIDE_TT,	"ShardAuto",		SH_ShardShow);
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.AUTO_MINIMIZE,FWL.AUTO_MINIMIZE_TT,	"ShardDetailsAuto");
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.SHOW_BARS,	FWL.SHOW_BARS_TT,	"ShardDetails");
		FW:RegisterOption(FW.CHK,1,FW.NON,FWL.EXPAND_UP,	FWL.EXPAND_UP_TT,	"ShardExpand",		SH_ShardShow);

--	FW:SetSubCategory(FWL.SPECIFIC,FW.ICON_SPECIFIC,3);	
	
	FW:SetSubCategory(FWL.SIZING,FW.ICON_SIZE,4);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.BAR_WIDTH,		"",	"ShardWidth",		SH_ShardShow,0);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.BAR_HEIGHT,		"",	"ShardHeight",		SH_ShardShow,0);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.BAR_SPACING,		"",	"ShardSpace",		SH_ShardShow,0);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.MAX_SHOWN,		"",	"ShardMax",			nil,0,NUM_SHARDS);	
	
	FW:SetSubCategory(FWL.BAR_COLORING,FW.ICON_FILTER,5);	
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.LITTLE_SHARDS,	"",	"ShardMin");
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.MANY_SHARDS,		"",	"ShardMax");
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.UNKNOWN_N,		"",	"ShardUnknown");
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.DEAD,				"",	"ShardDead");
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.OFFLINE,			"",	"ShardOffline");
		
	FW:SetSubCategory(FWL.APPEARANCE,FW.ICON_APPEARANCE,6);	
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.BAR_TEXT,			"",	"ShardText",	SH_ShardShow);
		FW:RegisterOption(FW.COL,1,FW.NON,FWL.FRAME_BACKGROUND,	"",	"ShardBg",		SH_ShardShow);
		FW:RegisterOption(FW.FNT,2,FW.NON,FWL.BAR_FONT,			"",	"ShardFont",	SH_ShardShow);
		FW:RegisterOption(FW.TXT,2,FW.NON,FWL.BAR_TEXTURE,		"",	"ShardTexture",	SH_ShardShow);
		
FW:SetMainCategory(FWL.ADVANCED,FW.ICON_DEFAULT,99,"DEFAULT");
	FW:SetSubCategory(FWL.SHARD_SPY,FW.ICON_DEFAULT,2);
		FW:RegisterOption(FW.MS0,1,FW.NON,FWL.FRAME_LEVEL,	"",	"ShardStrata", SH_ShardShow);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.SHARD_CHECK_TIME,		"",	"ShardCheckTime",nil,10);
		FW:RegisterOption(FW.NUM,1,FW.NON,FWL.SHARD_DRAW_INTERVAL,	"",	"ShardInterval",nil,0.5,5);

		
FW.Default.ShardInterval = 2;
FW.Default.ShardCheckTime = 60;
FW.Default.ShardStrata = FW.Default.Strata;

FW.Default.ShardFont = FW.Default.Font;
FW.Default.ShardFontSize = FW.Default.FontSize;
FW.Default.ShardTexture = FW.Default.Texture;
FW.Default.ShardEnable = true;
FW.Default.ShardDetails = true;
FW.Default.ShardDetailsAuto = false;
FW.Default.ShardAuto = false;
FW.Default.ShardMax = 5;
FW.Default.ShardWidth = 100;
FW.Default.ShardHeight = 12;
FW.Default.ShardSpace = 1;
FW.Default.ShardExpand = false;

FW.Default.ShardBgColor = 	{0.31,0.00,0.62,0.75};
FW.Default.ShardMinColor = 	{1.00,0.00,0.60};
FW.Default.ShardMaxColor = 	{0.64,0.21,0.93};
FW.Default.ShardUnknownColor = 	{1.00,0.00,0.60};
FW.Default.ShardDeadColor = 	{0.60,0.60,0.60};
FW.Default.ShardOfflineColor = 	{0.40,0.40,0.40};
FW.Default.ShardTextColor = 	{1.00,1.00,1.00};

BINDING_HEADER_SHARD = FWL.SHARD_SPY;
BINDING_NAME_SH_GETUPDATE = FWL.UPDATE_NOW;
BINDING_NAME_SH_OPTIONS = FWL.TOGGLE_OPTIONS;