

function GM.DemotePlayer ( Player, Cmd, Args )
	if !Player:IsAdmin() then Player:Notify("You're not an admin -.-")return false; end
	if !tonumber(Args[1]) then Player:Notify('Invalid # of args.'); return false; end
	if !Args[2] then Player:Notify('Invalid # of args.'); return false; end
	
	local UsPlayer;
	for k, v in pairs(player.GetAll()) do
		if tonumber(v:UniqueID()) == tonumber(Args[1]) then
			UsPlayer = v;
		end
	end
	
	if !UsPlayer or !UsPlayer:IsValid() or !UsPlayer:IsPlayer() then Player:Notify('That is an unknown player.'); return false; end
	if UsPlayer:Team() == TEAM_CITIZEN then Player:Notify('That player is already a citizen!'); return false; end
	
	if (UsPlayer:Team() == TEAM_POLICE) then
			GAMEMODE.Police_Leave(UsPlayer);
		elseif (UsPlayer:Team() == TEAM_MEDIC) then
			GAMEMODE.Medic_Leave(UsPlayer);
		elseif (UsPlayer:Team() == TEAM_FIREMAN) then
			GAMEMODE.Fireman_Leave(UsPlayer);
		elseif (UsPlayer:Team() == TEAM_SWAT) then
			GAMEMODE.Swat_Leave(UsPlayer);
		elseif (UsPlayer:Team() == TEAM_DISPATCHER) then
			GAMEMODE.Dispatcher_Leave(UsPlayer);
		elseif (UsPlayer:Team() == TEAM_SECRET_SERVICE) then
			GAMEMODE.Secret_Service_Leave(UsPlayer);
		elseif (UsPlayer:Team() == TEAM_ROADCREW) then
			GAMEMODE.RoadCrews_Leave(UsPlayer);
		elseif (UsPlayer:Team() == TEAM_BUSDRIVER) then
			GAMEMODE.BusDriver_Leave(UsPlayer);
		elseif (UsPlayer:Team() == TEAM_MAYOR) then
			UsPlayer:SetModel(Player.PlayerModel);
			UsPlayer.JobModel = nil;
			UsPlayer:EquipMains();
			UsPlayer:SetTeam(TEAM_CITIZEN);
		
			for k, v in pairs(player.GetAll()) do
				if (v != Player && v != UsPlayer) then
					v:Notify("The mayor has been impeached!");
				end
			end
		else
			Player:Notify("Error demoting player.");
			return;
		end
	
	if (Player:GetUMsgInt("Disguise", 0) != 1) then
		UsPlayer:Notify('You have been demoted by an admin.');
	else
		UsPlayer:Notify('You have been demoted by ' .. Player:Nick() .. '.');
	end
	UsPlayer:Notify('Reason: ' .. Args[2]);
	
	Player:Notify('You have demoted ' .. UsPlayer:Nick() .. '.');
end
concommand.Add('perp2_demote', GM.DemotePlayer);