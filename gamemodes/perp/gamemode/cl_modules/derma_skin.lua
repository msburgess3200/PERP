


SKIN = {}

SKIN.PrintName 		= "PERP3"
SKIN.Author 		= ""
SKIN.DermaVersion	= 1

SKIN.colOutline	= Color(0, 0, 0, 250)

SKIN.control_color 				= Color( 100, 100, 100, 200 )
SKIN.control_color_highlight	= Color( 130, 130, 130, 200 )
SKIN.control_color_active 		= Color( 90, 130, 230, 200 )
SKIN.control_color_bright 		= Color( 255, 200, 100, 200 )
SKIN.control_color_dark 		= Color( 80, 80, 80, 200 )

SKIN.colButtonBorderHighlight	= Color( 255, 255, 255, 0 )
SKIN.colButtonBorderShadow		= Color( 0, 0, 0, 0 )

SKIN.colTabBG 					= Color(0, 0, 0, 255)
SKIN.colPropertySheet 			= Color(100, 100, 100, 255)
SKIN.colTab			 			= Color(150, 150, 150, 255)
SKIN.colTabInactive	 			= SKIN.colPropertySheet
SKIN.colTabText		 			= Color(255, 255, 255, 150)
SKIN.colTabTextInactive		 	= Color(205, 205, 205, 100)

SKIN.fontButton					= "DefaultSmall"
SKIN.fontTab					= "DefaultSmall"
SKIN.fontFrame					= "DebugFixed"
SKIN.fontForm 					= "DefaultSmall"
SKIN.fontLabel 					= "DefaultSmall"
SKIN.fontLargeLabel 			= "DefaultLarge"

function cutLength ( str, pW, font )
	surface.SetFont(font);
	
	local sW = pW - 40;
	
	for i = 1, string.len(str) do
		local sStr = string.sub(str, 1, i);
		local w, h = surface.GetTextSize(sStr);
		
		if (w > pW || (w > sW && string.sub(str, i, i) == " ")) then
			local cutRet = cutLength(string.sub(str, i + 1), pW, font);
			
			local returnTable = {sStr};
			
			for k, v in pairs(cutRet) do
				table.insert(returnTable, v);
			end
			
			return returnTable;
		end
	end
	
	return {str};
end

function SKIN:PaintTab( panel )
	surface.SetDrawColor(SKIN.colTabBG.r, SKIN.colTabBG.g, SKIN.colTabBG.b, SKIN.colTabBG.a);
	
	surface.DrawRect(0, 0, panel:GetWide(), panel:GetTall() + 8);
		
	if (panel:GetPropertySheet():GetActiveTab() == panel) then
		surface.SetDrawColor(SKIN.colTab.r, SKIN.colTab.g, SKIN.colTab.b, SKIN.colTab.a);
		surface.DrawRect(1, 1, panel:GetWide() - 2, panel:GetTall() + 8)
	else
		surface.SetDrawColor(SKIN.colTabInactive.r, SKIN.colTabInactive.g, SKIN.colTabInactive.b, SKIN.colTabInactive.a);
		surface.DrawRect(1, 1, panel:GetWide() - 2, panel:GetTall() + 8)
	end
end

function SKIN:PaintPropertySheet( panel )
	local ActiveTab = panel:GetActiveTab()
	local Offset = 0
	if ( ActiveTab ) then Offset = ActiveTab:GetTall() end
	
	// This adds a little shadow to the right which helps define the tab shape..
	
	surface.SetDrawColor(SKIN.colTabBG.r, SKIN.colTabBG.g, SKIN.colTabBG.b, SKIN.colTabBG.a);
	surface.DrawRect(0, Offset, panel:GetWide(), panel:GetTall() - Offset);
	surface.SetDrawColor(SKIN.colPropertySheet.r, SKIN.colPropertySheet.g, SKIN.colPropertySheet.b, SKIN.colPropertySheet.a);
	surface.DrawRect(1, 1 + Offset, panel:GetWide() - 2, panel:GetTall() - 2 - Offset);
end

function SKIN:SchemeForm ( panel )
	panel.Label:SetFont(SKIN.fontForm)
	panel.Label:SetTextColor(Color( 255, 255, 255, 255 ));
end

function SKIN:SchemeLabel( panel )
	local col = nil

	if ( panel.Hovered && panel:GetTextColorHovered() ) then
		col = panel:GetTextColorHovered()
	else
		col = panel:GetTextColor()
	end
	if (col) then
		panel:SetFGColor( col.r, col.g, col.b, col.a )
	else
		panel:SetFGColor( 200, 200, 200, 255 )
	end
	
	if (panel.BrokeAlready && panel.BrokeAlready == panel:GetValue()) then return; end
	
	local ourFont = SKIN.fontLabel;
	local isLarge = string.sub(panel:GetValue(), 1, 1) == ":";
	if (isLarge) then
		ourFont = SKIN.fontLargeLabel;
		panel:SetText(string.sub(panel:GetValue(), 2));
	end
	
	panel.BrokeAlready = panel:GetValue();
	panel:SetFont(ourFont);
end

function SKIN:DrawSquaredBox ( x, y, w, h, color )
	surface.SetDrawColor(color);
	surface.DrawRect(x, y, w, h);
	
	surface.SetDrawColor(self.colOutline);
	surface.DrawOutlinedRect(x, y, w, h);
end

function SKIN:PaintFrame ( panel, skipTop )
	local color = self.bg_color;

	self:DrawSquaredBox(0, 0, panel:GetWide(), panel:GetTall(), color)
	
	if (!skipTop) then
		surface.SetDrawColor(0, 0, 0, 75);
		surface.DrawRect(0, 0, panel:GetWide(), 21);
		
		surface.SetDrawColor(self.colOutline);
		surface.DrawRect(0, 21, panel:GetWide(), 1);
	end
end

function SKIN:PaintPanelList ( panel )
	if (panel.m_bBackground) then
		draw.RoundedBox(0, 0, 0, panel:GetWide(), panel:GetTall(), self.bg_color_dark);
	end
end

derma.DefineSkin("ugperp", "ugperp", SKIN);

PERP2_SKIN = SKIN;