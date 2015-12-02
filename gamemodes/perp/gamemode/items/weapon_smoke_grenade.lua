


local ITEM 					= {};

ITEM.ID 					= 200;
ITEM.Reference 				= "weapon_smoke_grenade";

ITEM.Name 					= "Smoke Grenade";
ITEM.Description			= "Used for smoking out your enemies.";

ITEM.Weight 				= 5;
ITEM.Cost					= 500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/weapons/w_eq_flashbang.mdl";
ITEM.ModelCamPos 				= Vector(1, -16, 1);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/weapons/w_eq_flashbang.mdl";

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
		Player:Give("smoke_grenade");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("smoke_grenade");
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