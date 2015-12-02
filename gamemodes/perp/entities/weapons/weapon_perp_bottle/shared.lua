
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Emtpy Bottle"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Left Click: Hit"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false

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

SWEP.ViewModel = "models/weapons/v_beerbo2.mdl"
SWEP.WorldModel = "models/weapons/w_beerbo2.mdl"

function SWEP:Initialize()
	//if SERVER then
		self:SetWeaponHoldType("melee")
	//end
end

function SWEP:CanPrimaryAttack() return true end

function SWEP:PrimaryAttack()	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav")
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	
	local EyeTrace = self.Owner:GetEyeTrace();
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	if Distance > 75 then return false; end
		
	if EyeTrace.HitWorld then
		self.Weapon:EmitSound("physics/glass/glass_impact_bullet" .. math.random(1, 4) .. ".wav");
		
		util.Decal('BeerSplash', EyeTrace.HitPos + EyeTrace.HitNormal, EyeTrace.HitPos - EyeTrace.HitNormal);
		
		return false;
	end
	
	if !EyeTrace.Entity or !EyeTrace.Entity:IsValid() or !EyeTrace.HitNonWorld then return false; end
	
	if EyeTrace.MatType == MAT_FLESH then
		self.Weapon:EmitSound("physics/flesh/flesh_impact_hard" .. math.random(1, 6) .. ".wav")
		
		local OurEffect = EffectData();
		OurEffect:SetOrigin(EyeTrace.HitPos);
		util.Effect("BloodImpact", OurEffect);
		
		if SERVER then
			if EyeTrace.Entity:IsPlayer() then
				EyeTrace.Entity:TakeDamage(10, self.Owner, self.Weapon);
			end
		end
		
		return false;
	else
		self.Weapon:EmitSound("physics/glass/glass_impact_bullet" .. math.random(1, 4) .. ".wav");
		
		if SERVER then
			if math.random(1, 5) == 1 then
				self.Owner:Notify('Your bottle broke!');
				self:Remove();
			end
		end
		
		return false;
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack();
end

