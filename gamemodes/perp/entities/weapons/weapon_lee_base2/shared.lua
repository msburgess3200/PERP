
include( "ai_translations.lua" )
include("sh_anim.lua")

/*-----------------------------------------------------------
	
	this base is a remake of my very first base. 8D
	
-----------------------------------------------------------*/

if ( CLIENT ) then

	SWEP.PrintName			= "Base Test"			
	SWEP.Slot				= 2
	SWEP.SlotPos			= 2
	SWEP.IconLetter			= "a"

	killicon.AddFont( "weapon_lee_base2", "csKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )

end

if !ConVarExists("Lee_WeaponsSpeed") then
	CreateConVar("Lee_WeaponsSpeed", '1', FCVAR_NOTIFY)
end

if !ConVarExists("Lee_WeaponDamageMul") then
	CreateConVar("Lee_WeaponDamageMul", '1', FCVAR_NOTIFY)
end

if !ConVarExists("Lee_WeaponRecoilMul") then
	CreateConVar("Lee_WeaponRecoilMul", '1.4', FCVAR_NOTIFY)
end

if !ConVarExists("Lee_WeaponEDT") then
	CreateConVar("Lee_WeaponEDT", '1', FCVAR_NOTIFY)
end

if !ConVarExists("Lee_WeaponEDC") then
	CreateConVar("Lee_WeaponEDC", '3', FCVAR_NOTIFY)
end

if !ConVarExists("Lee_WeaponViewKick") then
	CreateConVar("Lee_WeaponViewKick", '1', FCVAR_NOTIFY)
end

if !ConVarExists("Lee_WeaponInfiniteAmmo") then
	CreateConVar("Lee_WeaponInfiniteAmmo", '0', FCVAR_NOTIFY)
end

if !ConVarExists("Lee_WeaponShakeMul") then
	CreateConVar("Lee_WeaponShakeMul", '5', FCVAR_NOTIFY)
end

if !ConVarExists("Lee_WeaponHitEffect") then
	CreateConVar("Lee_WeaponHitEffect", '0', FCVAR_NOTIFY)
end

if !ConVarExists("Lee_AttachViewModelToView") then
	CreateConVar("Lee_AttachViewModelToView", '0', FCVAR_NOTIFY)
end

if !ConVarExists("Lee_WeaponAutoReload") then
	CreateConVar("Lee_WeaponAutoReload", '0', FCVAR_NOTIFY)
end

SWEP.HoldType 		= "pistol"

SWEP.Author			= "Bigcheezit210 (Corrie Pruiett)"
SWEP.Contact		= "http://steamcommunity.com/id/Bigcheezit210/"
SWEP.Purpose		= "Killing Herp Derp"
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 62
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_pistol.mdl"
SWEP.WorldModel		= "models/weapons/w_357.mdl"
SWEP.AnimPrefix		= "python"

SWEP.HoldType		= "pistol"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound			= Sound( "Weapon_AK47.Single" )
SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay			= 0.15
SWEP.Primary.Mode			= "semi"
SWEP.Primary.Ammo			= "pistol"
SWEP.Primary.BoltBack		= false
SWEP.Primary.PumpAction		= false
SWEP.Primary.SmokeTrail		= "muzzle_smoke_trail"
SWEP.WeaponType				= "pistol"
SWEP.AvailableFireMode    = {"semi"}

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.TracerRate = 1

SWEP.CanZoom = true
SWEP.Running = false
SWEP.Reloading = false
SWEP.CanShellEject = true
SWEP.ViewAnim = false -- my weapons anim speed is affected
SWEP.UseScope = false
SWEP.EjectSmoke = true
SWEP.MuzzleSmoke = true
SWEP.NearWall = false
SWEP.Silenced = false
SWEP.UseSilencer = true
SWEP.SilencerAnim = false
SWEP.DryFireAnim = false
SWEP.CanIdle = true
SWEP.FixIronShoot = false

SWEP.RecoverTime 		= 0.15
SWEP.MinRecoil			= 0
SWEP.MaxRecoil			= 1
SWEP.MinSpread			= 0
SWEP.MaxSpread			= 0.06

SWEP.SetHolsterTime 	= 0.35
SWEP.DeltaSpread		= 0.055
SWEP.DeltaRecoil		= 0.095
SWEP.IronSightTime      = 0.20
SWEP.RunSetTime         = 0.15
SWEP.IronSightZoom 		= 1.35

SWEP.ReloadTable = {}
SWEP.ReloadTable["RemoveClip"] = {}
SWEP.ReloadTable["RemoveClip"].Time = 0.75
SWEP.ReloadTable["RemoveClip"].EmptyTime = 0
SWEP.ReloadTable["RemoveClip"].Cylinder = false
SWEP.ReloadTable["SetClip"] = {}
SWEP.ReloadTable["SetClip"].Time = 1
SWEP.ReloadTable["SetClip"].EmptyTime = 0

SWEP.ScopeForce         = 3

SWEP.MuzzleEffect 			= "muzzle_lee_pistol"
SWEP.MuzzleAttachment		= "1"

SWEP.ShellEject         = nil

SWEP.EjectAttachment 	= "2"
SWEP.EjectTime 			= 0.01

SWEP.SmokeMuzzleAttachment		= "1" -- why not using SWEP.MuzzleEffect, idk 8D
SWEP.SmokeEjectAttachment		= "2"

SWEP.Burst = {} -- best burst evar 8D
SWEP.Burst.Enable = false
SWEP.Burst.NumShots = 3
SWEP.Burst.NextShotDelay = 0.05
SWEP.Burst.NextBurst = 1

SWEP.ViewAnimAngleFix = Angle(0,0,0)

SWEP.IronSightsPos = Vector (-3.7296, -2.1808, 2.4182)
SWEP.IronSightsAng = Vector (0.2948, 0.045, 0)

SWEP.HolsterPos = Vector (-3.7763, 0, 2.0671)
SWEP.HolstersAng = Vector (-42.3517, -47.3228, 0)

SWEP.NewOriginPos 		= Vector (2.9742, 0, 0.5123)
SWEP.NewOriginAng		= Vector (0, 0, 0)

SWEP.PistolNearWallPos = Vector (-0.6027, -11.384, -6.2741)
SWEP.PistolNearWallAng = Vector (67.6324, 4.9439, -3.6316)

SWEP.NearWallPos = Vector (-1.0416, -11.4198, -2.2259)
SWEP.NearWallAng = Vector (40.6435, -56.4456, -17.6906)

SWEP.ShotgunNearWallPos = Vector (3.1884, -13.3188, -2.7605)
SWEP.ShotgunNearWallAng = Vector (59.4118, 1.7834, 9.1462)

SWEP.RunArmOffset = Vector (0.3801, -14.5637, -6.2134)
SWEP.RunArmAngle = Vector (47.6338, -3.0839, -0.4233)

function SWEP:Initialize()
	
	if SERVER and ValidEntity(self.Owner) and self.Owner:IsNPC() then
		self:SetWeaponHoldType( self.HoldType )
		self:SetNPCMinBurst(1)			
		self:SetNPCMaxBurst(3)
		self:SetNPCFireRate(1)	
		self.Weapon:SetCurrentWeaponProficiency( WEAPON_PROFICIENCY_VERY_GOOD )
	end
	
	if self.WeaponType == "pistol" then
		self.CanZoom = false
		self.UseScope = false
	elseif self.WeaponType == "smg" then
		self.CanZoom = true
		self.UseScope = false
	elseif self.WeaponType == "rifle" then
		self.CanZoom = true
		self.UseScope = false
	elseif self.WeaponType == "shotgun" then
		self.CanZoom = true
		self.HoldType = "shotgun"
		self.UseScope = false
	elseif self.WeaponType == "sniper" then
		self.CanZoom = true
		self.UseScope = true
	elseif self.WeaponType == "winchester" then
		self.CanZoom = true
		self.UseScope = false
	elseif self.WeaponType == "aa12" then
		self.CanZoom = true
		self.UseScope = false	
	end
	
	self:SetUpFiremode()
	self:SetupDataTables()
	self:ResetVar()
	
end

function SWEP:ResetVar()
	
	self.Weapon:SetDTBool(0, false)
	self.Weapon:SetDTBool(3, false)
	self.Weapon:SetDTBool(2, false)
	
	self:SetIronsights( false )
	self:DoViewAnim(0, false)
	self.Weapon:SetNWBool("DoReloadBlur", false) 
	
	self.Weapon:SetDTFloat(0, 0)
	
	self.Reloading = false
	self.DontNearWall = false
	self.NearWall = false
	self.ShotGunReloading = false
	self.LastSilBool = false
	self.HolsterAnim = false
	
	self.ActionDelay = CurTime()
	self.NextMod = CurTime()
	self.NextHolster = CurTime()
	self.ReloadTimer = CurTime()
	
	self.IronFiremode = nil
	self.SpreadModifyTime = nil
	self.RemoveClipDelay = nil
	self.SetClipDelay = nil
	self.ShellEjectTime = nil
	self.MuzzleTime = nil
	self.BurstTime = nil
	self.NextBurstShot = nil
	self.MuzzleSmokeTrailTime = nil
	self.EjectSmokeTrailTime = nil
	self.ViewModelCenterFix = nil
	self.RecoverSpreadTime = nil
	self.RecoverRecoilTime = nil
	self.DropMagTime = nil
	self.ScopeTime = nil
	self.ReAimTime = nil
	
	self.CurrentSpread = 0
	self.CurrentRecoil = 0
	self.BurstCounter = 0
	self.AddSpread = 0
	self.AddRecoil = 0
	self.DropingAmmo = 0
	
end

function SWEP:SetupDataTables()

	self.Weapon:DTVar("Bool", 0, "Holstered")
	self.Weapon:DTVar("Bool", 1, "Ironsights")
	self.Weapon:DTVar("Bool", 2, "Lee_Scope")
	self.Weapon:DTVar("Bool", 3, "Reloading")
	
	self.Weapon:DTVar("Float", 0, "CurrentSpread")
	
end

function SWEP:DoViewAnim(Time, Bool)
	
	if SERVER then
		umsg.Start( "SendViewAnim" )
			umsg.Float( Time )
			umsg.Bool( Bool )
		umsg.End( )
	end	

end

function SWEP:GetTimeDivider() -- make your weapon on cocaine
	
	if !self.Owner:GetNWBool("Extention_Adrenaline") then
		TimeDivider = (GetConVarNumber("Lee_WeaponsSpeed") or 1)
	elseif self.Owner:GetNWBool("Extention_Adrenaline") then
		TimeDivider = 1.5
	end
	
	return TimeDivider
end

function SWEP:SetUpFiremode() -- initialize the fire mode
	if self.Primary.Mode and self.Primary.Mode == "semi" then
		self.Primary.Automatic = false
	elseif self.Primary.Mode and self.Primary.Mode == "auto" then
		self.Primary.Automatic = true
	elseif self.Primary.Mode and self.Primary.Mode == "burst" then	
		self.Primary.Automatic = false
	elseif !self.Primary.Mode then
		self.Primary.Automatic = false
	end
end

function SWEP:Precache()
end

function SWEP:PrimaryAttack()
	
	local vm = self.Owner:GetViewModel()
	
	if self.ShotGunReloading then
		self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		self.Weapon:SetNWBool("DoReloadBlur", false) 
		self.AnimDuration = vm:SequenceDuration() / self:GetTimeDivider()
		vm:SetPlaybackRate ( self:GetTimeDivider() )
		self:DoViewAnim(self.AnimDuration, false)
		self.ShotGunReloading = false
		self.Reloading = false
		
		self:EmitMovementSound()
		
		self.Weapon:SetDTBool(3, false)
		
		self.ActionDelay = CurTime() + self.AnimDuration
		self.ViewModelCenterFix = CurTime() + self.AnimDuration
		self.Weapon:SetNextPrimaryFire(CurTime() + self.AnimDuration)
		self.Weapon:SetNextSecondaryFire(CurTime() + self.AnimDuration)
		if self.Primary.Automatic != true then
			timer.Simple(self.PumpTime / self:GetTimeDivider(), function()
				if self.PumpPunch then
					self.Owner:ViewPunch(Angle(self.PumpPunch[1],self.PumpPunch[2],self.PumpPunch[3]))
				end
			end, self.Weapon)
		end
		if ( (SERVER) || (CLIENT )) then
			self.Weapon:SetNetworkedFloat( "CrossHairGap", CurTime() )
		end
	else
		if self.Owner:KeyDown(IN_USE) then
			local SetHolster = !self:GetHolster()
			self:SetHolster( SetHolster )
			if !self:GetIronsights() and !self.Running then
				self:EmitMovementSound()
			end
		else
			if ( !self:CanPrimaryAttack() ) then return end
			if !self.Burst.Enable then
				self:AttackCode()
			else	
				self.BurstCounter = self.Burst.NumShots
				self:AttackCode()
				self.BurstTime = CurTime() + (self.Primary.Delay * self.BurstCounter)
				self.NextBurstShot = CurTime() + self.Primary.Delay
			end
		end	
	end	

end

function SWEP:IsShotAffect() -- allow you weapon to being on COCAINE 8D
	if self.WeaponType == "shotgun" and self.Primary.PumpAction	or self.WeaponType == "sniper" and self.Primary.BoltBack then
		return true
	else
		return false
	end
end

function SWEP:AttackCode()
	
	local CurrentDamage = self.Primary.Damage
	local vm = self.Owner:GetViewModel()
	
	if !self:GetSilencer() then
		self.Weapon:EmitSound( self.Primary.Sound )
	else	
		self.Weapon:EmitSound( self.Primary.Silenced )
	end	
	CurrentDamage = CurrentDamage * GetConVarNumber("Lee_WeaponDamageMul")
	self:ShootBullet( CurrentDamage, self.Primary.NumShots, self.CurrentSpread, self.CurrentRecoil )
	
	if self:IsShotAffect() then
		self.Weapon:SetNextPrimaryFire( CurTime() + (self.Primary.Delay / self:GetTimeDivider()) )
		self.Weapon:SetNextSecondaryFire( CurTime() + (self.Primary.Delay / self:GetTimeDivider()) )
		self.ActionDelay = CurTime() + (self.Primary.Delay  / self:GetTimeDivider())
	else
		self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self.Weapon:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
		self.ActionDelay = CurTime() + self.Primary.Delay
	end

	self:TakePrimaryAmmo( 1 )
	
	if ( self.Owner:IsNPC() ) then return end
	
	if SERVER then
		if self.FixIronShoot and self:GetIronsights() then
			umsg.Start("SendIronShootFix", self.Owner)
			umsg.End()
		end
	end
	
	if ( (SERVER) || (CLIENT) ) then
		self.AddRecoil = self.AddRecoil + self.DeltaRecoil
		self.RecoverRecoilTime = CurTime() + self.RecoverTime
		
		self.Weapon:SetNetworkedFloat( "LastShootTime", CurTime() )
	end
	
end

function SWEP:GetIronsights()
	return self.Weapon:GetDTBool( 1 )
end

function SWEP:EmitMovementSound()
	self.Weapon:EmitSound(Sound("Weapon_GenericFoley"))
end

function SWEP:SetIronsights( b, CanSound )

	if self.Owner and self.Weapon then
		if (b) then	
			if self.UseScope == true then
				self.ScopeTime = CurTime() + self.IronSightTime 
				self.NextReload = CurTime() + self.IronSightTime
			end	
			if self.ActionDelay and self.ActionDelay <= CurTime() then
				self.ViewModelCenterFix = CurTime()
			end
		else
			
			if self:GetScope() then
				self:SetScope(false, self.Owner)
			end	
			
		end
	end

	if CanSound then
		self:EmitMovementSound()
	end
	
	if SERVER then
		if ValidEntity(self.Owner) then
			umsg.Start("CallIronTilt", self.Owner)
				umsg.Float(self.IronSightTime)
			umsg.End()
		end
	end	
	
	self.LastIron = self:GetIronsights()
	self.Weapon:SetDTBool(1, b)

end

function SWEP:SetHolster( b )
	
	if self.NextHolster and self.NextHolster <= CurTime() then
		self.Weapon:SetDTBool(0, b)
		local Time = self.SetHolsterTime - 0.05
		self.NextHolster = CurTime() + Time
		self.Weapon:SetNextPrimaryFire(CurTime() + Time)
	end	

end

function SWEP:GetHolster()
	return self.Weapon:GetDTBool( 0 )
end

function SWEP:SetFireMode(mode, cansound, cantext)
	if !self.NextMod or self.NextMod > CurTime() or !IsFirstTimePredicted() or OneTime then return end
	
	local Text = ""
	OneTime = true
	self:SetIronsights(false, true)
	self:SetHolster( true )
	
	self:EmitMovementSound()
	
	if mode == "semi" then
		self.Primary.Automatic = false
		self.Primary.Mode = "semi"
		self.Burst.Enable = false
		if cansound then
			self.Owner:EmitSound("firemode/firemode_semi.wav", 80)
		end	
		Text = "Firemode switched to semi automatic."
	elseif mode == "auto" then
		self.Primary.Automatic = true
		self.Primary.Mode = "auto"
		self.Burst.Enable = false
		if cansound then
			self.Owner:EmitSound("firemode/firemode_auto.wav", 80)
		end	
		Text = "Firemode switched to automatic."
	elseif mode == "burst" then
		self.Primary.Automatic = false
		self.Primary.Mode = "burst"
		self.Burst.Enable = true
		if cansound then
			self.Owner:EmitSound("firemode/firemode_burst.wav", 80)
		end
		Text = "Firemode switched to burst shots."
	end
	if ValidEntity(self.Owner) and ValidEntity(self.Weapon) and self.Owner:GetActiveWeapon() == self.Weapon and Text != "" and cantext then
		self.Owner:ChatPrint(Text)
	end	
	self.NextMod = CurTime() + 0.5
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.8)
	
	self.IronFiremode = CurTime() + self.IronSightTime

	OneTime = false
	return
