local L = AceLibrary("AceLocale-2.2"):new("GhostPulse")

L:RegisterTranslations("koKR", function() return {
	-- Core.lua
	["Console-Slash-Commands"] = { "/cdp" },
	["GUI-Slash-Commands"] = { "/gp", "/ghostpulse" },
	
	["Ghost: Pulse 2"] = "Ghost: Pulse 2",
	["Pulses stuff on-screen."] = "화면에 맥박 효과",
	["You will need to reload the interface to reflect this change."] = "변경사항을 반영하기 위하여 ui리로드가 필요합니다.",
	
	["Locked"] = "잠금",
	["Locks frames in place so they can't be moved around."] = "이동이 안되게 프레임을 잠급니다.",
	
	["Allow Shared Frames"] = "프레임 공유 허용",
	["Remove Shared Frames"] = "공유 프레임 삭제",
	
	["Use Shared Media"] = "Shared Media 사용",
	
	["Frames"] = "프레임",
	["Create and configure frames to show alerts."] = "경고 표시의 생성과 프레임 설정을 합니다.",
	
	["Skinning"] = "Skinning",
	["Texture"] = "텍스쳐",
	["<name of texture>"] = "<텍스쳐 이름>",
	["Alpha"] = "투명도",
	["Scale"] = "크기",
	["Default"] = "기본값",
	
	["Reset to Defaults"] = "기본값으로 초기화",
	
	["<name of thing>"] = "<이름>",
	["<template>"] = "<템플릿>",
	
	["Add"] = "추가",
	["Enter a name for the new frame."] = "새로운 프레임의 이름을 입력하세요.",
	["<name of frame>"] = "<프레임의 이름>",
	
	["Alerts"] = "경고",
	["Contains the options for the different alerts you can set up."] = "별개의 경고를 설정 할수있으며, 옵션에 포함합니다.",
	["In-Combat Only"] = "전투시",
	["While Mounted"] = "탑승시",
	["While Solo"] = "솔잉시",
	["While Dead"] = "죽음시",
	["In Party"] = "파티시",
	["In Raid"] = "공격대시",
	
	["Minimum Cooldown Time"] = "최소 재사용 대기시간",
	["Maximum Cooldown Time"] = "최대 재사용 대기시간",
	["Highlight Color"] = "강조 색상",
	["Show Early Warnings"] = "이른 경고 표시",
	["Early Warning Time"] = "이른 경고 시간",
	["Early Warning Color"] = "이른 경고 색상",
	["Early Warning Text"] = "이른 경고 문자",
	["Alert Text"] = "경고 글자",
	
	["Early Warning Sound"] = "이른 경고 소리",
	["Early Warning Method"] = "이른 경고 방식",
	["<method>"] = "<방식>",
	["Floating Combat Text"] = "유동적인 전투 문자",
	["UIErrorsFrame"] = "UIErrorsFrame",
	["MSBT"] = "MSBT",
	
	["None"] = "없음",
	
	["Specifics"] = "특징",
	["Contains options for configuring specific things."] = "특징적인 설정을 옵션에 포함합니다..",
	["Enter the name of the thing you want specific settings for."] = "당신이 원하는 특징 설정의 이름을 입력하세요.",
	["Sound"] = "소리",
	["<name of sound>"] = "소리 이름",
	["Limit"] = "경계",
	["Enter a numeric limit for %s"] = "%s의 경계 수를 입력하세요.",
	["<limit>"] = "<경계>",
	
	["'%s' added to the whitelist for alert '%s'."] = "'%$2s' 경고의 화이트 리스트에 '%$1s' 추가 하였습니다.",
	["'%s' removed from the whitelist for alert '%s'."] = "'%$2s' 경고의 화이트 리스트에 '%$1s' 삭제 하였습니다.",
	["Showing the whitelist for alert '%s'..."] = "'%s' 경고의 화이트 리스트에 표시...",
	["Whitelist cleared for alert '%s'."] = "'%s' 경고의 화이트 리스트를 제거 하였습니다.",

	["'%s' added to the blacklist for alert '%s'."] = "'%$2s' 경고의 블랙 리스트에 '%$1s' 추가 하였습니다.",
	["'%s' removed from the blacklist for alert '%s'."] = "'%$2s' 경고의 블랙 리스트에 '%$1s' 삭제 하였습니다.",
	["Showing the blacklist for alert '%s'..."] = "'%s' 경고의 블랙 리스트에 표시...",
	["Blacklist cleared for alert '%s'."] = "'%s' 경고의 블랙 리스트를 제거 하였습니다.",

	["Options for %s"] = "%s|1을;를; 위한 옵션",
	["Keep"] = "유지",
	["Share Frame with Group"] = "그룹과 프레임 공유",
	
	["Size"] = "크기",
	["Show Text"] = "글자 보기",
	["Font Scale"] = "글꼴 크기",

	["Fade-in Time"] = "나타나는 시간",
	["Hold Time"] = "고정 시간",
	["Fade-out Time"] = "사라지는 시간",
	
	["Override Sound"] = "오버라이드 사운드",
	["If specified, this sound will play for all alerts shown in this frame instead of the alert-specific sound.  The general 'Sounds' options can override this, however."] = "특정적인 사용시, 모든 경고 표시 프레임에 경고-특정 소리를 재생 합니다.  일반적인 '소리' 설정에 오버라이드 할수 있습니다.",

	["Whitelist"] = "화이트 리스트",
	["'%s' added to the whitelist for frame '%s'."] = "'%$2s' 프레임의 화이트 리스트에 '%$1s' 추가 하였습니다.",
	["'%s' removed from the whitelist for frame '%s'."] = "'%$2s' 프레임의 화이트 리스트에 '%$1s' 삭제 하였습니다.",
	["List"] = "목록",
	["Showing the whitelist for frame '%s'..."] = "'%s' 프레임의 화이트 리스트에 표시...",
	["*** Empty ***"] = "*** 빈 공간 ***",
	["Clear"] = "제거",
	["Whitelist cleared for frame '%s'."] = "'%s' 프레임의 화이트 리스트를 제거 하였습니다.",
	
	["Blacklist"] = "블랙 리스트",
	["'%s' added to the blacklist for frame '%s'."] = "'%$2s' 프레임의 블랙 리스트에 '%$1s' 추가 하였습니다.",
	["'%s' removed from the blacklist for frame '%s'."] = "'%$2s' 프레임의 블랙 리스트에 '%$1s' 삭제 하였습니다.",
	["Showing the blacklist for frame '%s'..."] = "'%s' 프레임의 블랙 리스트에 표시...",
	["Blacklist cleared for frame '%s'."] = "'%s' 프레임의 블랙 리스트를 제거 하였습니다.",

	["Remove"] = "삭제",
	["Removes the frame."] = "프레임 삭제",

	-- Engine.lua
	["[Name] is ready soon"] = "[Name] 곧 준비",
	
	-- Events.lua
	["%s shared a frame with you."] = "%s 프레임 공유.",
	["%s tried to share a frame with you, but you are not allowing shared frames."] = "%s 프레임 공유를 시도하였으나 프레임 공유를 할수 없습니다.",
	
	-- AuraWatcher.lua
	["Player Buff Gains"] = "플레이어 버프 획득",
	["Player Buff Fades"] = "플레이어 버프 사라짐",
	["Player Debuff Gains"] = "플레이어 디버프 걸림",
	["Player Debuff Fades"] = "플레이어 디버프 사라짐",
	
	-- BagsWatcher.lua
	["Bag Item Cooldowns"] = "가방 아이템 재사용 대기시간",
	
	-- CCExpiryWatcher.lua
	["CC Expiry (Target)"] = "군중제어 종료 (대상)",
	["CC Expiry (Focus)"] = "군중제어 종료 (주시대상)",
	
	-- DecurseWatcher.lua
	["Decurse - Magic"] = "디버프 - 마법",
	["Decurse - Curse"] = "디버프 - 저주",
	["Decurse - Poison"] = "디버프 - 독",
	["Decurse - Disease"] = "디버프 - 질병",
	
	-- EnemyCastWatcher.lua
	["Enemy Spell Casts (Target)"] = "적 주문 시전 (대상)",
	["Enemy Spell Casts (Focus)"] = "적 주문 시전 (주시 대상)",
	["Enemy Spell Casts (Bosses)"] = "적 주문 시전 (보스)",
	
	-- LifeTapWatcher.lua
	["Bottled Nethergon Energy"] = "병에 담긴 황천 에너지",
	["The Mechanar"] = "메카나르",
	["The Botanica"] = "신록의 정원",
	["The Arcatraz"] = "알카트라즈",
	["Tempest Keep"] = "폭풍우 요새",
	
	["Cenarion Mana Salve"] = "세나리온 마나 연고",
	["The Steamvault"] = "증기 저장고",
	["The Slave Pens"] = "강제 노역소",
	["Serpentshrine Cavern"] = "불뱀 제단",
	["The Underbog"] = "지하수렁",
	
	["Mana Potion Injector"] = "마나 물약 주사기",
	["Super Mana Potion"] = "특급 마나 물약",
	["Mana Emerald"] = "마나 에메랄드",
	
	["Life Tap/Dark Pact"] = "생명력 전환/암흑의 계약",
	["Mana Potions/Gems"] = "마나 물약/보석",
	["Imp"] = "임프",
	["Dark Pact"] = "암흑의 계약",
	["Life Tap"] = "생명력 전환",
	
	-- MobDebuffWatcher.lua
	["Crowd Control (Target)"] = "군중 제어 (대상)",
	["Crowd Control (Focus)"] = "군중 제어 (주시 대상)",
	["Mob Debuffs (Target)"] = "몹 디버프 (대상)",
	["Mob Debuffs (Focus)"] = "몹 디버프 (주시 대상)",
	
	["Hibernate"] = "겨울잠",
	["Cyclone"] = "회오리바람",
	["Polymorph"] = "변이",
	["Seduction"] = "유혹",
	["Enslave Demon"] = "악마 지배",
	["Howl of Terror"] = "공포의 울부짖음",
	["Banish"] = "추방",
	["Fear"] = "공포",
	["Death Coil"] = "죽음의 고리",
	["Turn Evil"] = "악령 퇴치",
	["Freezing Trap"] = "얼음의 덫",
	["Scatter Shot"] = "산탄 사격",
	["Scare Beast"] = "야수 겁주기",
	["Sap"] = "기절시키기",
	["Blind"] = "실명",
	["Shackle Undead"] = "언데드 속박",
	["Mind Control"] = "정신 지배",

	-- ParryWatcher.lua
	["Riposte"] = "반격",
	["Overpower (Target)"] = "제압 (대상)",
	["Overpower (Focus)"] = "제압 (주시 대상)",

	-- PetWatcher.lua
	["Pet Spell Cooldowns"] = "펫 기술 재사용 대기시간",
	
	-- PlayerDeathWatcher.lua
	["Player Deaths"] = "플레이어 죽음",
	["Player Resurrections"] = "플레이어 부활",
	
	-- SpellWatcher.lua
	["Player Spell Cooldowns"] = "플레이어 주문 재사용 대기시간",
	["Player Spell Casts"] = "플레이어 주문 시전",
	["Player Spell Resists"] = "플레이어 주문 저항",
	["Player Spell Immunity"] = "플레이어 주문 면역",
	
	-- ThreatGenWatcher.lua
	["Threat Resists (Target)"] = "위협 저항 (대상)",
	["Threat Resists (Focus)"] = "위협 저항 (주시 대상)",
	
	-- TrinkerWatcher.lua
	["Trinket Cooldowns"] = "장신구 재사용 대기시간",
	
} end)
