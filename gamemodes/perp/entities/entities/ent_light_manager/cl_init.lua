
include('shared.lua')

local matLight 		= Material( "sprites/light_ignorez" )

ENT.RenderGroup 	= RENDERGROUP_BOTH

function ENT:Draw ( ) 
	self.lastDraw = CurTime() + 0.1
	self:DrawTranslucent()
end

function ENT:Think ( )
	if (!self.lastDraw || self.lastDraw < CurTime()) then
		self:DrawTranslucent()
	end
end

function ENT:DrawTranslucent ( )
	if (!self.ourParent) then
		local closestDist = 10000;
		local closet;
		
		for k, v in pairs(ents.FindByClass("prop_vehicle_jeep")) do
			local dist = v:GetPos():Distance(self:GetPos());
			if (dist < closestDist) then
				closest = v;
				closestDist = dist;
			end
		end
				
		if (!closest) then return; end
		
		self.ourParent = closest;
		
		local vT = lookForVT(self.ourParent);
		self.vehicleTable = vT;
		
		if (self.vehicleTable.SirenNoise) then
			self.sirenNoise = CreateSound(self.ourParent, self.vehicleTable.SirenNoise);
			self.sirenNoise_Duration = SoundDuration(self.vehicleTable.SirenNoise) * .98;
		end
		
		if (self.vehicleTable.SirenNoise_Alt) then
			self.sirenNoise_Alt = CreateSound(self.ourParent, self.vehicleTable.SirenNoise_Alt);
			self.sirenNoise_Alt_Duration = SoundDuration(self.vehicleTable.SirenNoise_Alt) * .98;
		end
	end
	
	if (!self.ourParent || !IsValid(self.ourParent)) then return; end
	
	local percChange = 1;
	local percChange_Siren = 1;
	if (GAMEMODE.CurrentTime > NOON) then
		// Past noon - look for sunset
		if (GAMEMODE.CurrentTime < DUSK_START) then
			percChange = .25;
			percChange_Siren = 0.5
		elseif (GAMEMODE.CurrentTime < DUSK_END) then
			PercentOf = (GAMEMODE.CurrentTime - DUSK_START) / (DUSK_END - DUSK_START);
			percChange = .25 + (.75 * PercentOf);
			percChange_Siren = .5 + (.5 * PercentOf);
		end
	else
		// Pre-noon - look for sunrise
		if (GAMEMODE.CurrentTime > DAWN_END) then
			percChange = .25;
			percChange_Siren = .5;
		elseif (GAMEMODE.CurrentTime > DAWN_START) then
			PercentOf = (GAMEMODE.CurrentTime - DAWN_START) / (DAWN_END - DAWN_START);
			percChange = 1 - (.75 * PercentOf);
			percChange_Siren = 1 - (.5 * PercentOf);
		end
	end
	
	if (self.ourParent:GetNetworkedBool("hl", false)) then
		self:DrawHeadlights(percChange);
	end
	
	if (!self.vehicleTable || !self.vehicleTable.RequiredClass) then return; end
		
	if (self.ourParent:GetNetworkedBool("siren", false)) then
		if (self.ourParent:GetNetworkedBool("siren_loud", false)) then
			if (self.LastSirenPlay) then
				self.sirenNoise:Stop();
				self.LastSirenPlay = nil;
			end
			
			if (!self.LastSirenPlay_Alt || self.LastSirenPlay_Alt <= CurTime()) then
				self.LastSirenPlay_Alt = CurTime() + self.sirenNoise_Alt_Duration;
				self.sirenNoise_Alt:Stop();
				self.sirenNoise_Alt:Play();
			end
		else
			if (self.LastSirenPlay_Alt) then
				self.sirenNoise_Alt:Stop();
				self.LastSirenPlay_Alt = nil;
			end
			
			if (!self.LastSirenPlay || self.LastSirenPlay <= CurTime()) then
				self.LastSirenPlay = CurTime() + self.sirenNoise_Duration;
				self.sirenNoise:Stop();
				self.sirenNoise:Play();
			end
		end
	elseif (self.LastSirenPlay) then
		self.sirenNoise:Stop();
		self.LastSirenPlay = nil;
	elseif (self.LastSirenPlay_Alt) then
		self.sirenNoise_Alt:Stop();
		self.LastSirenPlay_Alt = nil;
	end
	
	if (self.ourParent:GetNetworkedBool("slights", false)) then
		self.curSlight = 0
		if (table.Count(self.vehicleTable.SirenColors) == 2) then
			self:DrawDualSiren(percChange_Siren)
		else
			self:DrawMultiSiren(percChange_Siren)
		end
	end
end

function ENT:DrawMultiSiren ( percChange )
	local numPhases = math.ceil(table.Count(self.vehicleTable.SirenColors) / 2)
	local timePerPhase = 0.5 / numPhases
	
	local curPhase = math.ceil((CurTime() - math.floor(CurTime())) / timePerPhase)
	
	if (curPhase > numPhases) then	
		curPhase = curPhase - numPhases
	end
	
	local lightStart = curPhase * 2
	
	for curLight = lightStart - 1, lightStart do
		if (self.vehicleTable.SirenColors[curLight]) then
			self:DrawSirenSprite(self.vehicleTable.SirenColors[curLight][2], self.vehicleTable.SirenColors[curLight][1], percChange)
		end
	end
