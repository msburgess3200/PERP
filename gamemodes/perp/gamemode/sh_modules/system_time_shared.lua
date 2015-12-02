


TIME_PER_DAY 	= 60 * 60 * 3.5; // 3.5 hours is one cycle.
DAY_LENGTH		= 1440;

DAY_START		= 5 * 60; // 5 am
DAY_END			= 18.5 * 60; // 6:30 pm
DAWN			= DAY_LENGTH / 4;
DAWN_START		= DAWN - 144;
DAWN_END		= DAWN + 144;
NOON			= DAY_LENGTH / 2;
DUSK			= DAY_LENGTH - DAWN;
DUSK_START		= DUSK - 144;
DUSK_END		= DUSK + 144;

local nextTick = CurTime();
local timePerMinute = TIME_PER_DAY / DAY_LENGTH * .5; // <--- TIME_PER_DAY / DAY_LENGTH * .5
MONTH_DAYS = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5};
CLOUD_NAMES = {"Clear Skies", "Partly Cloudy", "Mostly Cloudy [ PRE ]", "Mostly Clouy [ POST ]", "Stormy", "Stormy [ LIGHT ]", "Stormy [ PRE ]", "Stormy [ SEVERE ]", "Heat Wave"};
							 

local function manageTime ( )
	if (!GAMEMODE.CurrentTime || (SERVER && !GAMEMODE.timeEntities.shadow_control) || nextTick > CurTime()) then return; end
	nextTick = nextTick + timePerMinute;
	
	GAMEMODE.CurrentTime = GAMEMODE.CurrentTime + .5;
	if (GAMEMODE.CurrentTime > DAY_LENGTH) then
		GAMEMODE.CurrentTime = .5;
		
		GAMEMODE.CurrentDay = GAMEMODE.CurrentDay + 1;
		
		/*
		if (GAMEMODE.CurrentDay > MONTH_DAYS[GAMEMODE.CurrentMonth]) then
			GAMEMODE.CurrentDay = 1;
			GAMEMODE.CurrentMonth = GAMEMODE.CurrentMonth + 1;
			
			if (GAMEMODE.CurrentMonth > 12) then
				GAMEMODE.CurrentMonth = 1;
				GAMEMODE.CurrentYear = GAMEMODE.CurrentYear + 1;
				// Happy near years
			end
		end
		*/
		
		if SERVER then GAMEMODE.SaveDate(); end
	end
		
	if SERVER then GAMEMODE.progressTime(); end
end
hook.Add("Think", "manageTime", manageTime);

function GM.GetTime ( )
	local perHour = DAY_LENGTH / 24;
	local perMinute = DAY_LENGTH / 1440;
	
	local hours = math.floor(GAMEMODE.CurrentTime / perHour);
	local mins = math.floor(GAMEMODE.CurrentTime / perMinute) - hours * 60;
	
	return hours, mins;
end
