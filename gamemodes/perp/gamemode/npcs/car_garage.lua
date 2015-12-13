


local NPC = {};

NPC.Name = "Garage";
NPC.ID = 5;

NPC.Model = Model("models/players/perp2/f_1_02.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = {Vector(-5317.2427, -10296.3262, 71.0313), Vector(5320.523926, -4728.700195, 128.031250 - 63)};
NPC.Angles = {Angle(0, 0, 0), Angle(0,90,0)};
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 228;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.DialogPanel:SetDialog("Can I help you?");
	
	if (LocalPlayer():Team() == TEAM_CITIZEN) then
		GAMEMODE.DialogPanel:AddDialog("Yes, I've come to claim my car.", NPC.ClaimCar)
		GAMEMODE.DialogPanel:AddDialog("I want to change cars, please.", NPC.NewCar)
		GAMEMODE.DialogPanel:AddDialog("I think I'm lost...", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:AddDialog("No.", LEAVE_DIALOG)
	end
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.NewCar ( )
		GAMEMODE.ShowGarageView();
		LEAVE_DIALOG();
end

function NPC.ClaimCar ( )
	local CarID = LocalPlayer():GetLastCar();
	//LocalPlayer():Notify(""..CarID.."");
	if LocalPlayer():GetLastCar() == 0 or LocalPlayer():GetLastCar() == nil or LocalPlayer():GetLastCar() == "" then
		GAMEMODE.DialogPanel:SetDialog("It doesn't seem like you were in a car recently.\n(Use Change cars menu or buy a car.)");
		
		GAMEMODE.DialogPanel:AddDialog("Hmm, ok then.", LEAVE_DIALOG)
	else
		RunConsoleCommand('perp_v_c', CarID);
		LEAVE_DIALOG();
	end
end

function NPC.DoFuel ( )
	local CarID = tostring(LocalPlayer():GetLastCar());
	if LocalPlayer():GetCash() < 50 then
		GAMEMODE.DialogPanel:SetDialog("It seems you don't have enough cash on you.");
		
		GAMEMODE.DialogPanel:AddDialog("Damn, I will be back when I get the cash.", LEAVE_DIALOG)
	else
		LocalPlayer():TakeCash(50);
		RunConsoleCommand('perp_c_c', 50);
		RunConsoleCommand('perp_v_c', CarID);
		GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG)
	end
end

function NPC.DoFix ( )
	local CarID = tostring(LocalPlayer():GetLastCar());
	if LocalPlayer():GetCash() < 2000 then 
		GAMEMODE.DialogPanel:SetDialog("It seems you don't have enough cash on you.");

		GAMEMODE.DialogPanel:AddDialog("Damn, I will be back when I get the cash.", LEAVE_DIALOG);
	else
		RunConsoleCommand('perp_c_c', 2000);
		LocalPlayer():SetCarState(0);
		LocalPlayer():TakeCash(2000);
		RunConsoleCommand('perp_v_c', CarID);
		GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG);
	end
end
GAMEMODE:LoadNPC(NPC);

function MiniDebug(Ply, Cmd, Args)
	print (LocalPlayer():GetLastCar())
end
concommand.Add("perp_lastcar_debug", MiniDebug)