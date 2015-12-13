

local NPC = {};

NPC.Name = "Bus Driver";
NPC.ID = 22;

NPC.Model = Model("models/players/perp2/m_2_06.mdl");

--NPC.Location = Vector(-2986.678711, 6912.656738, 68);
--NPC.Angles = Angle(0, 180, 0);
NPC.Location = Vector(-5353.600586, -6507.168457, 73);
NPC.Angles = Angle(0, -140, 0);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 228;


// This is always local player.
function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_BUSDRIVER then
		GAMEMODE.DialogPanel:SetDialog("Hello, can I help you?")
		
		GAMEMODE.DialogPanel:AddDialog("Are there any busses available?", NPC.Busses)
		GAMEMODE.DialogPanel:AddDialog("This job is too much for me. I'm here to quit.", NPC.QuitJob)
		GAMEMODE.DialogPanel:AddDialog("No, Just having a look around.", LEAVE_DIALOG)
	elseif LocalPlayer():Team() == TEAM_MAYOR then
		GAMEMODE.DialogPanel:SetDialog("Can I help you, Mr. Mayor?")
		
		GAMEMODE.DialogPanel:AddDialog("Not that I know of...", LEAVE_DIALOG)
	elseif LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("Hello. Do you think you have the patience to become a bus driver?")
		
		GAMEMODE.DialogPanel:AddDialog("I'm actually interested in becoming a bus driver.", NPC.Hire)
		GAMEMODE.DialogPanel:AddDialog("No. Just having a look around.", LEAVE_DIALOG)
	elseif LocalPlayer():Team() == TEAM_FIREMAN then
		GAMEMODE.DialogPanel:SetDialog("Thank you for protecting us from the ravages of fire!")
		
		GAMEMODE.DialogPanel:AddDialog("You're quite welcome, sir.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Hello.")
		
		GAMEMODE.DialogPanel:AddDialog("Hi...", LEAVE_DIALOG)
	end
	
	GAMEMODE.DialogPanel:Show()
end

function NPC.QuitJob ( )
	LEAVE_DIALOG()
	
	RunConsoleCommand('perp_bd_q')	
end

function NPC.Hire ( )
	local FiremanNumber = team.NumPlayers(TEAM_BUSDRIVER)
	
	if (FiremanNumber >= GAMEMODE.MaximumBusDrivers) then
		GAMEMODE.DialogPanel:SetDialog("We have more help than we currently need, sorry.\n\n(This class is full. Try again later.)")
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)	
	elseif (LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_BUSDRIVER])) then
		local expires = LocalPlayer():HasBlacklist(GAMEMODE.teamToBlacklist[TEAM_BUSDRIVER])
		
		if (expires == 0) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are permanently blacklisted from this occupation.)")
		elseif (GAMEMODE.Options_EuroStuff:GetBool()) then
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %H:%M", expires) .. ".)")
		else
			GAMEMODE.DialogPanel:SetDialog("I don't think I can trust you after what happened last time.\n\n(You are currently blacklisted from this occupation. Expires on " .. os.date("%B %d, 20%y at %I:%M %p", expires) .. ".)")
		end
		
		GAMEMODE.DialogPanel:AddDialog("Oh, right...", LEAVE_DIALOG)	
	elseif (LocalPlayer():GetTimePlayed() < GAMEMODE.RequiredTime_BusDriver * 60 * 60) then
		if (LocalPlayer():GetLevel() < 98) then
			GAMEMODE.DialogPanel:SetDialog("Yes, you seem qualified.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")
		
			RunConsoleCommand('perp_bd_j')
		
			GAMEMODE.DialogPanel:AddDialog("Thank you. I'll be sure to attend to any who needs a ride.", LEAVE_DIALOG)	
		else
			GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_BusDriver .. " hours of play time and Gold or higher level of VIP to be a bus driver.)")
		
			GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)	
		end
	elseif (LocalPlayer():GetLevel() > 98) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears that you are not qualified for this position.\n\n(You need at least " .. GAMEMODE.RequiredTime_BusDriver .. " hours of play time and Gold or higher level of VIP to be a bus driver.)")
		
		GAMEMODE.DialogPanel:AddDialog("Alright. I'll check back in later, then.", LEAVE_DIALOG)
	elseif (GAMEMODE.IsRunningForMayor) then
		GAMEMODE.DialogPanel:SetDialog("Business laws state that we cannot hire mayor nominees. Sorry.\n\n(You cannot be a bus driver while running for mayor.)")
		
		GAMEMODE.DialogPanel:AddDialog("Ahh, yes. I wouldn't have the time.", LEAVE_DIALOG)		
	else
		GAMEMODE.DialogPanel:SetDialog("Yes, you seem qualified.\n\n(If you abuse your new-found power, you will be blacklisted and possibly banned.)")
		
		RunConsoleCommand('perp_bd_j')
		
		GAMEMODE.DialogPanel:AddDialog("Thank you. I'll be sure to attend to any who needs a ride.", LEAVE_DIALOG)	
	end
end

function NPC.Busses ( )
	local numFireCars = 0
	
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		local vT = lookForVT(v)
		
		if (vT && vT.RequiredClass == TEAM_BUSDRIVER && v:GetNetworkedEntity("owner", nil) != LocalPlayer()) then
			numFireCars = numFireCars + 1
		end
	end
	
	if (!LocalPlayer():IsBronze() && numFireCars >= GAMEMODE.MaxBusses) then
		GAMEMODE.DialogPanel:SetDialog("Sorry, but all of the busses have been taken out on duty.\n\n(All busses are taken.  Please wait until someone who is using one quits the job, or get VIP benefits.)")
		
		GAMEMODE.DialogPanel:AddDialog("Okay, I'll check back later.", LEAVE_DIALOG)	
	else
		GAMEMODE.DialogPanel:SetDialog("Sure, here are the keys.")
		
		RunConsoleCommand('perp_bd_cha')
		
		GAMEMODE.DialogPanel:AddDialog("Thank you, sir!", LEAVE_DIALOG)		
	end
end

GAMEMODE:LoadNPC(NPC)