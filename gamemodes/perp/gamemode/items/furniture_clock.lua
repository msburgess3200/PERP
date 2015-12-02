


local ITEM 					= {};

ITEM.ID 					= 17;
ITEM.Reference 				= "furniture_clock";

ITEM.Name 					= "Clock";
ITEM.Description			= "Displays the time in an easy to read fashion.\n\nLeft click to spawn as prop.";

ITEM.Weight 				= 10;
ITEM.Cost					= 500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_c17/clock01.mdl";
ITEM.ModelCamPos 				= Vector(2, 0, 17);
ITEM.ModelLookAt 				= Vector(-14, 0, -88);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_c17/clock01.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM, "prop_clock");
		
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
		return false;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);