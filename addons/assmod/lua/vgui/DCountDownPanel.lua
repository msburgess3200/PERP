/////////////////////////////////////////
// © 2010-2020 D3luX - D3luX-Gaming    //
//    All rights reserved    		   //
/////////////////////////////////////////
// This material may not be  		   //
//   reproduced, displayed,  		   //
//  modified or distributed  		   //
// without the express prior 		   //
// written permission of the 		   //
//   the copyright holder.  		   //
//		D3luX-Gaming.com   			   //
/////////////////////////////////////////

PANEL = {}

function PANEL:Init()
	self.m_bBackground = true
	self.StartTime = CurTime()
	self.Duration = self.Duration or 0
	self.CountDown = vgui.Create("DLabel", self)
	self.Info = vgui.Create("DLabel", self)
	
	self.CountDown:SetFont("CloseCaption_Bold")
	self.Info:SetFont("CloseCaption_Bold")

	self:SetAlpha( 0 )
	self.animFade = Derma_Anim( "Fade", self, self.Fade )
	self.animFade:Start( 1, { Out = false } )
end

function PANEL:Reset( TEXT, DURATION )

	self.StartTime = CurTime()
	self.Duration = DURATION
	self.Info:SetText( TEXT )
	
	self:InvalidateLayout()
	
end

function PANEL:Fade(anim, delta, data)
	
	if ( anim.Finished ) then
	
		if (data.Out) then
			self:SetAlpha( 0 )
			self.CurrentNotice = 0
		else
			self:SetAlpha( 255 )
		end
		
		return 
		
	end

	if (data.Out) then
		self:SetPos( 0 - (self:GetTall() * delta) )
	else
		self:SetAlpha( (delta * 255) )
	end
	
end


function PANEL:PerformLayout()
	
	self.Info:SizeToContents()
	self.CountDown:SizeToContents()

	self.Info:SetPos( 8, 4 )
	self.CountDown:SetPos( 8, self.Info:GetTall() + 8 )

	self:SetTall( self.Info:GetTall() + self.CountDown:GetTall() + 16 )
	
	local width = self.Info:GetWide()
	if (width > self.CountDown:GetWide()) then
		self:SetWide(width + 16)
	else
		self:SetWide(self.CountDown:GetWide() + 16)
	end
end

function PANEL:Think()

	local timeLeft = (self.StartTime + self.Duration) - CurTime()
	self.CountDown:SetText( string.FormattedTime( timeLeft, "%02i:%02i:%02i") )

end

function PANEL:Paint()

	
	self.Info:SetFGColor( 40, 40, 40, 255 )
	self.CountDown:SetFGColor( 40, 40, 40, 255 )
	derma.SkinHook( "Paint", "Menu", self, self:GetWide(),self:GetTall() )
	derma.SkinHook( "PaintOver", "Menu", self,self:GetWide(),self:GetTall() )

end

derma.DefineControl( "DCountDownPanel", "Countdown panel", PANEL, "Panel" )
