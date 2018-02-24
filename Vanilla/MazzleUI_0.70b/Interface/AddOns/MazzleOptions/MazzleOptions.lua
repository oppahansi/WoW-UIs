-- Copyright © 2006 Mazin Assanie
-- All Rights Reserved.
-- 
-- Permission to use, copy, modify, and distribute this software in any way
-- is not granted without expressed written agreement.  In the case that it
-- is granted, the above copyright notice and this paragraph must appear in
-- all copies, modifications, and distributions.
--
-- To contact the author of this work, use mazzlefizz@gmail.com 
-- For more information on copyright, visit http://copyright.gov/ or http://whatiscopyright.org/
--

MazzleOptions_Version = 0.1

local MazzleOptions_WidgetPool = {}
MazzleOptions_WidgetPool.YesNoPool = {}
MazzleOptions_WidgetPool.CheckButtonPool = {}
MazzleOptions_WidgetPool.MenuPool = {}
MazzleOptions_WidgetPool.SliderPool = {}
MazzleOptions_WidgetPool.ButtonPool = {}
MazzleOptions_WidgetPool.TextboxPool = {}
MazzleOptions_WidgetPool.PerformancePool = {}
MazzleOptions_WidgetPool.TitleButtonPool = {}
MazzleOptions_ScrollPosition = {}

local MazzleOptions_ContentData
local MazzleOptions_MaxTopics

function MazzleOptions_OnLoad()
	this:RegisterEvent("ADDON_LOADED");
	tinsert(UISpecialFrames, "MazzleOptions_Frame");

end

function MazzleOptions_OnEvent(event)
	if (event=="ADDON_LOADED" and arg1=="MazzleOptions" and (not MazzleOptions_Initialized)) then
	    DEFAULT_CHAT_FRAME:AddMessage(MazzleOptions_LOADED_MESSAGE,0.0,1.0,0.0);
        if (not MazzleUI_Settings) then
            MazzleUI_Settings = {}
            SetupDefaultSettings()
        end

        MazzleOptions_SetupOptions()
        MazzleOptions_CompileDirectory()
        MazzleOptions_SetupHelp()
        
        if (not MazzleUI_Settings.OptionsLastTopic) then
            MazzleUI_Settings.OptionsMode = "Options"
            MazzleUI_Settings.OptionsLastTopic = 1
        end
        MazzleOptions_SetContentData()

        local OptionsButton
        if (MazzleOptions_SettingsInfo.NumTopics > MazzleOptions_HelpInfo.NumTopics) then
            MazzleOptions_MaxTopics = MazzleOptions_SettingsInfo.NumTopics; else MazzleOptions_MaxTopics = MazzleOptions_HelpInfo.NumTopics;
        end
        for i=1, MazzleOptions_MaxTopics, 1 do
            OptionsButton = CreateFrame("Button", "MazzleOptionsTopic"..i, MazzleOptions_Topics_ScrollChildFrame, "MazzleOptionsTitleButtonTemplate");
            OptionsButton:SetID(i);
            OptionsButton.isActive = 1;
            if ( i > 1 ) then
                OptionsButton:SetPoint("TOPLEFT", "MazzleOptionsTopic"..(i-1),"BOTTOMLEFT", 0, 0)
            else
                OptionsButton:SetPoint("TOPLEFT", "MazzleOptions_Topics_ScrollChildFrame", "TOPLEFT", -10, -5);
            end
        end
	end
end

function MazzleOptions_Show()
	MazzleOptions_Frame:Show();
    MazzleOptions_PopulateTopics()
    MazzleOptions_LayoutWidgets(MazzleUI_Settings.OptionsLastTopic)
    MazzleOptions_RestoreScrollPosition()
	Timex:AddSchedule("MazzleOptions_AnimTimer", 0.3, true, nil, MazzleOptions_Animate)
	MazzleUI_Settings.needsReload = false
	Timex:AddSchedule("MazzleOptions_AnimTimer", 1, true, nil, function() MazzleOptions_Topics_ScrollFrame:UpdateScrollChildRect(); end);

end

function MazzleOptions_SetContentData()
    if (MazzleUI_Settings.OptionsMode == "Options") then
        MazzleOptions_ContentData = MazzleOptions_SettingsInfo
        MazzleOptions_HelpButton:UnlockHighlight()
        MazzleOptions_OptionsButton:LockHighlight()
    else
        MazzleOptions_ContentData = MazzleOptions_HelpInfo
        MazzleOptions_OptionsButton:UnlockHighlight()
        MazzleOptions_HelpButton:LockHighlight()
    end
    MazzleUI_Settings.OptionsLastTopic = 1
end

function MazzleOptions_CategoryButtonOnClick(buttonID)
    if (buttonID == 1) then
        MazzleUI_Settings.OptionsMode = "Options"
    else
        MazzleUI_Settings.OptionsMode = "Help"
    end
    MazzleOptions_SetContentData()
    MazzleOptions_PopulateTopics()
    MazzleOptions_LayoutWidgets(MazzleUI_Settings.OptionsLastTopic)
    MazzleOptions_RestoreScrollPosition()
end

