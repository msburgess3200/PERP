


local ITEM 					= {};

ITEM.ID 					= 164;
ITEM.Reference 				= "weapon_hk45";

ITEM.Name 					= "HK45";
ITEM.Description			= "A nice pistol.\n\nRequires Pistol Ammo.";

ITEM.Weight 				= 25;
ITEM.Cost					= 1300;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/weapons/w_pist_usp.mdl";
ITEM.ModelCamPos 				= Vector(6, 13, 0);
ITEM.ModelLookAt 				= Vector(6, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/weapons/w_pist_usp.mdl";

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
		Player:Give("weapon_perp_hk45");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("weapon_perp_hk45");
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