end

SWEP.NextSecondaryAttack = 0

function SWEP:SecondaryAttack()
	if not IsFirstTimePredicted() then return end
	if self.Owner and !self.Owner:KeyDown(IN_USE) then
	
		if !self.IronSightsPos or self.Weapon:GetDTBool(3) or self.ShotGunReloading or self.NearWall then return end
		if self.NextSecondaryAttack > CurTime() then return end
	
		bIronsights = !self:GetIronsights()
		self:SetIronsights( bIronsights, true )
		self.NextSecondaryAttack = CurTime() + 0.3
		
	elseif self.Owner and self.Owner:KeyDown(IN_USE) then
		self:DoMode()
	end
	
end

function SWEP:DoMode()
	if !table.HasValue(self.AvailableFireMode, "burst") and table.HasValue(self.AvailableFireMode, "auto") and self.Primary.Mode == "semi" then
		self:SetFireMode("auto", true, true)
	elseif !table.HasValue(self.AvailableFireMode, "burst") and table.HasValue(self.AvailableFireMode, "semi") and self.Primary.Mode == "auto" then
		self:SetFireMode("semi", true, true)
	elseif table.HasValue(self.AvailableFireMode, "burst") and !table.HasValue(self.AvailableFireMode, "semi") and self.Primary.Mode == "auto" then
		self:SetFireMode("burst", true, true)
	elseif table.HasValue(self.AvailableFireMode, "auto") and !table.HasValue(self.AvailableFireMode, "semi") and self.Primary.Mode == "burst" then
		self:SetFireMode("auto", true, true)
	elseif table.HasValue(self.AvailableFireMode, "burst") and !table.HasValue(self.AvailableFireMode, "auto") and self.Primary.Mode == "semi" then	
		self:SetFireMode("burst", true, true)
	elseif table.HasValue(self.AvailableFireMode, "semi") and !table.HasValue(self.AvailableFireMode, "auto") and self.Primary.Mode == "burst" then	
		self:SetFireMode("semi", true, true)	
	elseif table.HasValue(self.AvailableFireMode, "semi") and table.HasValue(self.AvailableFireMode, "auto") and table.HasValue(self.AvailableFireMode, "burst") and self.Primary.Mode == "semi" then	
		self:SetFireMode("auto", true, true)
	elseif table.HasValue(self.AvailableFireMode, "semi") and table.HasValue(self.AvailableFireMode, "auto") and table.HasValue(self.AvailableFireMode, "burst") and self.Primary.Mode == "auto" then	
		self:SetFireMode("burst", true, true)	
	elseif table.HasValue(self.AvailableFireMode, "semi") and table.HasValue(self.AvailableFireMode, "auto") and table.HasValue(self.AvailableFireMode, "burst") and self.Primary.Mode == "burst" then	
		self:SetFireMode("semi", true, true)		
	end	
