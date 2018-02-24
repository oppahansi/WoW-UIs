local LSM3 = LibStub("LibSharedMedia-3.0", true)
local LSM2 = LibStub("LibSharedMedia-2.0", true)
local SML = LibStub("SharedMedia-1.0", true)
local Surface = LibStub("Surface-1.0", true)

SharedMedia = {}
SharedMedia.revision = tonumber(string.sub("$Revision: 143 $", 12, -3)) or 1

SharedMedia.registry = { ["statusbar"] = {} }

function SharedMedia:Register(mediatype, key, data, langmask)
	if LSM3 then
		LSM3:Register(mediatype, key, data, langmask)
	end
	if LSM2 then
		LSM2:Register(mediatype, key, data)
	end
	if SML then
		SML:Register(mediatype, key, data)
	end
	if Surface and mediatype == "statusbar" then
		Surface:Register(key, data)
	end
	if not SharedMedia.registry[mediatype] then
		SharedMedia.registry[mediatype] = {}
	end
	table.insert(SharedMedia.registry[mediatype], { key, data, langmask})
end

function SharedMedia.OnEvent(this, event, ...)
	if not LSM3 then
		LSM3 = LibStub("LibSharedMedia-3.0", true)
		if LSM3 then
			for m,t in pairs(SharedMedia.registry) do
				for _,v in ipairs(t) do
					LSM3:Register(m, v[1], v[2], v[3])
				end
			end
		end
	end
	if not LSM2 then
		LSM2 = LibStub("LibSharedMedia-2.0", true)
		if LSM2 then
			for m,t in pairs(SharedMedia.registry) do
				for _,v in ipairs(t) do
					LSM2:Register(m, v[1], v[2])
				end
			end
		end
	end
	if not SML then
		SML = LibStub("SharedMedia-1.0", true)
		if SML then
			for m,t in pairs(SharedMedia.registry) do
				for _,v in ipairs(t) do
					SML:Register(m, v[1], v[2])
				end
			end
		end
	end
	if not Surface then
		Surface = LibStub("Surface-1.0", true)
		if Surface then
			for k,v in ipairs(SharedMedia.registry.statusbar) do
				Surface:Register(v[1], v[2])
			end
		end
	end
end

SharedMedia.frame = CreateFrame("Frame")
SharedMedia.frame:SetScript("OnEvent", SharedMedia.OnEvent)
SharedMedia.frame:RegisterEvent("ADDON_LOADED")
