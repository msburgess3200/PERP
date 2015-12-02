local PLUGIN = {}

PLUGIN.Name = "Gatekeeper"
PLUGIN.Author = "RedMist"
PLUGIN.Date = "15th March 2011"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = false
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

if (!SERVER) then return end

require("tmysql")
require("gatekeeper")

GAMEMODE.Clients = {};
GAMEMODE.numPlayers = 4
GAMEMODE.ReservedSlots = 0

// log IPs
local function logIPs ( user )
	if (!user || !IsValid(user) || !user:IsPlayer() || !user.IPAddress || !user.SteamID || !user.Nick || !user.UniqueID) then return end
	local steamID = user:SteamID()
	local ipAddress = string.Explode(":", user:IPAddress())[1] or "INVALID IP ADDRESS"
	local name = user:Nick()
	local uniqueID = user:UniqueID()
	local curTime = os.time()
	
	user.playerJoinTime = CurTime()
	
	tmysql.query("INSERT INTO `ip_intel` (`steamid`, `ip`, `name`, `first_seen`, `last_seen`, `num_seen`, `unique_id`, `rp_name`, `play_time`) VALUES ('" .. steamID .. "', '" .. ipAddress .. "', '" .. name .. "', '" .. curTime .. "', '" .. curTime .. "', '1', '" .. uniqueID .. "', '', '0') ON DUPLICATE KEY UPDATE `ip`='" .. ipAddress .. "', `name`='" .. name .. "', `last_seen`='" ..curTime .. "', `num_seen`=`num_seen`+'1'")
end
hook.Add("PlayerInitialSpawn", "logIPs", logIPs)

local function saveNewPlayTime ( user )	
	if (!user || !IsValid(user) || !user:IsPlayer() || !user.playerJoinTime || !user.SteamID) then return end
	local addedPlayTime = math.floor(CurTime() - user.playerJoinTime)
	user.playerJoinTime = CurTime()
	
	tmysql.query("UPDATE `ip_intel` SET `play_time`=`play_time`+'" .. addedPlayTime .. "' WHERE `steamid`='" .. user:SteamID() .. "' LIMIT 1")
end
hook.Add("PlayerDisconnected", "saveNewPlayTime", saveNewPlayTime)

// Initialize Crypto PP
Msg("Loading gatekeeper module... ")
//needs an update
require("gatekeeper")

if (gatekeeper) then
	Msg("done!\n")
else
	Msg("failed! Locking server to maintain security...\n")
	RunConsoleCommand("sv_password", "nogate")
	return
end

local serverBans = {}
local serverBlacklists = {};

