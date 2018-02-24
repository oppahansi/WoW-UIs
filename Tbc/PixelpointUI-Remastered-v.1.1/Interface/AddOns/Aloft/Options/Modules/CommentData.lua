-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("CommentData") then return end
local AloftCommentData = Aloft:GetModule("CommentData")
local L = AceLibrary("AceLocale-2.2"):new("AloftCommentDataOptions")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Comments"] = true,
	["Comment options"] = true,

	["Save Comment Data"] = true,
	["Stores comment data between sessions"] = true,

	["Automatic Comments"] = true,
	["Automatically set comments from tooltip tags"] = true,

	["   Include Hostile Units"] = true,
	["Include hostile units when automatically gathering comments"] = true,

	["Reset Comments"] = true,
	["Empties the comment database"] = true,
	
	["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Comments"] = "메모",
	["Comment options"] = "메모 설정",

	["Save Comment Data"] = "메모 데이터 저장",
	["Stores comment data between sessions"] = "접속 간 메모 데이터를 저장합니다.",

	["Automatic Comments"] = "자동 메모",
	["Automatically set comments from tooltip tags"] = "자동으로 툴팁 태그를 메모에 설정합니다.",

	["   Include Hostile Units"] = "   적대적 대상 포함",
	["Include hostile units when automatically gathering comments"] = "자동 메모 설정 시 적대적 대상도 포함시킵니다.",

	["Reset Comments"] = "메모 초기화",
	["Empties the comment database"] = "메모 데이터를 삭제합니다.",
	
	["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "당신의 메모 데이터를 삭제합니다.\n이 동작은 되돌릴 수 없습니다. 계속 하시겠습니까?",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Comments"] = "備註",
	["Comment options"] = "備註選項",

	["Save Comment Data"] = "儲存備註資料",
	["Stores comment data between sessions"] = "儲存備註資料",

	["Automatic Comments"] = "自動備註",
	["Automatically set comments from tooltip tags"] = "由提示訊息自動設定備註",

	["   Include Hostile Units"] = "   包括敵對單位",
	["Include hostile units when automatically gathering comments"] = "自動設定備註包括敵對單位",

	["Reset Comments"] = "重設備註",
	["Empties the comment database"] = "清空備註資料庫",
	
	["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "你是否真的清空備註資料庫?",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Comments"] = "备注",
	["Comment options"] = "备注选项",

	["Save Comment Data"] = "储存备注信息",
	["Stores comment data between sessions"] = "在两次登录的间隔储存备注信息",

	["Automatic Comments"] = "自动备注",
	["Automatically set comments from tooltip tags"] = "将提示信息自动转为备注",

	["   Include Hostile Units"] = "   包括敌对方单位",
	["Include hostile units when automatically gathering comments"] = "自动设定备注信息包括敌对方单位",

	["Reset Comments"] = "重置备注",
	["Empties the comment database"] = "清空备注信息库",
	
	["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"] = "你是否真得要清空备注信息库？",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.data.args.comment =
{
	type = 'group',
	name = L["Comments"],
	desc = L["Comment options"],
	args =
	{
		save =
		{
			type = 'toggle',
			name = L["Save Comment Data"],
			desc = L["Stores comment data between sessions"],
			get = function() return AloftCommentData.db.profile.save end,
			order = 1,
			set = AloftCommentData.SetSaveData
		},
		auto =
		{
			type = 'toggle',
			name = L["Automatic Comments"],
			desc = L["Automatically set comments from tooltip tags"],
			order = 2,
			get = function() return AloftCommentData.db.profile.auto end,
			set = function(v)
					AloftCommentData.db.profile.auto = v
					AloftCommentData:RegisterEvents()
				  end,
		},
		includeHostile =
		{
			type = 'toggle',
			name = L["   Include Hostile Units"],
			desc = L["Include hostile units when automatically gathering comments"],
			order = 3,
			disabled = function() return not AloftCommentData.db.profile.auto end,
			get = function() return AloftCommentData.db.profile.includeHostile end,
			set = function(v) AloftCommentData.db.profile.includeHostile = v end,
		},
		clear =
		{
			type = "execute",
			name = L["Reset Comments"],
			desc = L["Empties the comment database"],
			func = function() AloftCommentData:ClearAllData() end,
			order = -1,
			confirm = L["You are about to empty your comment database.\nThis action cannot be undone. Proceed?"]
		},
	}
}

-----------------------------------------------------------------------------
