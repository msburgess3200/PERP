


local PANEL = {};

function PANEL:Init ( )
	self.InventoryBlocks = {};
	
	local fakeX, fakeY = 1, 0;
	for y = 1, INVENTORY_HEIGHT do		
		for x = 1, INVENTORY_WIDTH do
			fakeY = fakeY + 1;
			if (fakeY > 5) then
				fakeY = 1;
				fakeX = fakeX + 1;
			end
			
			local newBlock = vgui.Create("perp2_trade_inv_block", self);
			newBlock:SetCoordinates(x, y);
			newBlock.fXPos, newBlock.fYPos = fakeX, fakeY;
			self.InventoryBlocks[newBlock.itemID] = newBlock;
		end
	end
	
	self.Description = true;
	//self:SetSkin("ugperp")
end

function PANEL:PerformLayout ( )	
	local bufferSize = 5;
	
	local curY = bufferSize;
	
	local blocksPerRow = (INVENTORY_HEIGHT * INVENTORY_WIDTH) / 5;
	
	for i, v in pairs(self.InventoryBlocks) do
		local x = v.fXPos;
		local y = v.fYPos;
		
		v:SetSize(self.SizeOfBlock, self.SizeOfBlock);
		v:SetPos((bufferSize * x) + ((x - 1) * self.SizeOfBlock), (bufferSize * y) + ((y - 1) * self.SizeOfBlock));
		v:GrabItem(true);
	end
end

function PANEL:Paint ( )
	SKIN:PaintFrame(self, true);
end

function PANEL:SetDescription ( ) end

vgui.Register("perp2_trade_inv", PANEL);