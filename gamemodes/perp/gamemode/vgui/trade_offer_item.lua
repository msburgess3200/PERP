


local PANEL = {};

function PANEL:Think ( ) end

PANEL.otherGrabItem = PANEL.GrabItem;

function PANEL:OnMousePressed ( MouseCode )	

end

function PANEL:OnMouseReleased( MouseCode )

end

vgui.Register("perp2_trade_offer_item", PANEL, "perp2_inventory_block_item");