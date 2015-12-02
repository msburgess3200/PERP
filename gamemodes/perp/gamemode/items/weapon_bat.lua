

local ITEM 					= {};

ITEM.ID 					= 56;
ITEM.Reference 				= "weapon_bat";

ITEM.Name 					= "Baseball Bat";
ITEM.Description			= "Useful for home defense.";

ITEM.Weight 				= 5;
ITEM.Cost					= 500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/weapons/w_basebat.mdl";
ITEM.ModelCamPos 				= Vector(-8, 8, -26);
ITEM.ModelLookAt 				= Vector(-2, -2, 10);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/weapons/w_basebat.mdl";

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
		Player:Give("weapon_perp_bat");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("weapon_perp_bat");
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