local MINOR_VERSION = tonumber(("$Revision: 74823 $"):match("%d+"))
if MINOR_VERSION > Omen.MINOR_VERSION then Omen.MINOR_VERSION = MINOR_VERSION end

local base = {bars = {}, registeredGUIDs = {}}
local math_floor = _G.math.floor
local math_min = _G.math.min
local math_max = _G.math.max
local maxHeight = 0

function base:OnInitialize()
	self.icon = "Interface\\Icons\\INV_Misc_QuestionMark"
	self.numColumns = 1
	self.columns = self.columns or {{}}
end

function base:OnEnable()
	if self.button then
		self.button:LockHighlight()
		self.button.enabled = true
		self.button:GetNormalTexture():SetDesaturated(false)
	end
	if Omen.activeModule then
		Omen.activeModule:Disable()
	end
	Omen:SetOption("Modules.LastActive", self:GetName())
	Omen.activeModule = self
	self:ResetBars()
end

function base:OnDisable()
	if self.button then
		self.button:UnlockHighlight()
		self.button.enabled = false
		self.button:GetNormalTexture():SetDesaturated(true)
	end
	Omen.activeModule = nil
	self:ReleaseBars()
end

function base:ReleaseBars()
	self:ClearBars()
	local bars = self.bars
	for i = 1, #bars do
		local v = tremove(bars)
		self.registeredGUIDs[v.guid] = nil
		v:Release()
	end
end

function base:ReleaseBar(bar)
	for k, v in ipairs(self.bars) do
		if v == bar then
			tremove(self.bars, k)
			break
		end
	end
	self.registeredGUIDs[bar.guid] = nil
	bar:Release()
	return nil
end

function base:RegisterConfigDefaults(opt)
	Omen:RegisterConfigDefaults(self:GetName(), opt)
end

function base:RegisterOptions(opt)
	Omen:RegisterOptions(self:GetName(), opt)
end

function base:AcquireBar(guid, noCreate)
	local bar = self.registeredGUIDs[guid]
	local new = false
	if not bar and not noCreate then
		bar = self:GetBar(guid)
		bar.labelPositionsUpdatedAfterResize = false
		bar.isTitle = false
		bar:SetColor(1,1,1,1)
		self.registeredGUIDs[guid] = bar
		tinsert(self.bars, bar)
		new = true
	end
	return bar, new
end

function base:GetOption(k)
	return Omen.Options[self:GetName() .. "." .. k]
end

function base:SetOption(k, v)
	Omen.Options[self:GetName() .. "." .. k] = v
end

function base:Test()
	Omen:Print("No test implemented for", self.name)
end

function base:Super(t)
	local sup = getmetatable(self)["__index"]
	return sup[t](sup == base and self or sup)
end

function base:SetTitle(t)
	Omen:SetTitle(t)
end

function base:GetBar(g)
	return Omen:GetBar(g)
end

function base:UpdateLayout()
	error("Please implement UpdateLayout in " .. tostring(self.name))
end

function base:Height()
	return (Omen.BarList:GetTop() or 0) - (Omen.BarList:GetBottom() or 0)
end

function base:Width()
	return Omen.BarList:GetRight() - Omen.BarList:GetLeft()
end

function base:Hint()
	return self.name
end

function base:ClearBars()
	Omen:ClearBars()
	self:ResetBars()
	if Omen.Options["Skin.Bars.Autocollapse"] then
		Omen.Anchor:SetHeight(Omen.Title:GetHeight() + Omen.ModuleList:GetHeight() + Omen.Options["Skin.Bars.Height"] + Omen.Options["Skin.Bars.Spacing"] + 11)
		self:MaybeAutoHide()
	end
end

function base:ResetBars(column)
	column = column or 1
	self.columns[column] = self.columns[column] or {}
	self.columns[column].layoutInit = false
	self.columns[column].barCount = 0
	self.columns[column].maxHeight = 0
	if Omen.Options["Skin.Bars.Autocollapse"] then
		maxHeight = 0
		for i = 1, self.numColumns do
			if self.columns[i] then
				maxHeight = math_max(self.columns[i].maxHeight, maxHeight)
			end
		end
		if maxHeight == 0 then
			Omen.Anchor:SetHeight(Omen.Title:GetHeight() + Omen.ModuleList:GetHeight() + Omen.Options["Skin.Bars.Height"] + Omen.Options["Skin.Bars.Spacing"] + 11)
		else
			Omen.Anchor:SetHeight(Omen.Title:GetHeight() + Omen.ModuleList:GetHeight() + maxHeight + 4)
		end
	end
	self:MaybeAutoHide()
