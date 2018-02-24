-- ForteXorcist v1.959.5 by Xus 12-03-2010
local FW = FW;
local FWL = FW.L;
local strfind = strfind;
local strformat = string.format;
local gsub = string.gsub;
local abs = math.abs;
local ipairs = ipairs;
local pairs = pairs;
local unpack = unpack;
local select = select;
local GetTime = GetTime;
local _G = _G;
local erase = FW.ERASE;

local optionsbuilt = false;
local filterdropdown;
local texturedropdown;
local fontdropdown;
local sounddropdown;
local backdropdropdown;
local listdropdown;

local Anchors = {};
local FW_Options = {};
FW.Options = FW_Options;
local Frames = FW.Frames;

local MAIN_DATA_TABLE = 8;
local NEW_INSTANCE_STRING = " + ";

FW.NIL = 0;
FW.CHK = 1;
FW.MSG = 2;
FW.MS2 = 3;
FW.MS0 = 4;
FW.TXT = 5;
FW.COL = 6;
FW.CO2 = 7;
FW.NUM = 8;
FW.NU2 = 9;
FW.INF = 10;
FW.FNT = 11;
FW.FIL = 12;
FW.SND = 13;
FW.URL = 14;
FW.BAC = 15;
FW.IMG = 16;
FW.LIS = 17;

local cx,cy;
function FW:IsLocked(framename)
	if FW.Settings[framename] and FW.Settings[framename].lock ~=nil then
		return FW.Settings[framename].lock;
	else
		return FW.Settings.GlobalLock;
	end
end

function FW:CorrectPosition(frame)
	FW:SetPosition(frame,FW.Settings[frame.name].x,FW.Settings[frame.name].y);
end

local function FW_GetHeight(frame)
	return frame:GetHeight()*frame:GetEffectiveScale();
end

local function FW_GetWidth(frame)
	return frame:GetWidth()*frame:GetEffectiveScale();
end

local function FW_GetTop(frame)
	return frame:GetTop()*frame:GetEffectiveScale();
end

local function FW_GetBottom(frame)
	return frame:GetBottom()*frame:GetEffectiveScale();
end

local function FW_GetLeft(frame)
	return frame:GetLeft()*frame:GetEffectiveScale();
end

local function FW_GetRight(frame)
	return frame:GetRight()*frame:GetEffectiveScale();
end

local function FW_CoordinatesString(option)
	return strformat("%.0f",FW.Settings[option].x).." "..strformat("%.0f",FW.Settings[option].y);
end

local function FW_ToggleFilterList()
	FW:BuildOptions();
end

local function FW_ShowOptions()
	if not optionsbuilt then
		FW:BuildOptions();
	end
	FWOptions.show = 1;
end

local function FW_HideOptions()
	FWOptions.show = 0;
end

local function FW_DragFrames()
	local frame1,frame2;
	local cx,cy = GetCursorPosition();
	for f,frame in pairs(Frames) do
		if frame.fwmovingx then
			frame1 = _G[strsub(f,1,4).."Background"] or frame;
			local oy = select(2,FW:GetCenter(frame)) - select(2,FW:GetCenter(frame1));
			local x = frame.fwmovingx+cx;
			local y = frame.fwmovingy+cy;
			local hh = FW_GetHeight(frame1)/2;
			local hw = FW_GetWidth(frame1)/2;
			local vl = frame.fwmovingx+cx-hw;
			local vr = frame.fwmovingx+cx+hw;
			local vt = frame.fwmovingy+cy+hh-oy;
			local vb = frame.fwmovingy+cy-hh-oy;
			if FW.Settings.FrameSnap and f~="FWOptions"  then
				for ff,dd in pairs(Frames) do
					if ff~=f and ff~="FWOptions" then
						frame2 = _G[strsub(ff,1,4).."Background"] or dd;
						if frame2:IsVisible() then
							local t = FW_GetTop(frame2);
							local b = FW_GetBottom(frame2);
							local l = FW_GetLeft(frame2);
							local r = FW_GetRight(frame2);
							if t > vt-FW.Settings.FrameSnapDistance and t < vt+FW.Settings.FrameSnapDistance then
								y = t - hh + oy;
							elseif b > vt-FW.Settings.FrameSnapDistance and b < vt+FW.Settings.FrameSnapDistance then
								y = b - hh -FW.Settings.FrameDistance + oy;
							elseif t < vb+FW.Settings.FrameSnapDistance and t > vb-FW.Settings.FrameSnapDistance then
								y = t + hh + FW.Settings.FrameDistance + oy;
							elseif b < vb+FW.Settings.FrameSnapDistance and b > vb-FW.Settings.FrameSnapDistance then
								y = b + hh + oy;
							end
							if r > vr-FW.Settings.FrameSnapDistance and r < vr+FW.Settings.FrameSnapDistance then
								x = r - hw;
							elseif l > vr-FW.Settings.FrameSnapDistance and l < vr+FW.Settings.FrameSnapDistance then
								x = l - hw -FW.Settings.FrameDistance;
							elseif r < vl+FW.Settings.FrameSnapDistance and r > vl-FW.Settings.FrameSnapDistance then
								x = r + hw + FW.Settings.FrameDistance;
							elseif l < vl+FW.Settings.FrameSnapDistance and l > vl-FW.Settings.FrameSnapDistance then
								x = l + hw;
							end								
						end
					end
				end
				if vt>FW_GetTop(UIParent) then
					y = FW_GetTop(UIParent) -hh - FW.Settings.FrameDistance + oy;
				elseif vb< 0 then
					y = hh + FW.Settings.FrameDistance + oy;
				end
				if vr>FW_GetRight(UIParent) then
					x = FW_GetRight(UIParent) -hw - FW.Settings.FrameDistance;
				elseif vl<0 then
					x = hw + FW.Settings.FrameDistance;
				end
			end
			FW:SetPosition(frame,x,y);			
			FW.Settings[f].x,FW.Settings[f].y = x,y;
			for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
				if main_data.option and main_data.option.frame == f then
					main_data.option.frameheader.coordinates:SetText(FW_CoordinatesString(f));
					break;
				end
			end
			return;
		end
		--if frame.fwsizing then
		--end
	end
end

function FW:StartMoving(button)
	cx,cy = GetCursorPosition();
	if not FW:IsLocked(this.name) and button=="LeftButton" and (not this.combat_sensitive or not InCombatLockdown()) then 
		FW:RegisterUpdatedEvent(FW_DragFrames);
		local tx,ty = FW:GetCenter(this);
		this.fwmovingx = tx-cx;
		this.fwmovingy = ty-cy;
	end
end

function FW:Moved() -- should return if my mouse moved between press and release...
	local x,y = GetCursorPosition();
	return x~=cx or y~=cy;
end

function FW:StopMoving()
	this.fwmovingx = nil;
	this.fwmovingy = nil;
	FW:UnregisterUpdatedEvent(FW_DragFrames);
end

local function FW_SetLockIcon(button)
	local frame = button.parent.parent.frame;
	if frame then
		--FW:Show(frame.." "..tostring(FW:IsLocked(frame)));
		if FW:IsLocked(frame) then
			button.normaltexture:SetTexCoord(0,0.25,0,1);
			button.highlighttexture:SetTexCoord(0,0.25,0,1);
			button.title = FWL.UNLOCK;
			button.tip = FWL.UNLOCK_TT;
		else
			button.normaltexture:SetTexCoord(0.25,0.50,0,1);
			button.highlighttexture:SetTexCoord(0.25,0.50,0,1);
			button.title = FWL.LOCK;
			button.tip = FWL.LOCK_TT;
		end
		if button.over then FW:ShowTip(button);end
	end
end

local function FW_LockFrame(button)
	local frame = button.parent.parent.frame
	if frame then
		FW.Settings[frame].lock = not FW.Settings[frame].lock;
		Frames[frame]:Update();
		FW_SetLockIcon(button);
	end
end

local function FW_SetFrameAlpha(button)
	local frame = button.parent.parent.frame;
	button.parent.alpha:SetText(strformat("%.1f",FW.Settings[frame].alpha));
	Frames[frame]:Update();
end

local function FW_SetFrameScale(button)
	local frame = button.parent.parent.frame;
	button.parent.scale:SetText(strformat("%.1f",FW.Settings[frame].scale));
	Frames[frame]:Update();
end

local function FW_ColorSelectedSpell(obj) -- only thing this does is highlght the spell that's currently active
	if obj.expand then
		local spell = obj.editbox:GetText();
		local l;
		local i = 1;
		obj.background:Show();
		while obj.items[i] and obj.items[i]:IsShown() do
			if obj.items[i].editbox:GetText() == spell then
				obj.items[i].editbox:SetTextColor(1,1,1);
				obj.items[i].background:Show();
			else
				obj.items[i].editbox:SetTextColor(0,1,0);
				obj.items[i].background:Hide();
			end
			i=i+1;
		end
	else
		obj.background:Hide();
	end
end

local function FW_StringToCoordinates(s)
	local s1,s2 = strsplit(" ",s);
	s1,s2 = tonumber(s1),tonumber(s2);
	if s1 and s2 then
		return s1,s2;
	end	
end

local function FW_StringToColor(s) -- used for filters and normal coloring
	local s1,s2,s3,s4 = strsplit(" ",s);
	s1,s2,s3,s4 = tonumber(s1),tonumber(s2),tonumber(s3),tonumber(s4);
	if s1 and s2 and s3 then
		return s1,s2,s3,s4;
	end
end

local function FW_FilterColorString(setting)
	if not setting then return "";end
	local s = "";
	for i=2,#setting,1 do
		if s=="" then
			s = s..strformat("%.2f",setting[i]);
		else
			s = s.." "..strformat("%.2f",setting[i]);
		end
	end
	return s;
end

local function FW_ColorString(setting)
	if not setting then return "";end
	local s = "";
	for i,v in ipairs(setting) do
		if s=="" then
			s = s..strformat("%.2f",v);
		else
			s = s.." "..strformat("%.2f",v);
		end
	end
	return s;
end

local function FW_SetFilterColor(data,obj)
	if data and (data[1] == FW.FILTER_COLOR or data[1] == FW.FILTER_SHOW_COLOR) then
		if not data[2] then
			data[2],data[3],data[4] = 1,1,1;
		end
		obj.colorswatch:EnableMouse(true);
		obj.colorswatch.normaltexture:SetVertexColor(data[2],data[3],data[4],1);
		obj.editbox2:EnableMouse(true);
		obj.editbox2:SetText(FW_FilterColorString(data));
	else
		obj.colorswatch:EnableMouse(false);
		obj.colorswatch.normaltexture:SetVertexColor(0,0,0,0.1);
		obj.editbox2:EnableMouse(false);
		obj.editbox2:SetText("");
	end
end

local function FW_FilterSpellUpdate(obj) -- now also called when the type is changed
	local spell = obj.editbox:GetText();
	local filter = obj.o;
	local typ = obj.typebutton.val or 1;

	if obj.s[filter][spell] and obj.s[filter][spell][typ] then
		obj.actionbutton:SetText(FW:TypeName(obj.s[filter][spell][typ][1],obj.actionbutton.list));
	else
		obj.actionbutton:SetText(FW:TypeName(0,obj.actionbutton.list));
	end
 	FW_SetFilterColor(obj.s[filter][spell] and obj.s[filter][spell][typ],obj);
	FW_ColorSelectedSpell(obj);
end

local function FC_BuildFilterList(obj)
	local l;
	local y = 0;
	local i = 1;
	--FW:Show(s:GetName());
	
	local list1 = obj.actionbutton.list;
	local list2 = obj.typebutton.list;

	if obj.expand then -- make and show the list
		for k, v in pairs(obj.s[obj.o]) do
			for key, val in pairs(v) do
				l = obj.items[i] or obj:NewFilterListItem(i);
				
				l.o = obj.o;
				l.s = obj.s;
				l.d = obj.d;
				l.func = obj.func;
				
				l.editbox:SetText(k);
				l.actionbutton.list = list1;
				l.typebutton.list = list2;
				l.typebutton.val = key;
				l.typebutton:SetText(FW:TypeName(key,list2));
				
				l.typebutton:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
				l.actionbutton:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
				l.editbox2:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize-2);
				l.editbox:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
				
				FW_FilterSpellUpdate(l);
				
				y = y - 20;
				
				l:SetPoint("TOPLEFT", obj, "TOPLEFT",0,y);
				l:Show();
				
				i = i + 1;
			end
		end
	end
	
	-- hide the rest of the list
	
	obj:Finalize(i);
	FW_ColorSelectedSpell(obj);
	return y;
end


local function FW_SetFilterType(t) -- receives the value number 
	-- the standard code that actually updates the value displayed on the button etc
	local spell = filterdropdown.button.parent.editbox:GetText();
	local filter = filterdropdown.button.parent.o;
	filterdropdown.button.parent.editbox2:ClearFocus();
	filterdropdown.button:SetText(FW:TypeName(t,filterdropdown.button.list));
	-- actually do something with this change
	local s = filterdropdown.button.parent.s;
	local typ = filterdropdown.button.parent.typebutton.val or 1;
	
	if filterdropdown.button.list == FW.FilterListOptions then -- this is the ACTION selection dropdown
		
		if not s[filter][spell] then
			s[filter][spell] = {};
		end
		if not s[filter][spell][typ] then
			s[filter][spell][typ] = {};
		end
		s[filter][spell][typ][1]=t;
		
		filterdropdown.button.parent.func(spell);
		
		FW_ToggleFilterList();  -- rebuild filter list
		
	else -- this is the TYPE selection dropdown
		
		if filterdropdown.button.parent.expand == nil then -- this is a list item edit!!
			-- i want to change the actual type and keep the rest of the settings...
			local old = filterdropdown.button.val;
			if not s[filter][spell][t] then
				s[filter][spell][t] = {};
			end
			s[filter][spell][t][1] = s[filter][spell][old][1];
			s[filter][spell][t][2] = s[filter][spell][old][2];
			s[filter][spell][t][3] = s[filter][spell][old][3];
			s[filter][spell][t][4] = s[filter][spell][old][4];	
			s[filter][spell][old] = nil;
			
			filterdropdown.button.parent.func(spell);
			
			FW_ToggleFilterList();  -- rebuild filter list			
		end
	end
	filterdropdown.button.val = t; -- <<-- the easiest way... stores the value INDEX that's selected

	if filterdropdown.button.parent.expand == null then -- this is a list item edit!!
		FW_FilterSpellUpdate(filterdropdown.button.parent.parent); -- refresh main filter parent
	else
		FW_FilterSpellUpdate(filterdropdown.button.parent);
	end
end

local function FW_FilterColorPickerApply()
	ColorPickerFrame.setting[2],ColorPickerFrame.setting[3],ColorPickerFrame.setting[4]=ColorPickerFrame:GetColorRGB();
	ColorPickerFrame.colorswatch.normaltexture:SetVertexColor(ColorPickerFrame.setting[2],ColorPickerFrame.setting[3],ColorPickerFrame.setting[4],1);
	ColorPickerFrame.colorswatch.parent.editbox2:SetText(FW_FilterColorString(ColorPickerFrame.setting));
end

local function FW_FilterColorPickerCancel()
	ColorPickerFrame.setting[2],ColorPickerFrame.setting[3],ColorPickerFrame.setting[4]=ColorPickerFrame.previousValues[1],ColorPickerFrame.previousValues[2],ColorPickerFrame.previousValues[3];
	ColorPickerFrame.colorswatch.normaltexture:SetVertexColor(ColorPickerFrame.setting[2],ColorPickerFrame.setting[3],ColorPickerFrame.setting[4],1);
	ColorPickerFrame.colorswatch.parent.editbox2:SetText(FW_FilterColorString(ColorPickerFrame.setting));
end

local function FW_FontApply(font)
	fontdropdown.button.parent.s[fontdropdown.button.parent.o] = font;
	fontdropdown.button:SetText(FW:FontName(font));
	fontdropdown.button:SetFont(font,fontdropdown.button.parent.s[fontdropdown.button.parent.o.."Size"]);
	fontdropdown.button.parent.editbox:SetText(font);
	if fontdropdown.button.parent.func then fontdropdown.button.parent.func(); end
end

local function FW_TextureApply(texture)
	texturedropdown.button.parent.s[texturedropdown.button.parent.o] = texture;
	texturedropdown.button:SetNormalTexture(texture);
	texturedropdown.button.parent.editbox:SetText(texture);
	if texturedropdown.button.parent.func then texturedropdown.button.parent.func(); end
end

local function FW_AlphaApply()
	local o = ColorPickerFrame.colorswatch.parent.o.."Color";
	local s = ColorPickerFrame.colorswatch.parent.s;
	if s[o] then
		if ColorPickerFrame.hasOpacity then
			s[o][4] =  1.0 - OpacitySliderFrame:GetValue();
		else
			s[o][4] =  nil;
		end
			ColorPickerFrame.colorswatch.normaltexture:SetVertexColor(s[o][1],s[o][2],s[o][3],s[o][4]);
			ColorPickerFrame.colorswatch.fullalphatexture:SetVertexColor(s[o][1],s[o][2],s[o][3]);
			ColorPickerFrame.colorswatch.parent.editbox:SetText(FW_ColorString(s[o]));
		end
	if ColorPickerFrame.colorswatch.parent.func then ColorPickerFrame.colorswatch.parent.func();end
end

local function FW_ColorPickerApply()
	local o = ColorPickerFrame.colorswatch.parent.o.."Color";
	local s = ColorPickerFrame.colorswatch.parent.s;
	ColorPickerFrame.colorswatch.parent.s[o][1],s[o][2],s[o][3] = ColorPickerFrame:GetColorRGB();

	ColorPickerFrame.colorswatch.normaltexture:SetVertexColor(s[o][1],s[o][2],s[o][3],s[o][4]);
	ColorPickerFrame.colorswatch.fullalphatexture:SetVertexColor(s[o][1],s[o][2],s[o][3]);
	ColorPickerFrame.colorswatch.parent.editbox:SetText(FW_ColorString(s[o]));

	if ColorPickerFrame.colorswatch.parent.func then ColorPickerFrame.colorswatch.parent.func();end
end

local function FW_ColorPickerCancel()
	local o = ColorPickerFrame.colorswatch.parent.o.."Color";
	local s = ColorPickerFrame.colorswatch.parent.s;
	s[o][1],s[o][2],s[o][3] = ColorPickerFrame.previousValues[1],ColorPickerFrame.previousValues[2],ColorPickerFrame.previousValues[3];
	s[o][4] = ColorPickerFrame.previousValues[4];
	
	ColorPickerFrame.colorswatch.normaltexture:SetVertexColor(s[o][1],s[o][2],s[o][3],s[o][4]);
	ColorPickerFrame.colorswatch.fullalphatexture:SetVertexColor(s[o][1],s[o][2],s[o][3]);
	ColorPickerFrame.colorswatch.parent.editbox:SetText(FW_ColorString(s[o]));
	
	if ColorPickerFrame.colorswatch.parent.func then ColorPickerFrame.colorswatch.parent.func();end
end

local function FW_SoundApply(sound)
	sounddropdown.button.parent.s[sounddropdown.button.parent.o] = sound;
	sounddropdown.button:SetText(FW:SoundName(sound));
	sounddropdown.button.parent.editbox:SetText(sound);
	if sounddropdown.button.parent.func then sounddropdown.button.parent.func(); end
end

local function FW_RestorePosition(button)
	local frame = button.parent.parent.frame;
	if frame then
		Frames[frame]:ClearAllPoints();
		Frames[frame]:SetPoint("CENTER",UIParent, "CENTER",0,0);
		FW.Settings[frame].x,FW.Settings[frame].y = FW:GetCenter(Frames[frame]);
		
		button.parent.coordinates:SetText(FW_CoordinatesString(frame));
	end
end

local function FW_FindCategory(t,name)
	for i, data in ipairs(t) do
		if data[1] == name then
			return i;
		end
	end
end
local function FW_FindOption(t,typ,name)
	for i, data in ipairs(t) do
		if data[1] == typ and data[4] == name then
			return i;
		end
	end
end