function MazzleOptions_Hide()
	Timex:DeleteSchedule("MazzleOptions_AnimTimer")
	MazzleOptions_Frame:Hide();
	if (MazzleUI_Settings.needsReload) then MazzleOptions_ReloadUIFrame:Show() end
end

function MazzleOptions_Animate()
    if (MazzleOptionsWaveTexture1:IsVisible()) then
        MazzleOptionsWaveTexture1:Hide()
        MazzleOptionsWaveTexture2:Show()
    else
        MazzleOptionsWaveTexture1:Show()
        MazzleOptionsWaveTexture2:Hide()
    end
end

function MazzleOptions_PopulateTopics()
    local totalWidth = 280
    local OptionsButton, lastPoint
    local repeatString, repeatWidth, repeatLength, entryString
    if ( MazzleOptions_ContentData.NumTopics > 0 ) then
        for i=1, MazzleOptions_MaxTopics, 1 do
            OptionsButton = getglobal("MazzleOptionsTopic"..i);
            if (i <= MazzleOptions_ContentData.NumTopics) then
                OptionsButton:SetText(MazzleOptions_ContentData.Contents[i].name);
                OptionsButton:SetHeight(OptionsButton:GetTextHeight() + 6);
                if (string.sub(MazzleOptions_ContentData.Contents[i].name, 1,1) == " ") then
                    repeatString = "-"
                    repeatWidth = 4
                    entryString = "|CFF00FF00 "..MazzleOptions_ContentData.Contents[i].name.." |CFFFF0000"
                    repeatLength = (((totalWidth - OptionsButton:GetTextWidth())/2)/repeatWidth)
                    OptionsButton:SetText(TEXT("|CFFFF0000"..string.rep(repeatString, repeatLength)..entryString..string.rep(repeatString, repeatLength)))
                end
    
                if (MazzleOptions_ContentData.Contents[i].tooltipText) then
                    OptionsButton.tooltipText = MazzleOptions_ContentData.Contents[i].tooltipText
                end
                OptionsButton:Show();
           else
                OptionsButton:Hide();
           end
           _, lastPoint, _, _, _ = OptionsButton:GetPoint()
            if (MazzleUI_Settings.OptionsMode == "Options") then
                if (i>1) then OptionsButton:ClearAllPoints(); OptionsButton:SetPoint("TOPLEFT", "MazzleOptionsTopic"..(i-1),"BOTTOMLEFT", 0, 0); end
                getglobal("MazzleOptionsTopic"..i.."NormalText"):ClearAllPoints()
                getglobal("MazzleOptionsTopic"..i.."NormalText"):SetPoint("TOP", 0, -4)
            else
                if (i>1) then OptionsButton:ClearAllPoints(); OptionsButton:SetPoint("TOPLEFT", "MazzleOptionsTopic"..(i-1),"BOTTOMLEFT", 0, -5); end
                getglobal("MazzleOptionsTopic"..i.."NormalText"):ClearAllPoints()
                getglobal("MazzleOptionsTopic"..i.."NormalText"):SetPoint("LEFT", 10, 0)
            end                

        end
    end
    MazzleOptions_Topics_ScrollFrame:UpdateScrollChildRect();
end


function MazzleOptions_TopicButton_OnClick(buttonID)
	PlaySound("igQuestListSelect");
	MazzleOptions_SaveScrollPosition()
	MazzleUI_Settings.OptionsLastTopic = buttonID
    MazzleOptions_LayoutWidgets(buttonID)
    MazzleOptions_RestoreScrollPosition()
end

function MazzleOptions_SaveScrollPosition()
    if (MazzleUI_Settings.OptionsMode == "Options") then
        MazzleOptions_ScrollPosition[MazzleUI_Settings.OptionsLastTopic] = MazzleOptions_Contents_ScrollFrame:GetVerticalScroll()
    end
end

function MazzleOptions_RestoreScrollPosition()
    if  ((MazzleUI_Settings.OptionsMode == "Options") and MazzleOptions_ScrollPosition[MazzleUI_Settings.OptionsLastTopic]) then
        --MazzleOptions_Contents_ScrollFrame:SetVerticalScroll(MazzleOptions_ScrollPosition[MazzleUI_Settings.OptionsLastTopic])
        -- for some reason, scroll bar does not move though contents do.  Setting it on a timer as a quick workaround
        Timex:AddSchedule("MazzleOptions_ScrollTimer", 0.05, nil, nil, function() MazzleOptions_Contents_ScrollFrame:SetVerticalScroll(MazzleOptions_ScrollPosition[MazzleUI_Settings.OptionsLastTopic]); end)
        
    else
        MazzleOptions_Contents_ScrollFrame:SetVerticalScroll(0)
    end
end

