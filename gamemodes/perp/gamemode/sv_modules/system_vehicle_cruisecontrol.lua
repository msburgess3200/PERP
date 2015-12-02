


function GM.CruiseControlPlayerDisconnect(objPl)
	objPl:ConCommand("-forward")
	objPl:ConCommand("-back")
	objPl:ConCommand("-moveleft")
	objPl:ConCommand("-moveright")
	objPl:ConCommand("-jump")
end
hook.Add("PlayerDisconnect", "CruiseControlPlayerDisconnect", GM.CruiseControlPlayerDisconnect)

function GM.ToggleCruiseControl(objPl, Key)
	local vehicle = objPl:GetVehicle()
	if(Key == IN_USE and ValidEntity(vehicle)) then
		objPl:ConCommand("-forward")
		objPl:ConCommand("-back")
		objPl:ConCommand("-jump")
	end
	
	if(not ValidEntity(vehicle)) then return end
	if(vehicle.CruiseControl == nil) then
		vehicle.CruiseControl = false
		objPl.IsInCruiseControl = false
		vehicle.CruiseControlSpeed = 0
		vehicle:SetNWInt("CruiseControlValue", vehicle.CruiseControlSpeed)
		if(vehicle.CruiseControl) then
			vehicle:SetNWInt("CruiseControl", 1)
		else
			vehicle:SetNWInt("CruiseControl", 0)
		end
	end
	
	if(Key == IN_ATTACK2) then
		vehicle.CruiseControl = !vehicle.CruiseControl
		objPl.IsInCruiseControl = vehicle.CruiseControl
		
		if(vehicle.CruiseControl) then
			vehicle:SetNWInt("CruiseControl", 1)
		else
			vehicle:SetNWInt("CruiseControl", 0)
		end
		if(vehicle.CruiseControl) then
			vehicle.CruiseControlSpeed =  math.ceil((vehicle:GetVelocity():Length() / 17.6) * 0.2) * 5
			
			vehicle:SetNWInt("CruiseControlValue", vehicle.CruiseControlSpeed)
			
			if(vehicle.CruiseControlSpeed < 0) then
				objPl:ConCommand("+back")
			else
				objPl:ConCommand("-back")
			end
			if(vehicle.CruiseControlSpeed > 0) then
				objPl:ConCommand("+forward")
			else
				objPl:ConCommand("-forward")
			end
			if(vehicle.CruiseControlSpeed == 0) then
				objPl:ConCommand("+jump")
			else
				objPl:ConCommand("-jump")
			end
		else
			vehicle:SetNWInt("CruiseControlValue", 0)
			
			objPl:ConCommand("-forward")
			objPl:ConCommand("-back")
			objPl:ConCommand("-jump")
		end
	return end
end
hook.Add("KeyPress", "ToggleCruiseControl", GM.ToggleCruiseControl)

function GM.CruiseControlTimer()
	local t = player.GetAll()
	for k=1, #t do
		local v = t[k]
		if(ValidEntity(v:GetVehicle())) then
			local car = v:GetVehicle()
			if(v:GetVehicle().CruiseControl) then
				local iSpeed = car:GetVelocity():Length() / 17.6
				local iMaxSpeed = math.abs(car.CruiseControlSpeed)
				if(iMaxSpeed > 0) then
					if(iSpeed >= iMaxSpeed) then
						car:GetPhysicsObject():SetDamping(math.ceil(iSpeed - iMaxSpeed + 4), 0)
					else
						car:GetPhysicsObject():SetDamping(0, 0)
					end
				end
			else
				car:GetPhysicsObject():SetDamping(0, 0)
			end
		else
			if(v.IsInCruiseControl) then
				v:ConCommand("-forward")
				v:ConCommand("-back")
				v:ConCommand("-jump")
				
				v.IsInCruiseControl = false
			end
		end
	end
end
timer.Create("CruiseControlTimer", 0.075, 0, GM.CruiseControlTimer)

concommand.Add("perp_cc_up", function(objPl, strC, tblArgs)
	local vehicle = objPl:GetVehicle()
	if(not ValidEntity(vehicle)) then return end
	if(vehicle.CruiseControl) then
		vehicle.CruiseControlSpeed = vehicle.CruiseControlSpeed + 5
		if(vehicle.CruiseControlSpeed > 120) then
			vehicle.CruiseControlSpeed = 120
			return
		end
		if(vehicle.CruiseControlSpeed < 0) then
			objPl:ConCommand("+back")
		else
			objPl:ConCommand("-back")
		end
		if(vehicle.CruiseControlSpeed > 0) then
			objPl:ConCommand("+forward")
		else
			objPl:ConCommand("-forward")
		end
		if(vehicle.CruiseControlSpeed == 0) then
			objPl:ConCommand("+jump")
		else
			objPl:ConCommand("-jump")
		end
		vehicle:SetNWInt("CruiseControlValue", vehicle.CruiseControlSpeed)
	end
end)

concommand.Add("perp_cc_down", function(objPl, strC, tblArgs)
	local vehicle = objPl:GetVehicle()
	if(not ValidEntity(vehicle)) then return end
	if(vehicle.CruiseControl) then
		vehicle.CruiseControlSpeed = vehicle.CruiseControlSpeed - 5
		if(vehicle.CruiseControlSpeed < -120) then
			vehicle.CruiseControlSpeed = -120
			return
		end
		if(vehicle.CruiseControlSpeed < 0) then
			objPl:ConCommand("+back")
		else
			objPl:ConCommand("-back")
		end
		if(vehicle.CruiseControlSpeed > 0) then
			objPl:ConCommand("+forward")
		else
			objPl:ConCommand("-forward")
		end
		if(vehicle.CruiseControlSpeed == 0) then
			objPl:ConCommand("+jump")
		else
			objPl:ConCommand("-jump")
		end
		vehicle:SetNWInt("CruiseControlValue", vehicle.CruiseControlSpeed)
	end
end)
