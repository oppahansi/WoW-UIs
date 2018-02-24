-- tab size is 4
-- registrations for media from the client itself belongs into LibSharedMedia-3.0

if not Media then return end
local revision = tonumber(string.sub("$Revision: 63551 $", 12, -3))
Media.revision = (revision > Media.revision) and revision or Media.revision

-- -----
-- BACKGROUND
-- -----
	Media:Register("background", "DarkBottom",				[[Interface\Addons\GrizzlySharedMedia\statusbar\DarkBottom]])
      Media:Register("background", "highlighttex",				[[Interface\Addons\GrizzlySharedMedia\statusbar\highlighttex]])
      Media:Register("background", "normtexa",				[[Interface\Addons\GrizzlySharedMedia\statusbar\normtexa]])
      Media:Register("background", "glowtex",				[[Interface\Addons\GrizzlySharedMedia\statusbar\glowtex]])
      Media:Register("background", "Empty",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Empty]])
      Media:Register("background", "Glamour",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour]])
      Media:Register("background", "Glamour2",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour2]])
      Media:Register("background", "Glamour3",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour3]])
      Media:Register("background", "Glamour4",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour4]])
      Media:Register("background", "Glamour5",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour5]])
      Media:Register("background", "Glamour6",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour6]])
      Media:Register("background", "Glamour7",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour7]])
      Media:Register("background", "Melli",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Melli]])
      Media:Register("background", "MelliDark",				[[Interface\Addons\GrizzlySharedMedia\statusbar\MelliDark]])
      Media:Register("background", "MelliDarkRough",				[[Interface\Addons\GrizzlySharedMedia\statusbar\MelliDarkRough]])
	

-- -----
--  BORDER
-- ----
	Media:Register("border", "Siana", 				
      [[Interface\AddOns\GrizzlySharedMedia\border\Siana]])
	Media:Register("border", "RothSquare", 				[[Interface\AddOns\GrizzlySharedMedia\border\Roth]])
	Media:Register("border", "Caith", 				
      [[Interface\AddOns\GrizzlySharedMedia\border\Caith]])
	Media:Register("border", "HalBorder", 				[[Interface\AddOns\GrizzlySharedMedia\border\HalBorder]])
	Media:Register("border", "krsnik", 				
      [[Interface\AddOns\GrizzlySharedMedia\border\krsnik]])
      Media:Register("border", "Caith2", 				
      [[Interface\AddOns\GrizzlySharedMedia\border\Caith2]])

-- -----
--   STATUSBAR
-- -----
	Media:Register("statusbar", "DarkBottom",				[[Interface\Addons\GrizzlySharedMedia\statusbar\DarkBottom]])
      Media:Register("statusbar", "highlighttex",				[[Interface\Addons\GrizzlySharedMedia\statusbar\highlighttex]])
      Media:Register("statusbar", "normtexa",				[[Interface\Addons\GrizzlySharedMedia\statusbar\normtexa]])
      Media:Register("statusbar", "glowtex",				[[Interface\Addons\GrizzlySharedMedia\statusbar\glowtex]])
      Media:Register("statusbar", "Empty",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Empty]])
      Media:Register("statusbar", "Glamour",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour]])
      Media:Register("statusbar", "Glamour2",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour2]])
      Media:Register("statusbar", "Glamour3",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour3]])
      Media:Register("statusbar", "Glamour4",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour4]])
      Media:Register("statusbar", "Glamour5",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour5]])
      Media:Register("statusbar", "Glamour6",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour6]])
      Media:Register("statusbar", "Glamour7",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Glamour7]])
      Media:Register("statusbar", "Melli",				[[Interface\Addons\GrizzlySharedMedia\statusbar\Melli]])
      Media:Register("statusbar", "MelliDark",				[[Interface\Addons\GrizzlySharedMedia\statusbar\MelliDark]])
      Media:Register("statusbar", "MelliDarkRough",				[[Interface\Addons\GrizzlySharedMedia\statusbar\MelliDarkRough]])
	
-- -----
--   FONT
-- -----
	Media:Register("font", "TinBirdhouse",				
      [[Interface\Addons\GrizzlySharedMedia\fonts\TinBirdhouse.ttf]])
      Media:Register("font", "Accidental Presidency",				[[Interface\Addons\GrizzlySharedMedia\fonts\Accidental Presidency.ttf]])
      Media:Register("font", "neuropol x cd rg",				[[Interface\Addons\GrizzlySharedMedia\fonts\neuropol x cd rg.ttf]])
	