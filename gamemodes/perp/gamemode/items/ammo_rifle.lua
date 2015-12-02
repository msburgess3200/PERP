


local ITEM 					= {};

ITEM.ID 					= 31;
ITEM.Reference 				= "ammo_rifle";

ITEM.Name 					= "Rifle Ammo";
ITEM.Description			= "Allows you to fire your small-arms.\n\nGrants 60 rifle bullets.";

ITEM.Weight 				= 5;
ITEM.Cost					= 1000;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/Items/BoxSRounds.mdl";
ITEM.ModelCamPos 				= Vector(21, -4, 6);
ITEM.ModelLookAt 				= Vector(-2, 0, 6);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/Items/BoxSRounds.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )
		Player:GiveAmmo(60, "smg1");
	
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