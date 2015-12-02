
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Defibrillator"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Left Click: Attempt to shock victim back to life. Right Click: Charge defibrillator."
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

SWEP.ViewModel = "models/weapons/v_defilibrator.mdl";
SWEP.WorldModel = "models/perp2/w_fists.mdl"; 

if CLIENT then
	function SWEP:GetViewModelPosition ( Pos, Ang )
		//Ang:RotateAroundAxis(Ang:Forward(), 90);
		//Pos = Pos + Ang:Forward() * 3;
		Pos = Pos + Ang:Up() * 6;
		
		return Pos, Ang;
	end 
end

function SWEP:Initialize()
	//if SERVER then
		self:SetWeaponHoldType("normal")
	//end
	
	self.ChargeAmmount = 0;
	self.NextDecharge = CurTime() + 5;
	self.SmoothCharge = CurTime() + 5;
	self.LastNoChargeError = CurTime();
end

function SWEP:CanPrimaryAttack ( ) return true; end

function SWEP:PrimaryAttack()	
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)

	if self.ChargeAmmount < 75 then
		if SERVER and self.LastNoChargeError + 1 < CurTime() then
			self.LastNoChargeError = CurTime();
			self.Owner:Notify('Not enough charge!');
		end
		
		return false;
	end
	
	local EyeTrace = self.Owner:GetEyeTrace();
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	if Distance > 75 then return false; end
	
	if CLIENT then	
		LastCPRUpdate = LastCPRUpdate or 0;
			
		if LastCPRUpdate + .5 < CurTime() then
			LastCPRUpdate = CurTime();
			
			for k, v in pairs(player.GetAll()) do
				if !v:Alive() then
					for _, ent in pairs(ents.FindInSphere(EyeTrace.HitPos, 5)) do						
						if ent == v:GetRagdollEntity() then
							self.Weapon:EmitSound("perp2/revive.wav");
							self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK);
								
							self.ChargeAmmount = self.ChargeAmmount - 75
								
							RunConsoleCommand('perp_m_h', v:UniqueID());
							return;
						end
					end
				end
			end
		end
	end
end

function SWEP:Think ( )
	/*if CurTime() < self.NextDecharge then
		if self.ChargeAmmount != 0 then
			self.ChargeAmmount = self.ChargeAmmount - 1;
		end
		
		self.NextDecharge = CurTime() + 5;
	end*/
end

function SWEP:SecondaryAttack()
	if (GAMEMODE.LastChargeUp && GAMEMODE.LastChargeUp + .75 > CurTime()) then return; end
	
	self.Weapon:SetNextSecondaryFire(CurTime() + .75)
	self.Weapon:SetNextPrimaryFire(CurTime() + .75)
	self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK);
	
	//self.Weapon:EmitSound("ambient/energy/spark5.wav");
	
	GAMEMODE.LastChargeUp = CurTime();
	self.ChargeAmmount = math.Clamp(self.ChargeAmmount + 25, 0, 100);
end

function SWEP:GetChargeAmmount ( )
	return self.ChargeAmmount;
end
