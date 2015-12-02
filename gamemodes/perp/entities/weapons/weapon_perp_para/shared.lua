
if( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.BackHolster = true
	
end

if( CLIENT ) then

	SWEP.PrintName			= "Para"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "z"
	
	SWEP.ViewModelFlip		= false
	
end

SWEP.HoldType			= "ar2"
SWEP.HoldTypeNorm		= "normal"

SWEP.Base				= "weapon_perp_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_mach_m249para.mdl"
SWEP.WorldModel			= "models/weapons/w_mach_m249para.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.AnimPrefix	 = "rpg"

SWEP.Primary.Sound			= Sound( "Weapon_m249.Single" )
SWEP.Primary.Recoil			= 2
SWEP.Primary.Damage			= 60
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.05
SWEP.Primary.ClipSize		= 100
SWEP.Primary.Delay			= 0.09
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"


SWEP.IronSightsPos 		= Vector( -4.4, -3, 2 )
SWEP.IronSightsAng 		= Vector (0, 0, 0)
SWEP.NormalPos 			= Vector( 0, 0, 3 )
SWEP.NormalAng 			= Vector(  -20, 0, 0 )

SWEP.MaxPenetration = PENETRATION_RIFLE

SWEP.GrantExperience_Skill 	= SKILL_RIFLE_MARK
SWEP.GrantExperience_Exp	= 1
