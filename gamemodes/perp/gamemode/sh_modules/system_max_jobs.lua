


GM.MinimumForSWAT = 25;

GM.MaximumCops = 4;
GM.MaximumParamedic = 2;
GM.MaximumFireMen = 2;
GM.MaximumSWAT = 0;
GM.MaximumDispatchers = 1;
GM.MaximumSecretService = 0;
GM.MaximumRoadCrew = 2;
GM.MaximumBusDrivers = 2;
GM.PeopleRequired_Mayor = 0;
	
GM.MaxCopCars = 2
GM.MaxFireTrucks = 1
GM.MaxAmbulances = 1
GM.MaxSWATVans = 0;
GM.MaxStretch = 0;
GM.MaxRoadCrewTrucks = math.Clamp(math.floor(GM.MaximumRoadCrew * .5), 1, 6);
GM.MaxBusses = math.Clamp(math.floor(GM.MaximumBusDrivers * .5), 1, 2);

if SERVER then
	function GM.SendJobInformation ( plOverride )
		umsg.Start("perp2_job_info_1", plOverride)
			umsg.Short(GAMEMODE.MaximumCops)
			umsg.Short(GAMEMODE.MaximumParamedic)
			umsg.Short(GAMEMODE.MaximumFireMen)
			umsg.Short(GAMEMODE.MaximumSWAT)
			umsg.Short(GAMEMODE.MaximumSecretService)
		umsg.End()
		
		timer.Simple(1, GAMEMODE.SendJobInformation2)
	end
	
	function GM.SendJobInformation2 ( plOverride )
		umsg.Start("perp2_job_info_2", plOverride)
			umsg.Short(GAMEMODE.MaxCopCars)
			umsg.Short(GAMEMODE.MaxFireTrucks)
			umsg.Short(GAMEMODE.MaxAmbulances)
			umsg.Short(GAMEMODE.MaxSWATVans)
			umsg.Short(GAMEMODE.MaxStretch)
		umsg.End()
		
		timer.Simple(1, GAMEMODE.SendJobInformation3)
	end
	
	function GM.SendJobInformation3 ( plOverride )
		umsg.Start("perp2_job_info_3", plOverride)
			umsg.Short(GAMEMODE.JobPaydayInfo[TEAM_POLICE][2])
			umsg.Short(GAMEMODE.JobPaydayInfo[TEAM_SWAT][2])
			umsg.Short(GAMEMODE.JobPaydayInfo[TEAM_FIREMAN][2])
			umsg.Short(GAMEMODE.JobPaydayInfo[TEAM_MEDIC][2])
			umsg.Short(GAMEMODE.JobPaydayInfo[TEAM_DISPATCHER][2])
			umsg.Short(GAMEMODE.JobPaydayInfo[TEAM_SECRET_SERVICE][2])
		umsg.End()
	end
	
else
	local function receieveJobInfo1 ( uMsg )
		GAMEMODE.MaximumCops = uMsg:ReadShort()
		GAMEMODE.MaximumParamedic = uMsg:ReadShort()
		GAMEMODE.MaximumFireMen = uMsg:ReadShort()
		GAMEMODE.MaximumSWAT = uMsg:ReadShort()
		GAMEMODE.MaximumSecretService = uMsg:ReadShort()
	end
	
	local function receieveJobInfo2 ( uMsg )
		GAMEMODE.MaxCopCars = uMsg:ReadShort()
		GAMEMODE.MaxFireTrucks = uMsg:ReadShort()
		GAMEMODE.MaxAmbulances = uMsg:ReadShort()
		GAMEMODE.MaxSWATVans = uMsg:ReadShort()
		GAMEMODE.MaxStretch = uMsg:ReadShort()
	end
	
	local function receieveJobInfo3 ( uMsg )
		GAMEMODE.PayDay_Police = uMsg:ReadShort()
		GAMEMODE.PayDay_SWAT = uMsg:ReadShort()
		GAMEMODE.PayDay_Fireman = uMsg:ReadShort()
		GAMEMODE.PayDay_Medic = uMsg:ReadShort()
		GAMEMODE.PayDay_Dispatcher = uMsg:ReadShort()
		GAMEMODE.PayDay_SecretService = uMsg:ReadShort()
	end
	
	usermessage.Hook("perp2_job_info_1", receieveJobInfo1)
	usermessage.Hook("perp2_job_info_2", receieveJobInfo2)
	usermessage.Hook("perp2_job_info_3", receieveJobInfo3)
end

function GM.CalculateMaxJobss ( )
	GAMEMODE.PeopleRequired_Mayor = math.Clamp(math.Round(table.Count(player.GetAll()) / 3), 2, 5);
	GAMEMODE.MaximumRoadCrew = math.Clamp(math.Round(table.Count(player.GetAll()) / 5), 1, 6);
	GAMEMODE.MaximumBusDrivers = math.Clamp(math.Round(table.Count(player.GetAll()) / 5), 1, 2);	
	GAMEMODE.MaxRoadCrewTrucks = math.Clamp(math.floor(GAMEMODE.MaximumRoadCrew * .5), 1, 6);
	GAMEMODE.MaxBusses = GAMEMODE.MaximumBusDrivers
	
	if SERVER then
		if (GAMEMODE.SendJobInfoUpdate) then
			GAMEMODE.SendJobInformation()
			GAMEMODE.SendJobInfoUpdate = nil
		end
	end
end
timer.Create("GM.CalculateMaxJobss", 5, 0, GM.CalculateMaxJobss)
