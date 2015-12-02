
include('shared.lua')

if !ConVarExists("lee_crosshair_fr") then
    CreateClientConVar("lee_crosshair_fr", 196, true, false)
end

if !ConVarExists("lee_crosshair_fg") then
    CreateClientConVar("lee_crosshair_fg", 36, true, false)
end

if !ConVarExists("lee_crosshair_fb") then
    CreateClientConVar("lee_crosshair_fb", 36, true, false)
end

if !ConVarExists("lee_crosshair_fa") then
    CreateClientConVar("lee_crosshair_fa", 200, true, false)
end

if !ConVarExists("lee_crosshair_fh") then
    CreateClientConVar("lee_crosshair_fh", -10, true, false)
end

if !ConVarExists("lee_crosshair_fw") then
    CreateClientConVar("lee_crosshair_fw", -10, true, false)
end

if !ConVarExists("lee_crosshair_h") then
    CreateClientConVar("lee_crosshair_h", -1, true, false)
end

if !ConVarExists("lee_crosshair_w") then
    CreateClientConVar("lee_crosshair_w", -1, true, false)
end

if !ConVarExists("lee_crosshair_r") then
    CreateClientConVar("lee_crosshair_r", 255, true, false)
end

if !ConVarExists("lee_crosshair_g") then
    CreateClientConVar("lee_crosshair_g", 255, true, false)
end

if !ConVarExists("lee_crosshair_b") then
    CreateClientConVar("lee_crosshair_b", 255, true, false)
end

if !ConVarExists("lee_crosshair_a") then
    CreateClientConVar("lee_crosshair_a", 255, true, false)
end

if !ConVarExists("lee_crosshair_x") then
    CreateClientConVar("lee_crosshair_x", 0, true, false)
end

if !ConVarExists("lee_crosshair_y") then
    CreateClientConVar("lee_crosshair_y", 0, true, false)
end

if !ConVarExists("lee_crosshair_le") then
    CreateClientConVar("lee_crosshair_le", 15, true, false)
end

if !ConVarExists("lee_crosshair_scale") then
    CreateClientConVar("lee_crosshair_scale", 2.5, true, false)
end

if !ConVarExists("lee_crosshair_scalespeed") then
    CreateClientConVar("lee_crosshair_scalespeed", 4, true, false)
end

if !ConVarExists("lee_crosshair_maxscale") then
    CreateClientConVar("lee_crosshair_maxscale", 6, true, false)
end

if !ConVarExists("lee_crosshair_t") then
    CreateClientConVar("lee_crosshair_t", 0, true, false)
end

if !ConVarExists("lee_crosshair_smooth") then
    CreateClientConVar("lee_crosshair_smooth", 0.05, true, false)
end

if !ConVarExists("Lee_WeaponNewOrigin") then
    CreateClientConVar("Lee_WeaponNewOrigin", 1, true, false)
end

if !ConVarExists("Lee_WeaponRealTimePos") then
    CreateClientConVar("Lee_WeaponRealTimePos", 0, true, false)
end

if !ConVarExists("Lee_AimSmooth") then
    CreateClientConVar("Lee_AimSmooth", 0.005, true, false)
end

if !ConVarExists("Lee_WeaponBobSpeedDiv") then
    CreateClientConVar("Lee_WeaponBobSpeedDiv", 0.3, true, false)
end

if !ConVarExists("Lee_WeaponFOV") then
    CreateClientConVar("Lee_WeaponFOV", 62, true, false)
end

if !ConVarExists("lee_crosshair_lengthbyscale") then
    CreateClientConVar("lee_crosshair_lengthbyscale", 1, true, false)
end

if !ConVarExists("lee_crosshair_special") then
    CreateClientConVar("lee_crosshair_special", 0, true, false)
end

if !ConVarExists("lee_WeaponSimpleEffect") then
    CreateClientConVar("lee_WeaponSimpleEffect", 0, true, false)
end

if !ConVarExists("lee_WeaponIronTiltXForce") then
    CreateClientConVar("lee_WeaponIronTiltXForce", -1, true, false)
end

if !ConVarExists("lee_WeaponIronTiltYForce") then
    CreateClientConVar("lee_WeaponIronTiltYForce", 0, true, false)
end

if !ConVarExists("lee_WeaponIronTiltZForce") then
    CreateClientConVar("lee_WeaponIronTiltZForce", -4, true, false)
end

if !ConVarExists("lee_WeaponIronTiltSpeed") then
    CreateClientConVar("lee_WeaponIronTiltSpeed", 0.35, true, false)
end

if !ConVarExists("lee_WeaponMovementSpeedDiv") then
    CreateClientConVar("lee_WeaponMovementSpeedDiv", 200, true, false)
end

if !ConVarExists("lee_WeaponMovementStepTime") then
    CreateClientConVar("lee_WeaponMovementStepTime", 0.55, true, false)
end

if !ConVarExists("cfov") then
    CreateClientConVar("cfov", 0, true, false)
end

SWEP.PrintName			= "Leeroys weapon base"	
SWEP.Slot				= 1	
SWEP.SlotPos			= 10		
SWEP.DrawAmmo			= true				
SWEP.DrawCrosshair		= false 				
SWEP.DrawWeaponInfoBox	= false		
SWEP.BounceWeaponIcon   = false
SWEP.CSMuzzleFlashes	= false
SWEP.SwayScale			= 0
SWEP.BobScale			= 0

