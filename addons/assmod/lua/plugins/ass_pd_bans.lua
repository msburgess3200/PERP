local PLUGIN = {}

PLUGIN.Name = "Bans"
PLUGIN.Author = "RedMist"
PLUGIN.Date = ""
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = false
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

if (!SERVER) then return end

local PLAYER = FindMetaTable("Player")

local function FixedTime ( time )
	//if !time then return; end
	local fixedTime;
	local plural
	local months	= time / 40320;
	local weeks 	= time / 10080;
	local days		= time / 1440;
	local hours		= time / 60;
	local minutes	= time;
	
	//1342828951
	
	if time <= 0 then
		fixedTime = "Permanent";
	elseif time > 40320 then
		if months >= 2 then
			plural = "'s";
		else
			plural = "";
		end
	
		fixedTime = "" .. math.Round(months) .. " Month" .. plural .. "";
	elseif time > 10080 then
		if weeks >= 2 then
			plural = "'s";
		else
			plural = "";
		end

		fixedTime = "" .. math.Round(weeks) .. " Week" .. plural .. "";
	elseif time > 1440 then
		if days >= 2 then
			plural = "'s";
		else
			plural = "";
		end		

		fixedTime = "" .. math.Round(days) .. " Day" .. plural .. "";
	elseif time > 60 then
		if hours >= 2 then
			plural = "'s";
		else
			plural = "";
		end		

		fixedTime = "" .. math.Round(hours) .. " Hour" .. plural .. "";
	else
		if minutes >= 2 then
			plural = "'s";
		else
			plural = "";
		end
	
		fixedTime = "" .. math.Round(minutes) .. " Minute" .. plural .. "";
	end
	
	return fixedTime;
end

function UpdateBT ()
	tmysql.query("SELECT `unban_time`, `steamid` FROM `server_bans`", function ( unbantime )
		if unbantime[1] and unbantime[1][1] then
			for k, v in pairs(unbantime) do
				local numUnbanTime = tonumber(v[1])
				local newTime = numUnbanTime - os.time()
				newTime = newTime / 60;

				tmysql.query("UPDATE `server_bans` SET `unban_time_fixed`='" .. FixedTime(newTime) .. "' WHERE `steamid`='" .. v[2] .. "'");
			end
		end
	end)
	
end
timer.Create("UpdateBT", 20, 0, UpdateBT)
concommand.Add("thisisgay", UpdateBT)

local function ContinueBan (ply, bannerName, banTime, banReason, Res)
	local steamID = ply:SteamID()
	local unbanTime = os.time() + (banTime * 60)
	local banReasonFixed = tmysql.escape(banReason)
	local bannerNameFixed = tmysql.escape(bannerName)
	local bannedNameFixed = tmysql.escape(ply:Nick())
	
	if (banTime == 0) then unbanTime = 0 end
		
	tmysql.query("INSERT INTO `server_bans_logs` (`steamid`, `type`, `committed_by`, `reason`) VALUES ('" .. steamID .. "', 'server ban', '" .. bannerNameFixed .. "', '" .. banReasonFixed .. "')");
	
	if Res and Res[1] and Res[1][1] and tonumber(Res[1][1]) >= 5 then
		tmysql.query("INSERT INTO `server_bans` (`steamid`, `unban_time`, `unban_time_fixed`, `banner_name`, `reason`, `banned_name`) VALUES ('" .. steamID .. "', '0', 'Permanent', '" .. bannerNameFixed .. "', 'Struck Out ( " .. banReasonFixed .. " )', '" .. bannedNameFixed .. "')");
		ply:Kick('Struck Out ( ' .. banReason .. ' )');
	else
		tmysql.query("INSERT INTO `server_bans` (`steamid`, `unban_time`, `unban_time_fixed`, `banner_name`, `reason`, `banned_name`) VALUES ('" .. steamID .. "', '" .. unbanTime .. "', '" .. FixedTime(banTime) .. "', '" .. bannerNameFixed .. "', '" .. banReasonFixed .. "', '" .. bannedNameFixed .. "')");
	
		ply:Kick(banReason);	
	end
end

function PLAYER:PDBan ( bannerName, banTime, banReason )
	local steamID = self:SteamID()
	local unbanTime = os.time() + (banTime * 60)
	local monthFromNow = os.time() + (1440 * 60 * 31)
	local banReasonFixed = tmysql.escape(banReason)
	local bannerNameFixed = tmysql.escape(bannerName)
	local bannedNameFixed = tmysql.escape(self:Nick())
	
	if (banTime == 0) then unbanTime = 0 end
	
	if (banTime >= 1440 or banTime == 0) then
		local Res = tmysql.query("UPDATE `ip_intel` SET `strikes`=`strikes`+1 WHERE `steamid` = '" .. steamID .. "'");
		
		tmysql.query("INSERT INTO `server_bans_points` (`steamid`, `time`) VALUES ('" .. steamID .. "', '" .. monthFromNow .. "')");
		
		tmysql.query("SELECT `strikes` FROM `ip_intel` WHERE `steamid`='" .. steamID .. "'", 
			function ( Res )
				ContinueBan(self, bannerName, banTime, banReason, Res);
			end
		);
	else
		ContinueBan(self, bannerName, banTime, banReason);
	end
end