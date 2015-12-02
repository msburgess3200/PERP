

local ITEM 					= {};

ITEM.ID 					= 121;
ITEM.Reference 				= "item_explosives";

ITEM.Name = 'Explosives';
ITEM.Description = "Blow up shit or break open doors with this.";

ITEM.Weight = 5;
ITEM.Cost = 2000;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/Items/car_battery01.mdl";
ITEM.ModelCamPos = Vector(0, 0, 30);
ITEM.ModelLookAt = Vector(0, 0, 0);
ITEM.ModelFOV = 70;
ITEM.WorldModel 			= "models/Items/car_battery01.mdl";

ITEM.RestrictedSelling	 	= true; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		local vStart = Player:GetShootPos()
		local vForward = Player:GetAimVector()
		local trace = {}
		trace.start = vStart
		trace.endpos = vStart + (vForward * 100)
		trace.filter = Player
		
		local tr = util.TraceLine(trace)
		
		local NewProp = ents.Create('item_doorbuster')
		NewProp:SetPos(tr.HitPos + Vector(0, 0, 32))
		NewProp:GetTable().ItemSpawner = Player
		NewProp:Spawn()
		
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