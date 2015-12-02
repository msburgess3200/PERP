

local minVectors = Vector(-9245.167969, -11189.324219, 0)
local maxVectors = Vector(-8930.300781, -10819.880859, 521.228821)

local function checkForATVs ( )
	for _, each in pairs(player.GetAll()) do
		if (each:InVehicle()) then
			local vehicle = each:GetVehicle()
			
			if (vehicle && IsValid(vehicle)) then
				local eachPos = each:GetPos()
					
				if (eachPos.x > minVectors.x && eachPos.y > minVectors.y && eachPos.z > minVectors.z && eachPos.x < maxVectors.x && eachPos.y < maxVectors.y && eachPos.z < maxVectors.z) then
					vehicle:Remove()
				end
			end
		end
	end
end
timer.Create("checkForATVs", 0.5, 0, checkForATVs)

