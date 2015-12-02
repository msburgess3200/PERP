require('tmysql');

local function sendOnline ( )
	if (GAMEMODE.ServerIdentifier == 0) then return end
	
	tmysql.query("UPDATE `perp_system` SET `value`='" .. os.time() .. "' WHERE `key`='online_" .. GAMEMODE.ServerIdentifier .. "' LIMIT 1");
end
timer.Create("sendOnline", 10, 0, sendOnline);

local function forceOnline ( Player )
	if (Player && IsValid(Player) && !Player:IsSuperAdmin()) then return end
	if (GAMEMODE.ServerIdentifier == 0) then return end
	
	tmysql.query("UPDATE `perp_system` SET `value`='" .. os.time() + 600 .. "' WHERE `key`='online_" .. GAMEMODE.ServerIdentifier .. "' LIMIT 1");
end
concommand.Add("force_online", forceOnline);

function GM:KeyPress ( Player, Key )
	if Key == IN_USE then
		local TTable = {}
		TTable.start = Player:GetShootPos();
		TTable.endpos = TTable.start + Player:GetAimVector() * 100;
		TTable.filter = Player;
		TTable.mask = MASK_OPAQUE_AND_NPCS;
		
		local Tr = util.TraceLine(TTable);
				
		if Tr.Entity and Tr.Entity:IsValid() and Tr.Entity:GetClass() == "npc_vendor" then
			Tr.Entity:UseFake(Player);
		end
	end
end

function GM:Initialize ( )
	Msg("Loading tmysql module... ");
	
	
	if (tmysql) then
		Msg("done!\n");
	else
		Msg("failed!\n");
	end
	
	self.ServerIdentifier = 2;
	self.ServerDateIdentifier = 1;
	self.numPlayers = 128;
	self.ReservedSlots = 64;
	self.Serious = true;
	
    SQL_INFO_1 = "localhost"; -- DB-HOST
	SQL_INFO_2 = ""; -- DB-User
	SQL_INFO_3 = "";  -- DB-Pass
	SQL_INFO_4 = ""; -- DB-DBName

	tmysql.initialize(SQL_INFO_1, SQL_INFO_2, SQL_INFO_3, SQL_INFO_4, 3306, 8, 8);

	RunConsoleCommand("sv_visiblemaxplayers", self.numPlayers-self.ReservedSlots);
	
	timer.Simple(1, function ( )
		RunConsoleCommand("sv_allowdownload", "1");
		RunConsoleCommand("sv_allowupload", "1");
		RunConsoleCommand("sv_usermessage_maxsize", "5000");
		RunConsoleCommand('lua_log_sv', '1');
		RunConsoleCommand('net_maxfilesize', '64');
	end);
	
	SetGlobalInt("tax_sales", 5);
	SetGlobalInt("tax_income", 5);
	
	sendOnline();
	
	RunConsoleCommand("qcache_gamedesc", ""); 
	
	RunConsoleCommand("sv_max_queries_window", "5"); 
	self.IsSerious = (self.ServerIdentifier == 2);
	
	self.HouseAlarms = {};
	
	tmysql.query("SELECT `key`, `value` FROM `perp_system` WHERE `key`='date_year_" .. self.ServerDateIdentifier .. "' OR `key`='date_month_" .. self.ServerDateIdentifier .. "' OR `key`='date_day_" .. self.ServerDateIdentifier .. "'", function ( Whatever )
		for k, v in pairs(Whatever) do
			if (v[1] == "date_year_" .. self.ServerDateIdentifier) then
				GAMEMODE.CurrentYear = tonumber(v[2]);
			elseif (v[1] == "date_month_" .. self.ServerDateIdentifier) then
				GAMEMODE.CurrentMonth = tonumber(v[2]);
			elseif (v[1] == "date_day_" .. self.ServerDateIdentifier) then
				GAMEMODE.CurrentDay = tonumber(v[2]);
			end
		end
		
		GAMEMODE.LastSaveYear = GAMEMODE.CurrentYear;
		GAMEMODE.LastSaveMonth = GAMEMODE.CurrentMonth;
		GAMEMODE.LastSaveDay = GAMEMODE.CurrentDay;
		
		GAMEMODE.CurrentTemperature = (AVERAGE_TEMPERATURES[GAMEMODE.CurrentMonth][1] + AVERAGE_TEMPERATURES[GAMEMODE.CurrentMonth][2]) * .5;
		SetGlobalInt("temp", GAMEMODE.CurrentTemperature);
		
		Msg("Current in-game date: " .. GAMEMODE.CurrentMonth .. "/" .. GAMEMODE.CurrentDay .. "/" .. GAMEMODE.CurrentYear .. "\n");
		
		GAMEMODE.CanSaveDate = true;
		Msg("Date saving authorized.\n");
	end);
	SetGlobalInt("tv_status", 0);