local function FW_RestoreDefaults(obj)
	if obj.parent.index then
		for i, d in ipairs(FW_Options[obj.parent.index][MAIN_DATA_TABLE][obj.index][4]) do -- OPTION LEVEL
			if d.option.default then
				d.option.default:Click();
			end
		end
	else
		for sub_index, sub_data in ipairs(FW_Options[obj.index][MAIN_DATA_TABLE]) do -- SUB OPTION LEVEL
			for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL
				if d.option.default then
					d.option.default:Click();
				end
			end
		end
	end
	FW:RefreshOptions();
end

local function FW_RestoreFrameDefaults(obj)
	if obj.frame then
		FW.Settings[obj.frame].lock = false;
		Frames[obj.frame]:Update();
		FW_SetLockIcon(obj.frameheader.lock);
		obj.frameheader.scalerestore:Click();
		obj.frameheader.position:Click();
		obj.frameheader.alpharestore:Click();
	end
end

local function FW_AutoComplete(self,...) -- auto complete editbox with keys from x tables
	local text = self:GetText();
	local textlen = strlen(text);
	
	-- fix special characters here if needed
	text = gsub(text, "%(", "%%(");
	text = gsub(text, "%)", "%%)");
	
	for i=1,select("#",...),1 do
		local t = (select(i,...));
		if t then
			for name in pairs(t) do

				if ( text ~= "" and strfind(strlower(name), "^"..strlower(text)) ) then
					self:SetText(name);
					self:HighlightText(textlen, -1);
					return;
				end
			end
		end
	end
end

------------------------------------------------------------
-- START ALL INTERFACE TEMPLATES
------------------------------------------------------------
-- these templates assume that the settings and defaults to use can change
-- but the names of the options will remain the same

local function NewColorSwatch(parent)
	local obj = CreateFrame("Button",nil,parent);
	obj.parent = parent;
	local o = obj.parent.o.."Color";
	obj:SetWidth(18);
	obj:SetHeight(18);
	
	obj.fullalphatexture = obj:CreateTexture(nil,"OVERLAY");
	obj.fullalphatexture:SetTexture("Interface\\ChatFrame\\ChatFrameColorSwatch");
	obj.fullalphatexture:SetWidth(18);
	obj.fullalphatexture:SetHeight(18);
	obj.fullalphatexture:SetPoint("CENTER",obj,"CENTER",0,0);
	obj.fullalphatexture:SetTexCoord(0,0, 0,1, 1,0, 1000,1000);	
	
	obj.backgroundtexture = obj:CreateTexture(nil,"BACKGROUND");
	obj.backgroundtexture:SetTexture(0.8,0.8,0.8);
	obj.backgroundtexture:SetWidth(16);
	obj.backgroundtexture:SetHeight(16);
	obj.backgroundtexture:SetPoint("CENTER",obj,"CENTER",0,0);
	obj.backgroundtexture:SetVertexColor(1.00,0.82,0.00);

	obj:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch");
	obj.normaltexture = obj:GetNormalTexture();
	
	--scripts

	obj.title = FWL.CLICK_TO_EDIT;
	obj.tip = FWL.CLICK_TO_EDIT_TT;

	obj:SetScript("OnClick",function(self)
				
		CloseMenus();
		ColorPickerFrame.func = FW_ColorPickerApply;
		ColorPickerFrame.colorswatch = self;
		
		if obj.parent.d[o] and obj.parent.d[o][4] then
			ColorPickerFrame.hasOpacity = 1;
			ColorPickerFrame.opacityFunc = FW_AlphaApply;
			ColorPickerFrame.opacity = 1.0 - obj.parent.s[o][4];
		else
			ColorPickerFrame.hasOpacity = nil;
			obj.parent.s[o][4] = nil;
		end
		
		ColorPickerFrame:SetColorRGB(obj.parent.s[o][1],obj.parent.s[o][2],obj.parent.s[o][3]);
		
		if not ColorPickerFrame.previousValues then ColorPickerFrame.previousValues = {}; end
		ColorPickerFrame.previousValues[1] = obj.parent.s[o][1];
		ColorPickerFrame.previousValues[2] = obj.parent.s[o][2];
		ColorPickerFrame.previousValues[3] = obj.parent.s[o][3];
		ColorPickerFrame.previousValues[4] = obj.parent.s[o][4];
		
		ColorPickerFrame.cancelFunc = FW_ColorPickerCancel;
		ShowUIPanel(ColorPickerFrame);
		
	end);

	obj:SetScript("OnEnter",function(self)
		obj.backgroundtexture:SetVertexColor(1.00,1.00,1.00);
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		obj.backgroundtexture:SetVertexColor(1.00,0.82,0.00);
		FW:HideTip(self);
	end);
	obj:SetScript("OnShow",function(self)
		obj.normaltexture:SetVertexColor(obj.parent.s[o][1],obj.parent.s[o][2],obj.parent.s[o][3],obj.parent.s[o][4] or 1);
		obj.fullalphatexture:SetVertexColor(obj.parent.s[o][1],obj.parent.s[o][2],obj.parent.s[o][3]);
	end);

	return obj;
end


local function NewButton(parent)
	local obj = CreateFrame("Button",nil,parent);
	obj.parent = parent;
	obj:SetWidth(14);
	obj:SetHeight(14);
	
	return obj;
end

local function NewDropdownShowButton(parent,dropdown)
	local obj = CreateFrame("Frame",nil,parent);
	obj.parent = parent;
	obj.dropdown = dropdown;
	
	obj:SetHeight(14);
	obj:EnableMouse(1);
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetAllPoints(obj);
	
	obj.background = obj:CreateTexture(nil,"BACKGROUND");
	obj.background:SetAllPoints(obj);
	obj.background:SetTexture(0,0,0,0.1);
	
	--scripts
	obj.SetText = function(self,text)
		obj.text:SetText(text);
	end
	obj.GetText = function(self)
		return obj.text:GetText();
	end
	obj.SetFont = function(self,...)
		obj.text:SetFont(...);
	end
	obj.SetJustifyH = function(self,...)
		obj.text:SetJustifyH(...);
	end
	obj:SetScript("OnEnter",function(self)
		obj.background:SetTexture(1,1,1,0.05);
		obj.dropdown.button = self;
		obj.dropdown:Build();
		obj.dropdown:SetPoint("TOPLEFT",self, "BOTTOMLEFT",-5,0);
		obj.dropdown:Show();
	end);
	obj:SetScript("OnLeave",function(self)
		obj.background:SetTexture(0,0,0,0.1);
		if not obj.dropdown.over then
			obj.dropdown:Hide();
		end
	end);
	return obj;
end


local function NewTextButton(parent)
	local obj = NewButton(parent);
	obj.anchor = "CENTER";
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetPoint(obj.anchor,obj,obj.anchor,0,0);
	obj.high = obj:CreateFontString(nil,"HIGHLIGHT","FWFontHighlight");
	obj.high:SetPoint(obj.anchor,obj,obj.anchor,0,0);
	
	-- scripts
	obj.SetText = function(self,text)
		obj.text:SetText(text);
		text = text:gsub("%|c%x%x%x%x%x%x%x%x", "") -- remove color tags
		text = text:gsub("%|r", "")	-- remove blizzard style return at end of line
		obj.high:SetText(text);
	end
	obj.GetText = function(self)
		return obj.text:GetText();
	end
	obj.SetFont = function(self,...)
		obj.text:SetFont(...);
		obj.high:SetFont(...);
	end
	obj.SetJustifyH = function(self,anchor)
		obj.anchor = anchor;
		obj.text:ClearAllPoints();
		obj.text:SetPoint(obj.anchor,obj,obj.anchor,0,0);
		obj.high:ClearAllPoints();
		obj.high:SetPoint(obj.anchor,obj,obj.anchor,0,0);
	end
	obj.SetTextColor = function(self,...)
		obj.text:SetTextColor(...);
	end
	obj:SetScript("OnMouseDown",function(self)
		obj.text:SetPoint(obj.anchor,obj,obj.anchor,1,-1);
		obj.high:SetPoint(obj.anchor,obj,obj.anchor,1,-1);
	end);
	obj:SetScript("OnMouseUp",function(self)
		obj.text:SetPoint(obj.anchor,obj,obj.anchor,0,0);
		obj.high:SetPoint(obj.anchor,obj,obj.anchor,0,0);
	end);	
	obj:SetScript("OnLeave",function(self)
		obj.text:SetPoint(obj.anchor,obj,obj.anchor,0,0);
		obj.high:SetPoint(obj.anchor,obj,obj.anchor,0,0);
		obj.text:Show();
		FW:HideTip(self);
	end);
	obj:SetScript("OnEnter",function(self)
		obj.text:Hide();
		FW:ShowOptionsTip(self);
	end);
	
	return obj;
end

local function NewDropdownListButton(parent)
	local obj = NewTextButton(parent);
	
	obj:SetScript("OnEnter",function(self)
		obj.parent:Show();
		obj.text:Hide();
	end);

	obj:SetScript("OnLeave",function(self)
		if not obj.parent.over then
			obj.parent:Hide();
		end
		obj.text:SetPoint(obj.anchor,obj,obj.anchor,0,0);
		obj.high:SetPoint(obj.anchor,obj,obj.anchor,0,0);
		obj.text:Show();
	end);
	return obj;
end

local function NewTexturedButton(parent,texture)
	local obj = NewButton(parent);

	obj:SetNormalTexture(texture);
	obj.normaltexture = obj:GetNormalTexture();
	obj:SetHighlightTexture(texture);
	obj.highlighttexture = obj:GetHighlightTexture();
	obj.highlighttexture:SetBlendMode("ADD");
	obj.highlighttexture:SetDesaturated(1);
	
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewDefaultButton(parent)
	local obj = NewTexturedButton(parent,"Interface\\PVPFrame\\PVP-Banner-Emblem-2");
	obj:SetPoint("RIGHT",parent,"RIGHT",-5,0);
	obj.normaltexture:SetVertexColor(1,1,1,0.3);
	obj.title = FWL.DEFAULT;
	obj.tip = FWL.DEFAULT_TT;
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	return obj;
end

local function NewDefaultAllButton(parent)
	local obj = NewDefaultButton(parent);
	obj.title = FWL.DEFAULT_ALL;
	obj.tip = FWL.DEFAULT_ALL_TT;
	return obj;
end

local function NewEditBox(parent)
	local obj = CreateFrame("EditBox",nil,parent);
	obj.parent = parent;
	obj:SetWidth(100);
	obj:SetHeight(14);
	obj:SetAutoFocus(false)
	obj:SetMaxLetters(64);
	obj:SetJustifyH("RIGHT");
	
	obj.background = obj:CreateTexture(nil,"BACKGROUND");
	obj.background:SetAllPoints(obj);
	obj.background:SetTexture(0,0,0,0.1);
	
	obj:SetFontObject("FWFontHighlight"); -- 
			
	obj.title = FWL.CLICK_TO_EDIT;
	obj.tip = FWL.CLICK_TO_EDIT_TT;	
	
	--scripts
	obj:SetScript("OnEnter",function(self)
		obj.background:SetTexture(1,1,1,0.05);
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
		obj.background:SetTexture(0,0,0,0.1);
	end);
	obj:SetScript("OnShow",function(self)
		self:SetText(obj.parent.s[obj.parent.o]);
	end);
	obj:SetScript("OnEscapePressed",function(self)
		self:ClearFocus();
	end);
	obj:SetScript("OnEnterPressed",function(self)
		self:ClearFocus();
	end);	
	obj:SetScript("OnEditFocusGained",function(self)
		self:HighlightText();
	end);
	obj:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(obj.parent.s[obj.parent.o]);
	end);
	
	return obj;
end

local function NewTextureButton(parent,n)
	local obj = CreateFrame("Button",nil,parent);
	obj.parent = parent;
	obj.parent.items[n] = obj;
	obj:SetWidth(140);
	obj:SetHeight(16);

	obj:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar");
	obj.normaltexture = obj:GetNormalTexture();
	obj.normaltexture:SetVertexColor(1.00,0.88,0.50);
	
	--scripts
	obj:SetScript("OnClick",function(self)
		FW_TextureApply(self.val);
		texturedropdown:Hide();
	end);
	obj:SetScript("OnEnter",function(self)
		self.normaltexture:SetVertexColor(1.00,1.00,1.00);
		texturedropdown:Show();
	end);
	obj:SetScript("OnLeave",function(self)
		self.normaltexture:SetVertexColor(1.00,0.88,0.50);
		if not texturedropdown.over then
			texturedropdown:Hide();
		end
	end);
	
	return obj;
end

local function NewBackdropButton(parent,n)
	local obj = CreateFrame("Button",nil,parent);
	obj.parent = parent;
	obj.parent.items[n] = obj;
	obj:SetWidth(140);
	obj:SetHeight(32);
	
	obj:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar");
	obj.normaltexture = obj:GetNormalTexture();
	obj.normaltexture:SetVertexColor(1.00,0.88,0.50);

	--scripts
	obj:SetScript("OnClick",function(self)
		--FW_TextureApply(self.val);
		backdropdropdown:Hide();
	end);
	obj:SetScript("OnEnter",function(self)
		self:SetBackdropBorderColor(1.00,1.00,1.00);
		self:SetBackdropColor(1.00,1.00,1.00);
		backdropdropdown:Show();
	end);
	obj:SetScript("OnLeave",function(self)
		self:SetBackdropBorderColor(1.00,0.88,0.50);
		self:SetBackdropColor(1.00,0.88,0.50);
		if not backdropdropdown.over then
			backdropdropdown:Hide();
		end
	end);
	
	return obj;
end

local function NewShortcutButton(parent)
	local obj = NewTextButton(parent);

	obj:SetNormalTexture("Interface\\GossipFrame\\BinderGossipIcon");
	obj.normaltexture = obj:GetNormalTexture();
	obj.normaltexture:SetWidth(12);
	obj.normaltexture:SetHeight(12);
	obj.normaltexture:ClearAllPoints();
	obj.normaltexture:SetPoint("LEFT",obj,"LEFT",2,0);
	return obj;
end

local function NewFontButton(parent,n)
	local obj = NewDropdownListButton(parent);
	obj.parent.items[n] = obj;
	obj:SetWidth(140);
	obj:SetHeight(16);

	--scripts
	obj:SetScript("OnClick",function(self)
		FW_FontApply(self.val);
		fontdropdown:Hide();
	end);
	return obj;
end

local function NewFilterButton(parent,n)
	local obj = NewDropdownListButton(parent);
	obj.parent.items[n] = obj;
	obj:SetWidth(70);
	obj:SetHeight(16);
	
	--scripts
	obj:SetScript("OnClick",function(self)
		FW_SetFilterType(self.val);
		filterdropdown:Hide();
	end);

	return obj;
end


local function NewPlaySound(parent)
	local obj = NewTexturedButton(parent,"Interface\\Buttons\\UI-GuildButton-MOTD-Up");
	
	--scripts
	obj:SetScript("OnClick",function(self)
		if obj.parent.s and obj.parent.s[obj.parent.o] then
			for i=1,obj.parent.s[obj.parent.o.."Volume"],1 do
				PlaySoundFile( obj.parent.s[obj.parent.o] );
			end
		else
			PlaySoundFile( obj.parent.o );
		end
	end);

	return obj;
end

local function NewSoundButton(parent,n)
	local obj = NewDropdownListButton(parent);
	obj.parent.items[n] = obj;
	obj:SetWidth(140);
	obj:SetHeight(16);

	obj.play = NewPlaySound(obj);
	obj.play:SetPoint("LEFT",obj);
	
	--scripts
	obj:SetScript("OnClick",function(self)
		FW_SoundApply(self.o);
		sounddropdown:Hide();
	end);
	obj.play:SetScript("OnEnter",function(self)
		sounddropdown:Show();
	end);
	obj.play:SetScript("OnLeave",function(self)
		if not sounddropdown.over then
			sounddropdown:Hide();
		end
	end);

	return obj;
end

local function NewDropdown(parent,build)
	local obj = CreateFrame("Frame",nil,parent);
	obj.parent = parent;
	obj:SetWidth(110);
	obj:SetHeight(20);
	obj:SetFrameStrata("TOOLTIP");
	obj:Hide();
	obj:EnableMouse(1);

	obj.items = {};
	obj.Build = build;

	obj.NewFontButton = NewFontButton;
	obj.NewSoundButton = NewSoundButton
	obj.NewFilterButton = NewFilterButton;
	obj.NewTextureButton = NewTextureButton;
	obj.NewBackdropButton = NewBackdropButton
	
	obj.Finalize = function(self,i)
		while obj.items[i] and obj.items[i]:IsShown() do
			obj.items[i]:Hide();
			i=i+1;
		end
	end
		
	--scripts
	obj:SetScript("OnEnter",function(self)
		self:Show();
		self.over = true;
	end);
	obj:SetScript("OnLeave",function(self)
		self:Hide();
		self.over = false;
	end);
	
	return obj;
end

local function NewCheckButton(parent)
	local obj = CreateFrame("Button",nil,parent);
	obj.parent = parent;
	obj:SetWidth(20);
	obj:SetHeight(20);
	
	obj:SetNormalTexture("Interface\\AddOns\\Forte_Core\\Textures\\CheckButton");
	obj.normaltexture = obj:GetNormalTexture();
	obj.normaltexture:ClearAllPoints();
	obj.normaltexture:SetWidth(16);
	obj.normaltexture:SetHeight(16);
	obj.normaltexture:SetPoint("CENTER",obj,"CENTER",0,0);
	
	obj.background = obj:CreateTexture(nil,"BACKGROUND");
	obj.background:SetTexture(0,0,0,0.2);
	obj.background:SetWidth(10);
	obj.background:SetHeight(10);
	obj.background:SetPoint("CENTER",obj,"CENTER",0,0);
	
	obj.texture = obj:CreateTexture(nil,"OVERLAY");
	obj.texture:SetTexture("Interface\\Buttons\\UI-CheckBox-Check");
	obj.texture:SetAllPoints(obj);
	
	obj.title = "[click to toggle]";
	obj.tip = "";
	
	obj.SetChecked = function(self,checked)
		if checked then
			obj.texture:SetVertexColor(1,1,1,1);
		else
			obj.texture:SetVertexColor(1,1,1,0);
		end
	end
	
	obj:SetScript("OnEnter",function(self)
		obj.background:SetTexture(1,1,1,0.05);
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
		obj.background:SetTexture(0,0,0,0.1);
	end);

	return obj;
end

