


GM.Options_GUIAlpha = CreateClientConVar("perp2_gui_alpha", "150", true, false);
GM.Options_HUDAlpha = CreateClientConVar("perp2_hud_alpha", "150", true, false);
GM.Options_HUDColorR = CreateClientConVar("perp2_hud_colorr", "255", true, false);
GM.Options_HUDColorG = CreateClientConVar("perp2_hud_colorg", "255", true, false);
GM.Options_HUDColorB = CreateClientConVar("perp2_hud_colorb", "255", true, false);
GM.Options_InventoryShouldUseGUIAlpha = CreateClientConVar("perp2_gui_inv_alpha", "0", true, false);
GM.Options_ShowOOC = CreateClientConVar("perp2_show_ooc", "1", true, false);
GM.Options_ShowChatBubble = CreateClientConVar("perp2_show_chat_bubble", "1", true, false);
GM.Options_SaveBuddies = CreateClientConVar("perp2_save_buddies", "0", true, false);
GM.Options_ShowUnownableDoors = CreateClientConVar("perp2_show_unownable_doors", "1", true, false);
GM.Options_ShowNames = CreateClientConVar("perp2_show_names", "1", true, false);
GM.Options_EuroStuff = CreateClientConVar("perp2_euro", "0", true, false);
GM.Options_ShowPaydayInfo = CreateClientConVar("perp2_payday_info", "1", true, false);
GM.Options_NumRadioStreams = CreateClientConVar("perp2_radio_streams", "1", true, false);
GM.Options_RadioVolume = CreateClientConVar("perp2_radio_volume", "100", true, false);
GM.Options_DisableFireSmoke = CreateClientConVar("perp2_firesmoke_disable", "0", true, false);
GM.Options_MuteLocalBreath = CreateClientConVar("perp2_mute_local_breath", "0", true, false);
GM.Options_AZERTY = CreateClientConVar("perp2_azerty", "0", true, false);
GM.Options_EnableTVs = CreateClientConVar("perp2_enable_tv", "1", true, false);

function GM.GetPhoneKey ( )
	if (GAMEMODE.Options_AZERTY:GetBool()) then
		return KEY_L;
	else
		return KEY_Z;
	end
end

function GM.GetGUIAlpha ( )
	return math.Clamp(GAMEMODE.Options_GUIAlpha:GetInt(), 150, 255);
end

function GM.GetHUDAlpha ( )
	return math.Clamp(GAMEMODE.Options_HUDAlpha:GetInt(), 0, 255);
end

function GM.GetHUDColorR ( )
	return math.Clamp(GAMEMODE.Options_HUDColorR:GetInt(), 0, 255);
end

function GM.GetHUDColorG ( )
	return math.Clamp(GAMEMODE.Options_HUDColorG:GetInt(), 0, 255);
end

function GM.GetHUDColorB ( )
	return math.Clamp(GAMEMODE.Options_HUDColorB:GetInt(), 0, 255);
end

function GM.GetInventoryAlpha ( )
	if (GAMEMODE.Options_InventoryShouldUseGUIAlpha:GetBool()) then
		return GAMEMODE.GetGUIAlpha();
	else
		return 255;
	end
end

local LastGUIAlpha = 0;
local LastHUDAlpha = 0;
local LastInventoryAlpha = 0;
local LastHUDColors = 0;
local function MonitorOptions ( )
	if (LastGUIAlpha != GAMEMODE.GetGUIAlpha()) then
		LastGUIAlpha = GAMEMODE.GetGUIAlpha();
		
		if (GAMEMODE.DialogPanel) then
			GAMEMODE.DialogPanel:SetAlpha(LastGUIAlpha);
		end
		
		if (GAMEMODE.HelpPanel) then
			GAMEMODE.HelpPanel:SetAlpha(LastGUIAlpha);
		end
	end
	
	local CurrentInventoryAlpha = GAMEMODE.GetInventoryAlpha();
	if (CurrentInventoryAlpha != LastInventoryAlpha) then
		LastInventoryAlpha = CurrentInventoryAlpha;
		
		if (GAMEMODE.InventoryPanel) then
			GAMEMODE.InventoryPanel:SetAlpha(CurrentInventoryAlpha);
		end
	end
	
	if (LastHUDAlpha != GAMEMODE.GetHUDAlpha()) then
		LastHUDAlpha = GAMEMODE.GetHUDAlpha();
		
		if (GAMEMODE.HUD) then
			GAMEMODE.HUD:SetAlpha(LastHUDAlpha);
		end
	end
end
hook.Add("Think", "MonitorOptions", MonitorOptions);

