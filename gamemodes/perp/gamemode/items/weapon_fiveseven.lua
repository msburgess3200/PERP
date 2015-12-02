


local ITEM 					= {};

ITEM.ID 					= 35;
ITEM.Reference 				= "weapon_fiveseven";

ITEM.Name 					= "Five-Seven";
ITEM.Description			= "A sleek-looking pistol.\n\nRequires Pistol Ammo.";

ITEM.Weight 				= 25;
ITEM.Cost					= 800;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/weapons/w_pist_fiveseven.mdl";
ITEM.ModelCamPos 				= Vector(8, 12, 2);
ITEM.ModelLookAt 				= Vector(6, -1, 2);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/weapons/w_pist_fiveseven.mdl";

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
		Player:Give("weapon_perp_fiveseven");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("weapon_perp_fiveseven");
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