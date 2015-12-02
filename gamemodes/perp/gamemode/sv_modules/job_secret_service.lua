


local ammoToGive = 35;

GM.JobPaydayInfo[TEAM_SECRET_SERVICE] = {"as a paycheck for being a secret service agent.", 75};

GM.JobEquips[TEAM_SECRET_SERVICE] = function ( Player )
	Player:Give("weapon_perp_copgun_ss");
	Player:GiveAmmo(ammoToGive, 'pistol');
end

function GM.Secret_Service_Join ( Player )
	if (Player:HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_SECRET_SERVICE])) then return; end
	if (!Player:NearNPC(1)) then return; end
	if (Player:Team() != TEAM_CITIZEN) then return; end
	if (Player.RunningForMayor) then return; end
	if (team.NumPlayers(TEAM_MAYOR) == 0) then return end
	if (Player:GetNetworkedBool("warrent", false)) then return; end
	if (team.NumPlayers(TEAM_SECRET_SERVICE) >= GAMEMODE.MaximumSecretService) then return; end
	if (Player:GetTimePlayed() < GAMEMODE.RequiredTime_SecretService * 60 * 60 && !Player:IsBronze()) then return end
	
	Player:SetTeam(TEAM_SECRET_SERVICE);
	
	Player:RemoveCar();
	Player:SetCarUsed(0);
	
	GAMEMODE.JobEquips[TEAM_SECRET_SERVICE](Player);
	
	Player.JobModel = JOB_MODELS[TEAM_SECRET_SERVICE][Player:GetFace()];
	Player:SetModel(Player.JobModel);
	Player:StripMains();
end
concommand.Add("perp_ss_j", GM.Secret_Service_Join);

function GM.Secret_Service_Quit ( Player )
	if (!Player:NearNPC(1)) then return; end
	GAMEMODE.Secret_Service_Leave(Player);
end
concommand.Add("perp_ss_q", GM.Secret_Service_Quit);

function GM.Secret_Service_Leave ( Player )
	Player:SetTeam(TEAM_CITIZEN);
	
	local ammoTheyHave = math.Clamp(Player:GetAmmoCount('pistol'), 0, ammoToGive);
	if (ammoTheyHave > 0) then
		Player:RemoveAmmo(ammoTheyHave, 'pistol');
	end
	
	Player:StripWeapon("weapon_perp_copgun_ss");
	
	Player:RemoveCar();
	for k, v in pairs(player.GetAll()) do
		umsg.Start("removebadid", Player)
			umsg.Long(Player:GetCarUsed());		// Fuel Left
		umsg.End()
	end
	
	Player.JobModel = nil;
	Player:SetModel(Player.PlayerModel);
	Player:EquipMains();
end

function GM.Secret_Service_SpawnCar ( Player )
	if (Player:Team() != TEAM_SECRET_SERVICE) then return; end
	if (!Player:NearNPC(1)) then return; end
	
	local numSquadCars = 0;
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do		
		if (v.vehicleTable && v.vehicleTable.RequiredClass == TEAM_SECRET_SERVICE && v:GetNetworkedEntity("owner", nil) != Player) then
			numSquadCars = numSquadCars + 1;
		end
	end
	
	if (numSquadCars >= GAMEMODE.MaxStretch) then return; end
	
	GAMEMODE.SpawnVehicle(Player, "v", {1, 1, 0, 0})
end
concommand.Add("perp_ss_c", GM.Secret_Service_SpawnCar);