function MazzleOptions_CreateWidget(requestedType, requestedAnchor, requestedParent, anchorType, xadjust, yadjust, widgetID)
    if (not xadjust) then
        xadjust = 0
    end
    if (not yadjust) then
        yadjust = 0
    end

    local newWidgetName

    local newWidgetType, newWidgetName, newWidgetTemplate, newWidgetList, newWidget
    if (requestedType == "YesNo") then
         newWidgetType = "Frame"
         newWidgetTemplate = "MazzleOptions_YesNoTemplate"
         newWidgetList = "YesNoPool"
    elseif (requestedType == "CheckButton") then
         newWidgetType = "CheckButton"
         newWidgetTemplate = "MazzleOptions_CheckButtonTemplate"
         newWidgetList = "CheckButtonPool"
         yadjust = yadjust + 12
    elseif (requestedType == "Slider") then
         newWidgetType = "Slider"
         newWidgetTemplate = "MazzleOptions_SliderTemplate"
         newWidgetList = "SliderPool"
    elseif (requestedType == "Menu") then
         newWidgetType = "Frame"
         newWidgetTemplate = "MazzleOptions_ButtonDropDownTemplate"
         newWidgetList = "MenuPool"
    elseif (requestedType == "Textbox") then
         newWidgetType = "Frame"
         newWidgetTemplate = "MazzleOptions_TextBoxTemplate"
         newWidgetList = "TextboxPool"
    elseif (requestedType == "Button") then
         newWidgetType = "Button"
         newWidgetTemplate = "MazzleOptions_ButtonTemplate"
         newWidgetList = "ButtonPool"
    elseif (requestedType == "PerformanceEntry") then
         newWidgetType = "Frame"
         newWidgetTemplate = "MazzleOptions_PerformanceTemplate"
         newWidgetList = "PerformancePool"
    elseif (requestedType == "TitleButton") then
         newWidgetType = "Button"
         newWidgetTemplate = "MazzleOptionsTitleButtonTemplate"
         newWidgetList = "TitleButtonPool"
    end

    for i=1, table.getn(MazzleOptions_WidgetPool[newWidgetList]), 1 do
        if (MazzleOptions_WidgetPool[newWidgetList][i].isFree) then
            --ace:print ("--> Found an existing widget to reuse.")
            newWidget = MazzleOptions_WidgetPool[newWidgetList][i]
            newWidgetName = MazzleOptions_WidgetPool[newWidgetList][i].widgetName
        end
    end
    if (not newWidget) then
        newWidget = {}
        newWidget.widgetName = "MazzleOptions_"..requestedType..(table.getn(MazzleOptions_WidgetPool[newWidgetList])+1)
        newWidget.frame = CreateFrame(newWidgetType, newWidget.widgetName, requestedParent, newWidgetTemplate);
        table.insert(MazzleOptions_WidgetPool[newWidgetList], newWidget)
    end
    newWidget.isFree = false
    newWidget.frame:SetParent(requestedParent)
	newWidget.frame:ClearAllPoints()
	if (anchorType == "top") then
        newWidget.frame:SetPoint("TOPLEFT", requestedAnchor, "TOPLEFT", (5 + xadjust), (-10 + yadjust));
	elseif (anchorType == "topright") then
        newWidget.frame:SetPoint("TOPRIGHT", requestedAnchor, "TOPRIGHT", (-30 + xadjust), (-20 + yadjust));
	elseif (anchorType == "middle") then
        newWidget.frame:SetPoint("TOPLEFT", requestedAnchor, "BOTTOMLEFT", xadjust, (-10 + yadjust));
	elseif (anchorType == "right") then
        newWidget.frame:SetPoint("TOPRIGHT", requestedAnchor, "BOTTOMRIGHT", xadjust, (0 + yadjust));
	elseif (anchorType == "aboveright") then
        newWidget.frame:SetPoint("BOTTOMRIGHT", requestedAnchor, "TOPRIGHT", xadjust, (0 + yadjust));
	elseif (anchorType == "center") then
        newWidget.frame:SetPoint("TOP", requestedAnchor, "BOTTOM", xadjust, (-20 + yadjust));
    end
    if (requestedType == "YesNo") then
        newWidget.labelName = newWidget.widgetName.."Title"
        newWidget.checkButtonYes = newWidget.widgetName.."_CheckButtonYes"
        newWidget.checkButtonNo = newWidget.widgetName.."_CheckButtonNo"
    elseif (requestedType == "CheckButton") then
        newWidget.labelName = newWidget.widgetName.."Text"
    elseif (requestedType == "Textbox") then
        newWidget.labelName = newWidget.widgetName.."_Text"
    elseif (requestedType == "Slider") then
        newWidget.labelName = newWidget.widgetName.."Text"
        newWidget.lowName = newWidget.widgetName.."Low"
        newWidget.highName = newWidget.widgetName.."High"
    elseif (requestedType == "Menu") then
        newWidget.labelName = newWidget.widgetName.."Label"
    elseif (requestedType == "Button") then
        newWidget.labelName = newWidget.widgetName.."Label"
    elseif (requestedType == "PerformanceEntry") then
        newWidget.labelName = newWidget.widgetName.."Label"
        newWidget.headerName = newWidget.widgetName.."Header"
        newWidget.checkButton1 = newWidget.widgetName.."_CheckButton1"
        newWidget.checkButton2 = newWidget.widgetName.."_CheckButton2"
        newWidget.checkButton3 = newWidget.widgetName.."_CheckButton3"
        newWidget.checkButton4 = newWidget.widgetName.."_CheckButton4"
        newWidget.checkButton5 = newWidget.widgetName.."_CheckButton5"
        newWidget.checkButton6 = newWidget.widgetName.."_CheckButton6"
    end
    newWidget.frame:Show()
    newWidget.frame:SetID(widgetID)
    return newWidget
