


function GM.Select_Clothes ( )
	local Models = {};
	
	local sexID = LocalPlayer():GetSex();
	if (sexID == "m") then sexID = SEX_MALE; end
	if (sexID == "f") then sexID = SEX_FEMALE; end
	
	local realID = "m";
	if (sexID == SEX_FEMALE) then realID = "f" end;
	
	local face = LocalPlayer():GetFace();
	for k, v in pairs(MODEL_AVAILABLE[realID][face]) do
		if (v < 10) then
			table.insert(Models, {LocalPlayer():GetModelPath(realID, face, v), realID .. "_" .. face .. "_0" .. v});
		else
			table.insert(Models, {LocalPlayer():GetModelPath(realID, face, v), realID .. "_" .. face .. "_" .. v});
		end
	end
	
	local curModelReference = 1;

	local W, H = 200, 270;
	
	AccountCreationScreen = vgui.Create("DFrame")
	AccountCreationScreen:SetPos(ScrW() * .5 - W * .5, ScrH() * .5 - H * .5)
	AccountCreationScreen:SetSize(W, H)
	AccountCreationScreen:SetTitle("Character Clothes")
	AccountCreationScreen:SetVisible(true)
	AccountCreationScreen:SetDraggable(false)
	AccountCreationScreen:ShowCloseButton(false)
	AccountCreationScreen:MakePopup()
	AccountCreationScreen:SetAlpha(GAMEMODE.GetGUIAlpha());
	AccountCreationScreen:SetSkin("ugperp")
	
	local PanelSize = W - 10;
	local UsCash = vgui.Create("DPanelList", AccountCreationScreen);
	UsCash:EnableHorizontal(false)
	UsCash:EnableVerticalScrollbar(true)
	UsCash:StretchToParent(5, 30, 5, 5);
	UsCash:SetPadding(5);
	
	local ModelPanel = vgui.Create('DModelPanel', AccountCreationScreen);
	ModelPanel:SetPos(5, 30);
	ModelPanel:SetSize(W - 20, W - 20);
	ModelPanel:SetFOV(70);
	ModelPanel:SetModel(Models[curModelReference][1]);
	
	local iSeq = ModelPanel.Entity:LookupSequence('walk_all');
	ModelPanel.Entity:ResetSequence(iSeq);
	
	function ModelPanel:LayoutEntity( Entity ) self:RunAnimation(); Entity:SetAngles( Angle( 0, RealTime()*20,  0) ); end

	local ourModel = Models[curModelReference][2]
	
	local r110 = (W - 25) * .5
	local LeftButton = vgui.Create("DButton", AccountCreationScreen);
	LeftButton:SetPos(10, H - 55);
	LeftButton:SetSize(r110, 20);
	LeftButton:SetText("<");
	
	function LeftButton:DoClick ( )
		curModelReference = curModelReference - 1;
		if (curModelReference < 1) then
			curModelReference = #Models;
		end
		
		ModelPanel:SetModel(Models[curModelReference][1]);
		ourModel = Models[curModelReference][2];
	end
		
	local RightButton = vgui.Create("DButton", AccountCreationScreen);
	RightButton:SetPos(15 + r110, H - 55);
	RightButton:SetSize(r110, 20);
	RightButton:SetText(">");
		
	function RightButton:DoClick ( )
		curModelReference = curModelReference + 1;
		if (curModelReference > #Models) then
			curModelReference = 1;
		end
			
		ModelPanel:SetModel(Models[curModelReference][1]);
		ourModel = Models[curModelReference][2];
	end
	
	local SubmitButton = vgui.Create("DButton", AccountCreationScreen);
	SubmitButton:SetPos(10, H - 30);
	SubmitButton:SetSize(W - 20, 20);
	SubmitButton:SetText("Confirm");
		
	function SubmitButton:DoClick ( )
		AccountCreationScreen:Remove();
			
		RunConsoleCommand("perp_cc", ourModel);
	end
end
