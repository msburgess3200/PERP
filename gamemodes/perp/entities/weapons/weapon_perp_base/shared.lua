if (SERVER) then
	AddCSLuaFile("shared.lua");
	SWEP.Weight				= 5;
	SWEP.AutoSwitchTo		= false;
	SWEP.AutoSwitchFrom		= false;
else
	SWEP.DrawAmmo			= false;
	SWEP.DrawCrosshair		= false;
	SWEP.ViewModelFOV		= 82;
	SWEP.ViewModelFlip		= true;
	SWEP.CSMuzzleFlashes	= true;
	

end

SWEP.Author			= "RedMist";
SWEP.Contact		= "http://www.underscoregaming.net/";
SWEP.Purpose		= "Remove enemies from play.";
SWEP.Instructions	= "Point, click, enjoy.";

SWEP.Spawnable			= false;
SWEP.AdminSpawnable		= false;

SWEP.Primary.Sound			= Sound("Weapon_AK47.Single");
SWEP.Primary.Recoil			= 1.5;
SWEP.Primary.Damage			= 40;
SWEP.Primary.NumShots		= 1;
SWEP.Primary.Cone			= 0.02;
SWEP.Primary.Delay			= 0.15;

SWEP.Primary.ClipSize		= -1;
SWEP.Primary.DefaultClip	= -1;
SWEP.Primary.Automatic		= false;
SWEP.Primary.Ammo			= "none";

SWEP.Secondary.ClipSize		= -1;
SWEP.Secondary.DefaultClip	= -1;
SWEP.Secondary.Automatic	= false;
SWEP.Secondary.Ammo			= "none";

SWEP.TracerRarity = 4;
SWEP.MaxPenetration = 4000;
SWEP.MaxPenetration_Depth = 25;

function SWEP:Initialize ( )
	if (SERVER) then
		timer.Simple(0, function ( ) if IsValid(self) then self:Holster(); end end);
	end
	
	self:SetWeaponHoldType(self.HoldTypeNorm);
	
	self:SetIronsights(false);
	self.bulletNumber = 0;
end

function SWEP:Reload ( )
	self:DefaultReload(ACT_VM_RELOAD);
	self:SetIronsights(false);
end

function SWEP:Think ( )
	if SERVER and self.GunModel and IsValid(self.GunModel) then
		self:CleanupGunModel();
	end
end

local function gunSound ( UMsg )
	local ent = UMsg:ReadEntity();
	sound.Play(ent.Primary.Sound, ent:GetPos());
end
usermessage.Hook("gs", gunSound);

function SWEP:PrimaryAttack ( )
	if (!self:CanPrimaryAttack()) then return end
	if (!self.Weapon:GetNetworkedBool("Ironsights", false)) then return end
	
	self:SetNextSecondaryFire(CurTime() + self.Primary.Delay);
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay);
	
	//if (string.find(self.Primary.Sound, "perp2")) then
		if SERVER then
			local pvs = RecipientFilter();
			
			for _, each in pairs(player.GetAll()) do
				if (each != self.Owner && each:GetPos():Distance(self.Owner:GetPos()) < 1000) then
					pvs:AddPlayer(each)
				end
			end
			
			umsg.Start("gs", pvs);
				umsg.Entity(self);
			umsg.End();
			
			if (self.GrantExperience_Skill) then
				self.Owner:GiveExperience(self.GrantExperience_Skill, self.GrantExperience_Exp, true);
			end
		elseif (!self.lastShootSound || self.lastShootSound < CurTime()) then
			self.lastShootSound = CurTime() + (self.Primary.Delay * 0.9)
			sound.Play(self.Primary.Sound, self:GetPos());
			
			if (self.GrantExperience_Skill) then
				self.Owner:GiveExperience(self.GrantExperience_Skill, self.GrantExperience_Exp, true);
			end
		end
	/*else
		self:EmitSound(self.Primary.Sound);
	end*/
	
	self:CSShootBullet(self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone, nil, nil, nil, nil, true);
	
	self:TakePrimaryAmmo(1);
	
	if (self.Owner:IsNPC()) then return end
	
	self.Owner:ViewPunch(Angle(math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0));
	
	if  (SERVER) || (CLIENT) then
		self:SetNetworkedFloat( "LastShootTime", CurTime() )
	end
end

SWEP.NextSecondaryAttack = 0
function SWEP:SecondaryAttack ( )
	if (!self.IronSightsPos) then return end
	if (self.NextSecondaryAttack > CurTime()) then return end
	
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay);
	
	self:SetIronsights(!self.Weapon:GetNetworkedBool("Ironsights", false));
	
	self.NextSecondaryAttack = CurTime() + 0.3;
end