end

function SWEP:CheckReload()
	
end

function SWEP:Reload()

	if self.Owner:IsPlayer() then
		local vm = self.Owner:GetViewModel()
		if !self.Owner:KeyDown(IN_USE) then
			if self.WeaponType != "shotgun" and self.WeaponType != "winchester" then
				if self.ActionDelay and self.ActionDelay <= CurTime() and ( self.Weapon:Clip1() < self.Primary.ClipSize ) and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
					if self.Silenced and self.SilencerAnim then
						self:CustomReload(ACT_VM_RELOAD_SILENCED)
					else
						if self.ReloadTable["CanEmptyReload"] then
							if self.Weapon:Clip1() > 0 then
								self:CustomReload(ACT_VM_RELOAD)
							else
								self:CustomReload(ACT_VM_RELOAD_EMPTY)
							end
						else
							self:CustomReload(ACT_VM_RELOAD)
						end
					end	
				end
			else	
				if self.ActionDelay and self.ActionDelay <= CurTime() and (self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
					if self.Owner:KeyPressed(IN_RELOAD) and !self.ShotGunReloading then
						self.ViewModelCenterFix = nil
						self.ShotGunReloading = true
						vm:SetSequence("reload_start")
						self.Weapon:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
						vm:SetPlaybackRate ( self:GetTimeDivider() )
						self.Weapon:SetNWBool("DoReloadBlur", true) 
						self.Weapon:SetDTBool(3, true)
						self.AnimDuration = vm:SequenceDuration() / self:GetTimeDivider()
						self:DoViewAnim(0, true)
						self.ActionDelay = CurTime() + self.AnimDuration
						self.ReloadTimer = CurTime() + self.AnimDuration
						self.Weapon:SetNextPrimaryFire(CurTime() + self.AnimDuration)
						self:SetIronsights(false, true)
						if ( (SERVER) || (CLIENT) ) then
							self.Weapon:SetNetworkedFloat( "LastShootTime", CurTime() )
						end
					end
				end
				if self.ShotGunReloading and self.ReloadTimer < CurTime() and self.ActionDelay and self.ActionDelay <= CurTime() and self.Owner:KeyPressed(IN_RELOAD) then
					if (self.Weapon:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) then
						vm:SetPlaybackRate ( self:GetTimeDivider() )
						self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
						vm:SetPlaybackRate ( self:GetTimeDivider() )
						self.AnimDuration = vm:SequenceDuration() / self:GetTimeDivider()
						self:EmitMovementSound()
						if self.AddShellPunch then
							self.Owner:ViewPunch(Angle(self.AddShellPunch[1],self.AddShellPunch[2],self.AddShellPunch[3]))
						end
						self.Weapon:SetNetworkedInt( "reloadtimer", CurTime() + self.AnimDuration - 0.1)
						self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
						self.Owner:SetAnimation (PLAYER_RELOAD)
						self.ActionDelay = CurTime() + self.AnimDuration
						self.Weapon:SetClip1(  self.Weapon:Clip1() + 1 )
						self.Weapon:SetNextPrimaryFire(CurTime() + self.AnimDuration)
						self.Weapon:SetNextSecondaryFire(CurTime() + self.AnimDuration)
						if ( (SERVER) || (CLIENT) ) then
							self.Weapon:SetNetworkedFloat( "LastShootTime", CurTime() )
						end
					end
				end
			end
		elseif self.Owner:KeyDown(IN_USE) and self.UseSilencer then
			if !self.ActionDelay or self.ActionDelay > CurTime() then return end
			if self.SilencerAnim then
				if !self.Silenced then
					self.Weapon:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
					self.Silenced = true
				else	
					self.Weapon:SendWeaponAnim(ACT_VM_DETACH_SILENCER)
					self.Silenced = false
				end
				if SERVER then
					umsg.Start("ClSendSilencer", self.Owner)
						umsg.Bool(self.Silenced)
					umsg.End()
				end
				self:SetIronsights(false, true)
				
				self.AnimDuration = vm:SequenceDuration() / self:GetTimeDivider()
				vm:SetPlaybackRate(self:GetTimeDivider())
				self.ActionDelay = CurTime() + self.AnimDuration
				self.ViewModelCenterFix = CurTime() + self.AnimDuration
				self.Weapon:SetNextPrimaryFire(CurTime() + self.AnimDuration)
				self.Weapon:SetNextSecondaryFire(CurTime() + self.AnimDuration)
				
				self:DoViewAnim(self.AnimDuration)
			end
		end
	else
		self.Weapon:DefaultReload( ACT_VM_RELOAD );
	end
	
end

function SWEP:GetSilencer()

    return self.Silenced
	
end

function SWEP:CustomReload(anim) -- i hate the DefaultReload

    if !anim then return end
	
	local Vm = self.Owner:GetViewModel()
	self.Owner:SetAnimation (PLAYER_RELOAD)
	
	self.Weapon:SendWeaponAnim(anim or "")
	
	self.AnimDuration = Vm:SequenceDuration()
	self:SetIronsights(false, true)
	self.Reloading	= true
	self:EmitMovementSound()
	
	self.Weapon:SetDTBool(3, true)
	
	self.EmptyReload = false
	self.Weapon:SetNWBool("DoReloadBlur", true) 
	Vm:SetPlaybackRate ( self:GetTimeDivider() )
	local ReloadSpeed = self.AnimDuration / self:GetTimeDivider()
	local SetClipvalue = math.Clamp( self.Owner:GetAmmoCount(self.Primary.Ammo), 0, self.Primary.ClipSize )
	
	if self.ReloadTable then
		local EmptyRemoveClipTime = self.ReloadTable["RemoveClip"].EmptyTime
		local EmptySetClipTime = self.ReloadTable["SetClip"].EmptyTime
		
		local HaveCylinder = self.ReloadTable["RemoveClip"].Cylinder
		
		local RemoveClipTime = self.ReloadTable["RemoveClip"].Time
		local SetClipTime = self.ReloadTable["SetClip"].Time
		
		if self.ReloadTable["CanEmptyReload"] and self.Weapon:Clip1() <= 0 and EmptyRemoveClipTime and EmptySetClipTime and EmptyRemoveClipTime > 0 and EmptySetClipTime > 0 and !HaveCylinder then
			self.RemoveClipDelay = CurTime() + (EmptyRemoveClipTime / self:GetTimeDivider())
			self.SetClipDelay = CurTime() + (EmptySetClipTime / self:GetTimeDivider())
			self.Weapon:SetNextSecondaryFire( CurTime() + ReloadSpeed )
			self.Weapon:SetNextPrimaryFire( CurTime() + ReloadSpeed )	
			self:DoViewAnim(ReloadSpeed)
			self.ActionDelay = CurTime() + ReloadSpeed
			self.NextSecondaryAttack = CurTime() + ReloadSpeed
			self.FinishReloadTime = CurTime() + ReloadSpeed
			self.ReloadBlurTime = CurTime() + ReloadSpeed - 0.35
		else
			self.RemoveClipDelay = CurTime() + (RemoveClipTime / self:GetTimeDivider())
			self.SetClipDelay = CurTime() + (SetClipTime / self:GetTimeDivider())
			self.Weapon:SetNextSecondaryFire( CurTime() + ReloadSpeed )
			self.Weapon:SetNextPrimaryFire( CurTime() + ReloadSpeed )	
			self:DoViewAnim(ReloadSpeed)
			self.ActionDelay = CurTime() + ReloadSpeed
			self.NextSecondaryAttack = CurTime() + ReloadSpeed
			self.FinishReloadTime = CurTime() + ReloadSpeed
			self.ReloadBlurTime = CurTime() + ReloadSpeed - 0.35
		end	
	else
		timer.Simple( ReloadSpeed, function() --shitty reload
			self.FinishReloadTime = CurTime()
			self.Weapon:SetClip1( SetClipvalue )
			self.Owner:RemoveAmmo( SetClipvalue, self.Primary.Ammo, false )
		end, self.Weapon)	
	end
	
	self.ViewModelCenterFix = nil
	
end

function SWEP:ReloadEffect()	
	
    if !self.Weapon:GetDTBool(3) then return end
	
	if self.DropMagTime and self.DropMagTime <= CurTime() then
		self.DropMagTime = nil
		local MagPos = self.Owner:GetShootPos()
		MagPos = MagPos + self.Owner:GetUp() * -15
		MagPos = MagPos + self.Owner:GetRight() * 4
		if SERVER then
		local Mag = ents.Create("Mag")
			Mag:SetModel( self.MagModel or "models/weapons/unloaded/pist_glock18_mag.mdl")				
			Mag:SetPos( MagPos )
			Mag:SetAngles(self.Owner:EyeAngles())
			Mag:Spawn()
			Mag:Activate()
			Mag:SetCollisionGroup(COLLISION_GROUP_WEAPON)
			SafeRemoveEntityDelayed( Mag, 15 )

			Mag.AmmoType = self.Weapon:GetPrimaryAmmoType()
			Mag.AmmoCount = self.DropingAmmo
			self.DropingAmmo = 0
			local phys = Mag:GetPhysicsObject()
			if phys:IsValid() then
				phys:SetVelocity( self.Owner:GetVelocity() + self.Owner:GetUp() * -100)
			end
		end
	end
	
    if self.RemoveClipDelay and CurTime() >= self.RemoveClipDelay then
		self.RemoveClipDelay = nil
		
		local RemoveClipTime = self.ReloadTable["RemoveClip"].Time
		local HaveCylinder = self.ReloadTable["RemoveClip"].Cylinder
		
		if !HaveCylinder then
			self.DropingAmmo = self.Weapon:Clip1()
			self.DropMagTime = CurTime() + 0.1
		end
		if self.Weapon:Clip1() > 0 then
			if !HaveCylinder then
				self.Weapon:SetClip1( 1 )
			else
				self.Weapon:SetClip1( 0 )
			end	
		else
			self.Weapon:SetClip1( 0 )
		end
	
		if ( self.Owner:IsNPC() ) then return end
		if ( (SERVER) || (CLIENT) ) then
			self.Weapon:SetNetworkedFloat( "CrossHairGap", CurTime() )
		end
		
    end

    if self.SetClipDelay and CurTime() >= self.SetClipDelay then
		self.SetClipDelay = nil
		local SetClipvalue = math.Clamp( self.Owner:GetAmmoCount(self.Primary.Ammo) , 0 , self.Primary.ClipSize )
		if self.Weapon:Clip1() < 1 then
			self.Weapon:SetClip1( SetClipvalue )
		else
			self.Weapon:SetClip1( SetClipvalue + 1 )
		end
		
		if GetConVarNumber("Lee_WeaponInfiniteAmmo") <= 0 then
			self.Owner:RemoveAmmo( SetClipvalue, self.Primary.Ammo, false )
		end
		
		if self.EmptyReload == true then
			self.EmptyReload = false
		end
		
		if ( self.Owner:IsNPC() ) then return end
		if ( (SERVER) || (CLIENT) ) then

			self.Weapon:SetNetworkedFloat( "CrossHairGap", CurTime() )
		end
    end
	
	if self.ReloadBlurTime and self.ReloadBlurTime <= CurTime() then
		self.ReloadBlurTime = nil
		self.Weapon:SetNWBool("DoReloadBlur", false) 
	end
	
	if self.FinishReloadTime and self.FinishReloadTime <= CurTime() then
		self.FinishReloadTime = nil
		self.Reloading = false
		self.Weapon:SetDTBool(3, false)
		
		if ValidEntity(self.Weapon) and ValidEntity(self.Owner) and self.Owner and self.Owner:Health() > 0 and self.Owner:KeyDown(IN_ATTACK2) and !self.Owner:KeyDown(IN_SPEED) then
			self:SetIronsights(true, true)
		end
	end
	
end

function SWEP:AltThink()
	
end

function SWEP:CalcWeaponVar()
	
	self.CurrentSpread = self.Primary.Cone
	self.CurrentRecoil = self.Primary.Recoil
	
	if self.Owner:IsPlayer() then
		
		local vel = self.Owner:GetVelocity()
		local vellen = vel:Length()
		
		if self.WeaponType != "shotgun" then
			
			if self.RecoverRecoilTime and self.RecoverRecoilTime < CurTime() and self.AddRecoil != 0 then
				local Dist = self.AddRecoil - 0
				local ARValue = self.AddRecoil - FrameTime() * (Dist * 10)
				self.AddRecoil = math.Clamp(ARValue, 0, ARValue)
			end
			
			if self.Owner:OnGround() and self.Owner:KeyDown(IN_DUCK) then
				self.CurrentSpread = self.CurrentSpread / 1.5
				self.CurrentRecoil = self.CurrentRecoil / 1.5
				self.AddSpread = self.AddSpread / 1.2
				self.AddRecoil = self.AddRecoil / 1.1
			end
			
			if !self.Owner:OnGround() then
				self.CurrentSpread = self.CurrentSpread * 2
				self.CurrentRecoil = self.CurrentRecoil * 2
				self.AddSpread = self.AddSpread * 1.5
				self.AddRecoil = self.AddRecoil * 1.1
			end
			
			if self:GetIronsights() then
				self.CurrentSpread = self.CurrentSpread / 1.5
				self.AddSpread = self.AddSpread / 1.2
				if self.WeaponType == "sniper" and !self.Primary.Boltback then
					self.CurrentRecoil = self.CurrentRecoil / 3
					self.AddRecoil = self.AddRecoil / 1.5
				else
					self.CurrentRecoil = self.CurrentRecoil / 1.5
				end
			end
			
			self.AddRecoil = math.Clamp(self.AddRecoil,0,self.CurrentRecoil * 2)
			
			self.CurrentSpread = self.CurrentSpread + self.AddSpread
			self.CurrentRecoil = self.CurrentRecoil + self.AddRecoil
			
			self.CurrentSpread = math.Clamp(self.CurrentSpread + (vellen / 16000), self.MinSpread, self.MaxSpread)
			self.CurrentRecoil = self.CurrentRecoil + (vellen / 1200)
			
			self.Weapon:SetDTFloat(0, self.CurrentRecoil)
		end
		
    end
	
end

/*---------------------------------------------------------
   Name: SWEP:Think( )
   Desc: Called every frame
---------------------------------------------------------*/
function SWEP:Think()
	
	if !self.Running and !self.Owner:KeyDown(IN_DUCK) and self.Owner:KeyDown(IN_SPEED) and self.Owner:GetVelocity():Length() > self.Owner:GetWalkSpeed() and !self:GetIronsights() and !self:GetHolster() and self.Owner:IsOnGround() then
	    self.Running = true
        self:SetIronsights(false, true)
	elseif self.Running and (!self.Owner:KeyDown(IN_SPEED) or self.Owner:KeyDown(IN_DUCK)) then
	   	self.Running = false
		if !self.Weapon:GetDTBool(3) then
			self.Weapon:SetNextPrimaryFire( CurTime() + 0.15 )
		end
		self:EmitMovementSound()
	elseif self.Running and self:GetIronsights() or self.Running and self.Owner:GetVelocity():Length() <= self.Owner:GetWalkSpeed() or self.Running and self.Owner:KeyDown(IN_SPEED) and !self.Owner:KeyDown(IN_FORWARD) and !self.Owner:KeyDown(IN_BACK) and !self.Owner:KeyDown(IN_MOVELEFT) and !self.Owner:KeyDown(IN_MOVERIGHT) or self.Running and !self.Owner:IsOnGround() or self.Running and self.Owner:KeyDown(IN_DUCK) then
	    self.Running = false
		if !self.Weapon:GetDTBool(3) then
			self.Weapon:SetNextPrimaryFire( CurTime() + 0.15 )
		end
		self:EmitMovementSound()
	end
	
	local Tr = self.Owner:GetEyeTrace()
	
	if Tr.Entity:IsValid() and Tr.Entity:IsNPC() or Tr.Entity:IsPlayer() then
		self.DontNearWall = true
	elseif Tr.Entity:IsValid() then
		self.DontNearWall = false
	end
	
	if Tr.Hit and Tr.HitPos:Distance(self.Owner:GetShootPos()) < 40 and !self.NearWall and self.SetSilencerTime == nil and !self.DontNearWall then
		self.NearWall = true
		if !self.Running and !self:GetHolster() then
			self:SetIronsights(false, true)
		else
			self:SetIronsights(false, false)
		end
	elseif Tr.HitPos:Distance(self.Owner:GetShootPos()) > 40 and self.NearWall or self.SetSilencerTime and self.SetSilencerTime >= CurTime() or self.NearWall and self.DontNearWall then
		self.NearWall = false
		if !self:GetHolster() then
			self:EmitMovementSound()
		end
		if !self.Weapon:GetDTBool(3) then
			self.Weapon:SetNextPrimaryFire(CurTime() + 0.15)
			self.Weapon:SetNextSecondaryFire(CurTime() + 0.15)
		end
		if self.LastIron and !self.DontNearWall then
			self:SetIronsights(true, true)
		end
	end
	
	if self.IronFiremode and self.IronFiremode <= CurTime() then
		self.IronFiremode = nil
		self.Weapon:SetDTBool( 0, false )
		if self.LastIron then
			self:SetIronsights(true, true)
		end
	end
	
	if self.BurstTime and self.BurstTime > CurTime() then
		if self.NextBurstShot and self.NextBurstShot <= CurTime() and self:CanPrimaryAttack() and self.Owner and self.Owner:KeyDown(IN_ATTACK) then
			self.NextBurstShot = CurTime() + self.Primary.Delay
			self.BurstCounter = self.BurstCounter - 1
			self.Weapon:SetNextPrimaryFire(CurTime() + self.Burst.NextBurst)
			self:AttackCode()
		end
	end
	
	if self.MuzzleSmokeTrailTime and self.MuzzleSmokeTrailTime <= CurTime() then
		self.MuzzleSmokeTrailTime = nil
		self:MuzzleSmokeTrailEffect()
	end	
	
	if self.EjectSmokeTrailTime and self.EjectSmokeTrailTime <= CurTime() then
		self.EjectSmokeTrailTime = nil
		self:EjectSmokeTrailEffect()
	end
	
	if self.Running or self:GetHolster() and !self:GetIronsights() or self.NearWall and !self:GetIronsights() then
		if self.WeaponType != "pistol" and !self.Owner:Crouching() then
			self:SetWeaponHoldType("passive")
		else
			self:SetWeaponHoldType("normal")
		end
		self.MeleeAttack = false
		self.MeleeAttackTime = nil
	else
		if self.WeaponType != "pistol" and self:GetIronsights() then
			self:SetWeaponHoldType("rpg")
		else
			self:SetWeaponHoldType(self.HoldType)
		end
	end
	
	if self.ViewModelCenterFix and self.ViewModelCenterFix <= CurTime() and self.CanIdle then
		self.ViewModelCenterFix = nil
		if self.WeaponType == "pistol" then
			if self.Weapon:Clip1() > 0 then
				if self.Silenced and self.SilencerAnim then
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
				else
					self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
				end
			elseif self.Weapon:Clip1() <= 0 and self.DryFireAnim then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE_EMPTY)
			end
		else
			if self.Silenced and self.SilencerAnim then
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
			else
				self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
			end
		end
		
		if self.Weapon:Clip1() > 0 then
			self.Owner:GetViewModel():SetPlaybackRate(0)
		end
		
	end
	
	self:AltThink()
	self:CalcWeaponVar()
	self:ReloadEffect()	
	self:SniperEffect()
	self:WeaponEffects()
