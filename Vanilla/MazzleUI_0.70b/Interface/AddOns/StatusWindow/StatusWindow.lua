--
-- Status Window 
-- World of Warcraft UI AddOn to display time, frame rate, latency, health regen rate, and mana regen rate
-- 2005 Satrina@Stormrage
--

-- Saved Variables
SWVar = {}
--

StatusWindow = { version = 11100.01, modules = {}, events = {}, debug = 0}

function StatusWindow.SlashCommands(msg)
	StatusWindowOptions:Open()
end

function StatusWindow:OnFrameLoad()
	SLASH_STATUSWINDOW1 = "/statuswindow"
	SlashCmdList["STATUSWINDOW"] = StatusWindow.SlashCommands
	this:RegisterEvent("VARIABLES_LOADED")
	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("PLAYER_LEAVING_WORLD")
	this:RegisterEvent("PLAYER_LOGOUT");
end

function StatusWindow:OnFrameEvent(event)
	if (event == "VARIABLES_LOADED") then
		StatusWindow:Initialise()		
		return
	end

	if StatusWindow.events[event] then
		for index,module in StatusWindow.events[event] do
			StatusWindow:UpdateModulePanes(module, event)
		end
	end
	
	if (event == "PLAYER_ENTERING_WORLD") then
		StatusWindow:RegisterEvents()
		StatusWindow:InitWindows()
		return
	end

	if (event == "PLAYER_LEAVING_WORLD") then
		StatusWindow:UnregisterEvents()
		return
	end
	
	if (event == "PLAYER_LOGOUT") then
		for i=1,10 do
			SWVar[StatusWindow.player].windows[i].count = nil
			SWVar[StatusWindow.player].windows[i].height = nil
		end
	end
end

function StatusWindow:RegisterEvents()
	local index,event
	for event,data in StatusWindow.events do
		StatusWindowFrame:RegisterEvent(event)
	end
end

function StatusWindow:UnregisterEvents()
	local index,event
	for event,data in StatusWindow.events do
		if not (event == "PLAYER_ENTERING_WORLD") and not (event == "PLAYER_LEAVING_WORLD") then
			StatusWindowFrame:UnregisterEvent(event)
		end
	end
end

function StatusWindow:OnFrameUpdate(elapsed)
	if (StatusWindow.elapsed >= 0.5) then
		StatusWindow.timer = StatusWindow.timer + 0.5
		if (StatusWindow.timer > 3600) then
			StatusWindow.timer = 0
		end
		StatusWindow.elapsed = 0
		for name,module in StatusWindow.modules do
			if module.updateFrequency and (math.mod(StatusWindow.timer*10, module.updateFrequency*10) == 0) then
				StatusWindow:UpdateModulePanes(module)
			end
		end
	else
		StatusWindow.elapsed = StatusWindow.elapsed + elapsed
	end

	if StatusWindow.moving then
		local slot
		StatusWindow.target = nil

		for i=1,2 do
			for j=1,10 do
				slot = getglobal("StatusWindowButtons"..i.."Button"..j)
				if MouseIsOver(slot) then
					slot:LockHighlight()
					StatusWindow.target = slot
				else
					slot:UnlockHighlight()
				end
			end
		end

		if not StatusWindow.target then
			for j=1,10 do
				slot = getglobal("StatusWindowButtonGroupButton"..j)
				if MouseIsOver(slot) then
					slot:LockHighlight()
					StatusWindow.target = slot
				else
					slot:UnlockHighlight()
				end
			end
		end
	end
end

--
-- Initialisation functions
--
function StatusWindow:Initialise()
	StatusWindow.player = UnitName("player")
	StatusWindow.elapsed = 1
	StatusWindow.optionsElapsed = 1
	StatusWindow.timer = 0
	StatusWindow.count = 0
	
	if not SWVar["version"] then
		SWVar["version"] = StatusWindow.version
	end

	if not SWVar[StatusWindow.player] then
			StatusWindow:NewPlayer()
	end
	
	if (SWVar["version"] < StatusWindow.version) then
		if (SWVar["version"] < 1900.00) then
			UIErrorsFrame:AddMessage(StatusWindow.strings.RESET, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)	
			SWVar = {}
			StatusWindow:NewPlayer()
		end
		if (SWVar["version"] < 11000.01) then
			SWVar[StatusWindow.player].addonmenu = 1
		end
		SWVar["version"] = StatusWindow.version
	end
	
	if not SWVar[StatusWindow.player] then
		StatusWindow:NewPlayer()
	end

	for index,pane in SWVar[StatusWindow.player].panes do
		if (pane == "None") then
			SWVar[StatusWindow.player].panes[index] = "Right Click"
		end
	end

