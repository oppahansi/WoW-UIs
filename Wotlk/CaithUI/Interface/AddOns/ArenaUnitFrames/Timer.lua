if ( not ArenaUnitFrames ) then
	return
end
local auf = ArenaUnitFrames;
auf.timer = {};
local timer = auf.timer;

timer.frame = CreateFrame("Frame", "ArenaUnitFramesTimerFrame");
timer.timers = {};

local function TimerUpdate()
	
	local now = GetTime();
	local cleanup;

	-- check for finished timers
	for index, t in ipairs(timer.timers) do
		
		if ( t.endTime < now ) then
			cleanup = true;
			t.endTime = now + 999999999;		-- just in case

			t.func(t.arg1, t.arg2, t.arg3);
			timer.timers[index] = true;
		end
	end

	-- remove finished timers
	if ( cleanup ) then

		local index = 1;
		local t = timer.timers[index];

		while ( t ) do
			if ( type(t) == "boolean" ) then
				table.remove(timer.timers, index);
			else
				index = index + 1;
			end
			t = timer.timers[index];
		end

		if ( #timer.timers == 0 ) then
			timer.frame:Hide();
		end
	end
end

function timer.StartTimer(duration, func, arg1, arg2, arg3)
	table.insert(timer.timers, { endTime = GetTime() + duration, func = func, arg1 = arg1, arg2 = arg2, arg3 = arg3 } );
	timer.frame:Show();
end

function timer.StopTimer(func)

	local index = 1;
	local t = timer.timers[index];

	while ( t ) do
		if ( func == "all" or t.func == func ) then
			table.remove(timer.timers, index);
print(index.." timer removed");
		else
			index = index + 1;
		end
		t = timer.timers[index];
	end

	if ( #timer.timers == 0 ) then
		timer.frame:Hide();
print("no timers left; hiding frame");
	end
end

timer.frame:SetScript("OnUpdate", TimerUpdate);
