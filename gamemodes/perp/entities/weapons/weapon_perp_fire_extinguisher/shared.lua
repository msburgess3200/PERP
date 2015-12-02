
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Fire Extinguisher"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Left Click: Extinguish Fires"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false

SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.ViewModel = "models/weapons/v_fire_extinguisher.mdl";
SWEP.WorldModel = "models/perp2/w_fists.mdl";

SWEP.ShootSound = Sound("ambient/wind/wind_hit2.wav");


function SWEP:Initialize()
	//if SERVER then
		self:SetWeaponHoldType("normal")
	//end
end

function SWEP:CanPrimaryAttack ( ) return true; end

function SWEP:PrimaryAttack()	
	if self:GetTable().LastNoise == nil then self:GetTable().LastNoise = true; end
	if self:GetTable().LastNoise then
		self.Weapon:EmitSound(self.ShootSound)
		self:GetTable().LastNoise = false;
	else
		self:GetTable().LastNoise = true;
	end
	
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Weapon:SetNextPrimaryFire(CurTime() + .1)
	
	if CLIENT or (SERVER) then		
		local ED = EffectData();
			ED:SetEntity(self.Owner);
		util.Effect('fire_extinguish', ED);
	end
	
	if SERVER then
		local Trace2 = {};
		Trace2.start = self.Owner:GetShootPos();
		Trace2.endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 150;
		Trace2.filter = self.Owner;

		local Trace = util.TraceLine(Trace2);
				
		local CloseEnts = ents.FindInSphere(Trace.HitPos, 50)
		
		for k, v in pairs(CloseEnts) do
			if v:GetClass() == 'ent_fire' then
				v:HitByExtinguisher(self.Owner)
			end
			
			if v:IsOnFire() then v:Extinguish() end
		end
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack();
end
