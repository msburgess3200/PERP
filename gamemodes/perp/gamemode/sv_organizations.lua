

function GM.FetchOrganizationData ( orgID )
	if (GAMEMODE.OrganizationMembers[orgID]) then return; end
	
	Msg("Loading Organization ID #" .. orgID .. "...\n");
	
	tmysql.query("SELECT `name`, `motd`, `owner` FROM `perp_organization` WHERE `id`='" .. orgID .. "' LIMIT 1", function ( orgInfo )
		if (orgInfo[1] && orgInfo[1][1]) then
			local name = orgInfo[1][1];
			local motd = orgInfo[1][2];
			local ownerID = orgInfo[1][3];
			
			tmysql.query("SELECT `rp_name_first`, `rp_name_last` FROM `perp_users` WHERE `id`='" .. ownerID .. "' LIMIT 1", function ( ownerInfo ) 
				local ownerName = "ERROR";
				
				if (ownerInfo[1] && ownerInfo[1][1]) then
					ownerName = ownerInfo[1][1] .. " " .. ownerInfo[1][2];
				end
				
				GAMEMODE.OrganizationData[orgID] = {name, motd, ownerName, ownerID};
			end);
		else
			GAMEMODE.OrganizationData[orgID] = {"ERROR", "Error fetching organization data.", "ERROR", 0};
		end
	end);
	
	GAMEMODE.OrganizationMembers[orgID] = {};
	tmysql.query("SELECT `rp_name_first`, `rp_name_last`, `uid` FROM `perp_users` WHERE `organization`='" .. orgID .. "'", function ( memData )
		if (memData[1]) then
			for k, v in pairs(memData) do
				table.insert(GAMEMODE.OrganizationMembers[orgID], {v[1] .. " " .. v[2], v[3]});
			end
		end
	end);
end

function GM.RequestOrganizationData ( Player, Cmd, Args )
	if (!Args[1]) then return; end
	
	Player.sentROD = Player.sentROD or {};
	
	local orgID = tonumber(Args[1]);
	
	if (Player.sentROD[orgID]) then return; end
		
	if (GAMEMODE.OrganizationData[orgID] && GAMEMODE.OrganizationMembers[orgID][1]) then
		Player.sentROD[orgID] = true;
	
		umsg.Start("perp_rod", Player);
			umsg.Short(orgID);
			umsg.String(GAMEMODE.OrganizationData[orgID][1]);
			umsg.String(GAMEMODE.OrganizationData[orgID][2]);
			umsg.String(GAMEMODE.OrganizationData[orgID][3]);
			umsg.Bool(GAMEMODE.OrganizationData[orgID][4] == Player.SMFID);
		umsg.End();
		
		for k, v in pairs(GAMEMODE.OrganizationMembers[orgID]) do
			timer.Simple(k * .1, 	function ( )
										if (Player && IsValid(Player)) then
											umsg.Start("perp_rod_m", Player);
												umsg.Short(orgID);
												umsg.String(v[1]);
												umsg.String(v[2]);
											umsg.End();
										end
									end);
		end
	else
		GAMEMODE.FetchOrganizationData(orgID);
		
		umsg.Start("perp_rod", Player);
			umsg.Short(orgID);
			umsg.String("fa");
			umsg.String("Loading...");
			umsg.String("Loading...");
			umsg.Bool(false);
		umsg.End();
	end
end
concommand.Add("perp_rod", GM.RequestOrganizationData);

function GM.RequestSimpleOrganizationData ( Player, Cmd, Args )
	if (!Args[1]) then return; end
	
	local orgID = tonumber(Args[1]);
		
	if (GAMEMODE.OrganizationData[orgID]) then
		umsg.Start("perp_srod", Player);
			umsg.Short(orgID);
			umsg.String(GAMEMODE.OrganizationData[orgID][1]);
		umsg.End();
	else
		GAMEMODE.FetchOrganizationData(orgID);
		
		umsg.Start("perp_srod", Player);
			umsg.Short(orgID);
			umsg.String("fa");
		umsg.End();
	end
end
concommand.Add("perp_srod", GM.RequestSimpleOrganizationData);