end

function SWEP:WeaponEffects()
	if self.ShellEjectTime and self.ShellEjectTime <= CurTime() then
		self.ShellEjectTime = nil
		if !self.Owner then return end
		if !IsFirstTimePredicted() then return end
		if self.ShellEject != nil and self.CanShellEject then
			if CLIENT then
				if GetViewEntity() == self.Owner then
					if SERVER then
						umsg.Start("CallShellEject", self.Owner)
						umsg.End()
					end	
				end	
			else
				if self.Owner:GetViewEntity() == self.Owner then
					if SERVER then
						umsg.Start("CallShellEject", self.Owner)
						umsg.End()
					end	
				end	
			end
		end
	end
end

function SWEP:SetScope(b, ply)

    if self.UseScope == false then return end
	
	if self.Owner and self.Owner:IsValid() then
		if b then
			self.Owner:SetFOV(self.Owner:GetFOV()/self.ScopeForce, 0)
		else
			self.Owner:SetFOV(0, 0)
		end
	end
	
	self.Weapon:SetDTBool(2, b)
end

function SWEP:SniperEffect()
	
	if not CLIENT and self:GetScope() and self:GetIronsights() or self.Owner.Rolling and self.Owner.Rolling then
	    self.Owner:DrawViewModel(false)
	elseif not CLIENT then
	    self.Owner:DrawViewModel(true)
	end	
	
	if self.ScopeTime and self.ScopeTime <= CurTime() and !self:GetScope() and self:GetIronsights() then
		self.ScopeTime = nil
		self:SetScope(true, self.Owner)
	end	
	
	if self.ReAimTime and self.ReAimTime <= CurTime() and !self:GetScope() and !self:GetIronsights() then
		self.ReAimTime = nil
		if self.Owner and self.Owner:KeyDown(IN_ATTACK2) and self.Weapon:Clip1() > 0 then
			self:SetIronsights(true, true)
		end	
	end
