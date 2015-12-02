

local function catchUnderglowPress ( Player )
	local vehicleTable = Player:GetVehicle().vehicleTable;
	local owner = Player:GetVehicle().owner;
	
	if (!owner.Vehicles[vehicleTable.ID][4] || owner.Vehicles[vehicleTable.ID][4] == 0) then return; end
	if (!Player:InVehicle()) then return; end
	if (Player:GetVehicle().IsPassengerSeat) then return; end
	if (!Player:GetVehicle().vehicleTable.UnderglowPositions) then return; end
	
	Player.lastUnderglowSwap = Player.lastUnderglowSwap or CurTime();
	if (Player.lastUnderglowSwap > CurTime()) then return; end
	Player.lastUnderglowSwap = CurTime() + .25;
		
	if (!Player:GetVehicle().Underglow) then
		Player:GetVehicle().Underglow = {};
		
		for k, v in pairs(Player:GetVehicle().vehicleTable.UnderglowPositions) do						
			local underglowLight = ents.Create("light_dynamic")
				    underglowLight:SetParent(Player:GetVehicle());
					underglowLight:SetLocalPos(v[1]);
					
					local realColor = HEADLIGHT_COLORS[Player:GetVehicle().headLightColor][1];
					
					underglowLight:SetKeyValue( "_light", realColor.r .. " " .. realColor.g .. " " .. realColor.b .. " " .. realColor.a)
					underglowLight:SetKeyValue( "style", 0 )
					underglowLight:SetKeyValue( "distance", 500 )
					underglowLight:SetKeyValue( "brightness", 6 )
					underglowLight:SetKeyValue( "_cone", 90 )
					underglowLight:SetKeyValue( "_inner_cone", 45 )
					underglowLight:SetKeyValue( "angles", "90 0 0" )
					underglowLight:SetKeyValue( "spotlight_radius", 110 )
					
					underglowLight:Spawn();
			
			table.insert(Player:GetVehicle().Underglow, underglowLight);
		end
	end
	
	if (Player:GetVehicle().UnderglowOn) then
		for k, v in pairs(Player:GetVehicle().Underglow) do
			v:Fire("TurnOff", "", 0);
			v.StatusOn = false;
		end
		
		Player:GetVehicle().UnderglowOn = nil;
	else
		for k, v in pairs(Player:GetVehicle().Underglow) do
			v:Fire("TurnOn", "", 0);
			v.StatusOn = true;
		end
		
		Player:GetVehicle().UnderglowOn = true;
	end
end
concommand.Add("perp_v_ug", catchUnderglowPress);

local function catchFlashlightPress ( Player )
	if (!Player:InVehicle()) then return; end
	if (Player:GetVehicle().IsPassengerSeat) then return; end
	if (!Player:GetVehicle().vehicleTable.HeadlightPositions) then return; end
	
	Player.lastHeadlightSwap = Player.lastHeadlightSwap or CurTime();
	if (Player.lastHeadlightSwap > CurTime()) then return; end
	Player.lastHeadlightSwap = CurTime() + .25;
		
	if (!Player:GetVehicle().Headlights) then
		Player:GetVehicle().Headlights = {};
		
		for k, v in pairs(Player:GetVehicle().vehicleTable.HeadlightPositions) do						
			local flashlight = ents.Create("env_projectedtexture");
				flashlight:SetParent(Player:GetVehicle());
					
				flashlight:SetLocalPos(v[1] + Vector(5, 0, 0));
				flashlight:SetLocalAngles(v[2] + Angle(0, 90, 0));
					
				flashlight:SetKeyValue("enableshadows", 0);
				flashlight:SetKeyValue("farz", 1028);
				flashlight:SetKeyValue("nearz", 64);
					
				flashlight:SetKeyValue("lightfov", 60);
				
				local realColor = HEADLIGHT_COLORS[Player:GetVehicle().headLightColor][1];
				flashlight:SetKeyValue("lightcolor", realColor.r .. " " .. realColor.g .. " " .. realColor.b .. " " .. realColor.a);
			flashlight:Spawn();
				
			flashlight:Input("SpotlightTexture", NULL, NULL, "effects/flashlight001");
			
			table.insert(Player:GetVehicle().Headlights, flashlight);
		end
	end
	
	if (Player:GetVehicle().HeadlightsOn) then
		for k, v in pairs(Player:GetVehicle().Headlights) do
			v:Fire("TurnOff", "", 0);
			v.StatusOn = false;
		end
		
		Player:GetVehicle().HeadlightsOn = nil;
		Player:GetVehicle():SetNetworkedBool("hl", false);
	else
		for k, v in pairs(Player:GetVehicle().Headlights) do
			v:Fire("TurnOn", "", 0);
			v.StatusOn = true;
		end
		
		Player:GetVehicle().HeadlightsOn = true;
		
		Player:GetVehicle():SetNetworkedBool("hl", true);
	end
