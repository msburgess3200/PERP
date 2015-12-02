local ITEM = {};

ITEM.ID = 116;
ITEM.Reference = "item_stim_pack";
ITEM.MaxStack = 100;
ITEM.Weight = 5;
ITEM.Cost = 300;
ITEM.Name = "Stim Pack";
ITEM.Description = "Heals your wounds.";

ITEM.InventoryModel = "models/healthvial.mdl";
ITEM.WorldModel = "models/healthvial.mdl";
ITEM.ModelCamPos = Vector(12, -4, 9);
ITEM.ModelLookAt = Vector(0, 0, 4);
ITEM.ModelFOV = 70;

ITEM.RestrictedSelling	 	= false;
ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		if Player:Health() == 100 then return false; end
		
		Player:SetHealth(math.Clamp(Player:Health() + 20, 0, 100));
				if Player:GetTable().IsCrippled then
			Player:GetTable().IsCrippled = false;
			Player:RestoreNormalSpeed();
		end

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