end

function SWEP:GetScope()

    return self.Weapon:GetDTBool(2)
	
end

function SWEP:SetSilencer( b )
	
	self.Silenced = b
	
	if SERVER then
		if self.LastSilBool != b then
			self.LastSilBool = b
			umsg.Start("ClSendSilencer", self.Owner)
				umsg.Bool(b)
			umsg.End()
		end
	end	
	
end

/*---------------------------------------------------------
   Name: SWEP:Holster( weapon_to_swap_to )
   Desc: Weapon wants to holster
   RetV: Return true to allow the weapon to holster
---------------------------------------------------------*/
function SWEP:Holster( wep )
	self:ResetVar()
	return true
end

/*---------------------------------------------------------
Deploy
---------------------------------------------------------*/
function SWEP:Deploy()
	
	local vm = self.Owner:GetViewModel()
	
	self:ResetVar()
	
	if !self.Silenced then
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	elseif self.Silenced and self.SilencerAnim then
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
	end
	
	vm:SetPlaybackRate ( self:GetTimeDivider() )
	self.AnimDuration = vm:SequenceDuration() / self:GetTimeDivider()
	self.Weapon:SetNextPrimaryFire(CurTime() + self.AnimDuration)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.AnimDuration)
	
	self:DoViewAnim(self.AnimDuration)
	
	self.ActionDelay = CurTime() + self.AnimDuration
	
	if (SERVER) or (CLIENT) then
	    self.Owner:EmitSound(Sound("player/deploysound.wav"))
	end

	return true
	
