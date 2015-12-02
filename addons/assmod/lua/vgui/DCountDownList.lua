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

	self.Panels = {}
	
end

function PANEL:AddCountdown( NAME, TEXT, DURATION )

	if (NAME) then
		for k,v in pairs(self.Panels) do

			if (v.Name == NAME) then

				v:Reset(TEXT, DURATION)
				self:InvalidateLayout()
				return

			end

		end
	end
	
	local newPanel = vgui.Create("DCountDownPanel", self)
	newPanel.Name = NAME
	newPanel:Reset(TEXT, DURATION)

	table.insert(self.Panels, newPanel)
	self:InvalidateLayout()

end

function PANEL:AddProgress( NAME, TEXT, MAX )
	
	for k,v in pairs(self.Panels) do

		if (v.Name == NAME) then

			v:Reset(TEXT, MAX)
			self:InvalidateLayout()
			return

		end

	end
	
	local newPanel = vgui.Create("DProgressPanel", self)
	newPanel.Name = NAME
	newPanel:Reset(TEXT, MAX)

	table.insert(self.Panels, newPanel)
	self:InvalidateLayout()
end

function PANEL:IncProgress( NAME, CURRENT )
	for k,v in pairs(self.Panels) do
		if (v.Name == NAME) then
			v.Current = v.Current + (CURRENT || 1)
			if (v.Current >= v.Max) then
				self:RemoveCountdown(NAME)
			end
			break
		end
	end	
end

function PANEL:RemoveCountdown( name )

	for k,v in pairs(self.Panels) do
	
		if (v.Name == name) then
		
			v:Remove()
			table.remove(self.Panels, k)
		
		end
	
	end
	self:InvalidateLayout()

end

function PANEL:PerformLayout()
	
	local yPos = 0
	local bigWidth = 0
	for k,v in pairs(self.Panels) do
	
		v.Info:InvalidateLayout()
		v.CountDown:InvalidateLayout()
		
		if ( v.Info:GetWide() + 16 > bigWidth ) then
			bigWidth = v.Info:GetWide() + 16
		end
		if ( v.CountDown:GetWide() + 16 > bigWidth ) then
			bigWidth = v.CountDown:GetWide() + 16
		end
		

		v:PerformLayout()
		v:SetPos( 0, yPos )
		
		yPos = yPos + v:GetTall() + 2
	end
	
	for k,v in pairs(self.Panels) do
		v.Info:SetWide(bigWidth-16)
		v.CountDown:SetWide(bigWidth-16)
		v:SetSize( bigWidth, v:GetTall() )
	end	

	self:SetSize(bigWidth,yPos)
	self:SetPos( ScrW() - bigWidth, 0 )
end

function PANEL:Paint()
	
	for k,v in pairs(self.Panels) do
	
		if (v.Duration) then
			if (CurTime() > v.Duration + v.StartTime) then

				v:Remove()
				table.remove(self.Panels, k)

				self:InvalidateLayout()

			end
		end	

		if (v.Max) then
			if (v.Current >= v.Max) then

				v:Remove()
				table.remove(self.Panels, k)

				self:InvalidateLayout()

			end
		end	
	end

	return false
end

derma.DefineControl( "DCountDownList", "Countdown panel list", PANEL, "Panel" )

