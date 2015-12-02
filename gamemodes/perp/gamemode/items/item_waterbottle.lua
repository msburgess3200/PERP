


local ITEM 					= {};

ITEM.ID 					= 4;
ITEM.Reference 				= "item_waterbottle";

ITEM.Name 					= "Water Bottle";
ITEM.Description			= "A 24 oz. bottle of water.";

ITEM.Weight 				= 5;
ITEM.Cost					= 150;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props/cs_office/Water_bottle.mdl";
ITEM.ModelCamPos 				= Vector(12, 2, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props/cs_office/Water_bottle.mdl";

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