function GM.LoadOptionsList ( panelList )
	local guiAlpha = vgui.Create("DNumSlider", panelList);
	guiAlpha:SetText("GUI Alpha");
	guiAlpha:SetMin(150);
	guiAlpha:SetMax(255);
	guiAlpha:SetConVar("perp2_gui_alpha");
	guiAlpha:SetValue(GAMEMODE.GetGUIAlpha());
	panelList:AddItem(guiAlpha);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("Inventory should use GUI alpha? (Optional because it doesn't look as good as full alpha.)");
	inventoryUseAlpha:SetValue(GAMEMODE.Options_InventoryShouldUseGUIAlpha:GetInt());
	inventoryUseAlpha:SetConVar("perp2_gui_inv_alpha");
	panelList:AddItem(inventoryUseAlpha);
	
	local hudAlpha = vgui.Create("DNumSlider", panelList);
	hudAlpha:SetText("HUD Alpha");
	hudAlpha:SetMin(0);
	hudAlpha:SetMax(255);
	hudAlpha:SetConVar("perp2_hud_alpha");
	hudAlpha:SetValue(GAMEMODE.GetHUDAlpha());
	panelList:AddItem(hudAlpha);
	
	local hudColorR = vgui.Create("DNumSlider", panelList);
	hudColorR:SetText("HUD Color: Red");
	hudColorR:SetMin(0);
	hudColorR:SetMax(255);
	hudColorR:SetConVar("perp2_hud_colorr");
	hudColorR:SetValue(GAMEMODE.GetHUDColorR());
	panelList:AddItem(hudColorR);
	
	local hudColorG = vgui.Create("DNumSlider", panelList);
	hudColorG:SetText("HUD Color: Green");
	hudColorG:SetMin(0);
	hudColorG:SetMax(255);
	hudColorG:SetConVar("perp2_hud_colorg");
	hudColorG:SetValue(GAMEMODE.GetHUDColorG());
	panelList:AddItem(hudColorG);
	
	local hudColorB = vgui.Create("DNumSlider", panelList);
	hudColorB:SetText("HUD Color: Blue");
	hudColorB:SetMin(0);
	hudColorB:SetMax(255);
	hudColorB:SetConVar("perp2_hud_colorb");
	hudColorB:SetValue(GAMEMODE.GetHUDColorB());
	panelList:AddItem(hudColorB);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("Show OOC chat in chat box?");
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowOOC:GetInt());
	inventoryUseAlpha:SetConVar("perp2_show_ooc");
	panelList:AddItem(inventoryUseAlpha);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("Show indicator above your head while you type?");
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowChatBubble:GetInt());
	inventoryUseAlpha:SetConVar("perp2_show_chat_bubble");
	panelList:AddItem(inventoryUseAlpha);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("Show names above people, vehicles, and doors?");
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowNames:GetInt());
	inventoryUseAlpha:SetConVar("perp2_show_names");
	panelList:AddItem(inventoryUseAlpha);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("Indicate unownable doors? (Requires above; if not checked unownable doors will have no text.)");
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowUnownableDoors:GetInt());
	inventoryUseAlpha:SetConVar("perp2_show_unownable_doors");
	panelList:AddItem(inventoryUseAlpha);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("Use metric system? (KPH and Celsius)");
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowUnownableDoors:GetInt());
	inventoryUseAlpha:SetConVar("perp2_euro");
	panelList:AddItem(inventoryUseAlpha);
	
	local numStreams = vgui.Create("DNumSlider", panelList);
	numStreams:SetText("Number of radio streams? (0 disables)");
	numStreams:SetMin(0);
	numStreams:SetMax(10);
	numStreams:SetConVar("perp2_radio_streams");
	numStreams:SetDecimals(0);
	numStreams:SetValue(GAMEMODE.Options_NumRadioStreams:GetInt());
	panelList:AddItem(numStreams);
	
	local numStreams = vgui.Create("DNumSlider", panelList);
	numStreams:SetText("Maximum volume of radio?");
	numStreams:SetMin(0);
	numStreams:SetMax(100);
	numStreams:SetConVar("perp2_radio_volume");
	numStreams:SetDecimals(0);
	numStreams:SetValue(GAMEMODE.Options_RadioVolume:GetInt());
	panelList:AddItem(numStreams);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("Use sun beams? (Recommended)");
	inventoryUseAlpha:SetConVar("pp_sunbeams");
	panelList:AddItem(inventoryUseAlpha);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("Remove smoke from fires?");
	inventoryUseAlpha:SetConVar("perp2_firesmoke_disable");
	inventoryUseAlpha:SetValue(GAMEMODE.Options_DisableFireSmoke:GetInt());
	panelList:AddItem(inventoryUseAlpha);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("Show payday notices?");
	inventoryUseAlpha:SetConVar("perp2_payday_info");
	inventoryUseAlpha:SetValue(GAMEMODE.Options_ShowPaydayInfo:GetInt());
	panelList:AddItem(inventoryUseAlpha);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("Mute heavy breathing?");
	inventoryUseAlpha:SetConVar("perp2_mute_local_breath");
	inventoryUseAlpha:SetValue(GAMEMODE.Options_MuteLocalBreath:GetInt());
	panelList:AddItem(inventoryUseAlpha);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("AZERT Keyboard? (Changes the phone key from Z to L)");
	inventoryUseAlpha:SetConVar("perp2_azerty");
	inventoryUseAlpha:SetValue(GAMEMODE.Options_AZERTY:GetInt());
	panelList:AddItem(inventoryUseAlpha);
	
	local inventoryUseAlpha = vgui.Create("DCheckBoxLabel", panelList);
	inventoryUseAlpha:SetText("Enable TVs?");
	inventoryUseAlpha:SetConVar("perp2_enable_tv");
	inventoryUseAlpha:SetValue(GAMEMODE.Options_EnableTVs:GetInt());
	panelList:AddItem(inventoryUseAlpha);
end
