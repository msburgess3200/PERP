


local ITEM 					= {};

ITEM.ID 					= 9;
ITEM.Reference 				= "drug_meth_wet";

ITEM.Name 					= "Meth (Wet)";
ITEM.Description			= "This meth's all wet. You should probably dry it out somehow.\n\n(Place wet meth in item form next to a stove to dry. Let set until begins to boil.)";

ITEM.Weight 				= 5;
ITEM.Cost					= 200;

ITEM.MaxStack 				= 25;

ITEM.InventoryModel 		= "models/props/water_bottle/perp2_bottle.mdl";
ITEM.ModelCamPos 				= Vector(36, -6, 5);
ITEM.ModelLookAt 				= Vector(0, 0, 5);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props/water_bottle/perp2_bottle.mdl";

ITEM.RestrictedSelling	 	= true; // Used for drugs and the like. So we can't sell it.

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