end

function MazzleOptions_ClearWidgets()
    local currentWidget
    -- Loop through different widget lists and put them as unused
    for _,poolList in {"YesNoPool", "CheckButtonPool", "SliderPool", "MenuPool", "PerformancePool", "ButtonPool", "TextboxPool", "TitleButtonPool"} do
        for i=1, table.getn(MazzleOptions_WidgetPool[poolList]), 1 do
            currentWidget = MazzleOptions_WidgetPool[poolList][i]
            currentWidget.isFree = true
            currentWidget.frame:SetParent(UIParent)
            currentWidget.frame:ClearAllPoints()
            currentWidget.frame:SetPoint("CENTER", UIParent)
            currentWidget.frame:SetID(0)
            currentWidget.frame:Hide()
        end
    end
end

function MazzleOptions_CountWidgets()
    for _,poolList in {"YesNoPool", "CheckButtonPool", "SliderPool", "MenuPool", "PerformancePool", "ButtonPool", "TextboxPool", "TitleButtonPool"} do
        ace:print("Number of ", poolList, " widgets: ", table.getn(MazzleOptions_WidgetPool[poolList]))
    end
end

	
function MazzleOptions_YesNo_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = MazzleOptions_CreateWidget("YesNo", lastFrame, MazzleOptions_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)
    getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.question))
    if ((currentWidgetInfo.parameter and MazzleUI_GetValue(currentWidgetInfo.parameter)) or
        (currentWidgetInfo.readOnlyParameter and MazzleUI_GetValue(currentWidgetInfo.readOnlyParameter)) or
        (currentWidgetInfo.readProc and currentWidgetInfo.readProc())) then
        getglobal(lastWidget.widgetName.."_CheckButtonYes"):SetChecked(1)
        getglobal(lastWidget.widgetName.."_CheckButtonNo"):SetChecked(nil)
    else
        getglobal(lastWidget.widgetName.."_CheckButtonYes"):SetChecked(nil)
        getglobal(lastWidget.widgetName.."_CheckButtonNo"):SetChecked(1)
    end
    if (currentWidgetInfo.yesText) then
        getglobal(lastWidget.widgetName.."_CheckButtonYesText"):SetText(TEXT(currentWidgetInfo.yesText))
    end
    if (currentWidgetInfo.noText) then
        getglobal(lastWidget.widgetName.."_CheckButtonNoText"):SetText(TEXT(currentWidgetInfo.noText))
    end
    return lastWidget
end

function MazzleOptions_Menu_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = MazzleOptions_CreateWidget("Menu", lastFrame, MazzleOptions_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)
    getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.name))
    if (currentWidgetInfo.menuItemsReadProc) then
        MazzleOptions_Menu_Initialize(lastWidget.frame, currentWidgetInfo.menuItemsReadProc())
    else
        MazzleOptions_Menu_Initialize(lastWidget.frame, currentWidgetInfo.menuItems)
    end
    if (currentWidgetInfo.width) then
        UIDropDownMenu_SetWidth( currentWidgetInfo.width, lastWidget.frame)
    end
    if (MazzleOptions_EnabledStatus) then
        OptionsFrame_EnableDropDown(lastWidget.frame)
        local menuValue = nil
        if (currentWidgetInfo.parameter) then
            menuValue = MazzleUI_GetValue(currentWidgetInfo.parameter)
        elseif (currentWidgetInfo.readOnlyParameter) then
            menuValue = MazzleUI_GetValue(currentWidgetInfo.readOnlyParameter)
        end    
        if (currentWidgetInfo.readProc) then
             menuValue = currentWidgetInfo.readProc(menuValue)
        end
        UIDropDownMenu_SetSelectedValue(lastWidget.frame, menuValue)
    else
        OptionsFrame_DisableDropDown(lastWidget.frame)
    end
    return lastWidget
end

function MazzleOptions_Menu_Initialize(theMenu, itemList)
	UIDropDownMenu_Initialize(theMenu, function() MazzleOptions_Menu_MakeButtons(theMenu, itemList) end);
	theMenu.tooltip = "";
	UIDropDownMenu_SetWidth(323, theMenu);
	UIDropDownMenu_JustifyText("CENTER", theMenu)
end

function MazzleOptions_Menu_MakeButtons(theMenu, itemList)
	local selectedValue = UIDropDownMenu_GetSelectedValue(theMenu);
	local info;
    local valcnt = 0
    for index,value in itemList do
        valcnt = valcnt + 1
    	info = {};
    	info.text = itemList[index];
    	info.func = function() MazzleOptions_Menu_SetValue(theMenu) end;
    	info.value = valcnt
    	if ( info.value == selectedValue ) then
    		info.checked = 1;
    	end
    	UIDropDownMenu_AddButton(info);
    end
end

