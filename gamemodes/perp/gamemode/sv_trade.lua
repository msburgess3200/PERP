


function PLAYER:TradeWith ( otherPlayer )
	if (!otherPlayer || !IsValid(otherPlayer) || !otherPlayer:IsPlayer()) then return; end
	
	if (otherPlayer.CurrentlyTrading) then
		self:Notify("That player is already trading. Please wait until he is finished.");
	return; end
	
	if (self.CurrentlyTrading) then
		self:Notify("You are already trading.");
	return; end
	
	if (otherPlayer.TradeOffer == self) then
		// He wants to trade too; lets do it!
		umsg.Start("perp_t_s", self); 
			umsg.Entity(otherPlayer);
		umsg.End();
		
		umsg.Start("perp_t_s", otherPlayer); 
			umsg.Entity(self);
		umsg.End();
		
		self.CurrentlyTrading = otherPlayer;
		otherPlayer.CurrentlyTrading = self;
		
		self.Trade_Offer = {};
		otherPlayer.Trade_Offer = {};
		
		self.Trade_CashOffer = 0;
		otherPlayer.Trade_CashOffer = 0;
		
		otherPlayer.nextTradeStart = nil;
		otherPlayer.TradeOffer = nil;
		
		otherPlayer.Trade_Accepted 	= nil;
		self.Trade_Accepted 		= nil;
	else
		if (self.nextTradeStart && CurTime() < self.nextTradeStart) then
			self:Notify("You must wait another " .. math.ceil(self.nextTradeStart - CurTime()) .. " seconds before you can trade again.");
		return; end
		
		self.TradeOffer = otherPlayer;
		self.nextTradeStart = CurTime() + 30;
		
		otherPlayer:Notify(self:GetRPName() .. " would like to trade. Look at him at press F4 to accept.");
		self:Notify("Trade request sent.");
	end
end

// OFFERING PROCESS
function GM.UpdateOffer_Toggle ( Player, Cmd, Args )
	if (!Player.CurrentlyTrading || !IsValid(Player.CurrentlyTrading) || !Player.CurrentlyTrading:IsPlayer()) then return; end
	if (!Args[1]) then return; end
	
	local itemID = tonumber(Args[1]);
	
	if (!Player.PlayerItems[itemID]) then return; end
	
	local kID;
	for i = 1, table.Count(Player.Trade_Offer) do
		if (Player.Trade_Offer[i] && Player.Trade_Offer[i] == itemID) then
			kID = i;
		end
	end
		
	if (kID && Player.Trade_Offer[kID]) then
		// Tell the other person we've retracted this offer.
		for i = 1, table.Count(Player.Trade_Offer) do
			if (Player.Trade_Offer[i] && Player.Trade_Offer[i] == itemID) then
				Player.Trade_Offer[i] = nil;
			end
		end
		
		umsg.Start("perp_t_r", Player.CurrentlyTrading)
			umsg.Short(Player.PlayerItems[itemID].ID);
			umsg.Short(Player.PlayerItems[itemID].Quantity);
		umsg.End();
	else
		// Tell the other person we've sent this offer.
		for i = 1, table.Count(Player.Trade_Offer) + 1 do
			if (!Player.Trade_Offer[i]) then
				Player.Trade_Offer[i] = itemID;
			end
		end
		
		umsg.Start("perp_t_a", Player.CurrentlyTrading)
			umsg.Short(Player.PlayerItems[itemID].ID);
			umsg.Short(Player.PlayerItems[itemID].Quantity);
		umsg.End();
	end
	
	Player.Trace_Accepted = nil;
	Player.CurrentlyTrading.Trace_Accepted = nil;
end
concommand.Add("perp_t_ot", GM.UpdateOffer_Toggle);

function GM.UpdateOffer_Cash ( Player, Cmd, Args )
	if (!Player.CurrentlyTrading || !IsValid(Player.CurrentlyTrading) || !Player.CurrentlyTrading:IsPlayer()) then return; end
	if (!Args[1]) then return; end
	
	local cash = math.Clamp(tonumber(Args[1]), 0, Player:GetCash());
	
	Player.Trade_CashOffer = cash;
	
	umsg.Start("perp_t_d", Player.CurrentlyTrading);
		umsg.Long(cash);
	umsg.End();
	
	Player.Trace_Accepted = nil;
	Player.CurrentlyTrading.Trace_Accepted = nil;
end
concommand.Add("perp_t_d", GM.UpdateOffer_Cash);