SWEP.Category                   = "LeErOy`S Test"

SWEP.RenderGroup 		= RENDERGROUP_OPAQUE
SWEP.WepSelectIcon		= surface.GetTextureID( "weapons/swep" )
SWEP.SpeechBubbleLid	= surface.GetTextureID( "gui/speech_lid" )

local function CallIronTilt( um )
	local ply = LocalPlayer()
	local weapon = ply:GetActiveWeapon()
	weapon.TiltTime = CurTime() + (um:ReadFloat() / 2)
end
usermessage.Hook( "CallIronTilt", CallIronTilt )

local function SendShootInfo( um )
	local ply = LocalPlayer()
	local weapon = ply:GetActiveWeapon()
	
	local AddRecoil = um:ReadFloat()
	local RecoverTime = um:ReadFloat()
	
	weapon.ClAddRecoil = AddRecoil
	weapon.ClRecoverTime = CurTime() + RecoverTime
	ply:ChatPrint(""..weapon.ClAddRecoil.."")
end
usermessage.Hook( "SendShootInfo", SendShootInfo )

SWEP.CrosshairScale = 1
SWEP.AddScale = 1
SWEP.CanScale = 1
SWEP.CrossHairAlpha = 255

local iScreenWidth = surface.ScreenWidth()
local iScreenHeight = surface.ScreenHeight()
local SCOPEFADE_TIME = 0.2

/*---------------------------------------------------------
   Name: SWEP:CrossairScale()
---------------------------------------------------------*/
function SWEP:CrossairScale()

	local CurrentScale 
	local scalebywidth = ScrW() / 1024 * 10
	local Speed = self.Owner:GetVelocity():Length()
	local CrossairAnim = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
	
	if !self.ClientSpread then
		self.ClientSpread = self.Primary.Cone
	end
	
	CurrentScale = (GetConVarNumber("lee_crosshair_scale") * self.Primary.Cone) + Speed / 6000

	if (self.RecoverTime + CrossairAnim >= CurTime()) then --gatcha bitch 8D
		self.AddScale = self.AddScale + math.Clamp(self.DeltaRecoil*scalebywidth/50, 0, 0.01*scalebywidth)
	elseif (self.RecoverTime + CrossairAnim < CurTime()) then
		self.AddScale = math.Approach(self.AddScale, 0, FrameTime() * (self.RecoverTime * 100))
	end

	if !self.Owner:OnGround() then
		CurrentScale = ( CurrentScale * 2.5 )
		self.AddScale = ( self.AddScale * 1.05 )
	end

	if self.Weapon:GetDTBool( 1 ) or self.Owner:OnGround() and self.Owner:Crouching() then
		CurrentScale = ( CurrentScale / 1.5 )
		self.AddScale = ( self.AddScale / 1.25 )
	end

	CurrentScale = CurrentScale * scalebywidth
	
	if self.WeaponType != "shotgun" and self.WeaponType != "special" then
		CurrentScale = CurrentScale + self.AddScale
		return math.Clamp(CurrentScale, 0.2, CurrentScale)
	else
		CurrentScale = (self.Primary.Cone * scalebywidth) / 2
		CurrentScale = CurrentScale * (5 - math.Clamp( (CurTime() - CrossairAnim) * 5, 0.0, 1.0 ))
		return CurrentScale
	end
	
end

function SWEP:FadeIt() -- fade this shit
	if self.Weapon:GetDTBool( 1 ) or self.NearWall or self.Running or self.Weapon:GetDTBool( 0 ) or self.Weapon:GetDTBool( 3 ) or self.ShotGunReloading or self.SilencerHoldTime and self.SilencerHoldTime > CurTime() then
		return true
	else
		return false
	end
end

/*---------------------------------------------------------
   Name: SWEP:DrawCrosshair()
---------------------------------------------------------*/
function SWEP:DrawCrosshairHUD(x, y, width, height, CrossHairAlpha)
	
	local FDist = 255 / GetConVarNumber("lee_crosshair_fa")
	local Dist = 255 / GetConVarNumber("lee_crosshair_a")
	
	local FCrossAMul = math.Clamp(CrossHairAlpha, 0, GetConVarNumber("lee_crosshair_fa"))
	local CrossAMul = math.Clamp(CrossHairAlpha, 0, GetConVarNumber("lee_crosshair_a"))

	surface.SetDrawColor(GetConVarNumber("lee_crosshair_fr"), GetConVarNumber("lee_crosshair_fg"), GetConVarNumber("lee_crosshair_fb"), CrossHairAlpha)
	surface.DrawRect(x + GetConVarNumber("lee_crosshair_x"), y + GetConVarNumber("lee_crosshair_y"), width + GetConVarNumber("lee_crosshair_fw"), height + GetConVarNumber("lee_crosshair_fh"))
	
	surface.SetDrawColor( GetConVarNumber("lee_crosshair_r"), GetConVarNumber("lee_crosshair_g"), GetConVarNumber("lee_crosshair_b"), CrossHairAlpha );	
	surface.DrawRect((x + 1) + GetConVarNumber("lee_crosshair_x"), (y + 1) + GetConVarNumber("lee_crosshair_y"), width + GetConVarNumber("lee_crosshair_w"), height + GetConVarNumber("lee_crosshair_h"))

