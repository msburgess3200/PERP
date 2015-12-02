


local ITEM 					= {};

ITEM.ID 					= 32;
ITEM.Reference 				= "ammo_shotgun";

ITEM.Name 					= "Buckshot";
ITEM.Description			= "Allows you to fire your shotguns.\n\nGrants 10 buckshot cartridges.";

ITEM.Weight 				= 5;
ITEM.Cost					= 1000;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/items/boxbuckshot.mdl";
ITEM.ModelCamPos			 	= Vector(13, 12, 13);
ITEM.ModelLookAt 				= Vector(1, 2, 5);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/items/boxbuckshot.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )	
		Player:GiveAmmo(10, "buckshot");
	
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