function MazzleOptions_Menu_SetValue(theMenu)
	UIDropDownMenu_SetSelectedValue(theMenu, this.value);
    if (MazzleOptions_CurrentOptions[theMenu:GetID()].info.parameter) then
        MazzleUI_CreateSet( MazzleOptions_CurrentOptions[theMenu:GetID()].info.parameter, this.value)
    end
    MazzleOptions_SetProc(theMenu:GetID(), this.value)
end

function MazzleOptions_TitleButton_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = MazzleOptions_CreateWidget("TitleButton", lastFrame, MazzleOptions_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)
    if (currentWidgetInfo.label) then
        lastWidget.frame:SetText(TEXT(currentWidgetInfo.label))
    end
    lastWidget.frame:SetWidth(MazzleOptions_Content_ScrollChildFrame:GetWidth())
    lastWidget.frame:SetScript("OnClick", currentWidgetInfo.setProc)
    getglobal(lastWidget.widgetName.."NormalText"):ClearAllPoints()
    getglobal(lastWidget.widgetName.."NormalText"):SetPoint("LEFT", lastWidget.frame, "LEFT", 5, 0)
    return lastWidget
end

function MazzleOptions_Button_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = MazzleOptions_CreateWidget("Button", lastFrame, MazzleOptions_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)
    if (currentWidgetInfo.name) then
        lastWidget.frame:SetText(TEXT(currentWidgetInfo.name))
    end
    if (currentWidgetInfo.label) then
        getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.label))
    end
    if (MazzleOptions_EnabledStatus) then
        lastWidget.frame:Enable()
    else
        lastWidget.frame:Disable()
    end
    return lastWidget
end

function MazzleOptions_Button_SetValue(widgetID)
    MazzleOptions_SetProc(widgetID)
end

function MazzleOptions_CheckButton_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = MazzleOptions_CreateWidget("CheckButton", lastFrame, MazzleOptions_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)
    getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.name))
    if (MazzleOptions_EnabledStatus) then
        OptionsFrame_EnableCheckBox(lastWidget.frame)
        local checkValue = nil
        if (currentWidgetInfo.parameter) then
            checkValue = MazzleUI_GetValue(currentWidgetInfo.parameter)
        elseif (currentWidgetInfo.readOnlyParameter) then
            checkValue = MazzleUI_GetValue(currentWidgetInfo.readOnlyParameter)
        end    
        if (currentWidgetInfo.readProc) then
             checkValue = currentWidgetInfo.readProc(checkValue)
        end
        lastWidget.frame:SetChecked(checkValue)
    else
        OptionsFrame_DisableCheckBox(lastWidget.frame)
    end
    return lastWidget
end

function MazzleOptions_CheckButton_SetValue(widgetID, widgetValue)
    if (MazzleOptions_CurrentOptions[widgetID].info.parameter) then
        MazzleUI_CreateSet( MazzleOptions_CurrentOptions[widgetID].info.parameter, widgetValue)
    end
    MazzleOptions_SetProc(widgetID, widgetValue)
end

function MazzleOptions_Slider_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = MazzleOptions_CreateWidget("Slider", lastFrame, MazzleOptions_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)

	getglobal(lastWidget.lowName):SetText(TEXT(MazzleOptions_Slider_Round(currentWidgetInfo.stepValue,currentWidgetInfo.minValue)))
	getglobal(lastWidget.highName):SetText(TEXT(MazzleOptions_Slider_Round(currentWidgetInfo.stepValue,currentWidgetInfo.maxValue)))
	lastWidget.frame:SetMinMaxValues(currentWidgetInfo.minValue, currentWidgetInfo.maxValue);
	lastWidget.frame:SetValueStep(currentWidgetInfo.stepValue);

    if (MazzleOptions_EnabledStatus) then
        local paramValue
    	if (currentWidgetInfo.readOnlyParameter) then
            paramValue = MazzleUI_GetValue(currentWidgetInfo.readOnlyParameter) or 0;
        elseif (currentWidgetInfo.readFunc) then
            paramValue = currentWidgetInfo.readFunc();
        elseif (currentWidgetInfo.parameter) then
            paramValue = MazzleUI_GetValue(currentWidgetInfo.parameter) or 0
        end
        getglobal(lastWidget.labelName):SetText(
            currentWidgetInfo.name.." "..MazzleOptions_Slider_Round(currentWidgetInfo.stepValue,paramValue)..currentWidgetInfo.units)
        lastWidget.frame:SetValue(paramValue);
        OptionsFrame_EnableSlider(lastWidget.frame);
    else
        getglobal(lastWidget.labelName):SetText(currentWidgetInfo.name)
        OptionsFrame_DisableSlider(lastWidget.frame);
    end
	lastWidget.frame.tooltipText = currentWidgetInfo.tooltip or "";
    return lastWidget
end

function MazzleOptions_SliderSet(widgetID, widgetValue)
    widgetValue = MazzleOptions_Slider_Format(widgetID, widgetValue)
    MazzleUI_CreateSet( MazzleOptions_CurrentOptions[widgetID].info.parameter, tonumber(widgetValue))
    getglobal(MazzleOptions_CurrentOptions[widgetID].widget.labelName):SetText(
        MazzleOptions_CurrentOptions[widgetID].info.name.." "..widgetValue..MazzleOptions_CurrentOptions[widgetID].info.units)
    MazzleOptions_SetProc(widgetID, tonumber(widgetValue))