local function NewCheckOption(parent,o,t,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = t or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;
	
	obj:EnableMouse(1);	
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",28,0);
	
	obj.checkbutton = NewCheckButton(obj);
	obj.checkbutton:SetPoint("LEFT",obj,"LEFT",5,0);
	
	obj.default = NewDefaultButton(obj);
	
	-- scripts
	obj.checkbutton:SetScript("OnClick",function(self)
		obj.s[obj.o] = not obj.s[obj.o];
		self:SetChecked(obj.s[obj.o]);
		if obj.func then obj.func(); end
	end);
	obj.checkbutton:SetScript("OnShow",function(self)
		self:SetChecked(obj.s[obj.o]);
	end);
	--
	obj.default:SetScript("OnClick",function(self)
		obj.checkbutton:SetChecked(obj.d[obj.o]);
		obj.s[obj.o] = obj.d[obj.o]
		if obj.func then obj.func(); end
	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewBackdropOption(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;

	obj:EnableMouse(1);	
	obj:SetWidth(560);
	obj:SetHeight(40);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetWidth(65);
	obj.text:SetHeight(40);
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",10,0);

	obj.default = NewDefaultButton(obj);
	
	if not backdropdropdown then
		backdropdropdown = NewDropdown(FWOptions,function()
			local j=0;
			local s;
			for i, texture in ipairs(FW.TextureList) do
				s = backdropdropdown.items[j] or backdropdropdown:NewBackdropButton(j);
				s:SetNormalTexture(texture);
				s.val=texture;
				s:SetPoint("TOPLEFT",backdropdropdown, "TOPLEFT",5+(j%3)*142,-5-math.floor(j/3)*34);
				s:Show();
				j=j+1;
			end
			backdropdropdown:SetWidth((142)*3+8);
			backdropdropdown:SetHeight(math.floor((j-1)/3)*34+42);
			backdropdropdown:Finalize(j+1);
		end);
	end
	
	obj.button = CreateFrame("Frame",nil,obj);
	obj.button:SetWidth(140);
	obj.button:SetHeight(34);
	obj.button:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	obj.button:EnableMouse(1);
	
	obj.overbutton = CreateFrame("Frame",nil,obj.button); 
	obj.overbutton:SetWidth(120);
	obj.overbutton:SetHeight(14);
	obj.overbutton:SetPoint("CENTER",obj.button,"CENTER",0,0);
	obj.overbutton:EnableMouse(1);
	
	obj.checkbutton = NewCheckButton(obj);	
	obj.checkbutton:SetPoint("LEFT",obj.button,"RIGHT",5,10);
	obj.checkbutton:SetWidth(22);
	obj.checkbutton.title = "[tile background, click to toggle]";
	
	obj.tilesize = NewEditBox(obj);
	obj.tilesize:SetPoint("LEFT",obj.checkbutton,"RIGHT",5,0);
	obj.tilesize:SetWidth(22);
	obj.tilesize.title = "[tile size background, click to edit]";
	
	obj.bg = NewEditBox(obj);
	obj.bg:SetPoint("LEFT",obj.tilesize,"RIGHT",5,0);
	obj.bg:SetPoint("RIGHT",obj.default,"LEFT",-5,10);
	obj.bg.title = "[background, click to edit]";
	
	obj.edge = NewEditBox(obj);
	obj.edge:SetPoint("LEFT",obj.button,"RIGHT",5,-10);
	obj.edge:SetWidth(22);
	obj.edge.title = "[border size, click to edit]";
	
	obj.inset = NewEditBox(obj);
	obj.inset:SetPoint("LEFT",obj.edge,"RIGHT",5,0);
	obj.inset:SetWidth(22);
	obj.inset.title = "[edge-content spacing, click to edit]";
	
	obj.border = NewEditBox(obj);
	obj.border:SetPoint("LEFT",obj.inset,"RIGHT",5,0);
	obj.border:SetPoint("RIGHT",obj.default,"LEFT",-5,-10);
	obj.border.title = "[border, click to edit]";
	
	-- scripts
	obj.default:SetScript("OnClick",function(self)
		for k, v in ipairs(obj.d[obj.o]) do
			obj.s[obj.o][k] = v;
		end
		obj.bg:SetText(obj.s[obj.o][1]);
		obj.border:SetText(obj.s[obj.o][2]);
		obj.checkbutton:SetChecked(obj.s[obj.o][3]);
		obj.tilesize:SetText(obj.s[obj.o][4]);
		obj.edge:SetText(obj.s[obj.o][5]);
		obj.inset:SetText(obj.s[obj.o][6]);
		FW:SetBackdrop(obj.button, unpack(obj.s[obj.o]) );
		obj.button:SetBackdropBorderColor(1.00,0.88,0.50);
		obj.button:SetBackdropColor(1.00,0.88,0.50);
		if obj.func then obj.func(); end
	end);
	--
	obj.button:SetScript("OnEnter",function(self)
		self:SetBackdropBorderColor(1.00,1.00,1.00);
		--[[backdropdropdown.button = self;
		backdropdropdown:Build();
		backdropdropdown:SetPoint("TOPLEFT",self, "BOTTOMLEFT",-5,0);
		backdropdropdown:Show();]]
	end);
	obj.button:SetScript("OnLeave",function(self)
		self:SetBackdropBorderColor(1.00,0.88,0.50);
		if not backdropdropdown.over then
			backdropdropdown:Hide();
		end
	end);
	obj.overbutton:SetScript("OnEnter",function(self)
		obj.button:SetBackdropColor(1.00,1.00,1.00);
		--[[backdropdropdown.button = self;
		backdropdropdown:Build();
		backdropdropdown:SetPoint("TOPLEFT",obj.button, "BOTTOMLEFT",-5,0);
		backdropdropdown:Show();]]
	end);
	obj.overbutton:SetScript("OnLeave",function(self)
		obj.button:SetBackdropColor(1.00,0.88,0.50);
		if not backdropdropdown.over then
			backdropdropdown:Hide();
		end
	end);
	obj.button:SetScript("OnShow",function(self)
		FW:SetBackdrop(self, unpack(obj.s[obj.o]) );
		self:SetBackdropBorderColor(1.00,0.88,0.50);
		self:SetBackdropColor(1.00,0.88,0.50);
	end);
	--
	obj.checkbutton:SetScript("OnShow",function(self)
		self:SetChecked(obj.s[obj.o][3]);
	end);
	obj.checkbutton:SetScript("OnClick",function(self)
		obj.s[obj.o][3] = not obj.s[obj.o][3];
		self:SetChecked(obj.s[obj.o][3]);
		FW:SetBackdrop(obj.button, unpack(obj.s[obj.o]) );
		obj.button:SetBackdropBorderColor(1.00,0.88,0.50);
		obj.button:SetBackdropColor(1.00,0.88,0.50);
		if obj.func then obj.func(); end
	end);
	--
	obj.tilesize:SetScript("OnShow",function(self)
		self:SetText(obj.s[obj.o][4]);
	end);
	obj.tilesize:SetScript("OnEnterPressed",function(self)
		local txt = tonumber(self:GetText());
		if txt then
			obj.s[obj.o][4] = txt;
			self:SetText(txt);
			FW:SetBackdrop(obj.button, unpack(obj.s[obj.o]) );
			obj.button:SetBackdropBorderColor(1.00,0.88,0.50);
			obj.button:SetBackdropColor(1.00,0.88,0.50);
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o][4]);
		end
		self:ClearFocus();
	end);
	obj.tilesize:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(obj.s[obj.o][4]);
	end);
	--
	obj.edge:SetScript("OnShow",function(self)
		self:SetText(obj.s[obj.o][5]);
	end);
	obj.edge:SetScript("OnEnterPressed",function(self)
		local txt = tonumber(self:GetText());
		if txt then
			obj.s[obj.o][5] = txt;
			self:SetText(txt);
			FW:SetBackdrop(obj.button, unpack(obj.s[obj.o]) );
			obj.button:SetBackdropBorderColor(1.00,0.88,0.50);
			obj.button:SetBackdropColor(1.00,0.88,0.50);
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o][5]);
		end
		self:ClearFocus();
	end);
	obj.edge:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(obj.s[obj.o][5]);
	end);
	--
	obj.inset:SetScript("OnShow",function(self)
		self:SetText(obj.s[obj.o][6]);
	end);
	obj.inset:SetScript("OnEnterPressed",function(self)
		local txt = tonumber(self:GetText());
		if txt then
			obj.s[obj.o][6] = txt;
			self:SetText(txt);
			FW:SetBackdrop(obj.button, unpack(obj.s[obj.o]) );
			obj.button:SetBackdropBorderColor(1.00,0.88,0.50);
			obj.button:SetBackdropColor(1.00,0.88,0.50);
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o][6]);
		end
		self:ClearFocus();
	end);
	obj.inset:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(obj.s[obj.o][6]);
	end);
	--
	obj.bg:SetScript("OnShow",function(self)
		self:SetText(obj.s[obj.o][1]);
	end);
	obj.bg:SetScript("OnEnterPressed",function(self)
		local txt = self:GetText();
		if txt and txt~="" then
			obj.s[obj.o][1] = txt;
			self:SetText(txt);
			FW:SetBackdrop(obj.button, unpack(obj.s[obj.o]) );
			obj.button:SetBackdropBorderColor(1.00,0.88,0.50);
			obj.button:SetBackdropColor(1.00,0.88,0.50);
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o][1]);
		end
		self:ClearFocus();
	end);
	obj.bg:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(obj.s[obj.o][1]);
	end);
	--
	obj.border:SetScript("OnShow",function(self)
		self:SetText(obj.s[obj.o][2]);
	end);
	obj.border:SetScript("OnEnterPressed",function(self)
		local txt = self:GetText();
		if txt and txt~="" then
			obj.s[obj.o][2] = txt;
			self:SetText(txt);
			FW:SetBackdrop(obj.button, unpack(obj.s[obj.o]) );
			obj.button:SetBackdropBorderColor(1.00,0.88,0.50);
			obj.button:SetBackdropColor(1.00,0.88,0.50);
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o][2]);
		end
		self:ClearFocus();
	end);
	obj.border:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(obj.s[obj.o][2]);
	end);

	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);

	return obj;
end

local function NewSoundOption(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;

	obj:EnableMouse(1);	
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetWidth(65);
	obj.text:SetHeight(20);
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",45,0);

	obj.default = NewDefaultButton(obj);
	
	obj.checkbutton = NewCheckButton(obj);	
	obj.checkbutton:SetPoint("LEFT",obj,"LEFT",5,0);	
	
	obj.play = NewPlaySound(obj);
	obj.play:SetPoint("LEFT",obj,"LEFT",25,0);
	
	if not sounddropdown then
		sounddropdown = NewDropdown(FWOptions,function()
		local j=0;
		local s;
		for i, data in ipairs(FW.SoundList) do
			s = sounddropdown.items[j] or sounddropdown:NewSoundButton(j);
			s:SetText(data[2]);
			s:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
			s.o = data[1];
			s:SetPoint("TOPLEFT",sounddropdown, "TOPLEFT",5+(j%3)*142,-5-math.floor(j/3)*18);
			s:Show();
			j=j+1;
		end
		sounddropdown:SetWidth((142)*3+8);
		sounddropdown:SetHeight(math.floor((j-1)/3)*18+26);	
		sounddropdown:Finalize(j+1);
	end);

	end
	obj.button = NewDropdownShowButton(obj,sounddropdown)
	obj.button:SetWidth(140);
	obj.button:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	
	obj.editbox2 = NewEditBox(obj);
	obj.editbox2:SetWidth(22);
	obj.editbox2:SetPoint("LEFT",obj.button,"RIGHT",5,0);
	obj.editbox2.minimum = 1;
	obj.editbox2.maximum = 8;
	
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetPoint("LEFT",obj.editbox2,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.default,"LEFT",-5,0);
	
	--scripts
	--obj.title = FW.L.CLICK_TO_EDIT;
	--obj.tip= "";
	--
	obj.default:SetScript("OnClick",function(self)
		obj.editbox:SetText(obj.d[obj.o]);
		obj.button:SetText(FW:SoundName(obj.d[obj.o]));
		obj.s[obj.o] = obj.d[obj.o]
		obj.s[obj.o.."Enable"] = obj.d[obj.o.."Enable"];
		obj.checkbutton:SetChecked(obj.d[obj.o.."Enable"]);
		obj.editbox2:SetText(obj.d[obj.o.."Volume"]);
		obj.s[obj.o.."Volume"] = obj.d[obj.o.."Volume"];
		if obj.func then obj.func(); end
	end);
	--
	obj.checkbutton:SetScript("OnClick",function(self)
		obj.s[obj.o.."Enable"] = not obj.s[obj.o.."Enable"];
		self:SetChecked(obj.s[obj.o.."Enable"]);
		if obj.func then obj.func(); end
	end);
	obj.checkbutton:SetScript("OnShow",function(self)
		self:SetChecked(obj.s[obj.o.."Enable"]);
	end);
	--
	obj.button:SetScript("OnShow",function(self)
		self:SetText(FW:SoundName(obj.s[obj.o]));
	end);
	--
	obj.editbox2:SetScript("OnShow",function(self)
		self:SetText(obj.s[obj.o.."Volume"]);
	end);
	obj.editbox2:SetScript("OnEnterPressed",function(self)
		local txt = FW:NumberCheck(self);
		if txt then
			obj.s[obj.o.."Volume"] = txt;
			self:SetText(obj.s[obj.o.."Volume"]);
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o.."Volume"]);
		end
		self:ClearFocus();
	end);
	obj.editbox2:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(obj.s[obj.o.."Volume"]);
	end);
	--
	obj.editbox:SetScript("OnEnterPressed",function(self)
		local txt = self:GetText();
		if txt and txt~="" then
			obj.s[obj.o] = txt;
			self:SetText(obj.s[obj.o]);
			obj.button:SetText(FW:SoundName(obj.s[obj.o]));
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o]);
		end
		self:ClearFocus();
	end);
	
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewCreateTabFrame(parent)
	local obj = CreateFrame("Frame",nil,parent);
	obj.parent = parent;
	
	obj.button = NewTextButton(obj);
	obj.button:SetPoint("TOPLEFT",obj,"TOPLEFT",0,-2);
	
	FW:SetBackdrop(obj,unpack(FW.Settings.OptionsBackdrop));
	
	obj:SetHeight(35);
	
	obj.SetText = function(self,txt)
		obj.button:SetText(txt);
		obj.button:SetWidth(obj.button.text:GetWidth()+FW.Settings.OptionsBackdrop[6]+3);
		obj:SetWidth(obj.button:GetWidth());
	end
	return obj;
end

local function NewTabFrame(parent)
	local obj = CreateFrame("Frame",nil,parent);
	local rightspace = 0;
	obj.parent = parent;
	obj.edit = false;
	obj.editing = false;
	
	obj.button = NewTextButton(obj);
	obj.button:SetPoint("TOPLEFT",obj,"TOPLEFT",0,-2);
	obj.button.title = FWL.SELECT_CLONE;
	obj.button.tip = "";
	
	obj.delete = NewTexturedButton(obj,"Interface\\Glues\\Login\\Glues-CheckBox-Check");
	obj.delete:SetPoint("TOPRIGHT",obj,"TOPRIGHT",-5,-5);
	obj.delete:SetHeight(10);
	obj.delete:SetWidth(10);
	obj.delete:Hide();
	obj.delete.title = FWL.DELETE_CLONE;
	obj.delete.tip = "";
	obj:SetHeight(35);
	
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetJustifyH("LEFT");
	obj.editbox:SetPoint("TOPLEFT",obj,"TOPLEFT",5,-2);
	obj.editbox:Hide();
	obj.editbox.title = FWL.RENAMING_CLONE;
	obj.editbox.tip = FWL.CLICK_TO_EDIT_TT;
	
	obj.SetEditable = function(self,edit)
		if edit ~= obj.edit then
			obj.edit = edit;
			if edit then
				rightspace = 15;
				obj.delete:Show();
			else
				rightspace = 0;
				obj.delete:Hide();
			end
			obj:SetWidth(obj.button:GetWidth()+rightspace);
		end
	end
	obj.SetEditing = function(self,editing)
		if editing ~= obj.editing then
			obj.editing = editing;
			if editing then
				obj.button:Hide();
				obj.editbox:SetWidth(120);
				obj:SetWidth(128+rightspace);
				obj.editbox:Show();
				obj.editbox:SetText(obj.button.text:GetText());
				obj.editbox:SetFocus(true);
				
			else
				obj.button:SetWidth(obj.button.text:GetWidth()+8);
				obj:SetWidth(obj.button:GetWidth()+rightspace);
				obj.button:Show();
				obj.editbox:Hide();
			end
		end
	end
	
	obj.SetText = function(self,txt)
		obj.button:SetText(txt);
		obj.button:SetWidth(obj.button.text:GetWidth()+5+3);
		obj:SetWidth(obj.button:GetWidth()+rightspace);
		
	end
	obj.button:SetScript("OnClick",function(self)
		if obj.savename == NEW_INSTANCE_STRING then
			obj.create_func(obj);
		else
			if obj.parent.parent.selected == obj.savename then
				if obj.edit then
					obj:SetEditing(true);
				end
			else
				obj.select_func(obj);
			end
		end
	end);

	obj.delete:SetScript("OnClick",function(self)
		obj.delete_func(obj);
	end);
	obj.editbox:SetScript("OnEnterPressed",function(self)
		local txt = self:GetText();
		if txt and txt~="" then
			obj.rename_func(obj,txt);
		end
		self:ClearFocus();
	end);	
	obj.editbox:SetScript("OnShow",function(self)
	end);
	obj.editbox:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		obj:SetEditing(false);
	end);
	return obj;
end

