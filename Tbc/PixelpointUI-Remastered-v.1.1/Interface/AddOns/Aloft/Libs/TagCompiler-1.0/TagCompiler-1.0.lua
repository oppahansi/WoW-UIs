-----------------------------------------------------------------------------

local MAJOR_VERSION = "TagCompiler-1.0"
local MINOR_VERSION = tonumber(("$Revision: 59 $"):match("%d+")) or 0

-- This ensures the code is only executed if the libary doesn't already exist, or is a newer version
if not AceLibrary then error(MAJOR_VERSION .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(MAJOR_VERSION, MINOR_VERSION) then return end

-----------------------------------------------------------------------------
--
-- TextTag			:= { Statement } @
-- RawTag			:= RValue @
-- NumberTag		:= RValue @
--
-- Statement		:= literal | "[" RValue "]"
-- RValue			:= Logical
-- Logical			:= Relation { "&" | "|" } Relation
-- Relation			:= Concat [ ("==" | "~=" | ">" | "<" | "<=" | ">=") Concat ]
-- Concat			:= Expression { ("."  | "..") Expression }
-- Expression		:= Term { ("+" | "-") Term }
-- Factor			:= Chain { ("*" | "/") Chain }
-- Chain			:= Unary { ":" Unary }
-- Unary			:= [ "~" | "-" ] Primary
-- Primary			:= ConstantNumber | ConstantString | Identifier ["(" ParameterList ")"] | "(" RValue ")"
-- ParameterList	:= RValue {, RValue }
--
-----------------------------------------------------------------------------

local TagCompiler = { }

-----------------------------------------------------------------------------
--
-- TagCompiler:Compile(tag, tagData, resultType)
-- tagData is a structure that optionally has:
--  tagname.data
--  tagname.events
--  tagname.overrideEvents
--  tagname.guaranteeResult
--  tagname.noGuaranteeChange
--  tagname.numeric
--  parameterTypes				-- Array of either "raw", "number" or "string"
-- And must have one of:
--  tagname.tableData
--  tagname.string
--  tagname.method				-- will be called with the input parameter, prior result and any parameters
--  tagname.compileString
--
-- For methods or compileStrings that require parameters, it must contain
--  tagname.parameterTypes
--
-- resultType is "string", "number", or "raw"
--
-- the result of CreateTag is a table with
--  data		- a list of data elements required, which is all of the tag's .data lists
--  events		- a list of the events required, which is a list of all tag's .events minus .overrideEvents
--  method		- call with input parameter
--  tag			- the tag used
--
-----------------------------------------------------------------------------

local next, select, type = next, select, type

-----------------------------------------------------------------------------

local dataTablePool = setmetatable({ }, { __mode="k" })

local function new()
    local recycledTable = next(dataTablePool)
    if recycledTable then
        dataTablePool[recycledTable] = nil
        return recycledTable
    else
        return { }
    end
end

local function del(t)
    for k,v in pairs(t) do
        t[k] = nil
    end
    dataTablePool[t] = true
end

-----------------------------------------------------------------------------

TagCompiler.CommonTagData = { }

TagCompiler.CommonTagData.Angle = 
{
	method = function(data, value) return value and value ~= "" and ("<"..value..">") end,
	noGuaranteeChange = true
}

TagCompiler.CommonTagData.Bracket =
{
	method = function(data, value) return value and value ~= "" and ("("..value..")") end,
	noGuaranteeChange = true
}

TagCompiler.CommonTagData.Brace = 
{
	method = function(data, value)	return value and value ~= "" and ("{"..value.."}") end,
	noGuaranteeChange = true
}

TagCompiler.CommonTagData.Color =
{
	method = function(data, value, r, g, b) return value and ("|cff%02x%02x%02x%s|r"):format(r*255, g*255, b*255, value) end,
	noGuaranteeChange = true,
	parameterTypes = { "number", "number", "number" }
}

TagCompiler.CommonTagData.ColorIf = 
{
	method = function(data, value, condition, r, g, b)
				return value and condition and ("|cff%02x%02x%02x%s|r"):format(r*255, g*255, b*255, value) or value
			 end,
	noGuaranteeChange = true,
	parameterTypes = { "raw", "number", "number", "number" }
}

TagCompiler.CommonTagData.Contains = 
{
	method = function(data, value, s, c)
				return value and s:find(c)
			 end,
	parameterTypes = { "string", "string" }
}

TagCompiler.CommonTagData.Decimal1 =
{
	method = function(data, value)
				if type(value) == "number" then
					return ("%.1f"):format(value)
				end
				return value
			 end,
	noGuaranteeChange = true
}

TagCompiler.CommonTagData.Format =
{
	method = function(data, value, format) return value and format:format(value) end,
	noGuaranteeChange = true,
	parameterTypes = { "string" }
}

TagCompiler.CommonTagData.HexColor =
{
	method = function(data, value, colorValue)	return value and ("|cff"..colorValue..value.."|r") end,
	noGuaranteeChange = true,
	parameterTypes = { "string" }
}

TagCompiler.CommonTagData.HexColorIf = 
{
	method = function(data, value, condition, colorValue) return value and condition and ("|cff"..colorValue..value.."|r") or value end,
	noGuaranteeChange = true,
	parameterTypes = { "raw", "string" }
}

TagCompiler.CommonTagData.HideIf =
{
	compileString = function(dataTable, prior, condition)
						return ("not (%s)%s%s"):format(condition, prior and " and " or "", prior or "")
					end,
	parameterTypes = { "raw" }
}

TagCompiler.CommonTagData.HideZero = 
{
	method = function(data, value) return value ~= 0 and value end
}

TagCompiler.CommonTagData.Index =
{
	compileString = function(dataTable, prior, index, ...)
						dataTable.headerCode = "local select = select\n"
						local t = new()
						for i=1,select('#', ...) do
							t[i] = select(i, ...)
						end
						local parameterList = table.concat(t, ",")
						del(t)
						return ("%s%sselect(%s, %s)"):format(prior or "", prior and " and " or "", index, parameterList)
					end,
	parameterTypes = { "number", "raw", "*raw" }
}

TagCompiler.CommonTagData.Integer =
{
	method = function(data, value)
				if type(value) == "number" then
					return ("%d"):format(value)
				end
				return value
			 end,
	noGuaranteeChange = true
}

TagCompiler.CommonTagData.IsNumber =
{
	compileString = function(dataTable, prior, value)
						dataTable.headerCode = "local type = type\n"
						return ("(type(%s) == \"number\")"):format(value)
					end,
	parameterTypes = { "raw" }
}

TagCompiler.CommonTagData.IsString =
{
	compileString = function(dataTable, prior, value)
						dataTable.headerCode = "local type = type\n"
						return ("(type(%s) == \"string\")"):format(value)
					end,
	parameterTypes = { "raw" }
}

TagCompiler.CommonTagData.Lower =
{
	method = function(data, value)
				if type(value) == "string" then
					return value:lower()
				end
				return value
			 end
}

TagCompiler.CommonTagData.Map =
{
	method = function(data, value, v, ...) 
				if not value then return value end
				for i=1,select('#', ...),2 do
					local x = select(i, ...)
					if x == v then return select(i+1, ...) end
				end
				return nil
			 end,
	parameterTypes = { "raw", "raw", "raw", "*raw" }
}

TagCompiler.CommonTagData.Maximum =
{
	method = function(data, value, v, ...) 
				if not value then return value end
				for i=1,select('#', ...) do
					local x = select(i, ...)
					if x > v then v = x end
				end
				return v
			 end,
	parameterTypes = { "number", "number", "*number" }
}

TagCompiler.CommonTagData.Minimum =
{
	method = function(data, value, v, ...) 
				if not value then return value end
				for i=1,select('#', ...) do
					local x = select(i, ...)
					if x < v then v = x end
				end
				return v
			 end,
	parameterTypes = { "number", "number", "*number" }
}

TagCompiler.CommonTagData.Negate =
{
	method = function(data, value)
				if type(value) == "number" then
					return -value
				end
				return value
			 end,
	noGuaranteeChange = true
}

TagCompiler.CommonTagData["Not"] =
{
	compileString = function(dataTable, prior, condition)
						return ("not (%s)%s%s"):format(condition, prior and " and " or "", prior or "")
					end,
	parameterTypes = { "raw" }
}

TagCompiler.CommonTagData.Percent =
{
	method = function(data, value)
				if type(value) == "number" then
					return ("%d%%"):format(value*100)
				end
				return value
			 end,
	noGuaranteeChange = true
}

TagCompiler.CommonTagData.Percent1 =
{
	method = function(data, value)
				if type(value) == "number" then
					return ("%.1f%%"):format(value*100)
				end
				return value
			 end,
	noGuaranteeChange = true
}

TagCompiler.CommonTagData.PlayerName =
{
	compileString = function(dataTable, prior)
						return ("%s%s%q"):format(prior or "", prior and " and " or "", UnitName("player"))
					end,
	guaranteeResult = true,
}

TagCompiler.CommonTagData.Prefix =
{
	method = function(data, value, prefix)	return value and prefix..value end,
	noGuaranteeChange = true,
	parameterTypes = { "string" }
}

local selectWrapComparison = TagCompiler -- This can be any table or function, ie. anything that lua doesn't consider false, that isn't a TagCompiler type
local selectTag
TagCompiler.CommonTagData.Select =
{
	compileString = function(dataTable, prior, condition, trueResult, falseResult)
						if dataTable.parameterList.type1 ~= "raw" then
							-- condition is always true! Optimize the whole lot out
							selectTag.guaranteeResult = dataTable.parameterList.guaranteeResult2
							selectTag.numeric = dataTable.parameterList.numeric2
							return ("%s%s%s"):format(prior or "", prior and " and " or "", trueResult)
						else
							selectTag.guaranteeResult = dataTable.parameterList.guaranteeResult2 and dataTable.parameterList.guaranteeResult3
							selectTag.numeric = dataTable.parameterList.numeric2 and dataTable.parameterList.numeric3

							if dataTable.parameterList.type2 == "raw" then
								dataTable.headerCode["local selectUnwrap = TagCompiler.tagCompilerData.Select.unwrap\n"..
													 "local selectWrap = TagCompiler.tagCompilerData.Select.wrap\n"] = true
								return ("%s%sselectUnwrap(%s and selectWrap(%s) or %s)"):format(prior or "", prior and " and " or "", condition, trueResult, falseResult)
							else
								return ("%s%s(%s and %s or %s)"):format(prior or "", prior and " and " or "", condition, trueResult, falseResult)
							end
						end
					end,

	parameterTypes = { "raw", "raw", "raw" },
	wrap = function(v) return v or selectWrapComparison end,
	unwrap = function(v) return v ~= selectWrapComparison and v end,
}
selectTag = TagCompiler.CommonTagData.Select

TagCompiler.CommonTagData.Surround =
{
	method = function(data, value, prefix, suffix)	return value and prefix..value..suffix end,
	noGuaranteeChange = true,
	parameterTypes = { "string", "string" }
}

TagCompiler.CommonTagData.RGB =
{
	method = function(data, value, r, g, b) return value and ("|cff%02x%02x%02x%s|r"):format(r, g, b, value) end,
	parameterTypes = { "number", "number", "number" }
}

TagCompiler.CommonTagData.RGBIf =
{
	method = function(data, value, condition, r, g, b)	return value and condition and ("|cff%02x%02x%02x%s|r"):format(r, g, b, value) or value end,
	parameterTypes = { "raw", "number", "number", "number" }
}

TagCompiler.CommonTagData.Script =
{
	compileString = function(dataTable, prior, script)
						local scriptFunction = ("return %s"):format(script)
						local scriptString = loadstring(scriptFunction)()
						return ("(%s%s%s)"):format(prior or "", prior and " and " or "", scriptString)
					end,
	parameterTypes = { "string" }
}

TagCompiler.CommonTagData.Short =
{
	method = function(data, value)
				if type(value) == "number" then
					-- Use a 'binary' tree to determine our range, rather than the old sequential search
					-- This gives us maximum 3 comparisons
					if value <= -10000 then
						if value <= -100000 then
							if value <= -1000000 then
								return ("%.2fm"):format(value / 1000000)
							else
								return ("%dk"):format(value / 1000)
							end
						else
							return ("%.1fk"):format(value / 1000)
						end
					else
						if value < 100000 then
							if value < 10000 then
								return ("%d"):format(value)
							else
								return ("%.1fk"):format(value / 1000)
							end
						else
							if value < 1000000 then
								return ("%dk"):format(value / 1000)
							else
								return ("%.2fm"):format(value / 1000000)
							end				
						end
					end
				end
				return value
			 end,
	noGuaranteeChange = true
}

TagCompiler.CommonTagData.Suffix =
{
	method = function(data, value, suffix)	return value and value..suffix end,
	noGuaranteeChange = true,
	parameterTypes = { "string" }
}

TagCompiler.CommonTagData.ToNumber =
{
	compileString = function(dataTable, prior, value)
						dataTable.headerCode = "local tonumber = tonumber\n"
						return ("tonumber(%s)"):format(value)
					end,
	parameterTypes = { "raw" }
}

TagCompiler.CommonTagData.ToString =
{
	compileString = function(dataTable, prior, value)
						dataTable.headerCode = "local tostring = tostring\n"
						return ("tostring(%s)"):format(value)
					end,
	parameterTypes = { "raw" }
}

TagCompiler.CommonTagData.Upper =
{
	method = function(data, value)
				if type(value) == "string" then
					return value:upper()
				end
				return value
			 end,
	noGuaranteeChange = true
}

TagCompiler.CommonTagData.White		= { string = [[HexColor("ffffff")]] }
TagCompiler.CommonTagData.Red 		= { string = [[HexColor("ff0000")]] }
TagCompiler.CommonTagData.Green 	= { string = [[HexColor("00ff00")]] }
TagCompiler.CommonTagData.Blue 		= { string = [[HexColor("0000ff")]] }
TagCompiler.CommonTagData.Cyan 		= { string = [[HexColor("00ffff")]] }
TagCompiler.CommonTagData.Fuchsia 	= { string = [[HexColor("ff00ff")]] }
TagCompiler.CommonTagData.Yellow 	= { string = [[HexColor("ffff00")]] }
TagCompiler.CommonTagData.Gray 		= { string = [[HexColor("afafaf")]] }

-----------------------------------------------------------------------------

local function caseInsensitiveGetTable(tab, key)
	local value = tab[key]
	if value ~= nil or type(key) ~= "string" then
		return key, value
	end
	local key_lower = key:lower()
	for k,v in pairs(tab) do
		if type(k) == "string" and k:lower() == key_lower then
			return k, v
		end
	end
	return key, nil
end

local tagCompilerData
local parseTag
local parseTagOffset
local headerCode = { }
local dataTable
local numeric = false

local function GetByte()
	while parseTag:byte(parseTagOffset) == 32 do 
		parseTagOffset = parseTagOffset + 1
	end 
	return parseTag:byte(parseTagOffset) or 0
end

local function AdvanceByte()
	parseTagOffset = parseTagOffset + 1
end

-----------------------------------------------------------------------------

local TagErrorMethods =
{
	string	= function() return "!!Tag Error!!" end,
	number	= function() return -1 end,
	raw		= function() return nil end,
}

local function TagErrorNoOffset(x) dataTable.error = true tagCompilerData["!TagError"](x) end
local function TagError(x) TagErrorNoOffset(("%s near \"%s...\" (%d)"):format(x, parseTag:sub(parseTagOffset, parseTagOffset+3), parseTagOffset)) end
local function TagDebug(x) tagCompilerData["!TagDebug"] (x) end

local function EmptyTable(table) for k in pairs(table) do table[k] = nil end end
local function MergeData(targetTable, sourceData)
	if not sourceData then return end
	if type(sourceData) == "string" then
		targetTable[sourceData] = true
	elseif type(sourceData) == "table" then
		for _,v in pairs(sourceData) do
			targetTable[v] = true
		end
	end
end

-----------------------------------------------------------------------------

local ParseRValue

local function CoerceToNumber(text)
	if not text or text == "" then
		numeric = true
		guaranteeResult = true
		return "0"
	end
	
	if guaranteeResult then
		if numeric then return text end
		numeric = true
		return ("(tonumber(%s) or 0)"):format(text)
	else
		guaranteeResult = true
		if numeric then
			return ("(%s or 0)"):format(text)
		else
			numeric = true
			return ("(tonumber(%s) or 0)"):format(text)
		end
	end
end

local function CoerceToString(text)
	if guaranteeResult then
		return text
	else
		guaranteeResult = true
		if not text then return [[""]] end
		return ([[(%s or "")]]):format(text)
	end
end

local function CoerceToRaw(text)
	return text
end

local coerceTypeMethods =
{
	string	= CoerceToString,
	number	= CoerceToNumber,
	raw		= CoerceToRaw,
}

local function CoerceToType(text, type, identifier)
	if not type then
		TagErrorNoOffset("Too many parameters for "..identifier)
		return ""
	end

	local method = coerceTypeMethods[type]
	if not method then
		TagError("Internal error - Unrecognised parameter type: "..type)
		return ""
	end

	return method(text)
end

local function GetType()
	if guaranteeResult then
		if numeric then
			return "number"
		else
			return "string"
		end
	else
		return "raw"
	end
end

local emptyList = { }
local parameterTypeAllRawProxy = setmetatable({}, { __index = function() return "raw" end })
local parameterTypeAllNumberProxy = setmetatable({}, { __index = function() return "number" end })
local parameterTypeAllStringProxy = setmetatable({}, { __index = function() return "string" end })

local variableParameterTypeLookup =
{
	["*"]		= parameterTypeAllRawProxy,
	["*raw"]	= parameterTypeAllRawProxy,
	["*number"] = parameterTypeAllNumberProxy,
	["*string"] = parameterTypeAllStringProxy,
}

local function ParseParameterList(parameterTypes, identifier)
	if GetByte() == 40 then -- byte == '('
		AdvanceByte()
		local byte = GetByte()
		if byte == 41 then 
			AdvanceByte()
			if parameterTypes and not variableParameterTypeLookup[parameterTypes[1]] then
				TagErrorNoOffset("Missing parameters for: "..identifier)
			end
			return emptyList
		end

		if not parameterTypes then
			TagErrorNoOffset("No parameters required for: "..identifier)
			return emptyList
		end

		local parameterListStringList = new()
		local result = ParseRValue()
		local checkParameterCount = true
		local parameterCount = 1
		
		local parameterCheck = variableParameterTypeLookup[ parameterTypes[1] ]
		if parameterCheck then
			checkParameterCount = false
			parameterTypes = parameterCheck
		end
		
		parameterListStringList["type1"] = GetType()
		parameterListStringList["numeric1"] = numeric
		parameterListStringList["guaranteeResult1"] = guaranteeResult
		parameterListStringList[1] = CoerceToType(result, parameterTypes[1], identifier)

		while parseTagOffset <= #parseTag and GetByte() == 44 do -- byte == ','
			AdvanceByte()
			local result = ParseRValue()
			parameterCount = parameterCount + 1
			
			local parameterCheck = variableParameterTypeLookup[ parameterTypes[parameterCount] ]
			if parameterCheck then
				checkParameterCount = false
				parameterTypes = parameterCheck
			end
			
			parameterListStringList["type"..parameterCount] = GetType()
			parameterListStringList["numeric"..parameterCount] = numeric
			parameterListStringList["guaranteeResult"..parameterCount] = guaranteeResult
			parameterListStringList[parameterCount] = CoerceToType(result, parameterTypes[parameterCount], identifier)
		end

		if GetByte() == 41 then -- byte == ')'
			AdvanceByte()
		else
			TagError("Missing end of parameter list \")\"")
		end
		
		if checkParameterCount and not variableParameterTypeLookup[parameterTypes[parameterCount+1]] and parameterCount ~= #parameterTypes then
			if variableParameterTypeLookup[parameterTypes[#parameterTypes]] then
				TagErrorNoOffset(("%s requires at least %d parameters, given %d"):format(identifier, #parameterTypes-1, #parameterListStringList))
			else
				TagErrorNoOffset(("%s requires %d parameters, given %d"):format(identifier, #parameterTypes, #parameterListStringList))
			end
		end

		return parameterListStringList
	else
		if parameterTypes and not variableParameterTypeLookup[parameterTypes[1]] then
			TagErrorNoOffset("Missing parameters for: "..identifier)
		end
	end
	return emptyList
end

local function ParsePrimary(functionString)
	local byte = GetByte()
	if byte >= 48 and byte <= 59 then -- byte >= '0' && byte <= '9'
		local startOffset = parseTagOffset
		local endOffset = startOffset
		local decimalPointFound = false
		while true do
			endOffset = endOffset + 1
			byte = parseTag:byte(endOffset) or 0
			if byte == 46 then -- '.'
				if decimalPointFound then
					break
				else
					decimalPointFound = true
				end
			elseif byte < 48 or byte > 59 then
				break
			end
		end
		numeric = true
		parseTagOffset = endOffset
		if functionString then
			return ("(%s and %s)"):format(functionString, parseTag:sub(startOffset, endOffset-1))
		else
			guaranteeResult = true
			return parseTag:sub(startOffset, endOffset-1)
		end
	elseif byte == 34 then	-- byte == '\"'
		local startOffset = parseTagOffset+1
		local endOffset = startOffset
		while true do
			if endOffset > #parseTag then
				TagError("Missing closing quote")
				return ""
			end
			byte = parseTag:byte(endOffset)
			if byte == 34 then -- byte == '\"'
				break
			elseif byte == 92 then	-- byte == '\\'
				endOffset = endOffset + 2
			else
				endOffset = endOffset + 1
			end
		end
		parseTagOffset = endOffset+1
		local string = parseTag:sub(startOffset, endOffset-1):gsub("\\\"", "\"")
		numeric = false
		if functionString then
			return ("%s and %q"):format(functionString, string)
		else
			guaranteeResult = true
			return ("%q"):format(string)
		end		
	elseif (byte >= 65 and byte <= 90) or (byte >= 97 and byte <= 122) then	-- byte >= 'A' && byte <= 'Z' || byte >= 'a' && byte <= 'z'
		local startOffset = parseTagOffset
		local endOffset = startOffset
		while (byte >= 65 and byte <= 90) or (byte >= 97 and byte <= 122) or (byte >= 48 and byte <= 57) do -- a-z, A-Z, 0-0
			endOffset = endOffset + 1
			byte = parseTag:byte(endOffset) or 0
		end
		parseTagOffset = endOffset
		local identifier = parseTag:sub(startOffset, endOffset-1)
		
		local identifier, tagData = caseInsensitiveGetTable(tagCompilerData, identifier)
		if not tagData then
			TagErrorNoOffset("Invalid tag: "..identifier)
			return ""
		end

		MergeData(dataTable.data, tagData.data)
		MergeData(dataTable.events, tagData.events)
		MergeData(dataTable.overrideEvents, tagData.overrideEvents)

		if tagData.string then
			local tag, offset = parseTag, parseTagOffset
			parseTag, parseTagOffset = tagData.string, 1
			local returnValue = ParsePrimary(functionString)
			parseTag, parseTagOffset = tag, offset
			return returnValue
		end

		local result
		local oldGuaranteeResult = guaranteeResult

		if tagData.compileString then
			local parameterStringList = ParseParameterList(tagData.parameterTypes, identifier)
			if not dataTable.error then
				dataTable.parameterList = parameterStringList
				result = tagData.compileString(dataTable, functionString, unpack(parameterStringList))
				dataTable.parameterList = nil
				if #parameterStringList > 0 then
					parameterStringList = del(parameterStringList)
				end
			end
		elseif tagData.tableData then
			if functionString then
				result = functionString.." and data."..tagData.tableData
			else
				result = "data."..tagData.tableData
			end
		elseif tagData.method then
			headerCode[("local tagMethod%s = TagCompiler.tagCompilerData[\"%s\"].method\n"):format(identifier, identifier)] = true
			local parameterStringList = ParseParameterList(tagData.parameterTypes, identifier)
			if not dataTable.error then
				if #parameterStringList > 0 then
					result = ("tagMethod%s(data, %s, %s)"):format(identifier, functionString or "true", table.concat(parameterStringList, ", "))
					parameterStringList = del(parameterStringList)
				else
					result = ("tagMethod%s(data, %s)"):format(identifier, functionString or "true")
				end
			end
		end

		numeric = tagData.numeric
		if tagData.noGuaranteeChange then
			guaranteeResult = oldGuaranteeResult
		else
			guaranteeResult = tagData.guaranteeResult
		end
		
		return result		
	elseif (byte == 40) then -- '('
		AdvanceByte()
		local priorNumeric = numeric
		local priorGuaranteeResult = guaranteeResult
		local result = ParseRValue()

		local byte = GetByte()
		if byte == 41 then
			AdvanceByte()
			if functionString then
				numeric = numeric and priorNumeric
				guaranteeResult = guaranteeResult and priorGuaranteeResult
				return ("%s and (%s)"):format(functionString, result)
			else
				return ("(%s)"):format(result)
			end
		else
			TagError("Missing \")\"")
			return ""
		end
	else
		TagError("Syntax error")
		return ""
	end
end

local function ParseUnary(functionString)
	local byte = GetByte()
	if byte == 126 then -- '~'
		AdvanceByte()
		local result = ("not (%s)%s%s"):format(ParsePrimary(), functionString and " and " or "", functionString or "")
		guaranteeResult = false
		numeric = false
		return result
	elseif byte == 45 then -- '-'
		AdvanceByte()
		return ("%s%s-%s"):format(functionString or "", functionString and " and " or "", CoerceToNumber(ParsePrimary()))
	else
		return ParsePrimary(functionString)
	end
end

local function ParseChain()
	local functionString = ParseUnary()
	while GetByte() == 58 do	-- while tag[offset] == ':'
		AdvanceByte()
		functionString = ParseUnary(functionString)
	end
	return functionString
end

local function ParseFactor()
	local result = ParseChain()
	local byte = GetByte()
	while byte == 42 or byte == 47 do	-- '*' or '/'
		AdvanceByte()
		result = CoerceToNumber(result)
		result = ("%s %s %s"):format(result, string.char(byte), CoerceToNumber(ParseFactor()))
		numeric = true
		guaranteeResult = true
		byte = GetByte()
	end
	return result
end

local function ParseExpression()
	local result = ParseFactor()
	local byte = GetByte()
	while byte == 43 or byte == 45 do	-- '+' or '-'
		AdvanceByte()
		result = CoerceToNumber(result)
		result = ("%s %s %s"):format(result, string.char(byte), CoerceToNumber(ParseFactor()))
		numeric = true
		guaranteeResult = true
		byte = GetByte()
	end
	return result
end

local function ParseConcat()
	local result = ParseExpression()
	while GetByte() == 46 do	-- '.'
		AdvanceByte()
		if GetByte() == 46 then AdvanceByte() end	-- Allow double ".." to mean concat also
		
		result = CoerceToString(result)
		result = ("%s .. %s"):format(result, CoerceToString(ParseExpression()))
		numeric = false
		guaranteeResult = true
	end
	return result
end

local function ParseRelation()
	local result = ParseConcat()

	local byte = GetByte()
	local byte2 = parseTag:byte(parseTagOffset+1)
	if byte == 61 then	-- '='
		AdvanceByte()
		if byte2 == 61 then
			AdvanceByte()
			result = ("(%s == %s)"):format(result, ParseConcat())
			guaranteeResult = false
			numeric = false
			return result
		else
			TagError("Unexpected \"=\"")
			return ""
		end
	elseif byte == 126 then -- '~'
		AdvanceByte()
		if byte2 == 61 then
			AdvanceByte()
			result = ("(%s ~= %s)"):format(result, ParseConcat())
			guaranteeResult = false
			numeric = false
			return result
		else
			TagError("Unexpected \"=\"")
			return ""
		end
	elseif byte == 60 then -- '<'
		AdvanceByte()
		result = CoerceToNumber(result)
		if byte2 == 61 then
			AdvanceByte()
			result = ("(%s <= %s)"):format(result, CoerceToNumber(ParseConcat()))
			guaranteeResult = false
			numeric = false
			return result
		else
			result = ("(%s < %s)"):format(result, CoerceToNumber(ParseConcat()))
			guaranteeResult = false
			numeric = false
			return result
		end
	elseif byte == 62 then -- '>'
		AdvanceByte()
		result = CoerceToNumber(result)
		if byte2 == 61 then
			AdvanceByte()
			result = ("(%s >= %s)"):format(result, CoerceToNumber(ParseConcat()))
			guaranteeResult = false
			numeric = false
			return result
		else
			result = ("(%s > %s)"):format(result, CoerceToNumber(ParseConcat()))
			guaranteeResult = false
			numeric = false
			return result
		end
	else
		return result
	end
end

local function ParseLogical()
	local result = ParseRelation()
	
	local byte = GetByte()
	local bracketsRequired = false
	while byte == 38 or byte == 124 do	-- '&' or '|'
		local byte2 = parseTag:byte(parseTagOffset+1)
		AdvanceByte()
		
		if byte == 124 and byte2 == 124 then	-- WoW escapes "|" characters for things such as "|cffffff00"
			AdvanceByte()
		end
		
		local priorNumeric = numeric
		local priorGuaranteeResult = guaranteeResult
		
		bracketsRequired = true
		
		if byte == 38 then -- '&'
			result = ("%s and %s"):format(result, ParseRelation())
			numeric = numeric and priorNumeric
			guaranteeResult = guaranteeResult and priorGuaranteeResult
		else
			result = ("%s or %s"):format(result, ParseRelation())
		end
		byte = GetByte()
	end
	
	if bracketsRequired then
		return "("..result..")"
	else
		return result
	end
end

ParseRValue = function()
	guaranteeResult = false
	return ParseLogical()
end

-----------------------------------------------------------------------------

local headerTable = { }
local functionStringList = { }
function TagCompiler:Compile(tag, tagData, resultType)
	self:argCheck(tag, 2, "string")
	self:argCheck(tagData, 3, "table")
	if resultType ~= "string" and resultType ~= "number" and resultType ~= "raw" then
		self:error("TagCompiler:Compile - resultType must be string, number or raw")
	end

	parseTag = tag
	tagCompilerData = tagData
	parseTagOffset = 1
	
	-- dataTable is a file local
	dataTable = new()
	dataTable.data = new()
	dataTable.events = new()
	dataTable.overrideEvents = new()
	dataTable.tag = parseTag
	dataTable.headerCode = headerCode

	functionStringList[1] = "" -- it's replaced with all the locals required later
	functionStringList[2] = "return function(data)\nreturn "
	
	if resultType == "string" then
		while parseTagOffset <= #parseTag and not dataTable.error do
			if parseTagOffset > 1 then
				functionStringList[#functionStringList+1] = "..\n "
			end
			if parseTag:byte(parseTagOffset) == 91 then	-- if tag[offset] == '['
				AdvanceByte()
				functionStringList[#functionStringList+1] = CoerceToType(ParseRValue(), "string")
				if GetByte() == 93 then -- if tag[offset] == ']'
					AdvanceByte()
				elseif not dataTable.error then
					TagError("Tag not closed - missing \"]\"")
				end
			else
				-- literal section
				local startOffset = parseTagOffset
				local endOffset = startOffset+1
				while endOffset <= #parseTag and parseTag:byte(endOffset) ~= 91 do
					endOffset = endOffset + 1
				end
				functionStringList[#functionStringList+1] = ("%q"):format(parseTag:sub(startOffset, endOffset-1))
				parseTagOffset = endOffset
			end
		end

		if #parseTag == 0 then
			functionStringList[#functionStringList+1] = [[""]]
		end
	else
		functionStringList[#functionStringList+1] = CoerceToType(ParseRValue(), resultType)
		if GetByte() ~= 0 then
			TagError("Tag contains unused trailing characters")
		end
	end

	for k in pairs(dataTable.overrideEvents) do
		dataTable.events[k] = nil
	end

	if dataTable.error then
		dataTable.method = TagErrorMethods[resultType]
		EmptyTable(dataTable.data)
		EmptyTable(dataTable.events)
	else
		self.tagCompilerData = tagData
		headerTable[1] = "local TagCompiler = AceLibrary(\""..MAJOR_VERSION.."\")\n"
		for k in pairs(headerCode) do
			headerTable[#headerTable+1] = k
		end
		functionStringList[1] = table.concat(headerTable)
		EmptyTable(headerTable)
		functionStringList[#functionStringList+1] = "\nend"
		local functionString = table.concat(functionStringList)

		if tagData["!TagDebug"] then
			TagDebug(("Tag: %s"):format(parseTag))
			for event in pairs(dataTable.events) do
				TagDebug((" - event: %s"):format(event))
			end
			for data in pairs(dataTable.data) do
				TagDebug((" - data: %s"):format(data))
			end
			TagDebug("--- Compiled method ---\n"..functionString)
		end

		local method = loadstring(functionString)
		dataTable.method = method and method() or TagErrorMethods[resultType]
	end

	EmptyTable(headerCode)
	EmptyTable(functionStringList)

	dataTable.headerCode = nil

	if not next(dataTable.events) then
		del(dataTable.events)
		dataTable.events = emptyList
	end

	if not next(dataTable.overrideEvents) then
		del(dataTable.overrideEvents)
		dataTable.overrideEvents = emptyList
	end

	if not next(dataTable.data) then
		del(dataTable.data)
		dataTable.data = emptyList
	end

	local result = dataTable
	dataTable = nil

	return result
end

-----------------------------------------------------------------------------

local processTagResult = { }
local processTagError
local processTagStartOffset
local ProcessTagParseRValue
local bracketLevel
local bracketLevelColors = { [0] = "|cffff00ff", "|cff00ff00", "|cff0000ff", "|cffffff00" }

local function ProcessTagColorSpan(startOffset, endOffset, color)
	if processTagError then return end

	if startOffset ~= processTagStartOffset then
		processTagResult[#processTagResult+1] = parseTag:sub(processTagStartOffset, startOffset-1)
	end

	processTagResult[#processTagResult+1] = color
	processTagResult[#processTagResult+1] = parseTag:sub(startOffset, endOffset)
	processTagResult[#processTagResult+1] = "|r"
	processTagStartOffset = endOffset+1
end

local function ProcessTagColorIdentifier(startOffset, endOffset, identifier, color)
	if processTagError then return end

	if startOffset ~= processTagStartOffset then
		processTagResult[#processTagResult+1] = parseTag:sub(processTagStartOffset, startOffset-1)
	end

	processTagResult[#processTagResult+1] = color
	processTagResult[#processTagResult+1] = parseTag:sub(startOffset, endOffset)
	processTagResult[#processTagResult+1] = "|r"
	processTagStartOffset = endOffset+1
end

local function ProcessTagSubstituteIdentifier(startOffset, endOffset, identifier)
	if startOffset ~= processTagStartOffset then
		processTagResult[#processTagResult+1] = parseTag:sub(processTagStartOffset, startOffset-1)
	end

	processTagResult[#processTagResult+1] = identifier
	processTagStartOffset = endOffset+1
end

local function ProcessTagIsValidIdentifier() end

local function ProcessTagNoColorSpan() end

local ProcessTagIdentifier
local ProcessTagColor

local function ProcessTagParseParameterList(parameterTypes)
	if GetByte() == 40 then -- byte == '('
		ProcessTagColor(parseTagOffset, parseTagOffset, bracketLevelColors[bracketLevel%4])
		bracketLevel = bracketLevel+1
		AdvanceByte()
		local byte = GetByte()
		if byte == 41 then 
			if parameterTypes and not variableParameterTypeLookup[parameterTypes[1]] then
				processTagError = true
			end
			bracketLevel = bracketLevel - 1
			ProcessTagColor(parseTagOffset, parseTagOffset, bracketLevelColors[bracketLevel%4])
			AdvanceByte()
		end

		if not parameterTypes then
			processTagError = true
			return
		end

		ProcessTagParseRValue()
		
		local checkParameterCount = true
		local parameterCount = 1
		
		local parameterCheck = variableParameterTypeLookup[ parameterTypes[1] ]
		if parameterCheck then
			checkParameterCount = false
			parameterTypes = parameterCheck
		end
		
		while parseTagOffset <= #parseTag and GetByte() == 44 do -- byte == ','
			ProcessTagColor(parseTagOffset, parseTagOffset, "|cff00ff00")
			AdvanceByte()
			ProcessTagParseRValue()
			parameterCount = parameterCount + 1

			local parameterCheck = variableParameterTypeLookup[ parameterTypes[parameterCount] ]
			if parameterCheck then
				checkParameterCount = false
				parameterTypes = parameterCheck
			end
		end

		if GetByte() == 41 then -- byte == ')'
			bracketLevel = bracketLevel - 1
			if checkParameterCount and not variableParameterTypeLookup[parameterTypes[parameterCount+1]] and parameterCount ~= #parameterTypes then
				processTagError = true
			end
			ProcessTagColor(parseTagOffset, parseTagOffset, bracketLevelColors[bracketLevel%4])
			AdvanceByte()
		else
			processTagError = true
			return
		end		
	else
		if parameterTypes and not variableParameterTypeLookup[parameterTypes[1]] then
			processTagError = true
		end
	end
end

local function ProcessTagParsePrimary()
	local byte = GetByte()
	if byte >= 48 and byte <= 59 then -- byte >= '0' && byte <= '9'
		local startOffset = parseTagOffset
		local decimalPointFound = false
		while true do
			parseTagOffset = parseTagOffset + 1
			byte = parseTag:byte(parseTagOffset) or 0
			if byte == 46 then -- '.'
				if decimalPointFound then
					break
				else
					decimalPointFound = true
				end
			elseif byte < 48 or byte > 59 then
				break
			end
		end
		ProcessTagColor(startOffset, parseTagOffset-1, "|cff00ffff")
	elseif byte == 34 then	-- byte == '\"'
		local startOffset = parseTagOffset
		parseTagOffset = parseTagOffset + 1
		while true do
			if parseTagOffset > #parseTag then
				processTagError = true
				return
			end
			byte = parseTag:byte(parseTagOffset)
			parseTagOffset = parseTagOffset + 1
			if byte == 34 then -- byte == '\"'
				break
			elseif byte == 92 then	-- byte == '\\'
				parseTagOffset = parseTagOffset + 1
			end
		end
		ProcessTagColor(startOffset, parseTagOffset-1, "|cff00ffff")
	elseif (byte >= 65 and byte <= 90) or (byte >= 97 and byte <= 122) then	-- byte >= 'A' && byte <= 'Z' || byte >= 'a' && byte <= 'z'
		local startOffset = parseTagOffset
		local endOffset = startOffset
		while (byte >= 65 and byte <= 90) or (byte >= 97 and byte <= 122) or (byte >= 48 and byte <= 57) do
			endOffset = endOffset + 1
			byte = parseTag:byte(endOffset) or 0
		end
		parseTagOffset = endOffset
		local identifier = parseTag:sub(startOffset, endOffset-1)
		
		local identifier, tagData = caseInsensitiveGetTable(tagCompilerData, identifier)
		if tagData then
			if tagData.parameterTypes then
				ProcessTagIdentifier(startOffset, endOffset-1, identifier, "|cffff8040")
			else
				ProcessTagIdentifier(startOffset, endOffset-1, identifier, "|cffffffc0")
			end
		else
			ProcessTagIdentifier(startOffset, endOffset-1, identifier, "|cffff0000")
			ProcessTagParseParameterList()
			return
		end

		if tagData.string then
			return
		end

		if tagData.tableData then
			-- Do nothing, this is to preserve the processing order we had previously
		elseif tagData.method then
			ProcessTagParseParameterList(tagData.parameterTypes)
		elseif tagData.compileString then
			ProcessTagParseParameterList(tagData.parameterTypes)
		end
	elseif (byte == 40) then -- '('
		ProcessTagColor(parseTagOffset, parseTagOffset, bracketLevelColors[bracketLevel%4])
		bracketLevel = bracketLevel + 1
		AdvanceByte()
		ProcessTagParseRValue()

		local byte = GetByte()
		if byte == 41 then
			bracketLevel = bracketLevel - 1
			ProcessTagColor(parseTagOffset, parseTagOffset, bracketLevelColors[bracketLevel%4])
			AdvanceByte()
		else
			processTagError = true
		end
	else
		processTagError = true
	end
end

local function ProcessTagParseUnary()
	local byte = GetByte()
	if byte == 126 then -- '~'
		local startOffset = parseTagOffset
		AdvanceByte()
		ProcessTagColor(startOffset, parseTagOffset-1, "|cff00ff00")
		ProcessTagParsePrimary()
	elseif byte == 45 then -- '-'
		local startOffset = parseTagOffset
		AdvanceByte()
		ProcessTagColor(startOffset, parseTagOffset-1, "|cff00ff00")
		ProcessTagParsePrimary()
	else
		return ProcessTagParsePrimary()
	end
end

local function ProcessTagParseChain()
	ProcessTagParseUnary()
	while GetByte() == 58 do	-- while tag[offset] == ':'
		local startOffset = parseTagOffset
		AdvanceByte()
		ProcessTagColor(startOffset, parseTagOffset-1, "|cffffff00")
		ProcessTagParseUnary()
	end
end

local function ProcessTagParseFactor()
	ProcessTagParseChain()
	local byte = GetByte()
	while byte == 42 or byte == 47 do	-- '*' or '/'
		local startOffset = parseTagOffset
		AdvanceByte()
		ProcessTagColor(startOffset, parseTagOffset-1, "|cff00ff00")
		ProcessTagParseFactor()
		byte = GetByte()
	end
end

local function ProcessTagParseExpression()
	ProcessTagParseFactor()
	local byte = GetByte()
	while byte == 43 or byte == 45 do	-- '+' or '-'
		local startOffset = parseTagOffset
		AdvanceByte()
		ProcessTagColor(startOffset, parseTagOffset-1, "|cff00ff00")
		ProcessTagParseFactor()
		byte = GetByte()
	end
end

local function ProcessTagParseConcat()
	ProcessTagParseExpression()
	while GetByte() == 46 do	-- '.'
		local startOffset = parseTagOffset
		AdvanceByte()
		if GetByte() == 46 then AdvanceByte() end	-- Allow double ".." to mean concat also
		ProcessTagColor(startOffset, parseTagOffset-1, "|cff00ff00")
		
		ProcessTagParseExpression()
	end
end

local function ProcessTagParseRelation()
	ProcessTagParseConcat()

	local byte = GetByte()
	local byte2 = parseTag:byte(parseTagOffset+1)
	if byte == 61 or byte == 126 then	-- '=', '~'
		local startOffset = parseTagOffset
		AdvanceByte()
		if byte2 == 61 then
			AdvanceByte()
			ProcessTagColor(startOffset, parseTagOffset-1, "|cff00ff00")
			ProcessTagParseConcat()
		else
			processTagError = true
		end
	elseif byte == 60 or byte == 62 then -- '<', '>'
		local startOffset = parseTagOffset
		AdvanceByte()
		if byte2 == 61 then	-- '='
			AdvanceByte()
		end
		ProcessTagColor(startOffset, parseTagOffset-1, "|cff00ff00")
		ProcessTagParseConcat()
	end
end

local function ProcessTagParseLogical()
	ProcessTagParseRelation()
	
	local byte = GetByte()
	while byte == 38 or byte == 124 do	-- '&' or '|'
		local startOffset = parseTagOffset
		byte2 = parseTag:byte(parseTagOffset+1)
		AdvanceByte()
		
		if byte == 124 and byte2 == 124 then	-- WoW escapes "|" characters for things such as "|cffffff00"
			AdvanceByte()
		end

		ProcessTagColor(startOffset, parseTagOffset-1, "|cff00ff00")
		
		if byte == 38 then -- '&'
			ProcessTagParseRelation()
		else
			ProcessTagParseRelation()
		end
		byte = GetByte()
	end	
end

ProcessTagParseRValue = function()
	ProcessTagParseLogical()
end

-----------------------------------------------------------------------------

function TagCompiler:HighlightSyntax(tag, tagData, resultType)
	self:argCheck(tag, 2, "string")
	self:argCheck(tagData, 3, "table")
	if resultType ~= "string" and resultType ~= "number" and resultType ~= "raw" then
		self:error("TagCompiler:HighlightSyntax - resultType must be string, number or raw")
	end

	parseTag = tag
	tagCompilerData = tagData

	parseTagOffset = 1
	processTagError = false
	processTagStartOffset = 1
	bracketLevel = 1
	
	ProcessTagIdentifier = ProcessTagColorIdentifier
	ProcessTagColor = ProcessTagColorSpan
	
	if resultType == "string" then
		while parseTagOffset <= #parseTag and not processTagError do
			if parseTag:byte(parseTagOffset) == 91 then	-- if tag[offset] == '['
				ProcessTagColorSpan(parseTagOffset, parseTagOffset, "|cffff00ff")
				AdvanceByte()
				ProcessTagParseRValue()
				if GetByte() == 93 then -- if tag[offset] == ']'
					ProcessTagColorSpan(parseTagOffset, parseTagOffset, "|cffff00ff")
					AdvanceByte()
				else
					-- There's an error
					processTagError = true
				end
			else
				-- literal section
				while parseTagOffset <= #parseTag and parseTag:byte(parseTagOffset) ~= 91 do
					parseTagOffset = parseTagOffset + 1
				end
			end
		end
		if not processTagError then
			processTagResult[#processTagResult+1] = parseTag:sub(processTagStartOffset, #parseTag)
			processTagStartOffset = #parseTag+1
		end
	else
		ProcessTagParseRValue()
		if GetByte() ~= 0 then
			processTagError = true
		end
	end
	
	if processTagStartOffset <= #parseTag then
		processTagResult[#processTagResult+1] = "|cffff0000"
		processTagResult[#processTagResult+1] = parseTag:sub(processTagStartOffset)
		processTagResult[#processTagResult+1] = "|r"
	end	

	local result = table.concat(processTagResult)
	for i=1,#processTagResult do
		processTagResult[i] = nil
	end
	return result
end

function TagCompiler:FixCasing(tag, tagData, resultType)
	self:argCheck(tag, 2, "string")
	self:argCheck(tagData, 3, "table")
	if resultType ~= "string" and resultType ~= "number" and resultType ~= "raw" then
		self:error("TagCompiler:FixCasing - resultType must be string, number or raw")
	end

	parseTag = tag
	tagCompilerData = tagData

	parseTagOffset = 1
	processTagError = false
	processTagStartOffset = 1
	bracketLevel = 1
	
	ProcessTagIdentifier = ProcessTagSubstituteIdentifier
	ProcessTagColor = ProcessTagNoColorSpan
	
	if resultType == "string" then
		while parseTagOffset <= #parseTag and not processTagError do
			if parseTag:byte(parseTagOffset) == 91 then	-- if tag[offset] == '['
				AdvanceByte()
				ProcessTagParseRValue()
				if GetByte() == 93 then -- if tag[offset] == ']'
					AdvanceByte()
				else
					-- There's an error, don't touch it
					processTagError = true
				end
			else
				-- literal section
				while parseTagOffset <= #parseTag and parseTag:byte(parseTagOffset) ~= 91 do
					parseTagOffset = parseTagOffset + 1
				end
			end
		end		
	else
		ProcessTagParseRValue()
		if GetByte() ~= 0 then
			processTagError = true
		end
	end
	
	if processTagError then
		for i=1,#processTagResult do
			processTagResult[i] = nil
		end
		return tag
	end
	
	if processTagStartOffset <= #parseTag then
		processTagResult[#processTagResult+1] = parseTag:sub(processTagStartOffset)
	end	

	local result = table.concat(processTagResult)
	for i=1,#processTagResult do
		processTagResult[i] = nil
	end
	return result
end

function TagCompiler:IsValid(tag, tagData, resultType)
	self:argCheck(tag, 2, "string")
	self:argCheck(tagData, 3, "table")
	if resultType ~= "string" and resultType ~= "number" and resultType ~= "raw" then
		self:error("TagCompiler:IsValid - resultType must be string, number or raw")
	end

	parseTag = tag
	tagCompilerData = tagData

	parseTagOffset = 1
	processTagError = false
	processTagStartOffset = 1
	bracketLevel = 1
	
	ProcessTagIdentifier = ProcessTagIsValidIdentifier
	ProcessTagColor = ProcessTagNoColorSpan
	
	if resultType == "string" then
		while parseTagOffset <= #parseTag and not processTagError do
			if parseTag:byte(parseTagOffset) == 91 then	-- if tag[offset] == '['
				AdvanceByte()
				ProcessTagParseRValue()
				if GetByte() == 93 then -- if tag[offset] == ']'
					AdvanceByte()
				else
					-- There's an error, don't touch it
					return false
				end
			else
				-- literal section
				while parseTagOffset <= #parseTag and parseTag:byte(parseTagOffset) ~= 91 do
					parseTagOffset = parseTagOffset + 1
				end
			end
		end		
	else
		ProcessTagParseRValue()
		if GetByte() ~= 0 then
			return false
		end
	end
	
	return not processTagError
end

-----------------------------------------------------------------------------

local cache = { }
function TagCompiler:Evaluate(tag, tagData, resultType, tagParameter)
	local tagDataCache = cache[tagData]
	if not tagDataCache then
		tagDataCache = { }
		cache[tagData] = tagDataCache
	end
	
	local cacheTag = (resultType == "string" and tag) or (resultType..tag)
	local method = tagDataCache[cacheTag]
	if method then
		return method(tagParameter)
	end

	local result = self:Compile(tag, tagData, resultType)
	method = result.method
	tagDataCache[cacheTag] = method

	-- Reclaim the result table
	if #result.events > 0 then del(result.events) end
	if #result.overrideEvents > 0 then del(result.overrideEvents) end
	if #result.data > 0 then del(result.data) end
	result = del(result)
	
	return method(tagParameter)
end

-----------------------------------------------------------------------------

AceLibrary:Register(TagCompiler, MAJOR_VERSION, MINOR_VERSION)

-----------------------------------------------------------------------------
