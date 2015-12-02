
if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.BackHolster = true;
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Tactical UMP45"			
	SWEP.Author				= "Counter-Strike"

	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "x"
	
end

SWEP.HoldType			= "ar2";
SWEP.HoldTypeNorm		= "normal";

SWEP.Base				= "weapon_perp_base"
SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_big_ump45.mdl"
SWEP.WorldModel			= "models/weapons/w_big_ump45.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.AnimPrefix	 = "rpg"

SWEP.Primary.Sound			= Sound("Weapon_big45.Single")
SWEP.Primary.Recoil 		= 0.4
SWEP.Primary.Damage 		= 20
SWEP.Primary.NumShots 		= 1
SWEP.Primary.Cone 			= 0.017
SWEP.Primary.ClipSize 		= 25
SWEP.Primary.Delay 			= 0.07
SWEP.Primary.DefaultClip 	= 0
SWEP.Primary.Automatic 		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"


SWEP.IronSightsPos = Vector (2.8373, 0.4767, 1.1864)
SWEP.IronSightsAng = Vector (0.36, -0.0909, 0)
SWEP.NormalPos 			= Vector( 0, 0, 3 )
SWEP.NormalAng 			= Vector(  -20, 0, 0 );

SWEP.MaxPenetration = PENETRATION_RIFLE;

SWEP.GrantExperience_Skill 	= SKILL_RIFLE_MARK;
SWEP.GrantExperience_Exp	= 1;