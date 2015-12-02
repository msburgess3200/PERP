


local ITEM 					= {};

ITEM.ID 					= 41;
ITEM.Reference 				= "item_car_bomb";

ITEM.Name 					= "Car Bomb";
ITEM.Description			= "Explodes when car is started.";

ITEM.Weight 				= 5;
ITEM.Cost					= 2000;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/weapons/w_c4_planted.mdl";
ITEM.ModelCamPos 				= Vector(0, 0, 30);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/weapons/w_c4_planted.mdl";

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
		
		if (w.Entity.RiggedToExplode) then
			Player:Notify("That vehicle is already rigged with a car bomb.");
		return false; end
		
		if (w.Entity:GetDriver() && IsValid(w.Entity:GetDriver())) then
			Player:Notify("The driver will see you if you do that!");
		return false; end
		
		Player:Notify("Car bomb planted.");
		
		w.Entity.RiggedToExplode = true;
		w.Entity.Rigger = Player;
		
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