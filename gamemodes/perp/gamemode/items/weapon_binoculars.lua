

local ITEM 					= {};

ITEM.ID 					= 16;
ITEM.Reference 				= "weapon_binoculars";

ITEM.Name 					= "Binoculars";
ITEM.Description			= "With three different zoom levels!";

ITEM.Weight 				= 5;
ITEM.Cost					= 750;

ITEM.MaxStack 				= 10;

ITEM.InventoryModel 		= "models/weapons/w_perpculars.mdl";
ITEM.ModelCamPos 				= Vector(0, 0, -12);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/weapons/w_perpculars.mdl";

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
		Player:Give("weapon_perp_binoculars");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("weapon_perp_binoculars");
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