end

function GM:InitPostEntity ( )
	self.GatherInvalidNames();
	
	timer.Simple(1, GAMEMODE.PushNumPlayers);
end

function GM:PlayerInitialSpawn ( Player )
	Player.PlayerItems = {}
	Player.StorageItems = {}
	Player:SetTeam(TEAM_CITIZEN)
	Player:ConCommand("playx_enabled 0")
	Player:ConCommand("cl_playerspraydisable 1")
	self.PushNumPlayers();
	timer.Simple(5, GAMEMODE.SendJobInformation, Player)
end

function GM:PlayerConnect ( )
	self.PushNumPlayers();
end

function GM:PlayerDisconnected ( ) 
	timer.Simple(1, GAMEMODE.PushNumPlayers);
end

local spawnPoints = {}
spawnPoints[TEAM_POLICE] = {
								{pos = Vector(-7336.943359, -8760.213867, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7336.943359, -8860.213867, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7336.943359, -8960.213867, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7336.943359, -9060.213867, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7336.943359, -9160.213867, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7236.943359, -9060.213867, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7236.943359, -9160.213867, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7136.943359, -8760.213867, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7136.943359, -8860.213867, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7136.943359, -8960.213867, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7136.943359, -9060.213867, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7136.943359, -9160.213867, 136.031250), ang = Angle(0, 0, 0)},
							}
spawnPoints[TEAM_SWAT] = spawnPoints[TEAM_POLICE]
spawnPoints[TEAM_MEDIC] = spawnPoints[TEAM_POLICE]
spawnPoints[TEAM_FIREMAN] = spawnPoints[TEAM_POLICE]
spawnPoints[TEAM_DISPATCHER] = spawnPoints[TEAM_POLICE]
spawnPoints[TEAM_MAYOR] = spawnPoints[TEAM_POLICE]
spawnPoints[TEAM_SECRET_SERVICE] = spawnPoints[TEAM_POLICE]
spawnPoints[TEAM_BUSDRIVER] = {
								{pos =Vector(-5306.995605, -6798.311523, 80.0313), ang = Angle(0, -180, 0)},
								{pos =Vector(-5089.976563, -6802.048340, 80.0313), ang = Angle(0, -180, 0)},
                              }
spawnPoints[TEAM_ROADCREW] = {
                                {pos =Vector(493.9533, 4278.0039, 64.0313), ang = Angle(0, 180, 0)},
                                {pos =Vector(494.1622, 4200.8335, 64.0313), ang = Angle(0, 180, 0)},
                             }
spawnPoints[TEAM_CITIZEN] =	{
								{pos = Vector(-6305.042969, -7913.229980, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-6305.042969, -7813.229980, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-6305.042969, -7713.229980, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-6305.042969, -7613.229980, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-6305.042969, -7513.229980, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-6305.042969, -7240.229980, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-6305.042969, -6977.000000, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-6305.042969, -6877.000000, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-5692.000977, -7938.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -7838.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -7738.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -7538.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -7438.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -7338.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -7238.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -7138.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -7038.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -6938.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -6738.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -6638.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -6538.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -6438.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -6338.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -6238.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -6138.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -5938.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5692.000977, -5838.023438, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-7809.376953, -7318.396484, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7809.376953, -7218.396484, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7809.376953, -7118.396484, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7809.376953, -7018.396484, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7809.376953, -6918.396484, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7809.376953, -6818.396484, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-7809.376953, -6718.396484, 136.031250), ang = Angle(0, 0, 0)},
								{pos = Vector(-5596.738281, -4409.487305, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5596.738281, -4509.487305, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5596.738281, -4609.487305, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5596.738281, -4709.487305, 136.031250), ang = Angle(0, 180, 0)},
								{pos = Vector(-5596.738281, -4809.487305, 136.031250), ang = Angle(0, 180, 0)},
							}

