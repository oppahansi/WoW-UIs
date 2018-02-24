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

local Mazzifier_WidgetPool = {}
Mazzifier_WidgetPool.YesNoPool = {}
Mazzifier_WidgetPool.CheckButtonPool = {}
Mazzifier_WidgetPool.MenuPool = {}
Mazzifier_WidgetPool.SliderPool = {}
Mazzifier_WidgetPool.ButtonPool = {}
Mazzifier_WidgetPool.TextboxPool = {}
Mazzifier_WidgetPool.PerformancePool = {}

Mazzifier_ScrollPosition = 0

function Mazzifier_SaveScrollPosition()
    Mazzifier_ScrollPosition = Mazzifier_Contents_ScrollFrame:GetVerticalScroll()
end

function Mazzifier_RestoreScrollPosition()
    if  (Mazzifier_ScrollPosition) then
        -- for some reason, scroll bar does not move though contents do.  Setting it on a timer as a quick workaround
        Timex:AddSchedule("Mazzifier_ScrollTimer", 0.05, nil, nil, function() Mazzifier_Contents_ScrollFrame:SetVerticalScroll(Mazzifier_ScrollPosition); end)
    else
        Mazzifier_Contents_ScrollFrame:SetVerticalScroll(0)
    end
end

function Mazzifier_CreateWidget(requestedType, requestedAnchor, requestedParent, anchorType, xadjust, yadjust, widgetID)
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
         newWidgetTemplate = "MazzifierAS_YesNoTemplate"
         newWidgetList = "YesNoPool"
    elseif (requestedType == "CheckButton") then
         newWidgetType = "CheckButton"
         newWidgetTemplate = "MazzifierAS_CheckButtonTemplate"
         newWidgetList = "CheckButtonPool"
         yadjust = yadjust + 12
    elseif (requestedType == "Slider") then
         newWidgetType = "Slider"
         newWidgetTemplate = "MazzifierAS_SliderTemplate"
         newWidgetList = "SliderPool"
    elseif (requestedType == "Menu") then
         newWidgetType = "Frame"
         newWidgetTemplate = "MazzifierAS_ButtonDropDownTemplate"
         newWidgetList = "MenuPool"
    elseif (requestedType == "Textbox") then
         newWidgetType = "Frame"
         newWidgetTemplate = "MazzifierAS_TextBoxTemplate"
         newWidgetList = "TextboxPool"
    elseif (requestedType == "Button") then
         newWidgetType = "Button"
         newWidgetTemplate = "MazzifierAS_ButtonTemplate"
         newWidgetList = "ButtonPool"
    end

    for i=1, table.getn(Mazzifier_WidgetPool[newWidgetList]), 1 do
        if (Mazzifier_WidgetPool[newWidgetList][i].isFree) then
            --ace:print ("--> Found an existing widget to reuse.")
            newWidget = Mazzifier_WidgetPool[newWidgetList][i]
            newWidgetName = Mazzifier_WidgetPool[newWidgetList][i].widgetName
        end
    end
    if (not newWidget) then
        newWidget = {}
        newWidget.widgetName = "Mazzifier_"..requestedType..(table.getn(Mazzifier_WidgetPool[newWidgetList])+1)
        newWidget.frame = CreateFrame(newWidgetType, newWidget.widgetName, requestedParent, newWidgetTemplate);
        table.insert(Mazzifier_WidgetPool[newWidgetList], newWidget)
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
    end
    newWidget.frame:Show()
    newWidget.frame:SetID(widgetID)
    return newWidget
end

function Mazzifier_ClearWidgets()
    local currentWidget
    -- Loop through different widget lists and put them as unused
    for _,poolList in {"YesNoPool", "CheckButtonPool", "SliderPool", "MenuPool", "PerformancePool", "ButtonPool", "TextboxPool"} do
        for i=1, table.getn(Mazzifier_WidgetPool[poolList]), 1 do
            currentWidget = Mazzifier_WidgetPool[poolList][i]
            currentWidget.isFree = true
            currentWidget.frame:SetParent(UIParent)
            currentWidget.frame:ClearAllPoints()
            currentWidget.frame:SetPoint("CENTER", UIParent)
            currentWidget.frame:SetID(0)
            currentWidget.frame:Hide()
        end
    end
