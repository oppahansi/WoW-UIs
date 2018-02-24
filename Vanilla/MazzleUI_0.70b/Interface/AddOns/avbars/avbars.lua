--[[
  ****************************************************************
	AVBars
	A simple UI mod which creates graphical timer bars for various events in alterac valley and arathi basin
	
	Written by Ogdin of the Deathreaver Legion - Shadow Moon
	http://www.atlantic-orcs.org/

	do /avbars in game to report the timers to BG chat

	Thanks to Keadrish for the German Localization
	Thanks to Wiser for the French Localization
	****************************************************************]]


-------------------------------------------------------
function gvalley_Initialize()

	
	T1Width=1
	GVTInit={}
	GVTTarget={}
	GV_active_timers={}
	GV_Faction={}

	GVLocale={}
	GVLocale["HASASSAULTED"]="has assaulted"
	GVLocale["CLAIMSTHE"]="claims the"
	GVLocale["HASDEFENDEDTHE"]="has defended the"
	GVLocale["HASTAKENTHE"]="has taken the"
	GVLocale["UNDERATTACK"]="under attack"
	GVLocale["BYTHE"]="by the"
	GVLocale["ALLIANCE"]="Alliance"
	GVLocale["HORDE"]="Horde"
	GVLocale["IVUS"]="wicked"
	GVLocale["IVUSNAME"]="Ivus the Forest Lord"
	GVLocale["IVUSTXT"]="Ivus Begins Moving"
	GVLocale["ICEY"]="WHO DARES SUMMON LOKHOLAR"
	GVLocale["ICEYTXT"]="Lokholar Begins Moving"
	GVLocale["1MIN"]="1 minute"
	GVLocale["30SEC"]="30 seconds"
	GVLocale["BEGINS"]="Game Starts"
		
	GAV_Objectives={"Stormpike Aid Station","Dun Baldar North Bunker","Dun Baldar South Bunker","Stormpike Graveyard","Icewing Bunker",
			"Stonehearth Graveyard","Stonehearth Bunker","Snowfall Graveyard","Iceblood Tower","Iceblood Graveyard","Tower Point",
			"Frostwolf Graveyard","West Frostwolf Tower","East Frostwolf Tower","Frostwolf Relief Hut"}

	GAB_Objectives={"farm","lumber mill","blacksmith","mine","stables"}

--GERMAN
	if (GetLocale()=="deDE") then
		GVLocale["HASASSAULTED"]="angegriffen"
		GVLocale["CLAIMSTHE"]="besetzt"
		GVLocale["HASDEFENDEDTHE"]="verteidigt"
		GVLocale["HASTAKENTHE"]="eingenommen"
		GVLocale["UNDERATTACK"]="angegriffen"
		GVLocale["BYTHE"]="von"
		GVLocale["ALLIANCE"]="Allianz"
		GVLocale["HORDE"]="Horde"
		GVLocale["IVUS"]="xxxxxxxxxxxxxxx"
		GVLocale["IVUSNAME"]="xxxxxxxxxxxxx"
		GVLocale["IVUSTXT"]="xxxxxxxxxxxxxxx"
		GVLocale["ICEY"]="xxxxxxxxxxxxxxx"
		GVLocale["ICEYTXT"]="xxxxxxxxxxxxxxx"
		GVLocale["1MIN"]="xxxxxxxxxxxxxxx"
		GVLocale["30SEC"]="xxxxxxxxxxxx"
		GVLocale["BEGINS"]="xxxxxxxxxxxx"
		
		GAV_Objectives={"Stormpike.Lazarett","Nordbunker von Dun Baldar","S\195\188dbunker von Dun Baldar","Stormpike.Friedhof","Icewing.Bunker",
			"Stonehearth.Friedhof","Stonehearth.Bunker","Snowfall.Friedhof","Iceblood.Turm","Iceblood.Friedhof","Turmstellung",
			"Friedhof der Frostwolf","westliche Frostwolfturm","\195\182stliche Frostwolfturm","H\195\188tte der Heiler"}

		GAB_Objectives={"Hof","S\195\164gewerk","Schmiede","Mine","St\195\164lle"}