function GM.CancelTrade ( Player )
	if (!Player.CurrentlyTrading || !IsValid(Player.CurrentlyTrading) || !Player.CurrentlyTrading:IsPlayer()) then return; end
	
	umsg.Start("perp_t_c", Player.CurrentlyTrading);
	umsg.End();
	
	Player.CurrentlyTrading.CurrentlyTrading = nil;
	Player.CurrentlyTrading.Trade_Offer = nil;
	Player.CurrentlyTrading.Trade_CashOffer = nil;
	
	Player.CurrentlyTrading = nil;
	Player.Trade_Offer = nil;
	Player.Trade_CashOffer = nil;
end
concommand.Add("perp_t_c", GM.CancelTrade);

function GM.AcceptTrade ( Player )
	if (!Player.CurrentlyTrading || !IsValid(Player.CurrentlyTrading) || !Player.CurrentlyTrading:IsPlayer()) then return; end

	Player.Trade_Accepted = true;
	
	umsg.Start("perp_t_ag", Player.CurrentlyTrading); umsg.End();
	
	if (Player.CurrentlyTrading.Trade_Accepted) then
		local freeSpotsRequired_Them = table.Count(Player.Trade_Offer);
		local freeSpotsRequired_Us = table.Count(Player.CurrentlyTrading.Trade_Offer);
		
		// Make sure we have enough room.
		if (((INVENTORY_HEIGHT * INVENTORY_WIDTH) - table.Count(Player.CurrentlyTrading.PlayerItems)) < (freeSpotsRequired_Them - freeSpotsRequired_Us)) then
			Player:Notify(Player.CurrentlyTrading:GetRPName() .. " does not have enough free inventory room.");
			Player.CurrentlyTrading:Notify("You do not have enough free inventory room.");
			
			umsg.Start("perp_t_c", Player); umsg.End();
			umsg.Start("perp_t_c", Player.CurrentlyTrading); umsg.End();
			
			return
		end
		
		if (((INVENTORY_HEIGHT * INVENTORY_WIDTH) - table.Count(Player.PlayerItems)) < (freeSpotsRequired_Us - freeSpotsRequired_Them)) then
			Player.CurrentlyTrading:Notify(Player:GetRPName() .. " does not have enough free inventory room.");
			Player:Notify("You do not have enough free inventory room.");
			
			umsg.Start("perp_t_c", Player); umsg.End();
			umsg.Start("perp_t_c", Player.CurrentlyTrading); umsg.End();
			
			return
		end
		
		// Everything appears to be OK. Let's move on. The client's handle all this on their own. Yay prediction!
		
		// Cash
		Player:TakeCash(Player.Trade_CashOffer, true);
		Player:GiveCash(Player.CurrentlyTrading.Trade_CashOffer, true);
		
		Player.CurrentlyTrading:TakeCash(Player.CurrentlyTrading.Trade_CashOffer, true);
		Player.CurrentlyTrading:GiveCash(Player.Trade_CashOffer, true);
		
		// Items (gulp);
		local tempTable_ToTradePartner = {}
		for k, v in pairs(Player.Trade_Offer) do
			table.insert(tempTable_ToTradePartner, Player.PlayerItems[v]);
		
			// Steal from our current player :D
			Player.PlayerItems[v] = nil;
		end
		
		local tempTable_ToPlayer = {}
		for k, v in pairs(Player.CurrentlyTrading.Trade_Offer) do
			table.insert(tempTable_ToPlayer, Player.CurrentlyTrading.PlayerItems[v]);
		
			// Steal from our trading partner :D
			Player.CurrentlyTrading.PlayerItems[v] = nil;
		end
		
		// now actually hand them out... kinda like candy!
		for k, v in pairs(tempTable_ToTradePartner) do
			Player.CurrentlyTrading:GiveItem(v.ID, v.Quantity);
		end
		
		for k, v in pairs(tempTable_ToPlayer) do
			Player:GiveItem(v.ID, v.Quantity);
		end
		
		Player:Save();
		Player.CurrentlyTrading:Save();
		
		Player.CurrentlyTrading.CurrentlyTrading = nil;
		Player.CurrentlyTrading.Trade_Offer = nil;
		Player.CurrentlyTrading.Trade_CashOffer = nil;
		
		Player.CurrentlyTrading = nil;
		Player.Trade_Offer = nil;
		Player.Trade_CashOffer = nil;
	end
end
concommand.Add("perp_t_ag", GM.AcceptTrade);