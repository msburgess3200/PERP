


local ITEM 					= {};

ITEM.ID 					= 49;
ITEM.Reference 				= "furniture_cone";

ITEM.Name 					= "Traffic Cone";
ITEM.Description			= "Points out hazardous areas to drivers.\n\nLeft click to spawn as prop.";

ITEM.Weight 				= 35;
ITEM.Cost					= 250;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_junk/trafficcone001a.mdl";
ITEM.ModelCamPos 				= Vector(8, 34, 8);
ITEM.ModelLookAt 				= Vector(0, 0, -2);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_junk/trafficcone001a.mdl";

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