end
concommand.Add("perp_v_f", catchFlashlightPress);

local function flashHeadlights ( )
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v.vehicleTable.ID == 'z' && v:GetNetworkedBool("slights", false)) then
			local shouldBeOn_1, shouldBeOn_2;
			
			local shouldBeOn_C = math.sin(CurTime() * 5);
			if (shouldBeOn_C > .4 && shouldBeOn_C < .85) then
				shouldBeOn_1 = true;
			elseif (shouldBeOn_C > -0.85 && shouldBeOn_C < -0.4) then
				shouldBeOn_2 = true;
			end
				
			local tV = 3;
			if (shouldBeOn_1) then tV = 1; end
			if (shouldBeOn_2) then tV = 2; end
				
			if (v:GetNetworkedInt("fl", 0) != tV) then
				v:SetNetworkedInt("fl", tV);
			end
			
			if (v.Headlights && v:GetNetworkedBool("hl", false)) then
				if (shouldBeOn_1 && !v.Headlights[1].Status) then
					v.Headlights[1].Status = true;
					v.Headlights[1]:Fire("TurnOn", "", 0);
				elseif (!shouldBeOn_1 && v.Headlights[1].Status) then
					v.Headlights[1].Status = false;
					v.Headlights[1]:Fire("TurnOff", "", 0);
				end
					
				if (shouldBeOn_2 && !v.Headlights[2].Status) then
					v.Headlights[2].Status = true;
					v.Headlights[2]:Fire("TurnOn", "", 0);
				elseif (!shouldBeOn_2 && v.Headlights[2].Status) then
					v.Headlights[2].Status = false;
					v.Headlights[2]:Fire("TurnOff", "", 0);
				end
			end
		elseif (v:GetNetworkedInt("fl", 0) != 0) then
			v:SetNetworkedInt("fl", 0);
			
			if (v.Headlights) then
				local shouldBeOn_1 = v:GetNetworkedBool("hl", false);
				local shouldBeOn_2 = v:GetNetworkedBool("hl", false);
				
				if (shouldBeOn_1 && !v.Headlights[1].Status) then
					v.Headlights[1].Status = true;
					v.Headlights[1]:Fire("TurnOn", "", 0);
				elseif (!shouldBeOn_1 && v.Headlights[1].Status) then
					v.Headlights[1].Status = false;
					v.Headlights[1]:Fire("TurnOff", "", 0);
				end
						
				if (shouldBeOn_2 && !v.Headlights[2].Status) then
					v.Headlights[2].Status = true;
					v.Headlights[2]:Fire("TurnOn", "", 0);
				elseif (!shouldBeOn_2 && v.Headlights[2].Status) then
					v.Headlights[2].Status = false;
					v.Headlights[2]:Fire("TurnOff", "", 0);
				end
			end
		end
	end
end
hook.Add("Think", "flashHeadlights", flashHeadlights);

