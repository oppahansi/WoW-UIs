----------------------------------------------------------------
-- TUKUI VARS
----------------------------------------------------------------

TukuiCF = { }
TukuiDB = { }
tukuilocal = { }

TukuiDB.dummy = function() return end
TukuiDB.myname, _ = UnitName("player")
_, TukuiDB.myclass = UnitClass("player") 
TukuiDB.client = GetLocale() 
TukuiDB.resolution = GetCurrentResolution()
TukuiDB.getscreenresolution = select(TukuiDB.resolution, GetScreenResolutions())
TukuiDB.version = GetAddOnMetadata("Tukui", "Version")
TukuiDB.incombat = UnitAffectingCombat("player")
TukuiDB.patch = GetBuildInfo()
TukuiDB.level = UnitLevel("player")

-- Hydra was here
realm = GetRealmName()
locale = GetLocale()
reso = select(TukuiDB.resolution, GetScreenResolutions())
user = UnitName("player")
_, class = UnitClass("player")

HydraDB = { }

function Hydra()
	if realm == "Spirestone" and locale == "enUS" and reso == "1280x1024" then
		return true
	end
end