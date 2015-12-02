
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Fuel Can"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Left Click: Add fuel"
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

SWEP.ViewModel = "models/perp2/v_fists.mdl";
SWEP.WorldModel = "models/perp2/w_fists.mdl";

SWEP.ShootSound = Sound("perp2.5/hose2.mp3");

function SWEP:Initialize()
	self:SetWeaponHoldType("fist")
end

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
	
	local EyeTrace = self.Owner:GetEyeTrace();
	
	if CLIENT or (SERVER) then		
		local ED = EffectData();
			ED:SetEntity(self.Owner);
		util.Effect('fire_hose_water', ED);
	end
	
	self.Owner:ViewPunch(Angle(math.Rand(-1,-0.5), math.Rand(-0.5,0.5), 0 ))
	
	
	if SERVER then
		if(ValidEntity(EyeTrace.Entity) and EyeTrace.Entity:IsVehicle()) then
			local VOwner = EyeTrace.Entity:GetNetworkedEntity("owner");
			
			EyeTrace.Entity:GetNetworkedEntity("owner"):SetPrivateInt("fuelleft", 1000, false);
			
			--if VOwner.IsPlayer() then print(VOwner.Nick()) end
			
			umsg.Start("send_fuel", EyeTrace.Entity:GetNetworkedEntity("owner"));
				umsg.Long(tonumber(1000));		// Fuel Left
			umsg.End();
		end
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack();
end
