
if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.BackHolster = false;
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Uzi"			
	SWEP.Author				= "Counter-Strike"

	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "l"
	
end

SWEP.HoldType			= "ar2";
SWEP.HoldTypeNorm		= "normal";

SWEP.Base				= "weapon_perp_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_smg_uzi10.mdl"
SWEP.WorldModel			= "models/weapons/w_smg_mac10.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.AnimPrefix	 = "rpg"

SWEP.Primary.Sound			= Sound("perp2/uzi-0.mp3");
SWEP.Primary.Recoil			= 0.7
SWEP.Primary.Damage			= 10
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.03
SWEP.Primary.ClipSize		= 25
SWEP.Primary.Delay			= 0.09
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 		= Vector (2.1301, 0.6352, 0.5666)
SWEP.IronSightsAng 		= Vector (0, 0, 0)
SWEP.NormalPos 			= Vector (-2.7133, 0.1164, 1.9471)
SWEP.NormalAng 			= Vector (-23.2661, -11.0075, 2.3854)

SWEP.MaxPenetration = PENETRATION_SMG;

SWEP.GrantExperience_Skill 	= SKILL_SMG_MARK;
SWEP.GrantExperience_Exp	= 1;