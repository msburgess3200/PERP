

GM.JobPaydayInfo[TEAM_BUSDRIVER] = {"for having the patience to drive citizens around.", 75}

GM.JobEquips[TEAM_BUSDRIVER] = function ( Player )
end

function GM.BusDriver_Join ( Player )
	if (Player:HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_BUSDRIVER])) then return end
	if (!Player:NearNPC(22)) then return end
	if (Player:Team() != TEAM_CITIZEN) then return end
	if (Player.RunningForMayor) then return end
	if (team.NumPlayers(TEAM_BUSDRIVER) >= GAMEMODE.MaxEmployment_BusDriver) then return end
	
	Player:SetTeam(TEAM_BUSDRIVER)
	
	Player:RemoveCar()
	
	GAMEMODE.JobEquips[TEAM_BUSDRIVER](Player)
	
	Player.JobModel = JOB_MODELS[TEAM_BUS][Player:GetFace()];
	Player:SetModel(Player.JobModel);
	
	Player:StripMains()
end
concommand.Add("perp_bd_j", GM.BusDriver_Join)

function GM.BusDriver_Leave ( Player )
	Player:SetTeam(TEAM_CITIZEN)
	
	Player:RemoveCar()
	
	Player.JobModel = nil
	Player:SetModel(Player.PlayerModel)
	Player:EquipMains()
end
concommand.Add("perp_bd_q", GM.BusDriver_Leave)

function GM.BusDriver_SpawnCar ( Player )
	if (Player:Team() != TEAM_BUSDRIVER) then return end
	if (!Player:NearNPC(22)) then return end
	
	local numSquadCars = 0
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do		
		if (v.vehicleTable && v.vehicleTable.RequiredClass == TEAM_BUSDRIVER && v:GetNetworkedEntity("owner", nil) != Player) then
			numSquadCars = numSquadCars + 1
		end
	end
	
	if (!Player:IsGold() && numSquadCars >= GAMEMODE.MaxBusses) then
		return;
	end

	GAMEMODE.SpawnVehicle(Player, "-", {1, 1, 0})
end
concommand.Add("perp_bd_cha", GM.BusDriver_SpawnCar)