local function NewOptionsFrame(parent)
	local obj = CreateFrame("Frame",nil,parent);
	obj.parent = parent;
	obj.normalheader = CreateFrame("Frame",nil,obj);
	obj.frameheader = CreateFrame("Frame",nil,obj);
	obj.frameheader.parent = obj;
	
	obj.frameheader.midframe = CreateFrame("Frame",nil,obj.frameheader);
	obj.frameheader.midframe:SetHeight(20);
	obj.frameheader.leftframe = CreateFrame("Frame",nil,obj.frameheader);
	obj.frameheader.leftframe:SetHeight(20);
	obj.frameheader.rightframe = CreateFrame("Frame",nil,obj.frameheader);
	obj.frameheader.rightframe:SetHeight(20);
	obj.frameheader.rightmidframe = CreateFrame("Frame",nil,obj.frameheader);
	obj.frameheader.rightmidframe:SetHeight(20);
	obj.frameheader.leftmidframe = CreateFrame("Frame",nil,obj.frameheader);
	obj.frameheader.leftmidframe:SetHeight(20);
	
	obj.frameheader.default = NewDefaultAllButton(obj.frameheader);
	obj.frameheader.default:SetPoint("RIGHT",obj.frameheader,"RIGHT",-32,0);	

	obj.frameheader.position = NewTexturedButton(obj.frameheader,"Interface\\Glues\\LoadingScreens\\DynamicElements");
	obj.frameheader.position:SetPoint("RIGHT",obj.frameheader.default,"LEFT",-5,0);
	obj.frameheader.position.normaltexture:SetTexCoord(0.5,1.0,0.0,0.5);
	obj.frameheader.position.highlighttexture:SetTexCoord(0.5,1.0,0.0,0.5);
	obj.frameheader.position:SetWidth(14);
	obj.frameheader.position:SetHeight(14);
	
	obj.frameheader.coordinates = NewEditBox(obj.frameheader);
	obj.frameheader.coordinates:SetWidth(60);
	obj.frameheader.coordinates:SetHeight(12);
	obj.frameheader.coordinates:SetPoint("RIGHT",obj.frameheader.position,"LEFT",-3,0);
	
	obj.frameheader.alpharestore = NewTexturedButton(obj.frameheader,"Interface\\Icons\\Spell_Magic_LesserInvisibilty");
	obj.frameheader.alpharestore:SetPoint("RIGHT",obj.frameheader.coordinates,"LEFT",-3,0);
	obj.frameheader.alpharestore:SetWidth(12);
	obj.frameheader.alpharestore:SetHeight(12);	
	
	obj.frameheader.alpha = NewEditBox(obj.frameheader);
	obj.frameheader.alpha:SetWidth(24);
	obj.frameheader.alpha:SetHeight(12);
	obj.frameheader.alpha:SetPoint("RIGHT",obj.frameheader.alpharestore,"LEFT",-3,0);

	obj.frameheader.scalerestore = NewTexturedButton(obj.frameheader,"Interface\\Buttons\\UI-AttributeButton-Encourage-Up");
	obj.frameheader.scalerestore:SetPoint("RIGHT",obj.frameheader.alpha,"LEFT",-3,0);
	obj.frameheader.scalerestore:SetWidth(12);
	obj.frameheader.scalerestore:SetHeight(12);
	
	obj.frameheader.scale = NewEditBox(obj.frameheader);
	obj.frameheader.scale:SetWidth(24);
	obj.frameheader.scale:SetHeight(12);
	obj.frameheader.scale:SetPoint("RIGHT",obj.frameheader.scalerestore,"LEFT",-3,0);

	obj.header = CreateFrame("Frame",nil,obj);
	obj.header:SetHeight(20);
	obj.header:SetPoint("TOPLEFT",obj,"TOPLEFT",0,0);
	obj.header:SetPoint("TOPRIGHT",obj,"TOPRIGHT",0,0);

	obj.header.icon = NewTexturedButton(obj.header,"Interface\\GossipFrame\\BinderGossipIcon");
	obj.header.icon:SetPoint("LEFT",obj.header,"LEFT",2,0);
	obj.header.icon:SetWidth(16);
	obj.header.icon:SetHeight(16);
	obj.header.title = obj.header:CreateFontString(nil,"OVERLAY","FWFontHighlight");
	obj.header.title:SetPoint("CENTER",obj.header,"CENTER",0,0);
	obj.header.default = NewDefaultAllButton(obj.header);
	obj.header.default:SetPoint("RIGHT",obj.header,"RIGHT",-5,0);

	obj.frameheader.lock = NewTexturedButton(obj.frameheader,"Interface\\Glues\\CharacterSelect\\Glues-AddOn-Icons");
	obj.frameheader.lock:SetPoint("LEFT",obj.header.icon,"RIGHT",5,0);
	
	obj.frameheader.midframe:SetPoint("LEFT",obj.header.title,"LEFT",-10,0);
	obj.frameheader.midframe:SetPoint("RIGHT",obj.header.title,"RIGHT",10,0);
	obj.frameheader.leftframe:SetPoint("LEFT",obj.frameheader,"LEFT",0,0);
	obj.frameheader.leftframe:SetPoint("RIGHT",obj.frameheader,"LEFT",40,0);
	obj.frameheader.rightframe:SetPoint("RIGHT",obj.frameheader,"RIGHT",0,0);
	obj.frameheader.rightframe:SetPoint("LEFT",obj.frameheader,"RIGHT",-25,0);
	obj.frameheader.rightmidframe:SetPoint("LEFT",obj.frameheader.midframe,"RIGHT",0,0);
	obj.frameheader.rightmidframe:SetPoint("RIGHT",obj.frameheader.rightframe,"LEFT",0,0);
	obj.frameheader.leftmidframe:SetPoint("LEFT",obj.frameheader.leftframe,"RIGHT",0,0);
	obj.frameheader.leftmidframe:SetPoint("RIGHT",obj.frameheader.midframe,"LEFT",0,0);
	
	obj.frameheader:SetAllPoints(obj.header);
	obj.normalheader:SetAllPoints(obj.header);
	
	--scripts
	obj.frameheader.position.tip = FWL.POSITION_TT;
	obj.frameheader.position.title = FWL.POSITION;
	obj.frameheader.alpharestore.tip = FWL.ALPHA_TT;
	obj.frameheader.alpharestore.title = FWL.ALPHA;
	obj.frameheader.scalerestore.tip = FWL.RESTORE_SCALE_TT;
	obj.frameheader.scalerestore.title = FWL.RESTORE_SCALE;
	obj.frameheader.default.tip = FWL.DEFAULT_FRAME_TT;
	obj.frameheader.default.title = FWL.DEFAULT_FRAME;
						
	obj.header.default:SetScript("OnClick",function(self)
		FW_RestoreDefaults(obj);
	end);
	--
	obj.frameheader.default:SetScript("OnClick",function(self)
		FW_RestoreFrameDefaults(obj);
	end);
	--
	obj.frameheader.position:SetScript("OnClick",function(self)
		FW_RestorePosition(self);
	end);
	--
	obj.frameheader.coordinates:SetScript("OnShow",function(self)
		self:SetText(FW_CoordinatesString(obj.frame));
	end);
	obj.frameheader.coordinates:SetScript("OnEnterPressed",function(self)
		local x,y = FW_StringToCoordinates(self:GetText());
		if x then
			FW.Settings[obj.frame].x = x;
			FW.Settings[obj.frame].y = y;
			FW:CorrectPosition(Frames[obj.frame]);
			--if self:GetParent().func then self:GetParent().func(); end
		end
		self:ClearFocus();
	end);
	obj.frameheader.coordinates:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(FW_CoordinatesString(obj.frame));
	end);
	--
	obj.frameheader.lock:SetScript("OnShow",function(self)
		FW_SetLockIcon(self);
	end);
	obj.frameheader.lock:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
		self.over=1;
	end);
	obj.frameheader.lock:SetScript("OnLeave",function(self)
		FW:HideTip(self);
		self.over=nil;
	end);
	obj.frameheader.lock:SetScript("OnClick",function(self)
		FW_LockFrame(self);
	end);
	--
	obj.frameheader.alpha:SetScript("OnShow",function(self)
		self:SetText(strformat("%.1f",FW.Settings[obj.frame].alpha));
	end);
	obj.frameheader.alpha:SetScript("OnEnterPressed",function(self)
		local num = FW:FrameAlphaCheck(self);
		if num then
			FW.Settings[obj.frame].alpha = num;
		end
		FW_SetFrameAlpha(self);
		self:ClearFocus();
	end);
	obj.frameheader.alpha:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(strformat("%.1f",FW.Settings[obj.frame].alpha));
	end);
	--
	obj.frameheader.alpharestore:SetScript("OnClick",function(self)
		FW.Settings[obj.frame].alpha = (FW.Default[obj.frame] and FW.Default[obj.frame].alpha) or 1;
		FW_SetFrameAlpha(self);
	end);
	--
	obj.frameheader.scale:SetScript("OnShow",function(self)
		self:SetText(strformat("%.1f",FW.Settings[obj.frame].scale));
	end);
	obj.frameheader.scale:SetScript("OnEnterPressed",function(self)
		local num = FW:FrameScaleCheck(self);
		if num then
			FW.Settings[obj.frame].scale = num;
		end
		FW_SetFrameScale(self);
		self:ClearFocus();
	end);
	obj.frameheader.scale:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(strformat("%.1f",FW.Settings[obj.frame].scale));
	end);
	--
	obj.frameheader.scalerestore:SetScript("OnClick",function(self)
		FW.Settings[obj.frame].scale = (FW.Default[obj.frame] and FW.Default[obj.frame].scale) or 1;
		FW_SetFrameScale(self);
	end);
	return obj;
end

local function NewSubOptionsFrame(parent)
	local obj = CreateFrame("Frame",nil,parent);
	obj.parent = parent;
	obj:SetHeight(20);
	
	obj.header = CreateFrame("Frame",nil,obj);
	obj.header:SetHeight(20);
	obj.header:SetPoint("TOPLEFT",obj,"TOPLEFT",0,0);
	
	obj.header.icon = obj.header:CreateTexture(nil,"ARTWORK");
	obj.header.icon:SetTexture("Interface\\GossipFrame\\BinderGossipIcon");
	obj.header.icon:SetWidth(12);
	obj.header.icon:SetHeight(12);
	obj.header.icon:SetPoint("LEFT",obj.header,"LEFT",4,0);
	
	obj.header.title = obj.header:CreateFontString(nil,"ARTWORK","FWFontHighlight");
	obj.header.title:SetPoint("LEFT",obj.header,"LEFT",20,0);
	obj.header.title:SetJustifyH("LEFT");
	
	obj.default = NewDefaultAllButton(obj);
	obj.default:SetPoint("RIGHT",obj.header,"RIGHT",-5,0);
	
	-- scripts
	obj.default:SetScript("OnClick",function(self)
		FW_RestoreDefaults(obj);
	end);
	
	return obj;
end

local function NewInfoOption(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;
	
	obj:EnableMouse(1);
	obj:SetWidth(560);
	obj:SetHeight(20);

	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontHighlight");
	obj.text:SetPoint("LEFT",obj,"LEFT",10,0);
	obj.text:SetJustifyH("LEFT");
	
	return obj;
end

local function NewColor2Option(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;
	local o = obj.o.."Color";
	local e = obj.o.."Enable";
	
	obj:EnableMouse(1);
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",45,0);

	obj.checkbutton = NewCheckButton(obj);	
	obj.checkbutton:SetPoint("LEFT",obj,"LEFT",5,0);	
	obj.colorswatch = NewColorSwatch(obj);
	obj.colorswatch:SetPoint("LEFT",obj,"LEFT",25,0);	
	
	obj.default = NewDefaultButton(obj);	
	
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.default,"LEFT",-5,0);
	
	--scripts
	obj.default:SetScript("OnClick",function(self)
		
		obj.s[o][1],obj.s[o][2],obj.s[o][3],obj.s[o][4]=obj.d[o][1],obj.d[o][2],obj.d[o][3],obj.d[o][4];
		obj.colorswatch.normaltexture:SetVertexColor(obj.s[o][1],obj.s[o][2],obj.s[o][3],obj.s[o][4] or 1);
		obj.colorswatch.fullalphatexture:SetVertexColor(obj.s[o][1],obj.s[o][2],obj.s[o][3]);
		obj.editbox:SetText(FW_ColorString(obj.s[o]));
		
		obj.s[e] = obj.d[e];
		obj.checkbutton:SetChecked(obj.s[e]);
		
		if obj.func then obj.func(); end
	end);
	--
	obj.checkbutton:SetScript("OnClick",function(self)
		obj.s[e] = not obj.s[e];
		self:SetChecked(obj.s[e]);
		if obj.func then obj.func(); end
	end);
	obj.checkbutton:SetScript("OnShow",function(self)
		self:SetChecked(obj.s[e]);
	end);
	--
	obj.editbox:SetScript("OnShow",function(self)
		self:SetText(FW_ColorString(obj.s[o]));
	end);
	obj.editbox:SetScript("OnEnterPressed",function(self)
		local c1,c2,c3,c4 = FW_StringToColor(self:GetText());
		
		if c1 then
			obj.s[o][1] = c1;
			obj.s[o][2] = c2;
			obj.s[o][3] = c3;
			if obj.d[o][4] then
				obj.s[o][4] = c4 or 1;
			else
				obj.s[o][4] = nil;
			end
			obj.colorswatch.normaltexture:SetVertexColor(obj.s[o][1],obj.s[o][2],obj.s[o][3],obj.s[o][4] or 1);
			obj.colorswatch.fullalphatexture:SetVertexColor(obj.s[o][1],obj.s[o][2],obj.s[o][3]);
			if obj.func then obj.func(); end
		end
		self:SetText(FW_ColorString(obj.s[o]));
		self:ClearFocus();
	end);
	obj.editbox:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(FW_ColorString(obj.s[o]));
	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewColorOption(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;
	local o = obj.o.."Color";
	local e = obj.o.."Enable";

	obj:EnableMouse(1);
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",28,0);
	
	obj.colorswatch = NewColorSwatch(obj);
	obj.colorswatch:SetPoint("LEFT",obj,"LEFT",6,0);	
	
	obj.default = NewDefaultButton(obj);	
	
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.default,"LEFT",-5,0);
	
	--scripts
	--
	obj.default:SetScript("OnClick",function(self)
		obj.s[o][1],obj.s[o][2],obj.s[o][3],obj.s[o][4]=obj.d[o][1],obj.d[o][2],obj.d[o][3],obj.d[o][4];
		obj.colorswatch.normaltexture:SetVertexColor(obj.s[o][1],obj.s[o][2],obj.s[o][3],obj.s[o][4] or 1);
		obj.colorswatch.fullalphatexture:SetVertexColor(obj.s[o][1],obj.s[o][2],obj.s[o][3]);
		obj.editbox:SetText(FW_ColorString(obj.s[o]));
		
		if obj.func then obj.func(); end
	end);
	--
	obj.editbox:SetScript("OnShow",function(self)
		self:SetText(FW_ColorString(obj.s[o]));
	end);
	obj.editbox:SetScript("OnEnterPressed",function(self)
		local c1,c2,c3,c4 = FW_StringToColor(self:GetText());
		
		if c1 then
			obj.s[o][1] = c1;
			obj.s[o][2] = c2;
			obj.s[o][3] = c3;
			if obj.d[o][4] then
				obj.s[o][4] = c4 or 1;
			else
				obj.s[o][4] = nil;
			end
			obj.colorswatch.normaltexture:SetVertexColor(obj.s[o][1],obj.s[o][2],obj.s[o][3],obj.s[o][4] or 1);
			obj.colorswatch.fullalphatexture:SetVertexColor(obj.s[o][1],obj.s[o][2],obj.s[o][3]);
			if obj.func then obj.func(); end
		end
		self:SetText(FW_ColorString(obj.s[o]));
		self:ClearFocus();
	end);
	obj.editbox:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(FW_ColorString(obj.s[o]));
	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewFilterListItem(parent,n)
	local obj = CreateFrame("Frame",nil,parent);
	obj.parent = parent;
	obj.parent.items[n] = obj;
	
	obj:EnableMouse(1);
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.expandtexture = obj:CreateTexture(nil,"BACKGROUND");
	obj.expandtexture:SetTexture("Interface\\TalentFrame\\UI-TalentBranches");
	obj.expandtexture:SetWidth(20);
	obj.expandtexture:SetHeight(20);
	obj.expandtexture:SetPoint("LEFT",obj,"LEFT",2,0);
	obj.expandtexture:SetTexCoord(0.0,0.1,0.0,0.5);
	
	obj.background = obj:CreateTexture(nil,"BACKGROUND");
	obj.background:SetAllPoints(obj);
	obj.background:SetTexture(0,1,0,0.2);
	
	obj.default = NewDefaultButton(obj);
	
	obj.editbox2 = NewEditBox(obj);
	obj.editbox2:SetWidth(80);
	obj.editbox2:SetHeight(14);
	obj.editbox2:SetPoint("RIGHT",obj.default,"LEFT",-5,0);

	obj.colorswatch = NewButton(obj);
	obj.colorswatch:SetWidth(18);
	obj.colorswatch:SetHeight(18);
	obj.colorswatch:SetPoint("RIGHT",obj.editbox2,"LEFT",0,0);
	obj.colorswatch:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch");
	obj.colorswatch.normaltexture = obj.colorswatch:GetNormalTexture();
	obj.colorswatch.backgroundtexture = obj.colorswatch:CreateTexture(nil,"BACKGROUND");
	obj.colorswatch.backgroundtexture:SetWidth(16);
	obj.colorswatch.backgroundtexture:SetHeight(16);
	obj.colorswatch.backgroundtexture:SetPoint("CENTER",obj.colorswatch,"CENTER",0,0);	
	obj.colorswatch.backgroundtexture:SetTexture(0.8,0.8,0.8);
	obj.colorswatch.backgroundtexture:SetVertexColor(1.0,0.82,0.0);

	obj.actionbutton = NewDropdownShowButton(obj,filterdropdown);
	obj.actionbutton:SetWidth(70);
	obj.actionbutton:SetPoint("RIGHT",obj.colorswatch,"LEFT",-5,0);
	
	obj.typebutton = NewDropdownShowButton(obj,filterdropdown);
	obj.typebutton:SetWidth(70);
	obj.typebutton:SetPoint("RIGHT",obj.actionbutton,"LEFT",-5,0);
	
	obj.editbox = NewTextButton(obj);
	obj.editbox:SetPoint("LEFT",obj.expandtexture,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.typebutton,"LEFT",-5,0);
	obj.editbox:SetJustifyH("LEFT");
	obj.editbox:SetHeight(20);
	
	-- scripts
	obj.val = 1; -- ????
	obj.actionbutton.val = 0;
	obj.typebutton.val = 1;
	
	obj.colorswatch.title = FWL.CLICK_TO_EDIT;
	obj.colorswatch.tip = FWL.CLICK_TO_EDIT_TT;
	--
	obj.default:SetScript("OnClick",function(self)
		-- list items should only reset the current spell - type pair to their default action!
		local spell = obj.editbox:GetText();		
		local typ = obj.typebutton.val or 1;
		
		if obj.d[obj.o][spell] and obj.d[obj.o][spell][typ] then
			obj.s[obj.o][spell][typ][1] = obj.d[obj.o][spell][typ][1];
			obj.s[obj.o][spell][typ][2] = obj.d[obj.o][spell][typ][2];
			obj.s[obj.o][spell][typ][3] = obj.d[obj.o][spell][typ][3];
			obj.s[obj.o][spell][typ][4] = obj.d[obj.o][spell][typ][4];									
		else
			obj.s[obj.o][spell][typ] = nil;
		end
		
		obj.func(spell);
		FW_ToggleFilterList();  -- rebuild obj.o list
		FW_FilterSpellUpdate(obj.parent)
	end);
	--
	obj.editbox2:SetScript("OnShow",function(self)
		local spell = obj.editbox:GetText();
		local typ = obj.typebutton.val or 1;
		self:SetText(FW_FilterColorString(obj.s[obj.o][spell] and obj.s[obj.o][spell][typ]));
	end);
	obj.editbox2:SetScript("OnEnterPressed",function(self)
		local spell = obj.editbox:GetText();
		local typ = obj.typebutton.val or 1;
		local c1,c2,c3 = FW_StringToColor(self:GetText());
		if c1 then
			obj.s[obj.o][spell][typ][2] = c1;
			obj.s[obj.o][spell][typ][3] = c2;
			obj.s[obj.o][spell][typ][4] = c3;
			if obj.func then obj.func(spell); end
		end
		FW_SetFilterColor(obj.s[obj.o][spell][typ],obj.parent);
		self:SetText(FW_FilterColorString(obj.s[obj.o][spell] and obj.s[obj.o][spell][typ]));
		self:ClearFocus();
	end);
	obj.editbox2:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		local spell = obj.editbox:GetText();
		local typ = obj.typebutton.val or 1;
		self:SetText(FW_FilterColorString(obj.s[obj.o][spell] and obj.s[obj.o][spell][typ]));
	end);
	--
	obj.colorswatch:SetScript("OnClick",function(self)
		CloseMenus();
		local spell = obj.editbox:GetText();
		local typ = obj.typebutton.val or 1;
		ColorPickerFrame.func = FW_FilterColorPickerApply;
		ColorPickerFrame.colorswatch = self;
		ColorPickerFrame.setting = obj.s[obj.o][spell][typ];
		ColorPickerFrame.hasOpacity = nil;
		
		ColorPickerFrame:SetColorRGB(ColorPickerFrame.setting[2],ColorPickerFrame.setting[3],ColorPickerFrame.setting[4]);
		
		if not ColorPickerFrame.previousValues then ColorPickerFrame.previousValues = {}; end
		ColorPickerFrame.previousValues[1] = ColorPickerFrame.setting[2];
		ColorPickerFrame.previousValues[2] = ColorPickerFrame.setting[3];
		ColorPickerFrame.previousValues[3] = ColorPickerFrame.setting[4];
		ColorPickerFrame.previousValues[4] = nil;	
		ColorPickerFrame.cancelFunc = FW_FilterColorPickerCancel;
		ShowUIPanel(ColorPickerFrame);
	end);
	obj.colorswatch:SetScript("OnEnter",function(self)
		self.backgroundtexture:SetVertexColor(1.00,1.00,1.00);
		FW:ShowOptionsTip(self);
	end);
	obj.colorswatch:SetScript("OnLeave",function(self)
		self.backgroundtexture:SetVertexColor(1.00,0.82,0.00);
		FW:HideTip(self);
	end);
	--
	obj.typebutton:SetScript("OnShow",function(self)
		self:SetText(FW:TypeName(self.val,self.list));
	end);
	--
	obj.editbox:SetScript("OnClick",function(self)
		obj.parent.typebutton.val = obj.typebutton.val;
		obj.parent.typebutton:SetText(FW:TypeName(obj.typebutton.val,obj.typebutton.list));
		obj.parent.editbox:SetText("");
		obj.parent.editbox:SetText(self:GetText());
	end);
	--[[
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);]]
	
	return obj;
end

