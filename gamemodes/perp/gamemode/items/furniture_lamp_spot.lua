


local ITEM 					= {};

ITEM.ID 					= 61;
ITEM.Reference 				= "furniture_lamp_spot";

ITEM.Name 					= "Spotlight";
ITEM.Description			= "Excelent for lighting things up during the night.\n\nLeft click to spawn as prop.\nUse + ALT to pickup after dropped as prop.";

ITEM.Weight 				= 10;
ITEM.Cost					= 500;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_wasteland/light_spotlight01_lamp.mdl";
ITEM.ModelCamPos 			= Vector(14, -25, 0);
ITEM.ModelLookAt 			= Vector(0, 0, 5);
ITEM.ModelFOV 				= 70;
ITEM.WorldModel 			= "models/props_wasteland/light_spotlight01_lamp.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= false; // If this isn't true, the server will tell the client when something happens to us.

if SERVER then

	function ITEM.OnUse ( Player )
		local prop = Player:SpawnProp(ITEM, "prop_lamp_spot");
		prop.Owner = Player;
		if (!prop || !IsValid(prop)) then return false; end
				
		prop.lightCurOn = false;

		prop.flashlight = ents.Create("env_projectedtexture");
			prop.flashlight:SetParent(prop);
					
			prop.flashlight:SetLocalPos(Vector(9, 0, 4));
			prop.flashlight:SetLocalAngles(Angle(0, 0, 0));
					
			prop.flashlight:SetKeyValue("enableshadows", 0);
			prop.flashlight:SetKeyValue("farz", 512);
			prop.flashlight:SetKeyValue("nearz", 16);
					
			prop.flashlight:SetKeyValue("lightfov", 50);
				
			local realColor = Color(255, 255, 200, 1000);
			prop.flashlight:SetKeyValue("lightcolor", realColor.r .. " " .. realColor.g .. " " .. realColor.b .. " " .. realColor.a);
		prop.flashlight:Spawn();
				
		prop.flashlight:Input("SpotlightTexture", NULL, NULL, "effects/flashlight001");
		prop.flashlight:Fire("TurnOff", "", 0);
		
		prop:SetSkin(1);
				
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