local function manageIncomingConnections ( Name, Pass, SteamID, IP )
	Msg(tostring(Name) .. " [" .. tostring(IP) .. "] joined with steamID " .. tostring(SteamID) .. ".\n")
	
	// We don't wanna mess with this if it's single player.
	if (game.SinglePlayer()) then return end
	if (!game.IsDedicated()) then return end
	
	// If they don't have steamids block them, as they may be trying to bypass the ban system.
	if (SteamID == "STEAM_ID_UNKNOWN") then return {false, "SteamID Error."}; end
	if (SteamID == "STEAM_ID_PENDING") then return {false, "SteamID Error."}; end
	
	// Get the time for everything.
	local curTime = os.time()
	
	// Check the bans list.
	if (serverBans[SteamID]) then
		local unbanTime = serverBans[SteamID]
		
		if (unbanTime == 0) then
			return {false, "You are permanently banned from Underscore Gaming."}
		elseif (unbanTime > curTime) then
			local timeLeft = unbanTime - curTime
			
			local Minutes = math.floor(timeLeft / 60)
			local Seconds = timeLeft - (Minutes * 60)
			local Hours = math.floor(Minutes / 60)
			local Minutes = Minutes - (Hours * 60)
			local Days = math.floor(Hours / 24)
			local Hours = Hours - (Days * 24)
			
			if (Minutes == 0 && Hours == 0 && Days == 0) then
				return {false, "Banned. Lifted In: " .. Seconds + 1 .. " Seconds"}
			elseif (Hours == 0 && Days == 0) then
				return {false, "Banned. Lifted In: " .. Minutes + 1 .. " Minutes"}
			elseif (Days == 0) then
				return {false, "Banned. Lifted In: " .. Hours + 1 .. " Hours"}
			else
				return {false, "Banned. Lifted In: " .. Days + 1 .. " Days"}
			end
		end
	end 
	
	if (GAMEMODE.IsSerious) then
		if (serverBlacklists[SteamID]) then
			local unbanTime = tonumber(serverBlacklists[SteamID]);
			
			if (unbanTime == 0) then
				return {false, "You are permanently blacklisted from Serious."};
			elseif (unbanTime > curTime) then
				local timeLeft = unbanTime - curTime;
				
				local Minutes = math.floor(timeLeft / 60);
				local Seconds = timeLeft - (Minutes * 60);
				local Hours = math.floor(Minutes / 60);
				local Minutes = Minutes - (Hours * 60);
				local Days = math.floor(Hours / 24);
				local Hours = Hours - (Days * 24);
				
				if (Minutes == 0 && Hours == 0 && Days == 0) then
					return {false, "Blacklisted from Serious. Lifted In: " .. Seconds + 1 .. " Seconds"};
				elseif (Hours == 0 && Days == 0) then
					return {false, "Blacklisted from Serious. Lifted In: " .. Minutes + 1 .. " Minutes"};
				elseif (Days == 0) then
					return {false, "Blacklisted from Serious. Lifted In: " .. Hours + 1 .. " Hours"};
				else
					return {false, "Blacklisted from Serious. Lifted In: " .. Days + 1 .. " Days"};
				end
			end
		end
	end
	
	// Make sure we're not overloaded.
	if (gatekeeper.GetNumClients().total >= GAMEMODE.numPlayers - GAMEMODE.ReservedSlots) then
		local rt = ASS_GetRankingTable()
		if (!rt[SteamID] || !rt[SteamID].Rank || !(rt[SteamID].Rank < ASS_LVL_ADMIN)) then
			if (gatekeeper.GetNumClients().total >= GAMEMODE.numPlayers) then
				return {false, "Server: Currently Maxed."}
			end
			return {false, "Server: Reserved Slots."}
		end
	end
	
	// I guess it's okay if they join...
	TCLI = gatekeeper.GetNumClients().total;
	GAMEMODE.Clients[tostring(SteamID)] = 0
	return;
end
hook.Add("PlayerPasswordAuth", "manageIncomingConnections", manageIncomingConnections)

function PlayerAuthed(ply, steamid, uid)
	Msg("Player Authed: " .. steamid .. "\n")
	local rt = ASS_GetRankingTable()
	if #GAMEMODE.Clients >= (GAMEMODE.numPlayers-GAMEMODE.ReservedSlots) then
		if (!rt[steamid] || !rt[steamid].Rank || !(rt[SteamID].Rank < ASS_LVL_ADMIN)) then
			ply:Kick("Nice try to bypass the reserved slots.")
		end
	end
end
hook.Add("PlayerAuthed", "Authed", PlayerAuthed)

function PlayerDisconnect(ply)
	GAMEMODE.Clients[ply:SteamID()] = nil
end
hook.Add("PlayerDisconnected", "PlayerDisconnect", PlayerDisconnect)

	

local function manageBanCreation ( res )
	serverBans = {}
	
	for _, ban in pairs(res) do
		serverBans[ban[1]] = tonumber(ban[2])
	end
end

