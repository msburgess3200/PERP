if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Molotov Cocktail"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Left Click: Throw"
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

SWEP.ViewModel = "models/weapons/v_molotov.mdl";
SWEP.WorldModel = "models/weapons/w_beerbot.mdl";

function SWEP:Initialize()
	//if SERVER then
		self:SetWeaponHoldType("melee")
	//end
end

function SWEP:CanPrimaryAttack ( ) return true; end

function SWEP:PrimaryAttack()	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav")
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	
	if SERVER then
		local Molotov = ents.Create('ent_molotov');
		Molotov:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector() * 20);
		Molotov:Spawn();
		Molotov:GetPhysicsObject():ApplyForceCenter(self.Owner:GetAimVector() * 1500);
		
		self.Owner:RemoveEquipped(EQUIP_SIDE);
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack();
end
