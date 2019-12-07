
-[[
Msg("Loading pimpmyride module... ");
require('pimpmyride');

if (FindMetaTable("Vehicle").GetWheelMaterial) then
	Msg("done!\n");
else
	Msg("failed!\n");
end

local function handleCarWheelMaterials ( )
	for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
		if (IsValid(v) && v:GetDriver() && IsValid(v:GetDriver()) && v.vehicleTable) then
			local shouldHaveMat;
			if (GAMEMODE.SnowOnGround or v.TiresBroken) then
				local defaultCar = v.vehicleTable.DefaultIceFriction;
				local addedForLevel = math.Clamp((defaultCar + ((v:GetDriver():GetLevel(SKILL_DRIVING) - 1) / 10)) * 10, 1, 20);
				if(v.TiresBroken) then
					addedForLevel = 10
				end
				if (addedForLevel < 10) then addedForLevel = "0" .. addedForLevel; end
			
				shouldHaveMat = "perp2_ice_" .. addedForLevel;
			elseif (v.defaultMaterialSet) then
				shouldHaveMat = v.defaultMaterialSet;
			end
			
			if (!v.defaultMaterialSet) then
				v.defaultMaterialSet = v:GetWheelMaterial(0);
			end
			
			if (shouldHaveMat) then
				if (v:GetWheelMaterial(0) != shouldHaveMat) then
					file.Write("last_wheel.txt", "Setting wheel material to " .. shouldHaveMat .. ".\n");
					v:SetWheelMaterial(0, shouldHaveMat);
					v:SetWheelMaterial(1, shouldHaveMat);
					v:SetWheelMaterial(2, shouldHaveMat);
					v:SetWheelMaterial(3, shouldHaveMat);
				end
			end
		end
	end
end
hook.Add("Think", "handleCarWheelMaterials", handleCarWheelMaterials);
-]]
