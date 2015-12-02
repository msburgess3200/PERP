


local NPC = {};

NPC.Name = "Fire Department";
NPC.ID = 12;

NPC.Model = Model("models/players/perp2/fire_02.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-3788.1167, -6982.7051, 198.0313);
NPC.Angles = Angle(0, 180, 0);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	local PoliceNumber = team.NumPlayers(TEAM_FIREMAN);
	
	if LocalPlayer():Team() == TEAM_FIREMAN then
		GAMEMODE.DialogPanel:SetDialog("Hello.");
		
		GAMEMODE.DialogPanel:AddDialog("Are there any fire trucks available?", NPC.FireTruck);
		GAMEMODE.DialogPanel:AddDialog("I'm here to quit the team. It's more than I can handle.", NPC.QuitJob);
		GAMEMODE.DialogPanel:AddDialog("Hello.", LEAVE_DIALOG);
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Hello, Mr. Mayor.");
		
		GAMEMODE.DialogPanel:AddDialog("Good day, sir.", LEAVE_DIALOG);
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("Hello. We could use new blood, are you interested?");
		
		GAMEMODE.DialogPanel:AddDialog("Yes, I'm interested in a position as a firefighter.", NPC.Hire);
		GAMEMODE.DialogPanel:AddDialog("No thank you.", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Hello.");
		
		GAMEMODE.DialogPanel:AddDialog("Goodbye.", LEAVE_DIALOG);
	end
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.QuitJob ( )
	LEAVE_DIALOG();
	
	RunConsoleCommand('perp_f_q');
	ClientCar = 0;
end

function NPC.Hire ( )
	local FiremanNumber = team.NumPlayers(TEAM_FIREMAN);
	
	if (FiremanNumber >= GAMEMODE.MaximumFireMen) then
		GAMEMODE.DialogPanel:SetDialog("We aren't currently recruiting new firefighters. Sorry.\n\n(This class is full. Try again later.)");
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (LocalPlayer():GetNetworkedBool("warrent", false)) then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials.\n\n(You have a warrent; you must get rid of it before becoming a fireman.)");
		
		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG);
	elseif (LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_FIREMAN])) then
		local expires = LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_FIREMAN]);
		
		if (expires == 0) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are permanently blacklisted from this occupation.)");
		elseif (GAMEMODE.Options_EuroStuff:GetBool()) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %H:%M", expires) .. ".)");
		else
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %I:%M %p", expires) .. ".)");
		end
		
		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG);	
	elseif (LocalPlayer():GetTimePlayed() < GAMEMODE.RequiredTime_Fire * 60 * 60 && !LocalPlayer():IsBronze()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_Fire .. " hours of play time or VIP to be a fireman.)");
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("You seem like the business type, are you sure you don't have other things going?\n\n(You cannot be a fire fighter while running for mayor.)");
		
		GAMEMODE.DialogPanel:AddDialog("Ahh, yes. I wouldn't have the time.", LEAVE_DIALOG);	
	else
		GAMEMODE.DialogPanel:SetDialog("Ahh, yes. Of course! Thank you for coming by! We've been looking to hire more men.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)");
		
		RunConsoleCommand('perp_f_j');
		
		GAMEMODE.DialogPanel:AddDialog("Thank you. I will do my hardest to protect the city.", LEAVE_DIALOG);			
	end
end

function NPC.FireTruck ( )
	local numFireCars = 0;
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		local vT = lookForVT(v);
		
		if (vT && vT.RequiredClass == TEAM_FIREMAN && v:GetNetworkedEntity("owner", nil) != LocalPlayer()) then
			numFireCars = numFireCars + 1;
		end
	end
	
	if (numFireCars >= GAMEMODE.MaxFireTrucks) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the fire trucks have been taken out on duty.\n\n(All fire trucks are taken; wait until someone who is using one quits the department.)");
				
		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG);	
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Your fire truck can be found on the sidewalk along side the Government Center.)");
		
		RunConsoleCommand('perp_f_c');
		
		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG);		
	end
end

GAMEMODE:LoadNPC(NPC);