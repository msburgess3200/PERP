


function GM.Select_Face ( )
	local Models = {};
	
	local sexID = LocalPlayer():GetSex();
	
	local clothInfo = LocalPlayer():GetClothes() or 1;
	local clothInfoD = tostring(clothInfo);
	if (clothInfo < 10) then clothInfoD = "0" .. clothInfoD; end
	
	if (sexID == SEX_MALE) then
		for k, v in pairs(MODEL_AVAILABLE["m"]) do table.insert(Models, {SEX_MALE, LocalPlayer():GetModelPath("m", k, clothInfo), "m_" .. k .. "_" .. clothInfoD}); end
	else
		for k, v in pairs(MODEL_AVAILABLE["f"]) do table.insert(Models, {SEX_FEMALE, LocalPlayer():GetModelPath("f", k, clothInfo), "f_" .. k .. "_" .. clothInfoD}); end
	end
	
	local curModelReference = 1;

	local W, H = 200, 270;
	
	AccountCreationScreen = vgui.Create("DFrame")
	AccountCreationScreen:SetPos(ScrW() * .5 - W * .5, ScrH() * .5 - H * .5)
	AccountCreationScreen:SetSize(W, H)
	AccountCreationScreen:SetTitle("Character Facial")
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
	ModelPanel:SetCamPos(Vector(14, 0, 60));
	
	if (sexID == SEX_MALE) then
		ModelPanel:SetLookAt(CAM_LOOK_AT[SEX_MALE]);
	else
		ModelPanel:SetLookAt(CAM_LOOK_AT[SEX_FEMALE]);
	end
	
	ModelPanel:SetModel(Models[curModelReference][2]);
	function ModelPanel:LayoutEntity( Entity )  end
	local ourModel = Models[curModelReference][3]
	
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
		
		ModelPanel:SetModel(Models[curModelReference][2]);
		ModelPanel:SetLookAt(CAM_LOOK_AT[Models[curModelReference][1]]);
		ourModel = Models[curModelReference][3];
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
			
		ModelPanel:SetModel(Models[curModelReference][2]);
		ModelPanel:SetLookAt(CAM_LOOK_AT[Models[curModelReference][1]]);
		ourModel = Models[curModelReference][3];
	end
	
	local SubmitButton = vgui.Create("DButton", AccountCreationScreen);
	SubmitButton:SetPos(10, H - 30);
	SubmitButton:SetSize(W - 20, 20);
	SubmitButton:SetText("Confirm");
		
	function SubmitButton:DoClick ( )
		AccountCreationScreen:Remove();
			
		RunConsoleCommand("perp_cf", ourModel);
	end
end
