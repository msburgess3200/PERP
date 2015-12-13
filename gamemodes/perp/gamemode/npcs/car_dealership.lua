

local NPC = {};

NPC.Name = "Dealership";
NPC.ID = 4;

NPC.Model = Model("models/players/perp2/m_2_06.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector( 5002.4219, -3550.6282, 228.0313 ); 
NPC.Angles = Angle(0, 271.7734, 0 );
NPC.ShowChatBubble = "VIP";

NPC.Sequence = 228;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.DialogPanel:SetDialog("Welcome to Big Bills Hell's used cars!");
	
	GAMEMODE.DialogPanel:AddDialog("Hey! I'm looking for a new car.", NPC.NewCar)
	GAMEMODE.DialogPanel:AddDialog("Hello. I'd like to sell a car. (VIP's Only)", NPC.SellCar)
	GAMEMODE.DialogPanel:AddDialog("You can't help me. Nobody can help me.", LEAVE_DIALOG)
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.NewCar ( )
	GAMEMODE.DialogPanel:SetDialog("You've come to the right place!");
	
	GAMEMODE.DialogPanel:AddDialog("Alright, show me your stock.", NPC.ShowCars)
	GAMEMODE.DialogPanel:AddDialog("Do you accept cash payments?", NPC.NoCash)
	GAMEMODE.DialogPanel:AddDialog("Ahh, I don't have time for this right now, sorry.", LEAVE_DIALOG)
end

function NPC.SellCar ( )
	if (LocalPlayer():GetLevel() > 100) then
		GAMEMODE.DialogPanel:SetDialog("Sorry this feature is for VIP players only. Please donate if you would like to sell cars")
	
		GAMEMODE.DialogPanel:AddDialog("Oh dang, I'll go donate right away.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Great! How can i help you?");
	
		GAMEMODE.DialogPanel:AddDialog("Alright, tell me what their're worth!", NPC.ShowSellCars)
		GAMEMODE.DialogPanel:AddDialog("Ahh, I don't have time for this right now, sorry.", LEAVE_DIALOG)
	end
end

function NPC.ShowCars ( )
	GAMEMODE.ShowDealershipView();
	LEAVE_DIALOG();
end

function NPC.ShowSellCars ( )
	GAMEMODE.ShowSellView();
	LEAVE_DIALOG()
end

function NPC.NoCash ( )
	GAMEMODE.DialogPanel:SetDialog("Sorry, we only accept direct bank transactions.");

	GAMEMODE.DialogPanel:AddDialog("Alright, show me your stock.", NPC.ShowCars)
	GAMEMODE.DialogPanel:AddDialog("Sorry i have to go.", LEAVE_DIALOG)
end

GAMEMODE:LoadNPC(NPC);