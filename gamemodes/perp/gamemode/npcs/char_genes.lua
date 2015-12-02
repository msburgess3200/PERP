

local NPC = {};

NPC.Name = "Genetec";
NPC.ID = 15;

NPC.Model = Model("models/players/perp2/m_4_01.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector(-9687.8604, 9193.0713, 72.0313);
NPC.Angles = Angle(0, 90, 0.000000);

NPC.ShowChatBubble = "Normal";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.DialogPanel:SetDialog("Welcome to GeneTech.");
		
	GAMEMODE.DialogPanel:AddDialog('What do you guys do around here?', NPC.What)
	GAMEMODE.DialogPanel:AddDialog("", LEAVE_DIALOG)

	GAMEMODE.DialogPanel:Show();
end

function NPC.What ( )
	GAMEMODE.DialogPanel:SetDialog("We manipulate your genes to allow you to choose what you'll be adept at. We can also insert specialized genes into your genome to allow you to be skilled in multiple fields.");
		
	GAMEMODE.DialogPanel:AddDialog('Sounds expensive. How much are we talking?', NPC.Cost)
	GAMEMODE.DialogPanel:AddDialog("I doubt I'm rich enough for this.", LEAVE_DIALOG)
end

function NPC.Cost ( )
	local cost = (((GAMEMODE.MaxGenes - 5) - (GAMEMODE.MaxGenes - LocalPlayer():GetNumGenes())) + 1) * GAMEMODE.NewGenePrice

	GAMEMODE.DialogPanel:SetDialog("Yes, it is quite. This cutting-edge technology will cost you no less than " .. DollarSign() .. GAMEMODE.GeneResetPrice .. " dollars to reset your genome, and " .. DollarSign() .. cost .. " to insert new genes. Also, every time we insert new genes, it will get more difficult, raising the price. We only take check or debit card.\n\n(This cost will be taken out of your bank account.)");

	GAMEMODE.DialogPanel:AddDialog("That's nothing! Let me manipulate my genome, please! (Reset your genes)", NPC.Reset);
	GAMEMODE.DialogPanel:AddDialog("That's nothing! Add some new genes to me, please! (Add more gene points)", NPC.Add);
	GAMEMODE.DialogPanel:AddDialog("<Whistle> I think I should leave now.", LEAVE_DIALOG);
end

function NPC.Add ( )
	local cost = (((GAMEMODE.MaxGenes - 5) - (GAMEMODE.MaxGenes - LocalPlayer():GetNumGenes())) + 1) * GAMEMODE.NewGenePrice
	
	if LocalPlayer():GetBank() >= cost then
		if LocalPlayer():GetNumGenes() < GAMEMODE.MaxGenes then
			GAMEMODE.DialogPanel:SetDialog("<5 Hours Later> There you go, sir. Enjoy your new mastery of any field desirable.");
			
			RunConsoleCommand('perp_s_b', LocalPlayer():UniqueID());
			
			GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
			
			LocalPlayer():SetPrivateInt("gpoints", LocalPlayer():GetPrivateInt("gpoints", 0) + 1, true);
			LocalPlayer():TakeBank(cost);
		else
			GAMEMODE.DialogPanel:SetDialog("Ahh, it appears our technicians cannot add any more genes, as we've already stuffed your genome to it's maximum. Sorry.");
			
			GAMEMODE.DialogPanel:AddDialog("That's lame.", LEAVE_DIALOG);
		end
	else
		GAMEMODE.DialogPanel:SetDialog("What do you mean that's nothing? You don't even have that much in your bank!\n\n(You can only pay for this out of your bank account.)");
				
		GAMEMODE.DialogPanel:AddDialog("Dang, you caught me.", LEAVE_DIALOG);
	end
end

function NPC.Reset ( )	
	if LocalPlayer():GetBank() >= GAMEMODE.GeneResetPrice then
		GAMEMODE.DialogPanel:SetDialog("<5 Hours Later> There you go, sir. Should be ready for you to choose your adeptness.");
		
		RunConsoleCommand('perp_s_r');
		
		LocalPlayer():SetPrivateInt("gpoints", LocalPlayer():GetNumGenes(), true);
		LocalPlayer():TakeBank(GAMEMODE.GeneResetPrice);
		LocalPlayer():ResetGenes(true);
		
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("What do you mean that's nothing? You don't even have that much!\n\n(You can only pay for this out of your bank account.)");
				
		GAMEMODE.DialogPanel:AddDialog("Dang, you caught me.", LEAVE_DIALOG);
	end
end


GAMEMODE:LoadNPC(NPC);