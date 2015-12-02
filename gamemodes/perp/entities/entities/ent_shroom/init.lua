
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')
local FullGrowthTime = 360
local MakeBrown = 720;
local StartFade = 780;
local FullDeath = 840;
local Distance = 50;

function ENT:Initialize()
	self.Entity:SetModel("models/fungi/sta_skyboxshroom1.mdl");

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self.Entity:SetAngles(Angle(0, math.random(1, 360), 0));
	
	self.SpawnTime = CurTime();
	self.Position = self:GetPos();
	self.Entity:GetTable().Tapped = false;
end

function ENT:Spore ( )
	if math.random(1, 3) == 3 then return false; end
	
	local NearbyMushrooms = 0;
	for k, v in pairs(ents.FindInSphere(self:GetPos(), Distance * 4)) do
		if v:GetClass() == 'ent_shroom' then
			NearbyMushrooms = NearbyMushrooms + 1;
		end
	end
	
	if NearbyMushrooms >= 15 then return false; end
	
	for i = 1, 25 do
		local RandomStart = self:GetPos() + Vector(math.Rand(-1, 1) * Distance, math.Rand(-1, 1) * Distance, 50);
		local UsStart = self:GetPos() + Vector(0, 0, 10);
		
		// trace to the random spot from us
		local Trace = {};
		Trace.start = UsStart;
		Trace.endpos = RandomStart;
		Trace.filter = self.Entity;
		Trace.mask = MASK_OPAQUE;
		
		local TR1 = util.TraceLine(Trace);
		
		// trace back to make sure theres nothing there
			
		local Trace2 = {};
		Trace2.start = RandomStart;
		Trace2.endpos = UsStart;
		Trace2.filter = self.Entity;
		Trace2.mask = MASK_OPAQUE;
			
		local TR2 = util.TraceLine(Trace2);
		
		if (TR1.Hit and TR2.Hit) or (!TR1.Hit and !TR2.Hit) then
			// trace down to make sure it's not a sheer cliff, or the like
			
			local TrStart = RandomStart;
			local TrEnd = TrStart - Vector(0, 0, 100);
			
			local Trace = {};
			Trace.start = TrStart;
			Trace.endpos = TrEnd;
			Trace.filter = self.Entity;
				
			local TraceResults = util.TraceLine(Trace);
				
			if TraceResults.HitWorld then
				if util.IsInWorld(TraceResults.HitPos) then				
					if TraceResults.MatType == MAT_DIRT then

						local NearbyEnts = ents.FindInSphere(TraceResults.HitPos, 25);
							
						local NearShroom = false;
						for k, v in pairs(NearbyEnts) do
							if v:GetClass() == 'ent_shroom' then
								NearShroom = true;
							end
						end
						
						if !NearShroom then
							local Trace = {};
							Trace.start = TraceResults.HitPos;
							Trace.endpos = TraceResults.HitPos + Vector(0, 0, 250)
							Trace.mask = MASK_VISIBLE;
							
							local TR = util.TraceLine(Trace);
							
							if !TR.HitWorld then
								local Shroom = ents.Create('ent_shroom');
								Shroom:SetPos(TraceResults.HitPos);
								Shroom:Spawn();
								if self:GetTable().ItemSpawner then Shroom:GetTable().ItemSpawner = self:GetTable().ItemSpawner; end
								
								break;
							end
						end
					end
				end
			end
		end
	end
end

function ENT:Think ( )
	if self.SpawnTime + FullDeath < CurTime() then
		self:Remove();
	elseif !self.FirstSpore and self.SpawnTime + FullGrowthTime + ((MakeBrown - FullGrowthTime) * .5) < CurTime() then
		self:Spore();
		self.FirstSpore = true;
	elseif !self.SecondSpore and self.SpawnTime + MakeBrown < CurTime() then
		self:Spore();
		self.SecondSpore = true;
	end
end

function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	if self.Entity:GetTable().Tapped then return false; end
	
	if activator:Team() == TEAM_POLICE then
		self.Entity:GetTable().Tapped = true;
		
		activator:AddCash(GAMEMODE.CopReward_Shrooms);
		activator:PrintMessage(HUD_PRINTTALK, "You have been rewarded $" .. GAMEMODE.CopReward_Shrooms .. " for destroying magic mushrooms.");
		self:Remove();
		return false;
	end
	
	if self.SpawnTime + FullGrowthTime < CurTime() and self.SpawnTime + MakeBrown > CurTime() then
		self.Entity:GetTable().Tapped = true;
		
		activator:GiveItem(83, 1, true);
		self:Remove();
	end
end