end

local CrosshairAnim = 0

/*---------------------------------------------------------
	You can draw to the HUD here - it will only draw when
	the client has the weapon deployed..
---------------------------------------------------------*/
function SWEP:DrawHUD()
	
	if GetConVarNumber("lee_crosshair_t") >= 1 and self.WeaponType != "sniper" and !self.Owner:InVehicle() then 
		
		x, y = ScrW() / 2.0, ScrH() / 2.0

		local LastShootTime = self.Weapon:GetNetworkedFloat( "LastShootTime", 0 )
		local ShootDif = CurTime() - LastShootTime
		local FovMul = self.Owner:GetFOV() / 75 -- 75 is the normal FOV
	
		local dist = math.abs(self.CrosshairScale - self:CrossairScale())
		
		self.CrosshairScale = math.Approach(self.CrosshairScale, self:CrossairScale(), FrameTime() * GetConVarNumber("lee_crosshair_scalespeed") + dist * GetConVarNumber("lee_crosshair_smooth"))
		self.CrosshairScale = math.Clamp(self.CrosshairScale, 0, GetConVarNumber("lee_crosshair_maxscale") ) * FovMul
	
		local gap = 10 * self.CrosshairScale

		gap = math.Clamp(gap, 0, (ScrH() / 2))
		
		local length = GetConVarNumber("lee_crosshair_le") * FovMul
		if GetConVarNumber("lee_crosshair_lengthbyscale") >= 1 then
			length = length + (gap / 2) * FovMul
		end
		
		if self:FadeIt() and self.CrossHairAlpha > 0 then
			self.CrossHairAlpha = self.CrossHairAlpha - FrameTime() * 800
			if self.CrossHairAlpha < 0 then
				self.CrossHairAlpha = 0
			end
		elseif !self:FadeIt() and self.CrossHairAlpha < 255 then
			self.CrossHairAlpha = self.CrossHairAlpha + FrameTime() * 800
			if self.CrossHairAlpha > 255 then
				self.CrossHairAlpha = 255
			end
		end
		
		local scalebywidth = ScrW() / 1024 * 10
		local Mul = 1 - (self.CrosshairScale / (GetConVarNumber("lee_crosshair_maxscale") + 14))
	
		self.CrossHairAlpha = self.CrossHairAlpha * Mul
		
		self:DrawCrosshairHUD(x - gap - length, y - 1, length, 3, self.CrossHairAlpha) 	// Left
		self:DrawCrosshairHUD(x + gap + 1, y - 1, length, 3, self.CrossHairAlpha) 		// Right
		self:DrawCrosshairHUD(x - 1, y - gap - length, 3, length, self.CrossHairAlpha) 	// Top 
		self:DrawCrosshairHUD(x - 1, y + gap + 1, 3, length, self.CrossHairAlpha) 		// Bottom
		
    end
	
	if self.UseScope then
    -- fading effect not by me 
		local bScope = self.Weapon:GetDTBool( 2 )
		if bScope ~= self.bLastScope then 
	
			self.bLastScope = bScope
			self.fScopeTime = CurTime()
			
		end
			
		local fScopeTime = self.fScopeTime or 0

		if fScopeTime > CurTime() - SCOPEFADE_TIME then
		
			local Mul = 1.0 -- This scales the alpha
			Mul = 1 - math.Clamp((CurTime() - fScopeTime)/SCOPEFADE_TIME, 0, 1)
		
			surface.SetDrawColor(0, 0, 0, 255*Mul)
			surface.DrawRect(0,0,iScreenWidth,iScreenHeight)
		end

	end
	/*
	local x = iScreenWidth * .4300
	local y = iScreenHeight * .9425
	local w = 115
	local h = 10
	
	local ply = LocalPlayer()
	local Etat = self:GetNWInt("Fas_Etat")
	
	local HeightByEtat = math.Clamp( Etat * 1.09 + 1.5, 0, w + 10)
	local AlphaByEtat = math.Clamp( Etat * 1.09 , 0, 255)
	
    if self.Base == "weapon_uni_base" and self.WeaponType != "special" then
		draw.RoundedBox( 6, x, y, ScreenScale(w), ScreenScale(h), Color( 0, 0, 0, 150 ) )
		draw.RoundedBox( 6, x+3, y+3, ScreenScale(HeightByEtat), ScreenScale(h - 4), Color( GetConVarNumber("lee_crosshair_r"), GetConVarNumber("lee_crosshair_g"), GetConVarNumber("lee_crosshair_b"), AlphaByEtat ) )
	end
*/
	
end

