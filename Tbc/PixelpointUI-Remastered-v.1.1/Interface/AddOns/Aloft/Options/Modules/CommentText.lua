-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("CommentText") then return end
local AloftCommentText = Aloft:GetModule("CommentText")
local L = AceLibrary("AceLocale-2.2"):new("AloftCommentTextOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Comment Text"] = true,
	["Comment text options"] = true,
	["Enable"] = true,
	["Show comments on nameplates"] = true,
	["Font"] = true,
	["Sets the font for comment text"] = true,

	["Set Comment"] = true,
	["Sets the comment for your current target"] = true,
	["<Any String>"] = true,

	["Typeface"] = true,
	["Comment typeface options"] = true,
	["Font Size"] = true,
	["Sets the font height of the comment text"] = true,
	["Font Shadow"] = true,
	["Show font shadow on comment text"] = true,
	["Outline"] = true,
	["Sets the outline for comment text"] = true,

	["Position"] = true,
	["Adjust comment tag position"] = true,
	["Anchor"] = true, 
	["Sets the anchor for the comment text"] = true,
	["Anchor To"] = true, 
	["Sets the relative point on the health bar to anchor the comment text"] = true,
	["X Offset"] = true,
	["X offset of the comment text"] = true,
	["Y Offset"] = true,
	["Y offset of the comment text"] = true,
	["Alpha"] = true,
	["Sets the alpha of the comment text"] = true,
	["Color"] = true,
	["Sets the comment text color"] = true,

	["None"] = true,
	["Normal"] = true,
	["Thick"] = true,

	["NoSetComment"] = "|cffff0000You must have a target to set a comment|r",
	["CommentAdded"] = "Added |cff00ff00%s|r -> |cff00ff00%s|r",

	["Advanced"] = true,
	["Options for expert users"] = true,
	["Format"] = true,
	["Comment tag"] = true,
	["<Any tag string>"] = true,

    ["TOPLEFT"] = true,
	["TOP"] = true,
	["TOPRIGHT"] = true,
	["LEFT"] = true,
	["CENTER"] = true,
	["RIGHT"] = true,
	["BOTTOMLEFT"] = true,
	["BOTTOM"] = true,
	["BOTTOMRIGHT"] = true,
} end)

L:RegisterTranslations("koKR", function() return {
	["Comment Text"] = "메모 글자",
	["Comment text options"] = "메모 글자 설정",
	["Enable"] = "사용",
	["Show comments on nameplates"] = "이름표에 메모를 표시합니다.",
	["Font"] = "글꼴",
	["Sets the font for comment text"] = "메모 글자의 글꼴을 설정합니다.",

	["Set Comment"] = "메모 설정",
	["Sets the comment for your current target"] = "현재 대상에 대한 메모를 설정합니다.",
	["<Any String>"] = "<문자열>",

	["Typeface"] = "서체",
	["Comment typeface options"] = "메모 서체 설정",
	["Font Size"] = "글꼴 크기",
	["Sets the font height of the comment text"] = "메모 글자의 글꼴 높이를 설정합니다.",
	["Font Shadow"] = "글꼴 그림자",
	["Show font shadow on comment text"] = "메모 글자에 그림자를 표시합니다.",
	["Outline"] = "테두리",
	["Sets the outline for comment text"] = "메모 글자에 테두리를 설정합니다.",

	["Position"] = "위치",
	["Adjust comment tag position"] = "메모 태그의 위치를 조절합니다.",
	["Anchor"] = "앵커", 
	["Sets the anchor for the comment text"] = "메모 글자의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치", 
	["Sets the relative point on the health bar to anchor the comment text"] = "생명력바에서 메모 글자의 앵커 위치를 설정합니다.",
	["X Offset"] = "X 좌표",
	["X offset of the comment text"] = "메모 글자의 X 좌표입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the comment text"] = "메모 글자의 Y 좌표입니다.",
	["Alpha"] = "투명도",
	["Sets the alpha of the comment text"] = "메모 글자의 투명도를 설정합니다.",
	["Color"] = "색상",
	["Sets the comment text color"] = "메모 글자의 색상을 설정합니다.",

	["None"] = "없음",
	["Normal"] = "기본",
	["Thick"] = "굵게",

	["NoSetComment"] = "|cffff0000메모를 설정하려면 대상이 있어야 합니다.|r",
	["CommentAdded"] = "|cff00ff00%s|r -> |cff00ff00%s|r 추가됨",

	["Advanced"] = "고급",
	["Options for expert users"] = "고급 사용자를 위한 설정",
	["Format"] = "형식",
	["Comment tag"] = "메모 태그",
	["<Any tag string>"] = "<태그 문자열>",

	["TOPLEFT"] = "좌측 상단",
	["TOP"] = "상단",
	["TOPRIGHT"] = "우측 상단",
	["LEFT"] = "좌측",
	["CENTER"] = "가운데",
	["RIGHT"] = "우측",
	["BOTTOMLEFT"] = "좌측 하단",
	["BOTTOM"] = "하단",
	["BOTTOMRIGHT"] = "우측 하단",
} end)

