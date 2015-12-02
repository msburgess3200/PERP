local ITEM 					= {};

ITEM.ID 					= 162;
ITEM.Reference 				= "item_kevlar_vest";

ITEM.Name 					= "Armor";
ITEM.Description			= "An armor vest.\n\nIncreases your armor by 30.";

ITEM.Weight 				= 20;
ITEM.Cost					= 2500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/kevlarvest/kevlarvest.mdl";
ITEM.ModelCamPos 				= Vector(-25, 0, 66);
ITEM.ModelLookAt 				= Vector(25, 0, 50);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/kevlarvest/kevlarvest.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

local toAddArmor = 30;

if SERVER then

	function ITEM.OnUse ( Player )		
		Player:SetArmor(50)
	
		return true;
	end
	
	function ITEM.OnDrop ( Player )
		return false;
	end
	
	function ITEM.Equip ( Player )

	end
	
	function ITEM.Holster ( Player )

	end
	
else

	function ITEM.OnUse ( slotID )	
		LocalPlayer():SetArmor(30);
		
		//surface.PlaySound("PERP2.5/can_opening.mp3");
		//timer.Simple(.5, surface.PlaySound, "PERP2.5/drinking.mp3")
		
		return true;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);
