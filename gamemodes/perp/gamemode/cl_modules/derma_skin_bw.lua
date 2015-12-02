
local SKIN = {}

// These are used in the settings panel

SKIN.PrintName 		= "ugperp"
SKIN.Author 		= "RedMist"
SKIN.DermaVersion	= 1

SKIN.colOutline	= Color( 51, 51, 51, 225 )

// You can change the colours from the Default skin

SKIN.colPropertySheet 			= Color( 225, 225, 225, 255 )
SKIN.colTab			 			= SKIN.colPropertySheet
SKIN.colTabText		 			= Color( 51, 51, 51, 225 )
SKIN.colTabInactive				= Color( 225, 225, 225, 225 )
SKIN.colTabShadow				= Color( 0, 0, 0, 225 )
SKIN.colButtonText				=  Color(0, 0, 0, 255)
SKIN.fontButton					= "Default"
SKIN.fontTab					= "Default"
SKIN.bg_color 					= Color( 0, 0, 0, 225 )
SKIN.bg_color_sleep 			= Color( 225, 225, 225, 225 )
SKIN.bg_color_dark				= Color( 0, 0, 0, 225 )
SKIN.bg_color_bright			= Color( 225, 225, 225, 255 )
SKIN.listview_hover				= Color( 31, 31, 31, 225 )
SKIN.listview_selected			= Color( 0, 0, 0, 225 )
SKIN.control_color 				= Color( 225, 225, 225, 225 )
SKIN.control_color_highlight	= Color( 225, 225, 225, 255 )
SKIN.control_color_active 		= Color( 31, 31, 31, 225 )
SKIN.control_color_bright 		= Color( 31, 31, 31, 225 )
SKIN.control_color_dark 		= Color( 31, 31, 31, 255 )
SKIN.text_bright				= Color( 0, 0, 0, 255 )
SKIN.text_normal				= Color( 51, 51, 51, 225 )
SKIN.text_dark					= Color( 150, 150, 150, 255 )
SKIN.text_highlight				= Color( 0, 0, 0, 20 )
SKIN.colCategoryText			= Color( 51, 51, 51, 255 )
SKIN.colCategoryTextInactive	= Color( 31, 31, 31, 255 )
SKIN.fontCategoryHeader			= "TabLarge"
SKIN.colTextEntryTextHighlight	= Color( 31, 31, 31, 255 )
SKIN.colTextEntryTextHighlight	= Color( 31, 31, 31, 255 )
SKIN.colCategoryText			= Color( 255, 255, 255, 255 )
SKIN.colCategoryTextInactive	= Color( 225, 225, 225, 255 )
SKIN.panel_transback			 =  Color(255, 255, 255, 50)
SKIN.fontCategoryHeader			= "TabLarge"

// Or any of the functions

function SKIN:DrawSquaredBox( x, y, w, h, color )

	surface.SetDrawColor( color )
	surface.DrawRect( x, y, w, h )
	
	surface.SetDrawColor( self.colOutline )
	surface.DrawOutlinedRect( x, y, w, h )

end

function SKIN:PaintFrame( panel )

	local color = self.bg_color

	self:DrawSquaredBox( 0, 0, panel:GetWide(), panel:GetTall(), color )
	
	surface.SetDrawColor( 0, 0, 0, 225 )
	surface.DrawRect( 0, 0, panel:GetWide(), 21 )
	
	surface.SetDrawColor( self.colOutline )
	surface.DrawRect( 0, 21, panel:GetWide(), 1 )

end

function SKIN:PaintPanel(panel)

	if(panel.m_bPaintBackground) then
	
		local w, h = panel:GetSize()
		self:DrawGenericBackground(0, 0, w, h, self.panel_transback)
		
	end	

end

function SKIN:SchemeButton(panel)

	panel:SetFont(self.fontButton)
	
	if(panel:GetDisabled()) then
		panel:SetTextColor(self.colButtonTextDisabled)
	else
		panel:SetTextColor(self.colButtonText)
	end
	
	DLabel.ApplySchemeSettings(panel)

end

// Or just start a new skin from scratch by overriding the whole thing


//
// You need to add this to the bottom of your skin to register it in Derma.
// Parameters are name (which should have no spaces or special chacters), description, then the SKIN table
//

derma.DefineSkin( "ugperp", "ugperp", SKIN )