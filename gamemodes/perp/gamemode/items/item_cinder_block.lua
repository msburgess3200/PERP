


local ITEM 					= {};

ITEM.ID 					= 21;
ITEM.Reference 				= "item_cinder_block";

ITEM.Name 					= "Cinder Block";
ITEM.Description			= "A small cinder block, ideal for making large, stable structures.";

ITEM.Weight 				= 10;
ITEM.Cost					= 100;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_junk/cinderblock01a.mdl";
ITEM.ModelCamPos 				= Vector(-28, 0, 2);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_junk/cinderblock01a.mdl";

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