end

function ENT:DrawSirenSprite ( pos, col, percChange )
	self.curSlight = self.curSlight + 1
	local truePos = self.ourParent:LocalToWorld(pos + Vector(0, 0, 5))
		
	if (!self.PixVis["SLights" .. self.curSlight]) then
		self.PixVis["SLights" .. self.curSlight] = util.GetPixelVisibleHandle();
	end
	
	local trueAng = Angle(90, -90, 0) + self.ourParent:GetAngles();
	
	local LightNrm = trueAng:Up()
	local ViewNormal = truePos - EyePos()
	local Distance = ViewNormal:Length()
	ViewNormal:Normalize()
	local ViewDot = ViewNormal:Dot( LightNrm )
	local LightPos = truePos + ViewNormal * -6
	
	local visCheck = util.PixelVisible(LightPos, 32, self.PixVis["SLights" .. self.curSlight])
	
	if (!visCheck || visCheck == 0) then return end
		
	render.SetMaterial( matLight )
	local Size = math.Clamp(Distance * visCheck * 2, 32, 256) * percChange
	
	Distance = math.Clamp(Distance, 32, 800);
	local Alpha = math.Clamp(math.Clamp((1000 - Distance) * visCheck, 0, 75) * percChange, 0, 255);
	
	render.DrawSprite(LightPos, Size, Size, Color(col.r, col.g, col.b, Alpha), visCheck)
	
	/*
	local dlight = DynamicLight( self.ourParent:EntIndex() )
	if ( dlight ) then
		dlight.Pos = LightPos;
		dlight.r = col.r
		dlight.g = col.g
		dlight.b = col.b
		dlight.Brightness = 15 * percChange
		dlight.Decay = 1500
		dlight.Size = 256
		dlight.DieTime = CurTime() + 0.05
	end
	*/
			
	local dlight = DynamicLight( self.ourParent:EntIndex() )
	if ( dlight ) then
		dlight.Pos = LightPos;
		dlight.r = col.r
		dlight.g = col.g
		dlight.b = col.b
		dlight.Brightness = 5 * percChange
		dlight.Decay = 256
		dlight.Size = 512
		dlight.DieTime = CurTime() + 0.05
	end
end

function ENT:DrawDualSiren ( percChange )
	local shouldBeOn_1, shouldBeOn_2;
			
	local shouldBeOn_C = math.sin(CurTime() * 8);
	if (shouldBeOn_C > .4 && shouldBeOn_C < .85) then
		shouldBeOn_1 = true;
	elseif (shouldBeOn_C > -0.85 && shouldBeOn_C < -0.4) then
		shouldBeOn_2 = true;
	end
			
	local curLight = 3;
	if (shouldBeOn_1) then curLight = 1; end
	if (shouldBeOn_2) then curLight = 2; end
	
	if (curLight != 3) then
		self:DrawSirenSprite(self.vehicleTable.SirenColors[curLight][2], self.vehicleTable.SirenColors[curLight][1], percChange)
	end
end

function ENT:DrawHeadlights ( percChange )	
	local parentTable = lookForVT(self.ourParent);
	
	if (!parentTable.HeadlightPositions) then return; end
	
	for k, v in pairs(parentTable.HeadlightPositions) do
		if (self.ourParent:GetNetworkedInt("fl", 0) == 0 || self.ourParent:GetNetworkedInt("fl", 0) == k) then
			local truePos = self.ourParent:LocalToWorld(Vector(v[1].x, v[1].y, v[1].z));
			local trueAng = Angle(0, v[2].y, v[2].r) - Angle(-90, 90, 0) + self.ourParent:GetAngles();
					
			local LightNrm = trueAng:Up()
			local ViewNormal = truePos - EyePos()
			local Distance = ViewNormal:Length()
			ViewNormal:Normalize()
			local ViewDot = ViewNormal:Dot( LightNrm )
			local LightPos = truePos + ViewNormal * -6

			if ( ViewDot >= 0 ) then
				render.SetMaterial( matLight )
				
				if (!self.PixVis["H" .. tostring(k)]) then
					self.PixVis["H" .. tostring(k)] = util.GetPixelVisibleHandle();
				end
				
				local Visibile	= util.PixelVisible(LightPos, 16, self.PixVis["H" .. tostring(k)])	
				if (!Visibile) then return end
				
				local Size = math.Clamp(Distance * Visibile * ViewDot * 2, 64, 512) * percChange
				
				Distance = math.Clamp(Distance, 32, 800);
				local Alpha = math.Clamp((1000 - Distance) * Visibile * ViewDot, 0, 100) * percChange;
				local oc = self:GetColor();
				local Col = Color(oc.r, oc.g, oc.b, Alpha);
				
				render.DrawSprite(LightPos, Size, Size, Col, Visibile * ViewDot)
				render.DrawSprite(LightPos, Size * 0.4, Size * 0.4, Col, Visibile * ViewDot);
			end
		end
	end
end

function ENT:Initialize ( )	
	self:SetNotSolid(true);
	self:DrawShadow(false);
	
	self.PixVis = {};
end
