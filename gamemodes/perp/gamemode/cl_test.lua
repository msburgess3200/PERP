


concommand.Add("perp_headlight_configurator", function()
	local e = LocalPlayer():GetEyeTrace().Entity
	if(not e:IsVehicle()) then return end
	
	local tbl = lookForVT(e)
	if(not tbl) then return end
	
	local tblHeadlights = tbl.HeadlightPositions
	
	
	local Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrW() * 0.4, ScrH() * 0.7)
	Frame:AlignTop(5)
	Frame:AlignRight(5)
	Frame:SetTitle("Vehicle headlights fixer.")
	
	local PanelList = vgui.Create("DPanelList", Frame)
	PanelList:StretchToParent(5, 27, 6, 25)
	PanelList:EnableVerticalScrollbar(true)
	
	local PrintButton = vgui.Create("DButton", Frame)
	PrintButton:SetText("Print Lua Code To Console")
	PrintButton:StretchToParent(5, Frame:GetTall() - 25, 5, 5)
	PrintButton.DoClick = function()
		local tbl = lookForVT(e)
		if(not tbl) then print("FAILED TO DUMP DATA!") return end
		
		local tblHeadlights = tbl.HeadlightPositions
		
		for i=1, 5 do
			print("")
		end
		
		local s = "VEHICLE.HeadlightPositions = {"
		
		for k, v in pairs(tblHeadlights) do
			s = s .. "\n	" .. Format("{Vector(%s, %s, %s), Angle(%s, %s, %s)},", v[1].x, v[1].y, v[1].z, v[2].p, v[2].y, v[2].r)
		end
		
		s = s .. "\n" .. "};"
		
		print(s)
		
		for i=1, 5 do
			print("")
		end
	end
	
	for k, v in pairs(tblHeadlights) do
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Headlight #" .. k .. " Pos X: " .. k)
		NumSlider:SetMin(-500)
		NumSlider:SetMax(500)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.HeadlightPositions[k][1].x)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.HeadlightPositions[k][1]
			v.x = iValue
			
			e.vehicleTable.HeadlightPositions[k][1] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Headlight #" .. k .. " Pos Y: " .. k)
		NumSlider:SetMin(-500)
		NumSlider:SetMax(500)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.HeadlightPositions[k][1].y)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.HeadlightPositions[k][1]
			v.y = iValue
			
			e.vehicleTable.HeadlightPositions[k][1] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Headlight #" .. k .. " Pos Z: " .. k)
		NumSlider:SetMin(-500)
		NumSlider:SetMax(500)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.HeadlightPositions[k][1].z)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.HeadlightPositions[k][1]
			v.z = iValue
			
			e.vehicleTable.HeadlightPositions[k][1] = v
		end
		PanelList:AddItem(NumSlider)
		
		
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Headlight #" .. k .. " Angle P: " .. k)
		NumSlider:SetMin(-180)
		NumSlider:SetMax(180)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.HeadlightPositions[k][2].p)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.HeadlightPositions[k][2]
			v.p = iValue
			
			e.vehicleTable.HeadlightPositions[k][2] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Headlight #" .. k .. " Angle Y: " .. k)
		NumSlider:SetMin(-180)
		NumSlider:SetMax(180)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.HeadlightPositions[k][2].y)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.HeadlightPositions[k][2]
			v.y = iValue
			
			e.vehicleTable.HeadlightPositions[k][2] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Headlight #" .. k .. " Angle R: " .. k)
		NumSlider:SetMin(-180)
		NumSlider:SetMax(180)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.HeadlightPositions[k][2].r)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.HeadlightPositions[k][2]
			v.r = iValue
			
			e.vehicleTable.HeadlightPositions[k][2] = v
		end
		PanelList:AddItem(NumSlider)
		
		local panel = vgui.Create("DPanel")
		panel.paint = function()		end
		panel:SetTall(10)
		PanelList:AddItem(panel)
	end
	
	Frame:MakePopup()
end)

