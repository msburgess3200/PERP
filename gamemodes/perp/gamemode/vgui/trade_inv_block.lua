


local PANEL = {};

function PANEL:GrabItem ( dontScrewAlpha )
	if (GAMEMODE.PlayerItems[self.itemID]) then
		self.itemTable = ITEM_DATABASE[GAMEMODE.PlayerItems[self.itemID].ID];
		self.actualItem = GAMEMODE.PlayerItems[self.itemID];
		
		if (!self.ModelPanel) then
			//Msg("create\n")
			self.ModelPanel = vgui.Create('perp2_trade_inv_item', self:GetParent());
			self.ModelPanel.trueParent = self;
		end
		
		local x, y = self:GetPos()
		self.ModelPanel:SetPos(x + 1, y + 1);
		self.ModelPanel:SetSize(self:GetWide() - 2, self:GetTall() - 2);
		self.ModelPanel:SetItemTable(self.itemTable);
		self.ModelPanel.trueParent = self;
		
		if !dontScrewAlpha then self.ourAlpha = 170; end
	else
		self.itemTable = nil;
		self.actualItem = nil;
		
		if (self.ModelPanel) then
			self.ModelPanel:Remove();
			self.ModelPanel = nil;
		end
		
		if !dontScrewAlpha then self.ourAlpha = 170; end
	end
end

vgui.Register("perp2_trade_inv_block", PANEL, "perp2_inventory_block");