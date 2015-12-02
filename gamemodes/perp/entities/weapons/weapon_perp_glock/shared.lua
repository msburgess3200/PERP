
if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.BackHolster = false;
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Glock"			
	SWEP.Author				= "Counter-Strike"

	SWEP.Slot				= 2
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "c"
	
end

SWEP.HoldType			= "pistol";
SWEP.HoldTypeNorm		= "normal";

SWEP.Base				= "weapon_perp_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_pist_glock18.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_glock18.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.AnimPrefix	 = "rpg"

SWEP.Primary.Sound			= Sound( "Weapon_Glock.Single" )
SWEP.Primary.Recoil			= 1.8
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.03
SWEP.Primary.ClipSize		= 16
SWEP.Primary.Delay			= 0.05
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 		= Vector (4.3354, -3.3319, 2.8099)
SWEP.IronSightsAng 		= Vector (0, 0, 0)
SWEP.NormalPos 			= Vector( 0, 0, 3 )
SWEP.NormalAng 			= Vector(  -20, 0, 0 );

SWEP.MaxPenetration = PENETRATION_PISTOL;

SWEP.GrantExperience_Skill 	= SKILL_PISTOL_MARK;
SWEP.GrantExperience_Exp	= 2;