


local function showItemView ( Player )
	if (!Player:IsOwner()) then return; end
	
	if DEV_VCO_Panel then DEV_VCO_Panel:Remove(); end

	local DEV_VCO_LOOKAT_X = 0;
	local DEV_VCO_LOOKAT_Y = 0;
	local DEV_VCO_LOOKAT_Z = 0;
	local DEV_VCO_CAMPOS_X = 0;
	local DEV_VCO_CAMPOS_Y = 0;
	local DEV_VCO_CAMPOS_Z = 0;

	DEV_VCO_Panel = vgui.Create('DFrame');

	DEV_VCO_Panel:SetSize(256, 720);
	DEV_VCO_Panel:SetPos(0, 0);
	DEV_VCO_Panel:MakePopup();
	DEV_VCO_Panel:SetAlpha(150);
	DEV_VCO_Panel:ShowCloseButton(true);
	DEV_VCO_Panel:SetDraggable(true)
	DEV_VCO_Panel:SetTitle('PERP2 Developer Tool - Vector Coordinator');

	local OptionsForm = vgui.Create( "DForm", DEV_VCO_Panel)
	OptionsForm:SetPos(25, 30)
	OptionsForm:SetSize(DEV_VCO_Panel:GetWide() - 50)
	OptionsForm:SetSpacing(10)
	OptionsForm:SetName("Options")
	OptionsForm.Paint = function()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawOutlinedRect( 0, 0, OptionsForm:GetWide(), OptionsForm:GetTall() )
	end

	local ModelOptions = vgui.Create("DTextEntry")
	ModelOptions:SetValue('models/error.mdl')
	ModelOptions:SizeToContents()
	OptionsForm:AddItem(ModelOptions)

	local RotateOptions = vgui.Create("DCheckBoxLabel")
	RotateOptions:SetText("Rotate?")
	RotateOptions:SetValue(0)
	RotateOptions:SizeToContents()
	OptionsForm:AddItem(RotateOptions)

	local OuputVectors = vgui.Create("DButton")
	OuputVectors:SetText("\nOutput Vectors\n")
	OuputVectors:SizeToContents()
	OptionsForm:AddItem(OuputVectors)

	local CamPosForm = vgui.Create( "DForm", DEV_VCO_Panel)
	CamPosForm:SetPos(25, 30)
	CamPosForm:SetSize(DEV_VCO_Panel:GetWide() - 50)
	CamPosForm:SetSpacing(10)
	CamPosForm:SetName("Camera Position")
	CamPosForm.Paint = function()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawOutlinedRect( 0, 0, CamPosForm:GetWide(), CamPosForm:GetTall() )
	end
	OptionsForm:AddItem(CamPosForm)

	local CamPos_X = vgui.Create("DNumSlider")
	CamPos_X:SetText("Camera Position: X")
	CamPos_X:SetMin(-100)
	CamPos_X:SetMax(100)
	CamPos_X:SetDecimals(0)
	CamPos_X:SetValue(0)
	CamPosForm:AddItem(CamPos_X) 

	local CamPos_Y = vgui.Create("DNumSlider")
	CamPos_Y:SetText("Camera Position: Y")
	CamPos_Y:SetMin(-100)
	CamPos_Y:SetMax(100)
	CamPos_Y:SetDecimals(0)
	CamPos_Y:SetValue(0)
	CamPosForm:AddItem(CamPos_Y) 

	local CamPos_Z = vgui.Create("DNumSlider")
	CamPos_Z:SetText("Camera Position: Z")
	CamPos_Z:SetMin(-100)
	CamPos_Z:SetMax(100)
	CamPos_Z:SetDecimals(0)
	CamPos_Z:SetValue(0)
	CamPosForm:AddItem(CamPos_Z) 

	local LookAtForm = vgui.Create( "DForm", DEV_VCO_Panel)
	LookAtForm:SetPos(25, 30)
	LookAtForm:SetSize(DEV_VCO_Panel:GetWide() - 50)
	LookAtForm:SetSpacing(10)
	LookAtForm:SetName("Look At")
	LookAtForm.Paint = function()
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawOutlinedRect( 0, 0, LookAtForm:GetWide(), LookAtForm:GetTall() )
	end
	OptionsForm:AddItem(LookAtForm)

	local LookAt_X = vgui.Create("DNumSlider")
	LookAt_X:SetText("Look At: X")
	LookAt_X:SetMin(-100)
	LookAt_X:SetMax(100)
	LookAt_X:SetDecimals(0)
	LookAtForm:AddItem(LookAt_X) 

	local LookAt_Y = vgui.Create("DNumSlider")
	LookAt_Y:SetText("Look At: Y")
	LookAt_Y:SetMin(-100)
	LookAt_Y:SetMax(100)
	LookAt_Y:SetDecimals(0)
	LookAtForm:AddItem(LookAt_Y) 

	local LookAt_Z = vgui.Create("DNumSlider")
	LookAt_Z:SetText("Look At: Z")
	LookAt_Z:SetMin(-100)
	LookAt_Z:SetMax(100)
	LookAt_Z:SetDecimals(0)
	LookAt_Z:SetValue(0)
	LookAtForm:AddItem(LookAt_Z) 

	local ModelPanel = vgui.Create("DModelPanel")
	ModelPanel:SetModel('models/error.mdl');
	OptionsForm:AddItem(ModelPanel) 
	ModelPanel:SetTall(100);
	ModelPanel:SetWide(100);
	function ModelPanel:LayoutEntity( Entity ) end

	local function DEV_UpdateLookAt ( )
		ModelPanel:SetLookAt(Vector(DEV_VCO_LOOKAT_X, DEV_VCO_LOOKAT_Y, DEV_VCO_LOOKAT_Z));
	end

	local function DEV_UpdateCamPos ( )
		ModelPanel:SetCamPos(Vector(DEV_VCO_CAMPOS_X, DEV_VCO_CAMPOS_Y, DEV_VCO_CAMPOS_Z));
	end

	function RotateOptions:OnChange ( IsChecked )
		if !IsChecked then
			function ModelPanel:LayoutEntity( Entity ) end
		else
			function ModelPanel:LayoutEntity( Entity )
				if ( self.bAnimated ) then
					self:RunAnimation()
				end
				
				Entity:SetAngles( Angle( 0, RealTime()*10,  0) )
			end
		end
	end

	function ModelOptions:OnTextChanged ( )
		local NewModel = self:GetValue();
		
		if file.Exists('../' .. NewModel,"GAME") then
			ModelPanel:SetModel(NewModel)
		elseif ModelPanel.Entity:GetModel() != 'models/error.mdl' then
			ModelPanel:SetModel('models/error.mdl');
		end
	end

	function OuputVectors:DoClick ( )
		Msg("ITEM.ModelCamPos = Vector(" .. DEV_VCO_CAMPOS_X .. ", " .. DEV_VCO_CAMPOS_Y .. ", " .. DEV_VCO_CAMPOS_Z .. ");\nITEM.ModelLookAt = Vector(" .. DEV_VCO_LOOKAT_X .. ", " .. DEV_VCO_LOOKAT_Y .. ", " .. DEV_VCO_LOOKAT_Z .. ");");
		
	end

	function CamPos_X:OnValueChanged ( ValX )
		DEV_VCO_CAMPOS_X = ValX;
		
		DEV_UpdateCamPos();
	end

	function CamPos_Y:OnValueChanged ( ValY )
		DEV_VCO_CAMPOS_Y = ValY;
		
		DEV_UpdateCamPos();
	end

	function CamPos_Z:OnValueChanged ( ValZ )
		DEV_VCO_CAMPOS_Z = ValZ;
		
		DEV_UpdateCamPos();
	end

	function LookAt_X:OnValueChanged ( ValX )
		DEV_VCO_LOOKAT_X = ValX;
		
		DEV_UpdateLookAt();
	end

	function LookAt_Y:OnValueChanged ( ValY )
		DEV_VCO_LOOKAT_Y = ValY;
		
		DEV_UpdateLookAt();
	end

	function LookAt_Z:OnValueChanged ( ValZ )
		DEV_VCO_LOOKAT_Z = ValZ;
		
		DEV_UpdateLookAt();
	end
end
concommand.Add("perp_iv", showItemView);