end

function SWEP:ShootEffects()
	local vm = self.Owner:GetViewModel()
	local ShellEjectTime = self.EjectTime or 0.05
	
	if !self.FixIronShoot or !self:GetIronsights() then
		if self.Weapon:Clip1() == 1 and self.DryFireAnim then
			if self.Silenced and self.SilencerAnim then
				self.Weapon:SendWeaponAnim( ACT_VM_DRYFIRE_SILENCED )
			else
				self.Weapon:SendWeaponAnim( ACT_VM_DRYFIRE )
			end
			self.ViewModelCenterFix = nil
		else
			if self.Silenced and self.SilencerAnim then
				self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK_SILENCED )
			else
				self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
			end
			self.AnimDuration = vm:SequenceDuration() 
			self.ViewModelCenterFix = CurTime() + self.AnimDuration
		end
		
		if self:IsShotAffect() then
			self.ScopeTime = nil
			self.ReAimTime = nil
			vm:SetPlaybackRate ( self:GetTimeDivider() )
			self.AnimDuration = vm:SequenceDuration() / self:GetTimeDivider()
			self:DoViewAnim(self.AnimDuration)
			ShellEjectTime = ShellEjectTime / self:GetTimeDivider()
			if self:GetIronsights() and self.WeaponType == "sniper" and self.Primary.BoltBack then
				ShellEjectTime = ShellEjectTime + 0.2 --little fix when unscope shoot 8D
			end
			timer.Simple(0.2, function() -- i know its cheap but im lazy 8D
				self:SetIronsights( false )
				if self.Weapon:Clip1() > 0 then
					self.ReAimTime = CurTime() + self.AnimDuration
				end
			end, self)
		end
	end
	
	if self.WeaponType == "sniper" and self:GetIronsights() then
		if SERVER then
			umsg.Start("SendScopeAnim", self.Owner)
			umsg.End()
		end	
	end
	
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	self.ShellEjectTime = CurTime() + ShellEjectTime
	self.MuzzleTime = CurTime()
	
	if self.MuzzleEffect != nil then
		if ( self.Owner:IsNPC() ) then return end
		if self.Weapon then	
			if CLIENT then
				if GetViewEntity() == self.Owner then
					if not self.Owner then return end
					if not IsFirstTimePredicted() then return end
					if SERVER then
						umsg.Start("CallMuzzleEffect", self.Owner)
						umsg.End()
					end	
				end	
			else
				if self.Owner:GetViewEntity() == self.Owner then
					if not self.Owner then return end
					if not IsFirstTimePredicted() then return end
					if SERVER then
						umsg.Start("CallMuzzleEffect", self.Owner)
						umsg.End()
						if self.MuzzleSmoke then
							umsg.Start("CallSmokeTrailEffect", self.Owner)
								umsg.Float(0)
								umsg.String(self.SmokeMuzzleAttachment)
							umsg.End()
						end
						if self.EjectSmoke then
							umsg.Start("CallSmokeTrailEffect", self.Owner)
								umsg.Float(self.EjectDelay or 0.1)
								umsg.String(self.SmokeEjectAttachment)
							umsg.End()
						end
					end	
				end	
			end
		end
	end	
	
end

function SWEP:ShootBullet( damage, num_bullets, aimcone, recoil )
	
	local BulPos = self.Owner:GetShootPos()
	
	if !self:GetIronsights() then
		BulPos = BulPos + self.Owner:GetRight() * 4
		BulPos = BulPos + self.Owner:GetUp() * -5
		BulPos = BulPos + self.Owner:GetForward() * 30
	end	
	
	self.Owner:LagCompensation( false )
		local bullet = {}
		bullet.Num 		= num_bullets
		bullet.Src 		= BulPos
		bullet.Dir 		= ( self.Owner:GetAimVector():Angle() + self.Owner:GetPunchAngle() ):Forward()
		bullet.Spread 	= Vector( aimcone, aimcone, 0 )
		bullet.Tracer	= self.TracerRate	
		bullet.Force	= damage / 2								
		bullet.Damage	= damage
		bullet.AmmoType = "Pistol"
		if ValidEntity(self) then
			bullet.Callback  =  function ( attacker, tr, dmginfo )
				self:BulletCallback(  attacker, tr, dmginfo, 0 ) --thanks to night eagle for this usefull life of code
			end
		end	
		
		self.Owner:FireBullets( bullet )
		self:ShootEffects()
	
		if ( self.Owner:IsNPC() ) then return end
		self:CustomRecoil(recoil)
	self.Owner:LagCompensation( true )
end

function SWEP:BulletCallback( attacker, tr, dmginfo, bounce )

	if attacker:GetActiveWeapon() == nil then return end
	
    if tr.Entity:IsValid() and ( tr.Entity:IsNPC() || tr.Entity:IsPlayer() ) and SERVER then
		if tr.HitGroup == 1 then
			tr.Entity:EmitSound( Sound( "player/headshot1.wav" ), 100, math.random( 90, 120 ) ) 
		end
    end

    if self:BulletEffect( attacker, tr, dmginfo, bounce + 1) != nil then
	    self:BulletEffect( attacker, tr, dmginfo, bounce + 1)
	end
	
	if GetConVarNumber("Lee_WeaponEDT") <= 1 then
	
		self:ElementalImpact( "normal", tr, dmginfo )
		
	elseif GetConVarNumber("Lee_WeaponEDT") == 2 then
	
		self:ElementalImpact( "ignite", tr, dmginfo )
		
	elseif GetConVarNumber("Lee_WeaponEDT") == 3 then
	
		self:ElementalImpact( "explode", tr, dmginfo )
	
	elseif GetConVarNumber("Lee_WeaponEDT") == 4 then
	
		self:ElementalImpact( "acid", tr, dmginfo )	
		
	elseif GetConVarNumber("Lee_WeaponEDT") == 5 then
	
		self:ElementalImpact( "shock", tr, dmginfo )
	
	elseif GetConVarNumber("Lee_WeaponEDT") >= 6 then
	
		self:ElementalImpact( "dissovle", tr, dmginfo )
	
	end
	
	util.ScreenShake(tr.HitPos, dmginfo:GetDamage(), 50, 0.35, 60)
	
end

