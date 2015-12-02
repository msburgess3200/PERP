


local PANEL = {};


surface.CreateFont("PlayerNameFont", {
	font="Tahoma",
	size=20,
	weight=1000,
	antialias=true
})
surface.CreateFont("PEChatFont", {
	font="Tahoma",
	size=14,
	weight=1000,
	antialias=true
})


function PANEL:Init ( )
	self:SetAlpha(255);
	self.LastDisplayCash = 0;
end

function PANEL:PerformLayout ( )
	self:SetPos(0, 0);
	self:SetSize(ScrW(), ScrH());
end

local doorAssosiations = {};

local newbg = surface.GetTextureID("PERP2/hud/v1/hudbg");

local TypingText = surface.GetTextureID("PERP2/hud/typing");
local MicText = surface.GetTextureID("PERP2/hud/mic");
local currentlyTalkingTexture = surface.GetTextureID("voice/icntlk_pl");
local currentlyRadioTexture = surface.GetTextureID("PERP2/radio");
//
local Speed = surface.GetTextureID("perp2/hud/speed_perp");
local FuelN = surface.GetTextureID("perp2/hud/fuelpointer_perp");
local SpeedP = surface.GetTextureID("perp2/hud/speedpointer_perp");

local FuelCanCheck  = nil;

function PANEL:Paint ( )
	if LocalPlayer().Customizing then return; end
	// part of HUD borrowed from Scars
	if LocalPlayer():InVehicle() then
	local Tbl = LocalPlayer():GetVehicle().vehicleTable;
	local Width = ScrW()
	local Height = ScrH()
	local isWideScreen = true
	
	if (Width / Height) <= (4 / 3) then
		isWideScreen = false
	end
	
	if Tbl then
	if LocalPlayer():InVehicle() && Tbl.DF then
		CurFuel = LocalPlayer():GetVehicle():GetNetworkedInt("fuel");
	else
		CurFuel = 10000; //Setting this to full to appear that way.
	end
	local vel = LocalPlayer():GetVehicle():GetVelocity():Length() //math.Round(10 * 17.6)

			if isWideScreen then
			xPos = Width * 0.4114285714
			yPos = Height * 0.7142857143
			xSize = Width * 0.1785714286
			ySize = Height * 0.2857142857
		else
			xPos = Width * 0.4114285714
			yPos = Height * 0.7823142857
			xSize = Width * 0.1785714286
			ySize = Height * 0.2176870749
		end	
				
		surface.SetTexture( Speed )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( xPos, yPos, xSize, ySize )	
		
		local rotation = vel * -0.184
		--speed arrow
		if isWideScreen then
			xPos = Width * 0.5007142857
			yPos = Height * 0.8571428571
			xSize = Width * 0.1785714286
			ySize = Height * 0.2857142857
		else
			xPos = Width * 0.5007142857
			--yPos = Height * 0.925170068
			yPos = Height * 0.8911564626
			xSize = Width * 0.1785714286
			ySize = Height * 0.2176870749		
		end		
		
		surface.SetTexture( SpeedP )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRectRotated( xPos, yPos, xSize, ySize, rotation )

		--Fuel arrow
		if isWideScreen then
			xPos = Width * 0.5007142857
			yPos = Height * 0.939047619
			xSize = Width * 0.0595238095
			ySize = Height * 0.0952380952
		else
			xPos = Width * 0.5007142857
			--yPos = Height * 0.9616190476			
			yPos = Height * 0.9503854875
			xSize = Width * 0.0595238095
			ySize = Height * 0.0725714286	
		end
		

		rotation = CurFuel * -0.0114
		surface.SetTexture( FuelN )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRectRotated( xPos , yPos, xSize, ySize, rotation )
		
	end;