end

function Mazzifier_CountWidgets()
    for _,poolList in {"YesNoPool", "CheckButtonPool", "SliderPool", "MenuPool", "PerformancePool", "ButtonPool", "TextboxPool"} do
        ace:print("Number of ", poolList, " widgets: ", table.getn(Mazzifier_WidgetPool[poolList]))
    end
end

	
function Mazzifier_YesNo_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = Mazzifier_CreateWidget("YesNo", lastFrame, Mazzifier_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)
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

function Mazzifier_Menu_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = Mazzifier_CreateWidget("Menu", lastFrame, Mazzifier_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)
    getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.name))
    if (currentWidgetInfo.menuItemsReadProc) then
        Mazzifier_Menu_Initialize(lastWidget.frame, currentWidgetInfo.menuItemsReadProc())
    else
        Mazzifier_Menu_Initialize(lastWidget.frame, currentWidgetInfo.menuItems)
    end
    if (currentWidgetInfo.width) then
        UIDropDownMenu_SetWidth( currentWidgetInfo.width, lastWidget.frame)
    end
    if (Mazzifier_EnabledStatus) then
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

function Mazzifier_Menu_Initialize(theMenu, itemList)
	UIDropDownMenu_Initialize(theMenu, function() Mazzifier_Menu_MakeButtons(theMenu, itemList) end);
	theMenu.tooltip = "";
	UIDropDownMenu_SetWidth(323, theMenu);
	UIDropDownMenu_JustifyText("CENTER", theMenu)
end

function Mazzifier_Menu_MakeButtons(theMenu, itemList)
	local selectedValue = UIDropDownMenu_GetSelectedValue(theMenu);
	local info;
    local valcnt = 0
    for index,value in itemList do
        valcnt = valcnt + 1
    	info = {};
    	info.text = itemList[index];
    	info.func = function() Mazzifier_Menu_SetValue(theMenu) end;
    	info.value = valcnt
    	if ( info.value == selectedValue ) then
    		info.checked = 1;
    	end
    	UIDropDownMenu_AddButton(info);
    end
end

function Mazzifier_Menu_SetValue(theMenu)
	UIDropDownMenu_SetSelectedValue(theMenu, this.value);
    if (Mazzifier_CurrentOptions[theMenu:GetID()].info.parameter) then
        MazzleUI_CreateSet( Mazzifier_CurrentOptions[theMenu:GetID()].info.parameter, this.value)
    end
    Mazzifier_SetProc(theMenu:GetID(), this.value)
end

function Mazzifier_Button_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = Mazzifier_CreateWidget("Button", lastFrame, Mazzifier_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)
    if (currentWidgetInfo.name) then
        lastWidget.frame:SetText(TEXT(currentWidgetInfo.name))
    end
    if (currentWidgetInfo.label) then
        getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.label))
    end
    if (Mazzifier_EnabledStatus) then
        lastWidget.frame:Enable()
    else
        lastWidget.frame:Disable()
    end
    return lastWidget
end

function Mazzifier_Button_SetValue(widgetID)
    Mazzifier_SetProc(widgetID)
end

function Mazzifier_CheckButton_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = Mazzifier_CreateWidget("CheckButton", lastFrame, Mazzifier_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)
    getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.name))
    if (Mazzifier_EnabledStatus) then
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

function Mazzifier_CheckButton_SetValue(widgetID, widgetValue)
    if (Mazzifier_CurrentOptions[widgetID].info.parameter) then
        MazzleUI_CreateSet( Mazzifier_CurrentOptions[widgetID].info.parameter, widgetValue)
    end
    Mazzifier_SetProc(widgetID, widgetValue)
end

