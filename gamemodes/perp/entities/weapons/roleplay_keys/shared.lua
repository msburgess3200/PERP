if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Keys"
	SWEP.Slot = 1
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Left Click: Lock Door, Right Click: Unlock Door"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false 
SWEP.AnimPrefix	 = "rpg"

SWEP.LockSound = "doors/door_latch1.wav"
SWEP.UnlockSound = "doors/door_latch3.wav"

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

SWEP.ViewModel = "models/perp2/v_fists.mdl";
SWEP.WorldModel = "models/perp2/w_fists.mdl";

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end

function SWEP:CanPrimaryAttack ( ) return true; end

function SWEP:PrimaryAttack()
	if CLIENT then return false; end
	
	if GAMEMODE.LockOverride then
		self.Owner:Notify("You cannot lock doors during this event.");
		return false;
	end

	local EyeTrace = self.Owner:GetEyeTrace()
	
	if (!EyeTrace.Entity || !IsValid(EyeTrace.Entity)) then return false; end
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	
	if Distance > 75 and EyeTrace.Entity:IsDoor() then return false; end
	if Distance > 100 and EyeTrace.Entity:IsVehicle() then return false; end
	
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	
	if (!self.Owner:CanManipulateDoor(EyeTrace.Entity)) then
		self.Owner:Notify("You do not own this");
		
		return false;
	end
	
	EyeTrace.Entity:Fire("lock", "", 0)
	self.Owner:EmitSound(self.LockSound)
end

function SWEP:SecondaryAttack()
	if CLIENT then return false; end

	local EyeTrace = self.Owner:GetEyeTrace()
	
	if (!EyeTrace.Entity || !IsValid(EyeTrace.Entity)) then return false; end
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	
	if Distance > 75 and EyeTrace.Entity:IsDoor() then return false; end
	if Distance > 100 and EyeTrace.Entity:IsVehicle() then return false; end
	
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	
	if (!self.Owner:CanManipulateDoor(EyeTrace.Entity)) then
		print("Bug test");
		return false;
	end


	EyeTrace.Entity:Fire("unlock", "", 0)
	self.Owner:EmitSound(self.UnlockSound)
end
