


local ITEM 					= {};

ITEM.ID 					= 52;
ITEM.Reference 				= "furniture_lamp";

ITEM.Name 					= "Lamp";
ITEM.Description			= "Stands in the corner and looks good.\n\nLeft click to spawn as prop.\nUse + ALT to pickup after dropped as prop.";

ITEM.Weight 				= 10;
ITEM.Cost					= 200;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/env/lighting/lamp_trumpet/lamp_trumpet_tall.mdl";
ITEM.ModelCamPos 				= Vector(-68, 56, 30);
ITEM.ModelLookAt 				= Vector(0, 0, 29);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/env/lighting/lamp_trumpet/lamp_trumpet_tall.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM, "prop_lamp");
		
		if (!prop || !IsValid(prop)) then return false; end
				
		prop.lightCurOn = false;

		prop.flashlight = ents.Create("env_projectedtexture");
			prop.flashlight:SetParent(prop);
					
			prop.flashlight:SetLocalPos(Vector(0, 0, 80));
			prop.flashlight:SetLocalAngles(Angle(90, 0, 0));
					
			prop.flashlight:SetKeyValue("enableshadows", 0);
			prop.flashlight:SetKeyValue("farz", 512);
			prop.flashlight:SetKeyValue("nearz", 64);
					
			prop.flashlight:SetKeyValue("lightfov", 100);
				
			local realColor = Color(255, 255, 200, 500);
			prop.flashlight:SetKeyValue("lightcolor", realColor.r .. " " .. realColor.g .. " " .. realColor.b .. " " .. realColor.a);
		prop.flashlight:Spawn();
				
		prop.flashlight:Input("SpotlightTexture", NULL, NULL, "effects/flashlight001");
		prop.flashlight:Fire("TurnOff", "", 0);
				
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