/*---------------------------------------------------------
	Checks the objects before any action is taken
	This is to make sure that the entities haven't been removed
---------------------------------------------------------*/
function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	
	draw.SimpleText (self.IconLetter, self.IconLetterFont or "csSelectIcons", x + wide/2, (y + 5) + tall*0.2, Color (255, 210, 0, 255), TEXT_ALIGN_CENTER) 	 
	
	// try to fool them into thinking they're playing a Tony Hawks game
	draw.SimpleText( self.IconLetter, self.IconLetterFont or "csSelectIcons", x + wide/2 + math.Rand(-4, 4), (y + 5) + tall*0.2+ math.Rand(-14, 14), Color( 255, 210, 0, math.Rand(10, 120) ), TEXT_ALIGN_CENTER )
	draw.SimpleText( self.IconLetter, self.IconLetterFont or "csSelectIcons", x + wide/2 + math.Rand(-4, 4), (y + 5) + tall*0.2+ math.Rand(-9, 9), Color( 255, 210, 0, math.Rand(10, 120) ), TEXT_ALIGN_CENTER )

end

/*---------------------------------------------------------
	This draws the weapon info box
---------------------------------------------------------*/
function SWEP:PrintWeaponInfo( x, y, alpha )
	return false
end

/*---------------------------------------------------------
   Name: SWEP:FreezeMovement()
   Desc: Return true to freeze moving the view
---------------------------------------------------------*/
function SWEP:FreezeMovement()
	return false
end

/*---------------------------------------------------------
   Name: OnRestore
   Desc: Called immediately after a "load"
---------------------------------------------------------*/
function SWEP:OnRestore()
end

/*---------------------------------------------------------
   Name: OnRemove
   Desc: Called just before entity is deleted
---------------------------------------------------------*/
function SWEP:OnRemove()
end

/*---------------------------------------------------------
   Name: CustomAmmoDisplay
   Desc: Return a table
---------------------------------------------------------*/
function SWEP:CustomAmmoDisplay()
end

local VmPos = Vector(0, 0, 0)
local VmAng = Vector(0, 0, 0)
local VmMovementPos = Vector(0, 0, 0)
local VmMovementAng = Vector(0, 0, 0)
local AddVmMovementPos = Vector(0, 0, 0)
local AddVmMovementAng = Vector(0, 0, 0)
local VmSwayAng = Angle(0, 0, 0)
local VmSwayLastAng = Angle(0, 0, 0)
local VmMovementMul = 1
local VMSmooth = 0.2
local IdlePosX = 0
local IdlePosY = 0
local IdleTime = CurTime()
local IdleTick = 0
local IdleForce = 0
local IdleAng = Vector(0,0,0)
local StepTime = 0
local StepSmooth = 0
local IronTiltAngle = Vector(0,0,0) -- im sure i can do it 8D

local ShootAnimPos = Vector(0,0,0)

local CrouchValue = 0

