

function GM.StartTrade ( UMsg )
	if (GAMEMODE.TradingWith) then
		Msg("Already trading but got UMsg informing start of trade.\n");
		GAMEMODE.CancelTrade();
	end
	
	local tW = UMsg:ReadEntity();
	
	if (!tW || !IsValid(tW) || !tW:IsPlayer()) then return; end
	
	GAMEMODE.TradingWith = tW;
	
	GAMEMODE.TradeScreen = vgui.Create("perp2_trade");
	
	GAMEMODE.TheirOffer_Cash = 0;
	GAMEMODE.TheirOffer_Items = {};
	GAMEMODE.OurOffer_Items = {};
	GAMEMODE.OurOffer_Cash = 0;
	
	GAMEMODE.Trade_WeAccepted 		= nil;
	GAMEMODE.Trade_TheyAccepted 	= nil;
end
usermessage.Hook("perp_t_s", GM.StartTrade);

function GM.SetCashOffer ( UMsg )
	if (!GAMEMODE.TradingWith) then
		Msg("Offer cash offer but not trading.\n");
		return;
	end

	GAMEMODE.TheirOffer_Cash = UMsg:ReadLong();
	
	GAMEMODE.TradeScreen.cashBox.theirCashOffers:SetText(GAMEMODE.TheirOffer_Cash);
	
	GAMEMODE.Trade_WeAccepted 		= nil;
	GAMEMODE.Trade_TheyAccepted 	= nil;
end
usermessage.Hook("perp_t_d", GM.SetCashOffer);

function GM.AddOffer ( UMsg )
	if (!GAMEMODE.TradingWith) then
		Msg("Offer incoming but not trading.\n");
		return;
	end
		
	local itemID = UMsg:ReadShort();
	local itemQuantity = UMsg:ReadShort();
	
	local newTable = {};
	newTable.ID = itemID;
	newTable.Quantity = itemQuantity;
	
	for i = 1, table.Count(GAMEMODE.TheirOffer_Items) + 1 do
		if (!GAMEMODE.TheirOffer_Items[i]) then
			GAMEMODE.TheirOffer_Items[i] = newTable;
			GAMEMODE.TradeScreen.theirOffer.InventoryBlocks[i]:GrabItem();
		end
	end
	
	GAMEMODE.Trade_WeAccepted 		= nil;
	GAMEMODE.Trade_TheyAccepted 	= nil;
end
usermessage.Hook("perp_t_a", GM.AddOffer);

function GM.RemoveOffer ( UMsg )
	if (!GAMEMODE.TradingWith) then
		Msg("Offer removal but not trading.\n");
		return;
	end
	
	local itemID = UMsg:ReadShort();
	local itemQuantity = UMsg:ReadShort();
	
	GAMEMODE.Trade_WeAccepted 		= nil;
	GAMEMODE.Trade_TheyAccepted 	= nil;
	
	for k, v in pairs(GAMEMODE.TheirOffer_Items) do
		if (v.ID == itemID && v.Quantity == itemQuantity) then
			GAMEMODE.TheirOffer_Items[k] = nil;
			
			if (GAMEMODE.TradeScreen.theirOffer.InventoryBlocks[k]) then
				GAMEMODE.TradeScreen.theirOffer.InventoryBlocks[k]:GrabItem();
			end
			
			return;
		end
	end
	
	Msg("Could not find item to remove from trade offer.\n");
end
usermessage.Hook("perp_t_r", GM.RemoveOffer);

function GM.CancelTrade ( )
	if (!GAMEMODE.TradingWith) then
		Msg("Got cancel trade command but not trading.\n");
		return;
	end

	GAMEMODE.TradingWith = nil;
	GAMEMODE.TheirOffer_Cash = nil;
	GAMEMODE.TheirOffer_Items = nil;
	GAMEMODE.OurOffer_Items = nil;
	GAMEMODE.OurOffer_Cash = nil;
	
	LocalPlayer():Notify("Trade canceled.");
	
	if (GAMEMODE.TradeScreen) then GAMEMODE.TradeScreen:Remove(); GAMEMODE.TradeScreen = nil; end
end
usermessage.Hook("perp_t_c", GM.CancelTrade);

function GM.TheyAccepted ( UMsg )
	if (!GAMEMODE.TradingWith) then
		Msg("Got they accepted command but not trading.\n");
		return;
	end
	
	GAMEMODE.Trade_TheyAccepted = true;
	
	if (GAMEMODE.Trade_TheyAccepted && GAMEMODE.Trade_WeAccepted) then
		GAMEMODE.FinishTrade();
	end
end
usermessage.Hook("perp_t_ag", GM.TheyAccepted);

function GM.FinishTrade ( )
	// easy part - cash
	LocalPlayer():GiveCash(GAMEMODE.TheirOffer_Cash);
	LocalPlayer():TakeCash(GAMEMODE.OurOffer_Cash);
	
	// hard part - items
	// Remove our offered stuff
	for k, v in pairs(GAMEMODE.OurOffer_Items) do
		GAMEMODE.PlayerItems[v] = nil;
		GAMEMODE.InventoryBlocks_Linear[v]:GrabItem();
	end
	
	// Give us their offered stuff
	for k, v in pairs(GAMEMODE.TheirOffer_Items) do
		LocalPlayer():GiveItem(v.ID, v.Quantity);
	end
	
	GAMEMODE.TradingWith = nil;
	GAMEMODE.TheirOffer_Cash = nil;
	GAMEMODE.TheirOffer_Items = nil;
	GAMEMODE.OurOffer_Items = nil;
	GAMEMODE.OurOffer_Cash = nil;
	
	if (GAMEMODE.TradeScreen) then GAMEMODE.TradeScreen:Remove(); GAMEMODE.TradeScreen = nil; end
	
	LocalPlayer():Notify("Trade completed successfully.");
end
