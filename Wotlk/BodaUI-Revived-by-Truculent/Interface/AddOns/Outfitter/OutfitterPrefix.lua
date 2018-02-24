----------------------------------------
-- Outfitter Copyright 2009 John Stephen, wobbleworks.com
-- All rights reserved, unauthorized redistribution is prohibited
----------------------------------------

Outfitter =
{
	AddonName = "Outfitter",
	AddonColorCode = "|cff99ffcc",
	AddonPath = "Interface\\Addons\\Outfitter\\",
	UIElementsLibTexturePath = "Interface\\Addons\\Outfitter\\",
	Debug = {},
}

-- Patch 3.3 temp

if not EQUIPMENT_SETS then
	EQUIPMENT_SETS = "Equipment Sets: |cFFFFFFFF%s|r"
end

--

Outfitter.LibBabbleZone = LibStub("LibBabble-Zone-3.0")
Outfitter.LibBabbleInventory = LibStub("LibBabble-Inventory-3.0")
Outfitter.LibTipHooker = LibStub("LibTipHooker-1.1")
Outfitter.LibStatLogic = LibStub("LibStatLogic-1.1")
Outfitter.LBF = LibStub("LibButtonFacade", true)

Outfitter.LZ = Outfitter.LibBabbleZone:GetLookupTable()
Outfitter.LBI = Outfitter.LibBabbleInventory:GetLookupTable()

MCAddon = Outfitter

function MCAddon:New(pMethodTable, ...)
	local vObject
	
	if type(pMethodTable) ~= "table" then
		error("table expected")
	end
	
	if pMethodTable.New then
		vObject = pMethodTable:New(...)
	else
		vObject = {}
	end
	
	vObject.Inherit = self.Inherit
	
	vObject:Inherit(pMethodTable, ...)
	
	return vObject
end

function MCAddon:Inherit(pMethodTable, ...)
	for vKey, vValue in pairs(pMethodTable) do
		if self[vKey] then
			if not self.Inherited then
				self.Inherited = {}
			end
			
			self.Inherited[vKey] = self[vKey]
		end
		
		self[vKey] = vValue
	end
	
	if pMethodTable.Construct then
		pMethodTable.Construct(self, ...)
	end
end

function MCAddon:DuplicateTable(pTable, pRecurse, pDestTable)
	if not pTable then
		return nil
	end
	
	local vTable
	
	if pDestTable then
		if type(pDestTable) ~= "table" then
			error("table expected for pDestTable")
		end
		
		vTable = pDestTable
	else
		vTable = {}
	end
	
	if pRecurse then
		for vKey, vValue in pairs(pTable) do
			if type(vValue) == "table" then
				vTable[vKey] = self:DuplicateTable(vValue, true)
			else
				vTable[vKey] = vValue
			end
		end
	else
		self:CopyTable(vTable, pTable)
	end
	
	return vTable
end

function MCAddon:CopyTable(pDestTable, pTable)
	for vKey, vValue in pairs(pTable) do
		pDestTable[vKey] = vValue
	end
end

function MCAddon:RecycleTable(pTable)
	if not pTable then
		return {}
	else
		Outfitter:EraseTable(pTable)
		return pTable
	end
end

function MCAddon:EraseTable(pTable)
	for vKey in pairs(pTable) do
		pTable[vKey] = nil
	end
end

function MCAddon:HookScript(pFrame, pScriptID, pFunction)
	if not pFrame:GetScript(pScriptID) then
		pFrame:SetScript(pScriptID, pFunction)
	else
		pFrame:HookScript(pScriptID, pFunction)
	end
end
