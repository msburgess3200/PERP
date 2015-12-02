


local ITEM 					= {};

ITEM.ID 					= 53;
ITEM.Reference 				= "furniture_bed";

ITEM.Name 					= "Small Bed";
ITEM.Description			= "Needed for a good night's sleep.\n\nLeft click to spawn as prop.";

ITEM.Weight 				= 10;
ITEM.Cost					= 500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/env/furniture/bed_connemara/bed_connemara_3rd.mdl";
ITEM.ModelCamPos 				= Vector(93, 52, 68);
ITEM.ModelLookAt 				= Vector(0, 0, 13);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/env/furniture/bed_connemara/bed_connemara_3rd.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM);
		
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