local function NewFilterOption(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;
	
	local filter = obj.o;
	
	obj.items = {};
	obj.NewFilterListItem = NewFilterListItem;
	
	obj.Finalize = function(self,i)
		while obj.items[i] and obj.items[i]:IsShown() do
			obj.items[i]:Hide();
			i=i+1;
		end
	end
	
	obj:EnableMouse(1);
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetHeight(20);
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",24,0);
	
	obj.background = obj:CreateTexture(nil,"BACKGROUND");
	obj.background:SetAllPoints(obj);
	obj.background:SetTexture(1,1,0,0.2);
	
	obj.default = NewDefaultButton(obj);
	
	obj.editbox2 = NewEditBox(obj);
	obj.editbox2:SetWidth(80);
	obj.editbox2:SetHeight(14);
	obj.editbox2:SetPoint("RIGHT",obj.default,"LEFT",-5,0);

	obj.colorswatch = NewButton(obj)
	obj.colorswatch:SetWidth(18);
	obj.colorswatch:SetHeight(18);
	obj.colorswatch:SetPoint("RIGHT",obj.editbox2,"LEFT",0,0);
	obj.colorswatch:SetNormalTexture("Interface\\ChatFrame\\ChatFrameColorSwatch");
	obj.colorswatch.normaltexture = obj.colorswatch:GetNormalTexture();
	obj.colorswatch.backgroundtexture = obj.colorswatch:CreateTexture(nil,"BACKGROUND");
	obj.colorswatch.backgroundtexture:SetWidth(16);
	obj.colorswatch.backgroundtexture:SetHeight(16);
	obj.colorswatch.backgroundtexture:SetPoint("CENTER",obj.colorswatch,"CENTER",0,0);	
	obj.colorswatch.backgroundtexture:SetTexture(0.8,0.8,0.8);
	obj.colorswatch.backgroundtexture:SetVertexColor(1.0,0.82,0.0);
	
	if not filterdropdown then
		filterdropdown = NewDropdown(FWOptions,function()
			filterdropdown:SetWidth(80);
			local i=0;
			local f;
			for key,val in ipairs(filterdropdown.button.list) do
				i=i+1;
				f = filterdropdown.items[i] or filterdropdown:NewFilterButton(i);
				
				f:SetPoint("TOPLEFT",filterdropdown, "TOPLEFT",5,13-i*18);
				f:SetText(val[2]);
				f:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
				f.val=val[1];
				f:Show();
			end
			filterdropdown:SetHeight(i*18+8);
			filterdropdown:Finalize(i+1);
		end);
	end
	
	obj.actionbutton = NewDropdownShowButton(obj,filterdropdown)
	obj.actionbutton:SetWidth(70);
	obj.actionbutton:SetPoint("RIGHT",obj.colorswatch,"LEFT",-5,0);
	
	obj.typebutton = NewDropdownShowButton(obj,filterdropdown)
	obj.typebutton:SetWidth(70);
	obj.typebutton:SetPoint("RIGHT",obj.actionbutton,"LEFT",-5,0);
	
	obj.expandbutton = NewTexturedButton(obj,"Interface\\Buttons\\UI-GuildButton-PublicNote-Up")
	obj.expandbutton:SetWidth(16);
	obj.expandbutton:SetHeight(16);
	obj.expandbutton:SetPoint("LEFT",obj,"LEFT",7,0);
	
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.typebutton,"LEFT",-5,0);
	obj.editbox:SetText("enter ability/spell/item name");
	obj.editbox:SetJustifyH("LEFT");

	-- scripts
	obj.val = 1; -- ????
	obj.actionbutton.val = 0;
	obj.typebutton.val = 1;
	obj.expand = false;
	
	obj.colorswatch.title = FWL.CLICK_TO_EDIT;
	obj.colorswatch.tip = FWL.CLICK_TO_EDIT_TT;
	obj.expandbutton.title = FWL.TOGGLE_FILTER_LIST;
	obj.expandbutton.tip = "";
	
	--
	obj.default:SetScript("OnClick",function(self)
		-- resets als filters of this spell name!!!
		local spell = obj.editbox:GetText();
		local typ = 1;
		local action = 0;
		if obj.d[filter][spell] then
			if not obj.s[filter][spell] then
				obj.s[filter][spell] = {};
			else
				for k in pairs(obj.s[filter][spell]) do
					if not obj.d[filter][spell][k] then
						obj.s[filter][spell][k] = nil;
					end
				end
			end
			for k in pairs(obj.d[filter][spell]) do
				typ = k;
				if not obj.s[filter][spell][k] then
					obj.s[filter][spell][k] = {};
				end
				action = obj.d[filter][spell][k][1];
				obj.s[filter][spell][k][1] = obj.d[filter][spell][k][1];
				obj.s[filter][spell][k][2] = obj.d[filter][spell][k][2];
				obj.s[filter][spell][k][3] = obj.d[filter][spell][k][3];
				obj.s[filter][spell][k][4] = obj.d[filter][spell][k][4];
			end
		else
			obj.s[filter][spell]=nil;
		end
		obj.func(spell);
		obj.actionbutton:SetText(FW:TypeName(action,obj.actionbutton.list));
		obj.typebutton:SetText(FW:TypeName(typ,obj.typebutton.list));
		FW_SetFilterColor(obj.s[filter][spell] and obj.s[filter][spell][typ],obj);
		
		FW_ToggleFilterList();  -- rebuild filter list
	end);
	--
	obj.editbox2:SetScript("OnShow",function(self)
		local spell = obj.editbox:GetText();
		local typ = obj.typebutton.val or 1;
		self:SetText(FW_FilterColorString(obj.s[filter][spell] and obj.s[filter][spell][typ]));
	end);
	obj.editbox2:SetScript("OnEnterPressed",function(self)
		local spell = obj.editbox:GetText();
		local typ = obj.typebutton.val or 1;
		local c1,c2,c3 = FW_StringToColor(self:GetText());
		if c1 then
			obj.s[filter][spell][typ][2] = c1;
			obj.s[filter][spell][typ][3] = c2;
			obj.s[filter][spell][typ][4] = c3;
			if obj.func then obj.func(spell); end
		end
		FW_SetFilterColor(obj.s[filter][spell][typ],obj);
		self:SetText(FW_FilterColorString(obj.s[filter][spell] and obj.s[filter][spell][typ]));
		self:ClearFocus();
	end);
	obj.editbox2:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		local spell = obj.editbox:GetText();
		local typ = obj.typebutton.val or 1;
		self:SetText(FW_FilterColorString(obj.s[filter][spell] and obj.s[filter][spell][typ]));
	end);
	--
	obj.colorswatch:SetScript("OnClick",function(self)
		CloseMenus();
		local spell = obj.editbox:GetText();
		local typ = obj.typebutton.val or 1;
		ColorPickerFrame.func = FW_FilterColorPickerApply;
		ColorPickerFrame.colorswatch = self;
		ColorPickerFrame.setting = obj.s[filter][spell][typ];
		ColorPickerFrame.hasOpacity = nil;
		
		ColorPickerFrame:SetColorRGB(ColorPickerFrame.setting[2],ColorPickerFrame.setting[3],ColorPickerFrame.setting[4]);
		
		if not ColorPickerFrame.previousValues then ColorPickerFrame.previousValues = {}; end
		ColorPickerFrame.previousValues[1] = ColorPickerFrame.setting[2];
		ColorPickerFrame.previousValues[2] = ColorPickerFrame.setting[3];
		ColorPickerFrame.previousValues[3] = ColorPickerFrame.setting[4];
		ColorPickerFrame.previousValues[4] = nil;	
		ColorPickerFrame.cancelFunc = FW_FilterColorPickerCancel;
		ShowUIPanel(ColorPickerFrame);
	end);
	obj.colorswatch:SetScript("OnEnter",function(self)
		self.backgroundtexture:SetVertexColor(1.00,1.00,1.00);
		FW:ShowOptionsTip(self);
	end);
	obj.colorswatch:SetScript("OnLeave",function(self)
		self.backgroundtexture:SetVertexColor(1.00,0.82,0.00);
		FW:HideTip(self);
	end);
	--
	obj.typebutton:SetScript("OnShow",function(self)
		self:SetText(FW:TypeName(self.val,self.list));
	end);
	--
	obj.expandbutton:SetScript("OnClick",function(self)
		obj.expand = not obj.expand;
		FW_ToggleFilterList();  -- rebuild filter list
	end);
	obj.expandbutton:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj.expandbutton:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	--
	obj.editbox:SetScript("OnShow",function(self)
		FW_FilterSpellUpdate(obj);
	end);
	obj.editbox:SetScript("OnChar",function(self)
		FW_AutoComplete(self,obj.s[filter],FW.SpellInfo,FW.CooldownsPet,FW.CooldownsSpells,FW.CooldownsBuffs);
	end);
	obj.editbox:SetScript("OnTextChanged",function(self)
		FW_FilterSpellUpdate(obj);
	end);
	obj.editbox:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewMessage0Option(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;
	
	obj:EnableMouse(1);
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",10,0);
	
	obj.default = NewDefaultButton(obj);
		
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetWidth(70);
	obj.editbox:SetHeight(14);
	obj.editbox:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.default,"LEFT",-5,0);
	
	-- scripts
	obj.default:SetScript("OnClick",function(self)
		obj.editbox:SetText(obj.d[obj.o]);
		obj.s[obj.o] = obj.d[obj.o];
		if obj.func then obj.func(); end
	end);
	--
	obj.editbox:SetScript("OnEnterPressed",function(self)
		obj.s[obj.o] = self:GetText();
		if obj.func then obj.func(); end
		self:ClearFocus();
	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewMessage1Option(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;
	
	obj:EnableMouse(1);
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",30,0);
	
	obj.checkbutton = NewCheckButton(obj);
	obj.checkbutton:SetPoint("LEFT",obj,"LEFT",5,0);
	
	obj.default = NewDefaultButton(obj);
		
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetWidth(70);
	obj.editbox:SetHeight(14);
	obj.editbox:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.default,"LEFT",-5,0);
	
	-- scripts
	obj.checkbutton:SetScript("OnClick",function(self)
		obj.s[obj.o] = not obj.s[obj.o];
		self:SetChecked(obj.s[obj.o]);
		if obj.func then obj.func(); end
	end);
	obj.checkbutton:SetScript("OnShow",function(self)
		self:SetChecked(obj.s[obj.o]);
	end);
	--
	obj.default:SetScript("OnClick",function(self)
		obj.editbox:SetText(obj.d[obj.o.."Msg"]);
		obj.s[obj.o.."Msg"] = obj.d[obj.o.."Msg"];
		obj.checkbutton:SetChecked(obj.d[obj.o]);
		obj.s[obj.o] = obj.d[obj.o];
		if obj.func then obj.func(); end
	end);
	--
	obj.editbox:SetScript("OnShow",function(self)
		self:SetText(obj.s[obj.o.."Msg"]);
	end);
	obj.editbox:SetScript("OnEnterPressed",function(self)
		obj.s[obj.o.."Msg"] = self:GetText();
		if obj.func then obj.func(); end
		self:ClearFocus();
	end);
	obj.editbox:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(obj.s[obj.o.."Msg"]);

	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewMessage2Option(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;

	obj:EnableMouse(1);
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",50,0);
	
	obj.checkbutton1 = NewCheckButton(obj);
	obj.checkbutton1:SetPoint("LEFT",obj,"LEFT",5,0);

	obj.checkbutton2 = NewCheckButton(obj);
	obj.checkbutton2:SetPoint("LEFT",obj.checkbutton1,"RIGHT",0,0);
	
	obj.default = NewDefaultButton(obj);
		
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetWidth(70);
	obj.editbox:SetHeight(14);
	obj.editbox:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.default,"LEFT",-5,0);
	
	-- scripts
	obj.checkbutton1:SetScript("OnClick",function(self)
		if bit.band(1,obj.s[obj.o]) == 0 then
			obj.s[obj.o] = bit.bor(obj.s[obj.o],1);
			self:SetChecked(true);
		else
			obj.s[obj.o] = bit.bxor(obj.s[obj.o],1);
			self:SetChecked(false);
		end
		if obj.func then obj.func(); end
	end);
	obj.checkbutton1:SetScript("OnShow",function(self)
		self:SetChecked( bit.band(1,obj.s[obj.o]) ~= 0 );
	end);
	obj.checkbutton2:SetScript("OnClick",function(self)
		if bit.band(2,obj.s[obj.o]) == 0 then
			obj.s[obj.o] = bit.bor(obj.s[obj.o],2);
			self:SetChecked(true);
		else
			obj.s[obj.o] = bit.bxor(obj.s[obj.o],2);
			self:SetChecked(false);
		end
		if obj.func then obj.func(); end
	end);
	obj.checkbutton2:SetScript("OnShow",function(self)
		self:SetChecked( bit.band(2,obj.s[obj.o]) ~= 0 );
	end);
	--
	obj.default:SetScript("OnClick",function(self)
		obj.editbox:SetText(obj.d[obj.o.."Msg"]);
		obj.s[obj.o.."Msg"] = obj.d[obj.o.."Msg"];
		obj.checkbutton1:SetChecked( bit.band(1,obj.d[obj.o]) ~= 0 );
		obj.checkbutton2:SetChecked( bit.band(2,obj.d[obj.o]) ~= 0 );
		obj.s[obj.o] = obj.d[obj.o];
		if obj.func then obj.func(); end
	end);
	--
	obj.editbox:SetScript("OnShow",function(self)
		self:SetText(obj.s[obj.o.."Msg"]);
	end);
	obj.editbox:SetScript("OnEnterPressed",function(self)
		obj.s[obj.o.."Msg"] = self:GetText();
		if obj.func then obj.func(); end
		self:ClearFocus();
	end);
	obj.editbox:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(obj.s[obj.o.."Msg"]);
	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewLinkOption(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;
	
	obj:EnableMouse(1);
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",10,0);
	
	obj.default = NewDefaultButton(obj);
		
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetWidth(70);
	obj.editbox:SetHeight(14);
	obj.editbox:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.default,"LEFT",-5,0);
	obj.editbox:SetMaxLetters(128);
	
	-- scripts
	obj.editbox.title = FW.L.CLICK_TO_COPY;
	obj.editbox.tip = "";
	
	obj.default:SetScript("OnClick",function(self)
		obj.editbox:SetFocus();
		obj.editbox:HighlightText();
	end);
	--
	obj.editbox:SetScript("OnShow",function(self)
		self:SetText(obj.o);
	end);
	obj.editbox:SetScript("OnEnterPressed",function(self)
		self:ClearFocus();
	end);
	obj.editbox:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
	end);
	obj.editbox:SetScript("OnTextChanged",function(self)
		if self:GetText() ~= obj.o then
			self:SetText(obj.o);
		end
	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewNumberOption(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;
	
	obj:EnableMouse(1);	
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",10,0);
	
	obj.default = NewDefaultButton(obj);
		
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetWidth(70);
	obj.editbox:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.default,"LEFT",-5,0);

	-- scripts
	obj.default:SetScript("OnClick",function(self)
		obj.editbox:SetText(obj.d[obj.o]);
		obj.s[obj.o] = obj.d[obj.o];
		if obj.func then obj.func(); end
	end);
	--
	obj.editbox:SetScript("OnEnterPressed",function(self)
		local num = FW:NumberCheck(self);
		if num then
			obj.s[obj.o] = num;
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o]);
		end
		self:ClearFocus();
	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewNumber2Option(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;
	
	obj:EnableMouse(1);	
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",30,0);
	
	obj.checkbutton = NewCheckButton(obj);
	obj.checkbutton:SetPoint("LEFT",obj,"LEFT",5,0);
	
	obj.default = NewDefaultButton(obj);
		
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetWidth(70);
	obj.editbox:SetHeight(14);
	obj.editbox:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.default,"LEFT",-5,0);
	
	-- scripts
	obj.checkbutton:SetScript("OnClick",function(self)
		obj.s[obj.o.."Enable"] = not obj.s[obj.o.."Enable"];
		self:SetChecked(obj.s[obj.o.."Enable"]);
		if obj.func then obj.func(); end
	end);
	obj.checkbutton:SetScript("OnShow",function(self)
		self:SetChecked(obj.s[obj.o.."Enable"]);
	end);
	--
	obj.default:SetScript("OnClick",function(self)
		obj.editbox:SetText(obj.d[obj.o]);
		obj.s[obj.o] = obj.d[obj.o];
		obj.checkbutton:SetChecked(obj.d[obj.o.."Enable"]);
		obj.s[obj.o.."Enable"] = obj.d[obj.o.."Enable"];
		if obj.func then obj.func(); end
	end);
	--
	obj.editbox:SetScript("OnEnterPressed",function(self)
		local num = FW:NumberCheck(self);
		if num then
			obj.s[obj.o] = num;
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o]);
		end
		self:ClearFocus();
	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewFontOption(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;
	
	obj:EnableMouse(1);
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetWidth(65);
	obj.text:SetHeight(20);
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",10,0);

	obj.default = NewDefaultButton(obj);
	
	if not fontdropdown then
		fontdropdown = NewDropdown(FWOptions,function()
			local j=0;
			local f;
			for i, data in ipairs(FW.FontList) do
				f = fontdropdown.items[j] or fontdropdown:NewFontButton(j);
				f:SetText(data[2]);
				f:SetFont(data[1],11);
				f.val=data[1];
				f:SetPoint("TOPLEFT",fontdropdown, "TOPLEFT",5+(j%3)*142,-5-math.floor(j/3)*18);
				f:Show();
				j=j+1;
			end
			fontdropdown:SetHeight(math.floor((j-1)/3)*18+26);	
			fontdropdown:SetWidth((142)*3+8);
			fontdropdown:Finalize(j+1);
		end);
	end
	obj.button = NewDropdownShowButton(obj,fontdropdown)
	obj.button:SetWidth(140);
	obj.button:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	
	obj.editbox2 = NewEditBox(obj);
	obj.editbox2:SetWidth(22);
	obj.editbox2:SetPoint("LEFT",obj.button,"RIGHT",5,0);
	obj.editbox2.minimum = 8;
	obj.editbox2.maximum = 16;
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetPoint("LEFT",obj.editbox2,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.default,"LEFT",-5,0);

	--scripts
	obj.default:SetScript("OnClick",function(self)
		obj.editbox:SetText(obj.d[obj.o]);
		obj.editbox2:SetText(obj.d[obj.o.."Size"]);
		obj.button:SetText(FW:FontName(obj.d[obj.o]));
		obj.button:SetFont(obj.d[obj.o],obj.d[obj.o.."Size"]);

		obj.s[obj.o] = obj.d[obj.o];
		obj.s[obj.o.."Size"] = obj.d[obj.o.."Size"];
		if obj.func then obj.func(); end
	end);
	--
	obj.button:SetScript("OnShow",function(self)
		self:SetText(FW:FontName(obj.s[obj.o]));
		self:SetFont(obj.s[obj.o],obj.s[obj.o.."Size"]);
	end);
	--
	obj.editbox2:SetScript("OnShow",function(self)
		self:SetText(obj.s[obj.o.."Size"]);
	end);
	obj.editbox2:SetScript("OnEnterPressed",function(self)
		local txt = FW:NumberCheck(self);
		if txt then
			obj.s[obj.o.."Size"] = txt;
			self:SetText(obj.s[obj.o.."Size"]);
			obj.button:SetFont(obj.s[obj.o],obj.s[obj.o.."Size"]);
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o.."Size"]);
		end
		self:ClearFocus();
	end);
	obj.editbox2:SetScript("OnEditFocusLost",function(self)
		self:HighlightText(0,0);
		self:SetText(obj.s[obj.o.."Size"]);
	end);
	--
	obj.editbox:SetScript("OnEnterPressed",function(self)
		local txt = self:GetText();
		if txt and txt~="" then
			obj.s[obj.o] = txt;
			self:SetText(obj.s[obj.o]);
			obj.button:SetText(FW:FontName(obj.s[obj.o]));
			obj.button:SetFont(obj.s[obj.o],obj.s[obj.o.."Size"]);
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o]);
		end
		self:ClearFocus();
	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

