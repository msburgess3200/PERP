
if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Hand Cuffs"
	SWEP.Slot = 2
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "RedMist"
SWEP.Instructions = "Left Click: Arrest"
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

SWEP.ViewModel = "models/katharsmodels/handcuffs/handcuffs-1.mdl";
SWEP.WorldModel = "models/perp2/w_fists.mdl"; 

if CLIENT then
	function SWEP:GetViewModelPosition ( Pos, Ang )
		Ang:RotateAroundAxis(Ang:Forward(), 90);
		Pos = Pos + Ang:Forward() * 6;
		Pos = Pos + Ang:Right() * 2;
		
		return Pos, Ang;
	end 
end

function SWEP:Initialize()
	//if SERVER then
		self:SetWeaponHoldType("melee")
	//end
end

function SWEP:Think()
end

function SWEP:PrimaryAttack()	
	if !self.Owner:Team() == TEAM_POLICE then self:Remove(); return end
	
	self.Weapon:SetNextPrimaryFire(CurTime() + 1)
	self.Weapon:SetNextSecondaryFire(CurTime() + 1)
	
	local EyeTrace = self.Owner:GetEyeTrace();
	
	self.Weapon:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav")
	
	if CLIENT then return false; end
	
	local Distance = self.Owner:EyePos():Distance(EyeTrace.HitPos);
	if Distance > 75 then return false; end
	if !EyeTrace.Entity or !EyeTrace.Entity:IsValid() or !EyeTrace.Entity:IsPlayer() then return false; end
	
	if EyeTrace.Entity:Team() != TEAM_CITIZEN then self.Owner:Notify('You cannot arrest government employees.'); return false; end
	
	self.Owner:GetTable().LastFreeArrest = self.Owner:GetTable().LastFreeArrest or 0;
	if !EyeTrace.Entity:GetNetworkedBool("warrent", false) and self.Owner:GetTable().LastFreeArrest + 600 > CurTime() then self.Owner:Notify('You can only arrest a unwarranted player once every 10 minutes.'); return false; end
	self.Owner:GetTable().LastFreeArrest = CurTime();
	
	self.Owner:Notify('You have arrested ' .. EyeTrace.Entity:GetRPName() .. '!');
	EyeTrace.Entity:Notify('You have been arrested!');
	
	for k, v in pairs(player.GetAll()) do
		if v:IsAdmin() then
			
			v:PrintMessage(HUD_PRINTCONSOLE, '[Arrest] ' .. self.Owner:Nick() .. ' arrested ' .. EyeTrace.Entity:Nick() .. '\n');
			GAMEMODE.AddChatLog('[Arrest] ' .. self.Owner:GetRPName() .. ' [ ' .. self.Owner:SteamID() .. ' ] arrested ' .. EyeTrace.Entity:GetRPName() .. '\n');
		end
	end
	
	if EyeTrace.Entity:GetNetworkedBool("warrent", false) then
		self.Owner:AddCash(GAMEMODE.CopReward_Arrest);
		self.Owner:Notify('You have been rewarded ' .. GAMEMODE.CopReward_Arrest .. ' for arresting a warranted convict.');
	end
	
	EyeTrace.Entity:Arrest()
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack();
end
