


VEHICLE_DATABASE = {};

// Display order for garage.
VEHICLE_DISPLAY_ORDER = {"a", "b", "c", "d", "e", "f", "g", "h", "i","j", "k", "l", "m", "n", "o", "p", "q", "r", "t", "s", "2", "C", "6", "u", "5", "A", "B", "E", "4", "3", "F", "G", "I", "J", "K", "L", "N", "O", "1", "H", "7", "8", "9", "P", "Q", "R", "S", "T"};
// Non-VIPS (Dealership)
VEHICLE_DISPLAY_ORDER_NORMAL = {"a", "b", "c", "d", "e", "g", "h", "i", "j", "k", "l" , "m", "n", "o", "p", "q", "r", "t", "s"};

// VIP Dealership, credits to IntegralGaming for the work.
VEHICLE_DISPLAY_ORDER_VIP = { "I", "Q", "R", "*", "S", "Y", "U", "K", "T", "J", "Z", "F", "V" };



function GM:RegisterVehicle ( VehicleTable )
	if (VEHICLE_DATABASE[VehicleTable.ID]) then
		Error("Conflicting vehicle ID's #" .. VehicleTable.ID);
	end
	
	if (CLIENT && !VehicleTable.RequiredClass) then
		VehicleTable.Texture = surface.GetTextureID('PERP2/vehicles/new/' .. VehicleTable.Script);
	end
	
	for k, v in pairs(VehicleTable.PaintJobs) do
		util.PrecacheModel(v.model);
	end
	
	VEHICLE_DATABASE[VehicleTable.ID] = VehicleTable;
	Msg("\t-> Loaded " .. VehicleTable.Name .. ", " .. VehicleTable.ID .. "\n");
end

function PLAYER:HasVehicle ( vehicleID )
	local playerTable;
	
	if SERVER then playerTable = self.Vehicles; else playerTable = GAMEMODE.Vehicles; end
	
	if (playerTable[vehicleID]) then return true; else return false; end
end