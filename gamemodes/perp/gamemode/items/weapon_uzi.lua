


local ITEM 					= {};

ITEM.ID 					= 33;
ITEM.Reference 				= "weapon_uzi";

ITEM.Name 					= "Uzi";
ITEM.Description			= "The classic gangster weapon.\n\nRequires Rifle Ammo.";

ITEM.Weight 				= 25;
ITEM.Cost					= 2000;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/weapons/w_smg_mac10.mdl";
ITEM.ModelCamPos 				= Vector(8, -15, 0);
ITEM.ModelLookAt 				= Vector(6, 1, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/weapons/w_smg_mac10.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= EQUIP_MAIN;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		return false;
	end
	
	function ITEM.OnDrop ( Player )
		return true;
	end
	
	function ITEM.Equip ( Player )
		Player:Give("weapon_perp_uzi");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("weapon_perp_uzi");
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