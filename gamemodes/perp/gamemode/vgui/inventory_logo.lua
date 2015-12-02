


local PANEL = {};

local unOccupied = surface.GetTextureID("PERP2/inventory/inv_background_pdv2");

function PANEL:Init ( )
	
	self:SetVisible(true);
	
	self.NextChangeVisi = CurTime();
	self.ourAlpha = 255;
end

function PANEL:PerformLayout ( )

end

function PANEL:Paint ( )
	if (self.NextChangeVisi <= CurTime()) then
		self.NextChangeVisi = CurTime() + (1 / 200);
		
		if (self.itemTable) then
			self.ourAlpha =  math.Clamp(self.ourAlpha - (transitionSpeed * .2), 200, 255);
		else
			self.ourAlpha =  math.Clamp(self.ourAlpha + (transitionSpeed * .2), 200, 255);
		end
	end

	surface.SetTexture(unOccupied);
	local oa = math.Clamp(self.ourAlpha, 200, 255);
	
	surface.SetDrawColor(0, 0, 0, 255);
	surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall());
	
	surface.SetDrawColor(255, 255, 255, oa);
	surface.DrawTexturedRect(1, 1, self:GetWide() - 2, self:GetTall() - 2);
end

function PANEL:SetDisplay ( itemTable )
	self.itemTable = itemTable;
	
end

vgui.Register("perp2_inventory_logo", PANEL);