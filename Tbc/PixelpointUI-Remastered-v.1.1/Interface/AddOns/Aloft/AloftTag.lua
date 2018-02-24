-----------------------------------------------------------------------------

local TagCompiler = AceLibrary("TagCompiler-1.0")

-----------------------------------------------------------------------------

Aloft.TagData = 
{ 
	["!TagError"] = function(x) Aloft:Print(x) end, 
--	["!TagDebug"] = function(x) Aloft:Debug(x) end 
}

-----------------------------------------------------------------------------

for k,v in pairs(TagCompiler.CommonTagData) do
	Aloft.TagData[k] = v
end

-----------------------------------------------------------------------------

Aloft.TagData.HealthBarDeficit = 
{
	events = "Aloft:OnHealthBarValueChanged",
	compileString = function(dataTable, prior) return string.format("%s%s(data.healthBarMaxValue - data.healthBarValue)", prior or "", prior and " and " or "") end,
	guaranteeResult = true,
	numeric = true
}

Aloft.TagData.HealthBarMaxValue = 
{
	events = "Aloft:OnHealthBarValueChanged",
	tableData = "healthBarMaxValue",
	guaranteeResult = true,
	numeric = true
}

Aloft.TagData.HealthBarValue = 
{
	events = "Aloft:OnHealthBarValueChanged",
	tableData = "healthBarValue",
	guaranteeResult = true,
	numeric = true
}

Aloft.TagData.HealthFraction = 
{
	events = "Aloft:OnHealthBarValueChanged",
	compileString = function(dataTable, prior) return string.format("%s%s(data.healthBarValue / data.healthBarMaxValue)", prior or "", prior and " and " or "") end,
	guaranteeResult = true,
	numeric = true
}

Aloft.TagData.IsGroup =
{
	compileString = function(dataTable, prior) return string.format("data.healthBarMaxValue ~= 100%s%s", prior and " and " or "", prior or "") end,
	noGuaranteeChange = true
}

Aloft.TagData.IsNotGroup = 
{
	compileString = function(dataTable, prior) return string.format("data.healthBarMaxValue == 100%s%s", prior and " and " or "", prior or "") end,
	noGuaranteeChange = true
}

Aloft.TagData.IsBoss = { tableData = "isBoss" }

Aloft.TagData.IsFriendly =
{
	compileString = function(dataTable, prior)
						return string.format("(data.type == \"friendlyPlayer\" or data.type == \"friendlyNPC\")%s%s", prior and " and " or "", prior or "")
					end
}

Aloft.TagData.IsFriendlyNPC =
{
	compileString = function(dataTable, prior) return string.format("data.type == \"friendlyNPC\"%s%s", prior and " and " or "", prior or "") end
}

Aloft.TagData.IsFriendlyPlayer =
{
	compileString = function(dataTable, prior) return string.format("data.type == \"friendlyPlayer\"%s%s", prior and " and " or "", prior or "") end
}

Aloft.TagData.IsHostile =
{
	compileString = function(dataTable, prior) return string.format("data.type == \"hostile\"%s%s", prior and " and " or "", prior or "") end
}

Aloft.TagData.IsNeutral =
{
	compileString = function(dataTable, prior) return string.format("data.type == \"neutral\"%s%s", prior and " and " or "", prior or "") end
}

Aloft.TagData.IsMaxHealth =
{
	events = "Aloft:OnHealthBarValueChanged",
	compileString = function(dataTable, prior) return string.format("data.healthBarValue == data.healthBarMaxValue%s%s", prior and " and " or "", prior or "") end
}

Aloft.TagData.Level = { tableData = "level", numeric = true }

Aloft.TagData.Name = { tableData = "name", guaranteeResult = true }

Aloft.TagData.HealthBarColor =
{
	method = function(aloftData, value) return value and ("|cff%02x%02x%02x%s|r"):format(aloftData.healthBarR*255, aloftData.healthBarG*255, aloftData.healthBarB*255, value) end,
	noGuaranteeChange = true
}

Aloft.TagData.OriginalHealthBarColor =
{
	method = function(aloftData, value) return value and ("|cff%02x%02x%02x%s|r"):format(aloftData.originalHealthBarR*255, aloftData.originalHealthBarG*255, aloftData.originalHealthBarB*255, value) end,
	noGuaranteeChange = true
}

Aloft.TagData.DifficultyColor =
{
	method = function(aloftData, value) return value and ("|cff%02x%02x%02x%s|r"):format(aloftData.levelTextR*255, aloftData.levelTextG*255, aloftData.levelTextB*255, value) end,
	noGuaranteeChange = true
}

-----------------------------------------------------------------------------

-- Initialise the compile cache with an empty tag, something which would otherwise need some extra special-cased code
local compileCache =
{
	[""] = { data = { }, events = { }, tag = "", method = function() return "" end },
}

function Aloft:CreateTag(tag)
	local parseTag = tag or ""

	if compileCache[parseTag] then
		return compileCache[parseTag]
	end

	local result = TagCompiler:Compile(tag, self.TagData, "string")
	compileCache[tag] = result
	return result
end

function Aloft:FixTagCasing(tag)
	return TagCompiler:FixCasing(tag:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""), self.TagData, "string")
end

function Aloft:HighlightTagSyntax(tag)
	return TagCompiler:HighlightSyntax(tag, self.TagData, "string")
end

-----------------------------------------------------------------------------
