

local NPC = {};

NPC.Name = "Dealership";
NPC.ID = 92;

NPC.Model = Model("models/players/perp2/m_2_06.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(5533, -4729, 65); 
NPC.Angles = Angle(0, 90, 0);
NPC.ShowChatBubble = "VIP";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.DialogPanel:SetDialog("Welcome, Would you like to test drive a car?");
	
	GAMEMODE.DialogPanel:AddDialog("I sure would!", NPC.ShowCars)
	GAMEMODE.DialogPanel:AddDialog("Maybe later.", LEAVE_DIALOG)
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.ShowCars ( )
	GAMEMODE.ShowDealershipTestView();
	LEAVE_DIALOG();
end

GAMEMODE:LoadNPC(NPC);