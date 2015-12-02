


local ITEM 					= {};

ITEM.ID 					= 45;
ITEM.Reference 				= "furniture_chair_wooden";

ITEM.Name 					= "Wooden Chair";
ITEM.Description			= "Take a load off.\n\nLeft click to spawn as prop.\nUse + ALT to pickup after dropped as prop.";

ITEM.Weight 				= 35;
ITEM.Cost					= 750;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/nova/chair_wood01.mdl";
ITEM.ModelCamPos 				= Vector(45, 18, 22);
ITEM.ModelLookAt 				= Vector(0, 0, 17);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/nova/chair_wood01.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM, "prop_vehicle_prisoner_pod");
		
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
		return true;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);