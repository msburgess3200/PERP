


local function changeRadioStation ( Player )
	if (Player.nextRadio && Player.nextRadio > CurTime()) then return; end
	
	local ent;
	if (Player:InVehicle()) then
		local vehicleTable = Player:GetVehicle().vehicleTable;
		
		if (vehicleTable && vehicleTable.SirenNoise) then
			GAMEMODE.ToggleSiren(Player);
		return; end
		
		if (vehicleTable.ID == 'a') then
			Player:Notify("ATVs are not equipped with radios.");
		return; end
			
		ent = Player:GetVehicle();
	else
		local eyeTrace = Player:GetEyeTrace();
		
		if (!eyeTrace.Entity || !IsValid(eyeTrace.Entity) || eyeTrace.Entity:GetPos():Distance(Player:GetShootPos()) > 200) then return; end
		if (eyeTrace.Entity:GetClass() != "ent_prop_item") then return; end
		if (eyeTrace.Entity:GetModel() != "models/props/cs_office/radio.mdl") then return; end
		
		ent = eyeTrace.Entity;
	end
	
	if (GAMEMODE.RadioStations[ent:GetNetworkedInt("perp_station", 0) + 1]) then
		ent:SetNetworkedInt("perp_station", ent:GetNetworkedInt("perp_station", 0) + 1)
	else
		ent:SetNetworkedInt("perp_station", 0);
	end
		
	umsg.Start('perp_rmsg', Player);
		umsg.Short(ent:GetNetworkedInt("perp_station", 0));
	umsg.End();
	
	Player.nextRadio = CurTime() + .5;
end
concommand.Add("perp_r_c", changeRadioStation);