function GM:PlayerSelectSpawn ( user )
	local SafeSpawnArea = spawnPoints[user:Team()][math.random(1, table.Count(spawnPoints[user:Team()]))];
	
	for _, each in pairs(spawnPoints[user:Team()]) do
		local nearbyEnts = ents.FindInSphere(each.pos, 75)
		
		local nearbyPlayer = false
		for _, ent in pairs(nearbyEnts) do
			if (ent && IsValid(ent) && ent:IsPlayer() && ent != user) then
				nearbyPlayer = true
			end
		end
		
		if (!nearbyPlayer) then
			SafeSpawnArea = each
			break
		end
	end

	local MobileSpawn = ents.FindByClass('info_mobile_spawn')[1];
	
	if !IsValid(MobileSpawn) then
		MobileSpawn = ents.Create('info_mobile_spawn');
		MobileSpawn:SetPos(Vector(0, 0, 0));
		MobileSpawn:SetColor(Color(0,0,0, 0));
		MobileSpawn:Spawn();
	end
	
	MobileSpawn:SetPos(SafeSpawnArea.pos);
	MobileSpawn:SetAngles(SafeSpawnArea.ang);
	return MobileSpawn;
end

function GM:PlayerSpawn ( Player )	
	if Player.JobModel then Player:SetModel(Player.JobModel);
	elseif Player.PlayerModel then Player:SetModel(Player.PlayerModel);
	else Player:SetModel(Player:GetModelPath(SEX_MALE, 1, 1)); end
	
	if GAMEMODE.PlayerSpawn_Event then GAMEMODE.PlayerSpawn_Event(Player) end
	if GAMEMODE.PlayerSetModel_Event and GAMEMODE.PlayerSetModel_Event(Player) then return false; end

	Player.currentlyRestrained = nil
	self.freshLayout = true;
	self:PlayerLoadout(Player);
	
	if (!Player.DontFixCripple) then
		Player.Crippled = nil;
		
		umsg.Start("perp_reset_stam", Player); umsg.End();
		Player.Stamina = 100;
		
		if (Player:Team() == TEAM_CITIZEN && Player.DeathPos && !Player:GetTable().Pos) then
			for i = 1, 2 do
				if (Player.PlayerItems[i]) then
					local itemDrop = ents.Create("ent_item");
						itemDrop:SetModel(Player.PlayerItems[i].Table.WorldModel);
						itemDrop:SetContents(Player.PlayerItems[i].ID, Player);
						itemDrop:SetPos(Player.DeathPos + Vector(0, 0, 10 + 10 * i));
					itemDrop:Spawn();
					
					Player.PlayerItems[i] = nil;
				end
			end
			
			umsg.Start('perp_strip_main', Player); umsg.End();
		elseif (Player:Team() == TEAM_MAYOR  && !Player:GetTable().Pos) then
			for k, v in pairs(player.GetAll()) do
				if (v != Player) then
					v:Notify("The mayor has been assassinated.");
				end
			end
			
			Player:Notify("You have been assassinated.");
			
			Player:SetModel(Player.PlayerModel);
			Player.JobModel = nil;
			Player:EquipMains();
			Player:SetTeam(TEAM_CITIZEN);
		end
	else
		Player.DontFixCripple = nil;
	end
	
	Player:FindRunSpeed();
	
	if (Player:Team() == TEAM_CITIZEN) then
		Player:EquipMains();
	end
	
	if Player:GetTable().Pos then Player:SetPos(Player:GetTable().Pos); Player:GetTable().Pos = nil end
	radar.RemoveAlert(Player:SteamID() .. "Accident")
end

