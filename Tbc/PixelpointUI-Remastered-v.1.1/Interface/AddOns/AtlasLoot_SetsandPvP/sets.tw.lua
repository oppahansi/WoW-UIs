-- AtlasLoot loot tables zhTW locale file
-- NOTE: THIS FILE IS AUTO-GENERATED BY A TOOL, ANY MANUALLY CHANGE MIGHT BE OVERWRITTEN.
-- $Id: sets.tw.lua 79089 2008-07-25 01:25:00Z kurax $

if GetLocale() == "zhTW" then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootSetItems"][category] or #AtlasLoot_Data["AtlasLootSetItems"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootSetItems"][category][i][3] = data[i] end end data = nil end

end