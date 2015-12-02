


local NPC = {};

NPC.Name = "Medic";
NPC.ID = 19;

NPC.Model = Model("models/players/perp2/f_1_06.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-3913.059326, -7156.529297, 198);
NPC.Angles = Angle(0, 90, 0);

NPC.ShowChatBubble = "Normal";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
local NumberOfMedics = team.NumPlayers(TEAM_MEDIC);

	if NumberOfMedics > 0 then
		GAMEMODE.DialogPanel:SetDialog("It seems there is already a medic, I suggest you seek them for assistance.");
		
		GAMEMODE.DialogPanel:AddDialog("Oh, sorry.", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Hi, im the local medic. I'll be here in the bank until sgt.sickness adds a hospital to the map! Either way, I can heal you to full health or fix a broken leg.");
		
		GAMEMODE.DialogPanel:AddDialog("Can you restore my health?", NPC.HealPrice);
		GAMEMODE.DialogPanel:AddDialog("Can you fix my leg?", NPC.LegFixPrice);
		GAMEMODE.DialogPanel:AddDialog("No thanks...", LEAVE_DIALOG);
	end;
	
	GAMEMODE.DialogPanel:Show();
	
end

function NPC.HealPrice ( )
	GAMEMODE.DialogPanel:SetDialog("It will cost " .. DollarSign() .. COST_FOR_HEALTHRESET .. " to restore your health. Do you wish to proceed?");

	GAMEMODE.DialogPanel:AddDialog("Lets do it!", NPC.PerformHeal)
	GAMEMODE.DialogPanel:AddDialog("Too expensive!", LEAVE_DIALOG)
end;

function NPC.PerformHeal ( )
	if (LocalPlayer():GetCash() < COST_FOR_HEALTHRESET) then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you can pay for all of this?");
		GAMEMODE.DialogPanel:AddDialog("Not exactly...", LEAVE_DIALOG)
		
		return;
	end
	
	sound.Play(Sound('items/smallmedkit1.wav'), NPC.Location, 100, 100)
	RunConsoleCommand("perp2_encrypt3D_medic_resetHealth");
	LocalPlayer():TakeCash(COST_FOR_HEALTHRESET, true);
	GAMEMODE.DialogPanel:SetDialog("<5 Minutes Later> There you go, you should be fully healed now. That'll be " .. DollarSign() .. COST_FOR_HEALTHRESET .. ".");
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
	
end;

function NPC.LegFixPrice ( )
	GAMEMODE.DialogPanel:SetDialog("It will cost " .. DollarSign() .. COST_FOR_LEGFIX .. " to fix your legs. Do you wish to proceed?");

	GAMEMODE.DialogPanel:AddDialog("Lets do it!", NPC.PerformLegFix)
	GAMEMODE.DialogPanel:AddDialog("Too expensive!", LEAVE_DIALOG)
end;

function NPC.PerformLegFix ( )
	if (LocalPlayer():GetCash() < COST_FOR_LEGFIX) then
		GAMEMODE.DialogPanel:SetDialog("Are you sure you can pay for all of this?");
		GAMEMODE.DialogPanel:AddDialog("Not exactly...", LEAVE_DIALOG)
		
		return;
	end
	
	sound.Play(Sound('items/smallmedkit1.wav'), NPC.Location, 100, 100)
	RunConsoleCommand("perp2_encrypt3D_medic_resetCrippled");
	LocalPlayer():TakeCash(COST_FOR_LEGFIX, true);
	GAMEMODE.DialogPanel:SetDialog("<45 Minutes Later> There you go, the surgery went well. The total cost was " .. DollarSign() .. COST_FOR_LEGFIX .. ".");
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
end;

GAMEMODE:LoadNPC(NPC);