end

	
	// Typing... / names and stuff
	local FadePoint = ChatRadius_Local;
	local RealDist = ChatRadius_Local * 1.5;
	
	if (LocalPlayer():InVehicle()) then
		RealDist = RealDist * 2
	end
	
	surface.SetFont("PlayerNameFont");
	local w, h = surface.GetTextSize("Player Name");
	
	local ourPos = LocalPlayer():GetPos();
	if (PERP_SpectatingEntity) then ourPos = PERP_SpectatingEntity:GetPos() end
	
	local shootPos = LocalPlayer():GetShootPos();
	if (PERP_SpectatingEntity) then shootPos = PERP_SpectatingEntity:GetPos() end
	
	for k, v in pairs(player.GetAll()) do
		local col = v:GetColor()
		local r, g, b, a = col.r, col.g, col.b, col.a
		if (v != LocalPlayer() && v:Alive() && a > 0) then
			local dist = v:GetPos():Distance(ourPos);
			
			if (dist <= RealDist) then
				local trace = {}
				trace.start = shootPos;
				trace.endpos = v:GetShootPos();
				trace.filter = {LocalPlayer(), v};
				
				if (v:InVehicle()) then table.insert(trace.filter, v:GetVehicle()); end
				if (LocalPlayer():InVehicle()) then table.insert(trace.filter, LocalPlayer():GetVehicle()); end
				
				if PERP_SpectatingEntity then table.insert(trace.filter, PERP_SpectatingEntity); end

				local tr = util.TraceLine( trace ) 
				
				if (!tr.Hit) then
					local Alpha = 255;
					
					if (dist >= FadePoint) then
						local moreDist = RealDist - dist;
						local percOff = moreDist / (RealDist - FadePoint);
						
						Alpha = 255 * percOff;
					end
					
					local AttachmentPoint = v:GetAttachment(v:LookupAttachment('eyes'));
					if !AttachmentPoint then AttachmentPoint = v:GetAttachment(v:LookupAttachment('head')); end
					
					if (AttachmentPoint) then 
						local realPos = Vector(v:GetPos().x, v:GetPos().y, AttachmentPoint.Pos.z + 10);
						local screenPos = realPos:ToScreen();
						
						if (v:GetUMsgString("typing", 0) == 1) then						
							local pointDown = (realPos + Vector(0, 0, math.sin(CurTime() * 2) * 3)):ToScreen()
							local pointUp = (realPos + Vector(0, 0, 20 + math.sin(CurTime() * 2) * 3)):ToScreen() 
							
							local Size = math.abs(pointDown.y - pointUp.y);
							
							surface.SetDrawColor(255, 255, 255, Alpha);
							surface.SetTexture(TypingText);
							surface.DrawTexturedRect(pointUp.x - Size * .5, pointUp.y, Size, Size);
						elseif GAMEMODE.Options_ShowNames:GetBool() then
							local color = team.GetColor(v:Team());
							local nameText;
							
							if v:GetRPName() == "John Doe" then
								nameText = "Please reconnect.";
							else
								nameText = v:GetRPName();
							end
							
							draw.SimpleTextOutlined(nameText, "PlayerNameFont", screenPos.x, screenPos.y - h, Color(255, 255, 255, Alpha), 1, 1, 1, Color(color.r, color.g, color.b, Alpha));
							
							if (v:InVehicle() && v:GetVehicle():GetClass() == "prop_vehicle_jeep") then
								if (LocalPlayer():Team() == TEAM_POLICE) then
									local Speed = tostring(math.Round(v:GetVehicle():GetVelocity():Length() / 17.6));
									draw.SimpleTextOutlined(SpeedText(Speed), "PlayerNameFont", screenPos.x, screenPos.y - h * 2, Color(255, 255, 255, Alpha), 1, 1, 1, Color(0, 0, 255, Alpha));
								end

							else
								local orgName = v:GetOrganizationName();
								if (orgName && orgName != '' and orgName != 'New Organization') then
									draw.SimpleTextOutlined(orgName, "PlayerNameFont", screenPos.x, screenPos.y - h * 2, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
								end
							end
							
							if (v:GetNetworkedBool("warrent", false)) then
								draw.SimpleTextOutlined("Arrest Warrent", "PlayerNameFont", screenPos.x, screenPos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(color.r, color.g, color.b, Alpha));
							end
						end
					end
				end
			end
		end
	end
	
	// Fuel Can Shi
	
	
	for k, v in pairs(ents.FindInSphere(LocalPlayer():GetPos(), 300)) do
					if (v:IsValid() && (v:GetClass() == "ent_fuelcan")) then
					local Pos = v:LocalToWorld(v:OBBCenter()):ToScreen();
					local Name;
					if v.CurrentCar then
					 Name =	tostring(v.CurrentCar:GetNetworkedEntity("owner"):GetRPName()).. "'s Car."
					else
					 Name = "None"
					end
					
					draw.SimpleTextOutlined('Ready To Fuel:', "perp2_TextHUDSmall", Pos.x, Pos.y-50 , Color(255,255,255, Alpha), 1, 1, 1, Color(0,100,0,Alpha));
					draw.SimpleTextOutlined('Ready to Fuel:', "perp2_TextHUDSmall", Pos.x, Pos.y-50, Color(255,255,255, Alpha), 1, 1, 1, Color(0,100,0,Alpha));
					draw.SimpleTextOutlined(Name, "perp2_TextHUDSmall", Pos.x, Pos.y-38, Color(255,255,255, Alpha), 1, 1, 1, Color(0,100,0,Alpha));
					draw.SimpleTextOutlined(Name, "perp2_TextHUDSmall", Pos.x, Pos.y-38, Color(255,255,255, Alpha), 1, 1, 1, Color(0,100,0,Alpha));					
					end
	end
			
			
	
	// Door Stuff / Vehicles
	local FadePoint = FadePoint * .5;
	local RealDist = RealDist * .5;
	local WeedColor = Color(255, 0, 0, 255)
	local WeedColorO = Color(255, 255, 255, 255)
	
	local eyeTrace = LocalPlayer():GetEyeTrace();
	
	if eyeTrace and eyeTrace.Entity:IsValid() and eyeTrace.Entity:GetPos():Distance( LocalPlayer():GetPos() ) <= 200 and ( eyeTrace.Entity:GetClass() == "ent_coca" or eyeTrace.Entity:GetClass() == "ent_pot" ) then
		local Pos = eyeTrace.Entity:LocalToWorld(eyeTrace.Entity:OBBCenter()):ToScreen();
		
		local timeleft = 1
		local name = "N/A"
		if eyeTrace.Entity:GetClass() == "ent_coca" then
			timeleft = math.max( 0, eyeTrace.Entity.SpawnTime + POT_GROW_TIME - CurTime() )
			name = "Growing Cocaine";
		elseif eyeTrace.Entity:GetClass() == "ent_pot" then
			timeleft = math.max( 0, eyeTrace.Entity.SpawnTime + POT_GROW_TIME - CurTime() )
			name = "Growing Weed";
		end

		if timeleft ~= 0 then
			draw.SimpleTextOutlined("Ready in: "  .. string.FormattedTime( timeleft, "%02i:%02i"), "perp2_RealtorFontNew", Pos.x, Pos.y, WeedColor, 1, 1, 1, WeedColorO);
		else
			draw.SimpleTextOutlined("Ready to pick", "perp2_RealtorFontNew", Pos.x, Pos.y, WeedColor, 1, 1, 1, WeedColorO);
		end
	end
	
	if (!LocalPlayer():InVehicle() && GAMEMODE.Options_ShowNames:GetBool() && eyeTrace.Entity && IsValid(eyeTrace.Entity) && (eyeTrace.Entity:IsDoor() || eyeTrace.Entity:IsVehicle())) then
		local dist = eyeTrace.Entity:GetPos():Distance(ourPos);
		
		if (dist <= RealDist) then
			local Alpha = 255;
					
			if (dist >= FadePoint) then
				local moreDist = RealDist - dist;
				local percOff = moreDist / (RealDist - FadePoint);
						
				Alpha = 255 * percOff;
			end
			
			
			if (eyeTrace.Entity:IsDoor()) then
				local Pos = eyeTrace.Entity:LocalToWorld(eyeTrace.Entity:OBBCenter()):ToScreen();
				local doorTable = eyeTrace.Entity:GetPropertyTable();

				if (doorTable) then			
					local doorOwner = eyeTrace.Entity:GetDoorOwner();
					
					if (!doorOwner || !IsValid(doorOwner)) then
						draw.SimpleTextOutlined('For Sale', "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(0, 100, 0, Alpha));
						draw.SimpleTextOutlined(doorTable.Name, "perp2_RealtorFontNew", Pos.x, Pos.y + 25, Color(255, 255, 255, Alpha), 1, 1, 1, Color(0, 100, 0, Alpha));
					else
						draw.SimpleTextOutlined('Owned By ' .. doorOwner:GetRPName(), "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
						draw.SimpleTextOutlined(doorTable.Name, "perp2_RealtorFontNew", Pos.x, Pos.y + 25, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					end
				elseif (GAMEMODE.Options_ShowUnownableDoors:GetBool()) then
					if (eyeTrace.Entity:IsPoliceDoor()) then
						draw.SimpleTextOutlined('EvoCity Municipal Government', "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsCivilDoor()) then
						draw.SimpleTextOutlined('EvoCity Civil Services', "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsRealtorOfficeDoor()) then
						draw.SimpleTextOutlined("Realtor Office", "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsBPShopDoor()) then
						draw.SimpleTextOutlined("BP Shop", "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsFCStoreDoor()) then
						draw.SimpleTextOutlined("Facial And Clothes Store", "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsTidesHotelDoor()) then
						draw.SimpleTextOutlined("Tides Hotel", "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsShopsDoor()) then
						draw.SimpleTextOutlined("Shops", "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsCarDealerDoor()) then
						draw.SimpleTextOutlined("Car Dealership", "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsHospitalDoor()) then
						draw.SimpleTextOutlined("Mercy Hospital", "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsGovermentCenterDoor()) then
						draw.SimpleTextOutlined("Goverment Center", "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsJailsDoor()) then
						draw.SimpleTextOutlined("EvoCity Municipal Government - Jails", "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsApartmentsDoor()) then
						draw.SimpleTextOutlined("Apartments", "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					elseif (eyeTrace.Entity:IsRoadCrewDoor()) then
						draw.SimpleTextOutlined("The Road Crew", "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					else
						draw.SimpleTextOutlined('Unownable', "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(255, 0, 0, Alpha));
					end
				end
			elseif (eyeTrace.Entity:GetTrueOwner() && IsValid(eyeTrace.Entity:GetTrueOwner()) && eyeTrace.Entity:GetTrueOwner().GetRPName) then
				local Pos = eyeTrace.Entity:LocalToWorld(Vector(eyeTrace.Entity:OBBCenter().x, eyeTrace.Entity:OBBCenter().y, eyeTrace.Entity:OBBMaxs().z + 15)):ToScreen();
				draw.SimpleTextOutlined('Owned By ' .. eyeTrace.Entity:GetTrueOwner():GetRPName(), "perp2_RealtorFontNew", Pos.x, Pos.y, Color(255, 255, 255, Alpha), 1, 1, 1, Color(0, 0, 255, Alpha));
			end
		end
	end
	
	// Arrested
	if (GAMEMODE.UnarrestTime) then
		if (GAMEMODE.UnarrestTime < CurTime()) then GAMEMODE.UnarrestTime = nil; else
			local timeLeft = math.ceil(GAMEMODE.UnarrestTime - CurTime());
			
			draw.SimpleText('You are arrested for another ' .. timeLeft .. ' seconds.', 'SelectSexFont', ScrW() * .5, ScrH() * .25, Color(100+ 100 * math.abs(math.sin(CurTime())), 0, 0, 255), 1, 1);
			draw.SimpleText('You are arrested for another ' .. timeLeft .. ' seconds.', 'SelectSexFont', ScrW() * .5, ScrH() * .25, Color(100+ 100 * math.abs(math.sin(CurTime())), 0, 0, 255), 1, 1);
		end
	end
	
	// HUD
	local fader = math.abs(math.sin(CurTime() * 2));
	local border = 0;
	local availableWidth = self:GetWide();
	local widthPer = (availableWidth / 7);
	local heightPer = widthPer * .33;
	
	surface.SetDrawColor(GAMEMODE.GetHUDColorR(), GAMEMODE.GetHUDColorG(), GAMEMODE.GetHUDColorB(), 255);

	surface.SetTexture(newbg);
	surface.DrawTexturedRect(border, self:GetTall() - border - heightPer + 10, widthPer, heightPer);
	
	surface.SetTexture(newbg);
	surface.DrawTexturedRect(widthPer, self:GetTall() - border - heightPer + 10, widthPer, heightPer);
	
	surface.SetTexture(newbg);
	surface.DrawTexturedRect(widthPer * 2, self:GetTall() - border - heightPer + 10, widthPer, heightPer);
	
	surface.SetTexture(newbg);
	surface.DrawTexturedRect(widthPer * 3, self:GetTall() - border - heightPer + 10, widthPer, heightPer);
	
	surface.SetTexture(newbg);
	surface.DrawTexturedRect(widthPer * 4, self:GetTall() - border - heightPer + 10, widthPer, heightPer);
	
	surface.SetTexture(newbg);
	surface.DrawTexturedRect(widthPer * 5, self:GetTall() - border - heightPer + 10, widthPer, heightPer);
	
	surface.SetTexture(newbg);
	surface.DrawTexturedRect(widthPer * 6, self:GetTall() - border - heightPer + 10, widthPer, heightPer);
	
	local healthStatus = "Healthy";
	local health = LocalPlayer():Health();
	
	if (health < 1) then healthStatus = "Unconcious";
	elseif (health < 20) then healthStatus = "Critically Injured";
	elseif (health < 40) then healthStatus = "Majorly Injured";
	elseif (health < 60) then healthStatus = "Badly Injured";
	elseif (health < 80) then healthStatus = "Mildly Injured";
	elseif (health < 90) then healthStatus = "Slightly Injured";
	elseif (health < 100) then healthStatus	= "Slightly Bruised";
	end
	
	local percent = health / 100;
	
	local color = math.Clamp(percent * 255, 0, 255);
	draw.SimpleText("Health", "perp2_TextHUDBig", border + widthPer * .5, self:GetTall() - border - heightPer * .45, Color(0, 0, 0, 255), 1, 1);
	draw.SimpleText(healthStatus, "perp2_TextHUDSmall", border + widthPer * .5, self:GetTall() - border - heightPer * .28, Color(255 - color, color, 0, 200), 1, 1);
	
	
	local armorStatus = "Fully Armored";
	local armor = LocalPlayer():Armor();
	
	if (armor < 1) then armorStatus = "None";
	elseif (armor < 20) then armorStatus = "Slightly Armored";
	elseif (armor < 40) then armorStatus = "Lightly Armored";
	elseif (armor < 60) then armorStatus = "Moderately Armored";
	elseif (armor < 80) then armorStatus = "Heavily Armored";
	elseif (armor < 90) then armorStatus = "Extremely Armored";
	elseif (armor < 100) then armorStatus	= "Fully Armored";
	end
	
	local percent2 = armor / 100;
	local color2 = math.Clamp(percent2 * 255, 0, 255);
	
	draw.SimpleText("Armor", "perp2_TextHUDBig", border + widthPer * 1.5, self:GetTall() - border - heightPer * .45, Color(0, 0, 0, 255), 1, 1);
	draw.SimpleText(armorStatus, "perp2_TextHUDSmall", border + widthPer * 1.5, self:GetTall() - border - heightPer * .28, Color(255 - color2, 0, color2, 200), 1, 1);
	
	local staminaStatus = LocalPlayer().Stamina
	local color3 = staminaStatus * 2;

	if (ClientZombieCheck) then // Zombie (Infinite Stamina)
		draw.SimpleText("Stamina", "perp2_TextHUDBig", border * 2 + widthPer * 2.5, self:GetTall() - border - heightPer * .45, Color(0, 0, 0, 255), 1, 1);
		draw.SimpleText("Infinite", "perp2_TextHUDSmall", border * 2 + widthPer * 2.5, self:GetTall() - border - heightPer * .28, Color(0, 0, 0, 200 * fader), 1, 1);
	else
		draw.SimpleText("Stamina", "perp2_TextHUDBig", border * 2 + widthPer * 2.5, self:GetTall() - border - heightPer * .45, Color(0, 0, 0, 255), 1, 1);
		draw.SimpleText((staminaStatus or 100), "perp2_TextHUDSmall", border * 2 + widthPer * 2.5, self:GetTall() - border - heightPer * .28, Color(255, 255, 255, color3), 1, 1);
	end;
	
	if (LocalPlayer():GetPrivateInt("gpoints", 0) != 0) then
		local wht = math.Clamp((255 * .5) + (math.sin(CurTime() * 3) * 255 * .5), 0, 255);
	
		if (LocalPlayer():GetPrivateInt("gpoints", 0) == 1) then
			draw.SimpleText("Genes", "perp2_TextHUDBig", border * 3 + widthPer * 3.5, self:GetTall() - border - heightPer * .45, Color(0, 0, 0, 255), 1, 1);
			draw.SimpleText(LocalPlayer():GetPrivateInt("gpoints", 0) .. " Gene Available (F1)", "perp2_TextHUDSmall", border * 3 + widthPer * 3.5, self:GetTall() - border - heightPer * .28, Color(255, wht, wht, 200), 1, 1);
		else
			draw.SimpleText("Genes", "perp2_TextHUDBig", border * 3 + widthPer * 3.5, self:GetTall() - border - heightPer * .45, Color(0, 0, 0, 255), 1, 1);
			draw.SimpleText(LocalPlayer():GetPrivateInt("gpoints", 0) .. " Genes Available (F1)", "perp2_TextHUDSmall", border * 3 + widthPer * 3.5, self:GetTall() - border - heightPer * .28, Color(255, wht, wht, 200), 1, 1);
		end
	elseif (LocalPlayer():InVehicle()) then
		local Speed = tostring(math.Round(LocalPlayer():GetVehicle():GetVelocity():Length() / 17.6));
		draw.SimpleText("Speed", "perp2_TextHUDBig", border * 3 + widthPer * 3.5, self:GetTall() - border - heightPer * .45, Color(0, 0, 0, 255), 1, 1);
		draw.SimpleText(SpeedText(Speed), "perp2_TextHUDSmall", border * 3 + widthPer * 3.5, self:GetTall() - border - heightPer * .28, Color(0, 0, 0, 255), 1, 1);
	else
		local formattedTime = "0 Seconds";
		local timePlayed = LocalPlayer():GetTimePlayed();
		
		local numMonths = math.floor(timePlayed / (60 * 60 * 24 * 31));
		local numWeeks = math.floor(timePlayed / (60 * 60 * 24 * 7));
		local numDays = math.floor(timePlayed / (60 * 60 * 24));
		local numHours = math.floor(timePlayed / (60 * 60));
		local numMinutes = math.floor(timePlayed / 60);
		local numSeconds = math.floor(timePlayed);
		
		if (numMonths != 0) then formattedTime = numMonths .. " Month"; if (numMonths > 1) then formattedTime = formattedTime .. "s" end
		elseif (numWeeks != 0) then formattedTime = numWeeks .. " Week"; if (numWeeks > 1) then formattedTime = formattedTime .. "s" end
		elseif (numDays != 0) then formattedTime = numDays .. " Day";  if (numDays > 1) then formattedTime = formattedTime .. "s" end
		elseif (numHours != 0) then formattedTime = numHours .. " Hour";  if (numHours > 1) then formattedTime = formattedTime .. "s" end
		elseif (numMinutes != 0) then formattedTime = numMinutes .. " Minute";  if (numMinutes > 1) then formattedTime = formattedTime .. "s" end
		else formattedTime = numSeconds .. " Second"; if (numSeconds > 1) then formattedTime = formattedTime .. "s" end end
		
		draw.SimpleText("Played", "perp2_TextHUDBig", border * 3 + widthPer * 3.5, self:GetTall() - border - heightPer * .45, Color(0, 0, 0, 255), 1, 1);
		draw.SimpleText(formattedTime, "perp2_TextHUDSmall", border * 3 + widthPer * 3.5, self:GetTall() - border - heightPer * .28, Color(255, 255, 255, 200), 1, 1);
	end
	
	if (LocalPlayer():GetCash() > self.LastDisplayCash) then
		if (LocalPlayer():GetCash() - self.LastDisplayCash) > 10000 then
			self.LastDisplayCash = self.LastDisplayCash + 1000;
		elseif (LocalPlayer():GetCash() - self.LastDisplayCash) > 1000 then
			self.LastDisplayCash = self.LastDisplayCash + 100;
		elseif (LocalPlayer():GetCash() - self.LastDisplayCash) > 100 then
			self.LastDisplayCash = self.LastDisplayCash + 10;
		else
			self.LastDisplayCash = self.LastDisplayCash + 1;
		end
	elseif (LocalPlayer():GetCash() < self.LastDisplayCash) then
		if (self.LastDisplayCash - LocalPlayer():GetCash()) > 10000 then
			self.LastDisplayCash = self.LastDisplayCash - 1000;
		elseif (self.LastDisplayCash - LocalPlayer():GetCash()) > 1000 then
			self.LastDisplayCash = self.LastDisplayCash - 100;
		elseif (self.LastDisplayCash - LocalPlayer():GetCash()) > 100 then
			self.LastDisplayCash = self.LastDisplayCash - 10;
		else
			self.LastDisplayCash = self.LastDisplayCash - 1;
		end
	end
	
	draw.SimpleText("Money", "perp2_TextHUDBig", border * 4+ widthPer * 4.5, self:GetTall() - border - heightPer * .45, Color(0, 0, 0, 255), 1, 1);
	draw.SimpleText(DollarSign() .. self.LastDisplayCash, "perp2_TextHUDSmall", border * 4 + widthPer * 4.5, self:GetTall() - border - heightPer * .28, Color(255, 255, 255, 200), 1, 1);
	
	// Fuel
	local CurFuel = LocalPlayer():GetVehicle():GetNetworkedInt("fuel");
	draw.SimpleText("Gas", "perp2_TextHUDBig", border * 5 + widthPer * 5.5, self:GetTall() - border - heightPer * .45, Color(0, 0, 0, 255), 1, 1);
	draw.SimpleText(math.Round(CurFuel)*.01, "perp2_TextHUDSmall", border * 5 + widthPer * 5.5, self:GetTall() - border - heightPer * .28, Color(0, 255, 100, 255), 1, 1);
	
	local text = "No Weapon";
	if (LocalPlayer():Alive() && LocalPlayer():GetActiveWeapon() && LocalPlayer():GetActiveWeapon().Clip1) then
		local clip1 = LocalPlayer():GetActiveWeapon():Clip1();
		local ammo = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType());
		
		if (clip1 == -1) then
			text = "Unlimited Ammo";
		else
			text = clip1 .. " / " .. ammo;
		end
		
		if (LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physcannon") then
			text = "Unlimited Ammo";
		elseif (LocalPlayer():GetActiveWeapon():GetClass() == "weapon_perp_paramedic_defib") then
			self.lastChargeDisp = self.lastChargeDisp or 0;
			
			if (self.lastChargeDisp > LocalPlayer():GetActiveWeapon().ChargeAmmount) then
				self.lastChargeDisp = self.lastChargeDisp - 1;
			elseif (self.lastChargeDisp < LocalPlayer():GetActiveWeapon().ChargeAmmount) then
				self.lastChargeDisp = self.lastChargeDisp + 1;
			end
			
			text = "Charge: " .. self.lastChargeDisp .. "%";
		elseif (LocalPlayer():GetActiveWeapon():GetClass() == "weapon_perp_paramedic_health") then
			if (LocalPlayer():GetActiveWeapon().LastUse && LocalPlayer():GetActiveWeapon().LastUse > CurTime() + 10) then
				if (last == 1) then
					text = "Ready In " .. math.ceil(10 - (CurTime() - LocalPlayer():GetActiveWeapon().LastUse)) .. " Second";
				else
					text = "Ready In " .. math.ceil(10 - (CurTime() - LocalPlayer():GetActiveWeapon().LastUse)) .. " Seconds";
				end
			else
				text = "Ready";
			end
		end
	end	
	
	draw.SimpleText("Ammo", "perp2_TextHUDBig", border * 5 + widthPer * 6.5, self:GetTall() - border - heightPer * .45, Color(0, 0, 0, 255), 1, 1);
	draw.SimpleText(text, "perp2_TextHUDSmall", border * 5 + widthPer * 6.5, self:GetTall() - border - heightPer * .28, Color(255, 255, 255, 200), 1, 1);
	
	// talking
	
	if (GAMEMODE.CurrentlyTalking) then
		surface.SetDrawColor(255, 255, 255, 255);
		surface.SetTexture(currentlyTalkingTexture);
		surface.DrawTexturedRect(5, 5, ScrH() * .1, ScrH() * .1);
	end
	
	if (LocalPlayer():Team() != TEAM_CITIZEN && LocalPlayer():Team() != TEAM_MAYOR && LocalPlayer():GetUMsgBool("tradio", false)) then
		surface.SetDrawColor(255, 255, 255, 255);
		surface.SetTexture(currentlyRadioTexture);
		surface.DrawTexturedRect(10 + ScrH() * .1, 5, ScrH() * .1, ScrH() * .1);
	end
	
	// Chat
	local xBuffer = 160;
	local ChatFont = "PEChatFont"
	
	surface.SetFont(ChatFont);
	local _, y = surface.GetTextSize("what");
	local startY = self:GetTall() - border * 10 - heightPer - y - 8;
	
	if (GAMEMODE.ChatBoxOpen) then
		local ourType = "Local";
		if (GAMEMODE.chatBoxIsOOC) then ourType = "OOC"; end
		
		local drawText = GAMEMODE.chatBoxText;
		
		for k, v in pairs(GAMEMODE.chatPrefixes) do
			if (string.match(string.lower(GAMEMODE.chatBoxText), "^[ \t]*[!/]" .. string.lower(k))) then
				
				ourType = v;
				drawText = string.Trim(string.sub(string.Trim(drawText), string.len(k) + 2));
				
				break;
			end
		end
	
		surface.SetFont(ChatFont);
		local x, y = surface.GetTextSize(ourType .. ": " .. drawText);
		
		draw.RoundedBox(4, xBuffer, startY, x + 10, y, Color(255, 255, 255, 200))
		
		if (math.sin(CurTime() * 5) * 10) > 0 then
			drawText = drawText .. "|";
		end
		
		draw.SimpleText(ourType .. ": " .. drawText, ChatFont, xBuffer + 4, startY + y * .5, Color(0, 0, 0, 200), 0, 1);
		draw.SimpleText(ourType .. ": " .. drawText, ChatFont, xBuffer + 4, startY + y * .5, Color(0, 0, 0, 200), 0, 1);
	end
	
	if (#GAMEMODE.chatRecord > 0) then
		for i = math.Clamp(#GAMEMODE.chatRecord - GAMEMODE.linesToShow, 1, #GAMEMODE.chatRecord), #GAMEMODE.chatRecord do
			local tab = GAMEMODE.chatRecord[i];
			
			if (GAMEMODE.ChatBoxOpen || tab[1] + 15 >= CurTime()) then
				local Alpha = 255;
				
				if (!GAMEMODE.ChatBoxOpen && tab[1] + 10 < CurTime()) then
					local TimeLeft = tab[1] + 15 - CurTime();
					Alpha = (255 / 5) * TimeLeft;
				end

				local posX, posY = xBuffer, startY - y * (1.5 + (#GAMEMODE.chatRecord - i));
				
				if tab[3] then
					local col = Color(tab[3].r, tab[3].g, tab[3].b, Alpha);
					
					draw.SimpleText(tab[2] .. ": ", ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha), 2);
					draw.SimpleText(tab[2] .. ": ", ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha), 2);
					
					if (tab[6]) then
						local Cos = math.abs(math.sin(CurTime() * 2));
						
						draw.SimpleTextOutlined(tab[2] .. ": ", ChatFont, posX, posY, col, 2, 0, 1, Color(Cos * tab[6].r, Cos * tab[6].g, Cos * tab[6].b, math.Clamp(Alpha * Cos, 0, 255)));
						draw.SimpleTextOutlined(tab[2] .. ": ", ChatFont, posX, posY, col, 2, 0, 1, Color(Cos * tab[6].r, Cos * tab[6].g, Cos * tab[6].b, math.Clamp(Alpha * Cos, 0, 255)));
					else
						draw.SimpleText(tab[2] .. ": ", ChatFont, posX, posY, col, 2);
						draw.SimpleText(tab[2] .. ": ", ChatFont, posX, posY, col, 2);
					end
				end
				
				local col = Color(tab[5].r, tab[5].g, tab[5].b, Alpha);
				draw.SimpleText(tab[4], ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha));
				draw.SimpleText(tab[4], ChatFont, posX + 1, posY + 1, Color(0, 0, 0, Alpha));
				draw.SimpleText(tab[4], ChatFont, posX, posY, col);
				draw.SimpleText(tab[4], ChatFont, posX, posY, col);
			end
		end
	end
end

vgui.Register("perp2_hud", PANEL);