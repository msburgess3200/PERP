

local NPC = {};

NPC.Name = "Chop Shop";
NPC.ID = 63;

NPC.Model = Model("models/players/perp2/m_1_02.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(3859, 6658, 72);
NPC.Angles = Angle(0, 180, 0);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 228;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.DialogPanel:SetDialog("'Ay G, what's happenin?");
	
	GAMEMODE.DialogPanel:AddDialog('Hey man, will you take this car off my hands?', NPC.Chop)
	GAMEMODE.DialogPanel:AddDialog("Nevermind...", LEAVE_DIALOG)
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.Chop ( )
	local stolenVehicle;
	
	for k, ent in pairs(ents.FindInSphere(Vector(3859, 6658, 72), 250)) do
		if ent:IsValid() and ent:IsVehicle() and ent:GetClass() == "prop_vehicle_jeep" then
			stolenVehicle = ent;
		end
	end
	
	if (!stolenVehicle || !IsValid(stolenVehicle)) then
		GAMEMODE.DialogPanel:SetDialog("Uhm, what car?");
		GAMEMODE.DialogPanel:AddDialog("Oh, right. Let me go get it.", LEAVE_DIALOG);
		
		return;
	end
	
	GAMEMODE.DialogPanel:SetDialog("Yeah I could do that.");
	
	GAMEMODE.DialogPanel:AddDialog("Sounds fair lets do it.", NPC.ChopCar)
	GAMEMODE.DialogPanel:AddDialog("Nevermind.", LEAVE_DIALOG)
end

function NPC.ChopCar( )
	RunConsoleCommand("perp_chop_car")
	LEAVE_DIALOG()
end

GAMEMODE:LoadNPC(NPC);