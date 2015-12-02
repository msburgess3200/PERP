

local ITEM 					= {};

ITEM.ID 					= 34;
ITEM.Reference 				= "weapon_deagle";

ITEM.Name 					= "Desert Eagle";
ITEM.Description			= "A deadly side-arm.\n\nRequires Pistol Ammo.";

ITEM.Weight 				= 25;
ITEM.Cost					= 1000;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/weapons/w_pist_deagle.mdl";
ITEM.ModelCamPos 				= Vector(6, 17, 4);
ITEM.ModelLookAt 				= Vector(8, -8, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/weapons/w_pist_deagle.mdl";

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
		Player:Give("weapon_perp_deagle2");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("weapon_perp_deagle2");
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