function GM:PlayerDeath ( Player, Inflictor, Killer )
	local killerText = tostring(Killer);
	
	for k, v in pairs(player.GetAll()) do
		if (v:IsAdmin()) then
			if Killer:GetClass() == "prop_vehicle_jeep" then
				local VehDriver = Killer:GetDriver();
				if VehDriver:Nick() != "Console" then
					v:PrintMessage(HUD_PRINTTALK, VehDriver:Nick() .. " ran over " .. Player:Nick());
				else
					v:PrintMessage(HUD_PRINTTALK, Player:Nick() .. " was killed by a driverless car");
				end
			elseif Killer:GetClass() == "worldspawn" then
				v:PrintMessage(HUD_PRINTTALK, Player:Nick() .. " Hit the map too hard");
			elseif Killer:GetClass() == "ent_item" || Killer:GetClass() == "ent_prop_item" then
				v:PrintMessage(HUD_PRINTTALK, Player:Nick() .. " was prop killed");
			elseif Killer == Player then
				v:PrintMessage(HUD_PRINTTALK, Player:Nick() .. " killed themself");
			elseif (Killer && IsValid(Killer) && Killer:IsPlayer()) then
				killerText = Killer:Nick();
				v:PrintMessage(HUD_PRINTTALK, killerText .. " killed " .. Player:Nick());
			else
				v:PrintMessage(HUD_PRINTTALK, "Unknown object killed " .. Player:Nick());
			end
		end;
	end
	
	Player.RequiredDefib = math.random(1, 3);
	Player.DeathPos = Player:GetPos();
	
	if (Inflictor && Inflictor:IsVehicle()) then
		Player.RespawnTime = CurTime() + 10;
		Player:Notify('You have been rammed by a vehicle. Paramedics will probably not arrive in time to save you.');
	elseif (Inflictor && Inflictor:GetClass() == 'ent_fire') then
		Player.RespawnTime = CurTime() + 10;
		Player:Notify('You have been knocked unconcious in a fire. Paramedics will probably not arrive in time to save you.');
	elseif Player:WaterLevel() >= 3 then
		Player.RespawnTime = CurTime() + 10;
		Player:Notify('You have been knocked unconcious underwater. Paramedics will probably not arrive in time to save you.');
	else
		if (GAMEMODE.RespawnOverride) then
			Player.RespawnTime = CurTime() + 5;
		else
			Player.RespawnTime = CurTime() + 100;
		end;
		
		// Life alert
		if (Player:HasItem("item_lifealert")) then
			Player:BroadcastLifeAlert();
			radar.AddAlertTeam(Player:SteamID() .. "Accident", {TEAM_FIREMAN, TEAM_MAYOR, TEAM_PARAMEDIC, TEAM_SWAT}, Player:GetPos(), Player:GetRPName(), Color(255, 0, 0, 200))
		end
	end
end

function GM:PlayerDeathThink ( Player )
	Player.RespawnTime = Player.RespawnTime or 0;
	
	if Player.RespawnTime < CurTime() then
		Player:Spawn();
		Player:Notify('You have passed away... The paramedics were too slow.');
	end
end


function GM:PlayerLoadout ( Player )
	if (!self.freshLayout) then
		Player:StripWeapons();
	else self.freshLayout = nil; end
	
	Player:Give("roleplay_keys");
	Player:Give("roleplay_fists");
	Player:Give("weapon_physcannon");
	
	if (Player:GetLevel() <= 100) then
		Player:Give("weapon_physgun");
	end
	
	if (Player:GetLevel() <= 10) then
		Player:Give("god_stick");
	end
	
	if (GAMEMODE.JobEquips[Player:Team()]) then
		GAMEMODE.JobEquips[Player:Team()](Player);
	end
end

function RemoveWeps ( Player )
	Player:StripWeapons();
end
concommand.Add("perp_toggle_weapons", RemoveWeps);

function GM:PlayerDisconnected ( Player )
	Player.RespawnTime = Player.RespawnTime or 0;
	Player:Save();
	
	// Remove their save timer
	local ourID = Player:SteamID();
	timer.Remove(ourID);
	
	// Remove their properties
	for k, v in pairs(PROPERTY_DATABASE) do
		local propOwner = GetGlobalEntity("p_" .. k);
		
		if (propOwner && IsValid(propOwner) && propOwner == Player) then
			SetGlobalEntity("p_" .. k, Entity());
		end
	end
	
	// Delete all of their props
	for k, v in pairs(ents.GetAll()) do
		if (v.Owner && v.Owner == Player) then
			v:Remove();
		end
		
		if (v.pickupPlayer && v.pickupPlayer == Player) then
			v:Remove();
		end
	end
	
	local spawnPos = tostring(Player:GetPos());
	local spawnAng = tostring(Player:GetAngles());
	
	if Player.RespawnTime > CurTime() then
		local deathTime = Player.RespawnTime - CurTime();
		Player:SetSpawnPosition(spawnPos, spawnAng, deathTime, Player:SteamID())
	else 
		Player:SetSpawnPosition(spawnPos, spawnAng, 0, Player:SteamID())
	end
	
	// Remove their vehicle (and rotators)
	Player:RemoveCar();
	
	// Make sure they're not on the phone with anyone
	if (Player.Calling) then DropCall(Player); end
	
	timer.Simple(1, self.PushNumPlayers);