--FRENCH
	elseif (GetLocale()=="frFR") then
		GVLocale["HASASSAULTED"]="a attaqu\195\169"
		GVLocale["CLAIMSTHE"]="a pris"
		GVLocale["HASDEFENDEDTHE"]="a d\195\169fendu"
		GVLocale["HASTAKENTHE"]="s'est empar\195\169"
		GVLocale["UNDERATTACK"]="est attaqu\195\169"
		GVLocale["BYTHE"]="par"
		GVLocale["ALLIANCE"]="Alliance"
		GVLocale["HORDE"]="Horde"
		GVLocale["IVUS"]="xxxxxxxxxxxxxxx"
		GVLocale["IVUSNAME"]="xxxxxxxxxxxxx"
		GVLocale["IVUSTXT"]="xxxxxxxxxxxxxxx"
		GVLocale["ICEY"]="xxxxxxxxxxxxxxx"
		GVLocale["ICEYTXT"]="xxxxxxxxxxxxxxx"
		GVLocale["1MIN"]="XXXXXXXXXXXXXXX"
		GVLocale["30SEC"]="XXXXXXXXXXXXXX"
		GVLocale["BEGINS"]="XXXXXXXXXXXXX"

		GAV_Objectives={"poste de secours Stormpike","fortin nord de Dun Baldar","fortin sud de Dun Baldar","cimeti\195\168re Stormpike","fortin de l'aile de glace",
			"cimeti\195\168re de Stonehearth","fortin de Stoneheart","cimeti\195\168re des Neiges","tour de Glace.sang","cimeti\195\168re de Glace.sang","tour de la Halte",
			"cimeti\195\168re Frostwolf","tour Frostwolf occidentale","tour Frostwolf orientale","Hutte de gu\195\169rison Frostwolf"}

		GAB_Objectives={"ferme","scierie","forge","mine"," \195\169tables"}

	elseif (GetLocale()=="zhCN") then
		GVLocale["HASASSAULTED"]="\230\148\187\229\141\160\228\186\134"
		GVLocale["CLAIMSTHE"]="\231\170\129\232\162\173\228\186\134"
		GVLocale["HASDEFENDEDTHE"]="\229\183\178\228\191\157\229\141\171"
		GVLocale["HASTAKENTHE"]="\229\141\160\233\162\134\228\186\134"
		GVLocale["UNDERATTACK"]="\229\143\151\229\136\176\230\148\187\229\135\187"
		GVLocale["BYTHE"]="\232\162\171"
		GVLocale["ALLIANCE"]="\232\129\148\231\155\159"
		GVLocale["HORDE"]="\233\131\168\232\144\189"
		GVLocale["IVUS"]="\233\130\170\230\129\182"
		GVLocale["IVUSNAME"]="\230\163\174\230\158\151\228\185\139\231\142\139\228\188\138\229\188\151\230\150\175"
		GVLocale["IVUSTXT"]="\230\163\174\230\158\151\228\185\139\231\142\139\228\188\138\229\188\151\230\150\175\229\188\128\229\167\139\231\167\187\229\138\168"
		GVLocale["ICEY"]="\232\176\129\232\131\134\230\149\162\229\143\172\229\148\164\229\134\176\233\155\170\228\185\139\231\142\139\230\180\155\229\133\139\233\156\141\230\139\137"
		GVLocale["ICEYTXT"]="\229\134\176\233\155\170\228\185\139\231\142\139\230\180\155\229\133\139\233\156\141\230\139\137\229\188\128\229\167\139\231\167\187\229\138\168"
		GVLocale["1MIN"]="1 \229\136\134\233\146\159"
		GVLocale["30SEC"]="30 \231\167\146"
		GVLocale["BEGINS"]="\230\136\152\230\150\151\229\188\128\229\167\139"
		
		GAV_Objectives={"\233\155\183\231\159\155\230\149\145\230\143\180\231\171\153","\228\184\185\229\183\180\232\190\190\229\176\148\229\140\151\233\131\168\231\162\137\229\160\161","\228\184\185\229\183\180\232\190\190\229\176\148\229\141\151\233\131\168\231\162\137\229\160\161","\233\155\183\231\159\155\229\162\147\229\156\176","\229\134\176\231\191\188\231\162\137\229\160\161",
				"\231\159\179\231\130\137\229\162\147\229\156\176","\231\159\179\231\130\137\231\162\137\229\160\161","\232\144\189\233\155\170\229\162\147\229\156\176","\229\134\176\232\161\128\229\147\168\229\161\148","\229\134\176\232\161\128\229\162\147\229\156\176","\229\147\168\229\161\148\233\171\152\229\156\176",
				"\233\156\156\231\139\188\229\162\147\229\156\176","\232\165\191\228\190\167\233\156\156\231\139\188\229\147\168\229\161\148","\228\184\156\233\131\168\233\156\156\231\139\188\229\147\168\229\161\148","\233\156\156\231\139\188\230\149\145\230\181\142\230\137\128"}

		GAB_Objectives={"\229\134\156\229\156\186","\228\188\144\230\156\168\229\156\186","\233\147\129\229\140\160\233\147\186","\233\135\145\231\159\191","\229\133\189\230\160\143"}


	elseif (GetLocale()=="zhTW") then
		GVLocale["HASASSAULTED"]="\230\148\187\229\141\160\228\186\134"
		GVLocale["CLAIMSTHE"]="\231\170\129\232\162\173\228\186\134"
		GVLocale["HASDEFENDEDTHE"]="\229\183\178\228\191\157\232\161\155"
		GVLocale["HASTAKENTHE"]="\229\183\178\233\135\135\229\143\150"
		GVLocale["UNDERATTACK"]="\229\143\151\229\136\176\230\148\187\230\147\138"
		GVLocale["BYTHE"]="\232\162\171"
		GVLocale["ALLIANCE"]="\232\129\175\231\155\159"
		GVLocale["HORDE"]="\233\131\168\232\144\189"
		GVLocale["IVUS"]="\233\130\170\230\131\161, \230\131\161\229\138\163\231\154\132, \229\135\161\228\186\186! \230\163\174\230\158\151\229\156\168\229\147\173\230\179\163"
		GVLocale["IVUSNAME"]="\230\163\174\230\158\151\228\185\139\231\142\139\228\188\138\229\188\151\230\150\175"
		GVLocale["IVUSTXT"]="\230\163\174\230\158\151\228\185\139\231\142\139\228\188\138\229\188\151\230\150\175\233\150\139\229\167\139\231\167\187\229\139\149"
		GVLocale["ICEY"]="\232\170\176\232\134\189\230\149\162\229\143\172\229\150\154\229\134\176\233\155\170\228\185\139\231\142\139\230\180\155\229\133\139\233\156\141\230\139\137"
		GVLocale["ICEYTXT"]="\229\134\176\233\155\170\228\185\139\231\142\139\230\180\155\229\133\139\233\156\141\230\139\137\233\150\139\229\167\139\231\167\187\229\139\149"
		GVLocale["1MIN"]="1\229\136\134\233\144\152"
		GVLocale["30SEC"]="30\231\167\146"
		GVLocale["BEGINS"]="\230\136\176\233\172\165\233\150\139\229\167\139"
		
		GAV_Objectives={"\233\155\183\231\159\155\230\128\165\230\149\145\231\171\153","\228\184\185\229\183\180\233\129\148\231\136\190\229\140\151\233\131\168\231\162\137\229\160\161","\228\184\185\229\183\180\233\129\148\231\136\190\229\141\151\233\131\168\231\162\137\229\160\161","\233\155\183\231\159\155\229\162\147\229\156\176","\229\134\176\231\191\188\231\162\137\229\160\161",
				"\231\159\179\231\136\144\229\162\147\229\156\176","\231\159\179\231\136\144\231\162\137\229\160\161","\232\144\189\233\155\170\229\162\147\229\156\176","\229\134\176\232\161\128\229\147\168\229\161\148","\229\134\176\232\161\128\229\162\147\229\156\176","\229\147\168\229\161\148\233\171\152\229\156\176",
				"\233\156\156\231\139\188\229\162\147\229\156\176","\232\165\191\233\131\168\233\156\156\231\139\188\229\147\168\229\161\148","\230\157\177\233\131\168\233\156\156\231\139\188\229\147\168\229\161\148","\233\156\156\231\139\188\230\128\165\230\149\145\231\171\153"}

		GAB_Objectives={"\232\190\178\231\148\176","\228\188\144\230\156\168\229\160\180","\233\144\181\229\140\160\232\136\150","\233\135\145\231\164\166","\231\141\184\230\172\132"}



	end

	for i=1,15 do
		getglobal("gvalley_Timer"..i):Hide()
		getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.3,.3,.6,1);
		getglobal("gvalley_T"..i.."_Front"):SetVertexColor(0,0,0,.5);
		getglobal("gvalley_T"..i.."_Front"):SetPoint("BOTTOMRIGHT",-150,0);
		getglobal("gvalleyT"..i.."x"):SetJustifyH("LEFT")
		getglobal("gvalleyT"..i.."y"):SetText(GAV_Objectives[i])
		getglobal("gvalleyT"..i.."y"):SetTextColor(1,1,1,1)
		GVTInit[i]=0
		GVTTarget[i]=303
		GV_active_timers[i]=0
		GV_Faction[i]=" "
	end



	gvalley_main:SetScript("OnUpdate",gvalley_timerHandler)
	gvalley_main:Hide()

	--SlashCmdList["AVBARSTEST"] = gvalley_test;
	--SLASH_AVBARSTEST1 = "/avbarstest";

	this:RegisterEvent("PLAYER_ENTERING_WORLD")
	this:RegisterEvent("CHAT_MSG_MONSTER_YELL");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_HORDE");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_ALLIANCE");
	this:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL");

