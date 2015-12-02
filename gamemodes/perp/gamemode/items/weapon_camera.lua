

local ITEM 					= {};

ITEM.ID 					= 156;
ITEM.Reference 				= "weapon_camera";

ITEM.Name 					= "Camera";
ITEM.Description			= "Take pictures.";

ITEM.Weight 				= 5;
ITEM.Cost					= 250;

ITEM.MaxStack 				= 25;

ITEM.InventoryModel 		= "models/weapons/w_camphone.mdl";
ITEM.ModelCamPos 				= Vector(15, 2, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 2);
ITEM.ModelFOV 					= 30;
ITEM.WorldModel 			= "models/weapons/w_camphone.mdl";

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
		Player:Give("camera");
	end
	
	function ITEM.Holster ( Player )
		Player:StripWeapon("camera");
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