local function NewTextureOption(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.o = o;
	obj.s = s or FW.Settings;
	obj.d = d or FW.Default;
	obj.parent = parent;

	obj:EnableMouse(1);
	obj:SetWidth(560);
	obj:SetHeight(20);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetWidth(65);
	obj.text:SetHeight(20);
	obj.text:SetJustifyH("LEFT");
	obj.text:SetPoint("LEFT",obj,"LEFT",10,0);
	
	obj.default = NewDefaultButton(obj);

	if not texturedropdown then
		texturedropdown = NewDropdown(FWOptions,function()
			local j=0;
			local s;
			for i, texture in ipairs(FW.TextureList) do
				s = texturedropdown.items[j] or texturedropdown:NewTextureButton(j);
				s:SetNormalTexture(texture);
				s.val=texture;
				s:SetPoint("TOPLEFT",texturedropdown, "TOPLEFT",5+(j%3)*142,-5-math.floor(j/3)*18);
				s:Show();
				j=j+1;
			end
			texturedropdown:SetWidth((142)*3+8);
			texturedropdown:SetHeight(math.floor((j-1)/3)*18+26);
			texturedropdown:Finalize(j+1);
		end);
	end
	
	obj.button = NewButton(obj)
	obj.button:SetWidth(140);
	obj.button:SetHeight(14);
	obj.button:SetPoint("LEFT",obj.text,"RIGHT",5,0);
	obj.button:SetNormalTexture("Interface\\PaperDollInfoFrame\\UI-Character-Skills-Bar");
	obj.button.normaltexture = obj.button:GetNormalTexture();
	obj.button.normaltexture:SetVertexColor(1.00,0.88,0.50);
	
	obj.editbox = NewEditBox(obj);
	obj.editbox:SetPoint("LEFT",obj.button,"RIGHT",5,0);
	obj.editbox:SetPoint("RIGHT",obj.default,"LEFT",-5,0);

	--scripts
	obj.default:SetScript("OnCLick",function(self)
		obj.editbox:SetText(obj.d[obj.o]);
		obj.button:SetNormalTexture(obj.d[obj.o]);
		obj.s[obj.o] = obj.d[obj.o];
		if obj.func then obj.func(); end
	end);
	--
	obj.button:SetScript("OnShow",function(self)
		self:SetNormalTexture(obj.s[obj.o]);
	end);
	obj.button:SetScript("OnEnter",function(self)
		self.normaltexture:SetVertexColor(1.00,1.00,1.00);
		texturedropdown.button = self;
		texturedropdown:Build();
		texturedropdown:SetPoint("TOPLEFT",self, "BOTTOMLEFT",-5,0);
		texturedropdown:Show();
	end);
	obj.button:SetScript("OnLeave",function(self)
		self.normaltexture:SetVertexColor(1.00,0.88,0.50);
		if not texturedropdown.over then
			texturedropdown:Hide();
		end
	end);
	--
	obj.editbox:SetScript("OnEnterPressed",function(self)
		local txt = self:GetText();
		if txt and txt~="" then
		
			if string.find(txt,"\\") then
				obj.s[obj.o] = txt;
			else
				obj.s[obj.o] = "Interface\\AddOns\\Forte_Core\\Textures\\"..txt;
			end
			self:SetText(obj.s[obj.o]);
			obj.button:SetNormalTexture(obj.s[obj.o]);
			if obj.func then obj.func(); end
		else
			self:SetText(obj.s[obj.o]);
		end
		self:ClearFocus();
	end);
	--
	obj:SetScript("OnEnter",function(self)
		FW:ShowOptionsTip(self);
	end);
	obj:SetScript("OnLeave",function(self)
		FW:HideTip(self);
	end);
	
	return obj;
end

--[[
local function NewOptions()
	local obj = CreateFrame("Frame",nil,UIParent);
	obj.parent = UIParent;
	obj:SetWidth(600);
	obj:SetHeight(500);
	obj:SetBackdropColor(0.00,0.00,0.00,0.20);
	obj:SetBackdropBorderColor(0.00,0.00,0.00,0.20);

	obj.background = obj:CreateTexture(nil,"BACKGROUND");
	obj.background:SetTexture("Interface\\AddOns\\Forte_Core\\Textures\\XusLogo");
	obj.background:SetWidth(512);
	obj.background:SetHeight(256);
	obj.background:SetPoint("CENTER",obj,"CENTER",0,0);
	obj.background:SetVertexColor(1,1,1,0.3);
	
	obj.header = CreateFrame("Frame",nil,obj);
	obj.header:SetWidth(600);
	obj.header:SetHeight(20);
	obj.header:SetPoint("TOPLEFT",obj,"TOPLEFT",0,0);
	
	obj.header.icon = obj.header:CreateTexture(nil,"ARTWORK");
	obj.header.icon:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes");
	obj.header.icon:SetWidth(14);
	obj.header.icon:SetHeight(14);
	obj.header.icon:SetPoint("LEFT",obj.header,"LEFT",3,0);
	
	obj.header.title = obj.header:CreateFontString(nil,"ARTWORK","FWFontHighlight");
	obj.header.title:SetWidth(14);
	obj.header.title:SetHeight(14);
	obj.header.title:SetPoint("CENTER",obj.header,"CENTER",0,0);
	
	obj.close = CreateFrame("Button",nil,obj);
	obj.close:SetPoint("TOPRIGHT",obj,"TOPRIGHT",0,0);
	obj.close:SetNormalTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Up");
	obj.close:SetPushedTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Down");
	obj.close:SetHighlightTexture("Interface\\Buttons\\UI-Panel-MinimizeButton-Highlight");
	obj.close.highlighttexture = obj.close:GetHighlightTexture();
	obj.close.highlighttexture:SetBlendMode("ADD");
	obj.close.highlighttexture:SetDesaturated(1);
	
	obj.scrollframe = CreateFrame("ScrollFrame",nil,obj,"UIPanelScrollFrameTemplate");
	obj.scrollframe:SetWidth(560);
	obj.scrollframe:SetHeight(460);
	obj.scrollframe:SetPoint("TOPLEFT",obj,"TOPLEFT",10,-30);
	obj.content = obj.scrollframe:GetScrollChild();
	obj.content:SetWidth(560);
	obj.content:SetHeight(360);
	
	--scripts
	tinsert(UISpecialFrames,obj:GetName());	
	
	obj.close:SetScript("OnClick",function(self)
		FWOptions.show = 0;
	end);
	obj.scrollframe:SetScript("OnVerticalScroll",function(self)
		local scrollbar = getglobal(self:GetName().."ScrollBar");
		scrollbar:SetValue(arg1);
		local min;
		local max;
		min, max = scrollbar:GetMinMaxValues();
		if ( arg1 == 0 ) then
			getglobal(scrollbar:GetName().."ScrollUpButton"):Disable();
		else
			getglobal(scrollbar:GetName().."ScrollUpButton"):Enable();
		end
		if ((scrollbar:GetValue() - max) == 0) then
			getglobal(scrollbar:GetName().."ScrollDownButton"):Disable();
		else
			getglobal(scrollbar:GetName().."ScrollDownButton"):Enable();
		end
		
		FW:HideUnneededOptions();
	end);
	--
	obj:SetScript("OnMouseDown",function(self)
		FW:StartMoving(arg1);
	end);
	--
	obj:SetScript("OnMouseUp",function(self)
		FW:StopMoving();
	end);
	obj:SetScript("OnHide",function(self)
		FWOptions.show = 0;
	end);

	return obj;
end]]

local function NewImageOption(parent,o,s,d)
	local obj = CreateFrame("Frame",nil,parent);
	obj.parent = parent;
	
	obj.image = obj:CreateTexture(nil,"ARTWORK");
	obj.image:SetTexture(o);
	--obj.image:SetAllPoints(obj);
	obj.image:SetPoint("CENTER",obj,"CENTER");
	--obj.image:SetPoint("TOPLEFT",obj,"TOPLEFT",5,-5);
	--obj.image:SetPoint("BOTTOMRIGHT",obj,"BOTTOMRIGHT",-5,5);
	
	obj.text = obj:CreateFontString(nil,"ARTWORK","FWFontNormal");
	obj.text:SetHeight(20);
	obj.text:SetJustifyH("CENTER");
	obj.text:SetPoint("BOTTOM",obj,"BOTTOM",0,-5);
	
	return obj;
end

local createOption = {
	[FW.CHK] = NewCheckOption,
	[FW.NUM] = NewNumberOption,
	[FW.NU2] = NewNumber2Option,
	[FW.MS0] = NewMessage0Option,
	[FW.MSG] = NewMessage1Option,
	[FW.MS2] = NewMessage2Option,
	[FW.SND] = NewSoundOption,
	[FW.INF] = NewInfoOption,
	[FW.URL] = NewLinkOption,
	[FW.FNT] = NewFontOption,
	[FW.COL] = NewColorOption,
	[FW.CO2] = NewColor2Option,
	[FW.FIL] = NewFilterOption,
	[FW.TXT] = NewTextureOption,
	[FW.BAC] = NewBackdropOption,
	[FW.IMG] = NewImageOption,
}
------------------------------------------------------------
-- END ALL INTERFACE TEMPLATES
------------------------------------------------------------

FW.NON = 0;
--FW.LEF = 1;
--FW.RIG = 2;
FW.LAS = 99;

FW.ICON_DEFAULT = "Interface\\GossipFrame\\BinderGossipIcon";
FW.ICON_PROFILE = "Interface\\Buttons\\UI-GuildButton-PublicNote-Up";
FW.ICON_HINT = "Interface\\GossipFrame\\AvailableQuestIcon";
FW.ICON_FAQ = "Interface\\GossipFrame\\ActiveQuestIcon";
FW.ICON_APPEARANCE = "Interface\\Icons\\INV_Enchant_ShardPrismaticLarge";
FW.ICON_FILTER = "Interface\\Icons\\INV_Ingot_Eternium";
FW.ICON_BASIC = "Interface\\Buttons\\UI-CheckBox-Check-Disabled";
FW.ICON_SPECIFIC = "Interface\\Buttons\\UI-CheckBox-Check";
FW.ICON_SIZE = "Interface\\Minimap\\UI-Minimap-ZoomInButton-Up";
FW.ICON_GENERAL = "Interface\\QuestFrame\\UI-QuestLog-BookIcon";
FW.ICON_SOULBAG = "Interface\\Icons\\INV_Misc_Bag_CoreFelclothBag";

FW.ICON_CD = "Interface\\Icons\\Spell_Shadow_LastingAfflictions";
FW.ICON_HS = "Interface\\AddOns\\Forte_Core\\Textures\\HS1";
FW.ICON_SS = "Interface\\AddOns\\Forte_Core\\Textures\\SS1";
FW.ICON_SH = "Interface\\AddOns\\Forte_Core\\Textures\\SH1";
FW.ICON_SU = "Interface\\AddOns\\Forte_Core\\Textures\\SU1";
FW.ICON_ST = "Interface\\AddOns\\Forte_Core\\Textures\\ST";

FW.ICON_TALENT = "Interface\\Icons\\Ability_Marksmanship";
FW.ICON_MESSAGE = "Interface\\GossipFrame\\PetitionGossipIcon";
FW.ICON_SELFMESSAGE = "Interface\\GossipFrame\\GossipGossipIcon";
FW.ICON_SOUND = "Interface\\Buttons\\UI-GuildButton-MOTD-Up";
FW.ICON_DELETE = "Interface\\Glues\\Login\\Glues-CheckBox-Check";
FW.ICON_CREATE = "Interface\\Buttons\\UI-GuildButton-PublicNote-Up";

local function FC_SetBackgroundImage()
	local w = FWOptions:GetWidth()-10;
	local h = FWOptions:GetHeight()-10;
	local ar = 1; -- aspect ratio of my image
	local a = w/h; -- aspect ratio of frame
	FWOptionsBackground:SetWidth(w);
	FWOptionsBackground:SetHeight(h);
	if ar >= a then
		-- change height textcoords
		FWOptionsBackground:SetTexCoord(0.5*(1-a/ar),1-0.5*(1-a/ar),0,1);
	else
		-- change width textcoords
		FWOptionsBackground:SetTexCoord(0,1,0.5*(1-ar/a),1-0.5*(1-ar/a));
	end

	--[[
	if a >= ar then
		FWOptionsBackground:SetWidth(h*ar);
		FWOptionsBackground:SetHeight(h);
	else
		FWOptionsBackground:SetWidth(w);
		FWOptionsBackground:SetHeight(w/ar);
	end
	]]
end

function FW:SetFilterName(filter,name,typ)
	local obj = Anchors[filter];
	if typ then
		obj.typebutton.val = typ;
		obj.typebutton:SetText(FW:TypeName(obj.typebutton.val,obj.typebutton.list));
	end
	obj.editbox:SetText(name);

end

function FW:ShowOptionsTip(self)
	if self.tip and self.title then
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
		GameTooltip:SetText(self.title, 1.0, 1.0, 1.0);
		GameTooltip:AddLine(self.tip, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
		GameTooltip:Show();
	end
end

function FW:ScrollTo(v,fo,instance)
	--FW:Show(v..":"..tostring(fo)..":"..tostring(instance));
	if not FW.Settings then
		return;
	end
	if not optionsbuilt then
		FW:BuildOptions();
	end
	if Anchors[v] then
		local scrollto = Anchors[v].top or 0;
		if not fo and FWOptions:IsVisible() and (abs(FWOptionsFrameScrollBar:GetValue() - scrollto)<1 or FWOptions.scrollto and abs(FWOptions.scrollto - scrollto)<1 ) then
			if not instance or instance == Anchors[v].main_data.selected then -- only hide if instance is also the same
				FW_HideOptions();
			end
		elseif FW.Settings.RightClickOptions or fo then
			if FWOptionsFrame.maxscroll < scrollto then scrollto=FWOptionsFrame.maxscroll end
			FWOptions.scrollto = scrollto;
			FW_ShowOptions();
		end
		if instance and Anchors[v].main_data[5] ~= instance then -- switch tab if needed
			Anchors[v].main_data[5] = instance;
			Anchors[v].main_data.selected = instance;
			FW:BuildOptions();
			FW:RefreshOptions();
		end
	end
end

local vis = 0;
local function FW_AutoShow()
	if FWOptions.show == 1 then

		if FW.Settings.AnimateScroll then
			if not FWOptions:IsShown() then
				FWOptions:Show();
			end
			if vis<1 then
				vis = vis+0.25;
				FWOptions:SetAlpha( FW.Settings.FWOptions.alpha*vis );
				FWOptions:SetScale( FW.Settings.FWOptions.scale*(0.75+0.25*vis) );
				FW:CorrectPosition(FWOptions);
			else
				FWOptions.show=nil;
			end
		else
			FWOptions:Show();
			FWOptions.show=nil;
		end
	elseif FWOptions.show == 0 then

		if FW.Settings.AnimateScroll then
			
			if vis>0.25 then
				if not FWOptions:IsShown() then -- looks silly, but its to still be able to close on ESC
					FWOptions:Show();
				end
				vis = vis-0.25;
				FWOptions:SetAlpha( FW.Settings.FWOptions.alpha*vis );
				FWOptions:SetScale( FW.Settings.FWOptions.scale*(0.75+0.25*vis) );
				FW:CorrectPosition(FWOptions);
			else
				FWOptions.show=nil;
				FWOptions:Hide();
			end
		else
			FWOptions:Hide();
			FWOptions.show=nil;
		end
	end
end
local maxd = 0.5;
function FW:AutoScroll()
	if this.scrollto then
		if FW.Settings.AnimateScroll then
			local val = FWOptionsFrameScrollBar:GetValue();
			local d = this.scrollto - val;
			if abs(d)<maxd or this.newval and abs(this.newval-val)>maxd then -- newval is used to stop autoscrolling if user scrolls himself
				FWOptionsFrameScrollBar:SetValue(this.scrollto);
				FWOptionsFrame:UpdateScrollChildRect();
				this.scrollto=nil;
				this.newval=nil;
			else
				this.newval = val+d/8;
				FWOptionsFrameScrollBar:SetValue(this.newval);
				FWOptionsFrame:UpdateScrollChildRect();
			end	
		else
			FWOptionsFrameScrollBar:SetValue(this.scrollto);
			FWOptionsFrame:UpdateScrollChildRect();
			if abs(FWOptionsFrameScrollBar:GetValue() - this.scrollto)<maxd then
				this.scrollto=nil;
			end
		end
	end
end

local maincat,mainicon,mainindex,color,frame,defaults,tab_data;
local subcat,subicon,subindex;

function FW:SetMainCategory(a1,a2,a3,a4,a5,a6,a7)
	maincat,mainicon,mainindex,color,frame,defaults,tab_data = a1,a2,a3,a4,a5,a6,a7;
end
function FW:SetSubCategory(a1,a2,a3)
	subcat,subicon,subindex = a1,a2,a3;
end

function FW:RegisterOption(typ,width,pos,text,tip,option,func,minimum,maximum)
	-- maincat: main category
	-- mainicon: icon for main category (nil for none)
	-- mainindex: priority index of this category
	-- frame: frame belonging to this category (nil for none)
	
	-- subcat: sub category ("" for not adding a sub category)
	-- subicon (nil for none)
	-- subindex: priority index of this sub category
	
	-- typ: the template to use
	-- width: the number of rows the option will take up (1 or 2)
	-- pos: preferred postion (0 = none)
	-- text: text for this option
	-- tip: tooltip displayed for this option (nil for none)
	-- func: function to execute after change (nil for none)
	
	local mc = FW_FindCategory(FW_Options,maincat);
	if not mc then
		mc = 1;
		while(mc<=#FW_Options and FW_Options[mc][3]<=mainindex) do
			mc=mc+1;
		end
		tinsert(FW_Options,mc,{maincat,mainicon,mainindex,color,frame,defaults,tab_data,{}});	
	end
	local sc = FW_FindCategory(FW_Options[mc][MAIN_DATA_TABLE],subcat);
	if not sc then
		sc = 1;
		while(sc<=#FW_Options[mc][MAIN_DATA_TABLE] and FW_Options[mc][MAIN_DATA_TABLE][sc][3]<=subindex) do
			sc=sc+1;
		end
		tinsert(FW_Options[mc][MAIN_DATA_TABLE],sc,{subcat,subicon,subindex,{}});
	end
	local o = FW_FindOption(FW_Options[mc][MAIN_DATA_TABLE][sc][4],typ,text)
	if not o then
		o = 1;
		while(o<=#FW_Options[mc][MAIN_DATA_TABLE][sc][4] and FW_Options[mc][MAIN_DATA_TABLE][sc][4][o][3]<=pos) do
			o=o+1;
		end
		tinsert(FW_Options[mc][MAIN_DATA_TABLE][sc][4],o,{typ,width,pos,text,tip,option,func,minimum,maximum});
	end
end

local function FC_SetOptionsFont()
	
	FWOptionsHeaderTitle:SetFont(FW.Settings.OptionsHeaderFont,FW.Settings.OptionsHeaderFontSize);

	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
	
		if main_data.tabs then
			for i, t in ipairs(main_data.tabs) do
				t.button:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize-2);
				t.editbox:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize-2);
				t:SetText(t.button.text:GetText()); -- do this to update tab sizes
			end
		end
		
		main_data.shortcut:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
		main_data.option.header.title:SetFont(FW.Settings.OptionsHeaderFont,FW.Settings.OptionsHeaderFontSize);
		main_data.option.frameheader.coordinates:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize-2);
		main_data.option.frameheader.alpha:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize-2);
		main_data.option.frameheader.scale:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize-2);

		for sub_index, sub_data in ipairs(main_data[MAIN_DATA_TABLE]) do -- SUB OPTION LEVEL
			
			if sub_data[1] and sub_data[1] ~= FW.NIL then
				sub_data.option.header.title:SetFont(FW.Settings.OptionsHeaderFont,FW.Settings.OptionsHeaderFontSize);
			end
			
			for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL
				
				if d[1] and d[1] ~= FW.NIL then
					
					d.option.text:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
					
					if d[1] == FW.URL or d[1] == FW.FIL or d[1] == FW.MSG or d[1] == FW.NUM or d[1] == FW.MS2 or d[1] == FW.PRO then
						d.option.editbox:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
					end
					
					if d[1] == FW.COL or d[1] == FW.CO2 or d[1] == FW.SND or d[1] == FW.TXT or d[1] == FW.FNT then 
						d.option.editbox:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize-2);
					end
					if d[1] == FW.FNT or d[1] == FW.SND then
						d.option.editbox2:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
					end
					if d[1] == FW.PRO or d[1] == FW.SND then
						d.option.button:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
					end
					if d[1] == FW.FIL then
						d.option.actionbutton:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
						d.option.typebutton:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
						d.option.editbox2:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize-2);
						
						FC_BuildFilterList(d.option); -- calling this because the font apply is embedded here
					end
					if d[1] == FW.BAC then
						d.option.bg:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize-2);
						d.option.border:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize-2);
						d.option.tilesize:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
						d.option.edge:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
						d.option.inset:SetFont(FW.Settings.OptionsFont,FW.Settings.OptionsFontSize);
					end
				end
			end
		end
	end
end

--[[
local function FW_FrameEnabled(frame)
	local index = frame.index;
	for sub_index, sub_data in ipairs(FW_Options[index][MAIN_DATA_TABLE]) do -- SUB OPTION LEVEL
		for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL
			if d[1] == FW.CHK then
				if strfind(d[6],"Enable$") then
					if FW_Options[index][6] then -- use the clone settings
						return FW.Settings[ FW_Options[index][5] ][ d[6] ],true;
					else -- use global settings
						return FW.Settings[ d[6] ],true;
					end
				else
					return false,false;
				end
			end
		end
	end
end]]