end

function MazzleOptions_Slider_Format(widgetID, sliderValue)
    return MazzleOptions_Slider_Round(MazzleOptions_CurrentOptions[widgetID].info.stepValue, sliderValue)
end

function MazzleOptions_Slider_Round(stepValue, sliderValue)
    local formatString = "%i"
    if (stepValue < 1) then
        formatString = "%.2f"
    end
    if (sliderValue == nil) then return 0 else return string.format(formatString, sliderValue) end
end

function MazzleOptions_AddOnHeader_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)

    local realNumLines = currentWidgetInfo.numLines
    
    local headerName, buttonName, addonToggleFunc, enableStatus = MazzleOptions_GetAddonStatus(currentWidgetInfo)

    MazzleOptions_EnabledStatus = enableStatus
    currentWidgetInfo.numLines = 1
    currentWidgetInfo.text = headerName
    currentWidgetInfo.width = nil
    currentWidgetInfo.headerWidget = MazzleOptions_Textbox_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    
    currentWidgetInfo.numLines = realNumLines
    if (currentJustification == "top") then currentJustification = "middle"; end;
    currentWidgetInfo.text = currentWidgetInfo.addonDescription
    currentWidgetInfo.width = "full"
    local infoWidget = MazzleOptions_Infobox_Create(currentWidgetInfo, currentWidgetInfo.headerWidget.frame, currentJustification, xadjust, yadjust, widgetID)
     
    MazzleOptions_EnabledStatus = true;
    currentWidgetInfo.name = buttonName;
    currentWidgetInfo.setProc = addonToggleFunc

    currentWidgetInfo.theButton = MazzleOptions_Button_Create(currentWidgetInfo, infoWidget.frame, "aboveright", xadjust, yadjust, widgetID)
    
    MazzleOptions_EnabledStatus = enableStatus

    return infoWidget
end

function MazzleOptions_ToggleAddOn( turnOn, currentWidgetInfo)

    if (turnOn) then
        ace:print(TEXT("|CFFFF0000MazzleOptions:|CFFFFFFFF  "), currentWidgetInfo.addonName, " will be enabled upon next UI reload.")
        EnableAddOn(currentWidgetInfo.requiredAddOn)
    else
        ace:print(TEXT("|CFFFF0000MazzleOptions:|CFFFFFFFF  "), currentWidgetInfo.addonName, " will be disabled upon next UI reload.")
        DisableAddOn(currentWidgetInfo.requiredAddOn)
    end

    local headerName, buttonName, addonToggleFunc = MazzleOptions_GetAddonStatus(currentWidgetInfo)
    currentWidgetInfo.setProc = addonToggleFunc;
    local textWidget = getglobal(currentWidgetInfo.headerWidget.labelName)
    textWidget:SetText(TEXT(headerName))
    currentWidgetInfo.headerWidget.frame:SetWidth(textWidget:GetStringWidth() + 32)
    currentWidgetInfo.theButton.frame:SetText(TEXT(buttonName))
    MazzleUI_Settings.needsReload = true
end

function MazzleOptions_GetAddonStatus( currentWidgetInfo )
    local isEnabled, loadable, rv1, rv2, rv3, rv4
    _, _, _, isEnabled, loadable, _, _= GetAddOnInfo(currentWidgetInfo.requiredAddOn)
    if (isEnabled) then
        if (loadable) then
            rv1 = currentWidgetInfo.addonName
            rv2 = "Disable AddOn"
            rv3 = function() MazzleOptions_ToggleAddOn(false, currentWidgetInfo); end;
            rv4 = true
        else
            rv1 = currentWidgetInfo.addonName.." (on after reload)"
            rv2 = "Don't Enable"
            rv3 = function() MazzleOptions_ToggleAddOn(false, currentWidgetInfo); end;
            rv4 = false
        end
    else
        if (loadable) then
            rv1 = currentWidgetInfo.addonName.." (off after reload)"
            rv2 = "Don't Disable"
            rv3 = function() MazzleOptions_ToggleAddOn(true, currentWidgetInfo); end;
            rv4 = true
        else
            rv1 = currentWidgetInfo.addonName
            rv2 = "Enable AddOn"
            rv3 = function() MazzleOptions_ToggleAddOn(true, currentWidgetInfo); end;
            rv4 = false
        end
    end
    return rv1, rv2, rv3, rv4
end