function Mazzifier_Slider_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = Mazzifier_CreateWidget("Slider", lastFrame, Mazzifier_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID)

	getglobal(lastWidget.lowName):SetText(TEXT(Mazzifier_Slider_Round(currentWidgetInfo.stepValue,currentWidgetInfo.minValue)))
	getglobal(lastWidget.highName):SetText(TEXT(Mazzifier_Slider_Round(currentWidgetInfo.stepValue,currentWidgetInfo.maxValue)))
	lastWidget.frame:SetMinMaxValues(currentWidgetInfo.minValue, currentWidgetInfo.maxValue);
	lastWidget.frame:SetValueStep(currentWidgetInfo.stepValue);

    if (Mazzifier_EnabledStatus) then
        local paramValue
    	if (currentWidgetInfo.readOnlyParameter) then
            paramValue = MazzleUI_GetValue(currentWidgetInfo.readOnlyParameter) or 0;
        elseif (currentWidgetInfo.readFunc) then
            paramValue = currentWidgetInfo.readFunc();
        elseif (currentWidgetInfo.parameter) then
            paramValue = MazzleUI_GetValue(currentWidgetInfo.parameter) or 0
        end
        getglobal(lastWidget.labelName):SetText(
            currentWidgetInfo.name.." "..Mazzifier_Slider_Round(currentWidgetInfo.stepValue,paramValue)..currentWidgetInfo.units)
        lastWidget.frame:SetValue(paramValue);
        OptionsFrame_EnableSlider(lastWidget.frame);
    else
        getglobal(lastWidget.labelName):SetText(currentWidgetInfo.name)
        OptionsFrame_DisableSlider(lastWidget.frame);
    end
	lastWidget.frame.tooltipText = currentWidgetInfo.tooltip or "";
    return lastWidget
end

function Mazzifier_SliderSet(widgetID, widgetValue)
    widgetValue = Mazzifier_Slider_Format(widgetID, widgetValue)
    MazzleUI_CreateSet( Mazzifier_CurrentOptions[widgetID].info.parameter, tonumber(widgetValue))
    getglobal(Mazzifier_CurrentOptions[widgetID].widget.labelName):SetText(
        Mazzifier_CurrentOptions[widgetID].info.name.." "..widgetValue..Mazzifier_CurrentOptions[widgetID].info.units)
    Mazzifier_SetProc(widgetID, tonumber(widgetValue))
end

function Mazzifier_Slider_Format(widgetID, sliderValue)
    return Mazzifier_Slider_Round(Mazzifier_CurrentOptions[widgetID].info.stepValue, sliderValue)
end

function Mazzifier_Slider_Round(stepValue, sliderValue)
    local formatString = "%i"
    if (stepValue < 1) then
        formatString = "%.2f"
    end
    if (sliderValue == nil) then return 0 else return string.format(formatString, sliderValue) end
end

function Mazzifier_Textbox_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID, textOverride)
    local lastWidget = Mazzifier_CreateWidget("Textbox", lastFrame, Mazzifier_Content_ScrollChildFrame, currentJustification, xadjust, yadjust, widgetID, textOverride)
    
    local theTextString = currentWidgetInfo.text
    if (textOverride) then theTextString = textOverride; end
    
    local textWidget = getglobal(lastWidget.labelName)
    if (Mazzifier_EnabledStatus) then
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
    
    if (not Mazzifier_TextboxBackdrop) then
        Mazzifier_TextboxBackdrop = lastWidget.frame:GetBackdrop()
    else
        lastWidget.frame:SetBackdrop(Mazzifier_TextboxBackdrop) 
        lastWidget.frame:SetBackdropBorderColor(0.4, 0.4, 0.4);
        lastWidget.frame:SetBackdropColor(0.05, 0.05, 0.05);
    end
    return lastWidget
end

    
function Mazzifier_Infobox_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)
    local lastWidget = Mazzifier_Textbox_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, (yadjust+16), widgetID)

    if (Mazzifier_EnabledStatus) then
		getglobal(lastWidget.labelName):SetTextColor(1, 1, 1);
        getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.text))
    else
        getglobal(lastWidget.labelName):SetText(TEXT(currentWidgetInfo.text))
		getglobal(lastWidget.labelName):SetTextColor(0.5, 0.5, 0.5);
    end
    --lastWidget.frame:SetWidth(currentWidgetInfo.width or 500)
    return lastWidget
end