end

function gvalley_test()
	for i=1,15 do
		if GV_active_timers[i]==0 then 
			GV_active_timers[i]=1
			getglobal("gvalleyT"..i.."y"):SetText(GAV_Objectives[i])	
			getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.6,.2,.2,1)
			GVTInit[i]=GetTime()
			GVTTarget[i]=63
			GV_Faction[i]="(Horde) "
			gvalley_main:Show()
			return
		end
	end
end


-------------------------------------------------------
function gvalley_timerHandler()
	GVTNow=GetTime();

	for i=1,15 do
	
		if (GVTInit[i]+GVTTarget[i])>GVTNow then
			getglobal("gvalley_Timer"..i):Show()
			getglobal("gvalley_T"..i.."_Front"):SetPoint("BOTTOMRIGHT",-150*(1-(GVTNow-GVTInit[i])/GVTTarget[i]),0);
				GVRemaining=GVTTarget[i]-math.floor(GVTNow-GVTInit[i]+.5);
				GVMins=math.floor(GVRemaining/60)
				GVSecs=GVRemaining-GVMins*60
			getglobal("gvalleyT"..i.."x"):SetText(string.format("%.0f:%02.0f",GVMins,GVSecs))
		else
			getglobal("gvalley_Timer"..i):Hide()
			--getglobal("gvalley_T"..i.."_Front"):Hide()
			--getglobal("gvalley_T"..i.."_Back"):Hide()
			--getglobal("gvalleyT"..i.."x"):Hide()
			getglobal("gvalleyT"..i.."y"):SetText("")
			GV_active_timers[i]=0
			gvalley_TimerSort()
		end
	end

	for i=1,15 do if GV_active_timers[i]==1 then return end end
	gvalley_main:Hide()   						--if no timers are active, hide the UI
