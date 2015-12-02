local PLUGIN = {}

PLUGIN.Name = "Theater"
PLUGIN.Author = "RedMist"
PLUGIN.Date = "6/14/2012"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

if (CLIENT) then
	
	function PLUGIN.TDerma()
		local TPanel = vgui.Create( "DFrame" ) 
		TPanel:SetPos(ScrW()/2 - 150, ScrH()/2 - 92)
		TPanel:SetSize( 300, 184 )
		TPanel:SetTitle( "Theater Control" )
		TPanel:SetVisible( true )
		TPanel:SetDraggable( false )
		TPanel:ShowCloseButton( true )
		TPanel:MakePopup()
		
		local TList = vgui.Create("DPanelList", TPanel);
		TList:EnableHorizontal(false)
		TList:EnableVerticalScrollbar(true)
		TList:SetPos(5, 25);
		TList:SetSize(290, 154);
		TList:SetPadding(5);
		
		local PLabel = vgui.Create("DLabel", TList)
		PLabel:SetText("Provider:")
		TList:AddItem(PLabel)
 
		local PList = vgui.Create("DComboBox", TList)
		PList:SetPos(5,28)
		PList:SetSize( 100, 20 )
		PList:AddChoice("StaticWeb")
		PList:AddChoice("auto-detect")
		PList:AddChoice("Flash")
		PList:AddChoice("justin.tv")
		PList:AddChoice("YouTube")
		PList:AddChoice("Livestream")
		PList:AddChoice("Hulu")
		PList:AddChoice("MP3")
		PList:AddChoice("Image")
		PList:AddChoice("Shoutcast")
		PList:AddChoice("FlashVideo")
		PList:AddChoice("Vimeo")
		TList:AddItem(PList)
		function PList:OnSelect(index,value,data)
			provider = value;
		end
		
		local PLabel = vgui.Create("DLabel", TList)
		PLabel:SetText("Video Link:")
		TList:AddItem(PLabel)
 
		local EnterURL = vgui.Create("DTextEntry", TList)
		EnterURL:SetText("URL")
		TList:AddItem(EnterURL)
		EnterURL.OnTextChanged = function(PanelVar)
			URL = EnterURL:GetValue()
		end
		
		local Spacer = vgui.Create("DLabel", TList)
		Spacer:SetText("")
		TList:AddItem(Spacer)
		
		local Play = vgui.Create("DButton", TList)
		Play:SetText("Play")
		TList:AddItem(Play)
		Play.DoClick = function(Play)
			RunConsoleCommand("playx_open", URL, provider)
		end
	
		local Stop = vgui.Create("DButton", TList)
		Stop:SetText("Stop")
		TList:AddItem(Stop)
		Stop.DoClick = function(Stop)
			RunConsoleCommand("playx_close")
		end
	end

	function PrintProviders()
		local options = {
			["StaticWeb"] = {["playx_provider"] = ""}
		}
		
		for id, name in pairs(PlayX.Providers) do
			options[name] = {["playx_provider"] = id}
		end
		PrintTable(options)
	end
	concommand.Add("print_providers", PrintProviders)
	
	function PLUGIN.AddMenu(TMENU)
		TMENU:AddSubMenu("Theater", PLUGIN.TDerma, nil)
	end

end

ASS_RegisterPlugin(PLUGIN)