concommand.Add("perp_seat_configurator", function()
	local e = LocalPlayer():GetEyeTrace().Entity
	if(not e:IsVehicle()) then return end
	
	local tbl = lookForVT(e)
	if(not tbl) then return end
	
	local tblTaillights = tbl.PassengerSeats
	
	
	local Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrW() * 0.4, ScrH() * 0.7)
	Frame:AlignTop(5)
	Frame:AlignRight(5)
	Frame:SetTitle("Vehicle seat fixer.")
	
	local PanelList = vgui.Create("DPanelList", Frame)
	PanelList:StretchToParent(5, 27, 6, 25)
	PanelList:EnableVerticalScrollbar(true)
	
	local PrintButton = vgui.Create("DButton", Frame)
	PrintButton:SetText("Print Lua Code To Console")
	PrintButton:StretchToParent(5, Frame:GetTall() - 25, 5, 5)
	PrintButton.DoClick = function()
		local tbl = lookForVT(e)
		if(not tbl) then print("FAILED TO DUMP DATA!") return end
		
		local tblTaillights = tbl.PassengerSeats
		
		
		for i=1, 5 do
			print("")
		end
		
		local s = "VEHICLE.PassengerSeats = {"
		
		for k, v in pairs(tblTaillights) do
			s = s .. "\n	" .. Format("{Vector(%s, %s, %s), Angle(%s, %s, %s)},", v[1].x, v[1].y, v[1].z, v[2].p, v[2].y, v[2].r)
		end
		
		s = s .. "\n" .. "};"
		
		print(s)
		
		for i=1, 5 do
			print("")
		end
	end
	
	for k, v in pairs(tblTaillights) do
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Pos X: " .. k)
		NumSlider:SetMin(-500)
		NumSlider:SetMax(500)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.PassengerSeats[k][1].x)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.PassengerSeats[k][1]
			v.x = iValue
			
			e.vehicleTable.PassengerSeats[k][1] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Pos Y: " .. k)
		NumSlider:SetMin(-500)
		NumSlider:SetMax(500)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.PassengerSeats[k][1].y)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.PassengerSeats[k][1]
			v.y = iValue
			
			e.vehicleTable.PassengerSeats[k][1] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Pos Z: " .. k)
		NumSlider:SetMin(-500)
		NumSlider:SetMax(500)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.PassengerSeats[k][1].z)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.PassengerSeats[k][1]
			v.z = iValue
			
			e.vehicleTable.PassengerSeats[k][1] = v
		end
		PanelList:AddItem(NumSlider)
		
		
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Angle P: " .. k)
		NumSlider:SetMin(-180)
		NumSlider:SetMax(180)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.PassengerSeats[k][2].p)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.PassengerSeats[k][2]
			v.p = iValue
			
			e.vehicleTable.PassengerSeats[k][2] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Angle Y: " .. k)
		NumSlider:SetMin(-180)
		NumSlider:SetMax(180)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.PassengerSeats[k][2].y)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.PassengerSeats[k][2]
			v.y = iValue
			
			e.vehicleTable.PassengerSeats[k][2] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Angle R: " .. k)
		NumSlider:SetMin(-180)
		NumSlider:SetMax(180)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.PassengerSeats[k][2].r)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.PassengerSeats[k][2]
			v.r = iValue
			
			e.vehicleTable.PassengerSeats[k][2] = v
		end
		PanelList:AddItem(NumSlider)
		
		local panel = vgui.Create("DPanel")
		panel.paint = function()		end
		panel:SetTall(10)
		PanelList:AddItem(panel)
	end
	
	Frame:MakePopup()
end)