end

function GM:ShutDown ( )
	for k, v in pairs(player.GetAll()) do
		v:Save();
	end
end

function GM:PlayerNoClip ( Player )

	if (Player:GetLevel() <= 1) then
		return true;
	elseif !game.IsDedicated() then
		return true
	else 
		return false;
	end

end

function GM:CanPlayerSuicide ( ) return false; end

function GM:ShowHelp ( Player )
	umsg.Start("perp_help", Player);
	umsg.End();
end

function GM:ShowSpare1 ( Player )
	umsg.Start("perp_org", Player);
	umsg.End();
end

function GM:ShowSpare2 ( Player )
	local eyeTrace = Player:GetEyeTrace();
	
	if (eyeTrace.Entity && eyeTrace.Entity:IsPlayer() && eyeTrace.Entity:GetPos():Distance(Player:GetPos()) < 300) then
		Player:TradeWith(eyeTrace.Entity);
		return
	end

	umsg.Start("perp_buddies", Player);
	umsg.End();
end

function GM:GravGunPunt ( Player, Target ) return false; end
function GM:GravGunPickupAllowed ( Player, Target ) return Target && IsValid(Target) && (Player:CanManipulateEnt(Target) || Target:GetClass() == "ent_pot" || Target:GetClass() == "ent_coca" || Target:GetClass() == "ent_towtruck_hook"); end
function GM:PhysgunPickup ( Player, Target ) return Player:CanManipulateEnt(Target); end
function GM:ShowTeam ( Player )
	if (Player.currentlyRestrained) then
		Player:Notify("You cannot use your inventory while cuffed.");
		return false;
	end;
	
	umsg.Start("perp_inventory", Player); 
	umsg.End();
end

function GM:OnPhysgunFreeze( weapon, phys, ent, ply )
	if (
			ent:GetClass() != 'ent_prop_item' && 
			ent:GetClass() != "prop_clock" && 
			ent:GetClass() != "prop_lamp" && 
			ent:GetClass() != "prop_lamp_spot" && 
			ent:GetClass() != "prop_thermo"  &&
			ent:GetClass() != "prop_metal_detector" &&
			ent:GetClass() != "prop_vehicle_prisoner_pod" &&
			ent:GetClass() != "item_doorbuster"
		) then return false; end
	if !phys:IsMoveable() then return false; end
	
	phys:EnableMotion(false);
	
	return true;
end

function PLAYER:CanManipulateEnt ( Target )
	if !self or !self:IsValid() or !self:IsPlayer() then return false; end
	if !Target or !Target:IsValid() then return false; end
	
	if self:IsAdmin() and Target:GetClass() == 'prop_vehicle_prisoner_pod' then return true; end
	if self:IsAdmin() and Target:GetClass() == 'ent_prop_item' then return true; end
	if self:IsAdmin() and Target:GetClass() == 'prop_clock' then return true; end
	if self:IsAdmin() and Target:GetClass() == 'prop_thermo' then return true; end
	if self:IsAdmin() and Target:GetClass() == 'prop_lamp' then return true; end
	if self:IsAdmin() and Target:GetClass() == 'prop_case_beer' then return true; end
	if self:IsAdmin() and Target:GetClass() == 'prop_metal_detector' then return true; end
	if self:IsOwner() and Target:GetClass() == 'prop_vehicle_jeep' then return true; end
	if self:IsOwner() and Target:GetClass() == 'ent_pot' then return true; end
	if self:IsOwner() and Target:GetClass() == 'ent_coca' then return true; end
	if self:IsOwner() and Target:GetClass() == 'ent_pot_leaf' then return true; end
	if self:IsOwner() and Target:GetClass() == 'item_doorbuster' then return true; end
	
	
	if (Target:GetClass() == 'ent_prop_item' || Target:GetClass() == 'prop_clock' || Target:GetClass() == "prop_thermo" || Target:GetClass() == "prop_thermo" || Target:GetClass() == "prop_lamp" || Target:GetClass() == "prop_lamp_spot" || Target:GetClass() == "prop_case_beer" || Target:GetClass() == "prop_metal_detector") and Target:GetTable().Owner then
		if Target:GetTable().Owner == self or Target:GetTable().Owner:HasBuddy(self) then
			return true;
		end
	end
	
	if (Target:GetClass() == 'prop_vehicle_prisoner_pod') and Target.pickupPlayer && (!Target:GetDriver() || !IsValid(Target:GetDriver())) then
		if Target.pickupPlayer == self or Target.pickupPlayer:HasBuddy(self) then
			return true;
		end
	end
	
	if (Target:GetClass() == 'ent_fuelcan') then
		if Target.pickupPlayer == self or Target.pickupPlayer:HasBuddy(self) then
			return true;
		end
	end
	
	if Target:GetClass() == 'ent_item' then
		if (Target:GetNetworkedString("title", "") == "") then
			return true;
		else
			return (self == Target:GetTable().Owner)
		end
	end

	return false;
