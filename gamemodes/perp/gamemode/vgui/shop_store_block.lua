


local PANEL = {};

function PANEL:PerformLayout ( )
	local x, y = self:GetPos()
	if (self.ModelPanel) then
		self.ModelPanel:SetPos(x + 1, y + 1);
		self.ModelPanel:SetSize(self:GetWide() - 2, self:GetTall() - 2);
	end
end

function PANEL:GrabItem ( itemTable )
	self.itemTable = itemTable;
		
	if (!self.ModelPanel) then
		self.ModelPanel = vgui.Create('perp2_shop_store_item', self:GetParent());
	end
		
	local x, y = self:GetPos()
	self.ModelPanel:SetPos(x + 1, y + 1);
	self.ModelPanel:SetSize(self:GetWide() - 2, self:GetTall() - 2);
	self.ModelPanel:SetItemTable(self.itemTable);
	self.ModelPanel.trueParent = self;
end

vgui.Register("perp2_shop_store_block", PANEL, "perp2_inventory_block");