end


----------------------
-- Event Handler
-- this function parses events
function gvalley_OnEvent()
	
	if event=="VARIABLES_LOADED" then gvalley_Initialize() end
	if event=="CHAT_MSG_MONSTER_YELL" then gvalley_CaptureYell() end
	if event=="CHAT_MSG_BG_SYSTEM_ALLIANCE" then gvalley_ABAlliance() end
	if event=="CHAT_MSG_BG_SYSTEM_HORDE" then gvalley_ABHorde() end
	if event=="CHAT_MSG_BG_SYSTEM_NEUTRAL" then gvalley_ABNeutral() end
	if event=="PLAYER_ENTERING_WORLD" then gvalley_reset() end

	--ADD IN A SORT DESCENDING HERE for timers (least time left on top)
	gvalley_TimerSort()

end

function gvalley_AnnounceBG(gINDEX,gbutton)
		if IsShiftKeyDown() then return end
		if gbutton == "LeftButton" then SendChatMessage(GV_Faction[gINDEX]..getglobal("gvalleyT"..gINDEX.."y"):GetText().." - "..getglobal("gvalleyT"..gINDEX.."x"):GetText().." remaining","SAY") end
		if gbutton == "RightButton" then SendChatMessage(GV_Faction[gINDEX]..getglobal("gvalleyT"..gINDEX.."y"):GetText().." - "..getglobal("gvalleyT"..gINDEX.."x"):GetText().." remaining","BATTLEGROUND") end
end

