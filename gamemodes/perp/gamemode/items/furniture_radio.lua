


local ITEM 					= {};

ITEM.ID 					= 1;
ITEM.Reference 				= "furniture_radio";

ITEM.Name 					= "Radio";
ITEM.Description			= "Picks up FM broadcasts.\n\nAim at radio once spawned and press Q to change it's frequency.";

ITEM.Weight 				= 5;
ITEM.Cost					= 1500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props/cs_office/radio.mdl";
ITEM.ModelCamPos 				= Vector(20, 0, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 8);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props/cs_office/radio.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM);
		
		if (!prop || !IsValid(prop)) then return false; end
		
		return true;
	end
	
	function ITEM.OnDrop ( Player )
		return true;
	end
	
	function ITEM.Equip ( Player )

	end
	
	function ITEM.Holster ( Player )

	end
	
else

	function ITEM.OnUse ( slotID )		
		return true;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);