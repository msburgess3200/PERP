


local ITEM 					= {};

ITEM.ID 					= 24;
ITEM.Reference 				= "item_board";

ITEM.Name 					= "Wooden Board";
ITEM.Description			= "A flat piece of wood.";

ITEM.Weight 				= 5;
ITEM.Cost					= 100;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_debris/wood_board06a.mdl";
ITEM.ModelCamPos 				= Vector(66, -4, 9);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_debris/wood_board06a.mdl";

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