local extrabutton;
local function FC_SetOptionsColor()
	local r,g,b,a = unpack(FW.Settings.OptionHeaderColor);
	
	if FW.Settings.OptionsModuleColor then
		r,g,b = FW:MixColors2(0.5,FW.OPTION_COLOR.CLASS[1],FW.OPTION_COLOR.CLASS[2],FW.OPTION_COLOR.CLASS[3],r,g,b);
	end
	FWOptionsHeader:SetBackdropBorderColor(r,g,b,a);
	FWOptionsHeader:SetBackdropColor(r,g,b,a);
	
	-- dropdowns
	texturedropdown:SetBackdropBorderColor(r,g,b,a);
	fontdropdown:SetBackdropBorderColor(r,g,b,a);
	backdropdropdown:SetBackdropBorderColor(r,g,b,a);
	if filterdropdown then
		filterdropdown:SetBackdropBorderColor(r,g,b,a);
	end
	if sounddropdown then
		sounddropdown:SetBackdropBorderColor(r,g,b,a);
	end
	
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL

		main_data.option:SetBackdropColor(unpack(FW.Settings.OptionBackgroundColor));
		main_data.option:SetBackdropBorderColor(unpack(FW.Settings.OptionBackgroundColor));
		

		if FW.Settings.OptionsModuleColor then
			if FW.OPTION_COLOR[ main_data[4] ] then
				r,g,b = FW:MixColors(0.5,FW.OPTION_COLOR[ main_data[4] ],FW.Settings.OptionHeaderColor);
			else
				r,g,b = FW:MixColors(0.5,FW.OPTION_COLOR.CLASS,FW.Settings.OptionHeaderColor);
			end
		else
			r,g,b = unpack(FW.Settings.OptionHeaderColor);
		end
		
		if main_data.tabs then
			for i, t in ipairs(main_data.tabs) do
				if main_data.selected == t.savename then
					t:SetBackdropColor(r,g,b);
					t:SetBackdropBorderColor(r,g,b);
				else
					t:SetBackdropColor(unpack(FW.Settings.OptionBackgroundColor));
					t:SetBackdropBorderColor(unpack(FW.Settings.OptionBackgroundColor));
				end
			end
		end

		main_data.shortcut:SetBackdropBorderColor(r,g,b,1);
		main_data.shortcut:SetBackdropColor(r,g,b,1);
		main_data.option.normalheader:SetBackdropColor(r,g,b,a);
		main_data.option.normalheader:SetBackdropBorderColor(r,g,b,a);
		
		main_data.option.frameheader.leftframe:SetBackdropColor(r,g,b,a);
		main_data.option.frameheader.leftframe:SetBackdropBorderColor(r,g,b,a);
		main_data.option.frameheader.leftmidframe:SetBackdropColor(r,g,b,a);
		main_data.option.frameheader.leftmidframe:SetBackdropBorderColor(r,g,b,a);
		main_data.option.frameheader.midframe:SetBackdropColor(r,g,b,a);
		main_data.option.frameheader.midframe:SetBackdropBorderColor(r,g,b,a);
		main_data.option.frameheader.rightmidframe:SetBackdropColor(r,g,b,a);
		main_data.option.frameheader.rightmidframe:SetBackdropBorderColor(r,g,b,a);
		main_data.option.frameheader.rightframe:SetBackdropColor(r,g,b,a);
		main_data.option.frameheader.rightframe:SetBackdropBorderColor(r,g,b,a);
		
		for sub_index, sub_data in ipairs(main_data[MAIN_DATA_TABLE]) do -- SUB OPTION LEVEL
			if sub_data[1] and sub_data[1] ~= FW.NIL then
				sub_data.option.header:SetBackdropBorderColor(r,g,b,a);
				sub_data.option.header:SetBackdropColor(r,g,b,a);
			end
			
			for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL
					
				if d[1] then
					if d[1] == FW.CHK or d[1] == FW.NU2 or d[1] == FW.MSG or d[1] == FW.SND or d[1] == FW.CO2 or d[1] == FW.BAC then
						d.option.checkbutton.normaltexture:SetVertexColor(r,g,b);		
					elseif d[1] == FW.MS2 then
						d.option.checkbutton1.normaltexture:SetVertexColor(r,g,b);	
						d.option.checkbutton2.normaltexture:SetVertexColor(r,g,b);	
					end
				end
			end
		end
	end
	if extrabutton then
		extrabutton:SetBackdropBorderColor(r,g,b,1);
		extrabutton:SetBackdropColor(r,g,b,1);
	end
	a = 0.8;
	
	r,g,b = unpack(FW.Settings.OptionBackgroundColor);

	texturedropdown:SetBackdropColor(r,g,b,a);
	fontdropdown:SetBackdropColor(r,g,b,a);
	backdropdropdown:SetBackdropColor(r,g,b,a);
	if filterdropdown then filterdropdown:SetBackdropColor(r,g,b,a); end
	if sounddropdown then sounddropdown:SetBackdropColor(r,g,b,a); end
end


local bgbackdrop = {};
local subheaderbackdrop = {};
local function FC_SetOptionsBackdrop()
	FW:SetBackdrop(FWOptionsHeader,unpack(FW.Settings.OptionsHeaderBackdrop));
	FW:MakeBackdrop(bgbackdrop,unpack(FW.Settings.OptionsBackdrop));
	FW:MakeBackdrop(subheaderbackdrop,unpack(FW.Settings.OptionsSubHeaderBackdrop));
	
	-- dropdowns
	texturedropdown:SetBackdrop(bgbackdrop);
	fontdropdown:SetBackdrop(bgbackdrop);
	backdropdropdown:SetBackdrop(bgbackdrop);
	if filterdropdown then
		filterdropdown:SetBackdrop(bgbackdrop);
	end
	if sounddropdown then
		sounddropdown:SetBackdrop(bgbackdrop);
	end
	
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
		
		if main_data.tabs then
			for i, t in ipairs(main_data.tabs) do
				t:SetBackdrop(bgbackdrop);
			end
		end
		main_data.option:SetBackdrop(bgbackdrop);
	
		main_data.shortcut:SetBackdrop(FWOptionsHeader.backdrop);
		main_data.option.normalheader:SetBackdrop(FWOptionsHeader.backdrop);
		
		main_data.option.frameheader.leftframe:SetBackdrop(FWOptionsHeader.backdrop);
		main_data.option.frameheader.leftmidframe:SetBackdrop(FWOptionsHeader.backdrop);
		main_data.option.frameheader.midframe:SetBackdrop(FWOptionsHeader.backdrop);
		main_data.option.frameheader.rightmidframe:SetBackdrop(FWOptionsHeader.backdrop);
		main_data.option.frameheader.rightframe:SetBackdrop(FWOptionsHeader.backdrop);
		
		for sub_index, sub_data in ipairs(main_data[MAIN_DATA_TABLE]) do -- SUB OPTION LEVEL
			if sub_data[1] and sub_data[1] ~= FW.NIL then
				sub_data.option.header:SetBackdrop(subheaderbackdrop);
			end
		end
	end
	if extrabutton then
		extrabutton:SetBackdrop(FWOptionsHeader.backdrop);
	end
	FC_SetOptionsColor();
end


function FW:HideUnneededOptions()
	local top = FWOptionsFrameScrollBar:GetValue();
	local bottom = FWOptionsFrame:GetHeight()+top;
	-- 1 extra margin for error
	top=top-1;
	bottom=bottom+1;
	
	--if not FW.Saved.BLOCK then
	
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
	
		if main_data.option then
			if main_data.option.bottom<top or main_data.option.top>bottom then
				main_data.option:Hide(); -- also contains the options as children
			else
				main_data.option:Show();

				for sub_index, sub_data in ipairs(main_data[MAIN_DATA_TABLE]) do -- SUB OPTION LEVEL
					if sub_data.option then
						if sub_data.option.bottom<top or sub_data.option.top>bottom then
							sub_data.option:Hide();
						else
							sub_data.option:Show();
						end
					end
					for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL
						if d.option then
							if d.option.bottom<top or d.option.top>bottom then
								d.option:Hide();
							else
								d.option:Show();
							end
						end
					end
				end
			end
		end
	end
	
	--end
end

