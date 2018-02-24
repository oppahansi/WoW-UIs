-- tab size is 4
-- registrations for media from the client itself belongs in LibSharedMedia-3.0

if not SharedMedia then return end
local revision = tonumber(string.sub("$Revision: 76383 $", 12, -3))
SharedMedia.revision = (revision > SharedMedia.revision) and revision or SharedMedia.revision

-- -----
-- BACKGROUND
-- -----
SharedMedia:Register("background", "Moo", [[Interface\Addons\SharedMedia\background\moo.tga]])
SharedMedia:Register("background", "Moo2", [[Interface\Addons\SharedMedia\background\moo2.tga]])
SharedMedia:Register("background", "nBack", [[Interface\Addons\SharedMedia\background\nback.tga]])
SharedMedia:Register("background", "nShadow", [[Interface\Addons\SharedMedia\background\nshadow.tga]])
SharedMedia:Register("background", "Wglass.tga", [[Interface\Addons\SharedMedia\background\Wglass.tga]])
SharedMedia:Register("background", "Melli", [[Interface\Addons\SharedMedia\background\Melli.tga]])
SharedMedia:Register("background", "Ruben", [[Interface\Addons\SharedMedia\background\Ruben.tga]])
SharedMedia:Register("background", "outline", [[Interface\Addons\SharedMedia\background\Outline.tga]])
SharedMedia:Register("background", "litestep", [[Interface\Addons\SharedMedia\background\LiteStep.tga]])
SharedMedia:Register("background", "glamour4", [[Interface\Addons\SharedMedia\background\Glamour4.tga]])

-- -----
--  BORDER
-- ----
SharedMedia:Register("border", "RothSquare", [[Interface\Addons\SharedMedia\border\roth.tga]])

-- -----
--   FONT
-- -----
SharedMedia:Register("font", "Adventure",					[[Interface\Addons\SharedMedia\fonts\Adventure.ttf]])
SharedMedia:Register("font", "ABF",							[[Interface\Addons\SharedMedia\fonts\ABF.ttf]])
SharedMedia:Register("font", "Bazooka",						[[Interface\Addons\SharedMedia\fonts\Bazooka.ttf]])
SharedMedia:Register("font", "BigNoodleTitling",			[[Interface\Addons\SharedMedia\fonts\BigNoodleTitling.ttf]])
SharedMedia:Register("font", "BigNoodleTitling-Oblique",	[[Interface\Addons\SharedMedia\fonts\BigNoodleTitling-Oblique.ttf]])
SharedMedia:Register("font", "BlackChancery",				[[Interface\Addons\SharedMedia\fonts\BlackChancery.ttf]])
SharedMedia:Register("font", "caith",				[[Interface\Addons\SharedMedia\fonts\caith.ttf]])
SharedMedia:Register("font", "Diablo",						[[Interface\Addons\SharedMedia\fonts\Avqest.ttf]])
SharedMedia:Register("font", "Emblem",						[[Interface\Addons\SharedMedia\fonts\Emblem.ttf]])
SharedMedia:Register("font", "Enigma",						[[Interface\Addons\SharedMedia\fonts\Enigma__2.ttf]])
SharedMedia:Register("font", "Movie Poster",				[[Interface\Addons\SharedMedia\fonts\Movie_Poster-Bold.ttf]])
SharedMedia:Register("font", "Porky's",						[[Interface\Addons\SharedMedia\fonts\Porky.ttf]])
SharedMedia:Register("font", "RM Midserif",					[[Interface\Addons\SharedMedia\fonts\rm_midse.ttf]])
SharedMedia:Register("font", "Tangerine",					[[Interface\Addons\SharedMedia\fonts\Tangerin.ttf]])
SharedMedia:Register("font", "TwCenMT",						[[Interface\Addons\SharedMedia\fonts\Tw_Cen_MT_Bold.ttf]])
SharedMedia:Register("font", "Ultima Campagnoli",			[[Interface\Addons\SharedMedia\fonts\Ultima_Campagnoli.ttf]])
SharedMedia:Register("font", "Vera Serif",					[[Interface\Addons\SharedMedia\fonts\VeraSe.ttf]])
SharedMedia:Register("font", "Yellowjacket",				[[Interface\Addons\SharedMedia\fonts\Yellowjacket.ttf]])
-- -----
--   SOUND
-- -----

