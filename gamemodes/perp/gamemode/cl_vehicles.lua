


GM.Vehicles = {};

local function ParseVehicleString ( input )
	local itemInfo = string.Explode(";", string.Trim(input));
	
	for k, v in pairs(itemInfo) do
		local splitAgain = string.Explode(",", v);
		
		if (#splitAgain > 0) then			
			GAMEMODE.Vehicles[splitAgain[1]] = {tonumber(splitAgain[2] or 1), tonumber(splitAgain[3] or 1), tonumber(splitAgain[4] or 0), tonumber(splitAgain[5] or 0)};
		end
	end
end

local function loadInitialVehicles ( UMsg ) ParseVehicleString(UMsg:ReadString()); end
usermessage.Hook("perp_vehicles_init", loadInitialVehicles);

local function doRevving ( UMsg )
	local vehicle = UMsg:ReadEntity();
		
	if (!vehicle || !IsValid(vehicle) || !vehicle:IsVehicle()) then return; end
	
	local vehicleTable = lookForVT(vehicle);
	
	if (!vehicleTable) then return; end
	if (!vehicleTable.RevvingSound) then return; end
	
	if (!vehicle.RevvingSound) then
		vehicle.RevvingSound = CreateSound(vehicle, Sound(vehicleTable.RevvingSound));
	end
	
	vehicle.RevvingSound:Play();
	vehicle.StopRevving = CurTime() + SoundDuration(vehicleTable.RevvingSound);
end
usermessage.Hook("perp2_spinout", doRevving);

local function monitorRevving ( )
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v.StopRevving && v.RevvingSound) then
			if (v.StopRevving < CurTime()) then
				v.StopRevving = nil;
				v.RevvingSound:Stop();
			else
				local speedOVehicle = v:GetVelocity():Length();
				
				if (speedOVehicle > 50) then
					v.RevvingSound:Stop();
					v.StopRevving = nil;
					
					local vehicleTable = lookForVT(v);
					v:EmitSound(Sound(vehicleTable.SpinoutSound));
				end
			end
		end
	end
end
hook.Add("Think", "monitorRevving", monitorRevving);

function GetCarUmsg ( UMsg )
	local CUID 		= UMsg:ReadLong();
	
	ClientCar	= tonumber(CUID)
	--LocalPlayer():Notify("From Client:" .. CUID .. " " .. ClientCar .. "");
end
usermessage.Hook("sendcarid", GetCarUmsg);

function RemoveBadID ( UMsg )
	local ID 		= UMsg:ReadShort();
	
	if ClientCar == ID then ClientCar = 0 end;
end
usermessage.Hook("removebadid", RemoveBadID);
 
function DoFuel ( )
	if !LocalPlayer() then return end
	if !LocalPlayer().InVehicle then return end
	if LocalPlayer():InVehicle() then
		local Tbl = LocalPlayer():GetVehicle().vehicleTable;
		if Tbl == nil then return end;
		if !Tbl.DF then return end;
		ClientCar = LocalPlayer():GetVehicle():GetNetworkedInt("carid");
		local ID = tostring(Tbl.FID);
		local DF = Tbl.DF;
		local Speed = math.Round(LocalPlayer():GetVehicle():GetVelocity():Length() / 17.6)
			
		RunConsoleCommand('perp_take_fuel', ID, Speed, DF);
	end
end

timer.Create("DoFuel", 1, 0, DoFuel);