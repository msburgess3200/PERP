

local ITEM 					= {};

ITEM.ID 					= 131;
ITEM.Reference 				= "food_coffee";

ITEM.Name = 'Coffee';
ITEM.Description = "Short but powerful energy boosts.";

ITEM.Weight = 2;
ITEM.Cost = 35;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_junk/garbage_coffeemug001a.mdl";
ITEM.ModelCamPos = Vector(48, 0, 28);
ITEM.ModelLookAt = Vector(0, 0, 0);
ITEM.ModelFOV = 30;
ITEM.WorldModel 			= "models/props_junk/garbage_coffeemug001a.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us.

ITEM.Health = 0;

local toAddStam = 50;

if SERVER then
	function ITEM.OnUse ( objPl )
		objPl:EmitSound("perp2.5/drinking.mp3");
		
		objPl.Stamina = math.Clamp(objPl.Stamina + toAddStam, 0, 100);
		
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
		
		LocalPlayer().Stamina = math.Clamp(LocalPlayer().Stamina + toAddStam, 0, 100);
		
		return true;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);