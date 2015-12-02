


local ITEM 					= {};

ITEM.ID 					= 3;
ITEM.Reference 				= "item_lifealert";

ITEM.Name 					= "Life Alert";
ITEM.Description			= "Automatically contacts paramedics in case of an accident.";

ITEM.Weight 				= 5;
ITEM.Cost					= 500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_c17/consolebox05a.mdl";
ITEM.ModelCamPos 				= Vector(33, 20, 9);
ITEM.ModelLookAt 				= Vector(0, -5, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_c17/consolebox05a.mdl";

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