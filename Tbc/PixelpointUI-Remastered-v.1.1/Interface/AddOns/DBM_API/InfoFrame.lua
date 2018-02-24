-- -------------------------------------------------------------------------- --
-- InfoFrame for Deadly Boss Mods written by LV|Nitram & DeadlyMinds|Tandanu --
-- -------------------------------------------------------------------------- --
--  v1.00:	-- from InfoFrame
--  	Added functions:
--		myInfoFrame = DBMGui:CreateInfoFrame(title, text)
--		myInfoFrame:SetTitle(title)
--		myInfoFrame:SetText(text)
--
--  		myInfoFrameStatusBar = myInfoFrame:CreateStatusBar(min, max, value, title)
--  		myInfoFrameStatusBar:SetValue(value)
--  		myInfoFrameStatusBar:SetTitle(title)
--
--  		myInfoFrameTextField = myInfoFrame:CreateTextField(text)
--  		myInfoFrameTextField:SetText(text)
--
--	these methods are also available for status bars and text fields
--		myInfoFrame:Show()
--		myInfoFrame:Hide()
--	  	myInfoFrame:GetObject() - returns the frame object
--	  	myInfoFrame:Delete() 	- you can not delete frames, but this function hides the frame and 
--	  				- moves it to a "trash can"...the frame will be re-used next time you create a frame of this type
--
--  	Added Function DBMGui.InfoFrameRestoreFind(ftype)		(DO NOT CALL)		-- search in Trash
--		Added Function DBMGui.InfoFrameGetNewName()		(DO NOT CALL)		-- used to get a new FrameName
--
--  	Added Function DBM_Gui_CreateDistanceFrame() for a in Range Frame (C'Thun,...)
--  	Added Function DBM_Gui_DistanceFrame() to show/hide the Range Frame
--  	Added Function DBM_InfoFrameTemplate_OnUpdate() 	-- allways called by Frame:OnUpdate
--
--  v1.10:
--  	Updated Delete Function
--  	Updated Frame Positioning
--  	Updated Create Function
--
-- -------------------------------------------------------------------- --

DBMGui_DistanceFrame_Distance = 10;

DBMGui = {		-- Create table
	["Trash"] = {			-- Unused Frames moved there for recycling 
	},
	["FrameID"] = 1;	-- hmm i can't find a function to change the Name of a Frame so i use my own with ID
};


-- Handler for Auto CleanUp
DBMStatusBarHandler = {  "OnChar", "OnDragStart", "OnDragStop", "OnEnter", "OnEvent", "OnHide", "OnKeyDown",
		    "OnKeyUp", "OnLeave", "OnLoad", "OnMouseDown", "OnMouseUp", "OnMouseWheel", "OnReceiveDrag",
		    "OnShow", "OnSizeChanged", "OnUpdate", "OnValueChanged",
	};
DBMFrameHandler = {  "OnChar", "OnDragStart", "OnDragStop", "OnEnter", "OnEvent", "OnHide", "OnKeyDown",
		    "OnKeyUp", "OnLeave", "OnLoad", "OnMouseDown", "OnMouseUp", "OnMouseWheel", "OnReceiveDrag",
		    "OnShow", "OnSizeChanged", "OnUpdate",
	};
DBMFrameDefaultScripts = {
	["OnMouseDown"] = function()
		if ( arg1 == "RightButton" and IsShiftKeyDown() ) then
			this:Hide();
		elseif ( arg1 == "RightButton" ) then
			this:StartMoving();
		end
	end,
	["OnMouseUp"] = function()
		if ( arg1 == "RightButton" ) then
			this:StopMovingOrSizing();
			
			local xOfs, yOfs = this:GetCenter();
			yOfs = yOfs - (UIParent:GetHeight());-- / UIParent:GetEffectiveScale());

			DBMInfoFramePositions[this.Name] = {
				["x"] = xOfs;
				["y"] = yOfs;
			}
		end
	end,
	["OnEnter"] = function()
		GameTooltip:Hide();
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(this, "ANCHOR_CURSOR");
		GameTooltip:SetText(DBMGUI_INFOFRAME_TOOLTIP_TITLE, 1,1,1);
		GameTooltip:AddLine(DBMGUI_INFOFRAME_TOOLTIP_TEXT, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, 1);
		GameTooltip:Show();
	end,
	["OnLeave"] = function()
		GameTooltip:Hide();
	end,
	["OnHide"] = function()
		this:StopMovingOrSizing();
	end,
	["OnUpdate"] = function()
		DBM_InfoFrameTemplate_OnUpdate(this, arg1);
	end,
};
	
