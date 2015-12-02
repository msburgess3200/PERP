


local NPC = {};

NPC.Name = "Home Furnishings";
NPC.ID = 7;

NPC.Model = Model("models/players/perp2/f_1_03.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-6823.4462, -10029.9140, 71.0312);
NPC.Angles = Angle(0, 0, 0.000000);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.OpenShop(1);
end

GAMEMODE:LoadNPC(NPC);