function FW:BuildOptions()
	local f,s;
	local offset = 0;
	local x,y = 0,0;
	local columns = FW.Settings.OptionsColums;
	local w = 280;
	local width = w*columns;--total option space width
	local height = FW.Settings.OptionsHeight;--440
	local h = 20;--height of one option
	local ow = width+40;
	local oh = height+60;
	
	local r,g,b,a = unpack(FW.Settings.OptionHeaderColor);
	
	-- build main options
	FWOptions:SetWidth(ow);
	FWOptions:SetHeight(oh);
	FWOptionsHeader:SetWidth(ow);
	FWOptionsFrame:SetWidth(width);
	FWOptionsHeaderIcon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[FW.CLASS]));
	FWOptionsHeaderTitle:SetText(FW:Title());
				
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
		-- main_data[5] indicates that a frame belonging to these options
		-- main_data[6] indicates what this is an instance of (and allows cloning)
		x,y = 0,-h;
		local tabs = 0; -- TAB CODE
		local tabsx = 0;
		if main_data[7] ~= nil then
			

			if not main_data.tabs then
				main_data.tabs = {};
				main_data.selected = main_data[7][1];
				main_data.tabs_frame = CreateFrame("Frame",nil,FWOptionsContent);
				main_data.tabs_frame.parent = main_data;
			end
			if main_data[6] and FW.Settings[main_data[5]] == nil then -- fix wrong instance setting if switched profiles
				main_data[5] = main_data[7][1];
				main_data.selected = main_data[7][1];
			end	
			main_data.tabs_frame:SetWidth(width);
			main_data.tabs_frame:SetPoint("TOPLEFT", FWOptionsContent, "TOPLEFT",0,offset);
			
			local t;
			local n = 1;
			if main_data[6] then -- add 'main instance' fixed tab too
				t =  main_data.tabs[n] or NewTabFrame(main_data.tabs_frame); -- create 'default' tab
				t:ClearAllPoints();
				main_data.tabs[n] = t;
				t:SetPoint("TOPLEFT", main_data.tabs_frame, "TOPLEFT",0,0);
				if main_data[6] == main_data.selected then
					t:SetText(main_data[1]);
				else
					t:SetText("|cFFCCCCCC"..main_data[1].."|r");
				end
				t.select_func = main_data[7][5];
				t.savename = main_data[6];
				tabs = tabs + 15; -- size of one tab line
				tabsx=t:GetWidth();
				t:Show();
				n = 2;
			end
			if main_data[7][6] then
				for i, v in ipairs(main_data[7][6]) do
					t =  main_data.tabs[n] or NewTabFrame(main_data.tabs_frame);
					t:ClearAllPoints();
					main_data.tabs[n] = t;
					
					t:SetEditable(true);
					t:SetEditing(false);
					t:SetText(v[2]);
					t.delete_func = main_data[7][3];
					t.rename_func = main_data[7][4];
					t.select_func = main_data[7][5];
					t.savename = v[1];
					if v[1] == main_data.selected then
						t:SetText(v[2]);
						t.button.title = FWL.RENAME_CLONE;
						t.button.tip = "";
					else
						t:SetText("|cFFCCCCCC"..v[2].."|r");
						t.button.title = FWL.SELECT_CLONE;
						t.button.tip = "";
					end
					tabsx=tabsx+t:GetWidth();
					if n==1 or (tabsx > width) then
						t:SetPoint("TOPLEFT", main_data.tabs_frame, "TOPLEFT",0,-tabs);
						tabs = tabs + 15; -- size of one tab line
						tabsx=t:GetWidth();
					else
						t:SetPoint("TOPLEFT",main_data.tabs[n-1], "TOPRIGHT",0,0);
					end
					t:Show();
					n=n+1;
				end
			end
			t =  main_data.tabs[n] or NewTabFrame(main_data.tabs_frame); -- create 'create' tab
			t:ClearAllPoints();
			main_data.tabs[n] = t;
			
			t:SetEditable(false);
			t:SetEditing(false);
			t:SetText(NEW_INSTANCE_STRING);
			t.savename = NEW_INSTANCE_STRING;
			t.create_func = main_data[7][2];
			t.button.title = FWL.CREATE_CLONE;
			t.button.tip = "";
			tabsx=tabsx+t:GetWidth();
			if tabsx > width then
				t:SetPoint("TOPLEFT", main_data.tabs_frame, "TOPLEFT",0,-tabs);
				tabs = tabs + 15; -- size of one tab line
				tabsx=t:GetWidth();
			else
				t:SetPoint("TOPLEFT", main_data.tabs[n-1], "TOPRIGHT",0,0);
			end			
			t:Show();
			n=n+1;
			for i=n,#main_data.tabs,1 do
				main_data.tabs[i]:Hide();
			end
			main_data.tabs_frame:SetHeight(tabs);
			offset=offset-tabs;
		end --END TAB CODE
		
		if not main_data.option then
			main_data.option = NewOptionsFrame(FWOptionsContent);
		end
		f = main_data.option;
		f.main_data = main_data;
		f.header.title:SetText(main_data[1]);
		f.header.icon.normaltexture:SetTexture(main_data[2]);
		f.header.icon.highlighttexture:SetTexture(main_data[2]);
		
		f:SetWidth(width);
		f.frame = main_data[5];
		if f.frame then
			f.frameheader:Show();
			f.normalheader:Hide();
		else
			f.frameheader:Hide();
			f.normalheader:Show();	
		end
		
		f:ClearAllPoints();
		f:SetPoint("TOPLEFT", FWOptionsContent, "TOPLEFT",0,offset);

		f.index = main_index;
		
		for sub_index, sub_data in ipairs(main_data[MAIN_DATA_TABLE]) do -- SUB OPTION LEVEL
			
			if sub_data[1] and sub_data[1] ~= FW.NIL then
				if x>0 then
					x = 0;
					y = y -s:GetHeight();
				end
				if not sub_data.option then
					sub_data.option = NewSubOptionsFrame(f);
				end
				s = sub_data.option;
				s.main_data = main_data;
				s:SetWidth(width);
				s.header:SetWidth(width);
				s:ClearAllPoints();
				s:SetPoint("TOPLEFT",s.parent,"TOPLEFT",x,y);
				s.header.title:SetText(sub_data[1]);
				s.header.icon:SetTexture(sub_data[2]);
				
				if sub_data[1] == FWL.COLORING_FILTERING then
					Anchors[main_data[1].." Color"] = s; --save anchor for filters too!
				end
				s.index = sub_index;
				s.top = -offset - y;
				s.bottom = s.top+s:GetHeight();
				y = y -s:GetHeight();
				s:Show();
			end
			
			for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL

				if d[1] and d[1] ~= FW.NIL then
					if  d.option then
						if main_data[6] then
							d.option.s = FW.Settings[main_data[5]];
							d.option.d = FW.Default[main_data[6]];
						else
							d.option.s = FW.Settings; -- also update settings table
							d.option.d = FW.Default; -- also update defaults table
						end
					else
						if main_data[6] then
							d.option = createOption[d[1]](f, d[6], FW.Settings[main_data[5]], FW.Default[main_data[6]]);
						else
							d.option = createOption[d[1]](f, d[6], FW.Settings, FW.Default);
						end
					end
					s = d.option;
					s.main_data = main_data;
					s.title = d[4];
					if d[5] then
						local c = "|cff888888";
						s.tip = d[5];
						
						if d[1] == FW.NUM or d[1] == FW.NU2 then
							if d[8] then
								s.editbox.minimum = d[8];
								if d[9] then
									s.editbox.maximum = d[9];
									if s.tip ~= "" then s.tip=s.tip.."\n\n";end
									s.tip = s.tip..c..strformat(FWL.RANGE_MAX,d[8],d[9]).."|r";
								else
									if s.tip ~= "" then s.tip=s.tip.."\n\n";end
									s.tip = s.tip..c..strformat(FWL.RANGE_MIN,d[8]).."|r";
								end
							end
						elseif d[1] == FW.SND then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..strformat(FWL.RANGE_MAX,1,8).."|r";
						elseif d[1] == FW.FNT then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..strformat(FWL.RANGE_MAX,8,16).."|r";
						end
	
						if d[1] == FW.COL then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FWL.USE_COLOR_PICKER;
						elseif d[1] == FW.CO2 then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FWL.USE_COLOR_PICKER2;
						elseif d[1] == FW.TXT then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FWL.USE_TEXTURE;
						elseif d[1] == FW.FNT then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FWL.USE_FONT;
						elseif d[1] == FW.FIL then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FWL.USE_FILTER
							Anchors[main_data[1].." Filter"] = s; --save anchor for filters too!
							s.actionbutton.list = d[8];
							s.typebutton.list = d[9];
							
						elseif d[1] == FW.MSG or d[1] == FW.NUM or d[1] == FW.NU2 then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FWL.USE_EDITBOX;
						elseif d[1] == FW.MS2 then
							if s.tip ~= "" then s.tip=s.tip.."\n\n";end
							s.tip = s.tip..c..FWL.USE_MSG2;
						end
						
					end
					s.func = d[7];
					
					s:SetWidth(d[2]*w);
					s:ClearAllPoints();
					s.top = -offset-y;
					s:SetPoint("TOPLEFT",s.parent, "TOPLEFT",x,y);

					s.text:SetText(d[4]);
					
					if d[1] == FW.FIL then 
						y = y + FC_BuildFilterList(s);
					elseif d[1] == FW.IMG then
						--d[7]; aspect
						--d[8]; pref width
						--d[9]; pref height
						if d[9] then
							s:SetHeight(d[9]);
							s.image:SetHeight(d[9]-20);
							s.image:SetWidth(d[7]*s.image:GetHeight());
						end
					end
					
					s:Show();
				end
				s.bottom = -offset-y+s:GetHeight();
				x = x + d[2]*w;
				
				--if not sub_data[4][i+1] or x + (sub_data[4][i+1][2]*w or 0) > width then
				if x + (sub_data[4][i+1] and sub_data[4][i+1][2]*w or 0) > width then
					--s:SetWidth(--[[width-x +]] d[2]*w);
					x = 0;
					y = y -s:GetHeight();
				end
				
				
			end		
		end
		if x>0 then
			x = 0;
			y = y -s:GetHeight();
		end
		Anchors[main_data[1]] = f;
		
		f.top = -offset-tabs;
		offset = offset + y;
		f.bottom = -offset;
		
		offset = offset - 10;
		f:SetHeight(-y+5);
		f:Show();
		
	end
	
	-- build shortcuts
	columns = columns*2;
	w = (ow)/columns;
	h=16;
	y = h*math.ceil(#FW_Options/columns-1);
	x = 0;

	FWOptionsFrame:SetHeight(height-y);
	
	f=_G["FWOptionsDummy"] or CreateFrame("Frame", "FWOptionsDummy", FWOptionsContent);
	f:ClearAllPoints();
	f:SetPoint("TOPLEFT",FW_Options[1].option,"TOPLEFT",0,0);
	f:SetPoint("BOTTOMRIGHT",FW_Options[#FW_Options].option,"BOTTOMRIGHT",0,0);
	FWOptionsFrame.maxscroll = f:GetHeight()-FWOptionsFrame:GetHeight();
	width = width + 40;
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
		if not main_data.shortcut then
			main_data.shortcut = NewShortcutButton(FWOptions);
		end
		s = main_data.shortcut;
		s:ClearAllPoints();
		s:SetPoint("BOTTOMLEFT",FWOptions, "BOTTOMLEFT",x,y);
		s:SetWidth(w);
		s:SetHeight(h);
		s:SetText(main_data[1]);
		s.tip = FWL.SCROLL_TO_..main_data[1];
		s.title = main_data[1];
		s:SetNormalTexture(main_data[2]);
	
		s:SetScript("OnClick",function()FW:ScrollTo(main_data[1],1);end);--this is scary

		x=x+w;
		if x >= width-0.1 then -- stupid shit
			x=0;y=y-h;
		end		
	end
	if x ~= 0 then
		extrabutton = extrabutton or CreateFrame("Frame", nil, FWOptions);
		extrabutton:SetPoint("BOTTOMLEFT",FWOptions, "BOTTOMLEFT",x,y);
		extrabutton:SetWidth(width - x);
		extrabutton:SetHeight(h);
	end
	
	FC_SetBackgroundImage();
	FW:HideUnneededOptions();
	
	if not optionsbuilt then
		FC_SetOptionsFont();
		FC_SetOptionsBackdrop(); -- includes colors
	end
	optionsbuilt = true;
end


local function FW_SetAllLocks()
	for f,d in pairs(Frames) do
		if FW.Settings[f].lock ~= nil then
			FW.Settings[f].lock = FW.Settings.GlobalLock;
		end
	end
	FW:RefreshFrames();
	FW:RefreshOptions();
end

local function FW_SetAllAlpha()
	for f,d in pairs(Frames) do
		if FW.Settings[f].alpha ~= nil then
			FW.Settings[f].alpha = FW.Settings.GlobalAlpha;
		end
	end
	FW:RefreshFrames();
	FW:RefreshOptions();
end

local function FW_SetAllTextures()
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
		for sub_index, sub_data in ipairs(main_data[MAIN_DATA_TABLE]) do -- SUB OPTION LEVEL
			for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL
				if d[1] and d[1] == FW.TXT then
					d.option.s[ d.option.o ] = FW.Settings.Texture;
				end
			end
		end
	end
	FW:RefreshFrames();
	FW:RefreshOptions();
end

local function FW_SetAllFonts()
	for main_index, main_data in ipairs(FW_Options) do -- MAIN OPTION LEVEL
		for sub_index, sub_data in ipairs(main_data[MAIN_DATA_TABLE]) do -- SUB OPTION LEVEL
			for i, d in ipairs(sub_data[4]) do -- OPTION LEVEL
				if d[1] and d[1] == FW.FNT and d[6] ~= "OptionsFont" and d[6] ~= "OptionsHeaderFont"then
					d.option.s[ d.option.o ] = FW.Settings.Font;
					d.option.s[ d.option.o.."Size" ] = FW.Settings.FontSize;
				end
			end
		end
	end
	FW:RefreshFrames();
	FW:RefreshOptions();
end

-- the actual shared lib code is in the locale func
local LSM = LibStub and LibStub("LibSharedMedia-3.0", true)
if LSM then
	function FW:LSM_Registered(callback, media, handle)
		if media == "font" then
			FW:RegisterFont(LSM:Fetch("font", handle), handle)
		elseif media == "sound" then
			FW:RegisterSound(LSM:Fetch("sound", handle), handle)
		elseif media == "statusbar" then
			tinsert(FW.TextureList, LSM:Fetch("statusbar", handle))
		elseif media == "border" then
			FW:RegisterBorder(LSM:Fetch("border", handle), handle)
		elseif media == "background" then
			FW:RegisterBackground(LSM:Fetch("background", handle), handle)
		end
	end
	LSM.RegisterCallback(FW, "LibSharedMedia_Registered", "LSM_Registered")
end

local IMP_HS = {[0]=" (0/2)",[1]=" (1/2)",[2]=" (2/2)"};
function FW:LocalizedData()

	if LSM then -- doing this here because of chinese fonts
		--FW:Show("Shared Media Detected!");
		-- shared sound
		for i, data in ipairs(FW.SoundList) do
			LSM:Register("sound", data[2], data[1]);
		end
		erase(FW.SoundList);
		for i, name in pairs(LSM:List("sound")) do
			FW:RegisterSound(LSM:Fetch("sound", name), name)
		end
		-- shared borders
		for i, data in ipairs(FW.BorderList) do
			LSM:Register("border", data[2], data[1]);
		end
		erase(FW.BorderList);
		for i, name in pairs(LSM:List("border")) do
			FW:RegisterBorder(LSM:Fetch("border", name), name)
		end
		--shared backgrounds
		for i, data in ipairs(FW.BackgroundList) do
			LSM:Register("background", data[2], data[1]);
		end
		erase(FW.BackgroundList);
		for i, name in pairs(LSM:List("background")) do
			FW:RegisterBackground(LSM:Fetch("background", name), name)
		end
		-- shared textures
		for i, path in ipairs(FW.TextureList) do
			local name = select(3,strfind(path,"^Interface\\AddOns\\Forte_Core\\Textures\\(.-)$"));
			if name then
				LSM:Register("statusbar", name, path)
			end
		end
		erase(FW.TextureList);
		for i, name in ipairs(LSM:List("statusbar")) do
			tinsert(FW.TextureList,LSM:Fetch("statusbar", name))
		end
		-- shared fonts
		for i, data in ipairs(FW.FontList) do
			LSM:Register("font", data[2], data[1]);
		end
		erase(FW.FontList);
		for i, name in pairs(LSM:List("font")) do
			FW:RegisterFont(LSM:Fetch("font", name), name)
		end
	end

	FW.ID_HEALTHSTONE = {
		{5512,	FWL.MINOR..IMP_HS[0],	1,1,},
		{19004,	FWL.MINOR..IMP_HS[1],	2,1},
		{19005,	FWL.MINOR..IMP_HS[2],	3,1},
		{5511,	FWL.LESSER..IMP_HS[0],	1,2},
		{19006,	FWL.LESSER..IMP_HS[1],	2,2},
		{19007,	FWL.LESSER..IMP_HS[2],	3,2},
		{5509,	FWL.NORMAL..IMP_HS[0],	1,3},
		{19008,	FWL.NORMAL..IMP_HS[1],	2,3},
		{19009,	FWL.NORMAL..IMP_HS[2],	3,3},
		{5510,	FWL.GREATER..IMP_HS[0],	1,4},
		{19010,	FWL.GREATER..IMP_HS[1],	2,4},
		{19011,	FWL.GREATER..IMP_HS[2],	3,4},
		{9421,	FWL.MAJOR..IMP_HS[0],	1,5},
		{19012,	FWL.MAJOR..IMP_HS[1],	2,5},
		{19013,	FWL.MAJOR..IMP_HS[2],	3,5},
		{22103,	FWL.MASTER..IMP_HS[0],	1,6,2080},
		{22104,	FWL.MASTER..IMP_HS[1],	2,6,2288},
		{22105,	FWL.MASTER..IMP_HS[2],	3,6,2496},
		{36889,	FWL.DEMONIC..IMP_HS[0],	1,7,3500},
		{36890,	FWL.DEMONIC..IMP_HS[1],	2,7,3850},
		{36891,	FWL.DEMONIC..IMP_HS[2],	3,7,4200},
		{36892,	FWL.FEL..IMP_HS[0],		1,8,4280},
		{36893,	FWL.FEL..IMP_HS[1],		2,8,4708},
		{36894,	FWL.FEL..IMP_HS[2],		3,8,5136},
		
		[0]={0, FWL.NONE, 0,0,0},
	};
	FW.Exceptions = {
		[FWL.HELLFIRE_CHANNELER] = 0,
		[FWL.GRAND_ASTROMANCER_CAPERNIAN] = 1,
		[FWL.MASTER_ENGINEER_TELONICUS] = 1,
		[FWL.FATHOM_GUARD_SHARKKIS] = 1,
		[FWL.THALADRED_THE_DARKENER] = 1,
		[FWL.LORD_SANGUINAR] = 1,
		[FWL.FATHOM_GUARD_CARIBDIS] = 1,
		[FWL.FATHOM_GUARD_TIDALVESS] = 1,
	};
	FW.FilterListOptions = {
		{ 0,FWL.FILTER_NONE},
		{ 1,FWL.FILTER_NORMAL},
		{ 2,FWL.FILTER_SHOW_COLOR},
		{-2,FWL.FILTER_COLOR},
		{-1,FWL.FILTER_IGNORE},
	}
	FW.STFilterListOptions = {
		{ 1,FWL.FILTER_ALL},
		{ 2,FWL.FILTER_OTHERS},
		{ 4,FWL.FILTER_COOLDOWNS},
		{ 5,FWL.FILTER_DEBUFFS_ON_ME},
		{ 3,FWL.FILTER_MINE},
	}
	FW.CDFilterListOptions = {
		{ 1,FWL.FILTER_ALL},
		{ 2,FWL.FILTER_BUFF_DEBUFF},
		{ 3,FWL.FILTER_OTHER},
	}

	FW.ClassModules = FWL.MODULE_NONE;
	
	FW.tab_data = {
		nil, -- default selected value
		function(obj) -- create
			-- use obj.parent.parent.selected to see what i'm copying from
			local savename;
			local found;
			local n = 0;
			while not savename do
				n = n + 1;
				found = false;
				for k, v in ipairs(FW.Saved.ProfileNames) do
					if v[1] == "Profile"..n then
						found = true;
						break;
					end
				end
				if not found then
					savename = "Profile"..n;
				end
			end
			FW:CreateProfile(savename,FW:FullName());
		end,
		function(obj) -- remove
			FW:DeleteProfile(obj.savename);
		end,
		function(obj,txt) -- rename
			FW:RenameProfile(obj.savename,txt);
		end,
		function(obj) -- select func
			FW:UseProfile(obj.savename)
		end,
		nil,-- tab options table, make sure that this is updated when a profile is changed
	};
	
	FW:SetMainCategory(FWL.GENERAL,FW.ICON_DEFAULT,1,"DEFAULT","FWOptions",nil,FW.tab_data);

		FW:SetSubCategory(FWL.GENERAL_TIPS,FW.ICON_HINT,1);
			FW:RegisterOption(FW.INF,2,FW.NON,	FWL.GENERAL_TIPS3);
			FW:RegisterOption(FW.INF,2,FW.NON,	FWL.GENERAL_TIPS5);
			FW:RegisterOption(FW.INF,2,FW.NON,	FWL.GENERAL_TIPS4);
			FW:RegisterOption(FW.INF,2,FW.NON,	FWL.GENERAL_TIPS6);
			
		FW:SetSubCategory(FWL.GENERAL_MO,FW.ICON_DEFAULT,2);
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.GENERAL_MO1,	FWL.GENERAL_MO1_TT,	"RightClickOptions");
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.GENERAL_MO6,	FWL.GENERAL_MO6_TT,	"RightClickIconOptions");
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.GENERAL_MO2,	FWL.GENERAL_MO2_TT,	"TimeFormat");
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.GLOBAL_LOCK,	FWL.GLOBAL_LOCK_TT,	"GlobalLock",FW_SetAllLocks);
			FW:RegisterOption(FW.NUM,1,FW.NON,FWL.GLOBAL_ALPHA,	FWL.GLOBAL_ALPHA_TT,"GlobalAlpha",FW_SetAllAlpha,0.1,1.0);
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.GENERAL_MO3,	FWL.GENERAL_MO3_TT,	"FrameSnap");
			FW:RegisterOption(FW.NUM,1,FW.NON,FWL.GENERAL_MO4,	FWL.GENERAL_MO4_TT,	"FrameSnapDistance");
			FW:RegisterOption(FW.NUM,1,FW.NON,FWL.GENERAL_MO5,	FWL.GENERAL_MO5_TT,	"FrameDistance");

		FW:SetSubCategory(FWL.GENERAL_MA,FW.ICON_APPEARANCE,3);
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.TIPS,			FWL.TIPS_TT,		"Tips");
			FW:RegisterOption(FW.CO2,1,FW.NON,FWL.SPARK_COLOR,	FWL.SPARK_COLOR_TT,	"Spark");
			FW:RegisterOption(FW.FNT,2,FW.NON,FWL.BAR_FONT,		FWL.GENERAL_MA1_TT,	"Font",				FW_SetAllFonts);
			FW:RegisterOption(FW.TXT,2,FW.NON,FWL.BAR_TEXTURE,	FWL.GENERAL_MA2_TT,	"Texture",			FW_SetAllTextures);
			--FW:RegisterOption(FW.BAC,2,FW.LAS,"Backdrop",			"",				"Backdrop");

	FW:SetMainCategory(FWL.ADVANCED,FW.ICON_DEFAULT,98,"DEFAULT");

		FW:SetSubCategory(FW.NIL,FW.NIL,1);
			FW:RegisterOption(FW.INF,2,FW.NON,FWL.ADVANCED_HINT1);
			FW:RegisterOption(FW.INF,2,FW.NON,FWL.ADVANCED_HINT2);
			
		FW:SetSubCategory(FWL.GENERAL_OA,FW.ICON_APPEARANCE,2);
			FW:RegisterOption(FW.NUM,1,FW.NON,FWL.OPTIONS_COLUMNS,	FWL.OPTIONS_COLUMNS_TT,	"OptionsColums",FW.BuildOptions,2,4);
			FW:RegisterOption(FW.NUM,1,FW.NON,FWL.OPTIONS_HEIGHT,	FWL.OPTIONS_HEIGHT_TT,	"OptionsHeight",FW.BuildOptions,200);
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.ANIMATE_SCROLL,	FWL.ANIMATE_SCROLL_TT,	"AnimateScroll");
			FW:RegisterOption(FW.COL,1,FW.NON,FWL.GENERAL_OA1,		FWL.GENERAL_OA1_TT,	"OptionHeader",		FC_SetOptionsColor);
			FW:RegisterOption(FW.COL,1,FW.NON,FWL.GENERAL_OA2,		FWL.GENERAL_OA2_TT,	"OptionBackground",	FC_SetOptionsColor);
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.MODULE_COLORS,	FWL.MODULE_COLORS_TT,"OptionsModuleColor",FC_SetOptionsColor);
			FW:RegisterOption(FW.FNT,2,FW.NON,FWL.GENERAL_OA3,		FWL.GENERAL_OA3_TT,	"OptionsHeaderFont",FC_SetOptionsFont);
			FW:RegisterOption(FW.FNT,2,FW.NON,FWL.GENERAL_OA4,		FWL.GENERAL_OA4_TT,	"OptionsFont",		FC_SetOptionsFont);
			FW:RegisterOption(FW.BAC,2,FW.LAS,FWL.BACK_GROUND,		"",					"OptionsBackdrop" , 	FC_SetOptionsBackdrop);
			FW:RegisterOption(FW.BAC,2,FW.LAS,FWL.GENERAL_OA3,		"",					"OptionsHeaderBackdrop" , 	FC_SetOptionsBackdrop);
			FW:RegisterOption(FW.BAC,2,FW.LAS,FWL.SUB_HEADERS,		"",					"OptionsSubHeaderBackdrop" , 	FC_SetOptionsBackdrop);

		FW:SetSubCategory(FWL.CORE,FW.ICON_DEFAULT,2);
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.BLOCK_SHARDS,	FWL.BLOCK_SHARDS_TT,"SafeBlockShardReagent");
			FW:RegisterOption(FW.NUM,1,FW.NON,FWL.LOADING_DELAY,				"",	"LoadDelay",nil,1,10);
			FW:RegisterOption(FW.NUM,1,FW.NON,FWL.UPDATE_INTERVAL_CORE,			"",	"UpdateInterval",nil,0.01,1);
			FW:RegisterOption(FW.NUM,1,FW.NON,FWL.UPDATE_INTERVAL_ANIMATIONS,	"",	"AnimationInterval",nil,0.01,0.1);
			FW:RegisterOption(FW.NUM,1,FW.NON,FWL.CHILL_SPEED,					"",	"Chill",nil,0.01,0.1);
			FW:RegisterOption(FW.CHK,1,FW.NON,FWL.GLOBAL_FRAME_NAMES,FWL.GLOBAL_FRAME_NAMES_TT,	"GlobalFrameNames");
	
	FW:SetMainCategory("About",FW.ICON_HINT,99,"DEFAULT");
		FW:SetSubCategory(FW.NIL,FW.NIL,1);
			FW:RegisterOption(FW.IMG,2,FW.NON,"Copyright (C) 2006-2010 Xus (xuswow@hotmail.com)","","Interface\\AddOns\\Forte_Core\\Textures\\ForteXorcist",4,nil,100);
		FW:SetSubCategory("ForteXorcist on the Web",FW.ICON_HINT,1);
			FW:RegisterOption(FW.INF,2,FW.NON,"You can find additional documentation and news at my ForteXorcist portal.");
			FW:RegisterOption(FW.INF,2,FW.NON,"Please post bugs and suggestions on this portal as well.");
			FW:RegisterOption(FW.URL,2,FW.NON,"Portal","ForteXorcist Portal","http://www.wowinterface.com/portal.php?&uid=65900");
			FW:RegisterOption(FW.INF,2,FW.NON,"");
			FW:RegisterOption(FW.INF,2,FW.NON,"You can update this addon from WoWInterface and Curse.");
			FW:RegisterOption(FW.URL,2,FW.NON,"WoWI","Download at WoWInterface","http://www.wowinterface.com/downloads/info7532.html");
			FW:RegisterOption(FW.URL,2,FW.NON,"Curse","Download at Curse","http://wow.curse.com/downloads/wow-addons/details/fortexorcist.aspx");
			FW:RegisterOption(FW.INF,2,FW.NON," ");
			FW:RegisterOption(FW.INF,2,FW.NON,"If you want to donate anything for the work on this addon, feel free to use PayPal. Thanks! :)");
			FW:RegisterOption(FW.URL,2,FW.NON,"PayPal","Donate using PayPal","https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2083371");
		
		FW:SetSubCategory("Special Thanks",FW.ICON_HINT,2);
			FW:RegisterOption(FW.INF,2,FW.NON,"I would like to thank the following people:");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Everyone in Forte in its last years. Forte was the perfect AddOn testing playground ;)");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Its (ex-)warlocks for their suggestions and being my guinea pigs :p");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Everyone that gave me cool suggestions for the AddOn!");
		FW:SetSubCategory("Modules",FW.ICON_HINT,3);
			FW:RegisterOption(FW.INF,2,FW.NON,"I would like to curse the following people for making this suck up even more time: <3");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Phanx for helping me add shared media support.");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Eoy for starting the Priest module.");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Exuro & Aeco for starting the Warrior module.");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Lurosara for starting the Druid module.");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Destard for starting the Hunter module.");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Amros for starting the Mage module.");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Arono of Skywall for starting the Paladin module.");
		FW:SetSubCategory("Translations",FW.ICON_HINT,4);
			FW:RegisterOption(FW.INF,2,FW.NON,"And finally thanks to the following people that helped translate the AddOn:");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Papo & Shantara for Russian translations.");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Rabbitcookie for Chinese translations.");
 			FW:RegisterOption(FW.INF,2,FW.NON,"   Sylrias & Boute for French translations.");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Haity & Stempi & Pannonica & Norrax for German translations.");
			FW:RegisterOption(FW.INF,2,FW.NON,"   Intxixu for Spanish translations.");
		FW:SetSubCategory("FAQ",FW.ICON_FAQ,5);
			FW:RegisterOption(FW.INF,2,FW.NON,"   To come...");
			FW:RegisterOption(FW.URL,2,FW.NON,"","FAQ at ForteXorcist Portal","http://www.wowinterface.com/portal.php?id=513&a=faq");
		FW:SetSubCategory("Future",FW.ICON_HINT,7);
			FW:RegisterOption(FW.INF,2,FW.NON,"- Finish the About ;)");
			FW:RegisterOption(FW.INF,2,FW.NON,"- Spell Range/Usability Indicator");
			FW:RegisterOption(FW.INF,2,FW.NON,"- Rewrite really old code");
			FW:RegisterOption(FW.INF,2,FW.NON,"- Diminishing returns tracking @ spell timer");
			FW:RegisterOption(FW.INF,2,FW.NON,"- Some pet summon buttons etc so you can dump necrosis? :p");
			FW:RegisterOption(FW.INF,2,FW.NON,"- Docking with Fubar?");
	
	--set here because of localizations
	FW.Default.OptionsFont = FW.Default.Font;
	FW.Default.OptionsFontSize = FW.Default.FontSize;
	if FW.Default.Font == "Interface\\AddOns\\Forte_Core\\Fonts\\GOTHIC.TTF" then
		FW.Default.OptionsHeaderFont = "Interface\\AddOns\\Forte_Core\\Fonts\\GOTHICB.TTF";
	else
		FW.Default.OptionsHeaderFont = FW.Default.Font;
	end
	FW.Default.OptionsHeaderFontSize = FW.Default.FontSize;
	
	BINDING_HEADER_FORTECORE = FW.TITLE;
	BINDING_NAME_FC_OPTIONS = FWL.TOGGLE_OPTIONS;
end

function FW:RefreshOptions()
	if optionsbuilt then
		if FWOptions:IsVisible() then FWOptions:Hide();FWOptions:Show();FWOptions.show = 1; end
		FC_SetOptionsFont();
		FC_SetOptionsBackdrop(); -- includes colors
	end
end

function FW:ToggleOptions()
	if FWOptions:IsVisible() then
		FW_HideOptions();
	else
		FW_ShowOptions();
	end
end

FW:RegisterUpdatedEvent(FW_AutoShow);