function GM.UpdateOrganizationData ( Player, Cmd, Args )
	if (!Args[1] || !Args[2]) then return; end
	
	local playerOrg = Player:GetUMsgInt("org", 0);
	
	if (playerOrg == 0) then return; end
	if (!GAMEMODE.OrganizationData[playerOrg]) then return; end
	if (tostring(GAMEMODE.OrganizationData[playerOrg][4]) != tostring(Player.SMFID)) then return; end
	
	local oldName = GAMEMODE.OrganizationData[playerOrg][1];
	local oldMOTD = GAMEMODE.OrganizationData[playerOrg][2];
	
	local newName = Args[1];
	local newMOTD = Args[2];
	
	if (string.len(newName) > 20) then newName = string.sub(newName, 1, 20); end
	
	GAMEMODE.OrganizationData[playerOrg][1] = newName;
	GAMEMODE.OrganizationData[playerOrg][2] = newMOTD;
	
	tmysql.query("UPDATE `perp_organization` SET `name`='" .. tmysql.escape(newName) .. "', `motd`='" .. tmysql.escape(newMOTD) .. "' WHERE `id`='" .. playerOrg .. "' LIMIT 1");
	
	if (oldName != newName) then
		umsg.Start("perp_srod");
			umsg.Short(playerOrg);
			umsg.String(newName);
		umsg.End();
	end
	
	if (newMOTD != oldMOTD) then
		for k, v in pairs(player.GetAll()) do
			if (v.sentROD && v.sentROD[playerOrg]) then				
				umsg.Start("perp_rod", v);
					umsg.Short(playerOrg);
					umsg.String(GAMEMODE.OrganizationData[playerOrg][1]);
					umsg.String(GAMEMODE.OrganizationData[playerOrg][2]);
					umsg.String(GAMEMODE.OrganizationData[playerOrg][3]);
					umsg.Bool(GAMEMODE.OrganizationData[playerOrg][4] == v.SMFID);
				umsg.End();
			end
		end
	end
	
	Player:Notify("Changes successfully saved.");
end
concommand.Add("perp_o_c", GM.UpdateOrganizationData);

function GM.InviteToOrganization ( Player, Cmd, Args )
	if (!Args[1]) then return; end
	
	local playerOrg = Player:GetUMsgInt("org", 0);
	
	if (playerOrg == 0) then return; end
	if (!GAMEMODE.OrganizationData[playerOrg]) then return; end
	if (tostring(GAMEMODE.OrganizationData[playerOrg][4]) != tostring(Player.SMFID)) then return; end
	
	local sPlayer;
	for k, v in pairs(player.GetAll()) do
		if (tostring(v:UniqueID()) == Args[1]) then
			sPlayer = v;
		end
	end
	
	if (!sPlayer) then return; end
	if (sPlayer:GetUMsgInt("org", 0) != 0) then return; end
	
	sPlayer.invitedTo = playerOrg;
	sPlayer.invitedBy = Player;
	
	umsg.Start("perp_invite", sPlayer);
		umsg.String(GAMEMODE.OrganizationData[playerOrg][1]);
	umsg.End();
end
concommand.Add("perp_o_i", GM.InviteToOrganization);

function GM.KickFromOrganization ( Player, Cmd, Args )
	if (!Args[1]) then return; end
	
	local playerOrg = Player:GetUMsgInt("org", 0);
	
	if (playerOrg == 0) then return; end
	if (!GAMEMODE.OrganizationData[playerOrg]) then return; end
	if (tostring(GAMEMODE.OrganizationData[playerOrg][4]) != tostring(Player.SMFID)) then return; end
	
	local sPlayer;
	for k, v in pairs(player.GetAll()) do
		if (tostring(v:UniqueID()) == Args[1]) then
			sPlayer = v;
		end
	end
	
	if (!sPlayer) then return; end
	if (sPlayer:GetUMsgInt("org", 0) != playerOrg) then return; end
	
	sPlayer:Notify("You have been kicked out of " .. GAMEMODE.OrganizationData[playerOrg][1] .. ".");
	sPlayer:SetUMsgInt("org", nil);
	
	tmysql.query("UPDATE `perp_users` SET `organization`='0' WHERE `id`='" .. sPlayer.SMFID .. "'");
	
	for k, v in pairs(player.GetAll()) do
		if (v.sentROD && v.sentROD[playerOrg]) then			
			umsg.Start("perp_rod_c", v);
				umsg.Short(playerOrg);
				umsg.String(sPlayer:UniqueID());
			umsg.End();
		end
	end