--	StatusWindow:InitModules()
	StatusWindow:InitPanes()
	StatusWindowOptions:Initialise()
end

function StatusWindow:NewPlayer()
	UIErrorsFrame:AddMessage(StatusWindow.strings.NEWPLAYER..StatusWindow.player, 1.0, 1.0, 1.0, 1.0, UIERRORS_HOLD_TIME)	

	if not SWVar["version"] then
		SWVar["version"] = StatusWindow.version
	end

	SWVar[StatusWindow.player] = 
	{
		panes = { "Time", "Latency", "FPS", "Durability", "Health Regen", "Mana Regen", "Right Click", "Right Click", "Right Click", "Right Click",
		"Right Click", "Right Click", "Right Click", "Right Click", "Right Click", "Right Click", "Right Click", "Right Click", "Right Click", "Right Click" },
		windows = {
			[0] =	{ panes = { 0,0,0,0,0,0,7,8,9,10,11,12,13,14,15,16,17,18,19,20 } },
						{ panes = { 1,2,3,4,5,6,0,0,0,0 }, width = 75, background = 1 },
						{ panes = { 0,0,0,0,0,0,0,0,0,0 }, width = 75, background = 1 },
						{ panes = { 0,0,0,0,0,0,0,0,0,0 }, width = 75, background = 1 },
						{ panes = { 0,0,0,0,0,0,0,0,0,0 }, width = 75, background = 1 },
						{ panes = { 0,0,0,0,0,0,0,0,0,0 }, width = 75, background = 1 },
						{ panes = { 0,0,0,0,0,0,0,0,0,0 }, width = 75, background = 1 },
						{ panes = { 0,0,0,0,0,0,0,0,0,0 }, width = 75, background = 1 },
						{ panes = { 0,0,0,0,0,0,0,0,0,0 }, width = 75, background = 1 },
						{ panes = { 0,0,0,0,0,0,0,0,0,0 }, width = 75, background = 1 },
						{ panes = { 0,0,0,0,0,0,0,0,0,0 }, width = 75, background = 1 },
		},
		addonmenu = 1,
	}
end

--
-- Module functions
--
function StatusWindow:RegisterModule(module)
	if (StatusWindow.debug > 2) then
		ChatFrame1:AddMessage("Registering module "..module.name)
	end
	StatusWindow.modules[module.name] = module
	module.panes = {}
end

--[[
function StatusWindow:InitModules()
	for name,module in StatusWindow.modules do
		if module.Init then
			if (StatusWindow.debug > 2) then
				ChatFrame1:AddMessage("Initialising module "..module.name)
			end
			module:Init()
		end
	end
end
]]--

function StatusWindow:HookModuleEvent(module, event)
	if not StatusWindow.events[event] then
		StatusWindowFrame:RegisterEvent(event)
		StatusWindow.events[event] = {}
	end
	table.insert(StatusWindow.events[event], module)
	if (StatusWindow.debug > 1) then
		ChatFrame1:AddMessage("Hooked "..event.." for module "..module.name)
	end
end

function StatusWindow:UnhookModuleEvent(name, event)
	for index,module in StatusWindow.events[event] do
		if (name == module.name) then
			table.remove(StatusWindow.events[event], index)
			if (StatusWindow.debug > 1) then
				ChatFrame1:AddMessage("Unhooked "..event.." for module "..name)
			end
			return
		end
	end
end

function StatusWindow:ModuleAttachPane(name, paneID)
	local module = StatusWindow.modules[name]
	local paneInfo = StatusWindow.panes[paneID]
	if (StatusWindow.debug > 0) then
		ChatFrame1:AddMessage("Attach pane "..paneID.." to module "..name)
	end
	if (paneInfo.module ~= name) then	
		StatusWindow:ModuleRemoveWindow(paneID)
	end
	table.insert(module.panes, paneInfo.pane)
	paneInfo.module = name
	if module.Init and not module.initialised then
		if (StatusWindow.debug > 2) then
			ChatFrame1:AddMessage("Initialising module "..module.name)
		end
		module:Init()
	end
	StatusWindow:UpdateModulePanes(module)
end

function StatusWindow:ModuleRemoveWindow(paneID)
	local paneInfo = StatusWindow.panes[paneID]
	local module = StatusWindow.modules[paneInfo.module]
	if (StatusWindow.debug > 0) then
		ChatFrame1:AddMessage("Remove pane "..paneID.." from module "..module.name)
	end
	for index,pane in module.panes do
		if (pane:GetID() == paneID) then
			table.remove(module.panes, index)
			paneInfo.module = nil
		end
	end