DBMGuiStatusBar = setmetatable({}, {["__index"] = DBMGui});
DBMGuiTextField = setmetatable({}, {["__index"] = DBMGui});

function DBM_InfoFrameTemplate_OnUpdate(frame, elapsed, forceUpdate)
	frame.elapsed = frame.elapsed + elapsed;
	if( frame.elapsed > 1 ) or forceUpdate then
		frame.elapsed = 0;
		frame.myTemp = 0;
		frame.myTempHeight = 0;
					
		frame.myWidth = getglobal(frame:GetName().."Text"):GetStringWidth();
		if( frame.myWidth < 84 ) then	frame.myWidth = 84;	end
		
		_, lines = getglobal(frame:GetName().."Text"):GetText():gsub("\n", "\n")
		frame.myHeight = lines * 16;
--		if( frame.myHeight < 16 ) then	frame.myHeight = 16;	end

		local subframes = { frame:GetChildren() };
		for _,child in ipairs(subframes) do

			child:SetPoint("TOP", frame, "TOP", 0, ((frame.myTempHeight + frame.myHeight + 23 + 10 )*(-1)));

			frame.myTemp = child:GetWidth();
			frame.myTempHeight = frame.myTempHeight + child:GetHeight();
			if( frame.myTemp > frame.myWidth ) then
				frame.myWidth = frame.myTemp;
			end
		end

		frame:SetWidth( frame.myWidth + 16 );
		frame:SetHeight( frame.myTempHeight + frame.myHeight + 23 + 16 );		-- Childs + Text + Title + Border 
	end
end

function DBMGui.InfoFrameGetNewName()
	DBMGui["FrameID"] = DBMGui["FrameID"] + 1;
	return "DBMInfoFrameID"..(DBMGui["FrameID"] - 1);
end

DBMGuiMetatable = {
	["__index"] = DBMGui,
};

DBMGuiStatusBarMetatable = {
	["__index"] = DBMGuiStatusBar,
};

DBMGuiTextFieldMetatable = {
	["__index"] = DBMGuiTextField,
};

function DBMGui:CreateInfoFrame(iTitle, iText)
	if self ~= DBMGui then return; end
	if not iText then iText = " "; end
	local tempFrame;
	tempFrame = DBMGui.InfoFrameRestoreFind("MainFrame");
	if( tempFrame ) then
		tempFrame:SetParent("UIParent");
		tempFrame:ClearAllPoints();
	else 
		tempFrame = CreateFrame("Frame", DBMGui.InfoFrameGetNewName(), UIParent, "DBMInfoFrameTemplate");
		tempFrame:EnableMouse(true)
		tempFrame.elapsed = 0;
		tempFrame.myWidth = tempFrame:GetWidth();
		tempFrame.myHeight = tempFrame:GetHeight();
		for index, value in pairs(DBMFrameDefaultScripts) do
			if tempFrame:GetScript(index) ~= value then
				tempFrame:SetScript(index, value);
			end
		end
	end

	tempFrame.Name = iTitle; 	-- This field gives us the Memory function for InfoFrames

	if( DBMInfoFramePositions[tempFrame.Name] ) then		-- FRAME Positioning Load Saved Value
		if( DBMInfoFramePositions[tempFrame.Name].x < 0 
		 or DBMInfoFramePositions[tempFrame.Name].x > (UIParent:GetWidth() / UIParent:GetEffectiveScale()) ) then
--			DBM.AddMsg("Corrected FramePoint X - Out of Screen - ("..DBMInfoFramePositions[tempFrame.Name].x..")");
			DBMInfoFramePositions[tempFrame.Name].x = (UIParent:GetWidth() / UIParent:GetEffectiveScale()) / 2;
		end
		if( DBMInfoFramePositions[tempFrame.Name].y > 0 
		 or DBMInfoFramePositions[tempFrame.Name].y < ((UIParent:GetHeight() / UIParent:GetEffectiveScale())*(-1)) ) then
