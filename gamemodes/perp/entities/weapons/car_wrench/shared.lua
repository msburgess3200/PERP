
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Wrench"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Left Click: Fix a car"
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

SWEP.AnimPrefix  = "stunstick"

SWEP.ViewModel = "models/weapons/v_basebat.mdl"
SWEP.WorldModel = "models/weapons/W_basebat.mdl"

function SWEP:Initialize()
	self:SetWeaponHoldType("melee")
end

function SWEP:PrimaryAttack()	
	self.Owner:SetAnimation(PLAYER_ATTACK1);
	self.Weapon:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav");
    self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER);
	
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	
	local EyeTrace = self.Owner:GetEyeTrace();
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	if Distance > 75 then return false; end
	
	if CLIENT then
		if(ValidEntity(EyeTrace.Entity) and EyeTrace.Entity:IsVehicle()) then
			for i=0, 1.3, 0.3 do
				timer.Simple(i, function()
					local num = (math.random(1,2) == 1 and math.random(1, 3)) or math.random(5, 8)
					EyeTrace.Entity:EmitSound("npc/dog/dog_servo" .. num .. ".wav")
				end)
			end
		end
	else
		if(ValidEntity(EyeTrace.Entity) and EyeTrace.Entity:IsVehicle() and EyeTrace.Entity:GetTable().CarDamage) then

			if(EyeTrace.Entity:GetTable().CarDamage > 49 and EyeTrace.Entity.Disabled) then
				EyeTrace.Entity.Disabled = false;
				EyeTrace.Entity:SetColor(255, 255, 255, 255);
				EyeTrace.Entity:Fire('turnon', '', .5)
			else
			
				EyeTrace.Entity:GetTable().CarDamage = math.Clamp(EyeTrace.Entity:GetTable().CarDamage + 5, 0, 54)
				EyeTrace.Entity:FixTires()
				
				for i=0, 1.3, 0.3 do
					timer.Simple(i, function()
						if(ValidEntity(EyeTrace.Entity)) then
							local num = (math.random(1,2) == 1 and math.random(1, 3)) or math.random(5, 8)
							EyeTrace.Entity:EmitSound("npc/dog/dog_servo" .. num .. ".wav")
						end
					end)
				end
				
				local i = (EyeTrace.Entity:GetTable().CarDamage * 4)
				EyeTrace.Entity:SetColor(math.Clamp(50 + i, 0, 255), math.Clamp(50 + i, 0, 255), math.Clamp(50 + i, 0, 255), 255)
			end
		end
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack();
end