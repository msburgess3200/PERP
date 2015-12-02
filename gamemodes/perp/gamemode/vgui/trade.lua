


local PANEL = {};

function PANEL:Init ( )
	self:SetSkin("ugperp")
	
	self.theirOffer = vgui.Create("perp2_trade_offer", self);
	self.buttonBox = vgui.Create("perp2_trade_buttons", self);
	self.cashBox = vgui.Create("perp2_trade_cash", self);
end

function PANEL:PerformLayout ( )	
	self.Rift = 10;
	
	local realScrH = ScrW() * (10 / 16); 
	
	self:SetPos(0, (ScrH() - realScrH) * .5);
	self:SetSize(ScrW(), realScrH);

	local bufferSize = 5;
	
	// Block size calculations
	local availableWidth = (ScrW() * .5) - 2 - ((INVENTORY_WIDTH + 1) * bufferSize);
	local sizeOfBlock = availableWidth / INVENTORY_WIDTH;
	
	// Size of inventory panel
	local totalBlocks = INVENTORY_HEIGHT * INVENTORY_WIDTH;
	local NeededW = bufferSize + ((totalBlocks / 5) * (bufferSize + sizeOfBlock));
	local NeededH = bufferSize + (5 * (bufferSize + sizeOfBlock));
	
	invPanel = vgui.Create("perp2_trade_inv", self);
	invPanel.SizeOfBlock = sizeOfBlock;
	invPanel:SetSize(NeededW, NeededH);
	
	// Size of the offer boxes.
	local offerWidth = (sizeOfBlock * 3) + (bufferSize * 4);
	local yOfOffers = NeededH;
	
	local totalSize = offerWidth + self.Rift + NeededW;
	
	// set the pos of the inventory
	local startY = (realScrH * .5) - (NeededH * .5);
	local startX = ScrW() * .5 - totalSize * .5;
	
	invPanel:SetPos(startX, startY);
	
	// Make the offer pannels
	self.theirOffer.SizeOfBlock = sizeOfBlock;
	self.theirOffer:SetSize(offerWidth, yOfOffers);
	self.theirOffer:SetPos(startX + NeededW + self.Rift, startY);
	
	// Make cash and buttons
		local h = bufferSize * 2 + 20
	self.cashBox:SetPos(startX, startY - self.Rift - h);
	self.cashBox:SetSize(offerWidth + self.Rift + NeededW, h); 
	
	self.buttonBox:SetPos(startX, startY + self.Rift + yOfOffers);
	self.buttonBox:SetSize(offerWidth + self.Rift + NeededW, bufferSize * 2 + 20);
end

function PANEL:Paint ( ) end

vgui.Register("perp2_trade", PANEL);