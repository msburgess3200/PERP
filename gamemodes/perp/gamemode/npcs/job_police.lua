

local NPC = {};

NPC.Name = "Police Department";
NPC.ID = 11;

NPC.Model = Model("models/humans/SCPD/male_01.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-6997.8965, -8858.5801, -431.9688);
NPC.Angles = Angle(0, -90, 0);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )	
	if LocalPlayer():Team() == TEAM_POLICE or LocalPlayer():Team() == TEAM_SWAT or LocalPlayer():Team() == TEAM_DISPATCHER then
		GAMEMODE.DialogPanel:SetDialog("You're here to quit, aren't you? This ALWAYS happens! Can't find any reliable work nowadays!");
		
		if (LocalPlayer():Team() == TEAM_POLICE) then
			GAMEMODE.DialogPanel:AddDialog("No... I was just wondering if any squad cars were available.", NPC.SquadCar);
		elseif (LocalPlayer():Team() == TEAM_SWAT) then
			GAMEMODE.DialogPanel:AddDialog("No... I was just wondering if any SWAT vans were available.", NPC.SWATVan);
		end
		
		GAMEMODE.DialogPanel:AddDialog("Actually, yes. Here's my badge.", NPC.QuitJob);
		GAMEMODE.DialogPanel:AddDialog("Errr... No...", NPC.Relief);
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Hello, Mr. Mayor, sir!");
		
		GAMEMODE.DialogPanel:AddDialog("Good day, sir.", LEAVE_DIALOG);
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("Hello, are you interested in a position as an officer?");
		
		GAMEMODE.DialogPanel:AddDialog("Yes. I've always wanted to pursue a life in law enforcement.", NPC.HirePolice);
		GAMEMODE.DialogPanel:AddDialog("Actually, I was looking for a position on your SWAT team.", NPC.HireSWAT);
		GAMEMODE.DialogPanel:AddDialog("Are you in need of any phone operators?", NPC.HireDispatcher);
		GAMEMODE.DialogPanel:AddDialog("I'd never be a pig!", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Hello, sir.");
		      
		GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG);
	end
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.QuitJob ( )
	LEAVE_DIALOG();
	
	if LocalPlayer():Team() == TEAM_POLICE then
		RunConsoleCommand('perp_p_q');
		-- ClientCar = 0;
	elseif LocalPlayer():Team() == TEAM_SWAT then
		RunConsoleCommand('perp_s_q');	
		ClientCar = 0;
	else
		RunConsoleCommand('perp_di_q');
	end
end

function NPC.Relief ( )		
	GAMEMODE.DialogPanel:SetDialog("Oh... In that case, hey! What can I do for you?");
		
	GAMEMODE.DialogPanel:AddDialog("Nothing...", LEAVE_DIALOG);	
end

function NPC.HirePolice ( )
	local PoliceNumber = team.NumPlayers(TEAM_POLICE);
	
	if (PoliceNumber >= GAMEMODE.MaximumCops) then
		GAMEMODE.DialogPanel:SetDialog("Ahh, sorry. It seems that we aren't currently looking for any new officers. Sorry.\n\n(This class is full. Try again later.)");
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (LocalPlayer():GetNetworkedBool("warrent", false)) then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials.\n\n(You have a warrent; you must get rid of it before becoming a police officer.)");
		
		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG);	
	elseif (LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_POLICE])) then
		local expires = LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_POLICE]);
		
		if (expires == 0) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are permanently blacklisted from this occupation.)");
		elseif (GAMEMODE.Options_EuroStuff:GetBool()) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %H:%M", expires) .. ".)");
		else
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %I:%M %p", expires) .. ".)");
		end
		
		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG);	
	elseif (LocalPlayer():GetTimePlayed() < GAMEMODE.RequiredTime_Cop * 60 * 60 && !LocalPlayer():IsBronze()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_Cop .. " hours of play time or VIP to be an officer.)");
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but people running for mayordom cannot be officers. Legal mumbo-jumbo.");
		
		GAMEMODE.DialogPanel:AddDialog("Oh, that's lame.", LEAVE_DIALOG);	
	else
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Here's your uniform, firearm, and hand cuffs. You can ask the mayor personally to issue a warrant when you need one. We have several squad cars available, just ask the garage operator.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)");
		
		RunConsoleCommand('perp_p_j');
		
		GAMEMODE.DialogPanel:AddDialog("I'll serve to my best ability, sir!", LEAVE_DIALOG);			
	end
end

