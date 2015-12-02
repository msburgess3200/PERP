function GM.MakeCarDisplay ( Pos, Ang, Mod )
	local Veh = ents.Create('car_display');
	Veh:SetPos(Pos);
	Veh:SetAngles(Ang);
	Veh:SetModel(Mod);
	Veh:Spawn();
	
	return Veh;
end

function GM.MakeCarLight (LightPos, LightColor1)
			flashlight2 = ents.Create("env_projectedtexture");
					
			flashlight2:SetPos(LightPos);
			flashlight2:SetAngles(Angle(90, -90, 0));
					
			flashlight2:SetKeyValue("enableshadows", 0);
			flashlight2:SetKeyValue("farz", 2000);
			flashlight2:SetKeyValue("nearz", 16);
					
			flashlight2:SetKeyValue("lightfov", 50);
				
			//local realColor = Color(LightColor);
			flashlight2:SetKeyValue("lightcolor", LightColor1.r .. " " .. LightColor1.g .. " " .. LightColor1.b .. " " .. LightColor1.a);
			flashlight2:Spawn();
				
			flashlight2:Input("SpotlightTexture", NULL, NULL, "effects/flashlight001");
			flashlight2:Fire("TurnOn", "", 0);		
			flashlight2:Spawn();
			constraint.Weld(flashlight2,game.GetWorld(),0,0,0,true)
end

