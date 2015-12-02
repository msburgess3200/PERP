


local ITEM 					= {};

ITEM.ID 					= 57;
ITEM.Reference 				= "drug_cig";

ITEM.Name 					= "Shibboro Cigarettes";
ITEM.Description			= "These make you cool.";

ITEM.Weight 				= 5;
ITEM.Cost					= 50;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/boxopencigshib.mdl";
ITEM.ModelCamPos 				= Vector(6, 0, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/boxopencigshib.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )	
		timer.Simple(2.35, function ( )
							local Effect = EffectData();
							Effect:SetOrigin(Player:GetShootPos() + Player:GetAimVector() * 5);
							util.Effect('smoke_cig', Effect);
							
							Player:TakeDamage(5, Player, Player);
						end
					);
	
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
		surface.PlaySound('PERP2.5/smoke.mp3');
		
		return true;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);