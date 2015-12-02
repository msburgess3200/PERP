



local ITEM 					= {};

ITEM.ID 					= 123;
ITEM.Reference 				= "furniture_television";

ITEM.Name 					= "Television";
ITEM.Description			= "A TV that plays what the theater is playing.";

ITEM.Weight 				= 5;
ITEM.Cost					= 10000;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props/cs_office/TV_plasma.mdl";
ITEM.ModelCamPos 				= Vector(20, 0, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 8);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props/cs_office/TV_plasma.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local trace = {};
		trace.start = Player:GetShootPos();
		trace.endpos = Player:GetShootPos() + Player:GetAimVector() * 50;
		trace.filter = Player;
		local tRes = util.TraceLine(trace);
		
		local newItem = ents.Create("gmod_playx_repeater");
		newItem:SetModel("models/props/cs_office/TV_plasma.mdl")
		newItem:SetPos(tRes.HitPos);
		newItem:Spawn();
		newItem.ItemSpawner = oldOwner;
		
		newItem.pickupTable = 123;
		newItem.pickupPlayer = Player;
		return true;
	end
	
	function ITEM.OnDrop ( Player )
		return true;
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