--			DBM.AddMsg("Corrected FramePoint Y - Out of Screen - ("..DBM.Options.Gui.InfoFramePointY..")");
			DBMInfoFramePositions[tempFrame.Name].y = ((UIParent:GetHeight() / UIParent:GetEffectiveScale()) / (-2));
		end
		tempFrame:SetPoint("CENTER", "UIParent", "TOPLEFT", 
					DBMInfoFramePositions[tempFrame.Name].x, 
					DBMInfoFramePositions[tempFrame.Name].y
				);
	else	-- Use Middle of the Screen
		tempFrame:SetPoint("CENTER", "UIParent", "CENTER");
	end

	tempFrame:SetBackdropColor(0, 0, 1, 0.5);
	if( iTitle ~= nil ) then
		getglobal(tempFrame:GetName().."Title"):SetText(iTitle);
	else
		getglobal(tempFrame:GetName().."Title"):SetText("");
	end
	if( iText ~= nil ) then
		getglobal(tempFrame:GetName().."Text"):SetText(iText);
	else
		getglobal(tempFrame:GetName().."Text"):SetText("");
	end
	tempFrame:Show();
	DBM_InfoFrameTemplate_OnUpdate(tempFrame, 0, true);
	
	return setmetatable({
		["Frame"] = tempFrame,
		["SubFrames"] = {},
	}, DBMGuiMetatable);
end

function DBMGui:GetObject()
	if self == DBMGui then return; end
	return self.Frame;
end

function DBMGui:Hide()
	if self == DBMGui then return; end
	self.Frame:Hide();
end

function DBMGui:Show()
	if self == DBMGui then return; end
	self.Frame:Show();
end

function DBMGui:SetTitle(iTitle)
	if self == DBMGui then return; end
	getglobal(self.Frame:GetName().."Title"):SetText(iTitle);
end

function DBMGui:SetText(iText)
	if self == DBMGui then return; end
	getglobal(self.Frame:GetName().."Text"):SetText(iText);
end

function DBMGui:CreateStatusBar(iMin, iMax, iValue, iTitle, iLeftText, iRightText)
	if self == DBMGui then return; end
	local tempFrame;
	tempFrame = DBMGui.InfoFrameRestoreFind("StatusBar");
	if( tempFrame ) then
		tempFrame:SetParent(self.Frame);
		tempFrame:ClearAllPoints();
	else 
		tempFrame = CreateFrame("StatusBar", DBMGui.InfoFrameGetNewName(), self.Frame, "DBMInfoFrameTemplateBar");
	end
	tempFrame:SetWidth(140);
	tempFrame:SetHeight(16);
	tempFrame:SetPoint("TOP", self.Frame, "TOP", 0, -20);
	tempFrame:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
	tempFrame:SetStatusBarColor(0, 1, 0);
	tempFrame:SetMinMaxValues(tonumber(iMin), tonumber(iMax));
	tempFrame:SetValue(tonumber(iValue));
	if( iTitle ) then	getglobal(tempFrame:GetName().."Text"):SetText(iTitle);
	else			getglobal(tempFrame:GetName().."Text"):SetText("");
	end
	if( iLeftText ) then	getglobal(tempFrame:GetName().."LeftText"):SetText(iLeftText);
	else			getglobal(tempFrame:GetName().."LeftText"):SetText("");
	end
	if( iRightText ) then	getglobal(tempFrame:GetName().."RightText"):SetText(iRightText);
	else			getglobal(tempFrame:GetName().."RightText"):SetText("");
	end
	getglobal(tempFrame:GetName().."Text"):SetTextColor(1, 1, 1);
	getglobal(tempFrame:GetName().."LeftText"):SetTextColor(1, 1, 1);
	getglobal(tempFrame:GetName().."RightText"):SetTextColor(1, 1, 1);
	tempFrame:Show();
	DBM_InfoFrameTemplate_OnUpdate(tempFrame:GetParent(), 0, true);
	
	table.insert(self.SubFrames, {
		["Type"] = "StatusBar",
		["Frame"] = tempFrame,
	});
	return setmetatable(self.SubFrames[table.getn(self.SubFrames)], DBMGuiStatusBarMetatable);
end

function DBMGuiStatusBar:SetValue(iValue)
	self.Frame:SetValue(tonumber(iValue));
end

function DBMGuiStatusBar:GetValue()
	return self.Frame:GetValue();
end

function DBMGuiStatusBar:SetTitle(iTitle)
	getglobal(self.Frame:GetName().."Text"):SetText(iTitle);
end

