


local ITEM 					= {};

ITEM.ID 					= 170;
ITEM.Reference 				= "item_car_lock";

ITEM.Name 					= "Car Security Upgrade";
ITEM.Description			= "No lockpick will get passed this security system. (Vehicles Only)";

ITEM.Weight 				= 5;
ITEM.Cost					= 1000;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_c17/consolebox05a.mdl";
ITEM.ModelCamPos 				= Vector(41, 0, -24);
ITEM.ModelLookAt 				= Vector(9, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_c17/consolebox05a.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		local w = Player:GetEyeTrace();
		
		if (!w.Entity || !IsValid(w.Entity) || !w.Entity:IsVehicle()) then
			Player:Notify("You must be aiming at a vehicle to use this item.");
		return false; end
		
		if (w.Entity:GetPos():Distance(Player:GetPos()) > 200) then
			Player:Notify("You must be aiming at a vehicle to use this item.");
		return false; end
		
		if (w.Entity.PadLocked) then
			Player:Notify("This vehicle already has upgraded security.");
		return false; end
		
		if (w.Entity:GetDriver() && IsValid(w.Entity:GetDriver())) then
			Player:Notify("The driver will see you if you do that!");
		return false; end
		
		Player:Notify("Vehicle Security Upgraded.");
		
		w.Entity.PadLocked = true;
		
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
		return true;
	end
	
end

GM:RegisterItem(ITEM);