function Mazzifier_Notebox_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust, widgetID)

    local noteText
    if (currentWidgetInfo.notetype  == "warning") then
        noteText = "|CFFFF0000Warning: |r"..currentWidgetInfo.text
    elseif (currentWidgetInfo.notetype  == "example") then
        noteText = "|CFFFF8000Example: |r"..currentWidgetInfo.text
    else
        noteText = "|CFFFF8000Note:  |r"..currentWidgetInfo.text
    end
    currentWidgetInfo.width = "full"
    
    local lastWidget = Mazzifier_Textbox_Create(currentWidgetInfo, lastFrame, currentJustification, xadjust, yadjust , widgetID, noteText)
    if (Mazzifier_EnabledStatus) then
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

function Mazzifier_SetScrollingText(frameName, newText)
    getglobal(frameName.."_ScrollFrame__ScrollChildFrame_Text"):SetText(newText)
    getglobal(frameName.."_ScrollFrame__ScrollChildFrame_Text"):SetHeight(getglobal(frameName.."_ScrollFrame__ScrollChildFrame_Text"):GetHeight())
end

function Mazzifier_SetText(frameName, newText, newTextHeight, newTextWidth)
    getglobal(frameName.."_Text"):SetText(newText)
    getglobal(frameName.."_Text"):SetNonSpaceWrap(true)
    getglobal(frameName):SetHeight(newTextHeight)
    getglobal(frameName):SetWidth(newTextWidth)
    
end

function Mazzifier_SetProc(widgetID, widgetValue)
    if (Mazzifier_CurrentOptions[widgetID].info.setProc) then
        Mazzifier_CurrentOptions[widgetID].info.setProc(widgetID, widgetValue)
    end
end