function DBMGui:CreateTextField(iText)
	if self == DBMGui then return; end
	local tempFrame;
	tempFrame = DBMGui.InfoFrameRestoreFind("TextFrame");
	if( tempFrame ) then
		tempFrame:SetParent(self.Frame);
		tempFrame:ClearAllPoints();
	else 
		tempFrame = CreateFrame("Frame", DBMGui.InfoFrameGetNewName(), self.Frame, "DBMInfoFrameTemplateTextField");
	end
	tempFrame:SetPoint("TOP", self.Frame, "TOP", 0, -20);
	tempFrame:Show();
	DBM_InfoFrameTemplate_OnUpdate(tempFrame:GetParent(), 0, true);
	if( iText ~= nil ) then
		getglobal(tempFrame:GetName().."Text"):SetText(iText);
	end

	table.insert(self.SubFrames, {
		["Ident"] = iSub,
		["Type"] = "TextFrame",
		["Frame"] = tempFrame,
	});	
	return setmetatable(self.SubFrames[table.getn(self.SubFrames)], DBMGuiTextFieldMetatable);
end

function DBMGuiTextField:SetText(iText)
	getglobal(self.Frame:GetName().."Text"):SetText(iText);
end

function DBMGuiTextField:GetText()
	return getglobal(self.Frame:GetName().."Text"):GetText() or ""
end

------------------
-- FRAME KILLER --
------------------
function DBMGui:Delete()
	if self == DBMGui then return; end
	if( self.SubFrames ) then	-- delete MainFrame
		for index, value in pairs(self.SubFrames) do		-- first delete all sub Frames
			value:Delete();
		end
	end
	self.Frame:ClearAllPoints();
	self.Frame:SetParent("DBMInfoFrameTrash");
	self.Frame:SetPoint("TOPLEFT", 0, 0);
	self.Frame:UnregisterAllEvents();

	-- CleanUp Texts
	if getglobal(self.Frame:GetName().."Title") then		getglobal(self.Frame:GetName().."Title"):SetText("");		end
	if getglobal(self.Frame:GetName().."Text") then			getglobal(self.Frame:GetName().."Text"):SetText("");		end
	if getglobal(self.Frame:GetName().."LeftText") then		getglobal(self.Frame:GetName().."LeftText"):SetText("");	end
	if getglobal(self.Frame:GetName().."RightText") then		getglobal(self.Frame:GetName().."RightText"):SetText("");	end

	if self.Type == "StatusBar" then
		self.Frame:EnableMouse(false);
		self.Frame:SetValue(0);
		self.Frame:SetStatusBarColor(0, 1, 0)
		self.Frame:SetMinMaxValues(0, 1); 
		for index, value in pairs(DBMStatusBarHandler) do
			if self.Frame:GetScript(value) then 	self.Frame:SetScript(value, nil);	end
		end
	elseif self.Type == "TextFrame" then
		self.Frame:EnableMouse(false);
		getglobal(self.Frame:GetName().."Text"):SetTextColor(1, 1, 1);
		for index, value in pairs(DBMFrameHandler) do
			if self.Frame:GetScript(value) then 	self.Frame:SetScript(value, nil);	end
		end
	elseif not self.Type then --> main frame
		self.Frame:EnableMouse(true)
		self.Frame.elapsed = 0;
		self.Frame.myWidth = self.Frame:GetWidth();
		self.Frame.myHeight = self.Frame:GetHeight();		
		for index, value in pairs(DBMFrameDefaultScripts) do
			if self.Frame:GetScript(index) ~= value then
				self.Frame:SetScript(index, value);
			end
		end
	end
	
	self.Frame:Hide();
	table.insert(DBMGui["Trash"], { 
		["Type"] = self.Type or "MainFrame",
		["Frame"] = self.Frame,
	});

--[[local env = getfenv();
	for index, value in pairs(env) do
		if value == self then
			getfenv()[index] = nil;
			break;
		end
	end]]

end

function DBMGui.InfoFrameRestoreFind(ftype) 		-- please DO NOT CALL THIS FUNCTION
	if( ftype == nil ) then return false; end
	for index, value in pairs(DBMGui.Trash) do
		if( value.Type == ftype ) then
			DBMGui.Trash[index] = nil;
			return value.Frame;
		end
	end
	return false;
end

--------------------------------------------------------------------------------
--
--   DistanceFrame - Usage via  /distance  loaded by GUI on "PLAYER_LOGIN"
--
--------------------------------------------------------------------------------


function DBM_Gui_DistanceFrame(moption) --fix me
	if moption then moption = nil; end
	if( DBMDistanceFrame ) then
		local mframe = DBMDistanceFrame:GetObject();
		if( mframe:IsShown() and not moption ) then	DBMDistanceFrame:Hide();
		else DBMDistanceFrame:Show(); end
	else DBM_Gui_CreateDistanceFrame();
	end
