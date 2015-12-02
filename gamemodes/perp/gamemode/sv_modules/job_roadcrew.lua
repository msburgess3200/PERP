


GM.JobPaydayInfo[TEAM_ROADCREW] = {"for helping the citizens out.", 75}

GM.JobEquips[TEAM_ROADCREW] = function ( Player )
	Player:Give("weapon_perp_wrench")
	--Player:Give("weapon_perp_fuelcan")
end

function GM.RoadCrews_Join ( Player )
	if (Player:HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_ROADCREW])) then return end
	if (!Player:NearNPC(21)) then return end
	if (Player:Team() != TEAM_CITIZEN) then return end
	if (Player.RunningForMayor) then return end
	if (team.NumPlayers(TEAM_ROADCREW) >= GAMEMODE.MaxEmployment_Tow) then return end
	
	Player:SetTeam(TEAM_ROADCREW)
	
	Player:RemoveCar()
	
	GAMEMODE.JobEquips[TEAM_ROADCREW](Player)
	
	Player:StripMains()
end
concommand.Add("perp_rs_j_alsdkjfahsdlfhowieuhfdnbcvz", GM.RoadCrews_Join)

function GM.RoadCrews_Leave ( Player )
	
	//Strip weapons
	Player:StripWeapon("weapon_perp_wrench")
	--Player:StripWeapon("weapon_perp_fuelcan")
	
	Player:SetTeam(TEAM_CITIZEN)
	
	Player:RemoveCar()
	
	Player.JobModel = nil
	Player:SetModel(Player.PlayerModel)
	Player:EquipMains()
end
concommand.Add("perp_rs_q", GM.RoadCrews_Leave)

function GM.RoadCrews_SpawnCar ( Player )
	if (Player:Team() != TEAM_ROADCREW) then return end
	if (!Player:NearNPC(21)) then return end
	
	local RoadCrewTrucks = 0
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do		
		if (v.vehicleTable && v.vehicleTable.RequiredClass == TEAM_ROADCREW && v:GetNetworkedEntity("owner", nil) != Player) then
			RoadCrewTrucks = RoadCrewTrucks + 1
		end
	end
	
	if (RoadCrewTrucks >= GAMEMODE.MaxRoadCrewTrucks) then return end
	
	GAMEMODE.SpawnVehicle(Player, "%", {1, 1, 0})
end
concommand.Add("perp_rs_c", GM.RoadCrews_SpawnCar)
