local Arenas = DBM:NewBossMod("Arenas", DBM_ARENAS, DBM_ARENAS_DESCRIPTION, DBM_OTHER, "Battlegrounds", 3);

Arenas.Version = "2.0";
Arenas.Author = "Tandanu";
Arenas.ExtraGUITab	= "BC Battlegrounds";

Arenas:RegisterEvents("CHAT_MSG_BG_SYSTEM_NEUTRAL");

Arenas.DropdownMenu = { --I don't use :AddOption() here, because I want to use the battleground boss mod's options table
	{
		variable = "DBM.AddOns.Battlegrounds.Options.ShowInviteTimer", 
		text = DBM_BGMOD_LANG.SHOW_INV_TIMER, 
		func = function() DBM.AddOns.Battlegrounds.Options.ShowInviteTimer = not DBM.AddOns.Battlegrounds.Options.ShowInviteTimer; end, 
	},
	
	{
		variable = "DBM.AddOns.Battlegrounds.Options.ColorByClass", 
		text = DBM_BGMOD_LANG.COLOR_BY_CLASS, 
		func = function() DBM.AddOns.Battlegrounds.Options.ColorByClass = not DBM.AddOns.Battlegrounds.Options.ColorByClass; end, 
	},
};


function Arenas:OnEvent()
	if event == "CHAT_MSG_BG_SYSTEM_NEUTRAL" then
		if arg1 == DBM_BGMOD_LANG.ARENA_BEGIN then
			self:StartStatusBarTimer(62, "Begins", nil, true);
			
		elseif arg1 == DBM_BGMOD_LANG.ARENA_BEGIN30 then
			if not self:GetStatusBarTimerTimeLeft("Begins") then
				self:StartStatusBarTimer(62, "Begins", nil, true);
			end
			self:UpdateStatusBarTimer("Begins", 31, 62);
			
		elseif arg1 == DBM_BGMOD_LANG.ARENA_BEGIN15 then
			if not self:GetStatusBarTimerTimeLeft("Begins") then
				self:StartStatusBarTimer(62, "Begins", nil, true);
			end
			self:UpdateStatusBarTimer("Begins", 46, 62);
		end
	end
end