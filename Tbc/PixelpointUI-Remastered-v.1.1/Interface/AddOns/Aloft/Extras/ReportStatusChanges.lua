-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftReportStatusChanges")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["HostileNameplatesEnabled"] = "Hostile nameplates |cff00ff00enabled|r.",
	["HostileNameplatesDisabled"] = "Hostile nameplates |cffff0000disabled|r.",
	["FriendlyNameplatesEnabled"] = "Friendly nameplates |cff00ff00enabled|r.",
	["FriendlyNameplatesDisabled"] = "Friendly nameplates |cffff0000disabled|r.",

	["Report Status Changes"] = true,
	["Prints the status of nameplates whenever they change"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["HostileNameplatesEnabled"] = "적대적 대상의 이름표 : |cff00ff00표시|r.",
	["HostileNameplatesDisabled"] = "적대적 대상의 이름표 : |cffff0000숨김|r.",
	["FriendlyNameplatesEnabled"] = "우호적 대상의 이름표 : |cff00ff00표시|r.",
	["FriendlyNameplatesDisabled"] = "우호적 대상의 이름표 : |cffff0000숨김|r.",

	["Report Status Changes"] = "상태 변경 알림",
	["Prints the status of nameplates whenever they change"] = "이름표의 표시 상태 변경시 대화창에 표시합니다.",
} end)

L:RegisterTranslations("zhTW", function() return {
	["HostileNameplatesEnabled"] = "敵對名牌|cff00ff00已啟用|r。",
	["HostileNameplatesDisabled"] = "敵對名牌|cffff0000已停用|r。",
	["FriendlyNameplatesEnabled"] = "友好名牌|cff00ff00已啟用|r。",
	["FriendlyNameplatesDisabled"] = "友好名牌|cffff0000已停用|r。",

	["Report Status Changes"] = "報告狀態變化",
	["Prints the status of nameplates whenever they change"] = "報告名牌的狀態變化",
} end)

L:RegisterTranslations("zhCN", function() return {
	["HostileNameplatesEnabled"] = "敌对方姓名板|cff00ff00已启用|r。",
	["HostileNameplatesDisabled"] = "敌对方姓名板|cffff0000已停用|r。",
	["FriendlyNameplatesEnabled"] = "友好方姓名板|cff00ff00已启用|r。",
	["FriendlyNameplatesDisabled"] = "友好方姓名板|cffff0000已停用|r。",

	["Report Status Changes"] = "报告状态变化",
	["Prints the status of nameplates whenever they change"] = "报告姓名板的状态变化",
} end)

-----------------------------------------------------------------------------

local AloftReportStatusChanges = Aloft:NewModule("ReportStatus", "AceEvent-2.0", "AceHook-2.1")
AloftReportStatusChanges.db = Aloft:AcquireDBNamespace("reportStatusChanges")
Aloft:RegisterDefaults("reportStatusChanges", "profile", { enable = true })

-----------------------------------------------------------------------------

Aloft.Options.args.reportStatusChanges =
{
	type = 'toggle',
	name = L["Report Status Changes"],
	desc = L["Prints the status of nameplates whenever they change"],
	get = function() return AloftReportStatusChanges.db.profile.enable end,
	set = function(v) AloftReportStatusChanges.db.profile.enable = v AloftReportStatusChanges:HookNameplates() end,
	order = 3
}

-----------------------------------------------------------------------------

function AloftReportStatusChanges:OnEnable()
	self:HookNameplates()
end

function AloftReportStatusChanges:OnDisable()
end

function AloftReportStatusChanges:HookNameplates()
	self:UnhookAll()

	if self.db.profile.enable then
		self:Hook("HideNameplates", true)
		self:Hook("ShowNameplates", true)
		self:Hook("HideFriendNameplates", true)
		self:Hook("ShowFriendNameplates", true)

		self:Hook(Aloft, "RedisplayNameplates")
		self:Hook(Aloft, "RedisplayFriendlyNameplates")
	end
end

local function ReportNameplateStatus()
	Aloft:Print((NAMEPLATES_ON and L["HostileNameplatesEnabled"] or L["HostileNameplatesDisabled"]).." "..
				(FRIENDNAMEPLATES_ON and L["FriendlyNameplatesEnabled"] or L["FriendlyNameplatesDisabled"]))
end

-----------------------------------------------------------------------------

function AloftReportStatusChanges:HideNameplates()
	if NAMEPLATES_ON then 
		self:ScheduleEvent("AloftReportNameplateStatus", ReportNameplateStatus, 0) 
		NAMEPLATES_ON = false 
	end 
	self.hooks["HideNameplates"]() 
end

function AloftReportStatusChanges:ShowNameplates()
	if not NAMEPLATES_ON then 
		self:ScheduleEvent("AloftReportNameplateStatus", ReportNameplateStatus, 0) 
		NAMEPLATES_ON = true 
	end 
	self.hooks["ShowNameplates"]() 
end

function AloftReportStatusChanges:HideFriendNameplates() 
	if FRIENDNAMEPLATES_ON then 
		self:ScheduleEvent("AloftReportNameplateStatus", ReportNameplateStatus, 0)
		FRIENDNAMEPLATES_ON = false 
	end 
	self.hooks["HideFriendNameplates"]()
end

function AloftReportStatusChanges:ShowFriendNameplates() 
	if not FRIENDNAMEPLATES_ON then 
		self:ScheduleEvent("AloftReportNameplateStatus", ReportNameplateStatus, 0)
		FRIENDNAMEPLATES_ON = true 
	end 
	self.hooks["ShowFriendNameplates"]() 
end

-----------------------------------------------------------------------------

function AloftReportStatusChanges:RedisplayNameplates()
	if not NAMEPLATES_ON then return end
	
	AloftReportStatusChanges.hooks["HideNameplates"]()
	self:ScheduleEvent("AloftRedisplayNameplates", AloftReportStatusChanges.hooks["ShowNameplates"], 0.1)
end

function AloftReportStatusChanges:RedisplayFriendlyNameplates()
	if not FRIENDNAMEPLATES_ON then return end
	
	AloftReportStatusChanges.hooks["HideFriendNameplates"]()
	self:ScheduleEvent("AloftRedisplayFriendlyNameplate", AloftReportStatusChanges.hooks["ShowFriendNameplates"], 0.1)
end

-----------------------------------------------------------------------------
