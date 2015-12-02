

local ITEM 					= {};

ITEM.ID 					= 125;
ITEM.Reference 				= "item_chip";

ITEM.Name = 'Electronics';
ITEM.Description = "An electronic component, useful for making automated systems.";

ITEM.Weight = 20;
ITEM.Cost = 300;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/cheeze/wires/mini_chip.mdl";
ITEM.ModelCamPos = Vector(0, 0, 8);
ITEM.ModelLookAt = Vector(0, 0, 0);
ITEM.ModelFOV = 70;
ITEM.WorldModel 			= "models/cheeze/wires/mini_chip.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

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