

local ITEM 					= {};

ITEM.ID 					= 133;
ITEM.Reference 				= "food_orangejuice";

ITEM.Name = 'Orange Juice';
ITEM.Description = "Orange juice, good for your health.";

ITEM.Weight = 2;
ITEM.Cost = 40;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_junk/garbage_plasticbottle003a.mdl";
ITEM.ModelCamPos = Vector(48, 0, 28);
ITEM.ModelLookAt = Vector(0, 0, 0);
ITEM.ModelFOV = 30;
ITEM.WorldModel 			= "models/props_junk/garbage_plasticbottle003a.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us.

ITEM.Health = 5;

if SERVER then

	function ITEM.OnUse ( objPl )
		objPl:EmitSound("perp2.5/drinking.mp3");
		
		objPl:SetHealth(math.Clamp(objPl:Health() + ITEM.Health, 0, 100));
		
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
		surface.PlaySound('perp2.5/drinking.mp3');
		
		return true;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);