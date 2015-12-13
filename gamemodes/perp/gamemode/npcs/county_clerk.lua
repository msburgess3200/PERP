


local NPC = {};

NPC.Name = "County Clerk";
NPC.ID = 1;

NPC.Model = Model("models/players/perp2/f_2_02.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-7269.7134, -9219.4434, 72);
NPC.Angles = Angle(0, 90, 0.000000);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 228;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.DialogPanel:SetDialog("Welcome to the County Clerk's office, how many I help you?");
	
	if (LocalPlayer():Team() == TEAM_CITIZEN) then
		if (LocalPlayer():GetUMsgInt("org", 0) == 0) then
			GAMEMODE.DialogPanel:AddDialog("I'd like to register an organization, please.", NPC.Chat2)
		elseif (GAMEMODE.OrganizationData && GAMEMODE.OrganizationData[LocalPlayer():GetUMsgInt("org", 0)] && GAMEMODE.OrganizationData[LocalPlayer():GetUMsgInt("org", 0)][4]) then
			GAMEMODE.DialogPanel:AddDialog("I'd like to disband my organization, please.", NPC.Chat4)
		else
			GAMEMODE.DialogPanel:AddDialog("I'd like to leave my organization, please.", NPC.Chat6)
		end
	end
	
	GAMEMODE.DialogPanel:AddDialog("What is the process of getting a name change?", NPC.NameChange)
	
	if (LocalPlayer():Team() == TEAM_CITIZEN) then
		if (GAMEMODE.IsRunningForMayor) then
			GAMEMODE.DialogPanel:AddDialog("I'd like to retract my bid for mayordom.", NPC.RunForMayor)
		else
			GAMEMODE.DialogPanel:AddDialog("I'd like to run for mayor.", NPC.RunForMayor)
		end
		
		GAMEMODE.DialogPanel:AddDialog("Is the city looking for any Secret Service agents?", NPC.AskAboutSS)
	elseif (LocalPlayer():Team() == TEAM_SECRET_SERVICE) then
		GAMEMODE.DialogPanel:AddDialog("I'm here to pick up the mayor's limo...", NPC.GrabLimo)
		GAMEMODE.DialogPanel:AddDialog("I'd like to resign from my post as a Secret Service agent.", NPC.QuitSS)
	end
	
	GAMEMODE.DialogPanel:AddDialog("Nevermind... Sorry for bothering you.", LEAVE_DIALOG)
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.Chat2 ( )
	GAMEMODE.DialogPanel:SetDialog("Wonderful! There will be a five thousand dollar filing fee which is only taken in cash; is that okay?");
	
	if (LocalPlayer():GetCash() >= 5000) then
		GAMEMODE.DialogPanel:AddDialog("Sure, that sounds great.", NPC.Chat3)
		GAMEMODE.DialogPanel:AddDialog("Ehh... That seems a tad expensive. I'll have to pass.", LEAVE_DIALOG)
	elseif (LocalPlayer():GetCash() + LocalPlayer():GetBank() >= 5000) then
		GAMEMODE.DialogPanel:AddDialog("I don't have enough cash on me... Damn beaurocracy.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:AddDialog("Looks like I can't aford it... Damn beaurocracy.", LEAVE_DIALOG)
	end
end

function NPC.Chat3 ( )
	GAMEMODE.DialogPanel:SetDialog("(3 Hours Later...) Alright, all the paper work is done. Have a nice day.\n\n[ You can open the Organizations tab with F3. ]");
	LocalPlayer():TakeCash(5000);
	
	RunConsoleCommand("perp_o_n");
	
	GAMEMODE.DialogPanel:AddDialog("Thank you!", LEAVE_DIALOG)
end

function NPC.Chat4 ( )
	GAMEMODE.DialogPanel:SetDialog("Are you sure? Once I file the paperwork, I can't reform your organization.\n\n[ WARNING: You CANNOT undo this. ]");
	
	GAMEMODE.DialogPanel:AddDialog("Yes, I'm sure.", NPC.Chat5)
	GAMEMODE.DialogPanel:AddDialog("Nevermind. I need to think about it more.", LEAVE_DIALOG)
end

function NPC.Chat5 ( )
	GAMEMODE.DialogPanel:SetDialog("Okay, I'll file the paperwork immediately.");
	
	RunConsoleCommand("perp_o_q");
	
	GAMEMODE.DialogPanel:AddDialog("Thank you.", LEAVE_DIALOG)
end

function NPC.Chat6 ( )
	GAMEMODE.DialogPanel:SetDialog("Okay, I'll remove you from the organization roster. Have a nice day.");
	
	RunConsoleCommand("perp_o_q");
	
	GAMEMODE.DialogPanel:AddDialog("Thank you.", LEAVE_DIALOG)
end

function NPC.NameChange ( )
	GAMEMODE.DialogPanel:SetDialog("It's a simple matter of you paying a nominal filing fee of " .. DollarSign() .. GAMEMODE.RenamePrice .. " and telling us the name that you want.");
	
	if (LocalPlayer():GetCash() >= GAMEMODE.RenamePrice) then
		GAMEMODE.DialogPanel:AddDialog("Okay, let's do it.", NPC.DoNameChange)
	end
	
	GAMEMODE.DialogPanel:AddDialog("That seems a little too expensive...", LEAVE_DIALOG)
end

function NPC.DoNameChange ( )
	LocalPlayer():TakeCash(GAMEMODE.RenamePrice, true);
	ShowRenamePanel();
	LEAVE_DIALOG();
end

function NPC.RunForMayor ( )
	if (team.NumPlayers(TEAM_MAYOR) > 0) then
		GAMEMODE.DialogPanel:SetDialog("We already have a mayor, so you'll need to wait for the next election cycle.");
		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)
		return;
	end
	
	if (LocalPlayer():Team() != TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("Unfortunately you cannot run for mayor while serving as a government official. Conflict of interests, unfortunately.\n\n(If you wish to run for mayor, you must first quit your other job.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	end
	
	if (LocalPlayer():GetNetworkedBool("warrent", false)) then
		GAMEMODE.DialogPanel:SetDialog("We do not allowed people with an active warrent to run for mayor.\n\n(You have a warrent; you must get rid of it before running for mayor.)");
		GAMEMODE.DialogPanel:AddDialog("Oh, okay.", LEAVE_DIALOG)
		return;
	end
	
	/*
	if (LocalPlayer():GetPERPLevel(GENE_INFLUENCE) < 1) then
		GAMEMODE.DialogPanel:SetDialog("You do not seem to possess the characteristics that we look for in mayors.\n\n(You must have at least level 1 of the influence gene to be mayor.)");
		GAMEMODE.DialogPanel:AddDialog("That's unfortunate.", LEAVE_DIALOG)
		return;
	end
	*/
	
	if (LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_MAYOR])) then
		local expires = LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_FIREMAN]);
		
		if (expires == 0) then
			GAMEMODE.DialogPanel:SetDialog("I'm afraid you've reached your term limits.\n\n(You are permanently blacklisted from this occupation.)");
		elseif (GAMEMODE.Options_EuroStuff:GetBool()) then
			GAMEMODE.DialogPanel:SetDialog("I'm afraid you've reached your term limits.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %H:%M", expires) .. ".)");
		else
			GAMEMODE.DialogPanel:SetDialog("I'm afraid you've reached your term limits.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %I:%M %p", expires) .. ".)");
		end
		
		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG);	
		return;
	end
	
	if (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Okay, I've taken your name off of the ballot.");
		GAMEMODE.DialogPanel:AddDialog("Okay, thank you.", LEAVE_DIALOG)
		GAMEMODE.IsRunningForMayor = nil;
		
		RunConsoleCommand("perp_g_b");
	else
		GAMEMODE.IsRunningForMayor = true;
		GAMEMODE.DialogPanel:SetDialog("Okay, I've added your name to the ballot.");
		GAMEMODE.DialogPanel:AddDialog("Okay, thank you.", LEAVE_DIALOG)
		
		RunConsoleCommand("perp_g_b");
	end
end

function NPC.AskAboutSS ( )
	local SSNumber = team.NumPlayers(TEAM_SECRET_SERVICE);
	
	if (team.NumPlayers(TEAM_MAYOR) == 0) then
		GAMEMODE.DialogPanel:SetDialog("We do not currently have a mayor - what would be the point in protecting someone who doesn't exist?");
		
		GAMEMODE.DialogPanel:AddDialog("I guess that makes sense...", LEAVE_DIALOG);	
	elseif (SSNumber >= GAMEMODE.MaximumSecretService) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, we're not currently looking to hire any new secret service agents.\n\n(This class is full. Try again later.)");
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (LocalPlayer():GetNetworkedBool("warrent", false)) then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials.\n\n(You have a warrent; you must get rid of it before becoming a police officer.)");
		
		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG);	
	elseif (LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_SECRET_SERVICE])) then
		local expires = LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_SECRET_SERVICE]);
		
		if (expires == 0) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are permanently blacklisted from this occupation.)");
		elseif (GAMEMODE.Options_EuroStuff:GetBool()) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %H:%M", expires) .. ".)");
		else
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %I:%M %p", expires) .. ".)");
		end
		
		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG);	
	elseif (LocalPlayer():GetTimePlayed() < GAMEMODE.RequiredTime_SecretService * 60 * 60 && !LocalPlayer():IsBronze()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_SecretService .. " hours of play time or VIP to be an officer.)");
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but people running for mayordom cannot be hired by the city due to legal issues.");
		
		GAMEMODE.DialogPanel:AddDialog("Oh, that's lame.", LEAVE_DIALOG);	
	else
		GAMEMODE.DialogPanel:SetDialog("Yes, of course. Welcome to the Evocity branch of the Secret Service. As a member of the secret service, you are tasked with the protection of the mayor at all cost. You will also have, if the mayor so chooses to supply you with one, a stretch limo that you can use to help the mayor travel about the city.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)");
		
		RunConsoleCommand('perp_ss_j');
		
		GAMEMODE.DialogPanel:AddDialog("Thank you. I'll get my suit on!", LEAVE_DIALOG);			
	end
end

function NPC.QuitSS ( )
	LEAVE_DIALOG();
	
	RunConsoleCommand('perp_ss_q');
	ClientCar = 0;
end

function NPC.GrabLimo ( )
	local numSquadCars = 0;
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		local vT = lookForVT(v);
		
		if (vT && vT.RequiredClass == TEAM_SECRET_SERVICE && v:GetNetworkedEntity("owner", nil) != LocalPlayer()) then
			numSquadCars = numSquadCars + 1;
		end
	end
	
	if (GAMEMODE.MaxStretch == 0) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but the limo is out for repairs.\n\n(The mayor has not chosen to fund a limo for the Secret Service.)");
		
		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG);
	elseif (numSquadCars >= GAMEMODE.MaxStretch) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but the limo is already out. Try calling your partner, perhaps?");
				
		GAMEMODE.DialogPanel:AddDialog("Good idea.", LEAVE_DIALOG);	
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(The limo can be found on the sidewalk outside of the Government Center.)");
		
		RunConsoleCommand('perp_ss_c');
		
		GAMEMODE.DialogPanel:AddDialog("Thank you!", LEAVE_DIALOG);		
	end
end

GAMEMODE:LoadNPC(NPC);