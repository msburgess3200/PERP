
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Lock Pick"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Left Click: Attempt to pick lock."
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.HoldType = "melee";
SWEP.ViewModel = "models/weapons/v_crowbar.mdl";
SWEP.WorldModel = "models/weapons/w_crowbar.mdl";

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "melee"

SWEP.BreakSound = "doors/handle_pushbar_locked1.wav"
SWEP.BatterSound = "doors/door_locked2.wav"
SWEP.BreakSelfChance = 10;
SWEP.PercentChance = 10;
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize() self:SetWeaponHoldType("melee") end
function SWEP:CanPrimaryAttack ( ) return true; end

function SWEP:TryToBatter ( Target )
	/*
	if Target:GetDoorOwner() == self.Owner then 
		self.Owner:Notify('You pick open your own doors. Use a key!');
		return false;
	end
	*/
	
	self:EmitSound(self.BatterSound);
	
	local function whatlol ( )
		if !self or !self:IsValid() then return false; end
		
		local Randomness = math.random(1, 100);
		
		local SetOffHouseAlarm = true;
		if Randomness <= self.BreakSelfChance then
			self:EmitSound(self.BreakSound);
			self.Owner:Notify('Your lock pick broke!');
			self.Owner:RemoveEquipped(EQUIP_SIDE);
		elseif Randomness <= self.BreakSelfChance + self.PercentChance then		
			Target:Fire('unlock', '', 0);
			Target:Fire('open', '', .5);
			SetOffHouseAlarm = false;
			
			if IsValid(self.Owner) then
				self.Owner:GiveExperience(SKILL_LOCK_PICKING, 25);
			end
		end
		
		if SetOffHouseAlarm then			
			local GroupTable = Target:GetPropertyTable();

			if (GroupTable) then
				local Group = GroupTable.ID;
				
				if GAMEMODE.HouseAlarms[Group] and (!Target:GetTable().LastSirenPlay or Target:GetTable().LastSirenPlay + 30 < CurTime()) and Target:GetDoorOwner() and Target:GetDoorOwner():IsValid() and Target:GetDoorOwner():IsPlayer() then
					umsg.Start("perp_house_alarm");
						umsg.Entity(Target);
					umsg.End();
					
					Target:GetTable().LastSirenPlay = CurTime()
					
					local lifeAlertZone = Target:GetZoneName();
					
					if (lifeAlertZone) then
						GAMEMODE:PlayerSay(self:GetDoorOwner(), "/911 [Burglar Alarm] A break in has occured at " .. lifeAlertZone .. ". Police requested.", true, false);
					else
						Msg("no life alert zone.\n")
					end
				end
			end
		end
	end
	
	if SERVER then
		timer.Simple(1.5, whatlol);
	end
end

function SWEP:TryToPickCar ( Target )
	if self.PadLocked then return false; end

	self:EmitSound(self.BatterSound);
	
	local function whatlol ( )
		if !self or !self:IsValid() then return false; end
		
		local Randomness = math.random(1, 100);
		
		if Randomness <= self.BreakSelfChance then
			self:EmitSound(self.BreakSound);
			self.Owner:Notify('Your lock pick broke!');
			self.Owner:RemoveEquipped(EQUIP_SIDE);
		elseif Randomness <= self.BreakSelfChance + self.PercentChance then
			Target:Fire('unlock', '', 0);
			Target:Fire('open', '', .5);
	
				umsg.Start("perp_car_alarm");
					umsg.Entity(Target);
				umsg.End();
				
				local CarOwner = Target:GetNetworkedEntity("owner");
				
				CarOwner.StolenCarTimeLimit = CurTime() + 180;
				
				self.Owner:Notify("Car lockpicked, take it to the chop shop for some extra cash");
				self.Owner.StolenCar = Target;
			
			if IsValid(self.Owner) then
				self.Owner:GiveExperience(SKILL_LOCK_PICKING, 25);
			end
		end
	end
	
	if SERVER then
		timer.Simple(1.5, whatlol);
	end
end

//1390963

function SWEP:PrimaryAttack()
	local EyeTrace = self.Owner:GetEyeTrace()

	if (EyeTrace.Entity:IsValid() && EyeTrace.Entity:IsDoor()) then
	
		local group = EyeTrace.Entity:GetPropertyTable();
	
		if (!group) then return false; end
	
		local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	
		if Distance > 75 then return false; end
		
		/*
		local doorOwner = EyeTrace.Entity:GetDoorOwner();
		
		if doorOwner:GetTimePlayed() < 7200 then
			print(doorOwner:GetTimePlayed());
			self.Owner:Notify("You cannot raid new players");
			return false;
		end
		*/
	
		self:TryToBatter(EyeTrace.Entity);

		self.Weapon:SetNextPrimaryFire(CurTime() + 3)
		self.Weapon:SetNextSecondaryFire(CurTime() + 3)
	elseif (EyeTrace.Entity:IsValid() && EyeTrace.Entity:IsVehicle()) then
		
		self.Owner.lastattempt = self.Owner.lastattempt or 0;
		if (self.Owner.lastattempt > CurTime()) then return; end
		
		local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
		
		if Distance > 75 then return false; end
		
		local Owner = EyeTrace.Entity:GetNetworkedEntity("owner");
		
		if (Owner:Team() != TEAM_CITIZEN) then
			self.Owner:Notify("You cannot lockpick government vehicles.");
			self.Owner.lastattempt = CurTime() + 1;
			return false;
		elseif (Owner == self.Owner) then
			self.Owner:Notify("You cannot lockpick your own car.");
			self.Owner.lastattempt = CurTime() + 1;
			return false;
		elseif (EyeTrace.Entity.PadLocked) then
			self.Owner:Notify("This vehicle is equiped with security package. It cannot be picked.");
			Owner:Notify("Someone has attempted to break in your car.");
			self.Owner.lastattempt = CurTime() + 1;
			return false;
		end
		
		self:TryToPickCar(EyeTrace.Entity);
		
		self.Weapon:SetNextPrimaryFire(CurTime() + 2)
		self.Weapon:SetNextSecondaryFire(CurTime() + 2)
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack();
end
