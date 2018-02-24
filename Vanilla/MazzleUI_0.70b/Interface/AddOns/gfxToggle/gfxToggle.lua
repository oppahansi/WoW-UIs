local compost = CompostLib:GetInstance("compost-1")
local metro = Metrognome:GetInstance("1")

local const = gfxToggle.Const

-- Initialize the Class
 gfxToggle.Obj	= AceAddon:new({
	name					= "gfxToggle",
	version				= " a./R22." .. string.sub("$Revision: 1510 $", 12, -3),
	releaseDate   = string.sub("$Date: 2006-05-06 22:43:53 +0200 (Sa, 06 Mai 2006) $", 8, 17), 
	aceCompatible	=  103,
	author				= "Neriak",
	email					= "pk@neriak.de",
	website		 		= "http://neriak_x.wowinterface.com",
	category			= ACE_CATEGORY_INTERFACE,
	db						= AceDatabase:new("gfxToggleDB"),
	cmd						= AceChatCmd:new(const.Commands, const.CmdOptions),
	defaults			= {
		zonesDB = {},
		optionsDB = {
			Delay = 5, 
			M2Faster = true,
			Version = version,
		}
	},
	
	Initialize = function(self)
		if not self:Get("zonesDB") then self:debug("created zonesDB") self:Set("zonesDB", {}) end
		if self:IsM2Faster() then SetCVar("M2Faster", 1) else SetCVar("M2Faster", 0) end
		self.delay = self:GetP("optionsDB", "Delay") or self.defaults.optionsDB.Delay
		if self:GetP("optionsDB", "Low") then
			self.lo = true
		elseif self:GetP("optionsDB", "Med") then
			self.me = true
		elseif self:GetP("optionsDB", "High") then
			self.hi = true
		end
		self:GetDB()
	  self:Version()
	end,

-- Enable / Disable Options
	Enable = function(self)
		self:AutoReg()
	end,
	
	Disable = function(self)
		compost:Reclaim(self.tmpDB)
		self:UnregMetro()
	end,

	PLAYER_ENTERING_WORLD = function(self)
		if self.regged then return end
		if self:IsAuto() then self.regged = true self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneChange") end
	end,
	
	PLAYER_LEAVING_WORLD = function(self)
		if self:IsAuto() then self.regged = nil self:UnregisterEvent("ZONE_CHANGED_NEW_AREA") end
	end,

	RegisterMetro = function(self)
		metro:Register("gfxTLow", self.LoadLo, self.delay, self)
		metro:Register("gfxTMed", self.LoadMed, self.delay, self)
		metro:Register("gfxTHigh", self.LoadHi, self.delay, self)
		metro:Register("gfxTZone",self.ZoneChange, self.delay, self)
	end,
	
	UnregMetro = function(self)
		metro:Unregister("gfxTLow","gfxTMed","gfxTHigh","gfxTZone")
	end,

	AutoReg = function(self)
		if self:IsAuto() then
			self:RegisterMetro()
			self:RegisterEvent("PLAYER_ENTERING_WORLD")
			self:RegisterEvent("PLAYER_LEAVING_WORLD")
			self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "ZoneChange")
			self.regged = true
			metro:Start("gfxTZone")
		end
	end,
	
	Report = function(self)
		local l, h, c 
		self:GetDB()
		if self:IsInfoLow() then l = true end
		if self:IsInfoMed() then m = true end
		if self:IsInfoHigh() then h = true end
		for k,v in pairs(self.tmpDB) do c = (c or 0) + 1	end
			local report = compost:Acquire(
			compost:AcquireHash(
				'text',	const.Chat.Auto,
				'val', self:IsAuto() and 1 or 0,
				'map', ACEG_MAP_ONOFF
			),
			compost:AcquireHash(
				'text',	const.Chat.OhtMed,
				'val', self:Med() and 1 or 0,
				'map', ACEG_MAP_ONOFF
			),
			compost:AcquireHash(
				'text',	const.Chat.Mute,
				'val', self:IsMute() and 1 or 0,
				'map', ACEG_MAP_ONOFF
			),
			compost:AcquireHash(
				'text',const.Chat.GxR,
				'val', self:IsVsync() and 1 or 0,
				'map', ACEG_MAP_ONOFF
			),
			compost:AcquireHash(
				'text',	const.Chat.m2faster,
				'val', self:IsM2Faster() and 1 or 0,
				'map', ACEG_MAP_ONOFF
			),
			compost:AcquireHash(
				'text', const.Chat.Delay,
				'val', self.delay
			),
			compost:AcquireHash(
				'text',	const.Chat.OhtLo,
				'val', l and 1 or 0,
				'map', ACEG_MAP_ONOFF
			),
			compost:AcquireHash(
				'text',	const.Chat.OhtMed,
				'val', m and 1 or 0,
				'map', ACEG_MAP_ONOFF
			),
			compost:AcquireHash(
				'text',	const.Chat.OhtHi,
				'val', h and 1 or 0,
				'map', ACEG_MAP_ONOFF
			),
			compost:AcquireHash(
				'text',	const.Chat.ZoneDb,
				'val', c
			)
		)
		self.cmd:report(report)
		compost:Reclaim(report, 1)
	end,

	
-- Auto-Switch --
	Auto = function (self)
		self:TogP("optionsDB", "Auto", const.Chat.Auto.." [%s]")
		self:UnregisterAllEvents() 
		self:UnregMetro()
		self:AutoReg()
	end,
	
-- On ZoneChange
	ZoneChange = function(self)
		local mem, tim, count, rate = metro:Profile("gfxTZone")
		self:debug(string.format("Mem: %s KiB | Time: %s s| Count: %s | Rate: %s", mem or "", tim or "", count or "", rate or "")) 
		if metro:Status("gfxTZone") then metro:Stop("gfxTZone") end
		self.cnt = (self.cnt or 0) + 1
		self:debug(string.format("ZoneChange has been called %s time(s).",self.cnt))
		local gzt = GetZoneText()
		if gzt == "" or nil then	metro:Start("gfxTZone") return end
		self:GetDB()
		for k,v in pairs(self.tmpDB) do
			if strlower(k) == strlower(gzt) and v == "L" then
				self.zoneName = gzt
				if self:IsLow() then return end
					metro:Start("gfxTLow") 
				return
			end
	  end
		for k,v in pairs(self.tmpDB) do
			if strlower(k) == strlower(gzt) and v == "M" then
				self.zoneName = gzt
				if self:IsMed() then return end
				if self:Med() then
					metro:Start("gfxTMed")
				else
					metro:Start("gfxTLow") 
						return
				end
			end
		end
		if gzt ~= (self.zoneName or "" or nil) then
			if self:IsHigh() then return end
			metro:Start("gfxTHigh") return
		end
	end,

-- Silent Mode --								
	Mute = function (self)
		self:TogP("optionsDB", "Mute", const.Chat.Mute.." [%s]")
	end,

	TogMed = function (self)
		self:TogP("optionsDB", "UseMedium", const.Chat.Med.." [%s]")
	end,

-- Allow gxRestart --
	Vsyn = function (self)
		self:TogP("optionsDB", "gxRestart", const.Chat.GxR.." [%s]")
	end,

-- Allow M2Faster --	
	m2faster = function (self)
		if self:TogP("optionsDB", "M2Faster", const.Chat.m2faster.." [%s]") then 
			SetCVar("M2Faster", 1)
		else 
			SetCVar("M2Faster", 0) 
		end
	end,
	
-- Set Delay	
	Delay = function (self, i)
		self:SetP({"optionsDB"}, "Delay", tonumber(i))
		self:Msg(const.Chat.Delay..": "..ACEG_DISPLAY_OPTION, i)
		self.delay = tonumber(i)
		metro:ChangeRate("gfxTLow",self.delay,"gfxTMed",self.delay,"gfxTHigh",self.delay,"gfxTZone",self.delay)
	end,

-- Checks for Mute, Auto, Low, High, Vsync, M2Faster and Timex
	IsMute = function(self)
		return self:GetP("optionsDB", "Mute")
	end,
	
	IsAuto = function(self)
		self.auto = self:GetP("optionsDB", "Auto")
		  return self.auto
	end,

	Med = function(self)
		return self:GetP("optionsDB", "UseMedium")
	end,
	
	IsInfoLow = function(self)
		return self:GetP("optionsDB", "infoLow")
	end,

	IsInfoMed = function(self)
		return self:GetP("optionsDB", "infoMed")
	end,

	IsInfoHigh = function(self)
		return self:GetP("optionsDB", "infoHi")
	end,
	
	IsLow = function(self)
		return self:GetP("optionsDB", "Low")
	end,

	IsMed = function(self)
		return self:GetP("optionsDB", "Med")
	end,

	IsHigh = function(self)
		return self:GetP("optionsDB", "High")
	end,

	IsVsync = function(self)
		return self:GetP("optionsDB", "gxRestart")
	end,
	
	IsM2Faster = function(self)
	 return self:GetP("optionsDB", "M2Faster")
	end,
	
	SetLow = function(self)
		self:SetP({"optionsDB"}, "Low", true)
		self:SetP({"optionsDB"}, "Med")
		self:SetP({"optionsDB"}, "High")
		self.lo = true
		self.me = false
		self.hi = false
	end,
	
	SetMed = function(self)
		self:SetP({"optionsDB"}, "Med", true)
		self:SetP({"optionsDB"}, "Low")
		self:SetP({"optionsDB"}, "High")
		self.lo = false
		self.me = true
		self.hi = false
	end,

	SetHigh = function(self)
		self:SetP({"optionsDB"}, "High", true)
		self:SetP({"optionsDB"}, "Med")
		self:SetP({"optionsDB"}, "Low")
		self.lo = false
		self.me = false
		self.hi = true
		end,

	GetDB = function(self)
		self.tmpDB = compost:AcquireHash()
		for k,v in pairs(self:Get("zonesDB")) do
			self.tmpDB[self.Capitalize(k,2)] = v
		end
			return self.tmpDB
	end,
	
	Count = function(self)
		local c for k,v in pairs(self.tmpDB) do c = (c or 0) + 1 end return c
	end,
		
	Version = function(self)
		local v = self:GetP("optionsDB", "Version")
		if not v then 
			self:debug("No version info found - we need a reset!") 
			self:Msg(const.Chat.Update)
				return false
		end
		local selfVer,ver = tonumber(strsub(self.version,6,7) .. strsub(self.version,9,-1))
		if string.len(v) == 8 then 
			ver = tonumber(strsub(v,6,7) .. "0001")
		else 
			ver = tonumber(strsub(v,6,7) .. strsub(v,9,-1))
		end
		self:debug(string.format("version: %s | selfVersion: %s", ver, selfVer))
		if ver < selfVer then 
			self:SetP({"optionsDB"}, "Version", self.version) 
			self:debug("Version mismatch - updating version!") 
				return true
		elseif ver > selfVer then
			self:SetP({"optionsDB"}, "Version", self.version)
			self:debug("This version number is lower than the one from SavedVariables - updating version.")
			 return true
		elseif ver == selfVer then
			self:debug("Version match - let's continue.") 
				return true 
		end
	end,

	
-- DB functions --
	Reset = function (self, i)
		local db, u = {} 
		db = self:Get("zonesDB")
		if db and next(db) ~= nil then u = true end
		if i == "CONFIRM" then
			self.db:reset({self.profilePath},self.defaults) 
			self:Msg(ACEG_DORESET)
			if u then 
				if table.getn(db) >=1 then
					for k, v in ipairs(db) do self:SetP({"zonesDB"}, v, "L") end
				else
					self:Set("zonesDB", db) 
				end
			end
			self:Msg(const.Chat.Reload)
		else 
			self:Msg(ACEG_RESETINFO, self.cmd._cmdList[1])
		end	
	end,

-- Add Zone to List --
	AddL = function (self, i)
		self:Add(i,"low")
	end,
	
	AddM = function (self, i)
		self:Add(i,"med")
	end,
	
	Add = function (self,i, w)
		self:GetDB()
	  local z
		if i == "" then z = strlower(GetZoneText()) else z = strlower(i) end
		for k, v in pairs(self.tmpDB) do 
			if strlower(k) == z then 
				self:Msg(const.Chat.Exists) 
					return 
			end 
		end
		if w == "low" then 
			self:SetP({"zonesDB"},z, "L")
		elseif w == "med" then 
			self:SetP({"zonesDB"},z, "M")
			if not self:Med() then self:Msg(const.Chat.MedAdd) end
		end
		self:Msg("'"..self.Capitalize(z, 2)..const.Chat.Added)
		compost:Reclaim(self.tmpDB)
		self:GetDB()
		if z == strlower(GetZoneText()) then
			if w == "low" then self:LoadLo()
				elseif w == "med" then self:LoadMed()
			end
		end
	end,

-- Delete Zone from List --
	Del = function (self, i)
		self:GetDB()
		if strlower(i) == "all" then
			self:Set("zonesDB", {}) self:Msg(const.Chat.DelAll) 
			self:GetDB() return end
		local z, f 
		if i == "" then	z = strlower(GetZoneText())	else z = strlower(i) end
		for v in pairs(self.tmpDB) do if strlower(v) == z then f = strlower(v) end end
		if not f then self:Msg(const.Chat.NotThere)	return end
		self:Msg("'"..self.Capitalize(z,2)..const.Chat.Deleted)
		self:SetP({"zonesDB"} , f, nil)
		compost:Reclaim(self.tmpDB)
		self:GetDB()
		if z == strlower(GetZoneText()) then self:LoadHi() end
	end,

-- List all Zones --
	List = function(self)
		self:GetDB()
		local p,c = function() ace:print(" ") end
		self.dbLow, self.dbMed = compost:Acquire(), compost:Acquire()
		if next(self.tmpDB) ~= nil then
			for k,v in pairs(self.tmpDB) do
				if v == "L" then table.insert(self.dbLow,k) elseif v == "M" then table.insert(self.dbMed,k) end
			end
			c = self:Count()
			if c ~= (c and 0) then
				if next(self.dbLow) ~= nil then
					table.sort(self.dbLow)
					p() self:Msg(string.format("|cff00ff00%s|r", const.Chat.LowZones))
					for k, v in ipairs(self.dbLow) do self:Msg(v) end
				end
				if next(self.dbMed) ~= nil then
					table.sort(self.dbMed)
					p() self:Msg(string.format("|cffffff00%s|r", const.Chat.MedZones))
					for k, v in ipairs(self.dbMed) do self:Msg(v) end
				end
					p() 
					if c == 1 then self:Msg(c..const.Chat.FoundOne)	else self:Msg(c..const.Chat.Found) end
			end
		else
				self:Msg(const.Chat.NoEntry)	
		end
		compost:Reclaim(self.dbLow) compost:Reclaim(self.dbMed)
	end,

--[[ GFX Toggle Functions
			Toggle manually  --]]							
	Toggle = function (self)
		if self:Med() then
			if self:IsLow() then self:LoadMed() return end
			if self:IsMed() then self:LoadHi() return end
			if self:IsHigh() then self:LoadLo() return end
		else 
			if self:IsLow() then self:LoadHi() else self:LoadLo() return end
		end
	end,

-- LoadDefLo --
	DefLo = function (self)
		--SetBaseMip(0) 
		SetWorldDetail(0)
		SetFarclip(177)
		SetCVar("lod", 1)
		SetCVar("ffxGlow", 0)
		SetCVar("ffxDeath", 0)
		SetCVar("M2UsePixelShaders", 0)
		SetCVar("spellEffectLevel", 0)
		SetCVar("weatherDensity", 0)
		if not self:IsMute() then self.PrintOverheadText({1.0,1.0,1.0,5},const.Chat.OhtDefLo) end
		self:SetLow()
		metro:Stop("gfxTLow")
	end,
	
	-- LoadDefHi --
	DefMed = function (self)
		--SetBaseMip(1) 
		SetWorldDetail(1)
		SetFarclip(350)
		SetCVar("lod", 1)
		SetCVar("ffxGlow", 1)
		SetCVar("ffxDeath", 1)
		SetCVar("M2UsePixelShaders", 1)
		SetCVar("spellEffectLevel", 1)
		SetCVar("weatherDensity", 1)
		if not self:IsMute() then self.PrintOverheadText({1.0,1.0,1.0,5},const.Chat.OhtDefMed) end
		self:SetMed()
		metro:Stop("gfxTMed")
	end,
			
-- LoadDefHi --
	DefHi = function (self)
		--SetBaseMip(1) 
		SetWorldDetail(2)
		SetFarclip(777)
		SetCVar("lod", 0)
		SetCVar("ffxGlow", 1)
		SetCVar("ffxDeath", 1)
		SetCVar("M2UsePixelShaders", 1)
		SetCVar("spellEffectLevel", 2)
		SetCVar("weatherDensity", 3)
		if not self:IsMute() then self.PrintOverheadText({1.0,1.0,1.0,5},const.Chat.OhtDefHi) end
		self:SetHigh() 
		metro:Stop("gfxTHigh")
	end,

-- BaseLoad --
	BaseLoad = function (self, db)
		local db = self:GetP("optionsDB", db)
		--SetBaseMip(db.BMip or GetBaseMip())
		SetWorldDetail(db.World or GetWorldDetail())
		SetFarclip(db.Far or GetFarclip())
		SetCVar("lod", db.LD or GetCVar("lod"))
		SetCVar("ffxGlow", db.GL or GetCVar("ffxGlow"))
		SetCVar("ffxDeath", db.DT or GetCVar("ffxDeath"))
		SetCVar("M2UsePixelShaders", db.M2 or GetCVar("M2UsePixelShaders"))
		SetCVar("spellEffectLevel", db.SE or GetCVar("spellEffectLevel"))
		SetCVar("weatherDensity", db.WE or GetCVar("weatherDensity"))
		if self:GetP("optionsDB", "M2Faster") then SetCVar("M2Faster", 1) else SetCVar("M2Faster", 0) end
		if self:IsVsync() then
			SetCVar("gxVSync", db.VS or GetCVar("gxVSync"))
			SetCVar("gxTripleBuffer", db.TB or GetCVar("gxTripleBuffer"))
			SetCVar("gxFixLag", db.FL or GetCVar("gfFixLag"))
			RestartGx()
		end
	end,

-- LoadLo 
	LoadLo = function (self)
		if self:IsInfoLow() then self:BaseLoad("infoLow") 
			if not self:IsMute() then self.PrintOverheadText({1.0,1.0,1.0,5},const.Chat.OhtLo) end
			self:SetLow()
		else self:DefLo()	end
		metro:Stop("gfxTLow")
	end,

-- LoadMed	
	LoadMed = function (self)
		if self:IsInfoMed() then self:BaseLoad("infoMed")
			if not self:IsMute() then self.PrintOverheadText({1.0,1.0,1.0,5},const.Chat.OhtMed) end
			self:SetMed()
		else self:DefMed() end
		metro:Stop("gfxTMed")
	end,

-- LoadHi --
	LoadHi = function (self)
		if self:IsInfoHigh() then self:BaseLoad("infoHi") 
			if not self:IsMute() then self.PrintOverheadText({1.0,1.0,1.0,5},const.Chat.OhtHi) end
			self:SetHigh()
		else self:DefHi() end
		metro:Stop("gfxTHigh")
	end,

-- Save Settings Lo/Hi --
	Save = function (self, i)
		local BM, FA, WO     = GetBaseMip(), GetFarclip(), GetWorldDetail()
		local GL, DT, LD     = GetCVar("ffxGlow"), GetCVar("ffxDeath"), GetCVar("lod")
		local M2, VS, TB, FL = GetCVar("M2UsePixelShaders"), GetCVar("gxVSync"), GetCVar("gxTripleBuffer"), GetCVar("gxFixLag")
		local SE, WE         = GetCVar("spellEffectLevel"), GetCVar("weatherDensity")
		local db = { 
			BMip  = BM,
			World = WO,
			Far   = FA,
			LD    = LD,
			GL    = GL,
			DT    = DT,
			M2    = M2,
			VS    = VS,
			TB    = TB,
			FL    = FL,
			SE    = SE,
			WE 		= WE
		}
		if strlower(i) == "low" then self:SetP({"optionsDB"}, "infoLow", db) end
		if strlower(i) == "medium" then self:SetP({"optionsDB"}, "infoMed", db) end
		if strlower(i) == "high" then	self:SetP({"optionsDB"}, "infoHi", db) end
		if not self:IsMute() then
			if strlower(i) == "low" then 
				self:Msg(const.Chat.SaveLo) 
			elseif strlower(i) == "medium" then 
				self:Msg(const.Chat.SaveMed)
			elseif strlower(i) == "high" then 
				self:Msg(const.Chat.SaveHi) 
			end
		else 
			return 
		end
	end,
		
-- The End  
})

