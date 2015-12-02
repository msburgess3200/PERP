


local ITEM 					= {};

ITEM.ID 					= 62;
ITEM.Reference 				= "item_coke";

ITEM.Name 					= "Cola";
ITEM.Description			= "A small can of cola.\n\nRestores a small ammount of stamina.";

ITEM.Weight 				= 5;
ITEM.Cost					= 250;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_junk/PopCan01a.mdl";
ITEM.ModelCamPos 				= Vector(4, -8, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_junk/PopCan01a.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

local toAddStam = 15;

if SERVER then

	function ITEM.OnUse ( Player )		
		Player.Stamina = math.Clamp(Player.Stamina + toAddStam, 0, 100);
	
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
		LocalPlayer().Stamina = math.Clamp(LocalPlayer().Stamina + toAddStam, 0, 100);
		
		surface.PlaySound("PERP2.5/can_opening.mp3");
		timer.Simple(.5, function() surface.PlaySound("PERP2.5/drinking.mp3") end)
		
		return true;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);