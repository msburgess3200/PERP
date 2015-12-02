
include("shared.lua")

SWEP.PrintName			= "Traffic Ticket"
SWEP.Slot				= 4
SWEP.SlotPos			= 0
SWEP.DrawCrosshair		= false;
SWEP.Spawnable			= false;
SWEP.AdminSpawnable		= false;

function SWEP:Initialize()
end

function SWEP:DrawWorldModel()
	local iBone = self.Owner:LookupBone("ValveBiped.Bip01_L_Hand");
	if(iBone) then
		self:SetRenderOrigin(self.Owner:GetBonePosition(iBone) + self:GetUp() * 1 + self:GetForward() * 3 + self:GetRight() * 2);
		self:SetRenderAngles(Angle(0, self.Owner:GetAngles().y, 0));
	end
	
	self:DrawModel();
end

function SWEP:GetViewModelPosition(vPos, aAngles)
	vPos = vPos + LocalPlayer():GetUp() * -10;
	vPos = vPos + LocalPlayer():GetAimVector() * 20;
	vPos = vPos + LocalPlayer():GetRight() * 8;
	aAngles:RotateAroundAxis(aAngles:Right(), 90);
	aAngles:RotateAroundAxis(aAngles:Forward(), 0);

	return vPos, aAngles
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end
