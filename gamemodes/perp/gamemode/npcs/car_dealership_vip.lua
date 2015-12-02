///////////////////////////////
// © 2009-2010 Pulsar Effect //
//    All rights reserved    //
///////////////////////////////
// This material may not be  //
//   reproduced, displayed,  //
//  modified or distributed  //
// without the express prior //
// written permission of the //
//   the copyright holder.   //
///////////////////////////////


local NPC = {};

NPC.Name = "VIP Dealership";
NPC.ID = 14;

NPC.Model = Model("models/humans/suits2/male_04.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector( 5133.083008, -3550.066406, 228.031250 ); 
NPC.Angles = Angle(0, -90, 0);
NPC.ShowChatBubble = "VIP";

NPC.Sequence = 3;

// This is always local player.
function NPC.OnTalk ( )
	if (!LocalPlayer():IsBronze()) then
		GAMEMODE.DialogPanel:SetDialog("You don't seem to be a VIP. Sorry, I can't help you.");
		
		GAMEMODE.DialogPanel:AddDialog("How do I become a VIP?", NPC.HowVIP)
		GAMEMODE.DialogPanel:AddDialog("Fine, I'll go elsewhere.", LEAVE_DIALOG)
	else
		GAMEMODE.DialogPanel:SetDialog("Welcome to Big Bill Hell's used car dealership! I'm the one in charge of the VIP cars, how can I help you?");
		
		GAMEMODE.DialogPanel:AddDialog("Hey! I'm looking for a new car.", NPC.NewCar)
		GAMEMODE.DialogPanel:AddDialog("Hello. I'd like to sell a car.", NPC.SellCar)
		GAMEMODE.DialogPanel:AddDialog("I seemed to lost my car. Have you seen it around?", NPC.LostCar)
		GAMEMODE.DialogPanel:AddDialog("Uhm, nevermind I'll be going now.", LEAVE_DIALOG)
	end;
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.NewCar ( )
	GAMEMODE.DialogPanel:SetDialog("You've come to the right place! Let me show you around.");
	
	GAMEMODE.DialogPanel:AddDialog("Alright, show me your stock.", NPC.ShowCars)
	GAMEMODE.DialogPanel:AddDialog("Do you accept cash payments?", NPC.NoCash)
	GAMEMODE.DialogPanel:AddDialog("Ahh, I don't have time for this right now, sorry.", LEAVE_DIALOG)
end

function NPC.SellCar ( )
	GAMEMODE.DialogPanel:SetDialog("That's understandable, well I can assure a price for you.");
	
	GAMEMODE.DialogPanel:AddDialog("Alright, tell me what their're worth!", NPC.ShowSellCars)
	GAMEMODE.DialogPanel:AddDialog("Ahh, I don't have time for this right now, sorry.", LEAVE_DIALOG)
end

function NPC.ShowCars ( )
	GAMEMODE.ShowVIPDealershipView();
	LEAVE_DIALOG();
end

function NPC.ShowSellCars ( )
	GAMEMODE.ShowSellView();
	LEAVE_DIALOG()
end

function NPC.NoCash ( )
	GAMEMODE.DialogPanel:SetDialog("Sorry, we only accept direct bank transactions. Most people don't carry around enough money in their wallets, anyway.");

	GAMEMODE.DialogPanel:AddDialog("Alright, show me your stock.", NPC.ShowCars)
	GAMEMODE.DialogPanel:AddDialog("Ahh, I don't have time for this right now, sorry.", LEAVE_DIALOG)
end

function NPC.LostCar ( )
	GAMEMODE.DialogPanel:SetDialog("I haven't seen it, but have you checked the parking garage?\n\n(You can claim your previously purchased vehicles at the parking garage.)");

	GAMEMODE.DialogPanel:AddDialog("Oh yah, I remember now! Thanks!", LEAVE_DIALOG)
end

function NPC.HowVIP ( )
	GAMEMODE.DialogPanel:SetDialog("To become VIP, simply visit www.integralgaming.net to donate!");

	GAMEMODE.DialogPanel:AddDialog("Oh yah, I remember now! Thanks!", LEAVE_DIALOG)
end

GAMEMODE:LoadNPC(NPC);