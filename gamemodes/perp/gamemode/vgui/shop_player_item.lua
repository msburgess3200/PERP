


local PANEL = {};

function PANEL:Think ( ) end

PANEL.otherGrabItem = PANEL.GrabItem;

function PANEL:OnMousePressed ( MouseCode )	
	if (MouseCode == MOUSE_LEFT) then
		GAMEMODE.SellItem(self.trueParent.itemID, 1);
	elseif (MouseCode == MOUSE_RIGHT) then
		GAMEMODE.SellItem(self.trueParent.itemID, 5);
	end
end

function PANEL:OnMouseReleased( MouseCode )

end

vgui.Register("perp2_shop_player_item", PANEL, "perp2_inventory_block_item");