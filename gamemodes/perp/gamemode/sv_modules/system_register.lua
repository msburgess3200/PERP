

/*
local SetRank = 6;
function GM.PlayerRegistration ( Player, Cmd, Args )
	
	if Player.SMFID && Player.SMFID != -1 then
		Player:Notify("You're already a registered user of Pulsar Effect.");
		umsg.Start('pe_close_reg', Player); umsg.End();
		return
	end
	
	
	local UN, PW = Args[1], Args[2];
	
	if !UN or UN == "" then
		Player:Notify("Invalid username. Select another.");
		umsg.Start('pe_restore_reg', Player); umsg.End();
		return
	end
	
	if !PW or PW == "" or string.len(PW) < 5 then
		Player:Notify("Invalid password. It must be at least 5 characters long.");
		umsg.Start('pe_restore_reg', Player); umsg.End();
		return
	end
	
	if string.len(PW) > 32 then
		Player:Notify("Your password is too long. Maximum of 32 characters.");
		umsg.Start('pe_restore_reg', Player); umsg.End();
		return
	end
	
	if string.len(UN) < 3 then
		Player:Notify("Your username is too short. Minimum 3 characters.");
		umsg.Start('pe_restore_reg', Player); umsg.End();
		return
	end
	
	if string.len(UN) > 32 then
		Player:Notify("Your username is too long. Maximum 32 characters.");
		umsg.Start('pe_restore_reg', Player); umsg.End();
		return
	end
	
	if string.find(PW, ' ') then
		Player:Notify("Your password cannot contain spaces.");
		umsg.Start('pe_restore_reg', Player); umsg.End();
		return
	end
	
	if string.find(UN, ' ') then
		Player:Notify("Your username cannot contain spaces.");
		umsg.Start('pe_restore_reg', Player); umsg.End();
		return
	end
	
	if UN != tmysql.escape(UN) then
		Player:Notify("Your username contains illegal characters.");
		umsg.Start('pe_restore_reg', Player); umsg.End();
		return
	end
	
	if PW != tmysql.escape(PW) then
		Player:Notify("Your password contains illegal characters.");
		umsg.Start('pe_restore_reg', Player); umsg.End();
		return
	end
	
	for i = 1, string.len(UN) do
		StringToCheck = string.lower(string.sub(UN, i, i));
		
		local IsOkay = false;
		
		for k, v in pairs(VALID_CHARACTERS) do
			if v == StringToCheck then
				IsOkay = true;
				break;
			end
		end
		
		if !IsOkay then
			Player:Notify("Your username contains illegal characters.");
			umsg.Start('pe_restore_reg', Player); umsg.End();
			return
		end
	end
	
	for i = 1, string.len(PW) do
		StringToCheck = string.lower(string.sub(PW, i, i));
		
		local IsOkay = false;
		
		for k, v in pairs(VALID_CHARACTERS) do
			if v == StringToCheck then
				IsOkay = true;
				break;
			end
		end
		
		if !IsOkay then
			Player:Notify("Your password contains illegal characters.");
			umsg.Start('pe_restore_reg', Player); umsg.End();
			return
		end
	end
	
	if PW == "Password" then
		Player:Notify("Please choose a different password.");
		umsg.Start('pe_restore_reg', Player); umsg.End();
		return
	end
	
	tmysql.query("SELECT `id_member` FROM `smf_members` WHERE `member_name` LIKE '" .. tmysql.escape(UN) .. "'", function ( PlayerInfo )
		if (PlayerInfo && PlayerInfo[1]) then
			Player:Notify("That username has already been taken.");
			umsg.Start('pe_restore_reg', Player); umsg.End();
			return
		end

	tmysql.query("INSERT INTO `smf_members` (`member_name`, `id_group`, `passwd`, `aim`, `yim`, `member_ip`) VALUES ('" .. tmysql.escape(UN) .. "', '4', '" .. tmysql.escape(PW) .. "', '" .. tmysql.escape(Player:Nick()) .. "', '" .. Player:SteamID() .. "', '" .. Player:IPAddress() .. "')", function ( Res )
	//http.Get(REGISTRATION_ADDR .. Player:SteamID(), '', function ( C )
	
	
	if Player and Player:IsValid() and Player:IsPlayer() then
		if C == "s" then
			Player:Notify("You have registered successfully.");
			umsg.Start('pe_close_reg', Player); umsg.End();
			
			Player:LoadSMF();
		else
			Player:Notify("There was an error while trying to register. ID: '" .. C .. "'");
			umsg.Start('pe_restore_reg', Player); umsg.End();
		end
	end
	
	
	end);
end
concommand.Add('pe_reg', GM.PlayerRegistration);

function GM.PlayerRegistration ( Player, Cmd, Args )
	if !Player.SMFID || Player.SMFID == -1 then
		Player:Notify("Your account has errors. Please try again later.");
		Player:Notify("If this problem continues, contact administration.");
		return
	end
	
	local PW = Args[1];
	
	if !PW or PW == "" or string.len(PW) < 5 then
		Player:Notify("Invalid password. It must be at least 5 characters long.");
		return
	end
	
	if string.len(PW) > 32 then
		Player:Notify("Your password is too long. Maximum of 32 characters.");
		return
	end
	
	if string.find(PW, ' ') then
		Player:Notify("Your password cannot contain spaces.");
		return
	end
	
	if PW != tmysql.escape(PW) then
		Player:Notify("Your password contains illegal characters.");
		return
	end

	for i = 1, string.len(PW) do
		StringToCheck = string.lower(string.sub(PW, i, i));
		
		local IsOkay = false;
		
		for k, v in pairs(VALID_CHARACTERS) do
			if v == StringToCheck then
				IsOkay = true;
				break;
			end
		end
		
		if !IsOkay then
			Player:Notify("Your password contains illegal characters.");
			return
		end
	end
	
	if PW == "Password" then
		Player:Notify("Please choose a different password.");
		return
	end
	
	tmysql.query("INSERT INTO `smf_members_change_pw` VALUES ('" .. PW .. "', '" .. Player:SteamID() .. "')", function ( p )
		http.Get(CHANGE_PASSW_ADDR .. Player:SteamID(), '', function ( C )
			if (C == "s") then
				Player:Notify("You have successfully changed your password.");
			else
				Player:Notify("There was an error while attempting to change your password.");
			end
		end);
	end);
end
concommand.Add('pe_mang', GM.PlayerRegistration);
*/