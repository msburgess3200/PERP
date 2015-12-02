

local ITEM 					= {};

ITEM.ID 					= 63;
ITEM.Reference 				= "item_balloon";

ITEM.Name 					= "Birthday Balloon";
ITEM.Description			= "It's someone's birthday!";

ITEM.Weight 				= 5;
ITEM.Cost					= 500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/dav0r/balloon/balloon.mdl";
ITEM.ModelCamPos 				= Vector(30, 0, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/dav0r/balloon/balloon.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	local balloonColors = {Color(0, 0, 0), Color(125, 125, 125), Color(125, 0, 0), Color(0, 125, 0), Color(0, 0, 125), Color(125, 0, 125), Color(125, 125, 0), Color(0, 125, 125), Color(255, 255, 255), Color(255, 0, 0), Color(0, 255, 0), Color(0, 0, 255), Color(255, 255, 0), Color(255, 0, 255), Color(0, 255, 255)}

	function ITEM.OnUse ( Player )		
		local Trace = Player:GetEyeTrace();
		
		if !Player:IsOwner() then
			if Trace.Hit and Trace.Entity and Trace.Entity:IsValid() then
				Player:Notify("You cannot attach a balloon to that.");
				return false;
			elseif Trace.HitPos:Distance(Player:GetPos()) > 300 then
				Player:Notify("That's too far away to attach a balloon to.");
				return false;
			end
		end
	
		local balloon = ents.Create( "prop_balloon" )
		
		if (!balloon:IsValid()) then return false; end
			
		balloon:Spawn()

		local col = table.Random(balloonColors)
		local skin = "models/balloon/balloon";
		local force = 500;
		local length = math.random(50, 75);
		
		balloon:SetRenderMode( RENDERMODE_TRANSALPHA )
		balloon:SetColor(Color(col.r, col.g , col.b, 255 ))
		balloon:SetForce(force)

		balloon:SetMaterial(skin)
		
		balloon.Player = Player
		balloon.r = r
		balloon.g = g
		balloon.b = b
		balloon.skin = skin
		balloon.force = force
		balloon.ItemSpawner = Player;
		
		local trace = util.TraceLine({start = Player:GetShootPos(), endpos = Player:GetShootPos() + Player:GetAimVector() * 50000, filter = Player});
		local Pos = trace.HitPos + trace.HitNormal * 10
		
		balloon:SetPos(Pos);
		
		local attachpoint = Pos + Vector( 0, 0, -10 )
			
		local LPos1 = balloon:WorldToLocal(attachpoint);
		local LPos2 = trace.Entity:WorldToLocal(trace.HitPos);
		
		if (trace.Entity:IsValid()) then
			
			local phys = trace.Entity:GetPhysicsObjectNum( trace.PhysicsBone )
			if (phys:IsValid()) then
				LPos2 = phys:WorldToLocal( trace.HitPos )
			end
		
		end
		
		local constraint, rope = constraint.Rope( balloon, trace.Entity, 
												0, trace.PhysicsBone, 
												LPos1, LPos2, 
												0,length,
												0, 
												1.5, 
												'cable/rope', 
												false )
		
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