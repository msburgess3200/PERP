


local ITEM 					= {};

ITEM.ID 					= 115;
ITEM.Reference 				= "furniture_police_barrier";

ITEM.Name 					= "Police Barricade";
ITEM.Description			= "Useful for blocking\ncity roads.\n\n";

ITEM.Weight 				= 15;
ITEM.Cost					= 850;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_wasteland/barricade002a.mdl";
ITEM.ModelCamPos 				= Vector(0, 132, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_wasteland/barricade002a.mdl";

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