/*---------------------------------------------------------
   Name: GetViewModelPosition
   Desc: Allows you to re-position the view model
---------------------------------------------------------*/
function SWEP:GetViewModelPosition( pos, ang )
    
	local Running = self.Running
	local bIron = self.Weapon:GetDTBool( 1 )
	local Holster = self.Weapon:GetDTBool( 0 )
	local Reload = self.Weapon:GetDTBool( 3 )
	local NearWall = self.NearWall
	local vel = self.Owner:GetVelocity()
	local Speed = vel:Length()
	local EyeAng = self.Owner:EyeAngles()
	
	if GetConVarNumber("Lee_AttachViewModelToView") >= 1 then
		ang = EyeAng 
		if self.ViewModelFlip then
			ang.y = EyeAng.y + (EyeAng.y - ang.y)
		end
	end	
	
	if self.Owner:InVehicle() or self.Owner:GetMoveType() == MOVETYPE_NOCLIP and NearWall then return pos, ang end
	
	Ipos = pos
	Iang = ang
	
	self.Weapon.ViewModelFOV = GetConVarNumber("Lee_WeaponFOV")
	if bIron then
		self.SwayScale = 0.15
		self.BobScale = 0
	else
		self.SwayScale = 1
		self.BobScale = 0
	end
	
	if bIron then
	    Ipos = self.IronSightsPos
		Iang = self.IronSightsAng
		if GetConVarNumber("Lee_NewPlayerView")	>= 1 then 
			VMSmooth = FrameTime()/(self.IronSightTime / 4)
		else
			VMSmooth = FrameTime()/self.IronSightTime
		end
		IdleForce = 0.05
		IdleTick = 0.4
		VmMovementMul = 0.15
	elseif Running and self.RunArmOffset and self.RunArmAngle and !Reload then
	    Ipos = self.RunArmOffset
		Iang = self.RunArmAngle
		if GetConVarNumber("Lee_NewPlayerView")	>= 1 then 
			VMSmooth = FrameTime()/(self.RunSetTime / 2)
		else
			VMSmooth = FrameTime()/self.RunSetTime
		end
		IdleForce = 0
		IdleTick = 0
		BobSpeed = Speed / 550
		VmMovementMul = math.Clamp(BobSpeed, 1, 3)
	elseif !bIron and !Running and !Holster and !NearWall or Reload and Running then
		if GetConVarNumber("Lee_WeaponNewOrigin") <= 0 or !self.NewOriginAng or !self.NewOriginPos then
			Ipos = Vector(0, 0, 0)
			Iang = Vector(0, 0, 0)
		elseif GetConVarNumber("Lee_WeaponNewOrigin") >= 1 and self.NewOriginPos and self.NewOriginAng then 
			Ipos = self.NewOriginPos 
			Iang = self.NewOriginAng
		end
		if self.WeaponType == "sniper" then
			if GetConVarNumber("Lee_NewPlayerView")	>= 1 then 
				VMSmooth = FrameTime()/(self.IronSightTime / 4)
			else
				VMSmooth = FrameTime()/self.IronSightTime
			end
		else
			if GetConVarNumber("Lee_NewPlayerView")	>= 1 then 
				VMSmooth = FrameTime()/(0.25 / 2)
			else
				VMSmooth = FrameTime()/0.25
			end
		end
		IdleForce = 0.35
		IdleTick = 0.4
		VmMovementMul = 1
	elseif Holster and !NearWall then
		if self.WeaponType == "pistol" then
			Ipos = self.HolsterPos
			Iang = self.HolstersAng
		else
			Ipos = self.RunArmOffset
			Iang = self.RunArmAngle
		end
		if GetConVarNumber("Lee_NewPlayerView")	>= 1 then 
			VMSmooth = FrameTime()/(self.SetHolsterTime / 2)
		else
			VMSmooth = FrameTime()/self.SetHolsterTime
		end
		IdleForce = 0.1
		IdleTick = math.random(0.4, 0.6)
		VmMovementMul = 1
	elseif NearWall and !Holster then
		local WantedPos
		local WantedAng
		local tr = util.GetPlayerTrace( self.Owner )
		tr.mask = ( CONTENTS_SOLID||CONTENTS_MOVEABLE||CONTENTS_MONSTER||CONTENTS_WINDOW||CONTENTS_DEBRIS||CONTENTS_GRATE||CONTENTS_AUX )
		local Trace = util.TraceLine( tr )
		local Dist = Trace.HitPos:Distance(self.Owner:GetShootPos())
		Dist = Dist / 15
		
		if self.WeaponType == "pistol" then
			WantedPos = self.PistolNearWallPos
			WantedAng = self.PistolNearWallAng
		elseif self.WeaponType == "shotgun" then
			WantedPos = self.ShotgunNearWallPos
			WantedAng = self.ShotgunNearWallAng
		elseif self.WeaponType != "pistol" and self.WeaponType != "shotgun" then
			WantedPos = self.NearWallPos
			WantedAng = self.NearWallAng
		end
		
		--this part fix the anoying near wall problem
		WantedAng = (WantedAng / Dist)
		WantedAng.x = math.Clamp(WantedAng.x,-100,100)
		WantedAng.y = math.Clamp(WantedAng.y,-100,100)
		WantedAng.z = math.Clamp(WantedAng.z,-100,100)
		WantedPos = (WantedPos / Dist)
		WantedPos.x = math.Clamp(WantedPos.x,-100,100)
		WantedPos.y = math.Clamp(WantedPos.y,-100,100)
		WantedPos.z = math.Clamp(WantedPos.z,-100,100)
		
		Ipos = WantedPos
		Iang = WantedAng
		if GetConVarNumber("Lee_NewPlayerView")	>= 1 then 
			VMSmooth = FrameTime()/(0.15 / 2)
		else
			VMSmooth = FrameTime()/0.15
		end
		IdleForce = 0.1
		IdleTick = math.random(0.4, 0.6)
		VmMovementMul = 1
	elseif NearWall and Holster then	
		if self.WeaponType == "pistol" then
			Ipos = self.HolsterPos
			Iang = self.HolstersAng
		else
			Ipos = self.RunArmOffset
			Iang = self.RunArmAngle
		end
		if GetConVarNumber("Lee_NewPlayerView")	>= 1 then 
			VMSmooth = FrameTime()/(self.SetHolsterTime / 2)
		else
			VMSmooth = FrameTime()/self.SetHolsterTime
		end
		IdleForce = 0.1
		IdleTick = math.random(0.4, 0.6)
		VmMovementMul = 1
	end
	
	if self.SilencerHoldTime and self.SilencerHoldTime >= CurTime() then
		self.SetSilencer = true
	elseif !self.SilencerHoldTime or self.SilencerHoldTime < CurTime() then
		self.SetSilencer = false
	end

	if self.SetSilencer then
		Ipos = self.HolsterPos
		Iang = self.HolstersAng
	elseif self.MeleeAnimTime and self.MeleeAnimTime > CurTime() then
		Ipos = self.MeleePos
		Iang = self.MeleeAng
	elseif !self.SetSilencer or !self.MeleeAnimTime or self.MeleeAnimTime <= CurTime() then
		Ipos = Ipos
		Iang = Iang
	end

	VmPos = LerpVector(VMSmooth, VmPos, Ipos)
	VmAng = LerpVector(VMSmooth, VmAng, Iang)
	
	local PosDist = VmPos - Ipos
	local AngDist = VmAng - Iang
	
	if GetConVarNumber("Lee_NewPlayerView") <= 0 then 
		if self.Owner:IsOnGround() and !self.Owner.Sliding then
			MaxedSpeed = math.Clamp(Speed, 0, 450) 
			StepSmooth = StepSmooth * 0.75 + MaxedSpeed / GetConVarNumber("lee_WeaponMovementSpeedDiv")
			StepTime = (StepTime + StepSmooth * FrameTime() * GetConVarNumber("lee_WeaponMovementStepTime"))
			if Running then
				if self.WeaponType != "pistol" then
					VmMovementPos.y = ((math.cos(StepTime / 2) * StepSmooth) / 10) * VmMovementMul
					VmMovementPos.z = ((math.sin(StepTime) * StepSmooth) / 25) * VmMovementMul
					VmMovementAng.y = ((math.sin(StepTime / 2) * StepSmooth) / 2.5 ) * VmMovementMul
				elseif self.WeaponType == "pistol" then
					VmMovementPos.x = ((math.cos(StepTime / 2) * StepSmooth) / 20) * VmMovementMul
					VmMovementPos.z = ((math.sin(StepTime) * StepSmooth) / 25) * VmMovementMul
					VmMovementAng.y = ((math.sin(StepTime / 2) * StepSmooth) / 5 ) * VmMovementMul
				end
			else
				VmMovementPos.x = ((math.sin(StepTime / 2) * StepSmooth) / 25) * VmMovementMul
				VmMovementPos.y = ((math.cos(StepTime / 2) * StepSmooth) / 25) * VmMovementMul
				VmMovementPos.z = ((math.sin(StepTime) * StepSmooth) / 30) * VmMovementMul
				VmMovementAng.z = ((math.sin(StepTime / 2) * StepSmooth) / 10 ) * VmMovementMul
				
				if !bIron and !Running then
					AddVmMovementPos.y = (MaxedSpeed / 250)
					VmMovementAng.y = ((math.sin(StepTime / 2) * StepSmooth) / 10 ) * VmMovementMul
				end		
			
				if VmMovementAng.x != 0 or VmMovementAng.y != 0 then
					VmMovementAng.x = Lerp(FrameTime() * 1.5, VmMovementAng.x, 0)
					if bIron then
						VmMovementAng.y = Lerp(FrameTime() * 1.5, VmMovementAng.y, 0)
					end
				end
			end
		
			local MaxCrouchValue = 1
			if self.Owner:KeyDown(IN_DUCK) and !bIron then
				local Dist = MaxCrouchValue - CrouchValue
				if CrouchValue < MaxCrouchValue then
					CrouchValue = CrouchValue + FrameTime() * (Dist * 2.5)
				end
				if CrouchValue > MaxCrouchValue then
					CrouchValue = MaxCrouchValue
				end
				if CrouchValue > 0 then
					VmMovementPos.z = VmMovementPos.z - CrouchValue
				end
			else
				local Dist = CrouchValue - 0
				if CrouchValue > 0 then
					CrouchValue = CrouchValue - FrameTime() * (Dist * 2.5)
				end
				if CrouchValue < 0 then
					CrouchValue = 0
				end
				if CrouchValue > 0 then
					VmMovementPos.z = VmMovementPos.z - CrouchValue
				end
			end
		else
			if VmMovementPos.x != 0 or VmMovementPos.y != 0 or VmMovementPos.z != 0 or VmMovementAng.z != 0 or VmMovementAng.x != 0 or VmMovementAng.y != 0 then
				VmMovementPos.x = Lerp(FrameTime() * 1.5, VmMovementPos.x, 0)
				VmMovementPos.y = Lerp(FrameTime() * 1.5, VmMovementPos.y, 0)
				VmMovementPos.z = Lerp(FrameTime() * 1.5, VmMovementPos.z, 0)
				VmMovementAng.z = Lerp(FrameTime() * 1.5, VmMovementAng.z, 0)
				VmMovementAng.x = Lerp(FrameTime() * 1.5, VmMovementAng.x, 0)
				VmMovementAng.y = Lerp(FrameTime() * 1.5, VmMovementAng.y, 0)
			end	
		end	
	end
	
	if IdleTime < CurTime() then
	    
		IdlePosX = math.Rand(-IdleForce, IdleForce)
        IdlePosY = math.Rand(-IdleForce, IdleForce)
	    IdleTime = CurTime() + IdleTick
	
	end
	
	IdleAng.x = Lerp(FrameTime() / 1.35, IdleAng.x, IdlePosX)
	IdleAng.y = Lerp(FrameTime() / 1.35, IdleAng.y, IdlePosY)	
	
	if self.Weapon.TiltTime and self.Weapon.TiltTime >= CurTime() then
		if !bIron then
			IronTiltAngle.y = Lerp(FrameTime() / GetConVarNumber("lee_WeaponIronTiltSpeed"), IronTiltAngle.y, GetConVarNumber("lee_WeaponIronTiltYForce") * -1)
			IronTiltAngle.z = Lerp(FrameTime() / GetConVarNumber("lee_WeaponIronTiltSpeed"), IronTiltAngle.z, GetConVarNumber("lee_WeaponIronTiltZForce") * -1)
			IronTiltAngle.x = Lerp(FrameTime() / GetConVarNumber("lee_WeaponIronTiltSpeed"), IronTiltAngle.x, GetConVarNumber("lee_WeaponIronTiltXForce"))
		else
			IronTiltAngle.y = Lerp(FrameTime() / GetConVarNumber("lee_WeaponIronTiltSpeed"), IronTiltAngle.y, GetConVarNumber("lee_WeaponIronTiltYForce"))
			IronTiltAngle.z = Lerp(FrameTime() / GetConVarNumber("lee_WeaponIronTiltSpeed"), IronTiltAngle.z, GetConVarNumber("lee_WeaponIronTiltZForce"))
			IronTiltAngle.x = Lerp(FrameTime() / GetConVarNumber("lee_WeaponIronTiltSpeed"), IronTiltAngle.x, GetConVarNumber("lee_WeaponIronTiltXForce"))
		end
	else
		IronTiltAngle.x = Lerp(FrameTime() / GetConVarNumber("lee_WeaponIronTiltSpeed"), IronTiltAngle.x, 0)
		IronTiltAngle.y = Lerp(FrameTime() / GetConVarNumber("lee_WeaponIronTiltSpeed"), IronTiltAngle.y, 0)
		IronTiltAngle.z = Lerp(FrameTime() / GetConVarNumber("lee_WeaponIronTiltSpeed"), IronTiltAngle.z, 0)
	end