local function manageBlacklistCreation ( res )
	if (!res || !res[1]) then return; end
	
	serverBlacklists = {};
	
	for k, v in pairs(res) do
		local explodeLarge = string.Explode(";", v[2]);
		
		for _, chunk in pairs(explodeLarge) do
			local explodeMore = string.Explode(",", chunk);
						
			if (#explodeMore == 2 && explodeMore[1] == 'b') then
				serverBlacklists[v[1]] = tonumber(explodeMore[2]);
			end	
		end
	end
end

//uhmmmm
local function timerForCreationism ( )

	timer.Simple(10, function() tmysql.query("DELETE FROM `server_bans` WHERE `unban_time`<'" .. os.time() .. "' AND `unban_time`!= '0'") end)
	//timer.Simple(10, tmysql.query, "DELETE FROM `server_bans` WHERE `unban_time`<'" .. os.time() .. "' AND `unban_time`!= '0'")
	
	if (GAMEMODE.IsSerious) then
		timer.Simple(1.5, function() tmysql.query("SELECT `steamid`, `blacklists` FROM `perp_users` WHERE `blacklists` LIKE '%b,%'", manageBlacklistCreation) end)
		//timer.Simple(1.5, tmysql.query, "SELECT `steamid`, `blacklists` FROM `perp_users` WHERE `blacklists` LIKE '%b,%'", manageBlacklistCreation);
	end
	timer.Simple(3, function() tmysql.query("SELECT `steamid`, `unban_time` FROM `server_bans`", manageBanCreation) end)
	//timer.Simple(3, tmysql.query, "SELECT `steamid`, `unban_time` FROM `server_bans`", manageBanCreation)
end
timer.Create('timerForCreationism', 5, 0,timerForCreationism)

local function rebuildlists ( )
	timer.Simple(10, function() tmysql.query("DELETE FROM `server_bans` WHERE `unban_time`<'" .. os.time() .. "' AND `unban_time`!= '0'") end)
	//timer.Simple(10, tmysql.query, "DELETE FROM `server_bans` WHERE `unban_time`<'" .. os.time() .. "' AND `unban_time`!= '0'")
	
	if (GAMEMODE.IsSerious) then
		timer.Simple(1.5, function() tmysql.query("SELECT `steamid`, `blacklists` FROM `perp_users` WHERE `blacklists` LIKE '%b,%'", manageBlacklistCreation) end)
		//timer.Simple(1.5, tmysql.query, "SELECT `steamid`, `blacklists` FROM `perp_users` WHERE `blacklists` LIKE '%b,%'", manageBlacklistCreation);
	end
	
	timer.Simple(3, function() tmysql.query("SELECT `steamid`, `unban_time` FROM `server_bans`", manageBanCreation) end)
	//timer.Simple(3, tmysql.query, "SELECT `steamid`, `unban_time` FROM `server_bans`", manageBanCreation)
end
concommand.Add("perp_rebuild_lists", rebuildlists);

// Anti-Tranquility / Serenity

local tranquilityUsers = {}
local tranquilityNextThink = CurTime()
local tranquilityEnabled = true
local tranquilityTimeout = 30
Msg("Tranquility: Connected to steam.\n")

local function tranqKick ( steamID, reason )
	if (game.SinglePlayer()) then tranquilityUsers[steamID] = nil; return end

	local userID = gatekeeper.GetUserByAddress(tranquilityUsers[steamID].IP)
	
	if (userID) then
		gatekeeper.Drop(userID, "SteamID Validation Failed (" .. tostring(reason) .. ")\n")
	end
	
	tranquilityUsers[steamID] = nil
end

hook.Add("GSSteamConnected", "AntiTranqConnected", function ( )  
	tranquilityEnabled = true
	Msg("Tranquility: Connected to steam.\n")
end)

hook.Add("GSSteamDisconnected", "AntiTranqConnected", function ( reason )  
	tranquilityEnabled = false
	tranquilityUsers = {}
	
	Msg("Tranquility: Disconnected from steam - " .. reason .. "\n")
end)

hook.Add("GSClientApprove", "AntiTranqApprove", function ( steam )
	Msg("Tranquility: Approved " .. steam .. "\n")
	tranquilityUsers[steam] = nil
end)

hook.Add("GSClientDeny", "AntiTranqDeny", function ( steam, reason, msg )
	Msg("Tranquility: Denied " .. steam .. " (Reason: " .. reason .. "): " .. msg .. "\n")
	tranqKick(steam, reason)
end)

hook.Add("GSPlayerAuth", "AntiTranqConnect", function ( name, pass, steam, ip )
	if (tonumber(steam)) then return end
	
	Msg("Tranquility: Authorizing " .. steam .. "...\n")
	
	tranquilityUsers[steam] = {
		IP = ip,
		ConnectTime = CurTime(),
	}
end)

hook.Add("Think", "AntiTranqThink", function ( )
	if (tranquilityNextThink >= CurTime() || !tranquilityEnabled) then return end
	
	for steamID, each in pairs(tranquilityUsers) do
		local connectedTime = CurTime() - each.ConnectTime
		
		if (connectedTime >= tranquilityTimeout) then
			tranqKick(steamID, "timeout")
		end
	end
	
	tranquilityNextThink = CurTime() + 1
end)

// SLog
//Msg("Loading slog module... ");

if (!game.IsDedicated()) then
	Msg("disabled! (SLog not required for local servers.)\n");
	return
end

//require("slog");

-- if (file.Exists("../lua/includes/modules/gm_slog.dll", "GAME")) then
-- 	Msg("done!\n");
-- else
-- 	Msg("failed!\n");
-- end

local SLOGKicked = {
	"net_showevents",
	"~initnetworking",
}

local SLOGBlocked = {
	"dump_hooks",
	"se fail",
	"soundscape_flush",
	"hammer_update_entity",
	"physics_constraints",
	"physics_debug_entity",
	"physics_select",
	"physics_budget",
	"sv_soundemitter_flush",
	"rr_reloadresponsesystems",
	"sv_soundemitter_filecheck",
	"sv_soundscape_printdebuginfo",
	"dumpentityfactories",
	"dump_globals",
	"dump_entity_sizes",
	"dumpeventqueue",
	"dbghist_addline",
	"dbghist_dump",
	"groundlist",
	"report_simthinklist",
	"report_entities",
	"server_game_time"
};

local DontShow = {
	"headcrab",
	"say",
	"sf_",
	"~sf_",
	"bhop_",
	"setpassword",
	"linkaccount",
	"cnc",
	"dr_",
	"st_",
	"rp_",
	"rs_",
	"wire_",
	"gms_",
	"status",
	"kill",
	"myinfo",
	"phys_swap",
	"+ass_menu",
	"-ass_menu",
	"explode",
	"suitzoom",
	"feign_death",
	"gm_showhelp",
	"gm_showteam",
	"gm_showspare1",
	"gm_showspare2",
	"+gm_special",
	"-gm_special",
	"vban",
	"vmodenable",
	"se auth",
	"ulib_cl_ready",
	"noclip",
	"kill",
	"undo",
	"jukebox",
	"debugplayer",
	"gmod_undo",
	"pt",
	"net_graph",
	"se",
	"pe_",
};

local logPush = {};
local function pushLogReal ( steamID )
	if (!logPush[steamID]) then return; end
	
	local numWhat = string.len(string.Explode(":", steamID)[3]);
	
	if (!file.IsDir("slog/" .. numWhat)) then file.CreateDir("slog/" .. numWhat); end
	
	local fName = "slog/" .. numWhat .. "/" .. string.gsub(steamID, ":", "_") .. ".txt";
	
	local preBuffer = "";
	if (file.Exists(fName)) then preBuffer = file.Read(fName); end
	
	local postBuffer = "";
	for k, v in pairs(logPush[steamID]) do
		postBuffer = postBuffer .. v;
	end
	
	file.Write(fName, preBuffer .. postBuffer);
	
	logPush[steamID] = nil;
end

local function PushLog ( steamID, message )
	if (timer.IsTimer("slog_log_" .. steamID)) then timer.Destroy("slog_log_" .. steamID); end
		
	logPush[steamID] = logPush[steamID] or {};
	table.insert(logPush[steamID], message);
	
	timer.Create("slog_log_" .. steamID, 30, 1, pushLogReal, steamID);
end


function Cmd_RecvCommand ( Name, Buffer )
	local Ply = false
	for k,v in ipairs(player.GetAll()) do
		if(v and v:IsValid()) then
			if(v:GetName() == Name) then
				Ply = v
				break
			end
		end
	end
	
	local Return = false
	local StringMessage = false
	local BlockedMessage = false
	local Trimed = string.Trim(Buffer)
	local Buffer = string.lower(Trimed)
	
	if(!Ply or !Ply:IsValid()) then
		if(string.find(Buffer, "say") != nil) then
			return true
		end
	end
	
	local Search = true
	if (string.find(string.sub(Buffer, 1, 4), "perp")) then
		Search = false
	else
		for k,v in pairs(DontShow) do
			local vString = string.Trim(string.lower(v))
			local vLength = string.len(vString)
			if(string.sub(Buffer, 1, vLength) == vString) then
				Search = false
				break
			end
		end
	end
	
	if(!Search) then
		return false
	end
	
	for k,v in pairs(SLOGBlocked) do
		local vString = string.Trim(string.lower(v))
		if(Buffer == vString or string.find(Buffer, vString) != nil) then
			Return = true
			if(Ply) then
				BlockedMessage = true
				StringMessage = "#Found Blocked Command: "..string.format("%s (%s) Ran: %s\n", Ply:Nick(), Ply:SteamID(), Trimed)
			end
		end
	end
	
	for k,v in pairs(SLOGKicked) do
		local vString = string.Trim(string.lower(v))
		if(Buffer == vString or string.find(Buffer, vString) != nil) then
			Return = true
			if(Ply) then
				BlockedMessage = true
				StringMessage = "#Found AutoKick Command: "..string.format("%s (%s) Ran: %s\n", Ply:Nick(), Ply:SteamID(), Trimed)
				
				Ply:Kick("Use of banned console command");
			end
		end
	end
	
	if(Ply and Ply:IsValid()) then
		local Log = string.format("[%s] %s (%s) Ran: %s\n", os.date("%c"), Ply:Nick(), Ply:SteamID(), Trimed)
		if (!BlockedMessage) then
			StringMessage = "#"..Log
		end
		
		PushLog(Ply:SteamID(), StringMessage);
		
		Ply.NumCommandsAdded = Ply.NumCommandsAdded or 0;
		Ply.NumCommandsAdded = Ply.NumCommandsAdded + 1;
		
		timer.Simple(1, function ( ) if (IsValid(Ply)) then Ply.NumCommandsAdded = Ply.NumCommandsAdded - 1; end end);
		
		if (Ply.NumCommandsAdded >= 20 && !Ply.SlogBanned) then
			Ply.SlogBanned = true;
			Ply:PERPBan(24, "Attempted Exploitation");
		end
	end
	
	if(Ply and Ply:IsValid() and string.find(Buffer, "lua_run_cl")) then
		Ply:ChatPrint("You have a malicious bind! Type 'key_findbinding lua_run_cl' in console and rebind those keys or go to Game Menu->Options->Keyboard->Use Defaults")
		return Return
	end
	
	if(StringMessage) then
		for k,v in pairs(player.GetAll()) do
			if(v and v:IsValid() && v:IsAdmin()) then
				if(BlockedMessage) then
					v:PrintMessage(HUD_PRINTTALK, StringMessage)
				elseif (v:IsAdmin()) then
					v:PrintMessage(HUD_PRINTCONSOLE, StringMessage)
				end
			end
		end
	end
	
	return Return
end

if (!file.IsDir("slog", "LUA")) then file.CreateDir("slog", "LUA"); end