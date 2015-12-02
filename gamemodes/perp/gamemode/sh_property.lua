
PROPERTY_DATABASE = {};

local policeDoors = {
						{Vector(-7515, -9169, 518.28100585938), 'models/props_c17/door01_left.mdl'},
						{Vector(-6963, -9169, 518.28100585938), 'models/props_c17/door01_left.mdl'},
						{Vector(-6528, -9556.5, 527.5), '*218'},
						{Vector(-6528, -9423.5, 527.5), '*219'},
						{Vector(-7432, -9099, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7432, -8975, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7060, -8975, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7060, -9099, 1798), 'models/props_c17/door01_left.mdl'},
						{Vector(-7308, -9101, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-7214, -9101, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-6760, -9359, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-6760, -9499, 3845.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-6815, -8885, -377.75), 'models/props_c17/door03_left.mdl'},
						{Vector(-7125, -8798, -377.75), 'models/props_c17/door03_left.mdl'},
						{Vector(-7389, -9272, -377.75), 'models/props_c17/door03_left.mdl'},
						{Vector(-6768, -8986, -377.75), 'models/props_c17/door03_left.mdl'},
						{Vector(-7027, -9253, -372), '*78'},
					}
					
local civilDoors = 	{
						{Vector(-3816, -8232, 290), '*113'},
						{Vector(-3816, -7944, 290), '*111'},
						{Vector(-3816, -7656, 290), '*112'},
						{Vector(-3804, -7572.009765625, 248), '*115'},
						{Vector(-3684, -7572.009765625, 248), '*114'},
						{Vector(-3828, -7122, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3828, -7306.990234375, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3828, -7370.990234375, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3659, -7317, 252.25), 'models/props_c17/door01_left.mdl'},
						{Vector(-3659, -7381, 252.25), 'models/props_c17/door01_left.mdl'},
                        {Vector(-9383, 9044, 126.281), 'models/props_c17/door03_left.mdl'},
                        {Vector(-9768, 9097, 126.281), 'models/props_c17/door03_left.mdl'},
                        {Vector(-9880, 9334, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-9880, 9240, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10256, 9020, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10015, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10121, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10529, 9231, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10623, 9231, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10609, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
                        {Vector(-10703, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
						{Vector(-6758, -10521, -124.5), '*145'},
						{Vector(-3804, -7572, 248), '*62'},
						{Vector(-3684, -7572, 248), '*61'},
						{Vector(-3816, -7656, 290), '*59'},
						{Vector(-3816, -7944, 290), '*58'},
                        {Vector(-3816, -8232, 290), '*60'},
						{Vector(-10904, 9333, 135), '*241'},
						{Vector(-10904.5, 9393, 135), '*240'},
					}			
local RealtorOfficeDoors = 	{
						{Vector(-7092, -7786, 135), '*171'},
						{Vector(-7092, -7664, 135), '*172'},
					}

local BPShopDoors = 	{
						{Vector(-7348, -6349, 135), '*170'},
						{Vector(-7348, -6227, 135), '*169'},
						{Vector(10524, 13380, 121.5), '*175'},
						{Vector(10260, 13380, 121.5), '*176'},
					}

local FCStoreDoors = 	{
						{Vector(-5305, -6468, 135), '*181'},
						{Vector(-5183, -6468, 135), '*180'},
					}
					
local TidesHotelDoors = 	{
						{Vector(-5445.5, -4454, 135), '*51'},
						{Vector(-5445, -4514, 135), '*50'},
						{Vector(-5445.5, -4702, 135), '*53'},
						{Vector(-5445, -4762, 135), '*52'},
					}
					
local ShopsDoors = 	{
						{Vector(-6454, -10258, 127.5), '*64'},
					}
					
local CarDealerDoors = 	{
						{Vector(4066, -4757, 142), '*30'},
						{Vector(4598, -4057, 142), '*29'},
						{Vector(5361.5, -4757, 126), '*34'},
						{Vector(5490.5, -4757, 126), '*33'},
					}
					
local HospitalDoors = 	{
						{Vector(-9440.5, 9393, 135), '*239'},
						{Vector(-9440, 9333, 135), '*238'},
					}
					
local GovermentCenterDoors = 	{
						{Vector(-6760, -8712.625, 134), '*140'},
						{Vector(-6760, -8809.34375, 134), '*63'},
						{Vector(-6760, -8992.625, 134), '*142'},
						{Vector(-6760, -9089.34375, 134), '*141'},
						{Vector(-7782, -10415, -170.79219055176), '*65'},
						{Vector(-6892, -10160, -88), '*68'},
						{Vector(-6758, -10521, -124.5), '*145'},
					}
					
local JailsDoors = 	{
						{Vector(-7027, -9253, -372), '*78'},
						{Vector(-7482, -9844, -372), '*71'},
						{Vector(-7479.1875, -10369.375, -372), '*87'},
						{Vector(-8066, -9825, -377.75), 'models/props_c17/door03_left.mdl'},
						{Vector(-7972, -9825, -377.75), 'models/props_c17/door03_left.mdl'},
						{Vector(-7580, -10331, -381), '*76'},
						{Vector(-7580, -10203, -381), '*74'},
						{Vector(-7580, -10075, -381), '*72'},
						{Vector(-7580, -9947, -381), '*69'},
						{Vector(-7381, -9947, -381), '*82'},
						{Vector(-7381, -10075, -381), '*81'},
						{Vector(-7381, -10203, -381), '*80'},
						{Vector(-7381, -10331, -381), '*79'},
					}
					
local ApartmentsDoors = 	{
						{Vector(-10416, -9919, 128), '*237'},
						{Vector(-10416.375, -9859, 128), '*236'},
					}
					
local RoadCrewDoors = 	{
						{Vector(694, 4067, 136), '*161'},
						{Vector(694, 3955, 136), '*162'},
						{Vector(694, 3851, 136), '*164'},
						{Vector(694, 3739, 136), '*163'},
						{Vector(743, 4093, 126.25), 'models/props_c17/door01_left.mdl'},
						{Vector(566, 4571, 126.25), 'models/props_c17/door01_left.mdl'},
						{Vector(845, 4528, 126.25), 'models/props_c17/door01_left.mdl'},
						{Vector(845, 4592, 126.25), 'models/props_c17/door01_left.mdl'},
						{Vector(937, 4101, 136), '*166'},
						{Vector(937, 4220, 136), '*165'},
						{Vector(1312, 4603, 144), '*159'},
						{Vector(1084, 4603, 144), '*160'},
					}
					
function ENTITY:IsPoliceDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isPoliceDoor) then return true; end
	
	for k, v in pairs(policeDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isPoliceDoor = true;
			return true;
		end
	end
	
	return false;
end

function ENTITY:IsCivilDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isCivilDoor) then return true; end
	
	for k, v in pairs(civilDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isCivilDoor = true;
			return true;
		end
	end
	
	return false;
end


function ENTITY:IsRealtorOfficeDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isRealtorOfficeDoor) then return true; end
	
	for k, v in pairs(RealtorOfficeDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isRealtorOfficeDoor = true;
			return true;
		end
	end
	
	return false;
end

function ENTITY:IsBPShopDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isBPShopDoor) then return true; end
	
	for k, v in pairs(BPShopDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isBPShopDoor = true;
			return true;
		end
	end
	
	return false;
end

function ENTITY:IsFCStoreDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isFCStoreDoor) then return true; end
	
	for k, v in pairs(FCStoreDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isFCStoreDoor = true;
			return true;
		end
	end
	
	return false;
end

function ENTITY:IsTidesHotelDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isTidesHotelDoor) then return true; end
	
	for k, v in pairs(TidesHotelDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isTidesHotelDoor = true;
			return true;
		end
	end
	
	return false;
end

function ENTITY:IsShopsDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isShopsDoor) then return true; end
	
	for k, v in pairs(ShopsDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isShopsDoor = true;
			return true;
		end
	end
	
	return false;
end

function ENTITY:IsCarDealerDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isCarDealerDoor) then return true; end
	
	for k, v in pairs(CarDealerDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isCarDealerDoor = true;
			return true;
		end
	end
	
	return false;
end

function ENTITY:IsHospitalDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isHospitalDoor) then return true; end
	
	for k, v in pairs(HospitalDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isHospitalDoor = true;
			return true;
		end
	end
	
	return false;
end

function ENTITY:IsGovermentCenterDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isGovermentCenterDoor) then return true; end
	
	for k, v in pairs(GovermentCenterDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isGovermentCenterDoor = true;
			return true;
		end
	end
	
	return false;
end

function ENTITY:IsJailsDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isJailsDoor) then return true; end
	
	for k, v in pairs(JailsDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isJailsDoor = true;
			return true;
		end
	end
	
	return false;
end

function ENTITY:IsApartmentsDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isApartmentsDoor) then return true; end
	
	for k, v in pairs(ApartmentsDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isApartmentsDoor = true;
			return true;
		end
	end
	
	return false;
end

function ENTITY:IsRoadCrewDoor ( )
	if (!self:IsDoor()) then return false; end
	if (self.isRoadCrewDoor) then return true; end
	
	for k, v in pairs(RoadCrewDoors) do
		if (v[1]:Distance(self:GetPos()) < 50 && v[2] == self:GetModel()) then
			self.isRoadCrewDoor = true;
			return true;
		end
	end
	
	return false;
end

function GM.FindEntity ( pos, model )
	for _, ent in pairs(ents.FindInSphere(pos, 50)) do
		//if (ent:GetModel() == model) then
			return ent
		//end
	end
end

OwnableDoors = {}
function GM:RegisterProperty ( PropertyTable )
	if (PROPERTY_DATABASE[PropertyTable.ID]) then
		Error("Conflicting property ID's #" .. PropertyTable.ID);
	end
	
	if CLIENT then
		PropertyTable.Texture = surface.GetTextureID("PERP2/property/" .. PropertyTable.Image);
	else
		for k, v in pairs(PropertyTable.Doors) do
			local foundDoor = false
			
			for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
				if (ent:IsDoor() && ent:GetModel() == v[2]) then
					ent:Fire("lock", "", 0);
					table.insert(OwnableDoors, v[1])
					foundDoor = true;
					break
				end
			end
			
			if (!foundDoor) then
				Msg("\t\tMissing Door -> " .. PropertyTable.Name .. " #" .. k .. "\n")
			end
		end
	end
	
	Msg("\t-> Loaded " .. PropertyTable.Name .. "\n");

	PROPERTY_DATABASE[PropertyTable.ID] = PropertyTable;
end

ST1 = "2697"

function PLAYER:CanManipulateDoor ( door )
	if ((self:Team() == TEAM_POLICE || self:Team() == TEAM_SWAT || self:Team() == TEAM_DISPATCHER || self:Team() == TEAM_SECRET_SERVICE || self:Team() == TEAM_MAYOR) && door:IsPoliceDoor()) then return true; end
	if ((self:Team() == TEAM_FIREMAN || self:Team() == TEAM_MEDIC || self:Team() == TEAM_DISPATCHER || self:Team() == TEAM_SECRET_SERVICE || self:Team() == TEAM_MAYOR) && door:IsCivilDoor()) then return true; end
	
	if (!door:IsDoor() && !door:IsVehicle()) then return false; end
	
	local doorOwner = door:GetTrueOwner();
	if (!doorOwner || !IsValid(doorOwner) || !doorOwner:IsPlayer()) then return false; end
	
	if (self == doorOwner || doorOwner:HasBuddy(self)) then return true; end
		
	return false;
end

function ENTITY:IsDoor ( )
	return string.find(self:GetClass(), "door");
end

local doorAssosiations = {};
function ENTITY:GetPropertyTable ( )
	if (!self:IsDoor()) then return nil; end
	
	if (!doorAssosiations[self:EntIndex()]) then
		for k, v in pairs(PROPERTY_DATABASE) do
			for _, doorInfo in pairs(v.Doors) do
				if (doorInfo[1]:Distance(self:GetPos()) < 50 && self:GetModel() == doorInfo[2]) then
					doorAssosiations[self:EntIndex()] = k;
				end
			end
		end
	end
	
	return PROPERTY_DATABASE[doorAssosiations[self:EntIndex()]];
end

function ENTITY:GetTrueOwner ( )
	if (!self:IsVehicle() && !self:IsDoor()) then return nil; end
	
	if (self:IsDoor()) then
		if (self:GetPropertyTable()) then
			return GetGlobalEntity("p_" .. self:GetPropertyTable().ID);
		else
			return nil;
		end
	end
	
	return self:GetNetworkedEntity("owner");
end

ENTITY.GetDoorOwner = ENTITY.GetTrueOwner;
ENTITY.GetVehicleOwner = ENTITY.GetTrueOwner;
ENTITY.GetCarOwner = ENTITY.GetTrueOwner;

if CLIENT then return; end

local autolockDoors = 	{
							{Vector(-6967, -12459, 135), '*244'},
							{Vector(-7089, -12459, 135), '*245'}
						};
						
local autodeleteEnts = 	{
							{Vector(-7744, -9204.5, 888), '*144'},
							{Vector(-7738, -9204.5, 888), '*143'},
							{Vector(-7744, -9204.5, 888), '*144'},
							{Vector(-7738, -9204.5, 888), '*143'},
							{Vector(-7670, -9109.41015625, 888), '*155'},
							{Vector(-7664, -9109.41015625, 888), '*156'},
							{Vector(-7838, -9109.5, 888), '*153'},
							{Vector(-7832, -9109.5, 888), '*154'},
							{Vector(-7906, -9204.5, 888), '*145'},
							{Vector(-7912, -9204.5, 888), '*146'},
							{Vector(-8006, -9109.5, 888), '*151'},
							{Vector(-8000, -9109.5, 888), '*152'},
							{Vector(-8091.4399414063, -9118.98046875, 888), '*147'},
							{Vector(-8091.4301757813, -9112.9697265625, 888), '*148'},
							{Vector(-8080, -9204.5, 888), '*150'},
							{Vector(-8074, -9204.5, 888), '*149'},
							{Vector(-9001, -9899.8603515625, 117.08000183105), '*119'},
							{Vector(-9001, -9851.8603515625, 117.08000183105), '*117'},
							{Vector(-6761.5, -9456, 890), '*128'},
							{Vector(-6761.5, -9450, 890), '*130'},
						};
						
local autoopenDoors =	{
							{Vector(-8992, -9985, 196), '*116'},
							{Vector(-8992, -9769, 196), '*118'},
							{Vector(-10703, 9495, 126.25), 'models/props_c17/door03_left.mdl'},
							{Vector(-6758, -10521, -124.5), '*145'},
							{Vector(-6768, -8986, -377.75), 'models/props_c17/door03_left.mdl'},
							{Vector(-6768, -8892, -377.75), 'models/props_c17/door03_left.mdl'},
						}
						
local function lockDoors ( )
	for k, v in pairs(autolockDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("lock", "", 0);
			end
		end
	end
	
	for k, v in pairs(autoopenDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("open", "", 0);
			end
		end
	end
	
	for k, v in pairs(autodeleteEnts) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:GetModel() == v[2]) then
				ent:Remove()
			end
		end
	end
	
	for k, ent in pairs(ents.FindByClass("prop_physics")) do ent:Remove() end
	for k, ent in pairs(ents.FindByClass("prop_physics_multiplayer")) do ent:Remove() end
	
	/*
	for k, v in pairs(policeDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("lock", "", 0);
			end
		end
	end
	*/
	
	for k, v in pairs(civilDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("lock", "", 0);
			end
		end
	end
	
	/*
	for k, v in pairs(RealtorOfficeDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("open", "", 0);
			end
		end
	end
	
	for k, v in pairs(BPShopDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("open", "", 0);
			end
		end
	end
	
	for k, v in pairs(FCStoreDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("open", "", 0);
			end
		end
	end
	
	for k, v in pairs(TidesHotelDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("open", "", 0);
			end
		end
	end
	
	for k, v in pairs(ShopsDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("open", "", 0);
			end
		end
	end
	
	for k, v in pairs(CarDealerDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("open", "", 0);
			end
		end
	end
	
	for k, v in pairs(HospitalDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("open", "", 0);
			end
		end
	end
	
	for k, v in pairs(GovermentCenterDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("open", "", 0);
			end
		end
	end
	
	for k, v in pairs(JailsDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("open", "", 0);
			end
		end
	end
	
	for k, v in pairs(ApartmentsDoors) do
		for _, ent in pairs(ents.FindInSphere(v[1], 50)) do
			if (ent:IsDoor() && ent:GetModel() == v[2]) then
				ent:Fire("open", "", 0);
			end
		end
	end
	*/
end
hook.Add("InitPostEntity", "lockDoors", lockDoors);

function GM.ToggleProperty ( Player, Cmd, Args )
	if (!Args[1]) then return; end
	
	local property = tonumber(Args[1]);
	
	if (!PROPERTY_DATABASE[property]) then return; end
	
	local curOwner = GetGlobalEntity('p_' .. property);
	local hasOwner = curOwner && curOwner:IsValid() && curOwner:IsPlayer();
	
	if (hasOwner && curOwner != Player) then return; end
	
	local cost = PROPERTY_DATABASE[property].Cost + math.Round(PROPERTY_DATABASE[property].Cost * GAMEMODE.GetTaxRate_Sales())
	
	if (!hasOwner && Player:GetCash() < cost) then return; end
	
	if (hasOwner) then
		Player:GiveCash(math.Round(PROPERTY_DATABASE[property].Cost * .5));
		GAMEMODE.HouseAlarms[property] = nil;
		
		Player.OwnsThisProperty = nil;
		
		SetGlobalEntity("p_" .. property, Entity());
	else
		GAMEMODE.GiveCityMoney(math.Round(PROPERTY_DATABASE[property].Cost * GAMEMODE.GetTaxRate_Sales()))
		Player:TakeCash(cost);
		
		if (PROPERTY_DATABASE[property].OnBought) then
			PROPERTY_DATABASE[property].OnBought()
		end
		
		Player.OwnsThisProperty = property;
		
		SetGlobalEntity("p_" .. property, Player);
	end
end
concommand.Add("perp_p_b", GM.ToggleProperty);

local function RefreshProperties ( )
	
	for k, v in pairs(player.GetAll()) do
		if v.OwnsThisProperty then
			SetGlobalEntity("p_" .. v.OwnsThisProperty, v);
		end
	end
end
timer.Create("RefreshProperties", 40, 0, RefreshProperties)

local function showReadout ( user )
	if (game.IsDedicated()) then return end
	
	local ent = user:GetEyeTrace().Entity
	
	Msg("{Vector(" .. ent:GetPos().x .. ", " .. ent:GetPos().y .. ", " .. ent:GetPos().z .. "), '" .. ent:GetModel() .. "'},\n")
end
concommand.Add("perp_p_s", showReadout)