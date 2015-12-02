


local PANEL = {};

function PANEL:Init ( )
	GAMEMODE.InventoryBlocks = {};
	GAMEMODE.InventoryBlocks_Linear = {};
	for x = 1, INVENTORY_WIDTH do
		GAMEMODE.InventoryBlocks[x] = {};
		
		for y = 1, INVENTORY_HEIGHT do
			GAMEMODE.InventoryBlocks[x][y] = vgui.Create("perp2_inventory_block", self);
			GAMEMODE.InventoryBlocks[x][y]:SetCoordinates(x, y);
			GAMEMODE.InventoryBlocks_Linear[GAMEMODE.InventoryBlocks[x][y].itemID] = GAMEMODE.InventoryBlocks[x][y];
		end
	end
	
	self.Header = vgui.Create("perp2_inventory_logo", self);
	
	self.MainWeaponEquip = vgui.Create("perp2_inventory_block_equip", self);
	self.MainWeaponEquip:SetMain(true);
	GAMEMODE.InventoryBlocks_Linear[self.MainWeaponEquip.itemID] = self.MainWeaponEquip;
	
	self.SideWeaponEquip = vgui.Create("perp2_inventory_block_equip", self);
	self.SideWeaponEquip:SetMain(false);
	GAMEMODE.InventoryBlocks_Linear[self.SideWeaponEquip.itemID] = self.SideWeaponEquip;
	
	self.Description = vgui.Create("perp2_inventory_block_description", self);
	
	self:SetAlpha(GAMEMODE.GetInventoryAlpha());
end

function PANEL:GetHoveredItemSlot ( )
	for k, v in pairs(GAMEMODE.InventoryBlocks_Linear) do
		if (v.cursorIn) then
			return v;
		end
	end
	
	return nil;
end

function PANEL:PerformLayout ( )

	local MaxW, MaxH = ScrW() * .635;
	local MaxH = (ScrW() * (10 / 16)) * .8;
	self:SetPos((ScrW() * .5) - (MaxW * .5), (ScrH() * .5) - (MaxH * .5));
	self:SetSize(MaxW, MaxH);
/*
	local MaxW, MaxH = ScrW() * .5;
	local MaxH = (ScrW() * (10 / 16)) * .53;
	self:SetPos((ScrW() * .5) - (MaxW * .5), (ScrH() * .5) - (MaxH * .5));
	self:SetSize(MaxW, MaxH);
*/	
	local bufferSize = 5;
	local availableWidth = self:GetWide() - 2 - ((INVENTORY_WIDTH + 1) * bufferSize);
	local sizeOfBlock = availableWidth / INVENTORY_WIDTH;
	
	for x = 1, INVENTORY_WIDTH do
		for y = 1, INVENTORY_HEIGHT do		
			local ox, oy = self:GetSize();
			GAMEMODE.InventoryBlocks[x][y]:SetPos(1 + (x * bufferSize) + ((x - 1) * sizeOfBlock), self:GetTall() - 1 - ((INVENTORY_HEIGHT - (y - 1)) * (bufferSize + sizeOfBlock)));
			GAMEMODE.InventoryBlocks[x][y]:SetSize(sizeOfBlock, sizeOfBlock);
			GAMEMODE.InventoryBlocks[x][y]:GrabItem();
		end
	end
	
	local size = (self:GetWide() - 1 - bufferSize * 3) * .5;
	self.Header:SetPos(size + bufferSize * 1.5 + 3, bufferSize + 1);
	self.Header:SetSize(size, size * .5);
	
	self.MainWeaponEquip:SetPos(size + bufferSize * 1.5 + 3, bufferSize * 2 + 1 + size * .5);
	local w, h = (size - bufferSize) * .5, self:GetTall() - (2 + bufferSize * 2.5 + INVENTORY_HEIGHT * (bufferSize + sizeOfBlock) + size * .5);
	self.MainWeaponEquip:SetSize(w, h);
	self.MainWeaponEquip:GrabItem();
	
	self.SideWeaponEquip:SetPos(size + bufferSize * 2.5 + 3 + w, bufferSize * 2 + 1 + size * .5);
	self.SideWeaponEquip:SetSize(w, h);
	self.SideWeaponEquip:GrabItem();
	
	self.Description:SetPos(bufferSize + 1, bufferSize + 1);
	self.Description:SetSize(size, self:GetTall() - (bufferSize * 2 + INVENTORY_HEIGHT * (bufferSize + sizeOfBlock)));
end

function PANEL:SetDescription ( itemTable )
	self.Description:SetDescription(itemTable);
	self.Header:SetDisplay(itemTable);
end

function PANEL:Paint ( )
	SKIN:PaintFrame(self, true);
end

vgui.Register("perp2_inventory", PANEL);