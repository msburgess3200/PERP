

local NPC = {};

NPC.Name = "Bartender";
NPC.ID = 23;

NPC.Model = Model("models/humans/suits2/male_04.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-7189.0312, -14183.5, 72.0313); 
NPC.Angles = Angle(0,0,0);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	if (LocalPlayer():Team() == TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:SetDialog("What can I get for you maybe a shot or a beer?");
		
		GAMEMODE.DialogPanel:AddDialog("I'll have  beer please.", LEAVE_DIALOG)
		GAMEMODE.DialogPanel:AddDialog('How about a shot?', LEAVE_DIALOG)
		GAMEMODE.DialogPanel:AddDialog("No thanks I'm just looking around.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Uhhh... I don't server government officials on duty.\n\n(You must be a citizen to use this feature.)");
		
		GAMEMODE.DialogPanel:AddDialog("Oh shi-...*Sneak away awkwardly*", LEAVE_DIALOG)
	end
	
	GAMEMODE.DialogPanel:Show();
end
/*local function MakeEffects ( )
		LocalPlayer():TakeCash(50);
		GAMEMODE.DialogPanel:AddDialog("*Doawns the shot and feels it taking effect*", LEAVE_DIALOG)
end
GAMEMODE:LoadNPC(NPC); */