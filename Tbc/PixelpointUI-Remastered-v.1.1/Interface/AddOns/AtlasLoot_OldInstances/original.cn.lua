-- AtlasLoot loot tables zhCN locale file
-- NOTE: THIS FILE IS AUTO-GENERATED BY A TOOL, ANY MANUALLY CHANGE MIGHT BE OVERWRITTEN.
-- $Id: original.cn.lua 78965 2008-07-23 05:45:22Z kurax $

if GetLocale() == "zhCN" then
local Process = function(category,check,data) if not AtlasLoot_Data["AtlasLootItems"][category] or #AtlasLoot_Data["AtlasLootItems"][category] ~= check then return end for i = 1,#data do if(data[i] and data[i]~="") then AtlasLoot_Data["AtlasLootItems"][category][i][3] = data[i] end end data = nil end

end