function PLAYER:GetRankString()
	
	if self:GetLevel() == 200 then
		return "Guest";
	elseif self:GetLevel() == 100 then
		return "Bronze VIP";
	elseif self:GetLevel() == 99 then
		return "Silver VIP";
	elseif self:GetLevel() == 98 then
		return "Gold VIP";
	elseif self:GetLevel() == 97 then
		return "Diamond VIP"; 
	elseif self:GetLevel() == 96 then
		return "Premium VIP";
	elseif self:GetLevel() == 3 then
		return "Mod";
	elseif self:GetLevel() == 2 or self:GetLevel() == 10 then
		return "Admin";
	elseif self:GetLevel() == 1 then
		return "Super Admin";
	elseif self:GetLevel() == 0 then
		return "Owner";
	elseif self:GetLevel() == 255 then
		return "Banned";
	else
		return "ERROR GETTING RANK";
	end

end

local function MonitorDrowning ( )
	for k, v in pairs(player.GetAll()) do
		if (SERVER || v == LocalPlayer()) then
			if (v:WaterLevel() >= 3) then
				v.UnderwaterStart = v.UnderwaterStart or CurTime();
				local availableUnderwaterTime = GAMEMODE.DrownTime * (1 + ((v:GetPERPLevel(SKILL_SWIMMING) - 1) * .2));
				
				if (v:Alive() && v.UnderwaterStart + availableUnderwaterTime <= CurTime()) then
					v.LastWaterDamage = v.LastWaterDamage or 0;
					
					if (v.LastWaterDamage + GAMEMODE.DrowningDelay <= CurTime()) then
						v.LastWaterDamage = CurTime();
						
						if SERVER then
							local ProspectiveHealth = v:Health() - GAMEMODE.DrowningDamage;
							
							if (ProspectiveHealth <= 0) then
								v:Kill();
							else
								v:SetHealth(ProspectiveHealth);
							end
						else
							surface.PlaySound(Sound("player/pl_drown" .. math.random(1, 3) .. ".wav"));
							vgui.Create("perp2_drown");
						end
					end
				end
				
				v.LastSwimmingAllowance = v.LastSwimmingAllowance or 0;
				local realSpeed = v:GetVelocity():Length();
				
				if (realSpeed >= 50 && v.LastSwimmingAllowance + 1 <= CurTime()) then
					v:GiveExperience(SKILL_SWIMMING, GAMEMODE.ExperienceForSwimming, true);
					v.LastSwimmingAllowance = CurTime();
				end
			else
				if (v:InVehicle() && v:GetVehicle():GetClass() == "prop_vehicle_jeep") then
					v.LastDrivingAllowance = v.LastDrivingAllowance or 0;
					local realSpeed = v:GetVehicle():GetVelocity():Length();
					
					if (realSpeed >= 10 && v.LastDrivingAllowance <= CurTime()) then
						v:GiveExperience(SKILL_DRIVING, GAMEMODE.ExperienceForDriving, true);
						v.LastDrivingAllowance = CurTime() + 5;
					end
				end
				
				v.UnderwaterStart = nil;
			end
		end
	end
end
hook.Add("Think", "MonitorDrowning", MonitorDrowning);

function IsValid( object )
	if (!object) then return false; end
	if (!object.IsValid) then return false; end
	
	return object:IsValid();
end;

function ScaleToWideScreen(size)
	return math.min(math.max( ScreenScale(size / 2.62467192), math.min(size, 14) ), size);
end;

function FindPlayer(info)
	local pls = player.GetAll()

	-- Find by Index Number (status in console)
	for k = 1, #pls do -- Proven to be faster than pairs loop.
		local v = pls[k]
		if tonumber(info) == v:UserID() then
			return v
		end

		if info == v:SteamID() then
			return v
		end
		
		if string.find(string.lower(v:GetRPName()), string.lower(tostring(info)), 1, true) ~= nil then
			return v
		end
	end
	return nil
end