function gvalley_TimerSort()

	--GVTInit[i];
	GVTemp={};   for i=1,15 do GVTemp[i]=GetTime()+1 end

	--Figure out the order of GVTInit
	for i=1,15 do
		for j=1,15 do
			if i==1 and GV_active_timers[j]==1 and GVTInit[j]<GVTemp[i] then GVTemp[i]=GVTInit[j] end
			if i>1 and GV_active_timers[j]==1 and GVTInit[j]<GVTemp[i] and GVTInit[j]>GVTemp[i-1] then GVTemp[i]=GVTInit[j] end
		end
	end


	--Position Them In descending order
	for i=1,15 do
		for j=1,15 do
			if GVTInit[j]==GVTemp[i] then 
				getglobal("gvalley_Timer"..j):SetPoint("TOPLEFT",0,-(i-1)*13)
				break
			end
		end
		
	end


end

function gvalley_ABAlliance()

for index,value in ipairs(GAB_Objectives) do
	if string.find(arg1,value) then
		if string.find(arg1,GVLocale["HASASSAULTED"]) or string.find(arg1,GVLocale["CLAIMSTHE"]) then
			--Initiate a timer w/ value as text string for 60 seconds
			for i=1,15 do if getglobal("gvalleyT"..i.."y"):GetText()==GAB_Objectives[index] then GV_active_timers[i]=0 GVTInit[i]=0 end end
			for i=1,15 do
				if GV_active_timers[i]==0 then 
					GV_active_timers[i]=1
					getglobal("gvalleyT"..i.."y"):SetText(GAB_Objectives[index])	
					getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.2,.2,.6,1)
					GVTInit[i]=GetTime()
					GVTTarget[i]=63
					GV_Faction[i]="(Alliance) "
					gvalley_main:Show()
					return
				end
			end
		elseif string.find(arg1,GVLocale["HASDEFENDEDTHE"]) or string.find(arg1,GVLocale["HASTAKENTHE"]) then
			--clear a timer for value
			for i=1,15 do
				if getglobal("gvalleyT"..i.."y"):GetText()==GAB_Objectives[index] then
					GVTInit[i]=0
					GV_active_timers[i]=0
				end
			end
		end
	end
end

	--Initial capture of Snowfall for alliance
	if string.find(string.lower(arg1),string.lower(GAV_Objectives[8])) then
		for i=1,15 do if getglobal("gvalleyT"..i.."y"):GetText()==GAV_Objectives[8] then GV_active_timers[i]=0 GVTInit[i]=0 end end
		for i=1,15 do
			if GV_active_timers[i]==0 then 
				GV_active_timers[i]=1
				getglobal("gvalleyT"..i.."y"):SetText(GAV_Objectives[8])	
				getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.2,.2,.6,1)
				GVTInit[i]=GetTime()
				GVTTarget[i]=303
				GV_Faction[i]="(Alliance) "
				gvalley_main:Show()
				return
			end
		end
	end

end

function gvalley_ABHorde()


for index,value in ipairs(GAB_Objectives) do
	if string.find(arg1,value) then
		if string.find(arg1,GVLocale["HASASSAULTED"]) or string.find(arg1,GVLocale["CLAIMSTHE"]) then
			--Initiate a timer w/ value as text string for 60 seconds
			for i=1,15 do if getglobal("gvalleyT"..i.."y"):GetText()==GAB_Objectives[index] then GV_active_timers[i]=0 GVTInit[i]=0 end end

			for i=1,15 do
				if GV_active_timers[i]==0 then 
					GV_active_timers[i]=1
					getglobal("gvalleyT"..i.."y"):SetText(GAB_Objectives[index])	
					getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.6,.2,.2,1)
					GVTInit[i]=GetTime()
					GVTTarget[i]=63
					GV_Faction[i]="(Horde) "
					gvalley_main:Show()
					return
				end
			end
		elseif string.find(arg1,GVLocale["HASDEFENDEDTHE"]) or string.find(arg1,GVLocale["HASTAKENTHE"]) then
			--clear a timer for value
			for i=1,15 do
				if getglobal("gvalleyT"..i.."y"):GetText()==GAB_Objectives[index] then
					GVTInit[i]=0
					GV_active_timers[i]=0
				end
			end
		end
	end