end

function StatusWindow:UpdateModulePanes(module, event)
	local m = module
	if type(module) == "string" then
		m = StatusWindow.modules[module]
	end		
	local str = m:Update(event or m.updateEvent)
	for index,pane in m.panes do
		pane.text:SetText(str)
	end
end
--
-- Pane functions
--
function StatusWindow:InitPanes()
	StatusWindow.panes = {}
	local pane, module
	for i=1,20 do
		p = { 
			pane = getglobal("StatusWindowPane"..i), 
			button = getglobal("StatusWindowButton"..i), 
			module = SWVar[StatusWindow.player].panes[i]
		}
		if (module == "None") then
			p.module = "Right Click"
		end
		StatusWindow.panes[i] = p
		StatusWindow:ModuleAttachPane(SWVar[StatusWindow.player].panes[i], i)
	end
end

--
-- Window functions
--
function StatusWindow:InitWindows()
	local pane
	for i=1,20 do
		pane = StatusWindow.panes[i].pane
		pane:SetParent("StatusWindowFrame")
		pane:Hide()
	end

	for i=1,10 do
		StatusWindow:InitWindow(i)
	end
end
	
function StatusWindow:InitWindow(windowID)
	StatusWindow:AssembleWindow(windowID)
	StatusWindow:WindowDressing(windowID)
	StatusWindow:ScaleWindow(windowID)
end

function StatusWindow:AssembleWindow(windowID)
	local window = SWVar[StatusWindow.player].windows[windowID]
	local frame = getglobal("StatusWindowWindow"..windowID.."Content")
	local pane
	local lastPane = frame:GetName()

	window.count = 0
	frame:Show()
	for index,paneNum in window.panes do
		if (paneNum > 0) then
			window.count = window.count + 1
			pane = StatusWindow.panes[paneNum].pane
			pane:Show()
			pane:SetParent(frame:GetName())
			pane:ClearAllPoints()
			if (lastPane == frame:GetName()) then
				pane:SetPoint("TOPLEFT", frame:GetName(), "TOPLEFT")
			elseif window.horizontal then
				pane:SetPoint("LEFT", lastPane, "RIGHT")
			else
				pane:SetPoint("TOP", lastPane, "BOTTOM")
			end
			lastPane = pane:GetName()
		end
	end
	if (window.count == 0) then
		frame:Hide()
		return
	end
end

function StatusWindow:WindowDressing(windowID)
	local window = SWVar[StatusWindow.player].windows[windowID]
	local frame = getglobal("StatusWindowWindow"..windowID.."Content")

	if (window.count == 0) then
		return
	end
	
	local bgFile = "Interface/DialogFrame/UI-DialogBox-Background"
	if not window.background then
		bgFile = ""
	end

	local height, width
	if SWVar[StatusWindow.player].windows[windowID].horizontal then
		width = SWVar[StatusWindow.player].windows[windowID].width * SWVar[StatusWindow.player].windows[windowID].count
		height = 12
	else
		width = SWVar[StatusWindow.player].windows[windowID].width
		height = SWVar[StatusWindow.player].windows[windowID].count * 12
	end

	local edgeFile, insets, xOff, yOff
	if window.border then
		xOff = 5
		yOff = -6
		height = height + 10
		width = width + 10
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border"
		insets = { left = 5, right = 5, top = 5, bottom = 5 }
	else
		xOff = 0
		yOff = 0
		edgeFile = ""
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	end

	frame:SetHeight(height)
	frame:SetWidth(width)
	local anchored = nil
	for index,paneID in window.panes do
		if (paneID > 0) then
			StatusWindow.panes[paneID].pane:SetWidth(window.width)
			StatusWindow.panes[paneID].pane.text:SetWidth(window.width)
			if not anchored then
				StatusWindow.panes[paneID].pane:SetPoint("TOPLEFT", frame:GetName(), "TOPLEFT", xOff, yOff)
				anchored = 1
			end
		end
	end
	frame:SetBackdrop({
		bgFile = bgFile, 
		edgeFile = edgeFile, 
		tile = true, 
		tileSize = 16, 
		edgeSize = 16, 
		insets = insets
	})
end

function StatusWindow:ScaleWindow(windowID)
	local frame = getglobal("StatusWindowWindow"..windowID)
	local window = getglobal("StatusWindowWindow"..windowID.."Content")

	local scale = SWVar[StatusWindow.player].windows[windowID].scale or 1.0
	window:SetScale(scale)
	frame:SetWidth(window:GetWidth()*scale);
	frame:SetHeight(window:GetHeight()*scale);
end