function Mazzifier_ASLayoutWidgets(topicNum)

    Mazzifier_ClearWidgets()
    Mazzifier_CurrentOptions = {}
    Mazzifier_EnabledStatus = true
    local lastWidget, currentJustification, xadjust, yadjust
    Mazzifier_SetupASInfo()
    for i=1, table.getn(Mazzifier_ASInfo), 1 do
        Mazzifier_CurrentOptions[i] = {}
        Mazzifier_CurrentOptions[i].info = Mazzifier_ASInfo[i]
        xadjust = Mazzifier_CurrentOptions[i].info.xadjust or 0
        yadjust = Mazzifier_CurrentOptions[i].info.yadjust or 0
        if (i == 1) then
            currentJustification = "top"
        else
            currentJustification = Mazzifier_CurrentOptions[i].info.justification or "middle"
        end
        if (lastWidget) then lastFrame = lastWidget.frame else lastFrame = "Mazzifier_Content_ScrollChildFrame" end
        if (Mazzifier_CurrentOptions[i].info.type == "YesNo") then
            lastWidget = Mazzifier_YesNo_Create(Mazzifier_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (Mazzifier_CurrentOptions[i].info.type == "Menu") then
            lastWidget = Mazzifier_Menu_Create(Mazzifier_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (Mazzifier_CurrentOptions[i].info.type == "Button") then
            lastWidget = Mazzifier_Button_Create(Mazzifier_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (Mazzifier_CurrentOptions[i].info.type == "CheckButton") then
            lastWidget = Mazzifier_CheckButton_Create(Mazzifier_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (Mazzifier_CurrentOptions[i].info.type == "Slider") then
            lastWidget = Mazzifier_Slider_Create(Mazzifier_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (Mazzifier_CurrentOptions[i].info.type == "Textbox") then
            lastWidget = Mazzifier_Textbox_Create(Mazzifier_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (Mazzifier_CurrentOptions[i].info.type == "Infobox") then
            lastWidget = Mazzifier_Infobox_Create(Mazzifier_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        elseif (Mazzifier_CurrentOptions[i].info.type == "Notebox") then
            lastWidget = Mazzifier_Notebox_Create(Mazzifier_CurrentOptions[i].info, 
                                                    lastFrame, currentJustification, xadjust, yadjust, i)
        end
        Mazzifier_CurrentOptions[i].widget = lastWidget
        if (Mazzifier_CurrentOptions[i].info.idName) then
            Mazzifier_CurrentOptions[Mazzifier_CurrentOptions[i].info.idName] = i
        end
    end
    Mazzifier_Contents_ScrollFrame:UpdateScrollChildRect()
end

function Mazzifier_AbleParts(whichPart, a, b)
    if (Mazzifier_CurrentOptions) then
        for _,corePart in {"full", "loading", "cpu", "minimum"} do
            if (whichPart ~= corePart) then
                Mazzifier_CurrentOptions[Mazzifier_CurrentOptions[corePart]].widget.frame:SetChecked(nil)
            else
                Mazzifier_CurrentOptions[Mazzifier_CurrentOptions[corePart]].widget.frame:SetChecked(1)
            end
        end
        Mazzifier_CurrentInstallOptions.AddonExtras.corepackage = whichPart
    end
end

function Mazzifier_AbleDM(a, b)
    if (Mazzifier_CurrentOptions) then
        if (b) then
            OptionsFrame_EnableCheckBox(Mazzifier_CurrentOptions[Mazzifier_CurrentOptions["dmRecap"]].widget.frame)
            OptionsFrame_EnableCheckBox(Mazzifier_CurrentOptions[Mazzifier_CurrentOptions["dmDM"]].widget.frame)
            OptionsFrame_EnableCheckBox(Mazzifier_CurrentOptions[Mazzifier_CurrentOptions["dmSWS"]].widget.frame)
        else
            OptionsFrame_DisableCheckBox(Mazzifier_CurrentOptions[Mazzifier_CurrentOptions["dmRecap"]].widget.frame)
            OptionsFrame_DisableCheckBox(Mazzifier_CurrentOptions[Mazzifier_CurrentOptions["dmDM"]].widget.frame)
            OptionsFrame_DisableCheckBox(Mazzifier_CurrentOptions[Mazzifier_CurrentOptions["dmSWS"]].widget.frame)
        end
    end
end

function Mazzifier_AbleAddonSelection(isEnabled)
    if (isEnabled) then
        for _,theButton in Mazzifier_WidgetPool.CheckButtonPool do
            OptionsFrame_EnableCheckBox(theButton.frame)
        end
        for _,theButton in Mazzifier_WidgetPool.YesNoPool do
            OptionsFrame_EnableCheckBox(getglobal(theButton.widgetName.."_CheckButtonYes"))
            OptionsFrame_EnableCheckBox(getglobal(theButton.widgetName.."_CheckButtonNo"))
        end
        Mazzifier_AbleDM(nil,Mazzifier_CurrentInstallOptions.AddonExtras.damageheal)
    else
        for _,theButton in Mazzifier_WidgetPool.CheckButtonPool do
            OptionsFrame_DisableCheckBox(theButton.frame)
        end
        for _,theButton in Mazzifier_WidgetPool.YesNoPool do
            OptionsFrame_DisableCheckBox(getglobal(theButton.widgetName.."_CheckButtonYes"))
            OptionsFrame_DisableCheckBox(getglobal(theButton.widgetName.."_CheckButtonNo"))
        end
    end
end
        
function Mazzifier_SetupASInfo()
    MazzleUI_CreateSet("Mazzifier_CurrentInstallOptions.AddOnSelection", {})
    
    Mazzifier_ASInfo, tempItem = {}, {}

    tempItem = {
        type = "Textbox", 
        text = "Core Add-Ons",
    }
    table.insert(Mazzifier_ASInfo, tempItem)
    
    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Full MazzleUI Install |CFFFF8000(HIGHLY recommended)",
        idName = "full",
        setProc = function(a,b) Mazzifier_AbleParts("full",a,b); end,
        readProc = function() return (MazzleUI_GetValue("Mazzifier_CurrentInstallOptions.AddonExtras.corepackage") == "full"); end,
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Less features, faster loading",
        idName = "loading",
        setProc = function(a,b) Mazzifier_AbleParts("loading",a,b); end,
        readProc = function() return (MazzleUI_GetValue("Mazzifier_CurrentInstallOptions.AddonExtras.corepackage") == "loading"); end,
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Less features, faster processing",
        idName = "cpu",
        setProc = function(a,b) Mazzifier_AbleParts("cpu",a,b); end,
        readProc = function() return (MazzleUI_GetValue("Mazzifier_CurrentInstallOptions.AddonExtras.corepackage") == "cpu"); end,
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Minimal features",
        idName = "minimum",
        setProc = function(a,b) Mazzifier_AbleParts("minimum",a,b); end,
        readProc = function() return (MazzleUI_GetValue("Mazzifier_CurrentInstallOptions.AddonExtras.corepackage") == "minimum"); end,
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "Textbox", 
        text = "Specialty Add-Ons",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to install class-specific add-ons for this character?",
        yesText = "Yes, I would like add-ons installed to help better utilize my class-specific skills.",
        noText = "No thanks.  The core MazzleUI add-ons are all I need.",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.class",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you want to install raiding add-ons for this character?",
        yesText = "Yes, please install the raiding add-ons.",
        noText = "No, I almost never raid.  I'll stick with Blizzard's rudimentary raid interface.",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.raiding",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Does this character lead organized raids?",
        yesText = "Yes, please install the relevant oRA modules for raid leaders.",
        noText = "No, I leave that nonsense to others.",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.raidleader",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Will this character be PvP'ing?",
        yesText = "Umm..duh. Install all the PvP tools MazzleUI has to offer.  I have people to kill.",
        noText = "No, I don't PvP enough to make it worth installing PvP add-ons.",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.pvp",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Does this character use the auction house?",
        yesText = "Of course!  Who doesn't?",
        noText = "No, the market makes me nervous.  I avoid it at all costs.",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.auctions",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "Textbox", 
        text = "Expensive Optional Add-Ons",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you like to see timer bars for what others are casting around you?",
        yesText = "Yes, Natur's Enemy Castbars give me a lot of critical information I need to be ubarr!",
        noText = "OMG, information overload.  Don't install.  I get enough spam from gold farmers.",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.enemycastbar",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Is this character a hard-core gatherer of herbs and/or minerals?",
        yesText = "Yes, my precious resources call for me even as we speak.  Install Gatherer ASAP.",
        noText = "No way, Gatherer is expensive and is not worth it for this character.",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.gatherer",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Do you require one or more of the following damage/healing meters?",
        yesText = "Hells yeah!  I gotsta show these bitches who's the boss!",
        noText = "No, I am well-endowed IRL.",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.damageheal",
        setProc = function(a,b) Mazzifier_AbleDM(a,b); end,
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "CheckButton", xadjust = 15, yadjust = -10,
        name = "Install Recap (non-syncable damage meter with great UI)",
        idName = "dmRecap",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.recap",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Install DamageMeter (syncable damage meter)",
        idName = "dmDM",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.dm",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "CheckButton", yadjust = -3,
        name = "Install SWStats (syncable damage meter)",
        idName = "dmSWS",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.sws",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "Notebox", xadjust = -15, yadjust = 15,
        text = "While a few people may want to install both Recap and one of the syncable damage meters, you should not install both DamageMeters and SWStats.  I recommend you choose the one that the majority of your raid group uses.",
}
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "Notebox", notetype = "warning", yadjust = 20,
        text = "Damage meters require significant processing and can cause some framerate loss in combat situations.",
}
    table.insert(Mazzifier_ASInfo, tempItem)
    
    tempItem = {
        type = "YesNo", yadjust = -10,
        question = "Does your raid group use KLHThreatMeter?",
        yesText = "Yes, it is required.",
        noText = "I have no idea what you are talking about.",
        parameter = "Mazzifier_CurrentInstallOptions.AddonExtras.klh",
    }
    table.insert(Mazzifier_ASInfo, tempItem)

    tempItem = {
        type = "Notebox", notetype = "warning", yadjust = 15,
        text = "Threatmeters can cause significant framerate loss and are useless unless nearly EVERYONE in the raid is using it.  Do not enable unless you know that your raid group uses it.",
}
    table.insert(Mazzifier_ASInfo, tempItem)

--    tempItem = {
--        type = "Textbox", 
--        text = "Resulting Add-On Selection (based on above choices) ",
--    }
--    table.insert(Mazzifier_ASInfo, tempItem)
--
--    for _,theAddOn in MazzleUI_AddOn_DB do
--        if (theAddOn.canToggle) then
--            Mazzifier_CurrentInstallOptions.AddOnSelection[theAddOn.addonName] = false;
--            tempItem = {
--                type = "CheckButton", yadjust = 6,
--                name = theAddOn.addonName,
--                setProc = function(a,b) Mazzifier_AbleAddOn(theAddOn.addonName,a,b); end,
--            }
--            table.insert(Mazzifier_ASInfo, tempItem)
--        end
--    end

end