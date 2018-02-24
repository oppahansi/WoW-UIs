local AceLocale = LibStub:GetLibrary("AceLocale-3.0")
local L = AceLocale:NewLocale("Omen_Healer", "koKR")
if not L then return end

L["Healer Mode"] = "힐러 모드"
L["Column Spacing"] = "열 간격"

L["Data source"] = "데이터 소스"
L["Get tanks from..."] = "탱커 가져옴..."
L["oRA2 Main Tanks"] = "oRA2 메인 탱커"
L["Blizzard Main Tanks"] = "Blizzard 메인 탱커"
L["Healer Mode\n|cffffffffShows an overview of tank target threat\nTank targets come from oRA2 or the Blizzard tank settings.|r"] = "힐러 모드\n|cffffffff탱커의 대상에 대한 어그로 획득량을 표시합니다.\n탱커 대상은 oRA2나 Blizzard 탱커 설정이 되어 있어야 합니다.|r"