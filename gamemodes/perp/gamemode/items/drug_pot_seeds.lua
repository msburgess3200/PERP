


local ITEM 					= {};

ITEM.ID 					= 14;
ITEM.Reference 				= "drug_pot_seeds";

ITEM.Name 					= "Cannabis Seeds";
ITEM.Description			= "Looks like they would grow in a pot...";

ITEM.Weight 				= 5;
ITEM.Cost					= 200;

ITEM.MaxStack 				= 500;

ITEM.InventoryModel 		= "models/katharsmodels/contraband/zak_wiet/zak_seed.mdl";
ITEM.ModelCamPos 				= Vector(2, 0, 8);
ITEM.ModelLookAt 				= Vector(1, 0, -4);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/katharsmodels/contraband/zak_wiet/zak_seed.mdl";

ITEM.RestrictedSelling	 	= true; // Used for drugs and the like. So we can't sell it.

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