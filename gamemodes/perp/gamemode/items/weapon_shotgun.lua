


local ITEM 					= {};

ITEM.ID 					= 37;
ITEM.Reference 				= "weapon_shotgun";

ITEM.Name 					= "Shotgun";
ITEM.Description			= "A pump-action shotgun.\n\nRequires Buckshot.";

ITEM.Weight 				= 25;
ITEM.Cost					= 1500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/weapons/w_shot_m3super90.mdl";
ITEM.ModelCamPos 				= Vector(18, -36, 0);
ITEM.ModelLookAt 				= Vector(12, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/weapons/w_shot_m3super90.mdl";

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
		Player:Give("weapon_perp_shotgun");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("weapon_perp_shotgun");
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