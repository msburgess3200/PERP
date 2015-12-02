


local NPC = {};

NPC.Name = "Emergency Medical Support Agency";
NPC.ID = 13;

NPC.Model = Model("models/players/perp2/m_4_07.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-3788.1167, -7042, 198.0313);
NPC.Angles = Angle(0, 180, 0);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	local PoliceNumber = team.NumPlayers(TEAM_FIREMAN);
	
	if LocalPlayer():Team() == TEAM_MEDIC then
		GAMEMODE.DialogPanel:SetDialog("Hello, can I help you?");
		
		GAMEMODE.DialogPanel:AddDialog("Are there any ambulances available?", NPC.Ambulance);
		GAMEMODE.DialogPanel:AddDialog("This job is too much for me. I'm here to quit.", NPC.QuitJob);
		GAMEMODE.DialogPanel:AddDialog("No. Just having a look around.", LEAVE_DIALOG);
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Can I help you, Mr. Mayor?");
		
		GAMEMODE.DialogPanel:AddDialog("Not that I know of...", LEAVE_DIALOG);
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("Hello. Are you here for a checkup?");
		
		GAMEMODE.DialogPanel:AddDialog("I'm actually interested in becoming a paramedic.", NPC.Hire);
		GAMEMODE.DialogPanel:AddDialog("No. Just having a look around.", LEAVE_DIALOG);
	elseif LocalPlayer():Team() == TEAM_FIREMAN then
		GAMEMODE.DialogPanel:SetDialog("Thank you for protecting us from the ravages of fire!");
		
		GAMEMODE.DialogPanel:AddDialog("You're quite welcome, sir.", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Hello.");
		
		GAMEMODE.DialogPanel:AddDialog("Hi...", LEAVE_DIALOG);
	end
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.QuitJob ( )
	LEAVE_DIALOG();
	
	RunConsoleCommand('perp_m_q');	
	ClientCar = 0;
end

function NPC.Hire ( )
	local FiremanNumber = team.NumPlayers(TEAM_MEDIC);
	
	if (FiremanNumber >= GAMEMODE.MaximumParamedic) then
		GAMEMODE.DialogPanel:SetDialog("We have more help than we currently need, sorry.\n\n(This class is full. Try again later.)");
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (LocalPlayer():GetNetworkedBool("warrent", false)) then
		GAMEMODE.DialogPanel:SetDialog("We do not allow criminals to serve as government officials.\n\n(You have a warrent; you must get rid of it before becoming a paramedic.)");
		
		GAMEMODE.DialogPanel:AddDialog("Oh, okay...", LEAVE_DIALOG);	
	elseif (LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_MEDIC])) then
		local expires = LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_MEDIC]);
		
		if (expires == 0) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are permanently blacklisted from this occupation.)");
		elseif (GAMEMODE.Options_EuroStuff:GetBool()) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %H:%M", expires) .. ".)");
		else
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %I:%M %p", expires) .. ".)");
		end
		
		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG);	
	elseif (LocalPlayer():GetTimePlayed() < GAMEMODE.RequiredTime_Paramedic * 60 * 60 && !LocalPlayer():IsBronze()) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_Paramedic .. " hours of play time or VIP to be a paramedic.)");
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG);	
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Business laws state that we cannot hire mayor nominees. Sorry.\n\n(You cannot be a paramedic while running for mayor.)");
		
		GAMEMODE.DialogPanel:AddDialog("Ahh, yes. I wouldn't have the time.", LEAVE_DIALOG);	
	else
		GAMEMODE.DialogPanel:SetDialog("Yes, you seem qualified.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)");
		
		RunConsoleCommand('perp_m_j');
		
		GAMEMODE.DialogPanel:AddDialog("Thank you. I'll be sure to attend to any who need aid.", LEAVE_DIALOG);			
	end
end

function NPC.Ambulance ( )
	local numFireCars = 0;
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		local vT = lookForVT(v);
		
		if (vT && vT.RequiredClass == TEAM_MEDIC && v:GetNetworkedEntity("owner", nil) != LocalPlayer()) then
			numFireCars = numFireCars + 1;
		end
	end
	
	if (numFireCars >= GAMEMODE.MaxAmbulances) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the ambulances have been taken out on duty.\n\n(All ambulances are taken; wait until someone who is using one quits the department.)");
				
		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG);	
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.\n\n(Your ambulance can be found on the sidewalk opposite of the Government Center.)");
		
		RunConsoleCommand('perp_m_c');
		
		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG);		
	end
end

GAMEMODE:LoadNPC(NPC);