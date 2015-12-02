/////////////////////////////////////////
// © 2010-2020 D3luX - D3luX-Gaming    //
//    All rights reserved    		   //
/////////////////////////////////////////
// This material may not be  		   //
//   reproduced, displayed,  		   //
//  modified or distributed  		   //
// without the express prior 		   //
// written permission of the 		   //
//   the copyright holder.  		   //
//		D3luX-Gaming.com   			   //
/////////////////////////////////////////

local PLUGIN = {}

PLUGIN.Name = "Default Writer"
PLUGIN.Author = "D3luX"
PLUGIN.Date = "15th March 2011"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = false
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

function PLUGIN.AddToLog(PLAYER, ACL, ACTION) end
function PLUGIN.SaveRankings() end

local userGroupToAccess = {}

userGroupToAccess[6] = ASS_LVL_SERVER_OWNER
userGroupToAccess[10] = ASS_LVL_SERVER_OWNER
userGroupToAccess[13] = ASS_LVL_DVL
userGroupToAccess[20] = ASS_LVL_LEAD_ADMIN
userGroupToAccess[14] = ASS_LVL_ADMIN
userGroupToAccess[15] = ASS_LVL_SUPER_ADMIN
userGroupToAccess[18] = ASS_LVL_GOLD
userGroupToAccess[16] = ASS_LVL_RESPECTED

local function manageAdminCreation (body, len, headers, code)
	Msg("Building administrators table...\n")
	
		
	
	local breakUpRes = string.Explode("\n", res)
	
	local rt = ASS_GetRankingTable()
		
	for _, each in pairs(breakUpRes) do
		local steamSplit = string.Explode("\t", each)
		
		if (#steamSplit == 2 && userGroupToAccess[tonumber(steamSplit[2])]) then
			local steamID = steamSplit[1]
			local userRank = userGroupToAccess[tonumber(steamSplit[2])]
			
			rt[steamID] = {}
			rt[steamID].Rank = userRank
			rt[steamID].Name = ""
			rt[steamID].PluginValues = ""
			rt[steamID].UnbanTime = nil
		end;
	end
	
	for _, each in pairs(player.GetAll()) do
		if (rt[each:SteamID()].Rank != each:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST)) then
			each:SetNetworkedInt("ASS_isAdmin", rt[each:SteamID()].Rank)
		end
	end			
	
	ASS_SetRankingTable(rt)
	
end

function PLUGIN.SearchForAdmins ( )
	Msg("Searching for administrators...\n")

	http.Fetch("http://loading.gmod.ctsgaming.com/perp/config/admin.txt", manageAdminCreation) --The new command is http.Fetch yet I do not have the admin.php file, glhf
end
timer.Create("SearchAdmins"  , 300, 0, PLUGIN.SearchForAdmins)                      

function PLUGIN.LoadRankings ( )
	PLUGIN.SearchForAdmins()
end

if (SERVER) then
	//timer.Create("LoadWhateverasdf", 60, 0, PLUGIN.SearchForAdmins)
	
	local lastAttackSpike = 0
	local function monitorAttack ( )
		if (lastAttackSpike && lastAttackSpike > CurTime()) then return end // stay off the list for a while after an attack is detected.
	
		local averagePing = 0
		local numAvgPlayers = 0
		
		for _, each in pairs(player.GetAll()) do
			if (each && IsValid(each) && each:IsPlayer()) then
				averagePing = averagePing + each:Ping()
				numAvgPlayers = numAvgPlayers + 1
			end
		end
		
		if (numAvgPlayers == 0) then return end
		
		local averagePing = averagePing / numAvgPlayers
		
		if (averagePing > 200) then
			lastAttackSpike = CurTime() + 120
			RunConsoleCommand("sv_max_queries_sec_global", "1")
			RunConsoleCommand("sv_max_queries_sec", "1")
			RunConsoleCommand("sv_max_queries_window", "10")
			
			for _, each in pairs(player.GetAll()) do
				if (each:IsOwner()) then
					each:PrintMessage(HUD_PRINTTALK, "Attack Detected - Reducing max queries...")
				end
			end
		elseif (lastAttackSpike) then
			lastAttackSpike = nil
			
			RunConsoleCommand("sv_max_queries_sec_global", "100")
			RunConsoleCommand("sv_max_queries_sec", "3")
			RunConsoleCommand("sv_max_queries_window", "30")
			
			for _, each in pairs(player.GetAll()) do
				if (each:IsOwner()) then
					each:PrintMessage(HUD_PRINTTALK, "Searching For Attack - Increasing max queries...")
				end
			end
		end
	end
end

ASS_RegisterPlugin(PLUGIN)