function MazzleOptions_Textbox_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID, textOverride)
    local lastWidget = MazzleOptions_CreateWidget("Textbox", lastFrame, MazzleOptions_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID, textOverride)
    
    local theTextString = currentWidgetInfo.text
    if (textOverride) then theTextString = textOverride; end
    
    local textWidget = getglobal(lastWidget.labelName)
    if (MazzleOptions_EnabledStatus) then
        textWidget:SetTextColor(0, 1, 0);
        textWidget:SetText(TEXT(theTextString))
    else
        textWidget:SetText(TEXT(theTextString))
        textWidget:SetTextColor(0.5, 0.5, 0.5);
    end
    
    if (currentWidgetInfo.width == "full") then currentWidgetInfo.width = 500
    else currentWidgetInfo.width = currentWidgetInfo.width or (textWidget:GetStringWidth() + 32); end
    
    textWidget:ClearAllPoints()
    textWidget:SetPoint("TOPLEFT", lastWidget.frame, "TOPLEFT" , 0, 0);
    textWidget:SetWidth(currentWidgetInfo.width-20)
    lastWidget.frame:SetWidth(currentWidgetInfo.width)
    lastWidget.frame:SetHeight(textWidget:GetHeight()+20)
    textWidget:ClearAllPoints()
    textWidget:SetPoint("TOPLEFT", lastWidget.frame, "TOPLEFT" , 10, -10);
    textWidget:SetPoint("BOTTOMRIGHT", lastWidget.frame, "BOTTOMRIGHT" , -10, 10);
    
    if (not MazzleOptions_TextboxBackdrop) then
        MazzleOptions_TextboxBackdrop = lastWidget.frame:GetBackdrop()
    else
        lastWidget.frame:SetBackdrop(MazzleOptions_TextboxBackdrop) 
        lastWidget.frame:SetBackdropBorderColor(0.4, 0.4, 0.4);
        lastWidget.frame:SetBackdropColor(0.05, 0.05, 0.05);
    end
    return lastWidget
end

    
function MazzleOptions_Infobox_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = MazzleOptions_Textbox_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, (yadjust+16), widgetID)

    if (MazzleOptions_EnabledStatus) then
		getglobal(lastWidget.labelName):SetTextColor(1, 1, 1);
        getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.text))
    else
        getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.text))
		getglobal(lastWidget.labelName):SetTextColor(0.5, 0.5, 0.5);
    end
    --lastWidget.frame:SetWidth(currentWidgetInfo.width or 500)
    return lastWidget
end

function MazzleOptions_Notebox_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)

    local noteText
    if (currentWidgetInfo.notetype  == "warning") then
        noteText = "|CFFFF0000Warning: |r"..currentWidgetInfo.text
    elseif (currentWidgetInfo.notetype  == "example") then
        noteText = "|CFFFF8000Example: |r"..currentWidgetInfo.text
    elseif (currentWidgetInfo.notetype  == "none") then
        noteText = currentWidgetInfo.text
    else
        noteText = "|CFFFF8000Note:  |r"..currentWidgetInfo.text
    end
    currentWidgetInfo.width = "full"
    
    local lastWidget = MazzleOptions_Textbox_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust , widgetID, noteText)
    if (MazzleOptions_EnabledStatus) then
		getglobal(lastWidget.labelName):SetTextColor(1, 1, 1);
        getglobal(lastWidget.labelName):SetText(TEXT(noteText))
    else
        getglobal(lastWidget.labelName):SetText(TEXT(noteText))
		getglobal(lastWidget.labelName):SetTextColor(0.5, 0.5, 0.5);
    end

    --lastWidget.frame:SetWidth(currentWidgetInfo.width or 500)
    lastWidget.frame:SetBackdrop(nil)
    return lastWidget
end

function MazzleOptions_SetScrollingText(frameName, newText)
    getglobal(frameName.."_ScrollFrame__ScrollChildFrame_Text"):SetText(newText)
    getglobal(frameName.."_ScrollFrame__ScrollChildFrame_Text"):SetHeight(getglobal(frameName.."_ScrollFrame__ScrollChildFrame_Text"):GetHeight())
end

function MazzleOptions_SetText(frameName, newText, newTextHeight, newTextWidth)
    getglobal(frameName.."_Text"):SetText(newText)
    getglobal(frameName.."_Text"):SetNonSpaceWrap(true)
    getglobal(frameName):SetHeight(newTextHeight)
    getglobal(frameName):SetWidth(newTextWidth)
    
end

function MazzleOptions_TestHeight(widgetNum, newHeight, newWidth, newText)
    local theText = newText or getglobal(MazzleOptions_CurrentOptions[widgetNum].widget.widgetName.."_Text"):GetText()
    local theWidth = newWidth or getglobal(MazzleOptions_CurrentOptions[widgetNum].widget.widgetName):GetWidth()
    local theHeight = newHeight or getglobal(MazzleOptions_CurrentOptions[widgetNum].widget.widgetName):GetHeight()
    MazzleOptions_SetText(MazzleOptions_CurrentOptions[widgetNum].widget.widgetName, theText, theHeight, theWidth)
end

function MazzleOptions_PerformanceEntry_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = MazzleOptions_CreateWidget("PerformanceEntry", lastFrame, MazzleOptions_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)
    getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.name))
    if (currentWidgetInfo.header) then
        getglobal(lastWidget.headerName):SetText(TEXT(currentWidgetInfo.header))
    else
        getglobal(lastWidget.headerName):SetText("")
    end
    getglobal(lastWidget.checkButton1):SetChecked(MazzleUI_GetValue(currentWidgetInfo.parameter..".solo"))
    getglobal(lastWidget.checkButton2):SetChecked(MazzleUI_GetValue(currentWidgetInfo.parameter..".combat"))
    getglobal(lastWidget.checkButton3):SetChecked(MazzleUI_GetValue(currentWidgetInfo.parameter..".party"))
    getglobal(lastWidget.checkButton4):SetChecked(MazzleUI_GetValue(currentWidgetInfo.parameter..".raid"))
    getglobal(lastWidget.checkButton5):SetChecked(MazzleUI_GetValue(currentWidgetInfo.parameter..".pvp"))
    getglobal(lastWidget.checkButton6):SetChecked(MazzleUI_GetValue(currentWidgetInfo.parameter..".manual"))
    return lastWidget
