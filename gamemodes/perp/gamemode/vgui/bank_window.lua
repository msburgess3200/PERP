
function ShowBankWindow ( windowTitle, textTitle, buttonText, onFinish )
	local ourPanel = vgui.Create("DFrame");
	ourPanel:SetSize(260, 125);
	ourPanel:SetPos(ScrW() * .5 - 130, ScrH() * .5 - 92.5);
	ourPanel:SetAlpha(GAMEMODE.GetGUIAlpha());
	ourPanel:MakePopup();
	ourPanel:SetTitle(windowTitle);
	ourPanel:SetDraggable(false);
	ourPanel:SetSkin("ugperp")
	
	ourPanel:ShowCloseButton(false);
	
	local panelList = vgui.Create("DPanelList", ourPanel);
	panelList:EnableHorizontal(false)
	panelList:EnableVerticalScrollbar(true)
	panelList:StretchToParent(5, 30, 5, 5);
	panelList:SetPadding(5);
	
		local UserNamel = vgui.Create("DLabel", panelList);
		UserNamel:SetPos(80, 30);
		UserNamel:SetSize(100, 20);
		UserNamel:SetText(textTitle .. ":");
		panelList:AddItem(UserNamel);
	
		UserName = vgui.Create("DTextEntry", panelList);
		UserName:SetPos(80, 30);
		UserName:SetSize(100, 20);
		UserName:SetText(0);
		UserName:SetNumeric(true);
		panelList:AddItem(UserName);
		
		local UserName2 = vgui.Create("DLabel", panelList);
		UserName2:SetPos(80, 30);
		UserName2:SetSize(100, 20);
		UserName2:SetText("");
		panelList:AddItem(UserName2);
		
		local SubmitButton = vgui.Create("DButton", panelList);
		SubmitButton:SetPos(80, 30);
		SubmitButton:SetSize(100, 20);
		SubmitButton:SetText(buttonText);
		
		panelList:AddItem(SubmitButton);
		
		local function MonitorColors2 ( wantReturn )
			if (tostring(tonumber(UserName:GetValue())) != UserName:GetValue() || tonumber(UserName:GetValue()) < 0 || math.ceil(tonumber(UserName:GetValue())) != math.floor(tonumber(UserName:GetValue())) || (buttonText == "Deposit" && tonumber(UserName:GetValue()) > LocalPlayer():GetCash()) || (buttonText == "Withdraw" && tonumber(UserName:GetValue()) > LocalPlayer():GetBank())) then
				UserName:SetTextColor(Color(255, 0, 0, 255));
				
				SubmitButton:SetEnabled(false);
				return false;
			else
				UserName:SetTextColor(Color(0, 0, 0, 255));
				
				SubmitButton:SetEnabled(true);
				return true;
			end
		end
		hook.Add('Think', 'MonColorsATM', MonitorColors2);
		
		function SubmitButton:DoClick ( )
			if (!MonitorColors2(true)) then
				LocalPlayer():Notify("Please fix any fields that may have errors.");
				return;
			end
			
			hook.Remove("Think", 'MonColorsATM');
			ourPanel:Remove();
			
			onFinish(tonumber(UserName:GetValue()));
		end
end
