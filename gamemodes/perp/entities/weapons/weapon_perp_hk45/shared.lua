if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.BackHolster = false;
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "USP"			
	SWEP.Author				= "Misha"

	SWEP.Slot				= 2
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "f"
	
end
SWEP.HoldType			= "pistol"
SWEP.HoldTypeNorm		= "normal"

SWEP.Base				= "weapon_perp_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_pist_usp.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_usp.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.AnimPrefix	 = "rpg"

SWEP.Primary.Sound			= Sound( "Weapon_hk45.Single" )
SWEP.Primary.Recoil			= 0.5
SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 16
SWEP.Primary.Delay			= 0
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 		= Vector (1.8279, 0, 1.3514)
SWEP.NormalPos 			= Vector( 0, 0, 3 )
SWEP.NormalAng 			= Vector(  -20, 0, 0 )

SWEP.MaxPenetration = PENETRATION_PISTOL

SWEP.GrantExperience_Skill 	= SKILL_PISTOL_MARK
SWEP.GrantExperience_Exp	= 2