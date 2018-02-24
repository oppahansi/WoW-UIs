-----------------------------------------------------------------------------

local L = AceLibrary("AceLocale-2.2"):new("AloftCommentData")
local gratuity = AceLibrary("Gratuity-2.0")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Level"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Level"] = "레벨",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Level"] = "等級",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Level"] = "等级",
} end)

-----------------------------------------------------------------------------

local comments = { }
local profile

-----------------------------------------------------------------------------

local AloftCommentData = Aloft:NewModule("CommentData", "AceEvent-2.0")
AloftCommentData.db = Aloft:AcquireDBNamespace("commentData")
Aloft:RegisterDefaults("commentData", "account", { comments = { } })
Aloft:RegisterDefaults("commentData", "profile", { save = true, auto = true, includeHostile = false })

-----------------------------------------------------------------------------

Aloft.TagData.Comment =
{
	data = "comment",
	events = "Aloft:OnCommentDataChanged",
	tableData = "comment"
}

-----------------------------------------------------------------------------

function AloftCommentData:ProvidesData()
	return "comment"
end

function AloftCommentData:RegisterEvents()
	self:UnregisterAllEvents()
	if profile.auto then
		self:RegisterEvent("UPDATE_MOUSEOVER_UNIT", "UpdateCommentFromMouseOver")
		self:RegisterEvent("PLAYER_TARGET_CHANGED", "UpdateCommentFromTarget")
	end
end

function AloftCommentData:EnableDataSource()
	self:RegisterEvents()
end

-----------------------------------------------------------------------------

function AloftCommentData:OnInitialize()
	profile = self.db.profile
end

function AloftCommentData:OnEnable()
	if profile.save then
		comments = self.db.account.comments
	end
end

function AloftCommentData:UpdateData(aloftData)
	aloftData.comment = comments[aloftData.name]
end

-----------------------------------------------------------------------------

function AloftCommentData:UpdateAll()
	for aloftData in Aloft:IterateVisibleNameplates() do
		local comment = comments[aloftData.name]
		if aloftData.comment ~= comment then
			aloftData.comment = comment
			self:TriggerEvent("Aloft:OnCommentDataChanged", aloftData)
		end
	end
end

function AloftCommentData:SetCommentForTarget(comment)
	local name = UnitName("target")
	if name then
		comments[name] = comment ~= "" and comment or nil
		self:UpdateAll()
		return name
	end
end

function AloftCommentData.SetSaveData(v)
	AloftCommentData.db.profile.save = v
	AloftCommentData.db.server.comments = v and comments or { }
end

function AloftCommentData:ClearAllData()
	for k in pairs(comments) do
		comments[k] = nil
	end
	self:UpdateAll()
end

-----------------------------------------------------------------------------

function AloftCommentData:UpdateCommentFromUnit(unitid)
	local key = UnitName(unitid)
	if key and not comments[key] and not UnitPlayerControlled(unitid) and not UnitIsPlayer(unitid) then
		if not profile.includeHostile and not UnitIsFriend("player", unitid) then 
			return
		end

		gratuity:SetUnit(unitid)

		local comment = gratuity:GetLine(2)
		if comment and comment ~= "" and comment:find(L["Level"]) ~= 1 then
			comments[key] = comment
			for aloftData in Aloft:IterateVisibleNameplates() do
				if aloftData.name == key then
					aloftData.comment = comment
					self:TriggerEvent("Aloft:OnCommentDataChanged", aloftData)
				end
			end
		end
	end
end

function AloftCommentData:UpdateCommentFromMouseOver()
	self:UpdateCommentFromUnit("mouseover")
end

function AloftCommentData:UpdateCommentFromTarget()
	self:UpdateCommentFromUnit("target")
end

-----------------------------------------------------------------------------
