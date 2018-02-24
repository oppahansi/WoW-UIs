-- ForteXorcist v1.959.8 by Xus 13-04-2010

local FW = FW;
local CA = FW.Modules.Casting;
local ST = FW.Modules.Timer;
local CD = FW.Modules.Cooldown;
	
if ST then
	-- doesnt use the casting code, but who cares!!

	-- Wyrmrest Skytalon
	ST:RegisterSpell(57090,	1,000,0,FW.HEAL,00,nil,5); -- revivify
		ST:RegisterTickSpeed(57090, 1); -- make this show ticks
		
	ST:RegisterSpell(56092,	1,000,0,FW.DEFAULT,00,nil,5); -- engulf
		ST:RegisterTickSpeed(56092, 3); -- make this show ticks
		
	ST:RegisterSpell(57143,	1,000,0,FW.BUFF,00); -- life burst
		
	ST:RegisterSpell(57108,	1,000,0,FW.BUFF,00); -- flame shield

	ST:RegisterSpell(57092,	1,000,0,FW.PET,00); -- blazing speed
	
	-- Ulduar
	ST:RegisterSpell(62489,	1,000,0,FW.DEFAULT,00,nil,5); -- Blue Pyrite
		ST:RegisterTickSpeed(62489, 1); -- make this show ticks
		
	-- Amber Drake (The Oculus)
	ST:RegisterSpell(49836, 1, 000, 0, FW.DEFAULT); -- Shock Charge

	-- Emerald Drake (The Oculus)
	ST:RegisterSpell(50341, 1, 000, 0, FW.DEFAULT); -- Touch the Nightmare
	ST:RegisterSpell(50328, 1, 000, 0, FW.DEFAULT); -- Leeching Poison
		ST:RegisterTickSpeed(50328, 2); -- change tick speed from 3 to 2

end
