


local PANEL = {};

function PANEL:Init ( )
	self.InventoryBlocks = {};
	
	local fakeX, fakeY = 1, 0;
	for x = 1, 3 do		
		for y = 1, 5 do
			fakeY = fakeY + 1;
			if (fakeY > 5) then
				fakeY = 1;
				fakeX = fakeX + 1;
			end
			
			local newBlock = vgui.Create("perp2_trade_offer_block", self);
			newBlock.itemID = y + ((x - 1) * 5);
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
	end
end

function PANEL:Paint ( )
	SKIN:PaintFrame(self, true);
end

function PANEL:SetDescription ( ) end

vgui.Register("perp2_trade_offer", PANEL);