/*
	if !SmoothedAng then
		SmoothedAng = ang
	end
	
	VmSwayLastAng = SmoothedAng
	SmoothedAng = LerpAngle(FrameTime() * 0.1, VmSwayLastAng, ang)
	
	if ( math.abs(ang.y - SmoothedAng.y) > 180 ) then -- thanks to the creator of NOAMZ for this angle coordination fix
		if ( (ang.y - SmoothedAng.y) < 0 ) then
			ang.y = ang.y + 360
		else
			ang.y = ang.y - 360
		end
		Dist = math.Round(SmoothedAng.y) / math.Round(ang.y)
	else
		Dist = math.Round(ang.y) / math.Round(SmoothedAng.y)
	end

	VmSwayAng.y = (1 * 10) - (Dist * 10)
	*/
	if self.IronShootFixTime then
		local Recoil = math.Clamp(self.Primary.Recoil,1,self.Primary.Recoil)
		
		ShootAnimPos.y = (Recoil - math.Clamp( (CurTime() - self.IronShootFixTime) * 5, 0.0, Recoil))
		/*
		ShootAnimPos.z = ((Recoil / 5) - math.Clamp( (CurTime() - self.IronShootFixTime) * 1.5, 0.0, (Recoil / 5)))
		*/
	end
	
	ang = ang * 1
	ang:RotateAroundAxis( ang:Right(), VmAng.x + (VmMovementAng.x + IdleAng.x + IronTiltAngle.x + VmSwayAng.p) )
	ang:RotateAroundAxis( ang:Up(), VmAng.y + (VmMovementAng.y + IdleAng.y + IronTiltAngle.y + VmSwayAng.y) )
	ang:RotateAroundAxis( ang:Forward(), VmAng.z + (VmMovementAng.z + IdleAng.z + IronTiltAngle.z + VmSwayAng.r))
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	local Mul = 1
	
	if self.UseScope and bIron then
		Mul = 0
	end
	
	lookangle = self.Owner:GetUp() - self.Owner:GetAimVector()
	lookangle.z = math.Clamp(lookangle.z,-1.7, 1.7) * Mul

	pos = pos + (VmPos.x + VmMovementPos.x) * Right 
	pos = pos + (VmPos.y + VmMovementPos.y - ShootAnimPos.y - AddVmMovementPos.y - (lookangle.z / 1.5)) * Forward 
	pos = pos + (VmPos.z + VmMovementPos.z + ShootAnimPos.z) * Up 

	return pos, ang
	
