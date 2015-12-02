

local NPC = {};

NPC.Name = "Ace Hardware";
NPC.ID = 17;

NPC.Model = Model("models/players/perp2/m_6_01.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-6841.4838, -10456.2119, 71.0312);
NPC.Angles = Angle(0, 0, 0.000000);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.OpenShop(2);
end

GAMEMODE:LoadNPC(NPC);