local function setHoldType ( UMsg )
	local ent = UMsg:ReadEntity()
	local holdType = UMsg:ReadString()
	
	if (!ent || !ent:IsValid() || !ent.SetWeaponHoldType) then return end
	
	ent:SetWeaponHoldType(holdType)
end
usermessage.Hook("perp_wep_sethold", setHoldType)

function SWEP:SetIronsights ( b )
	self.Weapon:SetNetworkedBool("Ironsights", b);
	
	if SERVER then
		if b then
			self:SetWeaponHoldType(self.HoldType);
			
			umsg.Start("perp_wep_sethold")
				umsg.Entity(self)
				umsg.String(self.HoldType)
			umsg.End()
		else
			self:SetWeaponHoldType(self.HoldTypeNorm);
			
			umsg.Start("perp_wep_sethold")
				umsg.Entity(self)
				umsg.String(self.HoldTypeNorm)
			umsg.End()
		end
	end
end

local function randSign ( )
	while true do
		local rand = math.random(-1, 1);
		
		if (rand != 0) then
			return rand;
		end
	end
end

function SWEP:CSShootBullet( dmg, recoil, numbul, cone, fireFrom, aimVector, distanceLeft, showTracerOverride, orig )
	numbul 	= numbul 	or 1
	cone 	= cone 		or 0.01
	distanceLeft = distanceLeft or self.MaxPenetration;
	fireFrom = fireFrom or self.Owner:GetShootPos()
	aimVector = aimVector or self.Owner:GetAimVector()

	for i = 1, numbul do
		local showTracer = showTracerOverride or 0;
		
		if (!showTracerOverride) then
			self.bulletNumber = self.bulletNumber + 1;
			
			if (self.bulletNumber == self.TracerRarity) then
				self.bulletNumber = 0;
				showTracer = 1;
			end
		end
		
		local realSpread = Vector(0, 0, 0);
		
		if (cone != 0) then
			realSpread = Vector(math.random() * cone * randSign(), math.random() * cone * randSign(), math.random() * cone * randSign());
		end
		
		local trueAim = aimVector + realSpread;
		local trace = {};
		trace.start = fireFrom;
		trace.endpos = trace.start + (trueAim * 1000000);
		
		local traceRes = util.TraceLine(trace);
		local dir = (traceRes.HitPos - trace.start):Normalize();
		local hitPosition = traceRes.HitPos;
		
		local bullet = {}
		bullet.Num 		= 1
		bullet.Src 		= fireFrom								// Source
		bullet.Dir 		= self.Owner:GetAimVector()				// Dir of bullet
		bullet.Spread 	= Vector(0, 0, 0)						// Aim Cone
		bullet.Tracer	= showTracer							// Show a tracer on every x bullets 
		bullet.Force	= 8										// Amount of force to give to phys objects
		bullet.Damage	= dmg
		
		
		self.Owner:FireBullets(bullet)
		
		if (SERVER && traceRes.Entity && traceRes.Entity:GetClass() == "prop_vehicle_jeep" && traceRes.Entity:GetTable().CarDamage) then
			if (traceRes.Entity:GetModel() != "models/swatvan2.mdl") then
				traceRes.Entity:GetTable().CarDamage = traceRes.Entity:GetTable().CarDamage - (dmg * .5);
					
				if traceRes.Entity:GetTable().CarDamage <= 0 then
					traceRes.Entity:DisableVehicle();
				end
					
				local Driver = traceRes.Entity:GetDriver();
					
				if Driver and Driver:IsValid() and Driver:IsPlayer() then
					local NewHealth = Driver:Health() - (dmg * .4);
						
					if NewHealth <= 0 then
						Driver:Kill();
					else
						Driver:SetHealth(NewHealth);
						Driver:GetTable().OnEnteredHealth = NewHealth;
					end
				end
			end
		else
			if (CLIENT && orig) then				
				for k, v in pairs(player.GetAll()) do
					if (!v:Alive()) then
						local playerRagdoll = v:GetRagdollEntity()
						
						if (playerRagdoll) then
							for _, ent in pairs(ents.FindInSphere(traceRes.HitPos, 5)) do						
								if ent == playerRagdoll then
									RunConsoleCommand('perp_m_k', v:UniqueID());
								end
							end
						end
					end
				end
			end
			
			distanceLeft = distanceLeft - hitPosition:Distance(fireFrom);
			
			if (distanceLeft > 0 && (!traceRes.Entity || !IsValid(traceRes.Entity) || !traceRes.Entity:IsPlayer())) then
				for i = 1, self.MaxPenetration_Depth do
					if (distanceLeft < (i * 1000)) then break; else
						local testPos = hitPosition + (trueAim * i * 5);
						
						if (util.IsInWorld(testPos)) then
							self:CSShootBullet(dmg * .75, recoil, 1, 0, testPos, aimVector, distanceLeft - (i * 1000), showTracer);
							self:CSShootBullet(dmg * .75, recoil, 1, 0, testPos + (trueAim * 5), aimVector * -1, -100, showTracer);
							
							break
						end
					end
				end
			end
		end
	end
	self.Weapon:SendWeaponAnim(ACT_VM_PRIMARYATTACK); 		// View model animation
	self.Owner:MuzzleFlash();								// Crappy muzzle light
	self.Owner:SetAnimation(PLAYER_ATTACK1);				// 3rd Person Animation
	
	
	
	if ( self.Owner:IsNPC() ) then return end
	
	// CUSTOM RECOIL !
	if (!showTracerOverride && SERVER) || (CLIENT && IsFirstTimePredicted() ) then
	
		local eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - recoil
		self.Owner:SetEyeAngles( eyeang )
	
	end
	
