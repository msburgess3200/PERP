


GM.JobPaydayInfo[TEAM_DISPATCHER] = {"as a paycheck for being a police dispatcher.", 75};

GM.JobEquips[TEAM_DISPATCHER] = function ( Player )
	Player:Give("weapon_perp_nightstick");
	Player:Give("weapon_perp_handcuffs");
end

function GM.Dispatcher_Join ( Player )
	if (Player:HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_DISPATCHER])) then return; end
	if (!Player:NearNPC(11)) then return; end
	if (Player:Team() != TEAM_CITIZEN) then return; end
	if (Player.RunningForMayor) then return; end
	if (Player:GetNetworkedBool("warrent", false)) then return; end
	if (team.NumPlayers(TEAM_DISPATCHER) >= GAMEMODE.MaximumDispatchers) then return; end
	if (!Player:HasItem("item_phone")) then return; end
	if (Player:GetTimePlayed() < GAMEMODE.RequiredTime_Dispatcher * 60 * 60 && !Player:IsBronze()) then return end
	
	Player:SetTeam(TEAM_DISPATCHER);
	
	Player:RemoveCar();
	
	GAMEMODE.JobEquips[TEAM_DISPATCHER](Player);
	
	Player.JobModel = JOB_MODELS[TEAM_POLICE][Player:GetFace()];
	Player:SetModel(Player.JobModel);
	Player:StripMains();
end
concommand.Add("perp_di_j", GM.Dispatcher_Join);

function GM.Dispatcher_Quit ( Player )
	if (!Player:NearNPC(11)) then return; end
	GAMEMODE.Dispatcher_Leave(Player);
end
concommand.Add("perp_di_q", GM.Dispatcher_Quit);

function GM.Dispatcher_Leave ( Player )
	Player:SetTeam(TEAM_CITIZEN);
	
	Player:StripWeapon("weapon_perp_nightstick");
	Player:StripWeapon("weapon_perp_handcuffs");
	
	Player:RemoveCar();
	
	Player.JobModel = nil;
	Player:SetModel(Player.PlayerModel);
	Player:EquipMains();
end
