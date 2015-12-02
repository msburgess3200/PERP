


local PANEL = {};

function PANEL:Think ( ) end

PANEL.otherGrabItem = PANEL.GrabItem;

function PANEL:OnMousePressed ( MouseCode )	
	self.trueParent.SelectedForTrade = !self.trueParent.SelectedForTrade;
	
	if (self.trueParent.SelectedForTrade && table.Count(GAMEMODE.OurOffer_Items) >= 15) then
		self.trueParent.SelectedForTrade = nil;
		LocalPlayer():Notify("You have reached the maximum offer size.");
		return
	end
	
	GAMEMODE.Trade_WeAccepted 		= nil;
	GAMEMODE.Trade_TheyAccepted 	= nil;
	
	RunConsoleCommand("perp_t_ot", self.trueParent.itemID);
	
	if (self.trueParent.SelectedForTrade) then
		table.insert(GAMEMODE.OurOffer_Items, self.trueParent.itemID);
	else
		for k, v in pairs(GAMEMODE.OurOffer_Items) do
			if (v == self.trueParent.itemID) then
				GAMEMODE.OurOffer_Items[k] = nil;
			end
		end
	end
end

function PANEL:OnMouseReleased( MouseCode )

end

vgui.Register("perp2_trade_inv_item", PANEL, "perp2_inventory_block_item");