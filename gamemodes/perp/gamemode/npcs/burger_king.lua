

local NPC = {};

NPC.Name = "Burger King Shop";
NPC.ID = 34;

NPC.Model = Model("models/players/perp2/m_2_06.mdl");
NPC.Invisible = false;

NPC.Location = Vector(-7400.572754, -6607.649414, 72.0313);
NPC.Angles = Angle(0, 90, 0.000000);
NPC.ShowChatBubble = true;

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.OpenShop(4);
end

//GAMEMODE:LoadNPC(NPC);