end

function GM:GetFallDamage ( Player, flFallSpeed )
	return math.Clamp(flFallSpeed / 10, 10, 100);
end

function GM:ScalePlayerDamage ( Player, HitGroup, DmgInfo )
	local attacker = DmgInfo:GetAttacker()
	
	if (attacker && IsValid(attacker) && attacker:IsPlayer()) then
		if (!self:PlayerShouldTakeDamage(Player, attacker)) then return DmgInfo end
	end
	
	if (Player:Alive()) then
		if (HitGroup == HITGROUP_HEAD) then
			DmgInfo:ScaleDamage(2);
			if (Player:GetSex() == SEX_MALE) then
				MoanFile = Sound("vo/npc/male01/ow0"..math.random(1, 2)..".wav");
			else
				MoanFile = Sound("vo/npc/female01/ow0"..math.random(1, 2)..".wav");
			end;				
		elseif (HitGroup == HITGROUP_CHEST or HitGroup == HITGROUP_GENERIC) then
			if (Player:GetSex() == SEX_MALE) then
				MoanFile = Sound("vo/npc/male01/hitingut0"..math.random(1, 2)..".wav");
			else
				MoanFile = Sound("vo/npc/female01/hitingut0"..math.random(1, 2)..".wav");
			end;
		elseif (HitGroup == HITGROUP_LEFTARM or HitGroup == HITGROUP_RIGHTARM) then
			if (Player:GetSex() == SEX_MALE) then
				MoanFile = Sound("vo/npc/male01/myarm0"..math.random(1, 2)..".wav");
			else
				MoanFile = Sound("vo/npc/female01/myarm0"..math.random(1, 2)..".wav");
			end;
		elseif (HitGroup == HITGROUP_GEAR) then
			if (Player:GetSex() == SEX_MALE) then
				MoanFile = Sound("vo/npc/male01/startle0"..math.random(1, 2)..".wav");
			else
				MoanFile = Sound("vo/npc/female01/startle0"..math.random(1, 2)..".wav");
			end;
		elseif (HitGroup == HITGROUP_RIGHTLEG or HitGroup == HITGROUP_LEFTLEG) and !Player:GetTable().Crippled then
				if (GAMEMODE.CrippleOverride) then return; end;
				Player:GetTable().Crippled = true;
				Player:Notify("You've broken your legs!");
			
				Player:FindRunSpeed();
			
				if (Player:GetSex() == SEX_MALE) then
					MoanFile = Sound('vo/npc/male01/myleg0' .. math.random(1, 2) .. '.wav');
				else
					MoanFile = Sound('vo/npc/female01/myleg0' .. math.random(1, 2) .. '.wav');
				end;
		else
			if (Player:GetSex() == SEX_MALE) then
				MoanFile = Sound("vo/npc/male01/pain0"..math.random(1, 9)..".wav");
			else
				MoanFile = Sound("vo/npc/female01/pain0"..math.random(1, 9)..".wav");
			end;
		end;
		
		sound.Play(MoanFile, Player:GetPos(), 100, 100);
	end;
	
	if GAMEMODE.IsSerious then
		if Player:Team() == TEAM_SWAT then
			DmgInfo:ScaleDamage(1.25);
		else
			DmgInfo:ScaleDamage(1.5);
		end
	elseif Player:Team() == TEAM_SWAT then
		DmgInfo:ScaleDamage(0.75);
	end
	
	Player:GiveExperience(SKILL_HARDINESS, DmgInfo:GetDamage() * .25);
	
	return DmgInfo;
end

