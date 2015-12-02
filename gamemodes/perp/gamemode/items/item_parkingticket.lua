


local ITEM 					= {};

ITEM.ID 					= 107;
ITEM.Reference 				= "item_parkingticket";

ITEM.Name 					= "Traffic Ticket";
ITEM.Description			= "You have to pay it (use it) before you can drive your vehicles again.";

ITEM.Weight 				= 1;
ITEM.Cost					= 1;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_lab/clipboard.mdl";
ITEM.ModelCamPos 				= Vector(22, 6, 8);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_lab/clipboard.mdl";

ITEM.RestrictedSelling	 	= true; //Used for drugs and the like. So we can't sell it.
ITEM.RestrictTrading = true;

ITEM.EquipZone 				= nil;										
ITEM.PredictUseDrop			= false; //If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( objPl )	
		local iPrice = GetGlobalInt("ticket_price");
		
		if(objPl:GetCash() < iPrice) then
			objPl:Notify("You can't afford this!");
			return false;
		end
		
		objPl:TakeCash(iPrice, nil, "Parking Ticket");
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
		return false;
	end
	
	function ITEM.OnDrop()
		return false;
	end
end

GM:RegisterItem(ITEM);