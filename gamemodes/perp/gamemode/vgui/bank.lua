


local PANEL = {};

function PANEL:Init ( )
	self.BankPlayerInventory = vgui.Create("perp_bank_", self);
	self.BankPlayerInventory = vgui.Create("perp_bank_inv", self);
	//self.ShopDescription = vgui.Create("perp2_shop_desc", self);
	//self.ShopStoreInventory = vgui.Create("perp2_shop_store", self);
	//self.ShopTitle = vgui.Create("perp2_shop_title", self);
	self:SetSkin("ugperp")
end

function PANEL:PerformLayout ( )
	self.Rift = 45;
	
	local realScrH = ScrW() * (10 / 16);

	
	self:SetPos(0, (ScrH() - realScrH) * .5);
	self:SetSize(ScrW(), realScrH);

	local bufferSize = 5;
	
	// Block size calculations
	local availableWidth = (ScrW() * .5) - 2 - ((INVENTORY_WIDTH + 1) * bufferSize);
	local sizeOfBlock = availableWidth / INVENTORY_WIDTH;
	
	// Size of inventory panel
	local NeededW = bufferSize + (INVENTORY_HEIGHT * (bufferSize + sizeOfBlock));
	local NeededH = bufferSize + (INVENTORY_WIDTH * (bufferSize + sizeOfBlock));
	
	// Size of 
	local WidthSplit = (ScrW() * .5 - 1 - bufferSize * 3) * .5;
	
	// Total width of shop screen
	local totalWidth = WidthSplit + NeededW + self.Rift;
	local totalHeight = NeededH;
	
	local x, y = ScrW() * .5 - totalWidth * .5, realScrH * .5 - totalHeight * .5;
	
	self.BankPlayerInventory:SetSize(NeededW, NeededH);
	self.BankPlayerInventory:SetPos(x, y);
	self.BankPlayerInventory.SizeOfBlock = sizeOfBlock;
	
	local HeightSplit = WidthSplit * .5 + bufferSize * 3 + (realScrH * .53) - NeededW;

end

function PANEL:Paint ( ) end


vgui.Register("perp_bank", PANEL);