function GM:PlayerShouldTakeDamage ( victim, attacker )
	if (!victim || !IsValid(victim) || !victim:IsPlayer()) then return true end
	if (!attacker || !IsValid(attacker) || !attacker:IsPlayer()) then return true end
	if (attacker == victim) then return true; end
	if (victim:Team() == TEAM_MAYOR && attacker:Team() != TEAM_CITIZEN) then return false end
	if (victim:Team() != TEAM_CITIZEN && attacker:Team() != TEAM_CITIZEN) then return false end
	
	return true
end

local function customUse ( Player, Entity )
	if (Player:InVehicle()) then return; end
	if (Player.LastLeaveVehicle && Player.LastLeaveVehicle > CurTime()) then return; end
	
	if (Player:KeyDown(IN_WALK)) then
		if (Entity:GetClass() == "prop_vehicle_prisoner_pod" && Entity.pickupPlayer && Player == Entity.pickupPlayer && !Entity.used) then
			Player:GiveItem(Entity.pickupTable, 1, true);
			Entity.used = true;
			Entity:Remove();
		end
		
		if ((Entity:GetClass() == "prop_lamp" || Entity:GetClass() == "prop_lamp_spot") && Entity.pickupPlayer && Player == Entity.pickupPlayer && !Entity.used) then
			Player:GiveItem(Entity.pickupTable, 1, true);
			Entity.used = true;
			Entity:Remove();
		end
	elseif (Entity:GetClass() == "prop_vehicle_prisoner_pod" && Entity.pickupPlayer && !IsValid(Entity:GetDriver())) then
		Player:EnterVehicle(Entity);
	elseif (Entity:GetClass() == "prop_vehicle_prisoner_pod") then
		if Entity.TSeat then
			Player:EnterVehicle(Entity);
		end
	elseif ((Entity:GetClass() == "prop_lamp" || Entity:GetClass() == "prop_lamp_spot") && Entity.flashlight && (!Entity.nextLightFlip || CurTime() > Entity.nextLightFlip)) then
		// toggle the lights.
		if Entity.broken then
			sound.Play("ambient/energy/spark" .. math.random(1, 6) .. ".wav", Entity:GetPos(), 50);
		else
			if (Entity.lightCurOn) then
				Entity.lightCurOn = false;
				Entity.flashlight:Fire("TurnOff", "", 0);
				
				if (Entity:GetClass() == "prop_lamp_spot") then
					Entity:SetSkin(1);
					Entity:SetNetworkedBool("show_spot", false);
				end
			else
				Entity.lightCurOn = true;
				Entity.flashlight:Fire("TurnOn", "", 0);
				
				if (Entity:GetClass() == "prop_lamp_spot") then
					Entity:SetSkin(0);
					Entity:SetNetworkedBool("show_spot", true);
				end
			end
		end
		
		Entity.nextLightFlip = CurTime() + 1;
	end
end
hook.Add("PlayerUse", "customUse", customUse);

function GM:PlayerSpray ( Player )
	Player:Notify("Nope.");
	return false;
end;

function PlaySound ( Ply, Cmd, Args )
	if(not game.SinglePlayer() and not Ply:IsOwner()) then return end
	
	local sound = Args[1]
	
	if ( sound ) then
		PlaySound(sound)
		
		if ( string.match( sound, "^[a-zA-Z0-9/]+.wav$" ) ) then
			if ( !file.Exists( "../sound/" .. sound,"GAME" ) ) then
					print( "Sound \"" .. sound .. "\" not found!" )
					return
			end
		end
		
		for k, v in pairs( player.GetAll() ) do
			v:ConCommand( "play " .. sound )
		end
		
	else
		print("No sound was specified yet!" )
	end
end
concommand.Add("testsound1", PlaySound);

concommand.Add("perpx_giveitembeg", function(objPl, _, tblArgs)
	if(not game.SinglePlayer() and not objPl:IsSuperAdmin()) then return end
	
	objPl:GiveItem(tonumber(tblArgs[1]), 1, true)
end)

function GM:PlayerSwitchFlashlight( Player )
	if(Player:HasItem("item_flashlight")) then
		return true;
	else
		if(Player:FlashlightIsOn()) then
			return true;
		end
		
		return false;
	end
end

local function FixFlashlights()
	for k, v in pairs(player.GetAll()) do
		if(v.CanSave) then
			if(not v:HasItem("item_flashlight")) then
				if(v:FlashlightIsOn()) then
					v:Flashlight(false);
				end
			end
		end
	end
end
timer.Create("FixFlashlights", 1, 0, FixFlashlights);