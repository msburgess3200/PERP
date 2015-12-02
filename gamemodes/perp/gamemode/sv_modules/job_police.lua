


local ammoToGive = 55;

GM.JobPaydayInfo[TEAM_POLICE] = {"as a paycheck for being an officer of the law.", 75};

GM.JobEquips[TEAM_POLICE] = function ( Player )
	Player:Give("weapon_perp_copgun");
	Player:Give("weapon_perp_nightstick");
	Player:Give("weapon_perp_battering_ram");
	Player:Give("weapon_perp_handcuffs");
	//Player:Give("weapon_perp_car_ticket");
	Player:GiveAmmo(ammoToGive, 'pistol');
	Player:SetArmor(50);
end

function GM.Police_Join ( Player )
	if (Player:HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_POLICE])) then return; end
	if (!Player:NearNPC(11)) then return; end
	if (Player:Team() != TEAM_CITIZEN) then return; end
	if (Player.RunningForMayor) then return; end
	if (Player:GetNetworkedBool("warrent", false)) then return; end
	if (team.NumPlayers(TEAM_POLICE) >= GAMEMODE.MaximumCops) then return; end
	if (Player:GetTimePlayed() < GAMEMODE.RequiredTime_Cop * 60 * 60 && !Player:IsBronze()) then return end
	
	if (Player.currentlyRestrained) then
		Player:Notify("You cannot become cop while cuffed.");
		return;
	end;
	
	Player:SetTeam(TEAM_POLICE);
	
	Player:RemoveCar();
	
	GAMEMODE.JobEquips[TEAM_POLICE](Player);
	
	Player.JobModel = JOB_MODELS[TEAM_POLICE][Player:GetFace()];
	Player:SetModel(Player.JobModel);
	Player:StripMains();
end
concommand.Add("perp_p_j", GM.Police_Join);

function GM.Police_Quit ( Player )
	if (!Player:NearNPC(11)) then return; end
	GAMEMODE.Police_Leave(Player);
end
concommand.Add("perp_p_q", GM.Police_Quit);

function GM.Police_Leave ( Player )
	Player:SetTeam(TEAM_CITIZEN);
	
	local ammoTheyHave = math.Clamp(Player:GetAmmoCount('pistol'), 0, ammoToGive);
	if (ammoTheyHave > 0) then
		Player:RemoveAmmo(ammoToGive, 'pistol');
	end
	
	Player:StripWeapon("weapon_perp_copgun");
	Player:StripWeapon("weapon_perp_nightstick");
	Player:StripWeapon("weapon_perp_battering_ram");
	Player:StripWeapon("weapon_perp_handcuffs");
	Player:StripWeapon("weapon_perp_roadspikes");
	//Player:StripWeapon("weapon_perp_car_ticket");
	Player:SetArmor(0);
	
	Player:RemoveCar();
	for k, v in pairs(player.GetAll()) do
		umsg.Start("removebadid", Player)
			umsg.Short(Player:GetCarUsed());		// Fuel Left
		umsg.End()
	end
	
	Player.JobModel = nil;
	Player:SetModel(Player.PlayerModel);
	Player:EquipMains();
end

function GM.Police_SpawnCar ( Player )
	if (Player:Team() != TEAM_POLICE) then return; end
	if (!Player:NearNPC(11)) then return; end
	
	local numSquadCars = 0;
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do		
		if (v.vehicleTable && v.vehicleTable.RequiredClass == TEAM_POLICE && v:GetNetworkedEntity("owner", nil) != Player) then
			numSquadCars = numSquadCars + 1;
		end
	end
	
	if (numSquadCars >= GAMEMODE.MaxCopCars) then return; end
	
	GAMEMODE.SpawnVehicle(Player, "U", {1, 1, 0, 0})
end
concommand.Add("perp_p_c", GM.Police_SpawnCar);

function GM.Police_SpawnCarVIP ( Player )
	if (Player:Team() != TEAM_POLICE) then return; end
	if (!Player:NearNPC(11)) then return; end
	if (Player:GetLevel() > 98) then
		Player:Notify("You must be Gold or Diamond VIP")
		return;
	end
	
	local numSquadCars = 0;
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do		
		if (v.vehicleTable && v.vehicleTable.RequiredClass == TEAM_POLICE && v:GetNetworkedEntity("owner", nil) != Player) then
			numSquadCars = numSquadCars + 1;
		end
	end
	
	if (numSquadCars >= GAMEMODE.MaxCopCars) then return; end
	
	GAMEMODE.SpawnVehicle(Player, "z", {1, 1, 0, 0})
end
concommand.Add("perp_p_cm", GM.Police_SpawnCarVIP);

function GM.Police_SpawnCarAdmin ( Player )
	if (Player:Team() != TEAM_POLICE) then return; end
	if (!Player:NearNPC(11)) then return; end
	if (Player:GetLevel() > 3) then
		Player:Notify("You must be Admin.")
		return;
	end
	
	local numSquadCars = 0;
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do		
		if (v.vehicleTable && v.vehicleTable.RequiredClass == TEAM_POLICE && v:GetNetworkedEntity("owner", nil) != Player) then
			numSquadCars = numSquadCars + 1;
		end
	end
	
	if (numSquadCars >= GAMEMODE.MaxCopCars) then return; end
	
	GAMEMODE.SpawnVehicle(Player, "D", {1, 1, 0, 0})
end
concommand.Add("perp_p_ac", GM.Police_SpawnCarAdmin);
