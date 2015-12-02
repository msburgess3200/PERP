


local ITEM 					= {};

ITEM.ID 					= 27;
ITEM.Reference 				= "weapon_bottle";

ITEM.Name 					= "Empty Bottle";
ITEM.Description			= "It appears to be an empty bottle.";

ITEM.Weight 				= 5;
ITEM.Cost					= 50;

ITEM.MaxStack 				= 50;

ITEM.InventoryModel 		= "models/props_junk/garbage_glassbottle003z.mdl";
ITEM.ModelCamPos 				= Vector(1, -16, 1);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_junk/garbage_glassbottle003z.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= EQUIP_SIDE;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		return false;
	end
	
	function ITEM.OnDrop ( Player )
		return true;
	end
	
	function ITEM.Equip ( Player )
		Player:Give("weapon_perp_bottle");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("weapon_perp_bottle");
	end
	
else

	function ITEM.OnUse ( slotID )	
		GAMEMODE.AttemptToEquip(slotID);
		
		return false;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);