


local NPC = {};

NPC.Name = "Realtor";
NPC.ID = 3;

NPC.Model = Model("models/players/perp2/f_1_02.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-7580, -7620, 72);
NPC.Angles = Angle(0, 0, 0.000000);
NPC.ShowChatBubble = "Normal";


NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.MakeRealtorScreen();
end

GAMEMODE:LoadNPC(NPC);