function SWEP:ElementalImpact( Type, tr, dmginfo )
	if SERVER then
		if !Type or !tr then return end
		local ChanceToElemental = GetConVarNumber("Lee_WeaponEDC")
		if Type == "ignite" then
			if math.random(1,ChanceToElemental) == 1 then
				if !tr.HitSky then
					local fx 	= EffectData()
					fx:SetStart(tr.HitPos)
					fx:SetOrigin(tr.HitPos)
					fx:SetNormal(tr.HitNormal)
					util.Effect("ignite_hit",fx)
				end			
		
				local en = ents.FindInSphere(tr.HitPos, 50)
				for k, v in pairs(en) do
					v:Ignite(math.random(5, 20), 0)
					v.FlameOwner = self.Owner
					v.FlameOwnerWeapon = self
					   if v:IsPlayer() then
						   v.FixFire = true
					   end
				end
		
			if math.random(1,ChanceToElemental) == 1 then
				if tr.HitWorld and !tr.HitSky then
					local fire = ents.Create("env_fire")
					fire:SetPos(tr.HitPos)
					fire:SetKeyValue("health", math.random(5, 15))
					fire:SetKeyValue("firesize", "8")
					fire:SetKeyValue("fireattack", "10")
					fire:SetKeyValue("damagescale", "1.0")
					fire:SetKeyValue("StartDisabled", "0")
					fire:SetKeyValue("firetype", "0")
					fire:SetKeyValue("spawnflags", "128")
					fire:Spawn()
					fire:Fire("StartFire", "", 0)
				end
			end
			util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
			end
		elseif Type == "explode" then
			if !tr.HitSky then
				local fx 	= EffectData()
				fx:SetStart(tr.HitPos)
				fx:SetOrigin(tr.HitPos)
				fx:SetNormal(tr.HitNormal)
				util.Effect("explode_hit",fx)
			end
			util.BlastDamage(self.Owner, self.Owner, tr.HitPos, (dmginfo:GetDamage() * 4), dmginfo:GetDamage() )
			util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
			
		elseif Type == "acid" then
		
			if math.random(1,ChanceToElemental) == 1 then
				if !tr.HitSky then
					local fx 	= EffectData()
					fx:SetStart(tr.HitPos)
					fx:SetOrigin(tr.HitPos)
					fx:SetNormal(tr.HitNormal)
					util.Effect("acid_hit",fx)
				end
			
				local Amount = math.Round(dmginfo:GetDamage() / 3) 
				local dmginfo = DamageInfo()
				dmginfo:SetDamage( Amount )
				dmginfo:SetDamagePosition( tr.HitPos )
				dmginfo:SetDamageType( DMG_ACID )
				dmginfo:SetAttacker( self.Owner )
				dmginfo:SetDamageForce( self.Owner:GetAimVector() * Amount * 2 )
			
				local Ents = ents.FindInSphere(tr.HitPos, dmginfo:GetDamage())
				for k, v in pairs(Ents) do
					for i = 1, math.random( 5, 15 ) do	
						if !v:IsValid() or v:Health() <= 0 then return end
						timer.Simple(i / math.random( 0.6, 1.5 ), function()
							if !dmginfo then return end
							if v:IsValid() and v:Health() > 0 then 
								dmginfo:SetDamagePosition( v:GetPos() + Vector(0,0,30) )
								v:TakeDamageInfo( dmginfo )
							end
						end, v)
					end
				end
			end	
		
		elseif Type == "shock" then
			if math.random(1,ChanceToElemental) == 1 then
				if !tr.HitSky then
					/*
					local fx 	= EffectData()
					fx:SetStart(tr.HitPos)
					fx:SetOrigin(tr.HitPos)
					fx:SetNormal(tr.HitNormal)
					util.Effect("shock_hit",fx)
					*/
					if SERVER then
						umsg.Start("CallShockImpact", self.Owner)
							umsg.Vector(tr.HitPos)
							umsg.Angle(tr.HitNormal)
							umsg.Entity(tr.Entity)
						umsg.End()
					end	
				end
			/*
				local Tesla = ents.Create("point_tesla")
				Tesla:SetPos(tr.HitPos + tr.HitNormal)
				Tesla:SetKeyValue("m_SoundName", "")
				Tesla:SetKeyValue("texture", "sprites/bluelight1.spr")
				Tesla:SetKeyValue("m_Color", "255 150 200")
				Tesla:SetKeyValue("m_flRadius", "30")
				Tesla:SetKeyValue("beamcount_min", "7")
				Tesla:SetKeyValue("beamcount_max", "9")
				Tesla:SetKeyValue("thickm_in", "2")
				Tesla:SetKeyValue("thick_max", "2")
				Tesla:SetKeyValue("lifetime_min", "0.3")
				Tesla:SetKeyValue("lifetime_max", "0.4")
				Tesla:SetKeyValue("interval_min", "0.1")
				Tesla:SetKeyValue("interval_max", "0.1")
				Tesla:Spawn()
				Tesla:Fire("DoSpark", "", 0)
				Tesla:Fire("Kill", "", 1)
			*/
				local Amount = math.Round(dmginfo:GetDamage() * 1.3) 
				local dmginfo = DamageInfo()
				dmginfo:SetDamage( Amount )
				dmginfo:SetDamagePosition( tr.HitPos )
				dmginfo:SetDamageType( DMG_SHOCK )
				dmginfo:SetAttacker( self.Owner )
				dmginfo:SetDamageForce( self.Owner:GetAimVector() * Amount * 2 )
			
				local Ents = ents.FindInSphere(tr.HitPos, dmginfo:GetDamage())
				for k, v in pairs(Ents) do
					v:TakeDamageInfo( dmginfo )
				end
			end
		elseif Type == "dissovle" then
			if math.random(1,ChanceToElemental) == 1 then
				if !tr.HitSky then
					local fx 	= EffectData()
					fx:SetStart(tr.HitPos)
					fx:SetOrigin(tr.HitPos)
					fx:SetNormal(tr.HitNormal)
					util.Effect("dissolve_hit",fx)
				end			
			
				local Amount = math.Round(dmginfo:GetDamage() * 1.5) 
				local dmginfo = DamageInfo()
				dmginfo:SetDamage( Amount )
				dmginfo:SetDamagePosition( tr.HitPos )
				dmginfo:SetDamageType( DMG_DISSOLVE )
				dmginfo:SetAttacker( self.Owner )
				dmginfo:SetDamageForce( self.Owner:GetAimVector() * Amount * 2 )
			
				local Ents = ents.FindInSphere(tr.HitPos, dmginfo:GetDamage())
				for k, v in pairs(Ents) do
					v:TakeDamageInfo( dmginfo )
				end
			end
		elseif Type == "normal" then	
			if GetConVarNumber("Lee_WeaponHitEffect") >= 1 and tr.HitWorld and !tr.HitSky then
				local fx 	= EffectData()
				fx:SetStart(tr.HitPos)
				fx:SetOrigin(tr.HitPos)
				fx:SetNormal(tr.HitNormal)
				fx:SetScale(math.Clamp(dmginfo:GetDamage() / 10,0,5))
				fx:SetSurfaceProp(tr.MatType)
				util.Effect("ground_hit",fx)	
			end
		end
	end
end

function SWEP:GetPenetrationDistance( mat_type, Damage )
	
	if ( mat_type == MAT_GLASS || mat_type == MAT_FLESH || mat_type == MAT_ALIENFLESH ) then
		return Damage
	elseif ( mat_type == MAT_PLASTIC  || mat_type == MAT_WOOD ) then
		return Damage * 2
	elseif( mat_type == MAT_TILE || mat_type == MAT_SAND || mat_type == MAT_DIRT ) then
		return Damage * 1.5
	end
	
	return Damage
	
end

SWEP.MaterialDamageLossMul = {[MAT_GLASS] = 0.95,
[MAT_FLESH] = 0.8,
[MAT_ALIENFLESH] = 0.8,
[MAT_PLASTIC] = 0.95,
[MAT_WOOD] = 0.7,
[MAT_TILE] = 0.8,
[MAT_CONCRETE] = 0.4,
[MAT_METAL] = 0.4,
[MAT_DIRT] = 0.6,
[MAT_SAND] = 0.7,
[MAT_VENT] = 0.9}

function SWEP:GetPenetrationDamageLoss( mat_type, distance, damage )
	
	if self.MaterialDamageLossMul[mat_type] then
		damage = (damage * self.MaterialDamageLossMul[mat_type]) - ( distance * 0.1 )
	end
	
	return damage - ( distance * 0.1 )
	
end

