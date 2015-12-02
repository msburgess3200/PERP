


local ITEM 					= {};

ITEM.ID 					= 30;
ITEM.Reference 				= "ammo_pistol";

ITEM.Name 					= "Pistol Ammo";
ITEM.Description			= "Allows you to fire your small-arms.\n\nGrants 20 pistol bullets.";

ITEM.Weight 				= 5;
ITEM.Cost					= 1000;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/items/357ammo.mdl";
ITEM.ModelCamPos 				= Vector(12, -4, 9);
ITEM.ModelLookAt 				= Vector(0, 0, 4);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/items/357ammo.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )	
		Player:GiveAmmo(20, "pistol");
	
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