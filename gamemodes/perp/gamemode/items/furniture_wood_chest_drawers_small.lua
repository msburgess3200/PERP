


local ITEM 					= {};

ITEM.ID 					= 74;
ITEM.Reference 				= "furniture_wood_chest_drawers_small";

ITEM.Name 					= "Small Chest of Drawers";
ITEM.Description			= "I don't know what you'll stack in here. Haven't you got enough drawers already?\n\nLeft click to spawn as prop.";

ITEM.Weight 				= 30;
ITEM.Cost					= 300;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_c17/furnituredrawer003a.mdl";
ITEM.ModelCamPos 				= Vector(48, -24, 0);			
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_c17/furnituredrawer003a.mdl";

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