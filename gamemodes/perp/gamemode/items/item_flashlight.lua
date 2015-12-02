


local ITEM 					= {};

ITEM.ID 					= 126;
ITEM.Reference 				= "item_flashlight"

ITEM.Name = 'Flashlight';
ITEM.Description = "See in the dark.";

ITEM.Weight 				= 5;
ITEM.Cost					= 1000;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/lagmite/lagmite.mdl";
ITEM.ModelCamPos = Vector(0, 14, 21);
ITEM.ModelLookAt = Vector(8, -4, -1);
ITEM.ModelFOV = 70;
ITEM.WorldModel 			= "models/lagmite/lagmite.mdl";

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

GM:RegisterItem(ITEM)