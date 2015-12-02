
local PANEL = {};

local wantedX, wantedY = 5, 5
function PANEL:Init ( )
	self.ourItemSlots = {};
	
	for x = 1, wantedX do
		self.ourItemSlots[x] = {};
		
		for y = 1, wantedY do
			self.ourItemSlots[x][y] = vgui.Create("perp2_shop_store_block", self);
		end
	end
	
	self.Description = true;
	self:SetSkin("ugperp")
end

function PANEL:PerformLayout ( )	
	local buffer = 5;
	
	local xPer = (self:GetWide() - (buffer * (wantedX + 1))) / wantedX
	local yPer = (self:GetTall() - (buffer * (wantedY + 1))) / wantedY
		
	for x = 1, wantedX do		
		for y = 1, wantedY do
			self.ourItemSlots[x][y]:SetSize(xPer, yPer);
			self.ourItemSlots[x][y]:SetPos(buffer * x + xPer * (x - 1), buffer * y + yPer * (y - 1));
		end
	end
end

function PANEL:Paint ( )
	SKIN:PaintFrame(self, true);
end

function PANEL:PushItem ( itemTable )
	for y = 1, wantedY do		
		for x = 1, wantedX do
			if (!self.ourItemSlots[x][y].itemTable) then
				self.ourItemSlots[x][y]:GrabItem(itemTable);
				return;
			end
		end
	end
end

function PANEL:SetDescription ( itemTable )
	self:GetParent():SetDescription(itemTable);
end

vgui.Register("perp2_shop_store", PANEL);