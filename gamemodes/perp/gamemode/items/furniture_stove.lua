


local ITEM 					= {};

ITEM.ID 					= 12;
ITEM.Reference 				= "furniture_stove";

ITEM.Name 					= "Stove";
ITEM.Description			= "Useful for cooking things.\n\nLeft click to spawn as prop.";

ITEM.Weight 				= 35;
ITEM.Cost					= 1000;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_wasteland/kitchen_stove001a.mdl";
ITEM.ModelCamPos 				= Vector(80, 0, 32);
ITEM.ModelLookAt 				= Vector(-4, 0, 21);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_wasteland/kitchen_stove001a.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM);
		
		if (!prop || !IsValid(prop)) then return false; end
		
		prop:GetTable().HeatSource = true;
		
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