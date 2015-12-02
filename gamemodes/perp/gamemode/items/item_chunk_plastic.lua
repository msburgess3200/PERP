


local ITEM 					= {};

ITEM.ID 					= 19;
ITEM.Reference 				= "item_chunk_plastic";

ITEM.Name 					= "Chunk of Plastic";
ITEM.Description			= "A small chunk of plastic.";

ITEM.Weight 				= 5;
ITEM.Cost					= 200;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_c17/canisterchunk01a.mdl";
ITEM.ModelCamPos 				= Vector(14, 0, 18);
ITEM.ModelLookAt 				= Vector(0, 0, 20);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_c17/canisterchunk01a.mdl";

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