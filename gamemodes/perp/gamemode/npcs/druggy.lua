


local NPC = {};

NPC.Name = "Druggy";
NPC.ID = 16;

NPC.Model = Model("models/players/perp2/m_9_02.mdl");
NPC.Invisible = false; // Used for ATM Machines, Casino Tables, etc.

NPC.Location = Vector( -9377.741211, -9595.868164, 74.0313);
NPC.Angles = Angle(0, 130, 0);
NPC.ShowChatBubble = "Normal";

NPC.Sequence = 8;

// This is always local player.
function NPC.OnTalk ( )
	if LocalPlayer():Team() == TEAM_CITIZEN then
		GAMEMODE.DialogPanel:SetDialog("< Glances Around >\n\nHey, what can I get for ya?");
		
		GAMEMODE.DialogPanel:AddDialog("I got some product to sell...", NPC.BuyStuff);
		GAMEMODE.DialogPanel:AddDialog("Got anything good?", NPC.SellStuff);
	else
		GAMEMODE.DialogPanel:SetDialog("Hello.");
		
		GAMEMODE.DialogPanel:AddDialog("Err... Hello.", LEAVE_DIALOG);
	end
	
	GAMEMODE.DialogPanel:Show();
end

function NPC.BuyStuff ( )
	local ID = GetGlobalInt('perp_druggy_buy', 0);
	
	if (ID == 1 || ID == 2 || ID == 3 || ID == 4) then
		GAMEMODE.DialogPanel:SetDialog("Yah, I got some spare cash. What are you trying to sell?");
		
		GAMEMODE.DialogPanel:AddDialog("I cooked up some meth in my garage you need any??", NPC.BuyStuff_Meth);
		GAMEMODE.DialogPanel:AddDialog("I'm looking to sell some green.", NPC.BuyStuff_Weed);
		GAMEMODE.DialogPanel:AddDialog("I grew some awesome cocain I need rid of.", NPC.BuyStuff_Coke);
		GAMEMODE.DialogPanel:AddDialog("I got some magical delights that needs a proper home.", NPC.BuyStuff_Shrooms);
		GAMEMODE.DialogPanel:AddDialog("Nevermind.", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Naw, I don't have enough cash at the moment, sorry. Come back by later and we can work out a deal.");
		
		GAMEMODE.DialogPanel:AddDialog("Alright, I'll stop by later.", LEAVE_DIALOG);
	end
end

function NPC.BuyStuff_Meth ( )
	local ID = GetGlobalInt('perp_druggy_buy', 0);
		
	if (ID == 2) then
		GAMEMODE.DialogPanel:SetDialog("Yah, I'll buy some of that. " .. DollarSign() .. ITEM_DATABASE[10].Cost .. " each.");
		
		GAMEMODE.DialogPanel:AddDialog("Sounds reasonable.", NPC.BuyStuff_Meth_Confirm);
		GAMEMODE.DialogPanel:AddDialog("Are you joking?", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry man, I have plenty of that shit. Not enough demand around here. Come back later.");
		
		GAMEMODE.DialogPanel:AddDialog("Fine, I'll be back.", LEAVE_DIALOG);
	end
end

function NPC.BuyStuff_Meth_Confirm ( )
	RunConsoleCommand("perp_sd_m");
	
	local totalEarned = ITEM_DATABASE[10].Cost * LocalPlayer():GetItemCount(10);
	
	LocalPlayer():GiveCash(totalEarned);
	
	for k, v in pairs(GAMEMODE.PlayerItems) do
		if (v.ID == 10) then
			GAMEMODE.PlayerItems[k] = nil;
			GAMEMODE.InventoryBlocks_Linear[k]:GrabItem();
		end
	end
	
	GAMEMODE.DialogPanel:SetDialog("Thanks, man. Here's your " .. DollarSign() .. totalEarned .. ".");
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
end

function NPC.BuyStuff_Weed ( )
	local ID = GetGlobalInt('perp_druggy_buy', 0);
		
	if (ID == 1) then
		GAMEMODE.DialogPanel:SetDialog("Yah, I'll buy some of that. " .. DollarSign() .. ITEM_DATABASE[13].Cost .. " each.");
		
		GAMEMODE.DialogPanel:AddDialog("Sounds reasonable.", NPC.BuyStuff_Weed_Confirm);
		GAMEMODE.DialogPanel:AddDialog("Are you joking?", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry man, I have plenty of that shit. Not enough demand around here. Come back later.");
		
		GAMEMODE.DialogPanel:AddDialog("Fine, I'll be back.", LEAVE_DIALOG);
	end
end

function NPC.BuyStuff_Weed_Confirm ( )
	RunConsoleCommand("perp_sd_w");
	
	local totalEarned = ITEM_DATABASE[13].Cost * LocalPlayer():GetItemCount(13);
	
	LocalPlayer():GiveCash(totalEarned);
	
	for k, v in pairs(GAMEMODE.PlayerItems) do
		if (v.ID == 13) then
			GAMEMODE.PlayerItems[k] = nil;
			GAMEMODE.InventoryBlocks_Linear[k]:GrabItem();
		end
	end
	
	GAMEMODE.DialogPanel:SetDialog("Thanks, man. Here's your " .. DollarSign() .. totalEarned .. ".");
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
end

function NPC.BuyStuff_Shrooms ( )
	local ID = GetGlobalInt('perp_druggy_buy', 0);
		
	if (ID == 3) then
		GAMEMODE.DialogPanel:SetDialog("Oh Shi- you got the magical juju food? " .. DollarSign() .. (ITEM_DATABASE[83].Cost-100) .. " each.");
		
		GAMEMODE.DialogPanel:AddDialog("Sounds reasonable.", NPC.BuyStuff_Shrooms_Confirm);
		GAMEMODE.DialogPanel:AddDialog("Are you joking?", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry man, I have plenty of that shit. Not enough demand around here. Come back later.");
		
		GAMEMODE.DialogPanel:AddDialog("Fine, I'll be back.", LEAVE_DIALOG);
	end
end

function NPC.BuyStuff_Shrooms_Confirm ( )
	RunConsoleCommand("perp_sd_s");
	
	local totalEarned = (ITEM_DATABASE[83].Cost-100) * LocalPlayer():GetItemCount(83);
	
	LocalPlayer():GiveCash(totalEarned);
	
	for k, v in pairs(GAMEMODE.PlayerItems) do
		if (v.ID == 83) then
			GAMEMODE.PlayerItems[k] = nil;
			GAMEMODE.InventoryBlocks_Linear[k]:GrabItem();
		end
	end
	
	GAMEMODE.DialogPanel:SetDialog("Thanks, man. Here's your " .. DollarSign() .. totalEarned .. ".");
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
end

function NPC.BuyStuff_Coke ( )
	local ID = GetGlobalInt('perp_druggy_buy', 0);
		
	if (ID == 4) then
		GAMEMODE.DialogPanel:SetDialog("Yeah, I could use some of that " .. DollarSign() .. ITEM_DATABASE[160].Cost .. " each.");
		
		GAMEMODE.DialogPanel:AddDialog("Sounds reasonable.", NPC.BuyStuff_Coke_Confirm);
		GAMEMODE.DialogPanel:AddDialog("Are you joking?", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry man, I have plenty of that shit. Not enough demand around here. Come back later.");
		
		GAMEMODE.DialogPanel:AddDialog("Fine, I'll be back.", LEAVE_DIALOG);
	end
end

function NPC.BuyStuff_Coke_Confirm ( )
	RunConsoleCommand("perp_sd_c");
	
	local totalEarned = ITEM_DATABASE[160].Cost * LocalPlayer():GetItemCount(160);
	
	LocalPlayer():GiveCash(totalEarned);
	
	for k, v in pairs(GAMEMODE.PlayerItems) do
		if (v.ID == 160) then
			GAMEMODE.PlayerItems[k] = nil;
			GAMEMODE.InventoryBlocks_Linear[k]:GrabItem();
		end
	end
	
	GAMEMODE.DialogPanel:SetDialog("Thanks, man. Here's your " .. DollarSign() .. totalEarned .. ".");
	GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
end

function NPC.SellStuff ( )
	local ID = GetGlobalInt('perp_druggy_sell', 0);
	
	if (ID == 1) then
		GAMEMODE.DialogPanel:SetDialog("Yah man, I got some seeds. You interested? " .. DollarSign() .. ITEM_DATABASE[14].Cost .. " each.");
		
		GAMEMODE.DialogPanel:AddDialog("Yah, I'll take some.", NPC.SellStuff_Weed);
		GAMEMODE.DialogPanel:AddDialog("Naw man, sorry.", LEAVE_DIALOG);
	elseif (ID == 2) then
		GAMEMODE.DialogPanel:SetDialog("Yeah dude, I got some shroomies. Want? " .. DollarSign() .. ITEM_DATABASE[83].Cost .. "each.");
		
		GAMEMODE.DialogPanel:AddDialog("Gimme some of that shit'.", NPC.SellStuff_Shrooms);
		GAMEMODE.DialogPanel:AddDialog("Psh, too damn expensive!", LEAVE_DIALOG);
	elseif (ID == 3) then
		GAMEMODE.DialogPanel:SetDialog("Yeah homie, I got some cocain seeds. Want? " .. DollarSign() .. ITEM_DATABASE[161].Cost .. "each.");
		
		GAMEMODE.DialogPanel:AddDialog("Gimme some of that shit'.", NPC.SellStuff_Coke);
		GAMEMODE.DialogPanel:AddDialog("Psh, too damn expensive!", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:SetDialog("Sorry, I got nothing today. The people around here are druggies, I tell ya.");

		GAMEMODE.DialogPanel:AddDialog("Damnit, alright. I'll stop by later.", LEAVE_DIALOG);
	end
end

function NPC.SellStuff_Weed ( )
	GAMEMODE.DialogPanel:SetDialog("How many do you need?");
		
	GAMEMODE.DialogPanel:AddDialog("One ( " .. DollarSign() .. ITEM_DATABASE[14].Cost * 1 .. " )", function ( ) NPC.SellStuff_Weed_Confirm(1); end);
	GAMEMODE.DialogPanel:AddDialog("Two ( " .. DollarSign() .. ITEM_DATABASE[14].Cost * 2 .. " )", function ( ) NPC.SellStuff_Weed_Confirm(2); end);
	GAMEMODE.DialogPanel:AddDialog("Three ( " .. DollarSign() .. ITEM_DATABASE[14].Cost * 3 .. " )", function ( ) NPC.SellStuff_Weed_Confirm(3); end);
	GAMEMODE.DialogPanel:AddDialog("Four ( " .. DollarSign() .. ITEM_DATABASE[14].Cost * 4 .. " )", function ( ) NPC.SellStuff_Weed_Confirm(4); end);
	GAMEMODE.DialogPanel:AddDialog("Five ( " .. DollarSign() .. ITEM_DATABASE[14].Cost * 5 .. " )", function ( ) NPC.SellStuff_Weed_Confirm(5); end);
	GAMEMODE.DialogPanel:AddDialog("Ten ( " .. DollarSign() .. ITEM_DATABASE[14].Cost * 10 .. " )", function ( ) NPC.SellStuff_Weed_Confirm(10); end);
	GAMEMODE.DialogPanel:AddDialog("Twenty ( " .. DollarSign() .. ITEM_DATABASE[14].Cost * 20 .. " )", function ( ) NPC.SellStuff_Weed_Confirm(20); end);
	GAMEMODE.DialogPanel:AddDialog("Fifty ( " .. DollarSign() .. ITEM_DATABASE[14].Cost * 50 .. " )", function ( ) NPC.SellStuff_Weed_Confirm(50); end);
	GAMEMODE.DialogPanel:AddDialog("Nevermind", LEAVE_DIALOG);
end

function NPC.SellStuff_Weed_Confirm ( num )
	local totalCost = num * ITEM_DATABASE[14].Cost;
	
	GAMEMODE.DialogPanel:SetDialog("That'll be " .. DollarSign() .. totalCost .. ".");
	
	if (LocalPlayer():GetCash() < totalCost) then
		GAMEMODE.DialogPanel:AddDialog("Ahh, I can't afford that.", LEAVE_DIALOG);	
	elseif (!LocalPlayer():CanHoldItem(14, num)) then
		GAMEMODE.DialogPanel:AddDialog("Nevermind, I don't think I can hold that many.", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
		
		LocalPlayer():TakeCash(totalCost);
		LocalPlayer():GiveItem(14, num);
		
		RunConsoleCommand('perp_bd_w', num);
	end
end

function NPC.SellStuff_Shrooms ( )
	GAMEMODE.DialogPanel:SetDialog("How many do you need?");
		
	GAMEMODE.DialogPanel:AddDialog("One ( " .. DollarSign() .. ITEM_DATABASE[83].Cost * 1 .. " )", function ( ) NPC.SellStuff_Shrooms_Confirm(1); end);
	GAMEMODE.DialogPanel:AddDialog("Two ( " .. DollarSign() .. ITEM_DATABASE[83].Cost * 2 .. " )", function ( ) NPC.SellStuff_Shrooms_Confirm(2); end);
	GAMEMODE.DialogPanel:AddDialog("Three ( " .. DollarSign() .. ITEM_DATABASE[83].Cost * 3 .. " )", function ( ) NPC.SellStuff_Shrooms_Confirm(3); end);
	GAMEMODE.DialogPanel:AddDialog("Four ( " .. DollarSign() .. ITEM_DATABASE[83].Cost * 4 .. " )", function ( ) NPC.SellStuff_Shrooms_Confirm(4); end);
	GAMEMODE.DialogPanel:AddDialog("Five ( " .. DollarSign() .. ITEM_DATABASE[83].Cost * 5 .. " )", function ( ) NPC.SellStuff_Shrooms_Confirm(5); end);
	GAMEMODE.DialogPanel:AddDialog("Ten ( " .. DollarSign() .. ITEM_DATABASE[83].Cost * 10 .. " )", function ( ) NPC.SellStuff_Shrooms_Confirm(10); end);
	GAMEMODE.DialogPanel:AddDialog("Twenty ( " .. DollarSign() .. ITEM_DATABASE[83].Cost * 20 .. " )", function ( ) NPC.SellStuff_Shrooms_Confirm(20); end);
	GAMEMODE.DialogPanel:AddDialog("Nevermind", LEAVE_DIALOG);
end

function NPC.SellStuff_Shrooms_Confirm ( num )
	local totalCost = num * ITEM_DATABASE[83].Cost;
	
	GAMEMODE.DialogPanel:SetDialog("That'll be " .. DollarSign() .. totalCost .. ".");
	
	if (LocalPlayer():GetCash() < totalCost) then
		GAMEMODE.DialogPanel:AddDialog("Ahh, I can't afford that.", LEAVE_DIALOG);	
	elseif (!LocalPlayer():CanHoldItem(83, num)) then
		GAMEMODE.DialogPanel:AddDialog("Nevermind, I don't think I can hold that many.", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
		
		LocalPlayer():TakeCash(totalCost);
		LocalPlayer():GiveItem(83, num);
		
		RunConsoleCommand('perp_bd_s', num);
	end
end

function NPC.SellStuff_Coke ( )
	GAMEMODE.DialogPanel:SetDialog("How many do you need?");
		
	GAMEMODE.DialogPanel:AddDialog("One ( " .. DollarSign() .. ITEM_DATABASE[161].Cost * 1 .. " )", function ( ) NPC.SellStuff_Coke_Confirm(1); end);
	GAMEMODE.DialogPanel:AddDialog("Two ( " .. DollarSign() .. ITEM_DATABASE[161].Cost * 2 .. " )", function ( ) NPC.SellStuff_Coke_Confirm(2); end);
	GAMEMODE.DialogPanel:AddDialog("Three ( " .. DollarSign() .. ITEM_DATABASE[161].Cost * 3 .. " )", function ( ) NPC.SellStuff_Coke_Confirm(3); end);
	GAMEMODE.DialogPanel:AddDialog("Four ( " .. DollarSign() .. ITEM_DATABASE[161].Cost * 4 .. " )", function ( ) NPC.SellStuff_Coke_Confirm(4); end);
	GAMEMODE.DialogPanel:AddDialog("Five ( " .. DollarSign() .. ITEM_DATABASE[161].Cost * 5 .. " )", function ( ) NPC.SellStuff_Coke_Confirm(5); end);
	GAMEMODE.DialogPanel:AddDialog("Ten ( " .. DollarSign() .. ITEM_DATABASE[161].Cost * 10 .. " )", function ( ) NPC.SellStuff_Coke_Confirm(10); end);
	GAMEMODE.DialogPanel:AddDialog("Twenty ( " .. DollarSign() .. ITEM_DATABASE[161].Cost * 20 .. " )", function ( ) NPC.SellStuff_Coke_Confirm(20); end);
	GAMEMODE.DialogPanel:AddDialog("Fifty ( " .. DollarSign() .. ITEM_DATABASE[161].Cost * 50 .. " )", function ( ) NPC.SellStuff_Coke_Confirm(50); end);
	GAMEMODE.DialogPanel:AddDialog("Nevermind", LEAVE_DIALOG);
end

function NPC.SellStuff_Coke_Confirm ( num )
	local totalCost = num * ITEM_DATABASE[161].Cost;
	
	GAMEMODE.DialogPanel:SetDialog("That'll be " .. DollarSign() .. totalCost .. ".");
	
	if (LocalPlayer():GetCash() < totalCost) then
		GAMEMODE.DialogPanel:AddDialog("Ahh, I can't afford that.", LEAVE_DIALOG);	
	elseif (!LocalPlayer():CanHoldItem(161, num)) then
		GAMEMODE.DialogPanel:AddDialog("Nevermind, I don't think I can hold that many.", LEAVE_DIALOG);
	else
		GAMEMODE.DialogPanel:AddDialog("Thanks!", LEAVE_DIALOG);
		
		LocalPlayer():TakeCash(totalCost);
		LocalPlayer():GiveItem(161, num);
		
		RunConsoleCommand('perp_bd_c', num);
	end
end

if SERVER then
	// Sell -> 1 = Pot, 2 = Shrooms
	// Buy -> 1 = Pot, 2 = Meth, 3 = Shrooms
	function GAMEMODE.RandomizeDruggyValues ( )
		SetGlobalInt('perp_druggy_sell', math.random(0, 3))
		SetGlobalInt('perp_druggy_buy', math.random(0, 4))
	end
	timer.Create('perp_druggy', 300, 0, GAMEMODE.RandomizeDruggyValues);
	GAMEMODE.RandomizeDruggyValues();
	
	local function buyWeed ( Player, CMD, Args )
		if (!Args[1]) then return; end
		if (!Player:NearNPC(16)) then return; end
		
		local toBuy = tonumber(Args[1]);
		local totalCost = toBuy * ITEM_DATABASE[14].Cost;
		
		if (toBuy <= 0) then return; end
		if (Player:GetCash() < totalCost) then return; end
		if (GetGlobalInt('perp_druggy_sell', 0) != 1) then return; end
		if (!Player:CanHoldItem(14, toBuy)) then return; end
		
		Player:TakeCash(totalCost, true);
		Player:GiveItem(14, toBuy);
		Player:Save();
	end
	concommand.Add("perp_bd_w", buyWeed);
	
	local function buyCoke ( Player, CMD, Args )
		if (!Args[1]) then return; end
		if (!Player:NearNPC(16)) then return; end
		
		local toBuy = tonumber(Args[1]);
		local totalCost = toBuy * ITEM_DATABASE[161].Cost;
		
		if (toBuy <= 0) then return; end
		if (Player:GetCash() < totalCost) then return; end
		if (GetGlobalInt('perp_druggy_sell', 0) != 3) then return; end
		if (!Player:CanHoldItem(161, toBuy)) then return; end
		
		Player:TakeCash(totalCost, true);
		Player:GiveItem(161, toBuy);
		Player:Save();
	end
	concommand.Add("perp_bd_c", buyCoke);
	
	local function buyShrooms ( Player, CMD, Args )
		if (!Args[1]) then return; end
		if (!Player:NearNPC(16)) then return; end
		
		local toBuy = tonumber(Args[1]);
		local totalCost = toBuy * (ITEM_DATABASE[83].Cost);
		
		if (toBuy <= 0) then return; end
		if (Player:GetCash() < totalCost) then return; end
		if (GetGlobalInt('perp_druggy_sell', 0) != 2) then return; end
		if (!Player:CanHoldItem(83, toBuy)) then return; end
		
		Player:TakeCash(totalCost, true);
		Player:GiveItem(83, toBuy);
		Player:Save()
	end
	concommand.Add("perp_bd_s", buyShrooms)
		
	
	local function sellWeed ( Player )
		if (GetGlobalInt('perp_druggy_buy', 0) != 1) then return; end
		if (!Player:NearNPC(16)) then return; end
	
		local num = Player:GetItemCount(13);
		
		if (num == 0) then return; end
		
		for k, v in pairs(Player.PlayerItems) do
			if (v.ID == 13) then
				Player.PlayerItems[k] = nil;
			end
		end
		
		Player:GiveCash(num * ITEM_DATABASE[13].Cost, true);
		
		Player:Save();
	end
	concommand.Add("perp_sd_w", sellWeed);
	
	local function sellCoke ( Player )
		if (GetGlobalInt('perp_druggy_buy', 0) != 4) then return; end
		if (!Player:NearNPC(16)) then return; end
	
		local num = Player:GetItemCount(160);
		
		if (num == 0) then return; end
		
		for k, v in pairs(Player.PlayerItems) do
			if (v.ID == 160) then
				Player.PlayerItems[k] = nil;
			end
		end
		
		Player:GiveCash(num * ITEM_DATABASE[160].Cost, true);
		
		Player:Save();
	end
	concommand.Add("perp_sd_c", sellCoke);
	
	local function sellShrooms( Player )
		if (GetGlobalInt('perp_druggy_buy', 0) != 3) then return; end
		if (!Player:NearNPC(16)) then return; end
	
		local num = Player:GetItemCount(83);
		
		if (num == 0) then return; end
		
		for k, v in pairs(Player.PlayerItems) do
			if (v.ID == 83) then
				Player.PlayerItems[k] = nil;
			end
		end
		
		Player:GiveCash((num * (ITEM_DATABASE[83].Cost-100)), true);
		
		Player:Save();
	end
	concommand.Add("perp_sd_s", sellShrooms);
	
	local function sellMeth ( Player )
		if (GetGlobalInt('perp_druggy_buy', 0) != 2) then return; end
		if (!Player:NearNPC(16)) then return; end
	
		local num = Player:GetItemCount(10);
		
		if (num == 0) then return; end
		
		for k, v in pairs(Player.PlayerItems) do
			if (v.ID == 10) then
				Player.PlayerItems[k] = nil;
			end
		end
		
		Player:GiveCash(num * ITEM_DATABASE[10].Cost, true);
		
		Player:Save();
	end
	concommand.Add("perp_sd_m", sellMeth);
end

GAMEMODE:LoadNPC(NPC);