local function catchHornHonk ( Player )
	if (Player.nextHornHonk && Player.nextHornHonk > CurTime()) then return; end
	if (!Player:InVehicle()) then return; end
	
	local vehicleTable = Player:GetVehicle().vehicleTable;
	
	if (!vehicleTable) then return; end
	if (!vehicleTable.HornNoise) then return; end
	
	horn_noise = vehicleTable.HornNoise;
	
	if (horn_noise == NORMAL_HORNS) then
		local randHorn = math.random(1, 1000);
		
		if (randHorn < 499) then
			horn_noise = "PERP2.5/car_horn.wav";
		elseif (randHorn < 998) then
			horn_noise = "PERP2.5/car_horn_long.wav";
		else
			horn_noise = "PERP2.5/car_horn_dixie.mp3";
		end
	end
	
	Player:GetVehicle():EmitSound(horn_noise);
	Player.nextHornHonk = CurTime() + SoundDuration(horn_noise) + 1;
	
	if (vehicleTable.ID == "y") then Player.nextHornHonk = Player.nextHornHonk - 1.05; end
end
concommand.Add("perp_v_h", catchHornHonk);

local function manageSpinouts ( )
	for k, v in pairs(player.GetAll()) do
		if (v:InVehicle() && v:GetVehicle().vehicleTable && v:GetVehicle().vehicleTable.RevvingSound && 
				(!v.nextSpinout || v.nextSpinout < CurTime()) && v:KeyDown(IN_FORWARD) && v:KeyDown(IN_JUMP)) then
				
			local speed = v:GetVehicle():GetVelocity():Length();
			
			if (speed < 50) then
				v.nextSpinout = CurTime() + SoundDuration(v:GetVehicle().vehicleTable.RevvingSound);
				
				local recipient = RecipientFilter();
				recipient:AddPVS(v:GetPos());
				recipient:AddPlayer(v);
				
				umsg.Start("perp2_spinout", recipient);
					umsg.Entity(v:GetVehicle());
				umsg.End();
			end
		end		
	end
end
hook.Add("Think", "manageSpinouts", manageSpinouts);

local function catchHyd ( Player )
	if (Player.nextHyd && Player.nextHyd > CurTime()) then return; end
	if (!Player:InVehicle()) then return; end
	
	local vehicleTable = Player:GetVehicle().vehicleTable;
	local owner = Player:GetVehicle().owner;
	
	if (!vehicleTable) then return; end

	if (vehicleTable.SirenNoise) then
		Player:GetVehicle():SetNetworkedBool("slights", !Player:GetVehicle():GetNetworkedBool("slights", false));
		
		return;
	end
	
	if (!owner.Vehicles[vehicleTable.ID]) then return; end
	if (!owner.Vehicles[vehicleTable.ID][3] || owner.Vehicles[vehicleTable.ID][3] == 0) then return; end
		
	Player:GetVehicle():GetPhysicsObject():ApplyForceCenter(Player:GetVehicle():GetUp() * Player:GetVehicle():GetPhysicsObject():GetMass() * 250);
	
	Player.nextHyd = CurTime() + .5;
end
concommand.Add("perp_v_y", catchHyd);

function GM.ToggleSiren ( Player )
	if (!Player:GetVehicle()) then return; end
	
	Player:GetVehicle():SetNetworkedBool("siren", !Player:GetVehicle():GetNetworkedBool("siren", false));
end

local function manageLoudSirens ( )
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (v.vehicleTable && v:GetDriver() && IsValid(v:GetDriver()) && v:GetDriver():IsPlayer() && v.vehicleTable.SirenNoise_Alt) then
			if (v:GetDriver():KeyDown(IN_WALK) && !v:GetNetworkedBool("siren_loud", false)) then
				v:SetNetworkedBool("siren_loud", true);
			elseif (!v:GetDriver():KeyDown(IN_WALK) && v:GetNetworkedBool("siren_loud", false)) then
				v:SetNetworkedBool("siren_loud", false);
			end
		end
	end
end
hook.Add("Think", "manageLoudSirens", manageLoudSirens);