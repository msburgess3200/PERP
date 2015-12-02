
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Health Kit"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Left Click: Give health to a citizen ( 10 second cooldown )"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

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

SWEP.ViewModel = "models/weapons/v_healthkit.mdl";
SWEP.WorldModel = "models/perp2/w_fists.mdl";  

SWEP.NormalPos = Vector (0.008, -8.7471, -0.0641)
SWEP.NormalAng = Vector (0, 0, 0)

SWEP.IronSightsPos = Vector (0, 2.2083, 0)
SWEP.IronSightsAng = Vector (0, 0, 0)


function SWEP:Initialize()
	//if SERVER then
		self:SetWeaponHoldType("normal")
	//end
end

function SWEP:CanPrimaryAttack ( ) return true; end

function SWEP:PrimaryAttack()	
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	self.Weapon:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav");
	self.IsIronsighted = true;
	self.Owner:SetAnimation(ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST)
		
	self.Weapon:SetNextPrimaryFire(CurTime() + 10)
	self.Weapon:SetNextSecondaryFire(CurTime() + 10)
	
	local EyeTrace = self.Owner:GetEyeTrace();
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	if Distance > 75 then return false; end
	
	self.LastUse = CurTime();
	
	if CLIENT then return false; end
	if !EyeTrace.Entity or !EyeTrace.Entity:IsValid() or !EyeTrace.Entity:IsPlayer() then return false; end
	
	EyeTrace.Entity:SetHealth(math.Clamp(EyeTrace.Entity:Health() + 50, 0, 100));
	
	if EyeTrace.Entity.Crippled then
		EyeTrace.Entity.Crippled = false;
		EyeTrace.Entity:FindRunSpeed();
	end
		
	sound.Play(Sound('items/smallmedkit1.wav'), EyeTrace.HitPos, 50, 50)
end

local IRONSIGHT_TIME = 0.15
function SWEP:GetViewModelPosition ( pos, ang )

	if ( !self.IronSightsPos ) then return pos, ang end

	local bIron = self.IsIronsighted;
	
	if ( bIron != self.bLastIron ) then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if ( bIron ) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	local Mul = 1.0

	if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then
		if self.NormalAng then
			ang = ang * 1
			ang:RotateAroundAxis( ang:Right(), 		self.NormalAng.x * Mul )
			ang:RotateAroundAxis( ang:Up(), 		self.NormalAng.y * Mul )
			ang:RotateAroundAxis( ang:Forward(), 	self.NormalAng.z * Mul )
		end
		
		if self.NormalPos then
			pos = pos + self.NormalPos.x * Right * Mul
			pos = pos + self.NormalPos.y * Forward * Mul
			pos = pos + self.NormalPos.z * Up * Mul
		end
	
		return pos, ang;
	end
	
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
	
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		
		if (!bIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if ( self.IronSightsAng ) then
	
		if (Mul == 1) then
			self.IsIronsighted = nil;
		end
	
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	
	end
	
	if self.NormalAng then
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.NormalAng.x * (1 - Mul) )
		ang:RotateAroundAxis( ang:Up(), 		self.NormalAng.y * (1 - Mul) )
		ang:RotateAroundAxis( ang:Forward(), 	self.NormalAng.z * (1 - Mul) )
	end

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul
	
	if self.NormalPos then
		pos = pos + self.NormalPos.x * Right * (1 - Mul)
		pos = pos + self.NormalPos.y * Forward * (1 - Mul)
		pos = pos + self.NormalPos.z * Up * (1 - Mul)
	end

	return pos, ang
	
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack();
end