end
concommand.Add("perp_o_r", GM.KickFromOrganization);

function GM.AcceptInvitation ( Player )
	if (Player:GetUMsgInt("org", 0) != 0) then return; end
	if (!Player.invitedTo || !Player.invitedBy) then return; end
	
	Player:SetUMsgInt("org", Player.invitedTo);
	
	if (Player.invitedBy && IsValid(Player.invitedBy)) then
		Player.invitedBy:Notify(Player:Nick() .. " has accepted your invitation.");
	end
	
	tmysql.query("UPDATE `perp_users` SET `organization`='" .. Player.invitedTo .. "' WHERE `id`='" .. Player.SMFID .. "'");
	
	for k, v in pairs(player.GetAll()) do
		if (v.sentROD && v.sentROD[Player.invitedTo]) then			
			umsg.Start("perp_rod_m", v);
				umsg.Short(Player.invitedTo);
				umsg.String(Player:GetRPName());
				umsg.String(Player:UniqueID());
			umsg.End();
		end
	end
	
	Player.invitedTo = nil;
	Player.invitedBy = nil;
end
concommand.Add("perp_o_a", GM.AcceptInvitation);

function GM.NewOrganization ( Player )
	if (Player:GetCash() < 5000) then return; end
	Player:TakeCash(5000);
	
	tmysql.query("INSERT INTO `perp_organization` (`name`, `motd`, `owner`) VALUES ('New Organization', 'No Current MOTD', '" .. Player.SMFID .. "')", function ( d )
		tmysql.query("SELECT `id` FROM `perp_organization` WHERE `owner`='" .. Player.SMFID .. "' LIMIT 1", function ( data ) 
			if (data[1] && data[1][1]) then
				Player:SetUMsgInt("org", tonumber(data[1][1]));
				tmysql.query("UPDATE `perp_users` SET `organization`='" .. data[1][1] .. "' WHERE `id`='" .. Player.SMFID .. "' LIMIT 1");
				GAMEMODE.FetchOrganizationData(tonumber(data[1][1]))
			end
		end);
	end);
end
concommand.Add("perp_o_n", GM.NewOrganization);

function GM.LeaveOrganization ( Player )
	if (Player:GetUMsgInt("org", 0) == 0) then return; end
	
	local orgID = Player:GetUMsgInt("org", 0);
	
	if (!GAMEMODE.OrganizationData[orgID]) then return; end
	
	if (tostring(Player.SMFID) == tostring(GAMEMODE.OrganizationData[orgID][4])) then		
		for k, v in pairs(player.GetAll()) do
			if (v:GetUMsgInt("org", 0) == orgID) then
				if (v != Player) then
					v:Notify(GAMEMODE.OrganizationData[orgID][1] .. " has been disbaned.");
				end
				
				v:SetUMsgInt("org", 0);
			end
		end
		
		tmysql.query("UPDATE `perp_users` SET `organization`='0' WHERE `organization`='" .. orgID .. "'");
		tmysql.query("DELETE FROM `perp_organization` WHERE `id`='" .. orgID .. "'");
	else		
		Player:SetUMsgInt("org", 0);
		tmysql.query("UPDATE `perp_users` SET `organization`='0' WHERE `id`='" .. Player.SMFID .. "'");
		
		for k, v in pairs(player.GetAll()) do
			if (v.sentROD && v.sentROD[orgID]) then			
				umsg.Start("perp_rod_c", v);
					umsg.Short(orgID);
					umsg.String(Player:UniqueID());
				umsg.End();
			end
		end
	end
end
concommand.Add("perp_o_q", GM.LeaveOrganization);