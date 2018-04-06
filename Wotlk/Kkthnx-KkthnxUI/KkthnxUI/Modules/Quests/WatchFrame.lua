local K, C, L, _ = select(2, ...):unpack()
if IsAddOnLoaded("QuestHelper") then return end

local UIWatchFrame = CreateFrame("Frame", "UIWatchFrame", UIParent)
UIWatchFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- Compatible with Blizzard option
local wideFrame = GetCVar("watchFrameWidth")

-- Create our moving area
local WatchFrameAnchor = CreateFrame("Frame", "WatchFrameAnchor", UIParent)
WatchFrameAnchor:SetHeight(150)

-- Set default position
WatchFrameAnchor:SetPoint(unpack(C.Position.Quest))

-- Width of the watchframe according to our Blizzard cVar
if wideFrame == "1" then
	UIWatchFrame:SetWidth(350)
	WatchFrameAnchor:SetWidth(350)
else
	UIWatchFrame:SetWidth(250)
	WatchFrameAnchor:SetWidth(250)
end

UIWatchFrame:SetParent(WatchFrameAnchor)
UIWatchFrame:SetHeight(K.ScreenHeight / 1.6)
UIWatchFrame:ClearAllPoints()
UIWatchFrame:SetPoint("TOP", WatchFrameAnchor, "TOP", 0, 0)

local function init()
	UIWatchFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
	UIWatchFrame:RegisterEvent("CVAR_UPDATE")
	UIWatchFrame:SetScript("OnEvent", function(_, _, cvar, value)
		if cvar == "WATCH_FRAME_WIDTH_TEXT" then
			if not WatchFrame.userCollapsed then
				if value == "1" then
					UIWatchFrame:SetWidth(350)
					WatchFrameAnchor:SetWidth(350)
				else
					UIWatchFrame:SetWidth(250)
					WatchFrameAnchor:SetWidth(250)
				end
			end
			wideFrame = value
		end
	end)
end

local function setup()
	WatchFrame:SetParent(UIWatchFrame)
	WatchFrame:SetFrameStrata("MEDIUM")
	WatchFrame:SetFrameLevel(3)
	WatchFrame:SetClampedToScreen(false)
	WatchFrame:ClearAllPoints()
	WatchFrame.ClearAllPoints = function() end
	WatchFrame:SetPoint("TOPLEFT", 25, 2)
	WatchFrame:SetPoint("BOTTOMRIGHT", 0, 0)
	WatchFrame.SetPoint = K.Noop
end

-- Execute setup after we enter world
local f = CreateFrame("Frame")
f:Hide()
f.elapsed = 0
f:SetScript("OnUpdate", function(self, elapsed)
	f.elapsed = f.elapsed + elapsed
	if f.elapsed > 0.5 then
		setup()
		f:Hide()
	end
end)
UIWatchFrame:SetScript("OnEvent", function()
	if not IsAddOnLoaded("Who Framed Watcher Wabbit") or not IsAddOnLoaded("Fux") then
		init()
		f:Show()
	end
end)

-- Difficulty color for WatchFrame lines
-- Remove those shitty dashes too
hooksecurefunc("WatchFrame_Update", function()
	local nextline = 1
	local numQuestWatches = GetNumQuestWatches()

	for i = nextline, 50 do
	local line = _G["WatchFrameLine"..i]
		if line then
			line.dash:Hide()
		end
	end

	for i = 1, numQuestWatches do
		local questIndex = GetQuestIndexForWatch(i)
		if questIndex then
			local title, level = GetQuestLogTitle(questIndex)
			local col = GetQuestDifficultyColor(level)

			for j = 1, #WATCHFRAME_QUESTLINES do
				if WATCHFRAME_QUESTLINES[j].text:GetText() == title then
					WATCHFRAME_QUESTLINES[j].text:SetTextColor(col.r, col.g, col.b)
					WATCHFRAME_QUESTLINES[j].col = col
				end
			end
			for k = 1, #WATCHFRAME_ACHIEVEMENTLINES do
				WATCHFRAME_ACHIEVEMENTLINES[k].col = nil
			end
		end
	end
end)

hooksecurefunc("WatchFrameLinkButtonTemplate_Highlight", function(self, onEnter)
	i = self.startLine
	if not (self.lines[i] and self.lines[i].col) then return end
	if onEnter then
		self.lines[i].text:SetTextColor(1, 0.8, 0)
	else
		self.lines[i].text:SetTextColor(self.lines[i].col.r, self.lines[i].col.g, self.lines[i].col.b)
	end
end)