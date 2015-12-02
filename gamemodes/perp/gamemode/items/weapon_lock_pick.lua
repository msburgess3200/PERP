

local ITEM 					= {};

ITEM.ID 					= 43;
ITEM.Reference 				= "weapon_lock_pick";

ITEM.Name 					= "Lock Pick";
ITEM.Description			= "Useful for going where you don't belong.\n\nRequires level 3 strength to use.";

ITEM.Weight 				= 5;
ITEM.Cost					= 200;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/weapons/w_crowbar.mdl";
ITEM.ModelCamPos 				= Vector(8, 9, 24);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/weapons/w_crowbar.mdl";

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
		if (Player:GetPERPLevel(GENE_STRENGTH) < 3) then
			Player:Notify("You must have level 3 strength to use this item.\n");
			return;
		end
	
		Player:Give("weapon_perp_lock_pick");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("weapon_perp_lock_pick");
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