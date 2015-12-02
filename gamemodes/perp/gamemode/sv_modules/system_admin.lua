


function PLAYER:PERPBan ( banTime, banReason, ply  )
	local bannerName = "Autobot"
	if (ply && IsValid(ply)) then 
		bannerName = ply:Nick()
		ply:Notify("Player banned.")
	end
	
	self:PDBan(bannerName, banTime, banReason)
end

function BanPlayer ( Player, Cmd, Args ) end

function PLAYER:Kick2 (r) 
	self:Kick(r) 
end 
concommand.Add("perp_a_b", BanPlayer);

local function SetSpectate ( Player, Command, Args )
	if !Player:IsAdmin() then return false; end
	if (!Args[1]) then return; end
	
	local toBeBanned = Args[1];
	local toBeBannedPlayer;
	for k, v in pairs(player.GetAll()) do
		if (v:UniqueID() == toBeBanned) then
			toBeBannedPlayer = v; 
		end
	end
	if (!toBeBannedPlayer) then Player:Notify("Could not find that player."); return; end
		
	Player:GetTable().Spectating = toBeBannedPlayer;
	Player:GetTable().Pos = Player:GetPos()
	
	Player:Spectate(OBS_MODE_CHASE)
	Player:SpectateEntity(toBeBannedPlayer) 
end
concommand.Add('perp_a_s', SetSpectate);
	
local function StopSpectate ( Player, Command, Args )
	if !Player:IsAdmin() then return false; end
	
	Player:GetTable().Spectating = nil;
	
	Player:Spectate(OBS_MODE_NONE);
	Player:UnSpectate();
	Player:KillSilent();
	
end
concommand.Add('perp_a_ss', StopSpectate);

local function blacklistPlayer ( Player, cmd, Args )
	if (!Player:IsAdmin()) then return; end
	if (!Args[1] || !Args[2]) then return; end
	
	local banTime = tonumber(Args[1]);
	local toBeBanned = Args[2];
	
	banTime = math.Clamp(banTime, 0, 720);
	
	local toBeBannedPlayer;
	for k, v in pairs(player.GetAll()) do
		if (v:UniqueID() == toBeBanned) then
			toBeBannedPlayer = v;
		end
	end
	if (!toBeBannedPlayer) then Player:Notify("Could not find that player."); return; end
	
	tmysql.query("INSERT INTO `server_bans_logs` (`steamid`, `type`, `committed_by`, `reason`) VALUES ('" .. tmysql.escape(toBeBannedPlayer:SteamID()) .. "', 'server blacklist', '" .. tmysql.escape(Player:Nick()) .. "', 'blacklisted from " .. (toBeBannedPlayer:Team()) .. "')");
	
	if (!GAMEMODE.teamToBlacklist[toBeBannedPlayer:Team()]) then
		Player:Notify("Missing blacklist conversion.");
	return; end
	
	if (Player:HasBlacklist(GAMEMODE.teamToBlacklist[toBeBannedPlayer:Team()])) then
		Player:Notify("They already have that blacklist!");
	return; end
	
	toBeBannedPlayer:GiveBlacklist(GAMEMODE.teamToBlacklist[toBeBannedPlayer:Team()], banTime);
	
	Player:Notify("Player blacklisted.");
	toBeBannedPlayer:Notify("You have been blacklisted by an admin.\n");
		
	if (toBeBannedPlayer:Team() == TEAM_POLICE) then
		GAMEMODE.Police_Leave(toBeBannedPlayer);
	elseif (toBeBannedPlayer:Team() == TEAM_MEDIC) then
		GAMEMODE.Medic_Leave(toBeBannedPlayer);
	elseif (toBeBannedPlayer:Team() == TEAM_FIREMAN) then
		GAMEMODE.Fireman_Leave(toBeBannedPlayer);
	elseif (toBeBannedPlayer:Team() == TEAM_SWAT) then
		GAMEMODE.Swat_Leave(toBeBannedPlayer);
	elseif (toBeBannedPlayer:Team() == TEAM_DISPATCHER) then
		GAMEMODE.Dispatcher_Leave(toBeBannedPlayer);
	elseif (toBeBannedPlayer:Team() == TEAM_SECRET_SERVICE) then
		GAMEMODE.Secret_Service_Leave(toBeBannedPlayer);
	elseif (toBeBannedPlayer:Team() == TEAM_ROADCREW) then
		GAMEMODE.RoadCrews_Leave(toBeBannedPlayer);
	elseif (toBeBannedPlayer:Team() == TEAM_BUSDRIVER) then
		GAMEMODE.BusDriver_Leave(toBeBannedPlayer);
	elseif (toBeBannedPlayer:Team() == TEAM_MAYOR) then
		toBeBannedPlayer:SetModel(Player.PlayerModel);
		toBeBannedPlayer.JobModel = nil;
		toBeBannedPlayer:EquipMains();
		toBeBannedPlayer:SetTeam(TEAM_CITIZEN);
		
		for k, v in pairs(player.GetAll()) do
			if (v != Player && v != toBeBannedPlayer) then
				v:Notify("The mayor has been impeached!");
			end
		end
	else
		Player:Notify("Error demoting player.");
		return;
	end
	
end
concommand.Add("perp_a_bl", blacklistPlayer);

