
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Video Camera"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Right Click: Start Recording"
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
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = ""

SWEP.ViewModel 			= "models/Tools/camera/camera.mdl";
SWEP.WorldModel 		= "models/camera/camera.mdl";
SWEP.BobScale			= 2
SWEP.SwayScale			= 2
SWEP.HoldType           = "rpg";

SWEP.Volume = 7
SWEP.Influence = 0

SWEP.LastSoundRelease = 0
SWEP.RestartDelay = 1
SWEP.RandomEffectsDelay = 0.2

SWEP.ViewModelDefPos = Vector (12.7306, 17.1875, -6.495)
SWEP.ViewModelDefAng = Vector (6.0177, 11.7713, -0.8871)

SWEP.MoveToPos = Vector (12.7306, 17.1875, -6.495)
SWEP.MoveToAng = Vector (6.0177, 11.7713, -0.8871)

function SWEP:Initialize()
	//if SERVER then
		self:SetWeaponHoldType("rpg")
	//end
	
	self.zoomLevel = 70;
end

function SWEP:CanPrimaryAttack ( ) return true; end
function SWEP:CanSecondaryAttack ( ) return true; end

function SWEP:PrimaryAttack()	
	self.zoomLevel = math.Clamp(zoomLevel + 1, 20, 70);
	self:layoutFOV();
end

function SWEP:layoutFOV ( )
	self.Owner:SetFOV(self.zoomLevel, 0);
	
	if (!CLIENT) then return end
	
	if (self.zoomLevel == 70) then
		self.Owner:DrawViewModel(true)
	else
		self.Owner:DrawViewModel(false)
	end
end

function SWEP:SecondaryAttack()
	self.zoomLevel = math.Clamp(zoomLevel - 1, 20, 70);
	self:layoutFOV();
end

function SWEP:Think()
	if self.Owner:KeyDown(IN_FORWARD) then
	self.Owner:ViewPunch( Angle( math.Rand(0,0.1), math.Rand(-0.4,0.4), 0 ) )
	if self.Owner:KeyDown(IN_SPEED) then
	self.Owner:ViewPunch( Angle( math.Rand(0,0.3), math.Rand(-0.4,0.4), math.Rand(-0.4,0.4) ) )
	end
	end

	if self.Owner:KeyDown(IN_MOVELEFT) then
	self.Owner:ViewPunch( Angle( math.Rand(0,0.1), math.Rand(-0.4,0.4), 0 ) )
	if self.Owner:KeyDown(IN_SPEED) then
	self.Owner:ViewPunch( Angle( math.Rand(0,0.3), math.Rand(-0.4,0.4), math.Rand(-0.4,0.4) ) )
	end
	end

	if self.Owner:KeyDown(IN_MOVERIGHT) then
	self.Owner:ViewPunch( Angle( math.Rand(0,0.1), math.Rand(-0.4,0.4), 0 ) )
	if self.Owner:KeyDown(IN_SPEED) then
	self.Owner:ViewPunch( Angle( math.Rand(0,0.3), math.Rand(-0.4,0.4), math.Rand(-0.4,0.4) ) )
	end
	end

	if self.Owner:KeyDown(IN_MOVELEFT) then
	self.Owner:ViewPunch( Angle( math.Rand(-0.4,0.4), math.Rand(-0.4,0.4), 0 ) )
	if self.Owner:KeyDown(IN_SPEED) then
	self.Owner:ViewPunch( Angle( math.Rand(-0.5,0.5), math.Rand(-0.4,0.4), math.Rand(-0.4,0.4) ) )
	end
	end

	local cmd = self.Owner:GetCurrentCommand()
	
	self.LastThink = self.LastThink or 0
	local fDelta = (CurTime() - self.LastThink)
	self.LastThink = CurTime()

end

function SWEP:GetViewModelPosition (pos, ang, inv, mul)
	local mul = 0
	if self.Weapon:GetNWBool ("on") then
		self.Volume = math.Clamp (self.Volume + FrameTime() * 3, 0, 1)
	else
		self.Volume = math.Clamp (self.Volume - FrameTime() * 3, 0, 1)
	end
	mul = self.Volume
	
	--this is always applied
	local DefPos = self.ViewModelDefPos
	local DefAng = self.ViewModelDefAng
	
	if DefAng then
		ang = ang * 1
		ang:RotateAroundAxis (ang:Right(), 		DefAng.x)
		ang:RotateAroundAxis (ang:Up(), 		DefAng.y)
		ang:RotateAroundAxis (ang:Forward(), 	DefAng.z)
	end

	if DefPos then
		local Right 	= ang:Right()
		local Up 		= ang:Up()
		local Forward 	= ang:Forward()
	
		pos = pos + DefPos.x * Right
		pos = pos + DefPos.y * Forward
		pos = pos + DefPos.z * Up
	end
	
	--and some more
	local AddPos = self.MoveToPos - self.ViewModelDefPos
	local AddAng = self.MoveToAng - self.ViewModelDefAng
	
	if AddAng then
		ang = ang * 1
		ang:RotateAroundAxis (ang:Right(), 		AddAng.x * mul)
		ang:RotateAroundAxis (ang:Up(), 		AddAng.y * mul)
		ang:RotateAroundAxis (ang:Forward(), 	AddAng.z * mul)
	end

	if AddPos then
		local Right 	= ang:Right()
		local Up 		= ang:Up()
		local Forward 	= ang:Forward()
	
		pos = pos + AddPos.x * Right * mul
		pos = pos + AddPos.y * Forward * mul
		pos = pos + AddPos.z * Up * mul
	end
	
	return pos, ang
end