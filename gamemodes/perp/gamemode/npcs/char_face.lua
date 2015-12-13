


local NPC = {};

NPC.Name = "Katie's Facials";
NPC.ID = 8;

NPC.Model = Model("models/players/perp2/f_1_01.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-5017.1855, -6431.2847, 72.0313); 
NPC.Angles = Angle(0, 86.8871, 0);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 228;

// This is always local player.
function NPC.OnTalk ( )
	if (LocalPlayer():Team() == TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("You look like you could use a facial. Have a seat!");
		
		GAMEMODE.DialogPanel:AddDialog('Er... Okay... How much will this cost?', NPC.Cost)
		GAMEMODE.DialogPanel:AddDialog('What are you trying to say?', NPC.Lolz)
		GAMEMODE.DialogPanel:AddDialog("No thank you.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("I don't think any ammount of facials can fix that.\n\n(You must be a citizen to use this feature.)");
		
		GAMEMODE.DialogPanel:AddDialog("Oh... Okay...", LEAVE_DIALOG)
	end
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.Lolz ( )
	GAMEMODE.DialogPanel:SetDialog("Oh nothing, nothing! So how about it, want a facial?");
	
	GAMEMODE.DialogPanel:AddDialog("How much is this gonna cost me?", NPC.Cost)
	GAMEMODE.DialogPanel:AddDialog("No thank you.", LEAVE_DIALOG)
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.Cost ( )
	GAMEMODE.DialogPanel:SetDialog("We'll give you a complete facial for only " .. DollarSign() .. GAMEMODE.FacialPrice .. ". Is that a good deal, or what?");
	
	GAMEMODE.DialogPanel:AddDialog("Alright, let's do it!", NPC.DoIt)
	GAMEMODE.DialogPanel:AddDialog("That seems a little expensive... Nevermind.", LEAVE_DIALOG)
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.DoIt ( )
	if LocalPlayer():GetCash() >= GAMEMODE.FacialPrice then
		LEAVE_DIALOG();
		LocalPlayer():TakeCash(GAMEMODE.FacialPrice, true);
		GAMEMODE.Select_Face();
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry, but it appears you can't afford my services... Come back when you have a few dollars to spare.");
		
		GAMEMODE.DialogPanel:AddDialog("Alright, fine.", LEAVE_DIALOG);
	end
end

GAMEMODE:LoadNPC(NPC);