

local PANEL = {};

function PANEL:Init ( )
	self.InventoryBlocks = {};
	self:SetSkin("ugperp")
	
	for x = 1, INVENTORY_WIDTH do		
		for y = 1, INVENTORY_HEIGHT do
			local newBlock = vgui.Create("perp2_shop_player_block", self);
			newBlock:SetCoordinates(x, y);
			self.InventoryBlocks[newBlock.itemID] = newBlock;
		end
	end
	
	self.Description = true;
end

function PANEL:PerformLayout ( )	
	local bufferSize = 5;
	
	local curY = bufferSize;
	
	for i, v in pairs(self.InventoryBlocks) do
		k = i - 2;
		local y = math.floor(((k - 1) / 6) + 1);
		local x = k - ((y - 1) * 6);
				
		v:SetSize(self.SizeOfBlock, self.SizeOfBlock);
		v:SetPos((bufferSize * x) + ((x - 1) * self.SizeOfBlock), (bufferSize * y) + ((y - 1) * self.SizeOfBlock));
		v:GrabItem(true);
	end
end

function PANEL:Paint ( )
	SKIN:PaintFrame(self, true);
end

function PANEL:SetDescription ( itemTable )
	self:GetParent():SetDescription(itemTable);
end

vgui.Register("perp2_shop_inv", PANEL);