L:RegisterTranslations("zhTW", function() return {
	["Comment Text"] = "備註文字",
	["Comment text options"] = "備註文字選項",
	["Enable"] = "啟用",
	["Show comments on nameplates"] = "在名牌顯示備註",
	["Font"] = "字型",
	["Sets the font for comment text"] = "備註文字字型",

	["Set Comment"] = "設定備註",
	["Sets the comment for your current target"] = "設定目前目標的備註",
	["<Any String>"] = "<任何文字>",

	["Typeface"] = "字體",
	["Comment typeface options"] = "備註文字字體選項",
	["Font Size"] = "字型大小",
	["Sets the font height of the comment text"] = "備註文字字型大小",
	["Font Shadow"] = "字型陰影",
	["Show font shadow on comment text"] = "備註文字字型陰影",
	["Outline"] = "輪廓",
	["Sets the outline for comment text"] = "備註文字字型輪廓",

	["Position"] = "位置",
	["Adjust comment tag position"] = "備註標籤位置",
	["Anchor"] = "定位點", 
	["Sets the anchor for the comment text"] = "備註文字定位點",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the comment text"] = "備註文字固定在生命力條的位置",
	["X Offset"] = "X位移",
	["X offset of the comment text"] = "備註文字X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the comment text"] = "備註文字Y位移",
	["Alpha"] = "透明度",
	["Sets the alpha of the comment text"] = "備註文字透明度",
	["Color"] = "顏色",
	["Sets the comment text color"] = "備註文字顏色",

	["None"] = "無",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["NoSetComment"] = "|cffff0000你需要一個目標設定備註|r",
	["CommentAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r",

	["Advanced"] = "進階",
	["Options for expert users"] = "進階選項",
	["Format"] = "格式",
	["Comment tag"] = "備註標籤",
	["<Any tag string>"] = "<任何標籤文字>",

    ["TOPLEFT"] = "左上",
	["TOP"] = "上",
	["TOPRIGHT"] = "右上",
	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右",
	["BOTTOMLEFT"] = "左下",
	["BOTTOM"] = "下",
	["BOTTOMRIGHT"] = "右下",
} end)

L:RegisterTranslations("zhCN", function() return {
	["Comment Text"] = "备注文字",
	["Comment text options"] = "备注文字相关设置",
	["Enable"] = "启用",
	["Show comments on nameplates"] = "在姓名板上显示备注文字",
	["Font"] = "字体",
	["Sets the font for comment text"] = "设定备注文字的字体",

	["Set Comment"] = "设定备注",
	["Sets the comment for your current target"] = "为你的当前目标设定备注",
	["<Any String>"] = "<任意文字>",

	["Typeface"] = "式样",
	["Comment typeface options"] = "备注文字式样设置",
	["Font Size"] = "字号",
	["Sets the font height of the comment text"] = "设定备注文字的字号",
	["Font Shadow"] = "字体阴影",
	["Show font shadow on comment text"] = "显示备注文字的字体阴影",
	["Outline"] = "轮廓",
	["Sets the outline for comment text"] = "设定备注文字的字体輪廓",

	["Position"] = "位置",
	["Adjust comment tag position"] = "调整备注标签的位置",
	["Anchor"] = "锚点", 
	["Sets the anchor for the comment text"] = "设定备注文字的锚点",
	["Anchor To"] = "固定在", 
	["Sets the relative point on the health bar to anchor the comment text"] = "设定备注文字固定在生命值显示条的相对位置",
	["X Offset"] = "X轴偏移",
	["X offset of the comment text"] = "设定备注文字的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the comment text"] = "设定备注文字的Y轴偏移量",
	["Alpha"] = "透明度",
	["Sets the alpha of the comment text"] = "设定备注文字的透明度",
	["Color"] = "颜色",
	["Sets the comment text color"] = "设定备注文字的颜色",

	["None"] = "无",
	["Normal"] = "正常",
	["Thick"] = "粗",

	["NoSetComment"] = "|cffff0000要设定备注，你需要一个目标|r",
	["CommentAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r",

	["Advanced"] = "高级",
	["Options for expert users"] = "高级设置",
	["Format"] = "格式",
	["Comment tag"] = "备注标签",
	["<Any tag string>"] = "<任意标签文字>",

    ["TOPLEFT"] = "左上",
	["TOP"] = "上",
	["TOPRIGHT"] = "右上",
	["LEFT"] = "左",
	["CENTER"] = "中",
	["RIGHT"] = "右",
	["BOTTOMLEFT"] = "左下",
	["BOTTOM"] = "下",
	["BOTTOMRIGHT"] = "右下",
} end)

