


local ITEM 					= {};

ITEM.ID 					= 67;
ITEM.Reference 				= "item_glue";

ITEM.Name 					= "Glue";
ITEM.Description			= "A hot glue gun. Useful for wood working.";

ITEM.Weight 				= 5;
ITEM.Cost					= 125;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/Items/battery.mdl";
ITEM.ModelCamPos 				= Vector(1, -17, 6);
ITEM.ModelLookAt 				= Vector(0, 0, 5);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/Items/battery.mdl";

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