


local ITEM 					= {};

ITEM.ID 					= 20;
ITEM.Reference 				= "item_cardboard";

ITEM.Name 					= "Cardboard Box";
ITEM.Description			= "An ancient box made of cardboard.";

ITEM.Weight 				= 5;
ITEM.Cost					= 150;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_junk/cardboard_box004a_gib01.mdl";
ITEM.ModelCamPos 				= Vector(4, 8, 18);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_junk/cardboard_box004a_gib01.mdl";

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