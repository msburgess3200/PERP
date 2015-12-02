


local PANEL = {};

local itemPic = {}
itemPic[1] = surface.GetTextureID("PERP2/inventory/inv_main");
itemPic[2] = surface.GetTextureID("PERP2/inventory/inv_side");

function PANEL:PerformLayout ( )

end

function PANEL:Paint ( )
	self:FunWithAlpha()
	
	local trueAlpha = self.ourAlpha;
	if (self.SuperGlow) then
		trueAlpha = trueAlpha - (10 + math.cos(CurTime() * 4) * 20);
		
		surface.SetDrawColor(0, 0, 150, 100);
		surface.DrawRect(1, 1, self:GetWide() - 2, self:GetTall() - 2);
	end
	
	surface.SetDrawColor(0, 0, 0, trueAlpha);
	surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall());
	
	surface.SetDrawColor(54, 54, 54, trueAlpha);
	surface.DrawRect(1, 1, self:GetWide() - 2, self:GetTall() - 2);
	
	if (!self.itemTable || (GAMEMODE.DraggingSomething && self.ModelPanel == GAMEMODE.DraggingSomething)) then
		surface.SetTexture(itemPic[self.itemID]);
		surface.SetDrawColor(150, 150, 150, self.ourAlpha);
		surface.DrawTexturedRect(0, 0, self:GetWide(), self:GetTall());
	end
end

function PANEL:SetMain ( isMain )
	if (isMain) then
		self.itemID = 1;
	else
		self.itemID = 2;
	end
end

vgui.Register("perp2_inventory_block_equip", PANEL, "perp2_inventory_block");