end

function MazzleOptions_PerformanceEntry_SetValue(widgetID, modeID, modeValue)
    --ace:print("MazzleOptions_PerformanceEntry_SetValue called with ", widgetID, " ", modeID, " ", modeValue)
    if (MazzleOptions_CurrentOptions[widgetID].info.parameter) then
        local modeString
        if (modeID == 1) then modeString = "solo"
            elseif (modeID == 2) then modeString = "combat"
            elseif (modeID == 3) then modeString = "party"
            elseif (modeID == 4) then modeString = "raid"
            elseif (modeID == 5) then modeString = "pvp"
            elseif (modeID == 6) then modeString = "manual"
        end
        --ace:print("Setting value of ", MazzleOptions_CurrentOptions[widgetID].info.parameter.."."..modeString, " to ", modeValue)
        MazzleUI_CreateSet( MazzleOptions_CurrentOptions[widgetID].info.parameter.."."..modeString, modeValue)
        MazzleUI:InstantiateEfficiencyMode(true)
    end
    MazzleOptions_SetProc(widgetID, widgetValue)
end

function MazzleOptions_SetProc(widgetID, widgetValue)
    if (MazzleOptions_CurrentOptions[widgetID].info.setProc) then
        MazzleOptions_CurrentOptions[widgetID].info.setProc(widgetID, widgetValue)
    end
end

function MazzleOptions_LayoutWidgets(topicNum)
    for i=1, MazzleOptions_ContentData.NumTopics, 1 do
        getglobal("MazzleOptionsTopic"..i):UnlockHighlight();
    end
    getglobal("MazzleOptionsTopic"..topicNum):LockHighlight();
    
    MazzleOptions_ClearWidgets()
    MazzleOptions_CurrentOptions = {}
    MazzleOptions_EnabledStatus = true
    local lastWidget, currentJustification, xadjust, yadjust
    
    for i=1, table.getn(MazzleOptions_ContentData.Contents[topicNum]), 1 do
        MazzleOptions_CurrentOptions[i] = {}
        MazzleOptions_CurrentOptions[i].info = MazzleOptions_ContentData.Contents[topicNum][i]
        xadjust = MazzleOptions_CurrentOptions[i].info.xadjust or 0
        yadjust = MazzleOptions_CurrentOptions[i].info.yadjust or 0
        if (i == 1) then
            currentJustification = "top"
        else
            currentJustification = MazzleOptions_CurrentOptions[i].info.justification or "middle"
        end
        if (lastWidget) then lastFrame = lastWidget.frame else lastFrame = "MazzleOptions_Content_ScrollChildFrame" end
        if (MazzleOptions_CurrentOptions[i].info.type == "YesNo") then
            lastWidget = MazzleOptions_YesNo_Create(MazzleOptions_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (MazzleOptions_CurrentOptions[i].info.type == "Menu") then
            lastWidget = MazzleOptions_Menu_Create(MazzleOptions_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (MazzleOptions_CurrentOptions[i].info.type == "AddOnHeader") then
            lastWidget = MazzleOptions_AddOnHeader_Create(MazzleOptions_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (MazzleOptions_CurrentOptions[i].info.type == "Button") then
            lastWidget = MazzleOptions_Button_Create(MazzleOptions_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (MazzleOptions_CurrentOptions[i].info.type == "CheckButton") then
            lastWidget = MazzleOptions_CheckButton_Create(MazzleOptions_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (MazzleOptions_CurrentOptions[i].info.type == "Slider") then
            lastWidget = MazzleOptions_Slider_Create(MazzleOptions_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (MazzleOptions_CurrentOptions[i].info.type == "Textbox") then
            lastWidget = MazzleOptions_Textbox_Create(MazzleOptions_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (MazzleOptions_CurrentOptions[i].info.type == "Infobox") then
            lastWidget = MazzleOptions_Infobox_Create(MazzleOptions_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (MazzleOptions_CurrentOptions[i].info.type == "Notebox") then
            lastWidget = MazzleOptions_Notebox_Create(MazzleOptions_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (MazzleOptions_CurrentOptions[i].info.type == "TitleButton") then
            lastWidget = MazzleOptions_TitleButton_Create(MazzleOptions_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (MazzleOptions_CurrentOptions[i].info.type == "PerformanceEntry") then
            lastWidget = MazzleOptions_PerformanceEntry_Create(MazzleOptions_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        end
        MazzleOptions_CurrentOptions[i].widget = lastWidget
    end
    MazzleOptions_Contents_ScrollFrame:UpdateScrollChildRect()
end

