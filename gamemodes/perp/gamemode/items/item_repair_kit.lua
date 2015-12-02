


local ITEM 					= {};

ITEM.ID 					= 110;
ITEM.Reference 				= "item_repair_kit";

ITEM.Name 					= "Repair Kit";
ITEM.Description			= "Useful to repair broken down cars. Dynamic Effect Special.";

ITEM.Weight 				= 20;
ITEM.Cost					= 1500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/items/car_battery01.mdl";
ITEM.ModelCamPos 				= Vector(0, 0, 30);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/items/car_battery01.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )	
		local EyeTrace = Player:GetEyeTrace();
		
		if !EyeTrace.Entity or !EyeTrace.Entity:IsValid() or !EyeTrace.Entity:IsVehicle() or EyeTrace.Entity:GetPos():Distance(Player:GetPos()) > 200 then
			Player:Notify('You must aim at a vehicle to use this device.');
			return false;
		end
		
		if EyeTrace.Entity.Disabled == false then
			Player:Notify('That vehicle is already fixed.');
			return false;
		end
		
		Player:Notify('The vehicle has been repaired.');
		local Owner = EyeTrace.Entity:GetNetworkedEntity("owner");
		Owner.HasDisabledCar = false;
		EyeTrace.Entity.Disabled = false;
		//EyeTrace.Entity:SetColor(255, 255, 255, 255);
		EyeTrace.Entity:Fire('turnon', '', .5)
		
		
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
		return false;
	end
	
	function ITEM.OnDrop ( )
		return false;
	end
	
end

GM:RegisterItem(ITEM);