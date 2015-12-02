
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
	end
	
	if (!self.ourParent || !IsValid(self.ourParent)) then return; end
	
	local decel = false;
	if (self.ourParent:GetNetworkedEntity("owner") && IsValid(self.ourParent:GetNetworkedEntity("owner")) && self.ourParent:GetNetworkedEntity("owner") == LocalPlayer()) then
		if (LocalPlayer():InVehicle() && LocalPlayer():GetVehicle() == self.ourParent) then
			decel = LocalPlayer():KeyDown(IN_JUMP);
		end
	elseif (self.ourParent) then
		self.lastParentSpeed = self.lastParentSpeed or 0;
		local cSpeed = self.ourParent:GetVelocity():Length();
		
		if (cSpeed < self.lastParentSpeed - 2) then
			decel = true;
		end
		
		self.lastParentSpeed = cSpeed;
	end
	
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
	
	if (self.ourParent:GetNetworkedBool("hl", false) || decel) then
		self:DrawTaillights(decel, percChange);
	end
end

function ENT:DrawTaillights ( decel, percChange )
	local parentTable = lookForVT(self.ourParent);
	
	if (!parentTable.HeadlightPositions) then return; end
	
	for k, v in pairs(parentTable.TaillightPositions) do
		if (self.ourParent:GetNetworkedInt("fl", 0) == 0 || self.ourParent:GetNetworkedInt("fl", 0) == k || decel) then
			local truePos = self.ourParent:LocalToWorld(Vector(v[1].x, v[1].y, v[1].z));
			local trueAng =  Angle(0, v[2].y, v[2].r) - Angle(-90, 90, 0) + self.ourParent:GetAngles();
					
			local LightNrm = trueAng:Up()
			local ViewNormal = truePos - EyePos()
			local Distance = ViewNormal:Length()
			ViewNormal:Normalize()
			local ViewDot = ViewNormal:Dot( LightNrm )
			local LightPos = truePos + ViewNormal * 6

			if ( ViewDot >= 0 ) then
				render.SetMaterial( matLight )
				
				if (!self.PixVis["T" .. tostring(k)]) then
					self.PixVis["T" .. tostring(k)] = util.GetPixelVisibleHandle();
				end
				
				local Visibile	= util.PixelVisible(LightPos, 16, self.PixVis["T" .. tostring(k)])	
				if (!Visibile) then return end
				
				local Size = math.Clamp(Distance * Visibile * ViewDot * 2, 32, 256) * percChange
				
				Distance = math.Clamp(Distance, 32, 800);
				local Alpha = math.Clamp((1000 - Distance) * Visibile * ViewDot, 0, 100) * percChange;
				
				if (!decel) then
					Alpha = Alpha * .25;
				end
				
				local Col = Color(255, 0, 0, Alpha);
				
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
