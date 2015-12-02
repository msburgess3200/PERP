


local ITEM 					= {};

ITEM.ID 					= 15;
ITEM.Reference 				= "item_pot";

ITEM.Name 					= "Gardening Pot";
ITEM.Description			= "Useful for planting things.";

ITEM.Weight 				= 10;
ITEM.Cost					= 300;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_c17/pottery06a.mdl";
ITEM.ModelCamPos 				= Vector(42, 6, 18);
ITEM.ModelLookAt 				= Vector(0, 0, 14);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_c17/pottery06a.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		return false;
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