end

/*---------------------------------------------------------
   Name: TranslateFOV
   Desc: Allows the weapon to translate the player's FOV (clientside)
---------------------------------------------------------*/
function SWEP:TranslateFOV( current_fov )
	
	if !self.CanZoom then return current_fov end
	
    if self.Weapon:GetDTBool(2) then return current_fov / self.ScopeForce end

	local bIron = self.Weapon:GetDTBool( 1 )
	if bIron ~= self.bLastIron then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()

	end
	
	local fIronTime = self.fIronTime or 0
	
	if not bIron and (fIronTime < CurTime() - self.IronSightTime ) then 
		return current_fov
	end
	
	local Mul = 1.0 
	
	if fIronTime > CurTime() - self.IronSightTime  then
	
		Mul = math.Clamp((CurTime() - fIronTime) / self.IronSightTime , 0, 1)
		if not bIron then Mul = 1 - Mul end
	
	end

	current_fov = current_fov*(1 + Mul/self.IronSightZoom - Mul)

	return current_fov
end

function SWEP:ViewModelDrawn()
end

function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
         
	local bone, pos, ang
	if (tab.rel and tab.rel != "") then
		 
		local v = basetab[tab.rel]
		 
		if (!v) then return end
		 
		// Technically, if there exists an element with the same name as a bone
		// you can get in an infinite loop. Let's just hope nobody's that stupid.
		pos, ang = self:GetBoneOrientation( basetab, v, ent )
		 
		if (!pos) then return end
		 
		pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			 
	else
	 
		bone = ent:LookupBone(bone_override or tab.bone)

		if (!bone) then return end
		 
		pos, ang = Vector(0,0,0), Angle(0,0,0)
		local m = ent:GetBoneMatrix(bone)
		if (m) then
			pos, ang = m:GetTranslation(), m:GetAngle()
		end
		 
		if (ValidEntity(self.Owner) and self.Owner:IsPlayer() and
			ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
			ang.r = -ang.r // Fixes mirrored models
		end
	 
	end
	 
	return pos, ang
end

function SWEP:GetAttachmentOrientation( Pos, Ent, Attachment )

	local Ang = Vector(0,0,1)
	
	if !ValidEntity(Ent) then 
		return Pos, Vector(0, 0, 1) 
	end
	
	if !Ent:IsWeapon() then 
		return Pos, Vector(0, 0, 1) 
	end

	if Ent:IsCarriedByLocalPlayer() && GetViewEntity() == self.Owner then
		local Vm = self.Owner:GetViewModel()
		if ValidEntity(Vm) then
			local att = Vm:GetAttachment( Attachment )
			if att then
				Pos = att.Pos
				Ang = att.Ang
			end
		end
	else
		Ang = Ent:GetOwner():GetAimVector()
		Pos = Ent:GetOwner():GetShootPos()
	end

	return Pos,Ang

end

/*---------------------------------------------------------
   Name: DrawWorldModel
   Desc: Draws the world model (not the viewmodel)
---------------------------------------------------------*/
function SWEP:DrawWorldModel()
	
	self.Weapon:DrawModel()

end


/*---------------------------------------------------------
   Name: DrawWorldModelTranslucent
   Desc: Draws the world model (not the viewmodel)
---------------------------------------------------------*/
function SWEP:DrawWorldModelTranslucent()
	
	self.Weapon:DrawModel()

end


/*---------------------------------------------------------
   Name: AdjustMouseSensitivity()
   Desc: Allows you to adjust the mouse sensitivity.
---------------------------------------------------------*/
function SWEP:AdjustMouseSensitivity()
	if self.Weapon:GetDTBool( 1 ) then
		return GetConVarNumber("Lee_AimSmooth") * self.Owner:GetFOV()
	else
		return 1
	end
end

/*---------------------------------------------------------
   Name: GetTracerOrigin()
   Desc: Allows you to override where the tracer comes from (in first person view)
		 returning anything but a vector indicates that you want the default action
---------------------------------------------------------*/
function SWEP:GetTracerOrigin()

/*
	local ply = self:GetOwner()
	local pos = ply:EyePos() + ply:EyeAngles():Right() * -5
	return pos
*/

end

local ClearBones = {"v_weapon.Right_Hand", "v_weapon.Right_Pinky01", "v_weapon.Right_Pinky02", "v_weapon.Right_Pinky03", "v_weapon.R_wrist_helper", "v_weapon.Right_Arm", "v_weapon.Right_Thumb01", "v_weapon.Right_Thumb02", "v_weapon.Right_Thumb_02", "v_weapon.Right_Thumb03", "v_weapon.Right_Middle01", "v_weapon.Right_Middle02", "v_weapon.Right_Middle03", "v_weapon.Right_Ring01", "v_weapon.Right_Ring02", "v_weapon.Right_Ring03", "v_weapon.Right_Pinky01", "v_weapon.Right_Pinky02", "v_weapon.Right_Pinky03", "v_weapon.Right_Index01", "v_weapon.Right_Index02", "v_weapon.Right_Index03", "v_weapon.eff18", "v_weapon.Root23", "v_weapon.eff9", "v_weapon.Root24", "v_weapon.Root26", "v_weapon.Root27", "v_weapon.Root28", "v_weapon.Root98", "v_weapon.Root25", "v_weapon.Root36" }

local adsad = {"v_weapon.Right_Arm"}

function SWEP:ApplyViewModelTransformations( vm )

	local Reloading = self.Weapon:GetDTBool(3)
	local Iron = self.Weapon:GetDTBool(1)

	vm:SetupBones()
	/*
	if vm and ValidEntity( vm ) and ClearBones then
		for k, v in pairs( ClearBones ) do
			local Bone = vm:LookupBone( v )

			if( Bone and Bone > 0 ) then
				local matrix = vm:GetBoneMatrix( Bone )

				if( matrix ) then
					
					local Pos, Ang = matrix:GetTranslation(), matrix:GetAngle()
					
					if BoneScale == nil then
						BoneScale = Vector(0,0,0)
					end
					
					if Reloading or Iron then
						BoneScale.x = Lerp(FrameTime() * 0.35, BoneScale.x, 0)
						BoneScale.y = Lerp(FrameTime() * 0.35, BoneScale.y, 0)
						BoneScale.z = Lerp(FrameTime() * 0.35, BoneScale.z, 0)
					else
						BoneScale.x = Lerp(FrameTime() / 15, BoneScale.x, BoneScale.x - 150)
						BoneScale.y = Lerp(FrameTime() / 15, BoneScale.y, BoneScale.y - 150)
						BoneScale.z = Lerp(FrameTime() / 15, BoneScale.z, BoneScale.z -75)
					end
					
					local RealPos = Vector(Pos.x + BoneScale.x, Pos.y + BoneScale.y, Pos.z + BoneScale.z)
					
					matrix:Translate(BoneScale)
					vm:SetBoneMatrix( Bone, matrix )
				end
			end
		end
	end
	*/
end
