
local NPC = {};

NPC.Name = "ATM Machine";
NPC.ID = 50;

NPC.Model = Model("models/PERP2/bank_atm/bank_atm.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = {Vector(-9876, 9406, 73)};
NPC.Angles = {Angle(0, 0, 0)};

NPC.ShowChatBubble = false;

NPC.Sequence = -1;

// This is always local player.
function NPC.OnTalk ( )
	GAMEMODE.DialogPanel:SetDialog("What would you like to do?");
	
	NPC.MakeDialogButtons();
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.MakeDialogButtons ( )
	GAMEMODE.DialogPanel:AddDialog("Check Balance", NPC.CheckBalance)
	GAMEMODE.DialogPanel:AddDialog("Deposit", NPC.Deposit)
	GAMEMODE.DialogPanel:AddDialog("Withdraw", NPC.Withdraw)
	GAMEMODE.DialogPanel:AddDialog("Cancel", LEAVE_DIALOG)
end

function NPC.CheckBalance ( )
	GAMEMODE.DialogPanel:SetDialog("Current checking account balance: " .. DollarSign() .. LocalPlayer():GetBank() .. "\n\nWhat would you like to do?");
	
	NPC.MakeDialogButtons();
end

// Deposit Functions
function NPC.Deposit ( )
	GAMEMODE.DialogPanel:SetDialog("How much would you like to deposit?");
	
	if (LocalPlayer():GetCash() >= 100) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "100", NPC.Deposit_100) end
	if (LocalPlayer():GetCash() >= 1000) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "1000", NPC.Deposit_1000) end
	if (LocalPlayer():GetCash() >= 5000) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "5000", NPC.Deposit_5000) end
	
	local wouldShow = LocalPlayer():GetCash();
	if (wouldShow != 0 && wouldShow != 100 && wouldShow != 1000 && wouldShow != 5000) then
		GAMEMODE.DialogPanel:AddDialog(DollarSign() .. LocalPlayer():GetCash(), NPC.Deposit_All)
	end
	
	GAMEMODE.DialogPanel:AddDialog("Different Amount", NPC.Deposit_Custom)
	GAMEMODE.DialogPanel:AddDialog("Cancel", LEAVE_DIALOG)
end

function NPC.Deposit_Final ( ammount )
	if (ammount <= 0) then
		GAMEMODE.DialogPanel:SetDialog("A deposit must be a positive integer.\n\nWhat would you like to do?");
	elseif (LocalPlayer():GetCash() >= ammount) then
		RunConsoleCommand("perp_b_d", ammount);
		
		LocalPlayer():TakeCash(ammount);
		LocalPlayer():AddBank(ammount);
		
		GAMEMODE.DialogPanel:SetDialog("Deposited " .. DollarSign() .. ammount .. ".\n\nWhat would you like to do?");
	else
		GAMEMODE.DialogPanel:SetDialog("You do not have enough cash to deposit " .. DollarSign() .. ammount .. ".\n\nWhat would you like to do?");
	end
	
	NPC.MakeDialogButtons();
end

function NPC.Deposit_100 ( ) NPC.Deposit_Final(100); end
function NPC.Deposit_1000 ( ) NPC.Deposit_Final(1000); end
function NPC.Deposit_5000 ( ) NPC.Deposit_Final(5000); end
function NPC.Deposit_All ( ) NPC.Deposit_Final(LocalPlayer():GetCash()); end

function NPC.Deposit_Custom( )
	ShowBankWindow("ATM - Deposit", "Amount To Deposit", "Deposit", NPC.Deposit_Final)
end

// Withdraw Functions
function NPC.Withdraw ( )
	GAMEMODE.DialogPanel:SetDialog("How much would you like to withdraw?");
	
	local canHoldMore = MAX_CASH - LocalPlayer():GetCash();
	
	if (LocalPlayer():GetBank() >= 100 && canHoldMore >= 100) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "100", NPC.Withdraw_100) end
	if (LocalPlayer():GetBank() >= 1000 && canHoldMore >= 1000) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "1000", NPC.Withdraw_1000) end
	if (LocalPlayer():GetBank() >= 5000 && canHoldMore >= 5000) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. "5000", NPC.Withdraw_5000) end
	
	local wouldShow = math.Clamp(LocalPlayer():GetBank(), 0, canHoldMore);
	if (wouldShow != 0 && wouldShow != 100 && wouldShow != 1000 && wouldShow != 5000) then GAMEMODE.DialogPanel:AddDialog(DollarSign() .. wouldShow, NPC.Withdraw_Max) end
	
	GAMEMODE.DialogPanel:AddDialog("Different Amount", NPC.Withdraw_Custom)
	GAMEMODE.DialogPanel:AddDialog("Cancel", LEAVE_DIALOG)
end

function NPC.Withdraw_Final ( ammount )
	if (ammount <= 0) then
		GAMEMODE.DialogPanel:SetDialog("A withdraw must be a positive integer.\n\nWhat would you like to do?");
	elseif (LocalPlayer():GetBank() >= ammount) then
		if (LocalPlayer():GetCash() + ammount > MAX_CASH) then
			GAMEMODE.DialogPanel:SetDialog("You can only hold a maximum of " .. DollarSign() .. MAX_CASH .. ".\n\nWhat would you like to do?");
		else
			RunConsoleCommand("perp_b_w", ammount);
			
			LocalPlayer():GiveCash(ammount);
			LocalPlayer():TakeBank(ammount);
			
			GAMEMODE.DialogPanel:SetDialog("Withdrew " .. DollarSign() .. ammount .. ".\n\nWhat would you like to do?");
		end
	else
		GAMEMODE.DialogPanel:SetDialog("You do not have enough money in your bank account to withdraw " .. DollarSign() .. ammount .. ".\n\nWhat would you like to do?");
	end
	
	NPC.MakeDialogButtons();
end

function NPC.Withdraw_100 ( ) NPC.Withdraw_Final(100); end
function NPC.Withdraw_1000 ( ) NPC.Withdraw_Final(1000); end
function NPC.Withdraw_5000 ( ) NPC.Withdraw_Final(5000); end
function NPC.Withdraw_Max ( ) NPC.Withdraw_Final(math.Clamp(LocalPlayer():GetBank(), 0, MAX_CASH - LocalPlayer():GetCash())); end

function NPC.Withdraw_Custom( )
	ShowBankWindow("ATM - Withdraw", "Amount To Withdraw", "Withdraw", NPC.Withdraw_Final)
end



GAMEMODE:LoadNPC(NPC);