local function blacklistPlayer ( Player, cmd, Args )
	if (!Player:IsAdmin()) then return; end
	
	if (!GArgs[1] || !Args[2]) then return; end
	
	local banTime = tonumber(Args[1]);
	local toBeBanned = Args[2];
	local curTime = os.time();
	
	banTime = math.Clamp(banTime, 0, 720);
	
	local toBeBannedPlayer;
	for k, v in pairs(player.GetAll()) do
		if (v:UniqueID() == toBeBanned) then
			toBeBannedPlayer = v;
		end
	end
	if (!toBeBannedPlayer) then Player:Notify("Could not find that player."); return; end
	
	if (Player:HasBlacklist('b')) then
		Player:Notify("They already have that blacklist!");
	return; end
	
	Player:Notify("Player blacklisted.");
	toBeBannedPlayer:GiveBlacklist('b', banTime);
	
	local endTime = os.time() + (banTime * 60 * 60);
	if (banTime == 0) then endTime = 0; end
	
	if (endTime == 0) then
		return {false, "You are permanently blacklisted from Serious."};
	elseif (endTime > curTime) then
		local timeLeft = endTime - curTime;
		
		local Minutes = math.floor(timeLeft / 60);
		local Seconds = timeLeft - (Minutes * 60);
		local Hours = math.floor(Minutes / 60);
		local Minutes = Minutes - (Hours * 60);
		local Days = math.floor(Hours / 24);
		local Hours = Hours - (Days * 24);
		
		if (Minutes == 0 && Hours == 0 && Days == 0) then
			toBeBannedPlayer:Kick("BL'd from Serious. Lifted In: " .. Seconds .. " Seconds");
		elseif (Hours == 0 && Days == 0) then
			toBeBannedPlayer:Kick("BL'd from Serious. Lifted In: " .. Minutes .. " Minutes");
		elseif (Days == 0) then
			toBeBannedPlayer:Kick("BL'd from Serious. Lifted In: " .. Hours .. " Hours");
		else
			toBeBannedPlayer:Kick("BL'd from Serious. Lifted In: " .. Days .. " Days");
		end
	end
end
concommand.Add("perp_a_bs", blacklistPlayer);

function GM.ForceRename ( Player, cmd, Args )
	if (!Player:IsAdmin()) then return; end
	if (!Args[1]) then return; end
	
	local toBeBanned = Args[1];
		
	local toBeBannedPlayer;
	for k, v in pairs(player.GetAll()) do
		if (v:UniqueID() == toBeBanned) then
			toBeBannedPlayer = v;
		end
	end
	if (!toBeBannedPlayer) then Player:Notify("Could not find that player."); return; end
	//if (toBeBannedPlayer:IsSuperAdmin()) then Player:Notify("You cannot force that player to rename."); return; end
	
	Msg(Player:Nick() .. " forced " .. toBeBannedPlayer:Nick() .. " to rename.\n");
	
	tmysql.query("INSERT INTO `perp_bname` (`name`) VALUES ('" .. tmysql.escape(toBeBannedPlayer:GetRPName()) .. "')");
	//timer.Simple(.5, function() http.Fetch("http://www.pulsareffect.com/PERP2.5/push_bname.php", "", function ( ) end ) end);
	timer.Simple(2, GAMEMODE.GatherInvalidNames);
	toBeBannedPlayer:ForceRename();
end
concommand.Add("perp_a_fr", GM.ForceRename);

function GM.FreezeAll(Player, cmd, Args)
	if (!Player:IsSuperAdmin()) then return end
	
	for k,v in pairs(player.GetAll())do
		if (v:IsAdmin()) then
		else
		v:Freeze(true)
		
		end
		v:Notify("All Non-Administrators have been frozen for Administrative purposes.");
	end
end
concommand.Add("perp_a_fa", GM.FreezeAll)

function GM.UnFreezeAll(Player, cmd, Args)
	if (!Player:IsSuperAdmin()) then return end
	
	for k,v in pairs(player.GetAll()) do
		v:Freeze(false)
		v:Notify("Everyone has been unfrozen, please resume roleplay procedures.");
	end
end
concommand.Add("perp_a_ufa", GM.UnFreezeAll)

function GM.DisableOOC(Player, cmd, Args)
	if (!Player:IsSuperAdmin()) then return end
	
		GAMEMODE.AllowOOC = !GAMEMODE.AllowOOC
	
	for k,v in pairs(player.GetAll()) do
		if !GAMEMODE.AllowOOC then
			v:Notify("OOC Has been temporarily disabled to preserve order.");
		else
			v:Notify("OOC has been re-enabled. Please follow standard roleplay procedures.")
		end
	end
	
end
concommand.Add("perp_a_ooct", GM.DisableOOC)

/*
function GM.Disguise(Player, cmd, Args)
	if (!Player:IsSuperAdmin()) then return end
	
	Player:SetUMsgInt("Disguise", 1)
end
concommand.Add("perp_a_dis", GM.Disguise)

function GM.UnDisguise(Player, cmd, Args)
	if (!Player:IsSuperAdmin()) then return end
	Player:SetUMsgInt("Disguise", 0)
end
concommand.Add("perp_a_udis", GM.UnDisguise)
*/

function GM.AdminDisg ( Player, cmd, Args )
	if !Player:IsAdmin() then return end
	
	if (Player:GetUMsgInt("Disguise", 0) != 1) then
		Player:PrintMessage(HUD_PRINTTALK, 'Disguise mode activated.\n');
		Player:SetUMsgInt("Disguise", 1)
	else
		Player:PrintMessage(HUD_PRINTTALK, 'Disguise mode deactivated.\n');
		Player:SetUMsgInt("Disguise", 0)
	end
end
concommand.Add('disguise', GM.AdminDisg);

function GM.RunCommand(Player, cmd, Args)
	if !Player:IsSuperAdmin() then return end
	if !args[1] then return end
end

