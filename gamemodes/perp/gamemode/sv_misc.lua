require('gatekeeper')


function GM.GetEntPos ( Player )
	if !Player:IsSuperAdmin() then return false; end
	
	local Eyes = Player:GetEyeTrace().Entity:GetPos();
	
	Player:PrintMessage(HUD_PRINTCONSOLE, 'Vector(' .. math.Round(Eyes.x) .. ', ' .. math.Round(Eyes.y) .. ', ' .. math.Round(Eyes.z) .. ')\n');
end
concommand.Add('getentpos', GM.GetEntPos);

local function PlayerHealthReset ( Player )
if (Player:GetCash() < COST_FOR_HEALTHRESET) then return; end
	Player:TakeCash(COST_FOR_HEALTHRESET, true);
	Player:SetHealth(100);
	Player:Notify("Your health has been restored.");
end;
concommand.Add("perp2_encrypt3D_medic_resetHealth", PlayerHealthReset);

local function PlayerCrippledReset ( Player )
if (Player:GetCash() < COST_FOR_LEGFIX) then return; end
	Player:TakeCash(COST_FOR_LEGFIX, true);
	Player:GetTable().Crippled = false;
	Player:Notify("Your legs are now fixed.");
	Player:FindRunSpeed();
end;
concommand.Add("perp2_encrypt3D_medic_resetCrippled", PlayerCrippledReset);

local function ManageSprint ( )
	for k, v in pairs(player.GetAll()) do
		v:CalculateStaminaLoss();
	end
end
hook.Add("Think", "ManageSprint", ManageSprint);

local function ManageHealthRegeneration ( )
	for k, v in pairs(player.GetAll()) do
		v:CalculateRegeneration();
	end
end
timer.Create("ManageHealthRegeneration", 1, 0, ManageHealthRegeneration);

function ExplodeInit ( pos, damage_dealer )
	umsg.Start('perp_bomb');
		umsg.Vector(pos);
	umsg.End();

	if (damage_dealer && IsValid(damage_dealer) && damage_dealer:IsPlayer()) then
		for i = 1, 5 do
			util.BlastDamage(damage_dealer, damage_dealer, pos, 300, 300 )
		end
	else
		for i = 1, 5 do
			util.BlastDamage(damage_dealer, damage_dealer, pos, 300, 300 )
		end
	end
	
	for k, v in pairs(ents.FindInSphere(pos, 1000)) do
		if v:GetClass() == 'prop_vehicle_jeep' and !v:GetTable().Disabled and (!v:GetDriver() or !v:GetDriver():IsValid() or !v:GetDriver():IsPlayer()) then
			umsg.Start('perp_car_alarm');
				umsg.Entity(v);
			umsg.End();
		end
	end
	
	for i = 1, 5 do
		local Offset = Vector(math.random(-50, 50), math.random(-50, 50), 0);
			
		local Trace = {};
			Trace.start = pos + Offset + Vector(0, 0, 32);
			Trace.endpos = pos + Offset - Vector(0, 0, 1000);
			Trace.mask = MASK_SOLID_BRUSHONLY;
		local TR = util.TraceLine(Trace);
				
		if TR.Hit then					
			local Fire = ents.Create('ent_fire');
				Fire:SetPos(TR.HitPos);
			Fire:Spawn();
		end
	end
end

function GM.PushNumPlayers ( )
	if (GAMEMODE.ServerIdentifier == 0) then return; end
	
	local numPlayers = gatekeeper.GetNumClients().total;
	Msg("Sending number of players to database...\n");
	tmysql.query("UPDATE `perp_system` SET `value`='" .. numPlayers .. "' WHERE `key`='players_" .. GAMEMODE.ServerIdentifier .. "' LIMIT 1");
end

function GM.SetDate ( )
	local curDate = os.date("%m.%d")
	
	if (GetGlobalString("os.date", "") != curDate) then
		SetGlobalString("os.date", curDate)
	end
end
timer.Create("perp2_setdate", 60, 0, GM.SetDate)
GM.SetDate()

function SetDropPos ( Player )
	if !Player:IsSuperAdmin() then return false; end
	
	local P = Player:GetEyeTrace().HitPos + Vector(0, 0, 16);
	local WriteText = "Vector(" .. P.x .. ", " .. P.y .. ", " .. P.z .. "), \n";
	
	if !file.Exists('zombspawn.txt',"DATA") then
		file.Write('zombspawn.txt',"DATA", WriteText);
	else
		file.Write('zombspawn.txt', file.Read('zombspawn.txt',"DATA") .. WriteText);
	end
	
	local Marker = ents.Create('prop_physics');
	Marker:SetPos(P);
	Marker:SetModel('models/error.mdl');
	Marker:Spawn();
	Marker:SetMoveType(MOVETYPE_NONE);
	Marker:SetSolid(SOLID_NONE);
end
concommand.Add('perp3_zombiehere', SetDropPos);


function VTCheck()
	for k, ent in pairs(ents.FindInSphere(Vector(-7030, -12550, 130), 100)) do
		if ent:IsValid() and ent:IsVehicle() then
			ent:Remove();
		end
	end
end
timer.Create("VTCheck", 1, 0, VTCheck)

/*
function NexusTop ( )
	for k, ply in pairs(ents.FindInSphere(Vector(-7267.128418, -9195.308594, 4400), 400)) do
		if ply:IsValid() and ply:IsPlayer() then
			if ply:IsAdmin() then
				return;
			else
				ply:Notify("Get the fuck off of the nexus")
			end;
		end
	end
	
	for k, ply in pairs(ents.FindInSphere(Vector(-6745.465820, -8667.694336, 4400.609863), 400)) do
		if ply:IsValid() and ply:IsPlayer() then
			if ply:IsAdmin() then
				return;
			else
				ply:Notify("Get the fuck off of the nexus")
			end;
		end
	end
	
	for k, ply in pairs(ents.FindInSphere(Vector(-6508.780273, -9406.659180, 4400.420410), 400)) do
		if ply:IsValid() and ply:IsPlayer() then
			if ply:IsAdmin() then
				return;
			else
				ply:Notify("Get the fuck off of the nexus")
			end;
		end
	end
end;
timer.Create("NexusTopCheck", 10, 0, NexusTop);
*/

/*
function SetFirstNames ()
for k,v in pairs(player.GetAll()) do 
	v:SetUMsgString("rp_fname", v:GetUMsgString("rp_fname", "John")
end
end
timer.Create("SetFirstNames", 10, 0, SetFirstNames)
*/