


local ITEM 					= {};

ITEM.ID 					= 85;
ITEM.Reference 				= "furniture_Concrete_Barrier";

ITEM.Name 					= "Concrete Barrier";
ITEM.Description			= "Useful for blocking\n\noff roads.";

ITEM.Weight 				= 80;
ITEM.Cost					= 350;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_phx/construct/concrete_barrier00.mdl";
ITEM.ModelCamPos            = Vector(-78, -68, 20);
ITEM.ModelLookAt            = Vector(15, -5, 20);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_phx/construct/concrete_barrier00.mdl";

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