end


	--Initial capture of Snowfall for horde
	if string.find(string.lower(arg1),string.lower(GAV_Objectives[8])) then
		for i=1,15 do if getglobal("gvalleyT"..i.."y"):GetText()==GAV_Objectives[8] then GV_active_timers[i]=0 GVTInit[i]=0 end end
		for i=1,15 do
			if GV_active_timers[i]==0 then 
				GV_active_timers[i]=1
				getglobal("gvalleyT"..i.."y"):SetText(GAV_Objectives[8])	
				getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.6,.2,.2,1)
				GVTInit[i]=GetTime()
				GVTTarget[i]=303
				GV_Faction[i]="(Horde) "
				gvalley_main:Show()
				return
			end
		end
	end

end

function gvalley_ABNeutral()

	if string.find(arg1,GVLocale["1MIN"]) then
		for i=1,15 do
			if GV_active_timers[i]==0 then 
				GV_active_timers[i]=1
				getglobal("gvalleyT"..i.."y"):SetText(GVLocale["BEGINS"])	
				getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.46,.23,.04,1)
				GVTInit[i]=GetTime()
				GVTTarget[i]=62
				GV_Faction[i]="(Neutral) "
				gvalley_main:Show()
				return
			end
		end
	elseif string.find(arg1,GVLocale["30SEC"]) then
		for i=1,15 do if getglobal("gvalleyT"..i.."y"):GetText()==GVLocale["BEGINS"] then GVTInit[i]=GetTime()-30 return end end
		for i=1,15 do
			if GV_active_timers[i]==0 then 
				GV_active_timers[i]=1
				getglobal("gvalleyT"..i.."y"):SetText(GVLocale["BEGINS"])	
				getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.46,.23,.04,1)
				GVTInit[i]=GetTime()
				GVTTarget[i]=32
				GV_Faction[i]="(Neutral) "
				gvalley_main:Show()
				return
			end
		end
		
	end

	
	
end

function gvalley_CaptureYell()


for index,value in ipairs(GAV_Objectives) do
	if string.find(string.lower(arg1),string.lower(value)) then
		if string.find(arg1,GVLocale["UNDERATTACK"]) then
			--Initiate a timer w/ value as text string for 300 seconds

			for i=1,15 do
				if GV_active_timers[i]==0 then 
					GV_active_timers[i]=1
					getglobal("gvalleyT"..i.."y"):SetText(value)	
					if string.find(arg1,GVLocale["HORDE"]) then getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.6,.2,.2,1); GV_Faction[i]="(Horde) " end
					if string.find(arg1,GVLocale["ALLIANCE"]) then getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.2,.2,.6,1); GV_Faction[i]="(Alliance) " end					GVTInit[i]=GetTime()
					GVTTarget[i]=303
					gvalley_main:Show()
					return
				end
			end
		elseif string.find(arg1,GVLocale["BYTHE"]) or string.find(arg1,GVLocale["HASTAKENTHE"]) then
			--clear a timer for value
			for i=1,15 do
				if getglobal("gvalleyT"..i.."y"):GetText()==value then
					GVTInit[i]=0
					GV_active_timers[i]=0
				end
			end
		end
	end

end

	if string.find(arg1,GVLocale["IVUS"]) and string.find(arg2,GVLocale["IVUSNAME"]) then 
		for i=1,15 do
			if GV_active_timers[i]==0 then 
				GV_active_timers[i]=1
				getglobal("gvalleyT"..i.."y"):SetText(GVLocale["IVUSTXT"])	
				getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.2,.2,.6,1)
				GVTInit[i]=GetTime()
				GVTTarget[i]=603
				GV_Faction[i]="(Alliance) "
				gvalley_main:Show()
				return
			end
		end
	elseif string.find(string.lower(arg1),string.lower(GVLocale["ICEY"])) then
		for i=1,15 do
			if GV_active_timers[i]==0 then 
				GV_active_timers[i]=1
				getglobal("gvalleyT"..i.."y"):SetText(GVLocale["ICEYTXT"])	
				getglobal("gvalley_T"..i.."_Back"):SetVertexColor(.6,.2,.2,1)
				GVTInit[i]=GetTime()
				GVTTarget[i]=603
				GV_Faction[i]="(Horde) "
				gvalley_main:Show()
				return
			end
		end
	end

end

function gvalley_reset()
	for i=1,15 do GVTInit[i]=0 GV_active_timers[i]=0 end
end