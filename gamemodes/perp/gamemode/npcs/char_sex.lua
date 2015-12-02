


local NPC = {};

NPC.Name = "Dr. M. Ingebag";
NPC.ID = 10;

NPC.Model = Model("models/kleiner.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-9942.3193, 9720.0342, 72.0313);
NPC.Angles = Angle(0, 178.9973, 0.000000);

NPC.ShowChatBubble = "Normal";

NPC.Sequence = 1;

// This is always local player.
function NPC.OnTalk ( )
	if (LocalPlayer():Team() == TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("Hello. If you're sick of your private parts being what they are, or desire to sing in a different tone, you've come to the right place!");
		
		GAMEMODE.DialogPanel:AddDialog('Can you fix me doc? I want a sex change!', NPC.AreYouSure)
		GAMEMODE.DialogPanel:AddDialog('Are you suggesting sex change?', NPC.What)
		GAMEMODE.DialogPanel:AddDialog("I think I should go...", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("What sex are you, exactly?\n\n(You must be a citizen to use this feature.)");
		
		GAMEMODE.DialogPanel:AddDialog("What?", LEAVE_DIALOG)
	end
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.What ( )
	GAMEMODE.DialogPanel:SetDialog("Of course! It's all the rage nowadays.");
		
	GAMEMODE.DialogPanel:AddDialog('Sounds intriguing... How much will this cost?', NPC.AreYouSure)
	GAMEMODE.DialogPanel:AddDialog("I think I'll be leaving now...", LEAVE_DIALOG)
end

function NPC.AreYouSure ( )
	GAMEMODE.DialogPanel:SetDialog("Well, seeing as the surgery is very intricate and long, we've been forced to up our price. We are now charging " .. DollarSign() .. GAMEMODE.SexChangePrice .. " for the whole surgery.");
	
	if LocalPlayer():GetSex() == SEX_FEMALE then
		GAMEMODE.DialogPanel:AddDialog("Make me a man!", NPC.LetsGo);
	else
		GAMEMODE.DialogPanel:AddDialog("Make me a woman!", NPC.LetsGo);
	end
		
	GAMEMODE.DialogPanel:AddDialog(GAMEMODE.SexChangePrice .. " DOLLARS? ARE YOU CRAZY?", LEAVE_DIALOG)
end

function NPC.LetsGo ( )
	if LocalPlayer():GetCash() >= GAMEMODE.SexChangePrice then
		if LocalPlayer():GetSex() == SEX_FEMALE then
			GAMEMODE.DialogPanel:SetDialog("Thanks for the money! Enjoy your new manly parts. You may want to go get a facial, though... No offense, of course.");
		else
			GAMEMODE.DialogPanel:SetDialog("Thanks for the money! Enjoy your new girly parts. You may want to go get a facial, though... No offense, of course.");
		end
		
		RunConsoleCommand('perp_cs');
		LocalPlayer():TakeCash(GAMEMODE.SexChangePrice, true);
		
		GAMEMODE.DialogPanel:AddDialog("Thanks, doc!", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears you can't afford the surgery after all. Come back when you've got a little cash to spare!");
		
		GAMEMODE.DialogPanel:AddDialog("If only I had medical insurance...", LEAVE_DIALOG);
	end
end


GAMEMODE:LoadNPC(NPC);