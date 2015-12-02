


local ITEM 					= {};

ITEM.ID 					= 111;
ITEM.Reference 				= "furniture_bdoll";

ITEM.Name 					= "Doll";
ITEM.Description			= "A doll to do nasty things in the bed room with.";

ITEM.Weight 				= 5;
ITEM.Cost					= 200;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/striker/mosslover.mdl";
ITEM.ModelCamPos 				= Vector(20, 0, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 8);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/striker/mosslover.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM);
		
		if (!prop || !IsValid(prop)) then return false; end
		
		return true;
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
		return true;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);