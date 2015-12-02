


function GM.PlayerBindPressPERP2 ( Player, Bind, Press )
	if (string.find(string.lower(Bind), "voicerecord") && !Player:Alive()) then return true; end
	if (string.find(string.lower(Bind), "zoom")) then return true; end

	if (PERP_SpectatingEntity && Press) then
		if (string.find(string.lower(Bind), "+jump")) then
			PERP_SpectatingEntity = nil;
			RunConsoleCommand("perp_a_ss");
			
			return true;
		elseif (string.find(string.lower(Bind), "+attack")) then
			local ToDo
			local GrabNext = false;
			local First;
				
			for k, v in pairs(player.GetAll()) do
				if !First then
					First = v;
				end
					
				if GrabNext then
					ToDo = v;
					break;
				elseif v:UniqueID() == PERP_SpectatingEntity:UniqueID() then
					GrabNext = true
				end
			end
				
			if !ToDo then ToDo = First; end
			
			PERP_SpectatingEntity = ToDo;
			RunConsoleCommand('perp_a_s', ToDo:UniqueID())
			
			return true;
		elseif (string.find(string.lower(Bind), "+attack2")) then
			local ToDo
			local Last;
				
			for k, v in pairs(player.GetAll()) do				
				if v:UniqueID() == PERP_SpectatingEntity:UniqueID() and Last then
					ToDo = Last;
				end
					
				Last = v;
			end
			
			if !ToDo then ToDo = Last; end
		
			PERP_SpectatingEntity = ToDo;
			RunConsoleCommand('perp_a_s', ToDo:UniqueID())
			
			return true;
		end
		
		return;
	end
	
	local vT;
	if (LocalPlayer():InVehicle()) then vT = lookForVT(LocalPlayer():GetVehicle()); end

	if (Press && string.find(string.lower(Bind), "impulse 100") && LocalPlayer():InVehicle()) then
		RunConsoleCommand("perp_v_f");
	elseif (Press && string.find(string.lower(Bind), "impulse 201") && LocalPlayer():InVehicle()) then
		RunConsoleCommand("perp_v_ug");
	elseif (Press && string.find(string.lower(Bind), "+reload") && LocalPlayer():InVehicle()) then
		RunConsoleCommand("perp_v_su");
	elseif (LocalPlayer():InVehicle() && (!vT || !vT.SirenNoise_Alt || !LocalPlayer():GetVehicle():GetNetworkedBool("siren", false)) && Press && string.find(string.lower(Bind), "+walk")) then
		RunConsoleCommand("perp_v_h");
	elseif (Press && string.find(string.lower(Bind), "+speed") && LocalPlayer():InVehicle()) then
		RunConsoleCommand("perp_v_y");
	elseif (Press && string.find(string.lower(Bind), "+menu")) then
		RunConsoleCommand("perp_r_c");
	elseif (string.find(string.lower(Bind), "+duck") && (Player:InVehicle() || PERP_SpectatingEntity) && Press) then
		local iVal = GetConVar("gmod_vehicle_viewmode"):GetInt();
		if ( iVal == 0 ) then iVal = 1 else iVal = 0 end
		RunConsoleCommand("gmod_vehicle_viewmode", iVal)
		return true;
	end
end
hook.Add("PlayerBindPress", "PlayerBindPressPERP2", GM.PlayerBindPressPERP2)


CreateConVar("gmod_vehicle_viewmode",0)