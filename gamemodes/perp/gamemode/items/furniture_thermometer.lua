


local ITEM 					= {};

ITEM.ID 					= 60;
ITEM.Reference 				= "furniture_thermometer";

ITEM.Name 					= "Thermometer";
ITEM.Description			= "Displays the temperature.\n\nLeft click to spawn as prop.";

ITEM.Weight 				= 10;
ITEM.Cost					= 750;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_combine/perpthermo.mdl";
ITEM.ModelCamPos 				= Vector(18, 0, -2);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_combine/perpthermo.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM, "prop_thermo");
		
		if (!prop || !IsValid(prop)) then return false; end
		
		return true;
	end
	
	function ITEM.OnDrop ( Player )
		return true;
	end
	
	function ITEM.Equip ( Player )

	end
	
	function ITEM.Holster ( Player )

	end
	
else

	function ITEM.OnUse ( slotID )		
		return false;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);