function SWEP:BulletEffect( attacker, tr, dmginfo, bounce, damage )
	if attacker:GetActiveWeapon() == nil then return end
	local PeneDir = tr.Normal * self:GetPenetrationDistance( tr.MatType, dmginfo:GetDamage() )
		
	local PeneTrace = {}
	PeneTrace.endpos = tr.HitPos
	PeneTrace.start = tr.HitPos + PeneDir
	PeneTrace.mask = MASK_SHOT
	PeneTrace.filter = { attacker }
	   
	local PeneTrace = util.TraceLine( PeneTrace ) 
	local distance = ( PeneTrace.HitPos - tr.HitPos ):Length()
	local MaxBulletEffect = math.Clamp(dmginfo:GetDamage() / 5, 3, 5)
	
	if distance > math.Clamp(dmginfo:GetDamage() / 2, 10, dmginfo:GetDamage() / 2) and tr.MatType == MAT_METAL or distance > math.Clamp(dmginfo:GetDamage() / 2, 10, dmginfo:GetDamage() / 2) and tr.MatType == MAT_CONCRETE then -- more physical shits 8D
	    if ( bounce > MaxBulletEffect) then return end
	    local RicoChance = nil
	    local DotProduct = tr.HitNormal:Dot( tr.Normal * -1 )
	    local Dir = ((2 * tr.HitNormal * DotProduct) + tr.Normal + (VectorRand() * 0.05))
	    Dir:Normalize()
	    if ( tr.MatType == MAT_CONCRETE ) then
	        RicoChance = 4
	    elseif ( tr.MatType == MAT_METAL ) then
	        RicoChance = 3
			if SERVER then
				umsg.Start("AddLightOnRicochet", self.Owner)
					umsg.Vector(tr.HitPos)
				umsg.End()
			end	
	    end
		/*
		if Dir:Angle().y > 45 or Dir:Angle().y < -45 then return end
		*/
	    RicoChance = math.Clamp(RicoChance - math.Round(dmginfo:GetDamage() / 20), 1, 5)
	
        if math.random( 1, RicoChance ) == 1 then
	
	        local bullet = 
	        {	
		        Num = 1,
		        Src = tr.HitPos + (tr.HitNormal * 5),
		        Dir = Dir,
		        Spread = Vector( 0.05, 0.05, 0 ),
		        Tracer = 1,
		        TracerName = "pene_trace",
		        Force = (dmginfo:GetDamage() * 2),
		        Damage = dmginfo:GetDamage(),
		        AmmoType = "Pistol",
		        HullSize = 2
	        }
	        bullet.Callback = function( a, b, c ) if ( BulletCallback ) then return BulletCallback( a, b, c, bounce + 1 ) end end
			
			sound.Play( "weapons/fx/rics/ric".. math.random(1,5) ..".wav", tr.HitPos, 80, math.random( 90, 150 ) )
			
			self.Owner:FireBullets( bullet )
        end
	else
	    if ( bounce > MaxBulletEffect ) and self.WeaponType == "shotgun" then return false end
	
	    if ( PeneTrace.StartSolid || PeneTrace.Fraction >= 1.0 || tr.Fraction <= 0.0 ) then return false end	

	    local PeneChance = nil
	    local new_damage = self:GetPenetrationDamageLoss( tr.MatType, distance, dmginfo:GetDamage() )
	
	    if ( tr.MatType == MAT_GLASS ) then
	        PeneChance = 1
	    elseif ( tr.MatType == MAT_WOOD ) then
	        PeneChance = 2
	    elseif ( tr.MatType == MAT_PLASTIC ) then
	        PeneChance = 2
	    elseif ( tr.MatType == MAT_TILE ) then
	        PeneChance = 4
	    elseif ( tr.MatType == MAT_DIRT ) then
	        PeneChance = 2
	    elseif ( tr.MatType == MAT_SAND ) then
	        PeneChance = 3
	    end
	
	    if PeneChance == nil then
	        PeneChance = 2
	    end
	
	    PeneChance = math.Clamp(PeneChance - math.Round(new_damage / 10), 1, 5)
	
	    if math.random( 1, PeneChance ) == 1 then
		    local bullet = 
		    {	
			    Num 		= 1,
			    Src 		= PeneTrace.HitPos,
			    Dir 		= tr.Normal,	
			    Spread 		= Vector( 0, 0, 0 ),
			    Tracer		= 1,
			    Force		= 5,
			    Damage		= new_damage,
                TracerName 	= "pene_trace",
			    AmmoType 	= "Pistol",
		    }
		
		    bullet.Callback = function( a, b, c ) if ( BulletCallback ) then return BulletCallback( a, b, c, bounce + 1 ) end end
			
			sound.Play("Bullets.DefaultNearmiss", tr.HitPos, 250, math.random(70, 110))
			
		    if(tr.MatType == MAT_GLASS) then 
		        util.Decal( "Impact.Glass", PeneTrace.HitPos + tr.Normal, PeneTrace.HitPos - tr.Normal )
		    elseif(tr.MatType == MAT_FLESH) then 
		        util.Decal( "Impact.Flesh", PeneTrace.HitPos + tr.Normal, PeneTrace.HitPos - tr.Normal ) 
		    elseif(tr.MatType == MAT_WOOD) then 
		        util.Decal( "Impact.Wood", PeneTrace.HitPos + tr.Normal, PeneTrace.HitPos - tr.Normal )
		    elseif(tr.MatType == MAT_VENT || tr.MatType == MAT_GRATE || tr.MatType == MAT_METAL) then 
		        util.Decal( "Impact.Metal", PeneTrace.HitPos + tr.Normal, PeneTrace.HitPos - tr.Normal ) 
		    elseif(tr.MatType == MAT_SAND) then 
		        util.Decal( "Impact.Sand", PeneTrace.HitPos + tr.Normal, PeneTrace.HitPos - tr.Normal ) 
		    elseif(tr.MatType == MAT_ANTLION) then 
		        util.Decal( "Impact.Antlion", PeneTrace.HitPos + tr.Normal, PeneTrace.HitPos - tr.Normal ) 
		    else 
		        util.Decal( "Impact.Concrete", PeneTrace.HitPos + tr.Normal, PeneTrace.HitPos - tr.Normal ) 
		    end

		    timer.Simple( distance / 500, attacker.FireBullets, attacker, bullet, true )
		end
    end
end

function SWEP:CustomRecoil(recoil)

	recoil = recoil * GetConVarNumber("Lee_WeaponRecoilMul")
	
	if !game.SinglePlayer() then
		recoil = recoil * 1.5
	end
	
	SideRecoil = recoil / 1.5
	
	local anglo = Angle(-recoil, math.Rand(-SideRecoil,SideRecoil), 0)
	
	if self:GetIronsights() and self.WeaponType != "pistol" and self.WeaponType != "shotgun" then
		anglo = Angle(math.Rand(recoil * -1, 0), math.Rand(SideRecoil * -1,SideRecoil), 0)
	end
	
	local angle = self.Owner:EyeAngles() + anglo

	self.Owner:ViewPunch(anglo)
	
end

function SWEP:TakePrimaryAmmo( num )
	
	// Doesn't use clips
	if ( self.Weapon:Clip1() <= 0 ) then 
	
		if ( self:Ammo1() <= 0 ) then return end
		
		self.Owner:RemoveAmmo( num, self.Weapon:GetPrimaryAmmoType() )
	
	return end
	
	self.Weapon:SetClip1( self.Weapon:Clip1() - num )	
	
end

function SWEP:TakeSecondaryAmmo( num )
	
	// Doesn't use clips
	if ( self.Weapon:Clip2() <= 0 ) then 
	
		if ( self:Ammo2() <= 0 ) then return end
		
		self.Owner:RemoveAmmo( num, self.Weapon:GetSecondaryAmmoType() )
	
	return end
	
	self.Weapon:SetClip2( self.Weapon:Clip2() - num )	
	
end

function SWEP:CanPrimaryAttack()
	if self.Owner:IsPlayer() then
		if ( self.Weapon:Clip1() <= 0 ) and self.Primary.ClipSize > -1 and !self.Owner:IsNPC() then
			local EmptySound = nil
			self.Weapon:SetNextPrimaryFire(CurTime() + (self.Primary.Delay * 2))
			if self.WeaponType == "rifle" then
				EmptySound = self.EmptySound or "weapons/ClipEmptyRifle.wav"
			elseif self.WeaponType == "pistol" or self.WeaponType == "smg" then
				EmptySound = self.EmptySound or "weapons/ClipEmptyPistol.wav"
			elseif self.WeaponType == "shotgun" then
				EmptySound = self.EmptySound or "Weapon_Shotgun.Empty"
			end
			
			if EmptySound ==  nil then
				EmptySound = "weapons/clipempty_rifle.wav"
			end
			
			self.Weapon:EmitSound(EmptySound)
			self.BurstTime = nil
			if GetConVarNumber("Lee_WeaponAutoReload") >= 1 then
				self:Reload()
			end
			return false
		end
		if self.Owner:WaterLevel() > 2 then
			self.Weapon:SetNextPrimaryFire(CurTime() + 0.5)
			self.Weapon:EmitSound("weapons/pistol/pistol_empty.wav")
			return false
		end
		
		if (self:GetHolster() and !self:GetIronsights()) or self.NearWall or (self.Running and !self:GetIronsights()) or self.Reloading or self.ShotgunReloading then
			self.Weapon:SetNextPrimaryFire(CurTime() + 0.1)
			return false
		end
		
		return true
	elseif self.Owner:IsNPC() then
		if ( self.Weapon:Clip1() <= 0 ) then
			self:EmitSound( "Weapon_Pistol.Empty" )
			self:SetNextPrimaryFire( CurTime() + 0.2 )
			self:Reload()
			return false
		end
		return true
	end
end

function SWEP:CanSecondaryAttack()

	if ( self.Weapon:Clip2() <= 0 ) then
	
		self.Weapon:EmitSound( "Weapon_Pistol.Empty" )
		self.Weapon:SetNextSecondaryFire( CurTime() + 0.2 )
		return false
		
	end

	return true

end

function SWEP:ContextScreenClick( aimvec, mousecode, pressed, ply )
end

function SWEP:OnRemove()
	self:ResetVar()
end

function SWEP:OnRestore()
	self:ResetVar()
end

function SWEP:OwnerChanged()
	self:ResetVar()
end

function SWEP:Ammo1()
	return self.Owner:GetAmmoCount( self.Weapon:GetPrimaryAmmoType() )
end

function SWEP:Ammo2()
	return self.Owner:GetAmmoCount( self.Weapon:GetSecondaryAmmoType() )
end

function SWEP:SetDeploySpeed( speed )
	self.m_WeaponDeploySpeed = tonumber( speed )
end

function SWEP:DoImpactEffect( tr, nDamageType )

	return false;
	
end