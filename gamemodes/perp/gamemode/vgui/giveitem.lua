

local Frame

local function GiveItemPanelCreate()
	
	Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrW() * 0.5, ScrH() * 0.5)
	Frame:Center()
	Frame:SetTitle("Item Spawn")
	Frame:ShowCloseButton(false)
	
	Frame.List = vgui.Create("DPanelList", Frame)
	Frame.List:StretchToParent(5, 27, 5, 5)
	Frame.List:EnableVerticalScrollbar(true)
	Frame.List:EnableHorizontal(true)
	
	for i=1, #ITEM_DATABASE do
		local v = ITEM_DATABASE[i]
		if(not v) then continue end
		
		local sub = vgui.Create("DPanel")
		sub:SetSize(73, 89)
		sub.Paint = function()
			surface.SetDrawColor(Color(100, 100, 100, 255))
			surface.DrawRect(2, 2, sub:GetWide() - 4, sub:GetTall() - 4)
			
			surface.SetTextColor(Color(255, 255, 255, 255))
			surface.SetFont("Default")
			local x, y = surface.GetTextSize(v.Name)
			
			surface.SetTextPos(5, 5)
			surface.DrawText(v.Name)
		end
		
		sub.spawnicon = vgui.Create("SpawnIcon", sub)
		sub.spawnicon:SetModel(v.WorldModel)
		sub.spawnicon:SetPos(5, 20)
		sub.spawnicon.DoClick = function()
			RunConsoleCommand("perpx_giveitembeg", v.ID)
		end
		
		Frame.List:AddItem(sub)
	end
end

concommand.Add("+giveitempanel", function() if(not game.SinglePlayer() and not LocalPlayer():IsOwner()) then return end
	if(not Frame) then GiveItemPanelCreate() end Frame:MakePopup() Frame:SetVisible(true) end)
concommand.Add("-giveitempanel", function() if(not game.SinglePlayer() and not LocalPlayer():IsOwner()) then return end
	Frame:SetVisible(false) end)
