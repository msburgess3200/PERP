	require('tmysql');

local function PlayerSave ( ply )
	if (!IsValid(ply)) then
		return;
	end
			
	ply:Save();
end

GM.OrganizationData = {};
GM.OrganizationMembers = {};

function GM.LoadPlayerProfile ( Player )
	if (Player.AlreadyLoaded) then return false; end
	
	Player.SMFID = Player:SteamID()
	Player.Buddies = Player.Buddies or {}
	
	Msg("Loading " .. Player:Nick() .. "...\n");
	
	if (!Player.StartedSendingVars) then
		Player.StartedSendingVars = true;
	
		Msg("Starting var transfer to " .. Player:Nick() .. "...\n");
		local curNum = 5;
		for _, p in pairs(player.GetAll()) do
			if (p != Player && p.StringRedun) then
				for k, v in pairs(p.StringRedun) do
					curNum = curNum + .2;
					
					timer.Simple(curNum, function ( )
						if (Player && IsValid(Player)) then
							if (!p || !IsValid(p) || !p.StringRedun[k]) then
								umsg.Start("perp_umsg_f", Player);
								umsg.End();
							else
								Player:SendUMsgVar("perp_ums", Player, p, k, v.value, true);
							end
						end
					end);
				end
			end
		end
		
		umsg.Start("perp_expect", Player);
			umsg.Short((curNum - 5) * 5);
		umsg.End();
	end

	tmysql.query("SELECT `id`, `rp_name_first`, `rp_name_last`, `time_played`, `cash`, `model`, `items`, `storage`, `skills`, `genes`, `formulas`, `organization`, `bank`, `vehicles`, `blacklists`, `ringtone`, `ammo_pistol`, `ammo_rifle`, `ammo_shotgun`, `fuelleft`, `lastcar` FROM `perp_users` WHERE `id`='" .. Player.SMFID .. "'", function ( PlayerInfo )
		if (!Player || !Player:IsValid() || !IsValid(Player)) then return end
	
		if (!PlayerInfo || !PlayerInfo[1]) then
			tmysql.query("INSERT INTO `perp_users` (`id`, `uid`, `steamid`, `rp_name_first`, `rp_name_last`, `time_played`, `cash`, `model`, `items`, `skills`, `genes`, `formulas`, `organization`, `bank`, `vehicles`, `ringtones`, `ringtone`, `last_played`) VALUES ('" .. Player.SMFID .. "', '" .. Player:UniqueID() .. "', '" .. Player:SteamID() .. "', 'John', 'Doe', '5', '15000', '', '', '', '5', '', '0', '0', '', '', '1', '0')", function (...)
			PrintTable({...})
			tmysql.query("INSERT INTO `perp_fuel` (`uid`) VALUES ('" .. Player:UniqueID() .. "')");
				if (!Player || !Player:IsValid() || !IsValid(Player)) then return end
				
				Player.CanSetupPlayer = true;
				timer.Simple(1, function()
					GAMEMODE.LoadPlayerProfile(Player); end)
			end);
			return;
		end
		if (PlayerInfo[1][2] == "John" && PlayerInfo[1][3] == "Doe") then Player.CanSetupPlayer = true; end
		
		if (Player.CanSetupPlayer) then
			Msg("Allowing " .. Player:Nick() .. " to setup new player...\n");
			umsg.Start("perp_newchar", Player);
			umsg.End();
		else
		end
		
		Player.joinTime = CurTime();
		

		// Public UMsg Vars
		Player:SetUMsgString("rp_fname", PlayerInfo[1][2]);
		Player:SetUMsgString("rp_lname", PlayerInfo[1][3]);
		Player:SetUMsgInt("ringtone", tonumber(PlayerInfo[1][16]));
		
		// Ammo
		Player:GiveAmmo(tonumber(PlayerInfo[1][17]), 'pistol');
		Player:GiveAmmo(tonumber(PlayerInfo[1][18]), 'smg1');
		Player:GiveAmmo(tonumber(PlayerInfo[1][19]), 'buckshot');
		
		// Private UMsg Vars - This part only sets it for the server. It's also sent to the client via the next section.
		Player:SetPrivateInt("time_played", tonumber(PlayerInfo[1][4]), true);
		Player:SetPrivateInt("cash", tonumber(PlayerInfo[1][5]), true);
		Player:SetPrivateInt("bank", tonumber(PlayerInfo[1][13]), true);
		Player:SetPrivateString("blacklists", PlayerInfo[1][15]);
		Player:SetPrivateInt("fuelleft", tonumber(PlayerInfo[1][20]), true);
		Player:SetPrivateString("lastcar", PlayerInfo[1][21] or "a");

		
		if (PlayerInfo[1][15] != "") then
			Player:RecompileBlacklists();
		end
		
		// Model
		local modelInfo = GAMEMODE.ExplodeModelInfo(PlayerInfo[1][6]) or {};
		local theirNewModel = Player:GetModelPath(modelInfo.sex or "m", tonumber(modelInfo.face) or 1, tonumber(modelInfo.clothes) or 1);
		Player:SetModel(theirNewModel);
		Player:SetPrivateString("model", theirNewModel);
		Player.PlayerModel = theirNewModel;
		Player.PlayerSex = modelInfo.sex or "m";
		Player.PlayerClothes = modelInfo.clothes;
		Player.PlayerFace = tonumber(modelInfo.face) or 1;
		Player.PlayerItems = {}
		Player.StorageItems = {}
		
		// Sending the above private UMsg vars to the client.
		umsg.Start("perp_startup", Player)
			umsg.String(tostring(PlayerInfo[1][4]));	// Time Played
			umsg.Long(tonumber(PlayerInfo[1][5])); 		// Cash
			umsg.Long(tonumber(PlayerInfo[1][13])); 	// Bank Cash
			umsg.Long(tonumber(PlayerInfo[1][20]));		// Fuel Left
			umsg.Short(GAMEMODE.CurrentTime);			// Game Time
			umsg.Short(GAMEMODE.CurrentDay);			// Game Day
			umsg.Short(GAMEMODE.CurrentMonth);			// Game Month
			umsg.Short(GAMEMODE.CurrentYear);			// Game Year
		umsg.End();
		
		/*
		umsg.Start("perp_lastcar", Player)
			umsg.String(tostring(PlayerInfo[1][21]));
		umsg.End();
		*/
		
		//switched to datastream cause of usermessage byte limit
		//no more datastream in gmod 13?
		
		//Inventory
		net.Start("ItemHook")
		net.WriteString(PlayerInfo[1][7])
		net.Send(Player)

		--datastream.StreamToClients(Player, "ItemHook", PlayerInfo[1][7]);
		//Bank Storage
		--datastream.StreamToClients(Player, "StorageHook", PlayerInfo[1][8]);
		net.Start("StorageHook")
		net.WriteString(PlayerInfo[1][8])
		net.Send(Player)

		
		Player:parseSaveString(PlayerInfo[1][7]);
		Player:parseSSaveString(PlayerInfo[1][8]);
		
		// Load Vehicles...
		// should probably switch this to datastream too...
		timer.Simple(1, function ( )
			if (Player && IsValid(Player)) then
				umsg.Start("perp_vehicles_init", Player)
					umsg.String(PlayerInfo[1][14]);
				umsg.End();
			end
		end);
		
		Player.Vehicles = {};
		Player:parseVehicleString(PlayerInfo[1][14]);
		
		// mixtures
		Player:SetPrivateString("mixtures", PlayerInfo[1][11]);
		
		// Skills
		local ExplodeSkills = string.Explode(";", PlayerInfo[1][9]);
		for i = 1, #SKILLS_DATABASE do	
			if ExplodeSkills[i] && (i != #ExplodeSkills) then
				Player:SetPrivateInt("s_" .. i, tonumber(ExplodeSkills[i]));
				local postLevel = Player:GetPERPLevel(SKILLS_DATABASE[i][1]);
				Player:AchievedLevel(SKILLS_DATABASE[i][1], tonumber(postLevel));
			end
		end
		
		// Genes
		local ExplodeGenes = string.Explode(";", PlayerInfo[1][10]);
		
		if (#ExplodeGenes > 1) then
			for i = 1, #GENES_DATABASE do			
				if ExplodeGenes[i + 1] && (i != #ExplodeGenes) then
					Player:SetPrivateInt("g_" .. i, tonumber(ExplodeGenes[i + 1]));
					local postLevel = Player:GetPERPLevel(GENES_DATABASE[i][1]);
					Player:AchievedLevel(GENES_DATABASE[i][1], tonumber(postLevel));
				end
			end
		end
		
		if (ExplodeGenes[1]) then
			Player:SetPrivateInt("gpoints", tonumber(ExplodeGenes[1]));
		end
		
		// Check his name...
		if (!Player.CanSetupPlayer && !GAMEMODE.IsValidName(Player:GetFirstName(), Player:GetLastName())) then
			Player:ForceRename();
		end
		
		// Organization
		local org = tonumber(PlayerInfo[1][12]);
		if (org != 0) then
			Player:SetUMsgInt("org", org);
			
			if (!GAMEMODE.OrganizationMembers[org]) then
				GAMEMODE.FetchOrganizationData(org);
			end
		end
		
		// Set Varaibles
		Player.AlreadyLoaded = true;
		
		local ourID = Player:SteamID();
		timer.Create(ourID, 60, 0, PlayerSave, Player);
		
		// Make them bitches load their weapons
		Player:EquipMains();
	end);
	
	tmysql.query("SELECT `member_name`, `id_group`, `email_address` FROM `smf_members` WHERE `aim`='" .. Player:SteamID() .. "'", function ( WebsiteInfo )
	
		if (!WebsiteInfo[1] || !WebsiteInfo[1][1]) then return; end
		
		umsg.Start("perp_accountinfo", Player);
			umsg.String(tostring(WebsiteInfo[1][1]));		//UserName
			umsg.String(tostring(WebsiteInfo[1][2]));							//Group
			umsg.String(tostring(WebsiteInfo[1][3]));		//Email
		umsg.End();
	
	end)
end
concommand.Add('perp_lp', GM.LoadPlayerProfile);

function GM.ChangeEmail ( Player, Cmd, Args )
	if (!Args[1]) then return; end
	if (Args[2] != Player:UniqueID()) then return; end
	
	local EMail = Args[1];
	
	tmysql.query("SELECT `member_name` FROM `smf_members` WHERE `aim`='" .. Player:SteamID() .. "'", function ( MemberName )
		
		if (!MemberName[1] || !MemberName[1][1]) then return; end
	
		tmysql.query("UPDATE `smf_members` SET `email_address`='" .. tmysql.escape(EMail) .. "' WHERE `aim`='" .. Player:SteamID() .. "'")
		tmysql.query("UPDATE `tgbh2_users` SET `email`='" .. tmysql.escape(EMail) .. "' WHERE `username`='" .. MemberName[1][1] .. "'")
		
		Player:Notify("Email changed to '" .. EMail .. "'");
		
		GAMEMODE.LoadPlayerProfile(Player)
		
	end)
	
end
concommand.Add("perp_changeemail", GM.ChangeEmail)

function GM.NewCharacterCreation ( Player, Cmd, Args )
	if (!Player.CanSetupPlayer) then return false; end
	
	Player.CanSetupPlayer = nil;
	
	local Model = Args[1];
	local FirstName = string.upper(string.sub(Args[2], 1, 1)) .. string.lower(string.sub(Args[2], 2));
	local LastName = string.upper(string.sub(Args[3], 1, 1)) .. string.lower(string.sub(Args[3], 2));
	local UN, PW = Args[4], Args[5];
	
	if (!Model || !FirstName || !LastName) then
		Player:ForceRename();
		return;
	end
	
	if (!UN || !PW) then
		Player:ForceFUN();
		return;
	end
	
	// Model Stuff
	local modelInfo = GAMEMODE.ExplodeModelInfo(Model) or {};
	local theirNewModel = Player:GetModelPath(modelInfo.sex or "m", tonumber(modelInfo.face) or 1, tonumber(modelInfo.clothes) or 1);
	
	Player:SetModel(theirNewModel);
	Player.PlayerModel = theirNewModel;
	tmysql.query("UPDATE `perp_users` SET `model`='" .. modelInfo.sex .. "_" .. modelInfo.face .. "_" .. modelInfo.clothes .. "' WHERE `id`='" .. Player.SMFID .. "'");
	
	if (!GAMEMODE.IsValidName(FirstName, LastName)) then 
		Player:ForceRename();
		return; 
	end
	
	tmysql.query("SELECT `id` FROM `perp_users` WHERE `rp_name_first`='" .. FirstName .. "' AND `rp_name_last`='" .. LastName .. "' LIMIT 1", function ( someoneElseHas )
		if (!Player or !IsValid(Player) or !Player:IsValid()) then 
			return; 
		end
				
		if (someoneElseHas && someoneElseHas[1] && someoneElseHas[1][1]) then
			Player:Notify("That name is already taken.\n");
			Player:ForceRename();
			return; 
		end
		
			tmysql.query("SELECT `id_member` FROM `smf_members` WHERE `member_name`='" .. tmysql.escape(UN) .. "' LIMIT 1", function ( someoneElseHasFun )
			if (!Player or !IsValid(Player) or !Player:IsValid()) then 
				return; 
			end 	
			

			tmysql.query("INSERT INTO `smf_members` (`member_name`, `id_group`, `real_name`, `passwd`, `email_address`, `icq`, `aim`, `yim`, `msn`, `member_ip`) VALUES ('" .. tmysql.escape(UN) .. "', '4', '" .. tmysql.escape(UN) .. "', MD5('" .. PW .. "'), '" .. Player:UniqueID() .. "' '@gmail.com', '" .. tmysql.escape(Player:Nick()) .. "', '" .. Player:SteamID() .. "', '" .. FirstName .. "', '" .. LastName .. "', '" .. Player:IPAddress() .. "')");
			tmysql.query("UPDATE `perp_users` SET `rp_name_first`='" .. FirstName .. "',`rp_name_last`='" .. LastName .. "' WHERE `id`='" .. Player.SMFID .. "'");
			tmysql.query("SELECT `id_member` FROM `smf_members` WHERE `aim`='" .. Player:SteamID() .. "'", function ( IDMEMBER )

				
				tmysql.query("INSERT INTO `smf_themes` (`id_member`, `id_theme`, `variable`, `value`) VALUES ('" .. IDMEMBER[1][1] .. "', '1', 'cust_rpname', '" .. FirstName .. "' ' ' '" .. LastName .. "')")
				tmysql.query("INSERT INTO `smf_themes` (`id_member`, `id_theme`, `variable`, `value`) VALUES ('" .. IDMEMBER[1][1] .. "', '1', 'cust_steami', '" .. Player:SteamID() .. "')")
			
			end);
			
			if (someoneElseHasFun && someoneElseHasFun[1] && someoneElseHasFun[1][1]) then
				Player:Notify("That username is already taken.\n");
				Player:ForceFUN();
				return; 
			end
			
	
		Player:SetUMsgString("rp_fname", FirstName);
		Player:SetUMsgString("rp_lname", LastName);
		

		
	end);	end);
	
end
concommand.Add('perp_nc', GM.NewCharacterCreation);

local PLAYER = FindMetaTable("Player")

function PLAYER:LoadingDead ( deathTime )
	if self.AlreadyLoaded then
		timer.Destroy("DeadLoad");
		self.RespawnTime = CurTime() + deathTime;
		self:Notify("You must finish the remainder of your death time");
		self:Freeze(false);
		self:Kill();
	end
end

function PLAYER:GetSpawnPosition ( )
	
	tmysql.query("SELECT `vector`, `angle`, `deathtime` FROM `perp_spawn_locations` WHERE `steamid`='" .. self:SteamID() .. "'", function ( SpawnPos )
		
		if (SpawnPos[1] and SpawnPos[1][1]) then
			local vector 	= string.Explode(" ", SpawnPos[1][1]);
			local angle 	= string.Explode(" ", SpawnPos[1][2]);
			local deathTime = tonumber(SpawnPos[1][3]);
			
			self:SetPos(Vector(vector[1], vector[2], vector[3]));
			self:SetEyeAngles(Angle(angle[1], angle[2], angle[3]));
			
			if deathTime > 0 then
				self:Freeze(true);
				timer.Create("DeadLoad", 2, 0, function () self:LoadingDead(deathTime); end);
			end
		end
	
	end);
	
end

function PLAYER:SetSpawnPosition ( spawnVector, spawnAngle, deathTime, steamID )
	
	local stringVector = string.Explode(" ", spawnVector)
	
	for k, v in pairs(OwnableDoors) do
		local nearDoor = math.Dist(v[1], v[2], stringVector[1], stringVector[2])
	
		if nearDoor <= 1100 && self:IsInside() then
			return;
		end
	end

	if !deathTime then
		deathTime = 0
	end

	tmysql.query("SELECT `steamid`, `vector`, `angle`, `deathtime` FROM `perp_spawn_locations` WHERE `steamid`='" .. self:SteamID() .. "'", function ( SpawnPos )
		
		if (SpawnPos[1] and SpawnPos[1][1]) then
			tmysql.query("UPDATE `perp_spawn_locations` SET `vector`='" .. spawnVector .. "',`angle`='" .. spawnAngle .. "',`deathtime`='" .. deathTime .. "' WHERE `steamid`='" .. steamID .. "'");
		else
			tmysql.query("INSERT INTO `perp_spawn_locations` (`steamid`, `vector`, `angle`, `deathtime`) VALUES ('" .. steamID .. "', '" .. spawnVector .. "', '" .. spawnAngle .. "', '" .. deathTime .. "')")
		end

	end);
end

function GM.SetSpawnPos ( Player, Cmd, Args )

	local spawnPos = tostring(Player:GetPos());
	local spawnAng = tostring(Player:GetAngles());
	
	Player:SetSpawnPosition(spawnPos, spawnAng, 0, Player:SteamID())
	
end
concommand.Add("perp_save_pos", GM.SetSpawnPos);

function GM.ChangeName ( Player, Cmd, Args )
	if (Args[3] != Player:UniqueID()) then return; end
	local FirstName = string.upper(string.sub(Args[1], 1, 1)) .. string.lower(string.sub(Args[1], 2));
	local LastName = string.upper(string.sub(Args[2], 1, 1)) .. string.lower(string.sub(Args[2], 2));
	
	if (!FirstName || !LastName) then return; end
	
	if (!Player.CanRenameFree) then
		if (Player:GetCash() < GAMEMODE.RenamePrice) then
			return;
		end
			
		Player:TakeCash(GAMEMODE.RenamePrice, true);
	end
	
	if (!GAMEMODE.IsValidName(FirstName, LastName)) then 
		Player:ForceRename();
		return; 
	end
	
	tmysql.query("SELECT `id` FROM `perp_users` WHERE `rp_name_first`='" .. FirstName .. "' AND`rp_name_last`='" .. LastName .. "' LIMIT 1", function ( someoneElseHas )
		if (!Player or !IsValid(Player) or !Player:IsValid()) then return; end
		
		if (someoneElseHas && someoneElseHas[1] && someoneElseHas[1][1]) then
			Player:Notify("That name is already taken.\n");
			Player:ForceRename();
			return; 
		end
		
		Player.CanRenameFree = nil;
		
		Player:SetUMsgString("rp_fname", FirstName);
		Player:SetUMsgString("rp_lname", LastName);
		tmysql.query("UPDATE `smf_members` SET `yim`='" .. FirstName .. "',`msn`='" .. LastName .. "' WHERE `aim`='" .. Player:SteamID() .. "'");
		tmysql.query("UPDATE `perp_users` SET `rp_name_first`='" .. FirstName .. "',`rp_name_last`='" .. LastName .. "' WHERE `id`='" .. Player.SMFID .. "'");
	
			tmysql.query("SELECT `id_member` FROM `smf_members` WHERE `aim`='" .. Player:SteamID() .. "'", function ( IDMEMBER )

			tmysql.query("UPDATE `smf_themes` SET `value`='" .. FirstName .. "' ' ' '" .. LastName .. "' WHERE `id_member`='" .. IDMEMBER[1][1] .. "' AND `variable`='cust_rpname'");
			tmysql.query("UPDATE `smf_themes` SET `value`='" .. Player:SteamID() .. "' WHERE `id_member`='" .. IDMEMBER[1][1] .. "' AND `variable`='cust_steami'");
			
			end);
	end);
end
concommand.Add("perp_MOFUCKA_cn", GM.ChangeName);

function GM.ChangeFUN ( Player, Cmd, Args )
	if (Args[2] != Player:UniqueID()) then return; end
	local FUName = string.upper(string.sub(Args[1], 1, 1)) .. string.lower(string.sub(Args[1], 2));
	
	if (!FUName) then return; end
	
	tmysql.query("SELECT `id_member` FROM `smf_members` WHERE `member_name`='" .. FUName .. "' LIMIT 1", function ( someoneElseHasFun )
		if (!Player or !IsValid(Player) or !Player:IsValid()) then return; end
		
		if (someoneElseHasFun && someoneElseHasFun[1] && someoneElseHasFun[1][1]) then
			Player:Notify("That username is already taken.\n");
			Player:ForceFUN();
			return; 
		end
		
		Player:SetUMsgString("rp_funame", FUName);
		
		tmysql.query("UPDATE `smf_members` SET `member_name`='" .. FUName .. "' WHERE `aim`='" .. Player:SteamID() .. "'");
	end);
end
concommand.Add("perp_MOFUCKA_fun", GM.ChangeFUN)

function GM.ChangeFace ( Player, Cmd, Args )
	if (!Player) then return; end
	if (!Args[1]) then return; end
	if (Player:Team() != TEAM_CITIZEN) then return; end
	
	local Model = Args[1];
	
	// Model Stuff
	local modelInfo = GAMEMODE.ExplodeModelInfo(Model);
	if (!modelInfo) then return; end
	
	local newSex = SEX_MALE;
	if (modelInfo.sex == 'f') then newSex = SEX_FEMALE; end
	if (tonumber(modelInfo.sex) == 2) then newSex = SEX_FEMALE; end
	if (Player:GetSex() != newSex) then return; end
	if (Player:GetClothes() != modelInfo.clothes) then return; end
	
	Player:TakeCash(GAMEMODE.FacialPrice, true);
	
	local theirNewModel = Player:GetModelPath(modelInfo.sex or "m", tonumber(modelInfo.face) or 1, tonumber(modelInfo.clothes) or 1);
	
	Player:SetModel(theirNewModel);
	Player.PlayerModel = theirNewModel;
	tmysql.query("UPDATE `perp_users` SET `model`='" .. modelInfo.sex .. "_" .. modelInfo.face .. "_" .. modelInfo.clothes .. "' WHERE `id`='" .. Player.SMFID .. "'");
	
	Player:SetPrivateString("model", theirNewModel);
	Player.PlayerSex = modelInfo.sex or "m";
	Player.PlayerClothes = modelInfo.clothes;
	Player.PlayerFace = tonumber(modelInfo.face) or 1;
end
concommand.Add("perp_cf", GM.ChangeFace);

function GM.ChangeClothes ( Player, Cmd, Args )
	if (!Player) then return; end
	if (!Args[1]) then return; end
	if (Player:Team() != TEAM_CITIZEN) then return; end
	
	local Model = Args[1];
	
	// Model Stuff
	local modelInfo = GAMEMODE.ExplodeModelInfo(Model);
	if (!modelInfo) then Msg("fail info\n"); return; end
	
	local newSex = SEX_MALE;
	if (modelInfo.sex == 'f') then newSex = SEX_FEMALE; end
	if (tonumber(modelInfo.sex) == 2) then newSex = SEX_FEMALE; end
	if (Player:GetSex() != newSex) then return; end
	if (Player:GetFace() != modelInfo.face) then return; end
	
	Player:TakeCash(GAMEMODE.ClothesPrice, true);
	
	local theirNewModel = Player:GetModelPath(modelInfo.sex or "m", tonumber(modelInfo.face) or 1, tonumber(modelInfo.clothes) or 1);
	
	Player:SetModel(theirNewModel);
	Player.PlayerModel = theirNewModel;
	tmysql.query("UPDATE `perp_users` SET `model`='" .. modelInfo.sex .. "_" .. modelInfo.face .. "_" .. modelInfo.clothes .. "' WHERE `id`='" .. Player.SMFID .. "'");
	
	Player:SetPrivateString("model", theirNewModel);
	Player.PlayerSex = modelInfo.sex or "m";
	Player.PlayerClothes = modelInfo.clothes;
	Player.PlayerFace = tonumber(modelInfo.face) or 1;
end
concommand.Add("perp_cc", GM.ChangeClothes);

function GM.ChangeSex ( Player, Cmd, Args )
	if (!Player) then return; end
	if (Player:Team() != TEAM_CITIZEN) then return; end
	
	
	// Model Stuff
	local newSex = "m";
	if (Player:GetSex() == SEX_MALE) then newSex = "f"; end
	
	local modelInt = SEX_MALE;
	if (newSex == "f") then modelInt = SEX_FEMALE; end

	Player:TakeCash(GAMEMODE.SexChangePrice, true);
	
	local theirNewModel = Player:GetModelPath(newSex, 1, 1);
	
	Player:SetModel(theirNewModel);
	Player.PlayerModel = theirNewModel;
	tmysql.query("UPDATE `perp_users` SET `model`='" .. modelInt .. "_1_1' WHERE `id`='" .. Player.SMFID .. "'");
	
	Player:SetPrivateString("model", theirNewModel);
	Player.PlayerSex = modelInt;
	Player.PlayerClothes = 1;
	Player.PlayerFace = 1;
end
concommand.Add("perp_cs", GM.ChangeSex);

function GM.JohnDoeBug ( Player, Cmd, Args )
	
	tmysql.query("SELECT `rp_name_first`, `rp_name_last` FROM `perp_users` WHERE `steamid`='" .. Player:SteamID() .. "' LIMIT 1", function ( FixRPName )
		if (!Player or !IsValid(Player) or !Player:IsValid()) then return; end
		if (!FixRPName[1]) then return end
		
		Player:SetUMsgString("rp_fname", FixRPName[1][1]);
		Player:SetUMsgString("rp_lname", FixRPName[1][2]);
		
	end)
	
end
concommand.Add("perp_no_john", GM.JohnDoeBug)

function fixjohndoes ()
	for k, v in pairs(player.GetAll()) do
		GAMEMODE.JohnDoeBug(v)
	end
end
timer.Create("fixjohns", 60, 0, fixjohndoes)

function GM.Typing ( Player, Cmd, Args )
	if (Args[1] && tostring(Args[1]) == "1") then
		Player:SetUMsgInt("typing", 1);
		Player.StartedTyping = CurTime();
	else
		Player.StartedTyping = nil;
		Player:SetUMsgInt("typing", nil);
	end
end
concommand.Add("pt", GM.Typing);

function GM.AddBuddy ( Player, Cmd, Args )
	if (!Args[1] || !Player.Buddies) then return; end
	if (tostring(tonumber(Args[1])) != tostring(Args[1])) then return; end
	
	table.insert(Player.Buddies, Args[1]);
end
concommand.Add("perp_ab", GM.AddBuddy);

function GM.RemoveBuddy ( Player, Cmd, Args )
	if (!Args[1] || !Player.Buddies) then return; end
	if (tostring(tonumber(Args[1])) != tostring(Args[1])) then return; end
	
	for k, v in pairs(Player.Buddies) do
		if (v == Args[1]) then
			Player.Buddies[k] = nil;
		end
	end
end
concommand.Add("perp_rb", GM.RemoveBuddy);

function GM.BankDeposit ( Player, Cmd, Args )
	if (!Args[1]) then return; end
	
	local toTake = tonumber(Args[1]);
	
	if (toTake <= 0) then return; end
	if (Player:GetCash() < toTake) then return; end
	
	Player:TakeCash(toTake, true);
	Player:GiveBank(toTake, true);
end
concommand.Add("perp_b_d", GM.BankDeposit);

function GM.BankWithdraw ( Player, Cmd, Args )
	//if (!Player:NearNPC(2)) then return; end
	if (!Args[1]) then return; end
	
	local toTake = tonumber(Args[1]);
	
	if (toTake <= 0) then return; end
	if (Player:GetBank() < toTake) then return; end
	if ((Player:GetCash() + toTake) > MAX_CASH) then return; end
	
	Player:GiveCash(toTake, true);
	Player:TakeBank(toTake, true);
end
concommand.Add("perp_b_w", GM.BankWithdraw);

// Event Start Script
function GM.StartEvent ( Player, Cmd, Args )
	if Player:GetLevel() > 0 then return false; end
	local Event = Args[1];
	
	if !file.Exists('../gamemodes/perp/gamemode/events/' .. Event .. '.lua',"LUA") then
		Player:PrintMessage(HUD_PRINTCONSOLE, "That event does not exist.");
		return false;
	end
	
	include('perp2.5/gamemode/events/' .. Event .. '.lua');
end
concommand.Add("perp2_encrypt3D_events", GM.StartEvent);

function GM.ResetFirstName( Player, Cmd, Args )
	Player:SetUMsgString("rp_fname", Player:GetUMsgString("rp_fname", "John"))
end
concommand.Add("perp_r_fn", GM.ResetFirstName)
/*
function GM.ResetLastCar( Player, Cmd, Args )
	umsg.Start("perp_rs_lc")
*/
