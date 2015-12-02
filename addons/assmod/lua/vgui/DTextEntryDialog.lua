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

	self.Text = vgui.Create("DTextEntry", self)
	
	self.OkButton = vgui.Create("DButton", self)
	self.OkButton:SetText("Ok")
	self.OkButton.DoClick = function(BTN) PCallError( self.OnOk, self, self.Text:GetValue(), unpack(self.Params) ) end
	
	self.CancelButton = vgui.Create("DButton", self)
	self.CancelButton:SetText("Cancel")
	self.CancelButton.DoClick = function(BTN) self:Close() end

end

function PANEL:PerformLayout()

	derma.SkinHook( "Layout", "Frame", self )

	self.Text:SetTall(18)
	self.OkButton:SizeToContents()
	self.CancelButton:SizeToContents()
	if (self.OkButton:GetWide() + 16 > self.CancelButton:GetWide() + 16) then
		self.OkButton:SetWide(self.OkButton:GetWide() + 16)
		self.CancelButton:SetWide(self.OkButton:GetWide() + 16)
	else
		self.OkButton:SetWide(self.CancelButton:GetWide() + 16)
		self.CancelButton:SetWide(self.CancelButton:GetWide() + 16)
	end
	if (self.OkButton:GetTall() + 8 > self.CancelButton:GetTall() + 8) then
		self.OkButton:SetTall(self.OkButton:GetTall() + 8)
		self.CancelButton:SetTall(self.OkButton:GetTall() + 8)
	else
		self.OkButton:SetTall(self.CancelButton:GetTall() + 8)
		self.CancelButton:SetTall(self.CancelButton:GetTall() + 8)
	end	
	local height = 32
		
		height = height + self.Text:GetTall()
		height = height + 8
		height = height + self.OkButton:GetTall()
		height = height + 8

	self:SetTall(height)
	
	local width = self:GetWide()

	self.Text:SetPos( 8, 32 )
	self.Text:SetWide( width - 16 )
	
	local btnY = 32 + self.Text:GetTall() + 8
	self.OkButton:SetPos( width - 8 - self.CancelButton:GetWide() - 8 - self.OkButton:GetWide(), btnY )
	self.CancelButton:SetPos( width - 8 - self.CancelButton:GetWide(), btnY )
end

derma.DefineControl( "DTextEntryDialog", "A simple text entry dialog", PANEL, "DFrame" )

function PromptForText( TITLE, DEFAULT, FUNCTION, ... )

	local TE = vgui.Create("DTextEntryDialog")
	TE.Text:SetText( DEFAULT or "" )
	TE.OnOk = FUNCTION
	TE.Params = arg
	TE:SetTitle(TITLE)
	TE:SetVisible( true )
	TE:SetWide(300)
	TE:PerformLayout()
	TE:Center()
	TE:MakePopup()
			
end

/*
concommand.Add("text_entry_test", 
		function()
		
			PromptForText("Put some text", "Hello",
				function(DLG, TEXT, PARAM)
					Msg("Text is " .. TEXT .. " param is " .. PARAM .. "\n")
					DLG:Close()
				end,
				10
				)
				
			
		end
	)
*/