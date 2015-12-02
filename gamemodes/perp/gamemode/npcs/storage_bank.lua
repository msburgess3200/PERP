


local NPC = {};

NPC.Name = "Storage Bank";
NPC.ID = 36;

NPC.Model = Model("models/players/perp2/m_2_06.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-7580, -7840, 72);
NPC.Angles = Angle(0, 0, 0);
NPC.ShowChatBubble = "Normal";


NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.OpenBank();
end

GAMEMODE:LoadNPC(NPC);