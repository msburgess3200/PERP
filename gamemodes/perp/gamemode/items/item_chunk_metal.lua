


local ITEM 					= {};

ITEM.ID 					= 18;
ITEM.Reference 				= "item_chunk_metal";

ITEM.Name 					= "Piece of Metal";
ITEM.Description			= "A small piece of metal.";

ITEM.Weight 				= 5;
ITEM.Cost					= 250;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/gibs/metal_gib4.mdl";
ITEM.ModelCamPos 				= Vector(0, 0, 8);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/gibs/metal_gib4.mdl";

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