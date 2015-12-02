


local ITEM 					= {};

ITEM.ID 					= 11;
ITEM.Reference 				= "drug_meth_burned";

ITEM.Name 					= "Meth (Burned)";
ITEM.Description			= "Over-cooked meth. Worthless now.\n\nLeft Click to delete this item.";

ITEM.Weight 				= 5;
ITEM.Cost					= 200;

ITEM.MaxStack 				= 25;

ITEM.InventoryModel 		= "models/props/water_bottle/perpb_bottle.mdl";
ITEM.ModelCamPos 				= Vector(36, -6, 5);
ITEM.ModelLookAt 				= Vector(0, 0, 5);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props/water_bottle/perpb_bottle.mdl";

ITEM.RestrictedSelling	 	= true; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		return true;
	end
	
	function ITEM.OnDrop ( Player )
		return false;
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
		return false;
	end
	
end

GM:RegisterItem(ITEM);