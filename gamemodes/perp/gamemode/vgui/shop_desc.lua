


local PANEL = {};

function PANEL:Init ( )
	self.Description = vgui.Create("perp2_inventory_block_description", self);
	self.Description.ShopMenu = true;
	
	self.Logo = vgui.Create("perp2_inventory_logo", self);
	self:SetSkin("ugperp")
end

function PANEL:PerformLayout ( )	
	local bufferSize = 5;
	
	self.Logo:SetPos(bufferSize, bufferSize);
	local LW = self:GetWide() - bufferSize * 2;
	local LH = LW * .5;
	self.Logo:SetSize(LW, LH);
	
	self.Description:SetPos(bufferSize, bufferSize * 2 + LH);
	self.Description:SetSize(LW, self:GetTall() - bufferSize * 3 - LH);
end

function PANEL:Paint ( )
	SKIN:PaintFrame(self, true);
end

function PANEL:SetDescription ( itemTable )
	self.Description:SetDescription(itemTable);
	self.Logo:SetDisplay(itemTable);
end

vgui.Register("perp2_shop_desc", PANEL);