--Register the AddOn Object
gfxToggle.Obj:RegisterForLoad()

-- The Util Functions
	ace:RegisterFunctions(gfxToggle.Obj, {
		version= 2.0,

			Capitalize	=	function(s,l)
				for w in gfind(s,"%S+") do
					if(ace.strlen(w)>(l or 1)) then	s=gsub(s,w,strupper(strsub(w,1,1))..strsub(w,2)) end
				end	return s
			end,
			PrintOverheadText	=	function(...)
				if( type(arg[1])=="table" ) then local p=tremove(arg,1)
					ace:print({(p[1] or 1.0),(p[2] or 1.0),(p[3] or 0),UIErrorsFrame,p[4]},unpack(arg))
				else ace:print(unpack(arg)) end
			end,
			Msg	= function(self, ...)	self.cmd:msg(unpack(arg))	end,
			Get = function(self, var)	if type(self) == "string" then ace:print("! ERROR: "..self)	end	
				return self.db:get(self.profilePath, var)	end,
			GetP = function(self, p, var) if type(self) == "string" then ace:print("! ERROR: "..self)	end	
				return self.db:get({self.profilePath, p}, var) end,
			Set = function(self, var, val) self.db:set(self.profilePath, var, val) end,
			SetP = function(self, p, var, val) self.db:set({self.profilePath, p}, var, val)	end,
			TogSP = function(self, p, var) self.db:toggle({self.profilePath, p}, var)	end,
			TogP = function(self, p, var, c) self.cmd:result(format(c, self.db:toggle({self.profilePath, p}, var) and ACEG_ON or ACEG_OFF))	end,
			Ins = function(self, db, val) return self.db:insert(self.profilePath, db, val) end,
			InsP = function(self,p,db, val) return self.db:insert(self.profilePath, db, val) end,
			Rem = function(self, db, num) return self.db:remove(self.profilePath, db, num) end,
			RemP = function(self,p, db, num) return self.db:remove(self.profilePath, db, num) end
	})
