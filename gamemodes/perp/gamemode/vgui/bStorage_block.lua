


local PANEL = {};

local highestAlpha = 230;
local lowestAlpha = 170;

local unOccupied = surface.GetTextureID("PERP2/inventory/inv_empty");

function PANEL:Init ( )
	self:SetVisible(true);
	self.NextChangeVisi = CurTime();
	self.ourAlpha = 230;
end

function PANEL:PerformLayout ( )

end

function PANEL:FunWithAlpha ( )
	local cursorIn = false;
	local cx, cy = self:CursorPos()
	
	if (cx > 0 && cy > 0 && cx < self:GetWide() && cy < self:GetTall()) then
		cursorIn = true;
	end
		
	if (cursorIn && !self.cursorIn) then
		self:OnCursorEntered_Real()
	elseif (!cursorIn && self.cursorIn) then
		self:OnCursorExited_Real();
	end
	
	if (self.NextChangeVisi <= CurTime()) then
		self.NextChangeVisi = CurTime() + (1 / 200);
		
		if ((self.cursorIn || self.SuperGlow) && self.ourAlpha > lowestAlpha) then
			self.ourAlpha = self.ourAlpha - 1;
		elseif (!self.cursorIn && !self.SuperGlow && self.ourAlpha < highestAlpha) then
			self.ourAlpha = self.ourAlpha + 1;
		end
	end
end

function PANEL:Paint ( )
	self:FunWithAlpha()
	
	surface.SetTexture(unOccupied);
	
	local trueAlpha = self.ourAlpha;
	if (self.SuperGlow) then
		trueAlpha = trueAlpha - (10 + math.sin(CurTime() * 4) * 20);
	end
	
	if (self.actualItem) then
		draw.SimpleText(self.actualItem.Quantity, "Default", 3, 1, Color(255, 255, 255, 255), 0, 0);
	end

	surface.SetDrawColor(0, 0, 0, trueAlpha);
	surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall());
	
	if (self.IsShop && self.itemTable && self.itemTable.RestrictedSelling) then
		surface.SetDrawColor(255, 100, 100, trueAlpha);
	elseif (self.SelectedForTrade) then
		surface.SetDrawColor(170 + math.sin(CurTime() * 4) * 40, 170 + math.sin(CurTime() * 4) * 40, 255, trueAlpha);
	else
		surface.SetDrawColor(255, 255, 255, trueAlpha);
	end
	
	surface.DrawTexturedRect(1, 1, self:GetWide() - 2, self:GetTall() - 2);
end

function PANEL:SetCoordinates ( x, y )
	self.XPos = x;
	self.YPos = y;
	self.itemID = 2 + (y - 1) * INVENTORY_WIDTH + x;
end

function PANEL:OnCursorEntered_Real ( )
	self.cursorIn = true;
	if self.IsBank then return; end
	
	if self.SuperGlow then return false; end
	
	if (self:GetParent().Description && self.itemTable) then
		self:GetParent():SetDescription(self.itemTable);
	end
end

function PANEL:OnCursorExited_Real ( )
	self.cursorIn = false;
	if self.IsBank then return; end
	
	if (self:GetParent().Description) then
		self:GetParent():SetDescription(nil);
	end
end

function PANEL:GrabItem ( )
	if (GAMEMODE.StorageItems[self.itemID]) then
		self.itemTable = ITEM_DATABASE[GAMEMODE.StorageItems[self.itemID].ID];
		self.actualItem = GAMEMODE.StorageItems[self.itemID];
		
		if (!self.ModelPanel) then
			self.ModelPanel = vgui.Create('perp_storage_block_item', self:GetParent());
		end
		
		print("THE PARENT IS..... '" .. self:GetParent() .. "'");
		local x, y = self:GetPos()
		self.ModelPanel:SetPos(x + 1, y + 1);
		self.ModelPanel:SetSize(self:GetWide() - 2, self:GetTall() - 2);
		self.ModelPanel:SetItemTable(self.itemTable);
		self.ModelPanel.trueParent = self;
	else
		self.itemTable = nil;
		self.actualItem = nil;
		
		if (self.ModelPanel) then
			self.ModelPanel:Remove();
			self.ModelPanel = nil;
		end
	end
end

function PANEL:SetSuperGlow ( tf )
	self.SuperGlow = tf;
end

vgui.Register("perp_storage_block", PANEL);