


local ITEM 					= {};

ITEM.ID 					= 66;
ITEM.Reference 				= "furniture_saw_horse";

ITEM.Name 					= "Saw Horse";
ITEM.Description			= "Useful for working with wood.\n\nLeft click to spawn as prop.";

ITEM.Weight 				= 100;
ITEM.Cost					= 750;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props/cs_militia/sawhorse.mdl";
ITEM.ModelCamPos 				= Vector(42, -54, 20);
ITEM.ModelLookAt 				= Vector(-6, 0, 15);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props/cs_militia/sawhorse.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM);
		
		if (!prop || !IsValid(prop)) then return false; end
		
		prop:GetTable().SawHorse = true;
		
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