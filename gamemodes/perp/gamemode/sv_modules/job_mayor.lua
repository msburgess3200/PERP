

GM.CityBudget = 5000
GM.CityBudget_LastIncome = 0
GM.CityBudget_LastExpenses = 0

GM.JobPaydayInfo[TEAM_MAYOR] = {"for serving as the mayor of this fine town.", GM.MayorPay};

function GM.Mayor_SignUp ( Player )
	if (Player:HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_MAYOR])) then return; end
	if (Player:Team() != TEAM_CITIZEN) then return; end
	if (!Player:NearNPC(1)) then return; end
	if (Player:GetNetworkedBool("warrent", false)) then return; end
	//if (Player:GetPERPLevel(GENE_INFLUENCE) < 1) then return; end
	
	if (Player.RunningForMayor) then
		Player.RunningForMayor = nil;
	else
		Player.RunningForMayor = true;
	end
	
	local numRunningForMayor = {};
	for k, v in pairs(player.GetAll()) do
		if (v.RunningForMayor) then
			table.insert(numRunningForMayor, v);
		end
	end
	
	if (#numRunningForMayor >= GAMEMODE.PeopleRequired_Mayor) then
		GAMEMODE.StartMayorElection()
	elseif (#numRunningForMayor >= 2) then
		GAMEMODE.StartMayorElectionTime = CurTime() + (60 * 7.5)
	end
end
concommand.Add("perp_g_b", GM.Mayor_SignUp);

local function monitorMayorElectionStart ( )
	if (!GAMEMODE.StartMayorElectionTime) then return end
	if (GAMEMODE.StartMayorElectionTime > CurTime()) then return end
	
	GAMEMODE.StartMayorElection()
end
hook.Add("Think", monitorMayorElectionStart)

function GM.StartMayorElection ( )
	local numRunningForMayor = {};
	for k, v in pairs(player.GetAll()) do
		if (v.RunningForMayor) then
			table.insert(numRunningForMayor, v);
		end
	end

	Msg("Starting mayor election with " .. #numRunningForMayor .. " contestants.\n");
		
	umsg.Start("perp_mayor_election");
		umsg.Short(#numRunningForMayor);
		
		for k, v in pairs(numRunningForMayor) do
			v.NumVotes = 0;
			umsg.Entity(v);
		end
	umsg.End();
	
	GAMEMODE.MayorElection = CurTime() + 30;
	GAMEMODE.TotalVotesCounted = 0;
	GAMEMODE.VotesNeeded = table.Count(player.GetAll());
	hook.Add("Think", "GM.MonitorMayorVotes", GAMEMODE.MonitorMayorVotes);
	GAMEMODE.StartMayorElectionTime = nil
end

function GM.MonitorMayorVotes ()
	if (!GAMEMODE.MayorElection) then
		hook.Remove("Think", "GM.MonitorMayorVotes");
		
		for _, each in pairs(player.GetAll()) do
			each.RunningForMayor = nil
		end
		
		return;
	end
	
	if (GAMEMODE.TotalVotesCounted < GAMEMODE.VotesNeeded && GAMEMODE.MayorElection > CurTime()) then return; end
	
	Msg("Counting mayor votes... ");
	
	GAMEMODE.TotalVotesCounted = nil;
	GAMEMODE.VotesNeeded = nil;
	GAMEMODE.MayorElection = nil;
	
	local largestVote_Count = -1;
	local largestVote_Player;
	
	for k, v in pairs(player.GetAll()) do
		v.MayorVoteCounted = nil;
		
		if (v.RunningForMayor && v.NumVotes > largestVote_Count) then
			largestVote_Count = v.NumVotes;
			largestVote_Player = v;
			
			v.RunningForMayor = nil;
			v.NumVotes = nil;
		end
	end
	
	if (!largestVote_Player || !IsValid(largestVote_Player)) then Msg("No mayor was chosen.\n"); return; end
	
	Msg(largestVote_Player:Nick() .. " [ " .. largestVote_Player:GetRPName() .. " ] won election.\n");
	
	umsg.Start("perp_mayor_end");
		umsg.Entity(largestVote_Player);
		umsg.Short(largestVote_Count);
	umsg.End();
    
    largestVote_Player:StripMains();
	largestVote_Player:SetTeam(TEAM_MAYOR);
	largestVote_Player.JobModel = JOB_MODELS[TEAM_MAYOR][largestVote_Player:GetSex()];
	largestVote_Player:SetModel(largestVote_Player.JobModel);
	GAMEMODE.SendMayorCityInfo()

end

function GM.ReceivePlayerVote ( Player, Cmd, Args )
	if (!Player) then return; end
	if (!Args[1]) then return; end
	if (Player.MayorVoteCounted) then return; end
	if (!GAMEMODE.MayorElection) then return; end
	
	Player.MayorVoteCounted = true;
	
	local votedFor_UID = Args[1];
	
	local votedFor_Player;
	for k, v in pairs(player.GetAll()) do
		if (v:UniqueID() == votedFor_UID) then
			votedFor_Player = v;
			break;
		end
	end
	if (!votedFor_Player) then return; end
	if (!votedFor_Player.RunningForMayor) then return; end
	
	votedFor_Player.NumVotes = votedFor_Player.NumVotes + 1;
	GAMEMODE.TotalVotesCounted = GAMEMODE.TotalVotesCounted + 1;
end
concommand.Add("perp_g_v", GM.ReceivePlayerVote);

function GM.ReceiveDemoteCommand ( Player, Cmd, Args )
	if (!Player) then return; end
	if (!Args[1] || !Args[2]) then return; end
	if (Player:Team() != TEAM_MAYOR) then return; end
	if (Player.NextDemoteAllowed && Player.NextDemoteAllowed > CurTime()) then return; end
	Player.NextDemoteAllowed = CurTime() + 59;
	
	local toChangeUID = Args[1];
	local reason = Args[2];
	
	local toChangePlayer;
	for k, v in pairs(player.GetAll()) do
		if (v:UniqueID() == toChangeUID) then
			toChangePlayer = v;
			break;
		end
	end
	if (!toChangePlayer) then Player:Notify("Could not find player."); return; end
	if (Player == toChangePlayer) then return; end
	
	if (toChangePlayer:Team() == TEAM_CITIZEN) then
		Player:Notify("You cannot demote a citizen.");
	return; end
	
	if (toChangePlayer:Team() == TEAM_POLICE) then
		GAMEMODE.Police_Leave(toChangePlayer);
	elseif (toChangePlayer:Team() == TEAM_MEDIC) then
		GAMEMODE.Medic_Leave(toChangePlayer);
	elseif (toChangePlayer:Team() == TEAM_FIREMAN) then
		GAMEMODE.Fireman_Leave(toChangePlayer);
	elseif (toChangePlayer:Team() == TEAM_SWAT) then
		GAMEMODE.Swat_Leave(toChangePlayer);
	elseif (toChangePlayer:Team() == TEAM_DISPATCHER) then
		GAMEMODE.Dispatcher_Leave(toChangePlayer);
	elseif (toChangePlayer:Team() == TEAM_SECRET_SERVICE) then
		GAMEMODE.Secret_Service_Leave(toChangePlayer);
	else
		Player:Notify("Error demoting player.");
		return;
	end
	
	Player:Notify("Player demoted.");
	toChangePlayer:Notify("You have been demoted by the mayor for '" .. reason .. "'");
end
concommand.Add("perp_g_d", GM.ReceiveDemoteCommand);

function GM.ReceiveWarrentCommand ( Player, Cmd, Args )
	if (!Player) then return; end
	if (!Args[1] || !Args[2]) then return; end
	if (Player:Team() != TEAM_MAYOR) then return; end
	if (Player.NextWarrentAllowed && Player.NextWarrentAllowed > CurTime()) then return; end
	Player.NextWarrentAllowed = CurTime() + 9;
	
	local toChangeUID = Args[1];
	local reason = Args[2];
	
	local toChangePlayer;
	for k, v in pairs(player.GetAll()) do
		if (v:UniqueID() == toChangeUID) then
			toChangePlayer = v;
			break;
		end
	end
	if (!toChangePlayer) then Player:Notify("Could not find player."); return; end
	if (toChangePlayer == Player) then return; end
	
	if (toChangePlayer:Team() != TEAM_CITIZEN) then
		Player:Notify("You cannot warrant a government official.");
	return; end
	
	if (toChangePlayer:GetNetworkedBool("warrent", false)) then
		Player:Notify("That player is already warranted.");
	return; end
	
	Player:Notify("Player warrented.");
	toChangePlayer:Notify("You have been warrented by the mayor for '" .. reason .. "'");
	
	for k, v in pairs(team.GetPlayers(TEAM_POLICE)) do
		v:Notify(toChangePlayer:GetRPName() .. " has been warranted.");
	end
	
	for k, v in pairs(team.GetPlayers(TEAM_SWAT)) do
		v:Notify(toChangePlayer:GetRPName() .. " has been warranted.");
	end
	
	for k, v in pairs(team.GetPlayers(TEAM_DISPATCHER)) do
		v:Notify(toChangePlayer:GetRPName() .. " has been warranted.");
	end
	
	toChangePlayer.UnwarrentTime = CurTime() + WARRENT_TIME;
	toChangePlayer:SetNetworkedBool("warrent", true);
end
concommand.Add("perp_g_w", GM.ReceiveWarrentCommand);

local function MonitorPlayerWarrents ( )
	for k, v in pairs(player.GetAll()) do
		if (v.UnwarrentTime && v.UnwarrentTime < CurTime()) then
			v:SetNetworkedBool("warrent", false);
			v.UnwarrentTime = nil;
			
	
			for k, v in pairs(team.GetPlayers(TEAM_POLICE)) do
				v:Notify(toChangePlayer:GetRPName() .. "'s warrant has expired.");
			end
			
			for k, v in pairs(team.GetPlayers(TEAM_SWAT)) do
				v:Notify(toChangePlayer:GetRPName() .. "'s warrant has expired.");
			end
			
			for k, v in pairs(team.GetPlayers(TEAM_DISPATCHER)) do
				v:Notify(toChangePlayer:GetRPName() .. "'s warrant has expired.");
			end
		end
	end
end
hook.Add("Think", "MonitorPlayerWarrents", MonitorPlayerWarrents);

local function changeTaxRate_Sales ( user, cmd, args )
	if (!user) then return; end
	if (!args[1]) then return; end
	if (user:Team() != TEAM_MAYOR) then return; end
	
	local newSalesRate = math.Round(math.Clamp(tonumber(args[1]), 0, GAMEMODE.MaxTax_Income))
	SetGlobalInt("tax_sales", newSalesRate)
end
concommand.Add("perp_m_t_s", changeTaxRate_Sales)

local function changeTaxRate_Income ( user, cmd, args )
	if (!user) then return; end
	if (!args[1]) then return; end
	if (user:Team() != TEAM_MAYOR) then return; end
	
	local newIncomeRate = math.Round(math.Clamp(tonumber(args[1]), 0, GAMEMODE.MaxTax_Sales))
	SetGlobalInt("tax_income", newIncomeRate)
end
concommand.Add("perp_m_t_i", changeTaxRate_Income)

function GM.SendMayorCityInfo ( )
	local mayor = team.GetPlayers(TEAM_MAYOR)
	
	if (table.Count(mayor) == 0) then return end
	if (!mayor[1] || !IsValid(mayor[1]) || !mayor[1]:IsPlayer()) then return end

	umsg.Start("perp2_mayor_info", mayor[1])
		umsg.Long(GAMEMODE.CityBudget)
		umsg.Short(GAMEMODE.CityBudget_LastIncome)
		umsg.Short(GAMEMODE.CityBudget_LastExpenses)
	umsg.End()
end

local maxPayDayTable = {}
maxPayDayTable["perp_m_p_c"] = GM.MaxPayDay_Police
maxPayDayTable["perp_m_p_f"] = GM.MaxPayDay_Fireman
maxPayDayTable["perp_m_p_d"] = GM.MaxPayDay_Dispatcher
maxPayDayTable["perp_m_p_s"] = GM.MaxPayDay_SWAT
maxPayDayTable["perp_m_p_m"] = GM.MaxPayDay_Paramedic
maxPayDayTable["perp_m_p_ss"] = GM.MaxPayDay_SecretService

maxPayDayTable["perp_m_e_c"] = GM.MaxEmployment_Police
maxPayDayTable["perp_m_e_f"] = GM.MaxEmployment_Fire
maxPayDayTable["perp_m_e_s"] = GM.MaxEmployment_SWAT
maxPayDayTable["perp_m_e_m"] = GM.MaxEmployment_Medic
maxPayDayTable["perp_m_e_ss"] = GM.MaxEmployment_SecretService

maxPayDayTable["perp_m_v_c"] = GM.MaxVehicles_Police
maxPayDayTable["perp_m_v_f"] = GM.MaxVehicles_Fire
maxPayDayTable["perp_m_v_s"] = GM.MaxVehicles_SWAT
maxPayDayTable["perp_m_v_m"] = GM.MaxVehicles_Medic
maxPayDayTable["perp_m_v_ss"] = GM.MaxVehicles_SecretService

local cmdToTeam = {}
cmdToTeam["perp_m_p_c"] = TEAM_POLICE
cmdToTeam["perp_m_p_m"] = TEAM_MEDIC
cmdToTeam["perp_m_p_f"] = TEAM_FIREMAN
cmdToTeam["perp_m_p_d"] = TEAM_DISPATCHER
cmdToTeam["perp_m_p_s"] = TEAM_SWAT
cmdToTeam["perp_m_p_ss"] = TEAM_SECRET_SERVICE

cmdToTeam["perp_m_e_c"] = "MaximumCops"
cmdToTeam["perp_m_e_m"] = "MaximumParamedic"
cmdToTeam["perp_m_e_f"] = "MaximumFireMen"
cmdToTeam["perp_m_e_s"] = "MaximumSWAT"
cmdToTeam["perp_m_e_ss"] = "MaximumSecretService"

cmdToTeam["perp_m_v_c"] = "MaxCopCars"
cmdToTeam["perp_m_v_f"] = "MaxFireTrucks"
cmdToTeam["perp_m_v_m"] = "MaxAmbulances"
cmdToTeam["perp_m_v_s"] = "MaxSWATVans"
cmdToTeam["perp_m_v_ss"] = "MaxStretch"

function GM.HandlePayDayChanges ( user, cmd, args )
	if (user:Team() != TEAM_MAYOR && !user:IsOwner()) then return end
	if (!args[1]) then return end
	if (!maxPayDayTable[cmd]) then return end
	if (!cmdToTeam[cmd]) then return end
	
	GAMEMODE.JobPaydayInfo[cmdToTeam[cmd]][2] = math.Clamp(tonumber(args[1]), GAMEMODE.MinimumPayGov, maxPayDayTable[cmd])
	GAMEMODE.SendJobInfoUpdate = true
end
concommand.Add("perp_m_p_c", GM.HandlePayDayChanges)
concommand.Add("perp_m_p_f", GM.HandlePayDayChanges)
concommand.Add("perp_m_p_d", GM.HandlePayDayChanges)
concommand.Add("perp_m_p_s", GM.HandlePayDayChanges)
concommand.Add("perp_m_p_ss", GM.HandlePayDayChanges)
concommand.Add("perp_m_p_m", GM.HandlePayDayChanges)

function GM.HandleEMPChanges ( user, cmd, args )
	if (user:Team() != TEAM_MAYOR && !user:IsOwner()) then return end
	if (!args[1]) then return end
	if (!maxPayDayTable[cmd]) then return end
	if (!cmdToTeam[cmd]) then return end
		
	GAMEMODE[cmdToTeam[cmd]] = math.Clamp(tonumber(args[1]), 0, maxPayDayTable[cmd])
	GAMEMODE.SendJobInfoUpdate = true
end
concommand.Add("perp_m_e_c", GM.HandleEMPChanges)
concommand.Add("perp_m_e_f", GM.HandleEMPChanges)
concommand.Add("perp_m_e_m", GM.HandleEMPChanges)
concommand.Add("perp_m_e_s", GM.HandleEMPChanges)
concommand.Add("perp_m_e_ss", GM.HandleEMPChanges)

function GM.HandleVEHChanges ( user, cmd, args )
	if (user:Team() != TEAM_MAYOR && !user:IsOwner()) then return end
	if (!args[1]) then return end
	if (!maxPayDayTable[cmd]) then return end
	if (!cmdToTeam[cmd]) then return end
		
	GAMEMODE[cmdToTeam[cmd]] = math.Clamp(tonumber(args[1]), 0, maxPayDayTable[cmd])
	GAMEMODE.SendJobInfoUpdate = true
end
concommand.Add("perp_m_v_c", GM.HandleVEHChanges)
concommand.Add("perp_m_v_f", GM.HandleVEHChanges)
concommand.Add("perp_m_v_m", GM.HandleVEHChanges)
concommand.Add("perp_m_v_s", GM.HandleVEHChanges)
concommand.Add("perp_m_v_ss", GM.HandleVEHChanges)

