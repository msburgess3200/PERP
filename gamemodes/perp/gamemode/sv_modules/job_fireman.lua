


GM.JobPaydayInfo[TEAM_FIREMAN] = {"as a paycheck for being a firefighter.", 75};

GM.JobEquips[TEAM_FIREMAN] = function ( Player )
	Player:Give("weapon_perp_fire_axe");
	Player:Give("weapon_perp_fire_hose");
	Player:Give("weapon_perp_fire_extinguisher");
end

function GM.Fireman_Join ( Player )
	if (Player:HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_FIREMAN])) then return; end
	if (!Player:NearNPC(12)) then return; end
	if (Player:Team() != TEAM_CITIZEN) then return; end
	if (Player.RunningForMayor) then return; end
	if (Player:GetNetworkedBool("warrent", false)) then return; end
	if (team.NumPlayers(TEAM_FIREMAN) >= GAMEMODE.MaximumFireMen) then return; end
	if (Player:GetTimePlayed() < GAMEMODE.RequiredTime_Fire * 60 * 60 && !Player:IsBronze()) then return end
	
	Player:SetTeam(TEAM_FIREMAN);
	
	Player:RemoveCar();
	for k, v in pairs(player.GetAll()) do
		umsg.Start("removebadid", Player)
			umsg.Short(Player:GetCarUsed());		// Fuel Left
		umsg.End()
	end
	
	GAMEMODE.JobEquips[TEAM_FIREMAN](Player);
	
	Player.JobModel = JOB_MODELS[TEAM_FIREMAN][Player:GetFace()] or JOB_MODELS[TEAM_FIREMAN][1];
	Player:SetModel(Player.JobModel);
	Player:StripMains();
end
concommand.Add("perp_f_j", GM.Fireman_Join);

function GM.Fireman_Quit ( Player )
	if (!Player:NearNPC(12)) then return; end
	GAMEMODE.Fireman_Leave(Player);
end
concommand.Add("perp_f_q", GM.Fireman_Quit);

function GM.Fireman_Leave ( Player )
	Player:SetTeam(TEAM_CITIZEN);
	
	Player:StripWeapon("weapon_perp_fire_axe");
	Player:StripWeapon("weapon_perp_fire_hose");
	Player:StripWeapon("weapon_perp_fire_extinguisher");
	
	Player:RemoveCar();
	Player:SetCarUsed(0);
	
	Player.JobModel = nil;
	Player:SetModel(Player.PlayerModel);
	Player:EquipMains()
end

function GM.Fireman_SpawnCar ( Player )
	if (Player:Team() != TEAM_FIREMAN) then return; end
	if (!Player:NearNPC(12)) then return; end
	
	local numFireCars = 0;
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do		
		if (v.vehicleTable && v.vehicleTable.RequiredClass == TEAM_FIREMAN && v:GetNetworkedEntity("owner", nil) != Player) then
			numFireCars = numFireCars + 1;
		end
	end
	
	if (numFireCars >= GAMEMODE.MaxFireTrucks) then return; end
	
	GAMEMODE.SpawnVehicle(Player, "y", {1, 1, 0, 0})
end
concommand.Add("perp_f_c", GM.Fireman_SpawnCar);