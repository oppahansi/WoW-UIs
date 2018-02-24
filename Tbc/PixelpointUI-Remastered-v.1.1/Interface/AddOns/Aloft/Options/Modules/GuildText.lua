-----------------------------------------------------------------------------

if not Aloft or not Aloft:HasModule("GuildText") then return end

local AloftNameText = Aloft:GetModule("NameText")
local AloftGuildText = Aloft:GetModule("GuildText")

local L = AceLibrary("AceLocale-2.2"):new("AloftGuildTextOptions")
local SML = AceLibrary("SharedMedia-1.0")
local SML_font = SML:List("font")

-----------------------------------------------------------------------------

L:RegisterTranslations("enUS", function() return {
	["Guild Text"] = true,
	["Guild text options"] = true,
	["Enable"] = true,
	["Show guild information on nameplates"] = true,
	
	["Attach to Name"] = true,
	["Attaches guild text to name"] = true,
	["Attach Format"] = true,
	["Selects the text format to use"] = true,

	["HYPHEN"]	= "Name - Guild",
	["SLASH"]	= "Name / Guild",
	["BRACKET"]	= "Name (Guild)",
	["COLON"]	= "Name : Guild",

	["Short"] = true,
	["Use short guild names"] = true,
	["Set Short Name"] = true,
	["<Any String>"] = true,
	["Sets the short name for your current target"] = true,
	["Show Own"] = true,
	["Show the guild names of your own guild members"] = true,

	["Typeface"] = true,
	["Guild text typeface options"] = true,
	["Font"] = true,
	["Sets the font for guild text"] = true,
	["Font Size"] = true,
	["Sets the font height of the guild text"] = true,
	["Font Shadow"] = true,
	["Show font shadow on guild text"] = true,
	["Outline"] = true,
	["Sets the outline for guild text"] = true,

	["Position"] = true,
	["Adjust guild text position"] = true,
	["Anchor"] = true,
	["Sets the anchor for the guild text"] = true,
	["Anchor To"] = true,
	["Sets the relative point on the health bar to anchor the guild text"] = true,
	["X Offset"] = true,
	["X offset of the guild text"] = true,
	["Y Offset"] = true,
	["Y offset of the guild text"] = true,
	["Alpha"] = true,
	["Sets the alpha of the guild text"] = true,
	["Color"] = true,
	["Sets the guild text color"] = true,

	["None"] = true,
	["Normal"] = true,
	["Thick"] = true,
	
	["NoSetShortName"] = "|cffff0000You must have a target to set the short name|r",
	["ShortNameAdded"] = "Added |cff00ff00%s|r -> |cff00ff00%s|r",

	["Advanced"] = true,
	["Options for expert users"] = true,
	["Format"] = true,
	["Guild tag"] = true,
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
	["Guild Text"] = "길드정보",
	["Guild text options"] = "길드정보 설정",
	["Enable"] = "사용",
	["Show guild information on nameplates"] = "이름표에 길드정보를 표시합니다.",
	
	["Attach to Name"] = "이름에 첨부",
	["Attaches guild text to name"] = "이름에 길드 정보를 추가합니다.",
	["Attach Format"] = "첨부 형식",
	["Selects the text format to use"] = "사용할 정보 형식을 선택합니다.",

	["HYPHEN"]	= "이름  - 길드",
	["SLASH"]	= "이름  / 길드",
	["BRACKET"]	= "이름  (길드)",
	["COLON"]	= "이름  : 길드",

	["Short"] = "간략형",
	["Use short guild names"] = "짧은 길드명을 사용합니다.",
	["Set Short Name"] = "짧은 이름 설정",
	["<Any String>"] = "<문자열>",
	["Sets the short name for your current target"] = "현재 대상에 대해 짧은 이름을 설정합니다.",
	["Show Own"] = "자신 표시",
	["Show the guild names of your own guild members"] = "길드원의 길드명을 표시합니다.",

	["Typeface"] = "서체",
	["Guild text typeface options"] = "길드정보 서체 설정",
	["Font"] = "글꼴",
	["Sets the font for guild text"] = "길드 정보의 글꼴을 설정합니다.",
	["Font Size"] = "글꼴 크기",
	["Sets the font height of the guild text"] = "길드 정보 글꼴의 높이를 설정합니다.",
	["Font Shadow"] = "글꼴 그림자",
	["Show font shadow on guild text"] = "길드 정보 글꼴의 그림자를 표시합니다.",
	["Outline"] = "테두리",
	["Sets the outline for guild text"] = "길드 정보에 테두리를 설정합니다.",

	["Position"] = "위치",
	["Adjust guild text position"] = "길드 정보 위치 조절",
	["Anchor"] = "앵커",
	["Sets the anchor for the guild text"] = "길드 정보의 앵커를 설정합니다.",
	["Anchor To"] = "앵커 위치",
	["Sets the relative point on the health bar to anchor the guild text"] = "생명력바에서 길드 정보의 앵커 위치를 설정합니다.",
	["X Offset"] = "X 좌표",
	["X offset of the guild text"] = "길드 정보의 X 좌표 입니다.",
	["Y Offset"] = "Y 좌표",
	["Y offset of the guild text"] = "길드 정보의 Y 좌표 입니다.",
	["Alpha"] = "투명도",
	["Sets the alpha of the guild text"] = "길드 정보의 투명도를 설정합니다.",
	["Color"] = "색상",
	["Sets the guild text color"] = "길드 정보의 색상을 설정합니다.",

	["None"] = "없음",
	["Normal"] = "보통",
	["Thick"] = "굵게",
	
	["NoSetShortName"] = "|cffff0000대상에 지정된 짧은 이름이 없습니다.|r",
	["ShortNameAdded"] = "|cff00ff00%s|r -> |cff00ff00%s|r 추가됨",

	["Advanced"] = "고급",
	["Options for expert users"] = "고급 사용자를 위한 설정입니다.",
	["Format"] = "형식",
	["Guild tag"] = "길드 태그",
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
	["Guild Text"] = "公會文字",
	["Guild text options"] = "公會文字選項",
	["Enable"] = "啟用",
	["Show guild information on nameplates"] = "在名牌顯示公會資訊",
	
	["Attach to Name"] = "依附名字",
	["Attaches guild text to name"] = "公會文字依附名字",
	["Attach Format"] = "依附格式",
	["Selects the text format to use"] = "選擇文字格式",

	["HYPHEN"]	= "名字 - 公會",
	["SLASH"]	= "名字 / 公會",
	["BRACKET"]	= "名字 (公會)",
	["COLON"]	= "名字 : 公會",

	["Short"] = "簡短",
	["Use short guild names"] = "使用簡短公會名字",
	["Set Short Name"] = "設定簡短公會名字",
	["<Any String>"] = "<任何文字>",
	["Sets the short name for your current target"] = "設定目前目標的簡短公會名字",
	["Show Own"] = "設定自己",
	["Show the guild names of your own guild members"] = "設定自己的簡短公會名字",

	["Typeface"] = "字體",
	["Guild text typeface options"] = "公會文字字體選項",
	["Font"] = "字型",
	["Sets the font for guild text"] = "公會文字字型",
	["Font Size"] = "字型大小",
	["Sets the font height of the guild text"] = "公會文字字型大小",
	["Font Shadow"] = "字型陰影",
	["Show font shadow on guild text"] = "公會文字字型陰影",
	["Outline"] = "輪廓",
	["Sets the outline for guild text"] = "公會文字字型輪廓",

	["Position"] = "位置",
	["Adjust guild text position"] = "公會文字位置",
	["Anchor"] = "定位點",
	["Sets the anchor for the guild text"] = "公會文字定位點",
	["Anchor To"] = "固定在",
	["Sets the relative point on the health bar to anchor the guild text"] = "公會文字固定在生命力條的位置",
	["X Offset"] = "X位移",
	["X offset of the guild text"] = "公會文字X位移",
	["Y Offset"] = "Y位移",
	["Y offset of the guild text"] = "公會文字Y位移",
	["Alpha"] = "透明度",
	["Sets the alpha of the guild text"] = "公會文字透明度",
	["Color"] = "顏色",
	["Sets the guild text color"] = "公會文字顏色",

	["None"] = "無",
	["Normal"] = "正常",
	["Thick"] = "粗",
	
	["NoSetShortName"] = "|cffff0000你需要一個目標設定簡短公會名字|r",
	["ShortNameAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r",

	["Advanced"] = "進階",
	["Options for expert users"] = "進階選項",
	["Format"] = "格式",
	["Guild tag"] = "公會標籤",
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
	["Guild Text"] = "公会名称文字",
	["Guild text options"] = "公会名称文字相关设置",
	["Enable"] = "启用",
	["Show guild information on nameplates"] = "在姓名板上显示公会信息",
	
	["Attach to Name"] = "依附姓名",
	["Attaches guild text to name"] = "公会名称文字依附姓名",
	["Attach Format"] = "依附格式",
	["Selects the text format to use"] = "选择文字的",

	["HYPHEN"]	= "名字 - 公会",
	["SLASH"]	= "名字 / 公会",
	["BRACKET"]	= "名字 (公会)",
	["COLON"]	= "名字 : 公会",

	["Short"] = "缩写",
	["Use short guild names"] = "使用公会名称的缩写",
	["Set Short Name"] = "设定公会名称缩写",
	["<Any String>"] = "<任意文字>",
	["Sets the short name for your current target"] = "设定当前目标公会名称的缩写",
	["Show Own"] = "显示自己",
	["Show the guild names of your own guild members"] = "设定自己公会名称的缩写",

	["Typeface"] = "式样",
	["Guild text typeface options"] = "公会名称文字式样设置",
	["Font"] = "字体",
	["Sets the font for guild text"] = "设定公会名称文字的字体",
	["Font Size"] = "字号",
	["Sets the font height of the guild text"] = "设定公会名称文字的字号",
	["Font Shadow"] = "字体阴影",
	["Show font shadow on guild text"] = "显示公会名称文字的字体阴影",
	["Outline"] = "轮廓",
	["Sets the outline for guild text"] = "设定公会名称文字的轮廓",

	["Position"] = "位置",
	["Adjust guild text position"] = "调整设定公会名称文字的位置",
	["Anchor"] = "锚点",
	["Sets the anchor for the guild text"] = "设定公会名称文字的锚点",
	["Anchor To"] = "固定在",
	["Sets the relative point on the health bar to anchor the guild text"] = "设定公会名称文字的固定在生命值显示条的相对位置",
	["X Offset"] = "X轴偏移",
	["X offset of the guild text"] = "公会名称文字的X轴偏移量",
	["Y Offset"] = "Y轴偏移",
	["Y offset of the guild text"] = "公会名称文字的Y轴偏移量",
	["Alpha"] = "透明度",
	["Sets the alpha of the guild text"] = "设定公会名称文字的透明度",
	["Color"] = "颜色",
	["Sets the guild text color"] = "设定公会名称文字的颜色",

	["None"] = "无",
	["Normal"] = "正常",
	["Thick"] = "粗",
	
	["NoSetShortName"] = "|cffff0000要设定公会简称，你首先需要一个目标|r",
	["ShortNameAdded"] = "增加: |cff00ff00%s|r -> |cff00ff00%s|r",

	["Advanced"] = "高级",
	["Options for expert users"] = "高级设置",
	["Format"] = "格式",
	["Guild tag"] = "公会标签",
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

local attachFormats =
{
	["HYPHEN"]	= { "[Guild:Prefix(\" - \"):HideGuild]", "[ShortGuild:Prefix(\" - \"):HideGuild]", "[Guild:Prefix(\" - \")]", "[ShortGuild:Prefix(\" - \")]" },
	["BRACKET"]	= { "[Guild:HideGuild:Surround(\" (\", \")\")]", "[ShortGuild:HideGuild:Surround(\" (\", \")\")]", "[Guild:Surround(\" (\", \")\")]", "[ShortGuild:Surround(\" (\", \")\")]" },
	["SLASH"]	= { "[Guild:Prefix(\" / \"):HideGuild]", "[ShortGuild:Prefix(\" / \"):HideGuild]", "[Guild:Prefix(\" / \")]", "[ShortGuild:Prefix(\" / \")]" },
	["COLON"]	= { "[Guild:Prefix(\" : \"):HideGuild]", "[ShortGuild:Prefix(\" : \"):HideGuild]", "[Guild:Prefix(\" : \")]", "[ShortGuild:Prefix(\" : \")]" },
}

local formats	= { "[Guild:HideGuild]", "[ShortGuild:HideGuild]", "[Guild]", "[ShortGuild]" }

-----------------------------------------------------------------------------

Aloft.Options.args.guildText =
{
	type = 'group',
	name = L["Guild Text"],
	desc = L["Guild text options"],
	disabled = function() return not Aloft:IsActive() end,
	args =
	{
		enable =
		{
			type = 'toggle',
			name = L["Enable"],
			desc = L["Show guild information on nameplates"],
			get = function() return AloftGuildText.db.profile.enable end,
			set = function(v) AloftGuildText.db.profile.enable = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 1
		},
		attachToName =
		{
			type = 'toggle',
			name = L["Attach to Name"],
			desc = L["Attaches guild text to name"],
			disabled = function() return not AloftGuildText.db.profile.enable end,
			get = function() return AloftGuildText.db.profile.attachToName end,
			set = function(v) AloftGuildText.db.profile.attachToName = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 2
		},
		attachFormat =
		{
			type = 'text',
			name = L["Attach Format"],
			desc = L["Selects the text format to use"],
			disabled = function() return not AloftGuildText.db.profile.enable or not AloftGuildText.db.profile.attachToName end,
			get = function() return AloftGuildText.db.profile.attachFormat end,
			set = function(v) AloftGuildText.db.profile.attachFormat = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			validate = { HYPHEN = L["HYPHEN"], SLASH = L["SLASH"], BRACKET = L["BRACKET"], COLON = L["COLON"] },
			order = 3
		},
		short =
		{
			type = 'toggle',
			name = L["Short"],
			desc = L["Use short guild names"],
			disabled = function() return not AloftGuildText.db.profile.enable end,
			get = function() return AloftGuildText.db.profile.useShort end,
			set = function(v) AloftGuildText.db.profile.useShort = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 4
		},
		setShort =
		{
			type = 'text',
			name = L["Set Short Name"],
			desc = L["Sets the short name for your current target"],
			usage = L["<Any String>"],
			disabled = function() return not AloftGuildText.db.profile.enable or not AloftGuildText.db.profile.useShort end,
			get = function() return "" end,
			set = function(v) 
					if UnitExists("target") then
						local targetGuild = GetGuildInfo("target") or ""
						Aloft:GetModule("ShortGuildData"):AddData(targetGuild, v)
						Aloft:Print(string.format(L["ShortNameAdded"], targetGuild, v))
					else
						Aloft:Print(L["NoSetShortName"])
					end
				  end,
			order = 5
		},
		showOwn =
		{
			type = 'toggle',
			name = L["Show Own"],
			desc = L["Show the guild names of your own guild members"],
			disabled = function() return not AloftGuildText.db.profile.enable end,
			get = function() return AloftGuildText.db.profile.showOwn end,
			set = function(v) AloftGuildText.db.profile.showOwn = v AloftGuildText:UpdateAttachedText() Aloft:DetermineDataSources() AloftGuildText:UpdateAll() AloftNameText:UpdateAll() end,
			order = 6
		},
		typeface =
		{
			type = "group",
			name = L["Typeface"],
			desc = L["Guild text typeface options"],
			disabled = function() return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			args =
			{
				font =
				{
					type = "text", 
					name = L["Font"], 
					desc = L["Sets the font for guild text"],
					get = function() return AloftGuildText.db.profile.font end,
					set = function(v) AloftGuildText.db.profile.font = v AloftGuildText:UpdateAll() end,
					validate = SML_font,
				},
				fontSize =
				{
					type = 'range',
					name = L["Font Size"],
					desc = L["Sets the font height of the guild text"],
					max = 16,
					min = 5,
					step = 1,
					get = function() return AloftGuildText.db.profile.fontSize end,
					set = function(value) AloftGuildText.db.profile.fontSize = value AloftGuildText:UpdateAll() end
				},
				shadow =
				{
					type = 'toggle',
					name = L["Font Shadow"],
					desc = L["Show font shadow on guild text"],
					get = function() return AloftGuildText.db.profile.shadow end,
					set = function(v) AloftGuildText.db.profile.shadow = v AloftGuildText:UpdateAll() end
				},
				outline =
				{
					type = 'text',
					name = L["Outline"],
					desc = L["Sets the outline for guild text"],
					get = function() return AloftGuildText.db.profile.outline end,
					set = function(value) AloftGuildText.db.profile.outline = value AloftGuildText:UpdateAll() end,
					validate = { [""] = L["None"], ["OUTLINE"] = L["Normal"], ["THICKOUTLINE"] = L["Thick"] },
				},
			},
		},
		position =
		{
			type = 'group',
			name = L["Position"],
			desc = L["Adjust guild text position"],
			disabled = function() return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			args =
			{
				anchor = {
					type = "text", 
					name = L["Anchor"], 
					desc = L["Sets the anchor for the guild text"],
					get = function() return AloftGuildText.db.profile.point end,
					set = function(v) AloftGuildText.db.profile.point = v AloftGuildText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				anchorto = {
					type = "text", 
					name = L["Anchor To"], 
					desc = L["Sets the relative point on the health bar to anchor the guild text"],
					get = function() return AloftGuildText.db.profile.relativeToPoint end,
					set = function(v) AloftGuildText.db.profile.relativeToPoint = v AloftGuildText:UpdateAll() end,
					validate = {["TOPLEFT"] = L["TOPLEFT"], ["TOP"] = L["TOP"], ["TOPRIGHT"] = L["TOPRIGHT"], ["LEFT"] = L["LEFT"], ["CENTER"] = L["CENTER"], ["RIGHT"] = L["RIGHT"], ["BOTTOMLEFT"] = L["BOTTOMLEFT"], ["BOTTOM"] = L["BOTTOM"], ["BOTTOMRIGHT"] = L["BOTTOMRIGHT"]},
				},
				offsetX =
				{
					type = 'range',
					name = L["X Offset"],
					desc = L["X offset of the guild text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftGuildText.db.profile.offsetX end,
					set = function(v) AloftGuildText.db.profile.offsetX = v AloftGuildText:UpdateAll() end
				},
				offsetY =
				{
					type = 'range',
					name = L["Y Offset"],
					desc = L["Y offset of the guild text"],
					min = -32,
					max = 32,
					step = 1,
					get = function() return AloftGuildText.db.profile.offsetY end,
					set = function(v) AloftGuildText.db.profile.offsetY = v AloftGuildText:UpdateAll() end
				},
			},
		},
		alpha =
		{
			type = 'range',
			name = L["Alpha"],
			desc = L["Sets the alpha of the guild text"],
			min = 0,
			max = 1.0,
			step = 0.05,
			disabled = function() return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			get = function() return AloftGuildText.db.profile.alpha end,
			set = function(v) AloftGuildText.db.profile.alpha = v AloftGuildText:UpdateAll() end
		},
		color =
		{
			type = 'color',
			name = L["Color"],
			desc = L["Sets the guild text color"],
			disabled = function() return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			get = function() return unpack(AloftGuildText.db.profile.color) end,
			set = function(r, g, b, a) AloftGuildText.db.profile.color = { r, g, b, a } AloftGuildText:UpdateAll() end,
		},
		advanced  =
		{
			type = 'group',
			name = L["Advanced"],
			desc = L["Options for expert users"],
			order = -1,
			disabled = function() return not AloftGuildText.db.profile.enable or AloftGuildText.db.profile.attachToName end,
			args =
			{
				format = 
				{
					type = 'text',
					name = L["Format"],
					desc = L["Guild tag"],
					usage = L["<Any tag string>"],
					get = function() return Aloft:HighlightTagSyntax(AloftGuildText.db.profile.format) end,
					set = function(v) AloftGuildText.db.profile.format = Aloft:FixTagCasing(v) Aloft:DetermineDataSources() AloftGuildText:UpdateAll() end,
				}
			},
		},
	},
}

-----------------------------------------------------------------------------

function AloftGuildText:GetAttachFormatIndex()
	local attachFormatIndex = 1
	if self.db.profile.useShort then attachFormatIndex = 2 end
	if self.db.profile.showOwn then attachFormatIndex = attachFormatIndex+2 end
	return attachFormatIndex
end

function AloftGuildText:UpdateAttachedText()
	self.db.profile.format = formats[self:GetAttachFormatIndex()]
	AloftNameText:UpdateFormatTag()
end

-----------------------------------------------------------------------------

function AloftGuildText:NameTextTagModifier()
	if not self.db.profile.enable or not self.db.profile.attachToName then return end
	AloftNameText.db.profile.format = AloftNameText.db.profile.format..attachFormats[self.db.profile.attachFormat][self:GetAttachFormatIndex()]
end

AloftNameText:RegisterFormatTagModifier(1, AloftGuildText.NameTextTagModifier, AloftGuildText)

-----------------------------------------------------------------------------