-- -----
--   STATUSBAR
-- -----
SharedMedia:Register("statusbar", "Aluminium",			[[Interface\Addons\SharedMedia\statusbar\Aluminium]])
SharedMedia:Register("statusbar", "Armory",				[[Interface\Addons\SharedMedia\statusbar\Armory]])
SharedMedia:Register("statusbar", "BantoBar",			[[Interface\Addons\SharedMedia\statusbar\BantoBar]])
SharedMedia:Register("statusbar", "Bars",				[[Interface\Addons\SharedMedia\statusbar\Bars]])
SharedMedia:Register("statusbar", "Bumps",				[[Interface\Addons\SharedMedia\statusbar\Bumps]])
SharedMedia:Register("statusbar", "Button",				[[Interface\Addons\SharedMedia\statusbar\Button]])
SharedMedia:Register("statusbar", "Charcoal",			[[Interface\Addons\SharedMedia\statusbar\Charcoal]])
SharedMedia:Register("statusbar", "Cilo",				[[Interface\Addons\SharedMedia\statusbar\Cilo]])
SharedMedia:Register("statusbar", "Cloud",				[[Interface\Addons\SharedMedia\statusbar\Cloud]])
SharedMedia:Register("statusbar", "Comet",				[[Interface\Addons\SharedMedia\statusbar\Comet]])
SharedMedia:Register("statusbar", "Dabs",				[[Interface\Addons\SharedMedia\statusbar\Dabs]])
SharedMedia:Register("statusbar", "DarkBottom",			[[Interface\Addons\SharedMedia\statusbar\DarkBottom]])
SharedMedia:Register("statusbar", "Diagonal",			[[Interface\Addons\SharedMedia\statusbar\Diagonal]])
SharedMedia:Register("statusbar", "Empty",			    [[Interface\Addons\SharedMedia\statusbar\Empty]])
SharedMedia:Register("statusbar", "Falumn",				[[Interface\Addons\SharedMedia\statusbar\Falumn]])
SharedMedia:Register("statusbar", "Fifths",				[[Interface\Addons\SharedMedia\statusbar\Fifths]])
SharedMedia:Register("statusbar", "Flat",				[[Interface\Addons\SharedMedia\statusbar\Flat]])
SharedMedia:Register("statusbar", "Fourths",			[[Interface\Addons\SharedMedia\statusbar\Fourths]])
SharedMedia:Register("statusbar", "Frost",				[[Interface\Addons\SharedMedia\statusbar\Frost]])
SharedMedia:Register("statusbar", "Glamour",			[[Interface\Addons\SharedMedia\statusbar\Glamour]])
SharedMedia:Register("statusbar", "Glamour2",			[[Interface\Addons\SharedMedia\statusbar\Glamour2]])
SharedMedia:Register("statusbar", "Glamour3",			[[Interface\Addons\SharedMedia\statusbar\Glamour3]])
SharedMedia:Register("statusbar", "Glamour4",			[[Interface\Addons\SharedMedia\statusbar\Glamour4]])
SharedMedia:Register("statusbar", "Glamour5",			[[Interface\Addons\SharedMedia\statusbar\Glamour5]])
SharedMedia:Register("statusbar", "Glamour6",			[[Interface\Addons\SharedMedia\statusbar\Glamour6]])
SharedMedia:Register("statusbar", "Glamour7",			[[Interface\Addons\SharedMedia\statusbar\Glamour7]])
SharedMedia:Register("statusbar", "Glass",				[[Interface\Addons\SharedMedia\statusbar\Glass]])
SharedMedia:Register("statusbar", "Glaze",				[[Interface\Addons\SharedMedia\statusbar\Glaze]])
SharedMedia:Register("statusbar", "Glaze v2",			[[Interface\Addons\SharedMedia\statusbar\Glaze2]])
SharedMedia:Register("statusbar", "Gloss",				[[Interface\Addons\SharedMedia\statusbar\Gloss]])
SharedMedia:Register("statusbar", "Graphite",			[[Interface\Addons\SharedMedia\statusbar\Graphite]])
SharedMedia:Register("statusbar", "Grid",				[[Interface\Addons\SharedMedia\statusbar\Grid]])
SharedMedia:Register("statusbar", "Hatched",			[[Interface\Addons\SharedMedia\statusbar\Hatched]])
SharedMedia:Register("statusbar", "Healbot",			[[Interface\Addons\SharedMedia\statusbar\Healbot]])
SharedMedia:Register("statusbar", "Lyfe",				[[Interface\Addons\SharedMedia\statusbar\Lyfe]])
SharedMedia:Register("statusbar", "LiteStep",			[[Interface\Addons\SharedMedia\statusbar\LiteStep]])
SharedMedia:Register("statusbar", "LiteStepLite",		[[Interface\Addons\SharedMedia\statusbar\LiteStepLite]])
SharedMedia:Register("statusbar", "Melli",				[[Interface\Addons\SharedMedia\statusbar\Melli]])
SharedMedia:Register("statusbar", "Melli Dark",			[[Interface\Addons\SharedMedia\statusbar\MelliDark]])
SharedMedia:Register("statusbar", "Melli Dark Rough",	[[Interface\Addons\SharedMedia\statusbar\MelliDarkRough]])
SharedMedia:Register("statusbar", "Minimalist",			[[Interface\Addons\SharedMedia\statusbar\Minimalist]])
SharedMedia:Register("statusbar", "Otravi",				[[Interface\Addons\SharedMedia\statusbar\Otravi]])
SharedMedia:Register("statusbar", "Outline",			[[Interface\Addons\SharedMedia\statusbar\Outline]])
SharedMedia:Register("statusbar", "Perl",				[[Interface\Addons\SharedMedia\statusbar\Perl]])
SharedMedia:Register("statusbar", "Perl v2",			[[Interface\Addons\SharedMedia\statusbar\Perl2]])
SharedMedia:Register("statusbar", "Pill",				[[Interface\Addons\SharedMedia\statusbar\Pill]])
SharedMedia:Register("statusbar", "Rain",				[[Interface\Addons\SharedMedia\statusbar\Rain]])
SharedMedia:Register("statusbar", "Rocks",				[[Interface\Addons\SharedMedia\statusbar\Rocks]])
SharedMedia:Register("statusbar", "Round",				[[Interface\Addons\SharedMedia\statusbar\Round]])
SharedMedia:Register("statusbar", "Ruben",				[[Interface\Addons\SharedMedia\statusbar\Ruben]])
SharedMedia:Register("statusbar", "Runes",				[[Interface\Addons\SharedMedia\statusbar\Runes]])
SharedMedia:Register("statusbar", "Skewed",				[[Interface\Addons\SharedMedia\statusbar\Skewed]])
SharedMedia:Register("statusbar", "Smooth",				[[Interface\Addons\SharedMedia\statusbar\Smooth]])
SharedMedia:Register("statusbar", "Smooth v2",			[[Interface\Addons\SharedMedia\statusbar\Smoothv2]])
SharedMedia:Register("statusbar", "Smudge",				[[Interface\Addons\SharedMedia\statusbar\Smudge]])
SharedMedia:Register("statusbar", "Steel",				[[Interface\Addons\SharedMedia\statusbar\Steel]])
SharedMedia:Register("statusbar", "Striped",			[[Interface\Addons\SharedMedia\statusbar\Striped]])
SharedMedia:Register("statusbar", "Tube",				[[Interface\Addons\SharedMedia\statusbar\Tube]])
SharedMedia:Register("statusbar", "Water",				[[Interface\Addons\SharedMedia\statusbar\Water]])
SharedMedia:Register("statusbar", "Wglass",				[[Interface\Addons\SharedMedia\statusbar\Wglass]])
SharedMedia:Register("statusbar", "Wisps",				[[Interface\Addons\SharedMedia\statusbar\Wisps]])
SharedMedia:Register("statusbar", "Xeon",				[[Interface\Addons\SharedMedia\statusbar\Xeon]])
