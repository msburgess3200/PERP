


local ammoToGive_Pistol = 36;
local ammoToGive_SMG = 150;

GM.JobPaydayInfo[TEAM_SWAT] = {"as a paycheck for being a member of the SWAT team.", 100};

GM.JobEquips[TEAM_SWAT] = function ( Player )
	Player:Give("weapon_perp_copgun_usp");
	Player:Give("weapon_perp_copgun_mp5");
	Player:Give("weapon_perp_battering_ram_swat");
	Player:Give("weapon_perp_nightstick");
	Player:GiveAmmo(ammoToGive_Pistol, 'pistol');
	Player:GiveAmmo(ammoToGive_SMG, 'smg1');
	Player:SetArmor(100);
end

function GM.Swat_Join ( Player )
	if (Player:HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_SWAT])) then return; end
	if (!Player:NearNPC(11)) then return; end
	if (Player:Team() != TEAM_CITIZEN) then return; end
	if (Player.RunningForMayor) then return; end
	if (Player:GetNetworkedBool("warrent", false)) then return; end
	if (team.NumPlayers(TEAM_SWAT) >= GAMEMODE.MaximumSWAT && !Player:IsSuperAdmin()) then return; end
	if (Player:GetTimePlayed() < GAMEMODE.RequiredTime_SWAT * 60 * 60 && !Player:IsBronze()) then return end
	
	Player:SetTeam(TEAM_SWAT);
	
	Player:RemoveCar();
	
	GAMEMODE.JobEquips[TEAM_SWAT](Player);
	
	Player.JobModel = JOB_MODELS[TEAM_SWAT];
	Player:SetModel(Player.JobModel);
	Player:StripMains();
end
concommand.Add("perp_s_j", GM.Swat_Join);

function GM.Swat_Quit ( Player )
	if (!Player:NearNPC(11)) then return; end
	GAMEMODE.Swat_Leave(Player);
end
concommand.Add("perp_s_q", GM.Swat_Quit);

function GM.Swat_Leave ( Player )
	Player:SetTeam(TEAM_CITIZEN);
	
	local ammoTheyHave = math.Clamp(Player:GetAmmoCount('pistol'), 0, ammoToGive_Pistol);
	if (ammoTheyHave > 0) then
		Player:RemoveAmmo(ammoToGive_Pistol, 'pistol');
	end
	
	local ammoTheyHave = math.Clamp(Player:GetAmmoCount('smg1'), 0, ammoToGive_SMG);
	if (ammoTheyHave > 0) then
		Player:RemoveAmmo(ammoToGive_SMG, 'smg1');
	end
	
	Player:StripWeapon("weapon_perp_copgun_usp");
	Player:StripWeapon("weapon_perp_copgun_mp5");
	Player:StripWeapon("weapon_perp_battering_ram_swat");
	Player:StripWeapon("weapon_perp_nightstick");
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

function GM.Swat_SpawnCar ( Player )
	if (Player:Team() != TEAM_SWAT) then return; end
	if (!Player:NearNPC(11)) then return; end
	
	local numSquadCars = 0;
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do		
		if (v.vehicleTable && v.vehicleTable.RequiredClass == TEAM_SWAT && v:GetNetworkedEntity("owner", nil) != Player) then
			numSquadCars = numSquadCars + 1;
		end
	end
	
	if (numSquadCars >= GAMEMODE.MaxSWATVans) then return; end
	
	GAMEMODE.SpawnVehicle(Player, "x", {1, 1, 0, 0})
end
concommand.Add("perp_s_c", GM.Swat_SpawnCar);