end

function DBM_Gui_DistanceFrame_Show()
	if( DBMDistanceFrame ) then
		DBMDistanceFrame:Show();
	else
		DBM_Gui_CreateDistanceFrame();
	end
end

function DBM_Gui_DistanceFrame_Hide()
	if( DBMDistanceFrame ) then
		DBMDistanceFrame:Hide();
	end
end


function DBM_Gui_CreateDistanceFrame()
	DBMDistanceFrame = DBMGui:CreateInfoFrame(DBMGUI_DISTANCE_FRAME_TITLE, DBMGUI_DISTANCE_FRAME_TEXT);
	if( not DBMDistanceFrame ) then 
		DBM.AddMsg("Can't get Frame from CreateInfoFrame()");
		return false; 
	end
	DBMDistanceFrame:GetObject():SetScript("OnUpdate", function() 
					DBM_InfoFrameTemplate_OnUpdate(this, arg1); 
					DBM_Gui_CreateDistanceFrame_OnUpdate(); 
				end);

	DBMDistanceFramePlayer1 = DBMDistanceFrame:CreateTextField("");
	getglobal(DBMDistanceFramePlayer1:GetObject():GetName().."Text"):SetTextColor(1, 0, 0);
	DBMDistanceFramePlayer2 = DBMDistanceFrame:CreateTextField("");
	getglobal(DBMDistanceFramePlayer2:GetObject():GetName().."Text"):SetTextColor(1, 0, 0);
	DBMDistanceFramePlayer3 = DBMDistanceFrame:CreateTextField("");
	getglobal(DBMDistanceFramePlayer3:GetObject():GetName().."Text"):SetTextColor(1, 0, 0);
	DBMDistanceFramePlayer4 = DBMDistanceFrame:CreateTextField("");
	getglobal(DBMDistanceFramePlayer4:GetObject():GetName().."Text"):SetTextColor(1, 0, 0);
	DBMDistanceFramePlayer5 = DBMDistanceFrame:CreateTextField("");
	getglobal(DBMDistanceFramePlayer5:GetObject():GetName().."Text"):SetTextColor(1, 0, 0);
end

function DBM_Gui_CreateDistanceFrame_OnUpdate()
	if( this.elapsed == nil ) then this.elapsed = 0; end
	this.elapsed = this.elapsed + arg1;
	if( this.elapsed > 0.5 ) then
		local x=1;

		for i=1, GetNumRaidMembers(), 1 do
			if( x <= 5 and DBM_Gui_CheckDistance("raid"..i) 
			and not UnitIsDeadOrGhost("raid"..i) 
			and UnitName("raid"..i) ~= UnitName("player") ) then

				if( getglobal("DBMDistanceFramePlayer"..x) ) then
					getglobal("DBMDistanceFramePlayer"..x):SetText(UnitName("raid"..i));
				end
				x = x + 1;

			end
		end

		if( x <= 5 ) then
			for i=x, 5, 1  do
				if( getglobal("DBMDistanceFramePlayer"..i) ) then
					getglobal("DBMDistanceFramePlayer"..i):SetText("");
				end
			end
		end
	end
end


function DBM_Gui_CheckDistance(uID)
	if DBMGui_DistanceFrame_Distance == 10 then
		return CheckInteractDistance(uID, 3);
	elseif DBMGui_DistanceFrame_Distance == 15 then
		if IsItemInRange(DBM_HEAVY_NW_BANDAGE, uID) == 1 then -- IsItemInRange returns 0 for out of range...and 0 is true in lua
			return true;
		else
			return false;
		end
	else
		return false;
	end
end

function DBM_Gui_DistanceFrame_SetDistance(distance)
	if distance == 10 then
		DBMGui_DistanceFrame_Distance = 10;
		if DBMDistanceFrame then
			DBMDistanceFrame:SetText(DBMGUI_DISTANCE_FRAME_TEXT);
		end
	elseif distance == 15 then
		if IsItemInRange(DBM_HEAVY_NW_BANDAGE, "player") then
			DBMGui_DistanceFrame_Distance = 15;
			if DBMDistanceFrame then
				DBMDistanceFrame:SetText(DBMGUI_DISTANCE_FRAME_TEXT_15YD);
			end
		elseif not UnitIsDeadOrGhost("player") then
			DBM.AddMsg(DBM_RANGE_FRAME_BANDAGE_MISSING, "Deadly Boss Mods");
		end
	end
end