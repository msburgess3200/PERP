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

	self.List = vgui.Create("DPanelList", self)
	self.List:EnableVerticalScrollbar()

	self.CancelButton = vgui.Create("DButton", self)
	self.CancelButton:SetText("Cancel")
	self.CancelButton.DoClick = function(BTN) self:Close() end

end

function PANEL:PerformLayout()

	derma.SkinHook( "Layout", "Frame", self )

	self.List:SetTall(200)
	
	self.CancelButton:SizeToContents()
	self.CancelButton:SetWide(self.CancelButton:GetWide() + 16)
	self.CancelButton:SetTall(self.CancelButton:GetTall() + 8)

	local height = 32
		
		height = height + self.List:GetTall()
		height = height + 8
		height = height + self.CancelButton:GetTall()
		height = height + 8

	self:SetTall(height)
	
	local width = self:GetWide()

	self.List:SetPos( 8, 32 )
	self.List:SetWide( width - 16 )
	
	local btnY = 32 + self.List:GetTall() + 8
	self.CancelButton:SetPos( width - 8 - self.CancelButton:GetWide(), btnY )
end

function PANEL:RemoveItem(BTN)
	self.List:RemoveItem(BTN)
	self:PerformLayout()
end

derma.DefineControl( "DSingleChoiceDialog", "A simple list dialog", PANEL, "DFrame" )

function PromptForChoice( TITLE, SELECTION, FUNCTION, ... )

	local TE = vgui.Create("DSingleChoiceDialog")
	TE:SetBackgroundBlur( true )
	TE:SetDrawOnTop( true )
	for k,v in pairs(SELECTION) do
		local item = vgui.Create("DButton")
		item:SetText( v.Text )
		item.DoClick = 
			function(BTN) 
				TE.Selection = item
				PCallError( FUNCTION, TE, v, unpack(arg) )
			end

		TE.List:AddItem(item)
	end
	TE:SetTitle(TITLE)
	TE:SetVisible( true )
	TE:SetWide(300)
	TE:PerformLayout()
	TE:Center()
	TE:MakePopup()
			
end

/*
concommand.Add("list_entry_test", 
		function()
		
			local test_items = {
				{	Text = "Hello", 	OtherData = 12		},
				{	Text = "Hello 2", 	OtherData = 113		},
				{	Text = "Hello 3", 	OtherData = "A"		},
				{	Text = "Hello 4", 	OtherData = "Ban"	},
			}
		
			PromptForChoice("Select something", test_items,
				function(DLG, ITEM, PARAM)
					Msg("Text is " .. ITEM.Text .. " param is " .. PARAM .. "\n")
					DLG:Close()
				end,
				99
				)
				
			
		end
	)
*/