function NPC.HireSWAT ( )
	local PoliceNumber = team.NumPlayers(TEAM_SWAT);
	
	if (PoliceNumber >= GAMEMODE.MaximumSWAT && !LocalPlayer():IsSuperAdmin()) then
		if table.Count(player.GetAll()) >= GAMEMODE.MinimumForSWAT then
			GAMEMODE.DialogPanel:SetDialog("It appears that our SWAT team is filled.\n\n(This class is full. Try again later.)");
		else
			GAMEMODE.DialogPanel:SetDialog("There is no SWAT team currently in action.\n\n(SWAT requires at least " .. GAMEMODE.MinimumForSWAT .. " players in the server.)");
		end
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (LocalPlayer():GetNetworkedBool("warrent", false)) then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials.\n\n(You have a warrent; you must get rid of it before becoming a SWAT team member.)");
		
		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG);	
	elseif (LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_SWAT])) then
		local expires = LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_SWAT]);
		
		if (expires == 0) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are permanently blacklisted from this occupation.)");
		elseif (GAMEMODE.Options_EuroStuff:GetBool()) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %H:%M", expires) .. ".)");
		else
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %I:%M %p", expires) .. ".)");
		end
		
		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG);	
	elseif ((LocalPlayer():GetTimePlayed() < GAMEMODE.RequiredTime_SWAT * 60 * 60 || !LocalPlayer():IsBronze()) && !LocalPlayer():IsAdmin()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_SWAT .. " hours of play time and VIP to be a SWAT officer.)");
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but people running for mayordom cannot be officers. Legal mumbo-jumbo.");
		
		GAMEMODE.DialogPanel:AddDialog("Oh, that's lame.", LEAVE_DIALOG);	
	else
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Here's your body armor, MP5, and Service Pistol. You will be required to answer all calls by the mayor or Police Officers in danger.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)");
		
		RunConsoleCommand('perp_s_j');
		
		GAMEMODE.DialogPanel:AddDialog("I'll serve to my best ability, sir!", LEAVE_DIALOG);			
	end
end

function NPC.HireDispatcher ( )
	local PoliceNumber = team.NumPlayers(TEAM_DISPATCHER);
	
	if (PoliceNumber >= GAMEMODE.MaximumDispatchers && !LocalPlayer():IsSuperAdmin()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, we have more than enough.\n\n(This class is full. Try again later.)");
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (LocalPlayer():GetNetworkedBool("warrent", false)) then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials.\n\n(You have a warrent; you must get rid of it before becoming a police operator.)");
		
		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG);	
	elseif (LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_DISPATCHER])) then
		local expires = LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_DISPATCHER]);
		
		if (expires == 0) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are permanently blacklisted from this occupation.)");
		elseif (GAMEMODE.Options_EuroStuff:GetBool()) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %H:%M", expires) .. ".)");
		else
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %I:%M %p", expires) .. ".)");
		end
		
		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG);	
	elseif ((LocalPlayer():GetTimePlayed() < GAMEMODE.RequiredTime_Dispatcher * 60 * 60 && !LocalPlayer():IsAdmin())) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_Dispatcher .. " hours of play time to be a police operator.)");
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but people running for mayordom cannot be officers. Legal mumbo-jumbo.");
		
		GAMEMODE.DialogPanel:AddDialog("Oh, that's lame.", LEAVE_DIALOG);	
	elseif (!LocalPlayer():HasItem("item_phone")) then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you know how to use a phone?...\n\n(You need a phone to use this job.)");
		
		GAMEMODE.DialogPanel:AddDialog("What is a phone?", LEAVE_DIALOG);	
	else
		GAMEMODE.DialogPanel:SetDialog("Welcome to the force! Your job is to answer calls from people in distress. We will route all incoming calls directly to your cells phones, so you can work from home if need be.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)");
		
		RunConsoleCommand('perp_di_j');
		
		GAMEMODE.DialogPanel:AddDialog("I'll serve to my best ability, sir!", LEAVE_DIALOG);			
	end
end

function NPC.SquadCar ( )
	local numSquadCars = 0;
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		local vT = lookForVT(v);
		
		if (vT && vT.RequiredClass == TEAM_POLICE && v:GetNetworkedEntity("owner", nil) != LocalPlayer()) then
			numSquadCars = numSquadCars + 1;
		end
	end
	
	if (numSquadCars >= GAMEMODE.MaxCopCars) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the squad cars are taken.\n\n(All squad cars are taken; wait until someone who is using one quits the force.)");
				
		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG);	
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, theres one available.");
		
		GAMEMODE.DialogPanel:AddDialog("Normal Police Car.", NPC.REG)
		GAMEMODE.DialogPanel:AddDialog("Mustang Police Car (VIP Only)", NPC.MUS)
	
		GAMEMODE.DialogPanel:AddDialog("Nevermind.", LEAVE_DIALOG);		
	end
end

function NPC.REG ( )
	RunConsoleCommand('perp_p_c');
	LEAVE_DIALOG()
end

function NPC.CHAR ( )
	RunConsoleCommand('perp_p_ac');
	LEAVE_DIALOG()
end

function NPC.MUS()

	if (LocalPlayer():GetLevel() > 98) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but you must be a Gold or Diamond VIP for this car.");
		
		GAMEMODE.DialogPanel:AddDialog("Well bummer. Nevermind.", LEAVE_DIALOG);
	else
		RunConsoleCommand('perp_p_cm');
		LEAVE_DIALOG()
	end
end

function NPC.SWATVan ( )
	local numSquadCars = 0;
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		local vT = lookForVT(v);
		
		if (vT && vT.RequiredClass == TEAM_SWAT && v:GetNetworkedEntity("owner", nil) != LocalPlayer()) then
			numSquadCars = numSquadCars + 1;
		end
	end
	
	if (numSquadCars >= GAMEMODE.MaxSWATVans) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the SWAT vans are out.\n\n(All SWAT vans are taken; wait until someone who is using one quits the force.)");
				
		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG);	
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Your SWAT van can be found on the sidewalk opposite of the Government Center.)");
		
		RunConsoleCommand('perp_s_c');
		
		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG);		
	end
end

GAMEMODE:LoadNPC(NPC);