

local NPC = {};

NPC.Name = "Ching's Convenience Store";
NPC.ID = 18;

NPC.Model = Model("models/players/perp2/m_5_06.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-7495.572754, -6607.649414, 72.0313);
NPC.Angles = Angle(0, 90, 0.000000);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.OpenShop(3);
end

GAMEMODE:LoadNPC(NPC);