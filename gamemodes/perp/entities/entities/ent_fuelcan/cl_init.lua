
include('shared.lua')

function ENT:Initialize()
self.CurrentCar = nil;
end

function ENT:Think()
			local Carnear = false
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 50)) do
					if (v:GetClass() == "prop_vehicle_jeep") then
						self.CurrentCar = v;
						Carnear = true
						break;
					end
			end
			
			if Carnear == false then
				self.CurrentCar = nil;
			end
end