-----------------------------------------------------------------------------

Aloft.Options.args.comment =
{
	type = 'group',
	name = L["Comment Text"],
	desc = L["Comment text options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show comments on nameplates"],
			get = function() return AloftCommentText.db.profile.enable end,
			set = function(v) AloftCommentText.db.profile.enable = v AloftCommentText:UpdateTag() AloftCommentText:UpdateAll() end,
			order = 1
		},
		setComment =
		{
			type = 'text',
			name = L["Set Comment"],
			desc = L["Sets the comment for your current target"],
			usage = L["<Any String>"],
			disabled = function() return not AloftCommentText.db.profile.enable end,
			get = function() return "" end,
			set = function(v) 
					local setFor = Aloft:GetModule("CommentData"):SetCommentForTarget(v)
					if setFor then
						Aloft:Print(string.format(L["CommentAdded"], setFor, v))
					else
						Aloft:Print(L["NoSetComment"])
					end
				  end,
			order = 2
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Comment typeface options"],
			disabled = function() return not AloftCommentText.db.profile.enable end,
			args =
			{
				font =
				{
					type = "text", 
					name = L["Font"], 
					desc = L["Sets the font for comment text"],
					get = function() return AloftCommentText.db.profile.font end,
					set = function(v) AloftCommentText.db.profile.font = v AloftCommentText:UpdateAll() end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the comment text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftCommentText.db.profile.fontSize end,
					set = function(value) AloftCommentText.db.profile.fontSize = value AloftCommentText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on comment text"],
					get = function() return AloftCommentText.db.profile.shadow end,
					set = function(v) AloftCommentText.db.profile.shadow = v AloftCommentText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the outline for comment text"],
					get = function() return AloftCommentText.db.profile.outline end,
					set = function(value) AloftCommentText.db.profile.outline = value AloftCommentText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust comment tag position"],
			disabled = function() return not AloftCommentText.db.profile.enable end,
			args =
			{
				anchor = {
					type = "text", 
					name = L["Anchor"], 
					desc = L["Sets the anchor for the comment text"],
					get = function() return AloftCommentText.db.profile.point end,
					set = function(v) AloftCommentText.db.profile.point = v AloftCommentText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text", 
					name = L["Anchor To"], 
					desc = L["Sets the relative point on the health bar to anchor the comment text"],
					get = function() return AloftCommentText.db.profile.relativeToPoint end,
					set = function(v) AloftCommentText.db.profile.relativeToPoint = v AloftCommentText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the comment text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCommentText.db.profile.offsetX end,
					set = function(v) AloftCommentText.db.profile.offsetX = v AloftCommentText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the comment text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftCommentText.db.profile.offsetY end,
					set = function(v) AloftCommentText.db.profile.offsetY = v AloftCommentText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the alpha of the comment text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftCommentText.db.profile.enable end,
			get = function() return AloftCommentText.db.profile.alpha end,
			set = function(v) AloftCommentText.db.profile.alpha = v AloftCommentText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the comment text color"],
			disabled = function() return not AloftCommentText.db.profile.enable end,
			get = function() return unpack(AloftCommentText.db.profile.color) end,
			set = function(r, g, b, a) AloftCommentText.db.profile.color = { r, g, b, a } AloftCommentText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftCommentText.db.profile.enable end,
			args =
			{
				format = 
				{
					type = 'text',
					name = L["Format"],
					desc = L["Comment tag"],
					usage = L["<Any tag string>"],
					get = function() return Aloft:HighlightTagSyntax(AloftCommentText.db.profile.format) end,
					set = function(v) AloftCommentText.db.profile.format = Aloft:FixTagCasing(v) Aloft:DetermineDataSources() AloftCommentText:UpdateAll() end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------
