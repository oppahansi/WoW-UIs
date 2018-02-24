local L = AceLibrary("AceLocale-2.2"):new("ItemBonusLib")

L:RegisterTranslations("koKR", function () return {
	["An addon to get information about bonus from equipped items"] = "착용 장비의 보너스 효과에 대한 정보를 작성하는 애드온입니다",
	["show"] = "표시",
	["Show all bonuses from the current equipment"] = "현재 착용 장비의 모든 보너스 표시",
	["Current equipment bonuses:"] = "현재 착용 장비 보너스:",
	["details"] = "상세정보",
	["Shows bonuses with slot distribution"] = "슬롯 부위별 보너스를 표시합니다",
	["Current equipment bonus details:"] = "현재 착용 보너스 상세정보:",
	["item"] = "아이템",
	["show bonuses of given itemlink"] = "주어진 아이템 링크에 대한 보너스를 표시합니다.",
	["<itemlink>"] = "<아이템링크>",
	["Bonuses for %s:"] = "%s의 보너스 효과:",
	["Item is part of set [%s]"] = "[%s] 세트의 부분 아이템",
	[" %sBonus for %d pieces :"] = "%d 피스 %s 보너스 효과",
	["slot"] = "슬롯",
	["show bonuses of given slot"] = "주어진 슬롯에 대한 보너스 효과 표시",
	["<slotname>"] = "<슬롯명칭>",
	["Bonuses of slot %s:"] = "%s 슬롯의 보너스 효과:",
	
	-- bonus names
	NAMES = {	
		STR 		= "힘",
		AGI 		= "민첩성",
		STA 		= "체력",
		INT 		= "지능",
		SPI 		= "정신력",
		ARMOR 		= "방어도",

		ARCANERES 	= "비전 저항력",	
		FIRERES 	= "화염 저항력",
		NATURERES 	= "자연 저항력",
		FROSTRES 	= "냉기 저항력",
		SHADOWRES 	= "암흑 저항력",

		FISHING 	= "낚시",
		MINING 		= "채광",
		HERBALISM 	= "약초 채집",
		SKINNING 	= "무두질",
		DEFENSE 	= "방어 숙련도",
		
		BLOCK 		= "방어율",
		BLOCKVALUE  = "방패 피해 흡수량",
		DODGE 		= "회피",
		PARRY 		= "무기막기",
		ATTACKPOWER = "전투력",
		ATTACKPOWERUNDEAD = "언데드에 대한 전투력",
		ATTACKPOWERFERAL = "야수 변신시 전투력",
		CRIT 		= "치명타 적중률",
		RANGEDATTACKPOWER = "원거리 전투력",
		RANGEDCRIT 	= "원거리 치명타 적중률",
		TOHIT 		= "적중률",

		DMG 		= "주문 공격력",
		DMGUNDEAD	= "언데드에 대한 주문 공격력",
		ARCANEDMG 	= "비전계 주문 공격력",
		FIREDMG 	= "화염계 주문 공격력",
		FROSTDMG 	= "냉기계 주문 공격력",
		HOLYDMG 	= "신성계 주문 공격력",
		NATUREDMG 	= "자연계 주문 공격력",
		SHADOWDMG 	= "암흑계 주문 공격력",
		SPELLCRIT 	= "주문 극대화율",
		SPELLTOHIT 	= "주문 적중율",
		SPELLPEN 	= "대상 저항 감소",
		HEAL 		= "치유 증가량",
		HOLYCRIT 	= "신성계 주문 극대화율",

		HEALTHREG 	= "생명력 회복",
		MANAREG 	= "마나 회복",
		HEALTH 		= "생명력",
		MANA 		= "마나"
	};


	-- passive bonus patterns. checked against lines which start with above prefixes
	PATTERNS_PASSIVE = {


--[[		{ pattern = "비전 주문으로 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "ARCANECRIT" },
		{ pattern = "화염 주문으로 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "FIRECRIT" },
		{ pattern = "냉기 주문으로 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "FROSTCRIT" },
		{ pattern = "자연 주문으로 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "NATURECRIT" },
		{ pattern = "암흑 주문으로 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "SHADOWCRIT" },

		{ pattern = "비전 주문이 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "ARCANECRIT" },
		{ pattern = "화염 주문이 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "FIRECRIT" },
		{ pattern = "냉기 주문이 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "FROSTCRIT" },
		{ pattern = "자연 주문이 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "NATURECRIT" },
		{ pattern = "암흑 주문이 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "SHADOWCRIT" },]]

		{ pattern = "매 5초마다 (%d+)의 생명력이 회복됩니다%.", effect = "HEALTHREG" },
		{ pattern = "매 5초마다 (%d+)의 마나가 회복됩니다%.", effect = "MANAREG" },
		
		{ pattern = "방어 숙련도 ++(%d+)", effect = "DEFENSE" },
		{ pattern = "방패의 피해 방어량이 (%d+)만큼 증가합니다%.", effect = "BLOCKAMT" },
--[[		{ pattern = "타격 시 (%d+)%%의 확률로 1회의 추가 공격을 합니다%.", effect = "XTRAHIT" },
		{ pattern = "상처를 내 (%d+)의 피해를 입힙니다%.", effect = "HIT_WOUND" },
		{ pattern = "적에게 어둠의 화살을 발사하여 %d+~(%d+)의 암흑 피해를 입힙니다%.", effect = "HIT_SHADOW" }]]

		{ pattern = "전투력 ++(%d+)", effect = "ATTACKPOWER" },
		{ pattern = "원거리 전투력 ++(%d+)", effect = "RANGEDATTACKPOWER" },
		{ pattern = "방패로 적의 공격을 방어할 확률이 (%d+)%%만큼 증가합니다%.", effect = "BLOCK" },
		{ pattern = "Increases the block value of your shield by (%d+)%.", effect = "BLOCKVALUE" },
		{ pattern = "공격을 회피할 확률이 (%d+)%%만큼 증가합니다%.", effect = "DODGE" },
		{ pattern = "무기 막기 확률이 (%d+)%%만큼 증가합니다%.", effect = "PARRY" },
		{ pattern = "주문이 극대화 효과를 낼 확률이 (%d+)%%만큼 증가합니다%.", effect = "SPELLCRIT" },
		{ pattern = "신성 주문으로 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "HOLYCRIT" },
		{ pattern = "신성 주문이 극대화 효과를 발휘할 확률이 (%d+)%%만큼 증가합니다%.", effect = "HOLYCRIT" },
		{ pattern = "치명타를 적중시킬 확률이 (%d+)%%만큼 증가합니다%.", effect = "CRIT" },
		{ pattern = "원거리 무기로 치명타를 적중시킬 확률이 (%d+)%%만큼 증가합니다%.", effect = "RANGEDCRIT" },
		{ pattern = "비전 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "ARCANEDMG" },
		{ pattern = "화염 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "FIREDMG" },
		{ pattern = "냉기 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "FROSTDMG" },
		{ pattern = "신성 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "HOLYDMG" },
		{ pattern = "자연 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "NATUREDMG" },
		{ pattern = "암흑 계열의 주문과 효과의 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "SHADOWDMG" },
		{ pattern = "모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼 증가합니다%.", effect = "HEAL" },
		{ pattern = "모든 주문 및 효과에 의한 피해와 치유량이 최대 (%d+)만큼 증가합니다%.", effect = {"HEAL","DMG"} },
		{ pattern = "언데드에 대한 주문 및 효과에 의한 공격력이 최대 (%d+)만큼 증가합니다%.", effect = "DMGUNDEAD" },
		{ pattern = "언데드에 대한 효과나 주문에 의한 피해가 최대 (%d+)만큼 증가합니다%.", effect = "DMGUNDEAD" },
		{ pattern = "언데드 공격 시 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERUNDEAD" },
		{ pattern = "무기의 적중률이 (%d+)%%만큼 증가합니다%.", effect = "TOHIT" },
		{ pattern = "주문의 적중률이 (%d+)%%만큼 증가합니다%.", effect = "SPELLTOHIT" },
		{ pattern = "자신의 주문에 대한 대상의 마법 저항력을 (%d+)만큼 감소시킵니다%.", effect = "SPELLPEN" },
		{ pattern = "표범, 광포한 곰, 곰 변신 상태일 때 전투력이 (%d+)만큼 증가합니다%.", effect = "ATTACKPOWERFERAL" },

		-- Atiesh related patterns
		{ pattern = "주문의 공격력이 최대 (%d+)만큼 치유량을 최대 (%d+)만큼 증가합니다%.", effect = {"DMG", "HEAL"} },
		{ pattern = "주위 %d+미터 반경에 있는 모든 파티원의 모든 주문 및 효과에 의한 치유량이 최대 (%d+)만큼 증가합니다%.", effect = "HEAL" },
--		{ pattern = "Increases damage and healing done by magical spells and effects of all party members within %d+ yards by up to (%d+)%.", effect = {"HEAL", "DMG"} },
		{ pattern = "주위 %d+미터 반경 내에 있는 모든 파티원의 마나가 매 5초마다 (%d+)만큼 회복됩니다%.", effect = "MANAREG" },
		{ pattern = "주위 %d+미터 반경에 있는 모든 파티원의 주문 극대화 확률이 (%d+)%%만큼 증가합니다%.", effect = "SPELLCRIT" },

		-- Added for HealPoints
		{ pattern = "시전 중에도 평소의 (%d+)%%에 달하는 속도로 마나가 회복됩니다%.", effect = "CASTINGREG"},		
		{ pattern = "자연 계열 주문이 치명타로 적중할 확률이 (%d+)%%만큼 증가합니다%.", effect = "NATURECRIT"}, 
		{ pattern = "재생의 시전 시간이 0%.(%d+)초만큼 단축됩니다%.", effect = "CASTINGREGROWTH"}, 
--		{ pattern = "Reduces the casting time of your Holy Light spell by 0%.(%d+) sec%.", effect = "CASTINGHOLYLIGHT"},
--		{ pattern = "Reduces the casting time of your Healing Touch spell by 0%.(%d+) sec%.", effect = "CASTINGHEALINGTOUCH"},
		{ pattern = "순간 치유의 시전 시간이 0%.(%d+)초만큼 단축됩니다%.", effect = "CASTINGFLASHHEAL"},
		{ pattern = "연쇄 치유의 시전 시간이 0%.(%d+)초만큼 단축됩니다%.", effect = "CASTINGCHAINHEAL"},
		{ pattern = "회복의 지속시간이 (%d+)만큼 증가합니다%.", effect = "DURATIONREJUV"},
		{ pattern = "소생의 지속시간이 (%d+)초만큼 증가합니다%.", effect = "DURATIONRENEW"},
		{ pattern = "평상시 생명력과 마나의 회복 속도를 (%d+)만큼 향상시킵니다%.", effect = "MANAREGNORMAL" },
		{ pattern = "연쇄 치유 사용 시 처음 회복되는 대상 외에 치유되는 생명력이 각각 (%d+)%%만큼 증가합니다%.", effect = "IMPCHAINHEAL"},
		{ pattern = "회복에 의한 치유량이 최대 (%d+)까지 증가합니다%.", effect = "IMPREJUVENATION"},
		{ pattern = "하급 치유의 물결에 의한 치유량이 최대 (%d+)까지 증가합니다%.", effect = "IMPLESSERHEALINGWAVE"},
		{ pattern = "빛의 섬광에 의한 치유량이 최대 (%d+)만큼 증가합니다%.", effect = "IMPFLASHOFLIGHT"},
		{ pattern = "치유의 물결이나 하급 치유의 물결 시전 후 25%%의 확률로 소비된 마나의 (%d+)%%를 다시 회복합니다%.", effect = "REFUNDHEALINGWAVE"},
		{ pattern = "치유의 물결 사용 시 추가로 주위 아군을 연쇄적으로 회복시킵니다%. 대상이 바뀔 때마다 치유 효과는 (%d+)%%씩 감소됩니다%. 최대 2명의 추가 대상에게 효력을 미칩니다%.", effect = "JUMPHEALINGWAVE"},
		{ pattern = "치유의 손길%, 재생%, 회복%, 평온에 소비되는 마나가 (%d+)%%만큼 감소합니다%.", effect = "CHEAPERDRUID"},
		{ pattern = "치유의 손길이 극대화 효과를 발휘할 시 주문에 소비된 마나의 (%d+)%%만큼을 회복합니다%.", effect = "REFUNDHTCRIT"},
		{ pattern = "소생에 소비되는 마나가 (%d+)%%만큼 감소합니다%.", effect = "CHEAPERRENEW"},
	};

	-- generic patterns have the form "+xx bonus" or "bonus +xx" with an optional % sign after the value.

	-- first the generic bonus string is looked up in the following table
	PATTERNS_GENERIC_LOOKUP = {
		["모든 능력치"] 			= {"STR", "AGI", "STA", "INT", "SPI"},
		["힘"]			= "STR",
		["민첩성"]				= "AGI",
		["체력"]				= "STA",
		["지능"]			= "INT",
		["정신력"] 				= "SPI",

		["모든 저항력"] 	= { "ARCANERES", "FIRERES", "FROSTRES", "NATURERES", "SHADOWRES"},

		["낚시"]				= "FISHING",
		["낚시용 미끼"]		= "FISHING",
		["낚시 숙련도"]	= "FISHING",
		["채광"]				= "MINING",
		["약초 채집"]			= "HERBALISM",
		["무두질"]			= "SKINNING",
		["방어 숙련도"]				= "DEFENSE",

		["전투력"] 		= "ATTACKPOWER",
		["언데드 공격 시 전투력"] 		= "ATTACKPOWERUNDEAD",
--		["Attack Power in Cat, Bear, and Dire Bear forms only"] = "ATTACKPOWERFERAL",

		["회피율"] 				= "DODGE",
		["방어율"]				= "BLOCK",
		["방패 피해 방어량"]			= "BLOCKVALUE",
		["적중률"] 				= "TOHIT",
		["주문 적중률"]			= "SPELLTOHIT",
--		["Blocking"]			= "BLOCK",
		["원거리 전투력"] = "RANGEDATTACKPOWER",
		["5초당 생명력 회복"] = "HEALTHREG",
		["치유 주문 효과"] 		= "HEAL",
		["치유량 증가"] 	= "HEAL",
		["치유 효과 증가"] 	= "HEAL",
		["치유 및 공격 주문 위력"] = {"HEAL", "DMG"},
		["치유 및 주문 공격력"] = {"HEAL", "DMG"},
--		["Spell Damage and Healing"] = {"HEAL", "DMG"},	
		["5초당 마나 회복"] 	= "MANAREG",
		["마나 회복"] 			= "MANAREG",
		["주문 피해"] 		= {"HEAL", "DMG"},
		["치명타"] 			= "CRIT",
--		["Critical Hit"] 		= "CRIT",
		["주문 공격력"] 				= "DMG",
		["생명력"]				= "HEALTH",
--		["HP"]					= "HEALTH",
		["마나"]				= "MANA",
		["방어도"]				= "ARMOR",
		["방어도 보강"]	= "ARMOR",
	};	

	-- next we try to match against one pattern of stage 1 and one pattern of stage 2 and concatenate the effect strings
	PATTERNS_GENERIC_STAGE1 = {
		{ pattern = "비전", 	effect = "ARCANE" },	
		{ pattern = "화염", 	effect = "FIRE" },	
		{ pattern = "냉기", 	effect = "FROST" },	
		{ pattern = "신성", 	effect = "HOLY" },	
		{ pattern = "암흑", 	effect = "SHADOW" },	
		{ pattern = "자연", 	effect = "NATURE" }
	}; 	

	PATTERNS_GENERIC_STAGE2 = {
		{ pattern = "저항",	 	effect = "RES" },	
		{ pattern = "피해", 		effect = "DMG" },
		{ pattern = "주문 공격력",	effect = "DMG" },
		{ pattern = "공격력", 		effect = "DMG" }
	}; 	

	-- finally if we got no match, we match against some special enchantment patterns.
	PATTERNS_OTHER = {
		{ pattern = "Mana Regen (%d+) per 5 sec%.", effect = "MANAREG" },
		
		{ pattern = "최하급 마술사 오일", effect = {"DMG", "HEAL"}, value = 8 },
		{ pattern = "하급 마술사 오일", effect = {"DMG", "HEAL"}, value = 16 },
		{ pattern = "마술사 오일", effect = {"DMG", "HEAL"}, value = 24 },
		{ pattern = "반짝이는 마술사 오일", effect = {"DMG", "HEAL", "SPELLCRIT"}, value = {36, 36, 1} },

		{ pattern = "최하급 마나 오일", effect = "MANAREG", value = 4 },
		{ pattern = "하급 마나 오일", effect = "MANAREG", value = 8 },
		{ pattern = "반짝이는 마나 오일", effect = { "MANAREG", "HEAL"}, value = {12, 25} },
		
		{ pattern = "Eternium Line", effect = "FISHING", value = 5 }, 
		
		{ pattern = "Healing %+31 and 5 mana per 5 sec%.", effect = { "MANAREG", "HEAL"}, value = {5, 31} },
		{ pattern = "Stamina %+16 and Armor %+100", effect = { "STA", "ARMOR"}, value = {16, 100} },
		{ pattern = "Attack Power %+26 and %+1%% Critical Strike", effect = { "ATTACKPOWER", "CRIT"}, value = {26, 1} },
		{ pattern = "Spell Damage %+15 and %+1%% Spell Critical Strike", effect = { "DMG", "HEAL", "SPELLCRIT"}, value = {15, 15, 1} },

	}
} end)