end

local IRONSIGHT_TIME = 0.15
function SWEP:GetViewModelPosition ( pos, ang )

	if ( !self.IronSightsPos ) then return pos, ang end

	local bIron = self.Weapon:GetNetworkedBool( "Ironsights" )
	
	if ( bIron != self.bLastIron ) then
	
		self.bLastIron = bIron 
		self.fIronTime = CurTime()
		
		if ( bIron ) then 
			self.SwayScale 	= 0.3
			self.BobScale 	= 0.1
		else 
			self.SwayScale 	= 1.0
			self.BobScale 	= 1.0
		end
	
	end
	
	local fIronTime = self.fIronTime or 0
	
	local Right 	= ang:Right()
	local Up 		= ang:Up()
	local Forward 	= ang:Forward()
	
	local Mul = 1.0

	if ( !bIron && fIronTime < CurTime() - IRONSIGHT_TIME ) then
		if self.NormalAng then
			ang = ang * 1
			ang:RotateAroundAxis( ang:Right(), 		self.NormalAng.x * Mul )
			ang:RotateAroundAxis( ang:Up(), 		self.NormalAng.y * Mul )
			ang:RotateAroundAxis( ang:Forward(), 	self.NormalAng.z * Mul )
		end
		
		if self.NormalPos then
			pos = pos + self.NormalPos.x * Right * Mul
			pos = pos + self.NormalPos.y * Forward * Mul
			pos = pos + self.NormalPos.z * Up * Mul
		end
	
		return pos, ang;
	end
	
	if ( fIronTime > CurTime() - IRONSIGHT_TIME ) then
	
		Mul = math.Clamp( (CurTime() - fIronTime) / IRONSIGHT_TIME, 0, 1 )
		
		if (!bIron) then Mul = 1 - Mul end
	
	end

	local Offset	= self.IronSightsPos
	
	if ( self.IronSightsAng ) then
	
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.IronSightsAng.x * Mul )
		ang:RotateAroundAxis( ang:Up(), 		self.IronSightsAng.y * Mul )
		ang:RotateAroundAxis( ang:Forward(), 	self.IronSightsAng.z * Mul )
	
	end
	
	if self.NormalAng then
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		self.NormalAng.x * (1 - Mul) )
		ang:RotateAroundAxis( ang:Up(), 		self.NormalAng.y * (1 - Mul) )
		ang:RotateAroundAxis( ang:Forward(), 	self.NormalAng.z * (1 - Mul) )
	end

	pos = pos + Offset.x * Right * Mul
	pos = pos + Offset.y * Forward * Mul
	pos = pos + Offset.z * Up * Mul
	
	if self.NormalPos then
		pos = pos + self.NormalPos.x * Right * (1 - Mul)
		pos = pos + self.NormalPos.y * Forward * (1 - Mul)
		pos = pos + self.NormalPos.z * Up * (1 - Mul)
	end

	return pos, ang
	
end

function SWEP:DrawHUD ( ) end

function SWEP:OnRestore()
	self.NextSecondaryAttack = 0
	self:SetIronsights(false);
end

function SWEP:Holster ( )
	if SERVER && self.BackHolster then
		self.GunModel = ents.Create("prop_back_gun");
		self.GunModel:SetModel(self.WorldModel);
		self.GunModel:SetPos(self.Owner:GetPos() + self.Owner:GetForward() * 10 + self.Owner:GetUp() * 30);
		self.GunModel:SetAngles(self.Owner:GetAngles() + Angle(90, 0, 0));
		self.GunModel:SetNetworkedEntity("o", self.Owner);
		self.GunModel:SetParent(self.Owner);
		self.GunModel:Spawn();
	end

	return true;
end

function SWEP:CleanupGunModel ( )
	if IsValid(self.GunModel) then self.GunModel:Remove() end
end

function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
	draw.SimpleText( self.IconLetter, "CSSelectIcons", x + wide/2, y + tall*0.2, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )
end