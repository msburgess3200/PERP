function CustomizeCarWindow( ID )
	
	local Vtable = VEHICLE_DATABASE[ID]

	local DermaPanel = vgui.Create( "DFrame" )
	DermaPanel:SetPos( 0, 0 )
	DermaPanel:SetSize( 200, 705 )
	DermaPanel:SetTitle( "Car Color" )
	DermaPanel:SetVisible( true )
	DermaPanel:SetDraggable( false )
	DermaPanel:ShowCloseButton( false )
	DermaPanel:MakePopup()
	
	local panelList = vgui.Create("DPanelList", DermaPanel);
	panelList:EnableHorizontal(false);
	panelList:EnableVerticalScrollbar(true);
	panelList:StretchToParent(5, 30, 5, 5);
	panelList:SetSpacing(18);
	panelList:SetPadding(5);
	
	local Switch = false;
	local colorCube = vgui.Create( "DColorMixer", DermaPanel )
	colorCube:SetPos( 10, 30 )
	colorCube:SetSize( 100, 300 )
	colorCube:SetAlphaBar(false)
	colorCube:SetBaseColor( Color( 255, 255, 255 ) )
	colorCube.ValueChanged = function()
		Switch = true;
		local rgbT2 = colorCube:GetColor()
		if !rgbT2 then return; end
		RunConsoleCommand("perp_scrgb", rgbT2.r, rgbT2.g, rgbT2.b)
	end

	-- local colorCircle = vgui.Create( "DColorCircle", DermaPanel )
	-- colorCircle:SetPos( 10, 30 )
	-- colorCircle:SetSize( 180, 180 )
	-- colorCircle.PaintOver = function()
	-- 	local rgbT = colorCircle:GetRGB()
	-- 	if !rgbT || Switch then return; end
	-- 	colorCube:SetColor(Color(rgbT.r, rgbT.g, rgbT.b))
	-- 	RunConsoleCommand("perp_scrgb", rgbT.r, rgbT.g, rgbT.b)
	-- end
	
	local button0 = vgui.Create( "DButton", DermaPanel )
	button0:SetSize( 180, 20 )
	button0:SetPos( 10, 515 )
	button0:SetText( "Reset" )
	button0.DoClick = function( button0 )
		Switch = false;
	end
	
	panelList:AddItem(colorCircle);
	panelList:AddItem(button0);
	panelList:AddItem(colorCube);
	
	local button = vgui.Create( "DButton", DermaPanel )
	button:SetSize( 180, 20 )
	button:SetPos( 10, 490 )
	button:SetText( "Finish" )
	button.DoClick = function( button )
		Derma_Query("Are you sure you're done? This will be $10,000.", "Vehicle Customize",
		"No...", function() end,
		"Yeah, I'm done.", function()
			local VColor = colorCube:GetColor()
			RunConsoleCommand("perp_customize_this_shit", VColor.r, VColor.g, VColor.b)
			DermaPanel:Remove();
			LocalPlayer().Customizing = false;
		end)
	end
	panelList:AddItem(button);
	
	local button2 = vgui.Create( "DButton", DermaPanel )
	button2:SetSize( 180, 20 )
	button2:SetPos( 10, 515 )
	button2:SetText( "Cancel" )
	button2.DoClick = function( button2 )
		DermaPanel:Remove();
		RunConsoleCommand("perp_remove_car");
		LocalPlayer().Customizing = false;
	end
	panelList:AddItem(button2);
	
end