concommand.Add("perp_taillight_configurator", function()
	local e = LocalPlayer():GetEyeTrace().Entity
	if(not e:IsVehicle()) then return end
	
	local tbl = lookForVT(e)
	if(not tbl) then return end
	
	local tblTaillights = tbl.TaillightPositions
	
	
	local Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrW() * 0.4, ScrH() * 0.7)
	Frame:AlignTop(5)
	Frame:AlignRight(5)
	Frame:SetTitle("Vehicle Taillights fixer.")
	
	local PanelList = vgui.Create("DPanelList", Frame)
	PanelList:StretchToParent(5, 27, 6, 25)
	PanelList:EnableVerticalScrollbar(true)
	
	local PrintButton = vgui.Create("DButton", Frame)
	PrintButton:SetText("Print Lua Code To Console")
	PrintButton:StretchToParent(5, Frame:GetTall() - 25, 5, 5)
	PrintButton.DoClick = function()
		local tbl = lookForVT(e)
		if(not tbl) then print("FAILED TO DUMP DATA!") return end
		
		local tblTaillights = tbl.TaillightPositions
		
		
		for i=1, 5 do
			print("")
		end
		
		local s = "VEHICLE.TaillightPositions = {"
		
		for k, v in pairs(tblTaillights) do
			s = s .. "\n	" .. Format("{Vector(%s, %s, %s), Angle(%s, %s, %s)},", v[1].x, v[1].y, v[1].z, v[2].p, v[2].y, v[2].r)
		end
		
		s = s .. "\n" .. "};"
		
		print(s)
		
		for i=1, 5 do
			print("")
		end
	end
	
	for k, v in pairs(tblTaillights) do
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Pos X: " .. k)
		NumSlider:SetMin(-500)
		NumSlider:SetMax(500)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.TaillightPositions[k][1].x)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.TaillightPositions[k][1]
			v.x = iValue
			
			e.vehicleTable.TaillightPositions[k][1] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Pos Y: " .. k)
		NumSlider:SetMin(-500)
		NumSlider:SetMax(500)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.TaillightPositions[k][1].y)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.TaillightPositions[k][1]
			v.y = iValue
			
			e.vehicleTable.TaillightPositions[k][1] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Pos Z: " .. k)
		NumSlider:SetMin(-500)
		NumSlider:SetMax(500)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.TaillightPositions[k][1].z)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.TaillightPositions[k][1]
			v.z = iValue
			
			e.vehicleTable.TaillightPositions[k][1] = v
		end
		PanelList:AddItem(NumSlider)
		
		
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Angle P: " .. k)
		NumSlider:SetMin(-180)
		NumSlider:SetMax(180)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.TaillightPositions[k][2].p)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.TaillightPositions[k][2]
			v.p = iValue
			
			e.vehicleTable.TaillightPositions[k][2] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Angle Y: " .. k)
		NumSlider:SetMin(-180)
		NumSlider:SetMax(180)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.TaillightPositions[k][2].y)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.TaillightPositions[k][2]
			v.y = iValue
			
			e.vehicleTable.TaillightPositions[k][2] = v
		end
		PanelList:AddItem(NumSlider)
		
		local NumSlider = vgui.Create("DNumSlider")
		NumSlider:SetText("Taillight #" .. k .. " Angle R: " .. k)
		NumSlider:SetMin(-180)
		NumSlider:SetMax(180)
		NumSlider:SetDecimals(0)
		NumSlider:SetValue(e.vehicleTable.TaillightPositions[k][2].r)
		NumSlider.ValueChanged = function(self, iValue)
			local v = e.vehicleTable.TaillightPositions[k][2]
			v.r = iValue
			
			e.vehicleTable.TaillightPositions[k][2] = v
		end
		PanelList:AddItem(NumSlider)
		
		local panel = vgui.Create("DPanel")
		panel.paint = function()		end
		panel:SetTall(10)
		PanelList:AddItem(panel)
	end
	
	Frame:MakePopup()
end)


do
	local iModel = 1
	local Frame
	local objPrev
	local function DisplayTick()
		if(not objPrev) then
			objPrev = ClientsideModel("models/error.mdl")
		end
		iModel = math.Clamp(iModel, 1, 2500)
		
		objPrev:SetPos(LocalPlayer():GetEyeTraceNoCursor().HitPos + Vector(0, 0, 100))
		objPrev:SetModel("*" .. tostring(iModel))
		objPrev:SetAngles(Angle(0, CurTime() * 45, 0))
	end
	
	concommand.Add("map_models", function(_, _, t)
		if(t[1] != "1") then iModel = 0 timer.Remove("DisplayTick")  if(Frame) then Frame:Remove() end if(objPrev) then objPrev:Remove() objPrev = nil end return end
		
		timer.Create("DisplayTick", 0.01, 0, DisplayTick)
		
		Frame = vgui.Create("DFrame")
		Frame:SetSize(400, 100)
		Frame:AlignTop(5)
		Frame:AlignRight(5)
		Frame:SetTitle("Map Brush Models")
		Frame:SetVisible(true)
		Frame:MakePopup()
		
		local NumSlider = vgui.Create("DNumSlider", Frame)
		NumSlider:SetText("Integer:")
		NumSlider:SetMin(0)
		NumSlider:SetMax(247)
		NumSlider:StretchToParent(5, 27, 5, 5)
		NumSlider:SetDecimals(0)
		NumSlider.ValueChanged = function(self, iValue)
			iModel = tonumber(iValue)
		end
	end)
end