end

function base:SetNumColumns(columns)
	local old = self.numColumns
	self.numColumns = max(1, columns)
	if self.numColumns ~= old then
		self:ReleaseBars()
		for i = 1, self.numColumns do
			self:ResetBars(i)
		end
	end
end

function base:InitColumn(column)
	local columnList = self.columns
	columnList[column] = columnList[column] or {}
	local columnProps = columnList[column]
	
	if not columnProps.layoutInit then
		self.barHeight = Omen.Options["Skin.Bars.Height"]
		self.spacing = Omen.Options["Skin.Bars.Spacing"]
		
		columnProps.layoutInit = true		
		columnProps.offset = 7
		columnProps.totalHeight = self:Height() - columnProps.offset
		columnProps.usedHeight = 0
		columnProps.anchor = Omen.BarList
		columnProps.anchorPoint = "TOP"
		columnProps.barCount = 0
		columnProps.maxHeight = 0
	end
	return columnProps
end

function base:SetColumnSpacing(v)
	self.columnSpacing = v
end

function base:AddBar(bar, column)
	column = column or 1
	local columnProps = self:InitColumn(column)
	local columnSpacing = self.columnSpacing or 0
	
	if self:BarSpaceLeft(column) then
		columnProps.barCount = columnProps.barCount + 1
		local barList = Omen.BarList
		local tWidth = barList:GetWidth() - 14 - (columnSpacing * (self.numColumns-1))
		local bWidth = tWidth / self.numColumns
		local left = (column - 1) * bWidth + 7 + (columnSpacing * (column - 1))
		-- Omen:Print("Setting bar width to", bWidth, "left to", left, "column", column)
		columnProps.usedHeight = columnProps.usedHeight + columnProps.offset
		--bar.frame:ClearAllPoints()
		bar.frame:SetPoint("TOPLEFT", barList, "TOPLEFT", left, columnProps.usedHeight * -1)
		bar.frame:SetWidth(bWidth)
		if not bar.labelPositionsUpdatedAfterResize then
			bar:UpdateLabelPositions()
			bar.labelPositionsUpdatedAfterResize = true
		end
		
		columnProps.usedHeight = columnProps.usedHeight + self.barHeight + self.spacing
		if Omen.Options["Skin.Bars.Autocollapse"] then
			columnProps.maxHeight = math_max(columnProps.maxHeight, columnProps.usedHeight)
			maxHeight = math_max(columnProps.maxHeight, maxHeight)
			Omen.Anchor:SetHeight(Omen.Title:GetHeight() + Omen.ModuleList:GetHeight() + maxHeight + 4)
			self:MaybeAutoHide()
		end
		bar.frame:Show()
		columnProps.offset = self.spacing
		return true
	else
		return false
	end
end

function base:BarSpaceLeft(column)
	column = column or 1
	local columnProps = self:InitColumn(column)
	if Omen.Options["Skin.Bars.Autocollapse"] then
		local maxBars = Omen.Options["Skin.Bars.NumBars"]
		return columnProps.barCount <= maxBars, maxBars - columnProps.barCount
	end
	local spaceLeft = math_floor((columnProps.totalHeight - (columnProps.barCount == 0 and columnProps.offset or columnProps.usedHeight)) / (self.barHeight + self.spacing))
	return spaceLeft > 0, spaceLeft
end

function base:MaybeAutoHide()
	local show = true
	local frame = Omen.BarList
	if Omen.Options["Skin.Bars.Autocollapse"] and Omen.Options["Skin.Bars.Autohide"] then
		show = false
		local columnList = self.columns
		for i = 1, self.numColumns do
			local column = columnList[i]
			if column and column.barCount and column.barCount > 0 then
				show = true
			end
		end
		if Omen.Options["Skin.Bars.AutohideAll"] then
			frame = Omen.Anchor
		end
	end
	if show then
		frame:Show()
	else
		Omen.Anchor:SetHeight(Omen.Title:GetHeight() + Omen.ModuleList:GetHeight())
		--[[ Don't hide anything if we're resizing. Hiding either Omen.BarList or
		Omen.Anchor will cause Omen.Grip to hide as well. This will cause the
		OnMouseUp handler never to get called and the user can't stop resizing it.
		This is only an issue if "Skin.Bars.Autohide/Autocollapse/AutohideAll"
		options are on. ]]
		if not Omen.Anchor.IsMovingOrSizing then
			frame:Hide()
		end
	end
end
	

Omen.ModuleBase = base
