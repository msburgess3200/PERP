


local PANEL = {};

function PANEL:GrabItem ( )
	if (GAMEMODE.TheirOffer_Items[self.itemID]) then  
		self.itemTable = ITEM_DATABASE[GAMEMODE.TheirOffer_Items[self.itemID].ID];
		self.actualItem = GAMEMODE.TheirOffer_Items[self.itemID];
		
		if (!self.ModelPanel) then
		//	Msg("up\n")
			self.ModelPanel = vgui.Create('perp2_trade_offer_item', self:GetParent());
		end
		
		local x, y = self:GetPos()
		self.ModelPanel:SetPos(x + 1, y + 1);
		self.ModelPanel:SetSize(self:GetWide() - 2, self:GetTall() - 2);
		self.ModelPanel:SetItemTable(self.itemTable);
		self.ModelPanel.trueParent = self;
		
		self.ourAlpha = 170;
	else
		self.itemTable = nil;
		self.actualItem = nil;
		
		if (self.ModelPanel) then
			self.ModelPanel:Remove();
			self.ModelPanel = nil;
		end
		
		self.ourAlpha = 170;
	end
end

vgui.Register("perp2_trade_offer_block", PANEL, "perp2_inventory_block");