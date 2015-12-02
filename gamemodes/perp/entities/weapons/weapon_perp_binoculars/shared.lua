
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Binoculars"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Left Click: Zoom"
SWEP.Contact = ""
SWEP.Purpose = ""

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

SWEP.ViewModel = "models/weapons/v_perpculars.mdl"
SWEP.WorldModel	= "models/perp2/w_fists.mdl";

SWEP.curZoom = 1;

SWEP.ZoomIn = Sound("perp2/binoculars/in.wav");
SWEP.ZoomMax = Sound("perp2/binoculars/max.wav");
SWEP.ZoomOut = Sound("perp2/binoculars/out.wav");

function SWEP:Initialize() self:SetWeaponHoldType("normal") end

function SWEP:CanPrimaryAttack ( ) 
	return (self:GetNextPrimaryFire() <= CurTime()); 
end

SWEP.CanSecondaryAttack = SWEP.CanPrimaryFire;

local zoomSteps = {70, 35, 20, 5};
local soundsToPlay = {SWEP.ZoomOut, SWEP.ZoomIn, SWEP.ZoomIn, SWEP.ZoomMax};
function SWEP:PrimaryAttack ( Player ) 
	if (!self:CanPrimaryAttack()) then return; end
	
	self:SetNextPrimaryFire(CurTime() + .5);
	self:SetNextSecondaryFire(CurTime() + .5);

	local curStep = self.curZoom
	
	if (zoomSteps[curStep + 1]) then
		self.curZoom = curStep + 1;
	else
		self.curZoom = 1;
	end
	
	self.Owner:SetFOV(zoomSteps[self.curZoom], 0);
	
	if CLIENT then return end
	
	if (self.curZoom == 1) then
		self.Owner:DrawViewModel(true);
	else
		self.Owner:DrawViewModel(false);
	end
	
	self.Owner:SetPrivateInt("zoom", self.curZoom);
end

SWEP.SecondaryAttack = SWEP.PrimaryAttack;

function SWEP:Think ( )
	if (SERVER) then return; end
	
	local curZoom = self.Owner:GetPrivateInt("zoom", 1);
	self.lastZoom = self.lastZoom or 1;
	
	if (self.lastZoom != curZoom) then
		self.lastZoom = curZoom;
		
		if (soundsToPlay[curZoom]) then
			self:EmitSound(soundsToPlay[curZoom]);
		end
		
		self.Owner:SetFOV(zoomSteps[curZoom], 0);
		
		if (curZoom == 1) then
			RunConsoleCommand("pp_mat_overlay", "0");
		else
			RunConsoleCommand("pp_mat_overlay_texture", "effects/combine_binocoverlay.vmt");
			RunConsoleCommand("pp_mat_overlay", "1");
		end
	end
end

function SWEP:Holster ( )
	self.Owner:SetFOV(0, 0);
	self.curZoom = 1;
	
	if CLIENT then
		self.lastZoom = 1;
		RunConsoleCommand("pp_mat_overlay", "0");
	else self.Owner:DrawViewModel(true); end 
	
	return true;
end

function SWEP:Reload ( ) end
