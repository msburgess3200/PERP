


local ITEM 					= {};

ITEM.ID 					= 42;
ITEM.Reference 				= "item_house_alarm";

ITEM.Name 					= "House Alarm";
ITEM.Description			= "Alerts the police department if someone attempts to break into your home or business.";

ITEM.Weight 				= 5;
ITEM.Cost					= 250;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_lab/reciever01d.mdl";
ITEM.ModelCamPos 				= Vector(17, 0, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_lab/reciever01d.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		local w = Player:GetEyeTrace();
		
		if (!w.Entity || !IsValid(w.Entity) || !w.Entity:IsDoor()) then
			Player:Notify("You must be aiming at a door to use this item.");
		return false; end
		
		if (w.Entity:GetPos():Distance(Player:GetPos()) > 200) then
			Player:Notify("You must be aiming at a door to use this item.");
		return false; end
		
		local GroupTable = w.Entity:GetPropertyTable();
		
		if (!GroupTable) then
			Player:Notify("You must be aiming at a door you own to use this item.");
		return false; end
		
		if (w.Entity:GetDoorOwner() != Player) then
			Player:Notify("You must be aiming at a door you own to use this item.");
		return false; end
		
		if (GAMEMODE.HouseAlarms[GroupTable.ID]) then
			Player:Notify("This property already has a house alarm.");
		return false; end
		
		Player:Notify("House alarm installed.");
		
		GAMEMODE.HouseAlarms[GroupTable.ID] = true;
		
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