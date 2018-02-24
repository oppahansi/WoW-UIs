-- [[
-- Last Updated: 2/25/2008
-- Initial translation by: 560889223
-- Maintained by: Diablohu
-- http://www.dreamgen.cn
-- ]]

if (GetLocale() == "zhCN") then

	AtlasLootBossNames["AuchAuchenaiCrypts"][1] = "大主教玛拉达尔 (奥金尼地穴)";
	AtlasLootBossNames["AuchAuchenaiCrypts"][2] = "殉难者的化身 (奥金尼地穴)";

	AtlasLootBossNames["AuchShadowLabyrinth"][1] = "煽动者布莱卡特 (暗影迷宫)";

	for i, v in ipairs(AtlasLootBossNames["BlackrockSpireLower"]) do
		AtlasLootBossNames["BlackrockSpireLower"][i] = gsub(v, "%(LBRS%)", "%(黑石塔下%)");
	end
	AtlasLootBossNames["BlackrockSpireLower"][8] = "普通怪物 (黑石塔)";

	for i, v in ipairs(AtlasLootBossNames["BlackrockSpireUpper"]) do
		AtlasLootBossNames["BlackrockSpireUpper"][i] = gsub(v, "%(UBRS%)", "%(黑石塔上%)");
	end

	AtlasLootBossNames["BlackwingLair"][1] = "狂野的拉佐格尔 (黑翼之巢)";
	AtlasLootBossNames["BlackwingLair"][2] = "堕落的瓦拉斯塔兹 (黑翼之巢)";

	AtlasLootBossNames["CFRTheSteamvault"][1] = "水术师瑟丝比娅 (蒸汽地窟)";
	AtlasLootBossNames["CFRTheSteamvault"][2] = "督军卡利瑟里斯 (蒸汽地窟)";

	AtlasLootBossNames["Common"][1] = "普通怪物";

	AtlasLootBossNames["GruulsLair"][2] = "屠龙者格鲁尔 (格鲁尔的巢穴)";

	AtlasLootBossNames["HCBloodFurnace"][1] = "击碎者克里丹 (鲜血熔炉)";

	AtlasLootBossNames["HCShatteredHalls"][1] = "战争使者沃姆罗格 (破碎大厅)";
	AtlasLootBossNames["HCShatteredHalls"][2] = "酋长卡加斯·刃拳 (破碎大厅)";

	AtlasLootBossNames["MoltenCore"][7] = "焚化者古雷曼格 (熔火之心)";

	AtlasLootBossNames["Naxxramas"][6] = "黑女巫法琳娜 (纳克萨玛斯)";
	AtlasLootBossNames["Naxxramas"][8] = "教官拉苏维奥斯 (纳克萨玛斯)";
	AtlasLootBossNames["Naxxramas"][9] = "收割者戈提克 (纳克萨玛斯)";
	AtlasLootBossNames["Naxxramas"][11] = "瘟疫使者诺斯 (纳克萨玛斯)";

	for i, v in ipairs(AtlasLootBossNames["Scholomance"]) do
		AtlasLootBossNames["Scholomance"][i] = gsub(v, "%(Scholo%)", "%(通灵学院%)");
	end
	AtlasLootBossNames["Scholomance"][11] = "普通怪物 (通灵学院)";

	for i, v in ipairs(AtlasLootBossNames["Stratholme"]) do
		AtlasLootBossNames["Stratholme"][i] = gsub(v, "%(Strat%)", "%(斯坦索姆%)");
	end
	AtlasLootBossNames["Stratholme"][13] = "普通怪物 (斯坦索姆)";

	AtlasLootBossNames["TKMechanar"][1] = "计算者帕萨雷恩 (能源舰)";

	AtlasLootBossNames["TKTheArcatraz"][1] = "预言者斯克瑞斯 (禁魔监狱)";

end
