


local ITEM 					= {};

ITEM.ID 					= 81;
ITEM.Reference 				= "furniture_metal_detector";

ITEM.Name 					= "Metal Detector";
ITEM.Description			= "Detects when people pass through with weapons.\n\nLeft click to spawn as prop.";

ITEM.Weight 				= 100;
ITEM.Cost					= 1500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_wasteland/interior_fence002e.mdl";
ITEM.ModelCamPos 				= Vector(100, 100, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_wasteland/interior_fence002e.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM, "prop_metal_detector");
		
		if (!prop || !IsValid(prop)) then return false; end
		
		prop:SetItemOwner(Player);
		
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