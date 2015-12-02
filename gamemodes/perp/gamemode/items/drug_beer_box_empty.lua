


local ITEM 					= {};

ITEM.ID 					= 64;
ITEM.Reference 				= "drug_beer_box_empty";

ITEM.Name 					= "Box o' Beer (Empty)";
ITEM.Description			= "Allows your guests to grab beers at their leisure.\n\nLeft click to spawn as prop.";

ITEM.Weight 				= 10;
ITEM.Cost					= 100;

ITEM.MaxStack 				= 10;

ITEM.InventoryModel 		= "models/props/cs_militia/caseofbeer01.mdl";
ITEM.ModelCamPos 				= Vector(0, -16, 25);
ITEM.ModelLookAt 				= Vector(0, 0, 5);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props/cs_militia/caseofbeer01.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM, "prop_case_beer");
		
		if (!prop || !IsValid(prop)) then return false; end
		
		prop:SetNumBeers(0, Player)
				
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