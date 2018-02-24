local L = AceLibrary("AceLocale-2.2"):new("Mendeleev")

L:RegisterTranslations("koKR", function() return {
	["KCI Integration"] = "KCI 적용",
	["Integrate into the KCI tooltip"] = "KCI 툴팁에 적용합니다.",
--	["integrate"] = true,
--	["sets"] = true,
--	["toggle"] = true,
	["Toggle Sets"] = "설정 전환",

	["Crafted by"] = "제작됨",
	["Crafted by: "] = "제작됨: ",

	["Recipe source"] = "도안 출처",
	["Recipe source: "] = "도안 출처: ",
	["Seasonal recipe"] = "계절적인 도안",
	["Recipe faction"] = "도안 진영",
	["Vendor faction"] = "상인 진영",

	["Gathering skills"] = "채집 기술",
	["Mine Gems"] = "보석 광맥",
	["Trade Skills"] = "전문 기술",
	["Class Reagents"] = "직업 재료",
	["Zul'Gurub Enchants"] = "줄구룹 마법부여류",
	["Zul'Gurub Classes"] = "줄구룹 직업류",
	["Zul'Gurub Coins"] = "줄구룹 주화류",
	["Ahn'Qiraj CC Classes"] = "안퀴라즈 세나 직업류",
	["Ahn'Qiraj BoN Classes"] = "안퀴라즈 노즈 직업류",
	["Food type"] = "음식 종류",
	["Booze"] = "술류",
	["Lockpick value"] = "고정 획득률",
	["World Drops"] = "월드 드롭류",
	["World Boss Drops"] = "월드 보스 드롭류",
	["Raid Zones"] = "공격대 지역류",
	["Raid Bosses"] = "공격대 보스류",
	["Instance zones"] = "인스턴스 지역류",
	["Instance bosses"] = "인스턴스 보스류",
	["Elemental bosses"] = "속성 보스류",
	["Outdoor bosses"] = "야외 보스류",
	["Four Dragons"] = "네마리 용류",

	["Gathered by"] = "채집됨",
	["Zul'Gurub Enchant"] = "줄구룹 마법부여",
	["Used by"] = "사용됨",
	["Classes"] = "직업",
	["Darkmoon Faire"] = "다크문 페어",
	["Darkmoon Faire Card"] = "다크문 페어 카드",
	["World Drop"] = "월드 드롭",
	["World Boss Drop"] = "월드 보스 드롭",
	["Found in"] = "발견 장소",
	["Dropped by"] = "드롭됨",
	["Used in"] = "세부사용",
	["Reputaton item"] = "평판 아이템",

	["Copper"]        = "구리",
	["Tin"]           = "주석",
	["Silver"]        = "은",
	["Iron"]          = "철",
	["Gold"]          = "금",
	["Mithril"]       = "미스릴",
	["Truesilver"]    = "진은",
	["Small Thorium"] = "작은 토륨",
	["Hakkari Thorium"]                 = "학카리 토륨",
	["Rich Thorium"]  = "풍부한 토륨",
	["Dark Iron"]     = "흑철",

	["Fishing"]       = "낚시",
	["Disenchant"]    = "마력추출",
	["Herbalism"]     = "약초채집",
	["Mining"]        = "채광",
	["Skinning"]      = "무두질",
	["Alchemy"]       = "연금술",
	["Blacksmithing"] = "대장기술",
	["Cooking"]       = "요리",
	["Enchanting"]    = "마법부여",
	["Engineering"]   = "기계공학",
	["Firstaid"]      = "응급치료",
	["Leatherworking"]= "가죽세공",
	["Tailoring"]     = "재봉술",

	["Fish"]          = "생선",
	["Meat"]          = "고기",
	["Bread"]         = "빵",
	["Conjured"]      = "창조",
	["Cheese"]        = "치즈",
	["Fruit"]         = "과일",
	["Misc"]          = "기타",
	["Fungus"]        = "균류",

	["Junk Items"]    = "잡동사니",
	["Leather"]       = "가죽",
	["Blue Dragon Card"]                = "푸른용 카드",
	["Heroism Card"]  = "영웅심 카드",
	["Twisting Nether Card"]            = "뒤틀린 황천의 카드",
	["Maelstrom Card"]= "혼돈의 소용돌이 카드",

	["Lockpicking"]   = "고정획득",
	[" (Enchant)"]    = " (마법부여)",
	["Trash Mobs"]    = "일반몹",
	["Item ID"]        = "아이템 ID",
	["Stacksize"]     = "더미크기",
	["NoClue"]        = "알 수 없음 ",

	-- Factions
	["Alliance"] = "얼라이언스",
	["Horde"] = "호드",
	["Neutral"] = "중립",
	["Argent Dawn"] = "은빛 여명회",
	["Cenarion Circle"] = "세나리온 의회",
	["Thorium Brotherhood"] = "토륨 대장조합",
	["Timbermaw Hold"] = "팀버로우 홀드",
	["Zandalar Tribe"] = "잔달라 부족",
	["Ravenholdt"] = "라벤홀트",

	-- Crafted by
	["Alchemy"] = "연금술",
	["Blacksmithing"] = "대장기술",
	["Armorsmithing"] = "방어구제작",
	["Axesmithing"] = "도끼 제작의 대가",
	["Hammersmithing"] = "망치 제작의 대가",
	["Swordsmithing"] = "검 제작의 대가",
	["Weaponsmithing"] = "무기제작",
	["Cooking"] = "요리",
	["Engineering"] = "기계공학",
	["Gnomish Engineering"] = "노움 기계공학",
	["Goblin Engineering"] = "고블린 기계공학",
	["First Aid"] = "응급치료",
	["Leatherworking"] = "가죽세공",
	["Draconscale Leatherworking"] = "용비늘 가죽세공",
	["Elemental Leatherworking"] = "원소 가죽세공",
	["Tribal Leatherworking"] = "전통 가죽세공",
	["Tailoring"] = "재봉술",

	-- Sources
	["Drop"] = "드롭",
	["Vendor"] = "상인",
	["Quest"] = "퀘스트",
	["Crafted"] = "제작",

--	["UBRS"] = true,
--	["LBRS"] = true,
}end)
if GetLocale() == "koKR" then

	--Localized strings
	--This has a slightly different structure because of the way the closure in the cats works
	MendeleevLocals.Rep	= {}
	MendeleevLocals.Rep[1] 				= " (매우 적대적)"
	MendeleevLocals.Rep[2] 				= " (적대적)"
	MendeleevLocals.Rep[3] 				= " (약간 적대적)"
	MendeleevLocals.Rep[4] 				= " (중립적)"
	MendeleevLocals.Rep[5] 				= " (약간 우호적)"
	MendeleevLocals.Rep[6] 				= " (우호적)"
	MendeleevLocals.Rep[7] 				= " (매우 우호적)"
	MendeleevLocals.Rep[8] 				= " (확고한 동맹)"

	MendeleevLocals.Dif = {}
	MendeleevLocals.Dif[0] 		= "(아주 쉬운)"
	MendeleevLocals.Dif[1] 		= "(쉬운)"
	MendeleevLocals.Dif[2] 		= "(중간)"
	MendeleevLocals.Dif[3] 		= "(적당한)"
	MendeleevLocals.Dif[4] 		= "(어려운)"

end
