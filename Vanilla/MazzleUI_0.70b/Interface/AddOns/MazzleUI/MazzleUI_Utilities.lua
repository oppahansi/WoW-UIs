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

function MazzleUI_GetValue(variableName)
	if ( type(variableName) ~= "string" ) then return; end

	local sstart = 2;
	local value;

	local match = strfind(variableName, '.', sstart, true);
	if ( match ) then
		value = getglobal(strsub(variableName, 0, match-1));
	else
		return getglobal(variableName);
	end
		
	while true do
		if (type(value) ~= "table") then
			return;
		end
        sstart = match + 1;
		match = strfind(variableName, '.', sstart, true);

		if ( match ) then
			value = value[strsub(variableName, sstart, match-1)];
		else
			return value[strsub(variableName, sstart)];
		end
   	end
end

function MazzleUI_SetValue( variableName, newValue ) 

	if ( type(variableName) ~= "string" ) then return; end

	local sstart = 2;
	local value;

	local match = strfind(variableName, '.', sstart, true);
	if ( match ) then
		value = getglobal(strsub(variableName, 0, match-1));
	else
		setglobal(variableName, newValue);
		return true;
	end
		
	while true do
		if (type(value) ~= "table") then
			return false;
		end
        
        sstart = match + 1;
		match = strfind(variableName, '.', sstart, true);
		if ( match ) then
			value = value[strsub(variableName, sstart, match-1)];
		else
			value[strsub(variableName, sstart)] = newValue;
			return true;
		end
   	end
	return false;
end

function MazzleUI_CreateSet( variableName, newValue)
    MazzleUI_CreatePath(variableName)
    MazzleUI_SetValue( variableName, newValue ) 
end

function MazzleUI_CreatePath( variableName ) 

    if ( type(variableName) ~= "string" ) then
        return;
    end
    
    local strfind = strfind; 
    local strsub = strsub;
    local _G = getfenv(0)
    
    local sstart = 2;
    local value;
    local newValue
    
    local match = strfind(variableName, '.', sstart, true);
    if ( match ) then
        value = getglobal(strsub(variableName, 0, match-1));
        if (type(value) == "table") then
        elseif (type(value) == "nil") then
            _G[strsub(variableName, 0, match-1)] = {}
        else
            return false;
        end
    else
        return true
    end
    
    while true do
        sstart = match + 1;
        match = strfind(variableName, '.', sstart, true);
        
        if ( match ) then
            value = MazzleUI_GetValue(strsub(variableName, 0, match-1));
        else
            return true;
        end
        
        if (type(value) == "table") then
        elseif (type(value) == "nil") then
            newValue = MazzleUI_GetValue(strsub(variableName, 0, sstart-2))
            newValue[strsub(variableName, sstart, match-1)] = MazzleUI_MakeNestedTable(strsub(variableName, match+1))
            return true
        else
            return false;
        end
    end
end

function MazzleUI_MakeNestedTable( variableName ) 

    local returnTable = {}
    local match = strfind(variableName, '.', 2, true);
    if ( match ) then
        local subTable = MazzleUI_MakeNestedTable(strsub(variableName, match+1))
        if (subTable) then
            returnTable[strsub(variableName, 0, match-1)] = subTable
        else
            returnTable[strsub(variableName, 0, match-1)] = {}
        end
        return returnTable
    end
    return returnTable
end

function MazzleUI_IsAddOnEnabled( addonName )
    local returnVal, reason
    _, _, _, returnVal, _, reason, _ = GetAddOnInfo(addonName)
    
    if (returnVal and (reason ~= "NOT_DEMAND_LOADED")) then return true; else return false; end;

end

function MazzleUI_Split(str, pat)
    -- Copied from lua wiki
    local t = {n = 0}
    local fpat = "(.-)"..pat
    local last_end = 1
    local s,e,cap = string.find(str, fpat, 1)
    while s ~= nil do
        if s~=1 or cap~="" then
            table.insert(t,cap)
        end
        last_end = e+1
        s,e,cap = string.find(str, fpat, last_end)
    end
    if last_end<=string.len(str) then
        cap = string.sub(str,last_end)
        table.insert(t,cap)
    end
    return t
end

function MazzleUI_SplitPath(str)
    return Mazz3D_Split(str,'[\\/]+')
end

function MazzleUI:Return1or0(theBoolean)
    if (theBoolean) then return "1"; else return "0"; end;
end

function MazzleUI:DebugPrint(debugStr, forceLog, debugHeader)
    if (not debugHeader) then debugHeader = "MazzleUI"; end;
    if MazzleUI_Settings.debugPrint then 
        ace:print(TEXT("|CFFFF0000"..debugHeader..": |CFF2323FF"..debugStr))
    end
    if (MazzleUI_Settings.debugLogOn or forceLog) then 
        table.insert(MazzleUI_DebugLog, debugStr)
    end
end

function MazzleUI:Audit()
    
    LoadAddOn("MazzleOptions")
    LoadAddOn("Mazzifier")
    
    local numAddOns = GetNumAddOns()
    local theAddOn
    local name, title, notes, enabled, loadable, reason, security
    MazzleUI:DebugPrint("-------------------------\nAuditing global addon list-------------------------", true)
    for i=1, numAddOns, 1 do
        theAddOn, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
        if (not MazzleUI:AddOn_In_List(theAddOn)) then
            MazzleUI:DebugPrint("Need to add to global list: "..theAddOn, true)
        end
    end
    for _,addonInfo in MazzleUI_AddOn_DB do
        name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(addonInfo.addonName)
        if (reason == "MISSING" and (not addonInfo.mazzle)) then
            MazzleUI:DebugPrint("Obsolete addon in global ist: "..addonInfo.addonName, true)
        end
    end
    
    MazzleUI:DebugPrint("-------------------------\nAuditing MazzleOptions-------------------------", true)
    for i=1, numAddOns, 1 do
        theAddOn, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
        if (not MazzleUI:AddOn_In_List2(theAddOn)) then
            MazzleUI:DebugPrint("Need to add options for: "..theAddOn, true)
        end
    end
    for _,addonSectionInfo in MazzleOptions_SettingsInfo.Contents do
        for _,addonInfo in addonSectionInfo do
            if (type(addonInfo)=="table" and addonInfo.requiredAddOn) then
                name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(addonInfo.requiredAddOn)
                if (reason == "MISSING") then
                    MazzleUI:DebugPrint("Need to remove options for: "..addonInfo.requiredAddOn, true)
                end
            end
        end; 
    end;
end

function MazzleUI:AddOn_In_List(theAddon)
    for _,addonInfo in MazzleUI_AddOn_DB do
        if (addonInfo.addonName == theAddon) then
            return true;
        end
    end
    return false;
end

function MazzleUI:AddOn_In_List2(theAddon)
    for _,addonSectionInfo in MazzleOptions_SettingsInfo.Contents do
        for _,addonInfo in addonSectionInfo do
            if ((type(addonInfo)=="table") and (addonInfo.requiredAddOn == theAddon)) then
                return true;
            end
        end; 
    end;
    return false;
end

function MazzleUI:TryXTimes(theFunc, tryNum, param1)
    if (tryNum > 0) then tryNum = tryNum - 1; else return end;
    if (not theFunc(self, param1)) then
        --ace:print("Rescheduling!")
        Timex:AddSchedule("MazzleUI_TryXTimer", 5, nil, nil, MazzleUI.TryXTimes, self, theFunc, tryNum, param1)
    end
end
