local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen_AOE", "koKR")
if not L then return end

L["AOE Mode"] = "광역 모드"
L["Indicate target"] = "대상 표시"
L["Indicate focus"] = "주시 표시"
L["Show raid icons"] = "공격대 아이콘 표시"
L["AOE Mode\n|cffffffffShows your threat on all targets|r"] = "광역 모드\n|cffffffff주변에 있는 모든 적들에 대한 자신의 어그로 획득량을 표시합니다.|r"
L["Tank mode"] = "탱커 모드"
L["Show threat relative to #2, and an increased maximum threat"] = "최대 위협과 #2에 관한 위협을 표시합니다."
L["Tank mode maximum threat %"] = "탱커 모드 최대 위협 %"
L["Show up to this threat value, relative to current #2"] = "현재 #2에 관하여 위협 값을 표시합니다."
