

local PANEL = {};

function PANEL:Init ( )
	self:SetVisible(true);
	self.NextChangeVisi = CurTime();
	self.ourAlpha = 230;
	self.IsBank = true;
	self:SetSkin("ugperp")
end

function PANEL:GrabItem ( dontScrewAlpha )
	if (GAMEMODE.StorageItems[self.itemID]) then
		self.itemTable = ITEM_DATABASE[GAMEMODE.StorageItems[self.itemID].ID];
		self.actualItem = GAMEMODE.StorageItems[self.itemID];
		
		if (!self.ModelPanel) then
			self.ModelPanel = vgui.Create('perp_bank_storage_item', self:GetParent());
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

vgui.Register("perp_bank_storage_block", PANEL, "perp_storage_block");