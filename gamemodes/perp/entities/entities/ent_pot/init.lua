
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

function ENT:Initialize()
	self.Entity:SetModel("models/props_c17/pottery06a.mdl");

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	self.Entity:SetAngles(Angle(0, math.random(1, 360), 0));
	
	self.SpawnTime = CurTime();
	
	self.OurLeaves = ents.Create('ent_pot_leaf');
	
	local OurHeight = self:LocalToWorld(self:OBBMaxs()).z;
	local OurPos = self:LocalToWorld(self:OBBCenter());
	
	self.OurLeaves:SetPos(Vector(OurPos.x, OurPos.y, OurHeight - 2));
	self.OurLeaves:SetParent(self);
	self.OurLeaves:Spawn();
	
	self.Entity:GetPhysicsObject():Wake();
end

function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	if self.Entity:GetTable().Tapped then return false; end
	
	if activator:Team() == TEAM_POLICE || activator:Team() == TEAM_SWAT then
		self.Entity:GetTable().Tapped = true;
		activator:GiveCash(GAMEMODE.CopReward_Arrest);
		activator:PrintMessage(HUD_PRINTTALK, "You have been rewarded $" .. GAMEMODE.CopReward_Arrest .. " for destroying marijuana.");
		self:Remove();
	elseif (activator:Team() != TEAM_CITIZEN) then
		
	elseif self.SpawnTime + POT_GROW_TIME < CurTime() then		
		self.Entity:GetTable().Tapped = true;
		
		local NearLamp
		local roll
		local sroll
		
		/*
		for k, ent in pairs(ents.FindInSphere(self:GetPos(), 100)) do
			if ent:GetClass() != "prop_lamp_spot" then return; end
			if ent:IsValid() then
				NearLamp = true;
			else
				NearLamp = false;
			end
		end
		*/
		
		if NearLamp then
			roll = math.random(5, 8);
			sroll = math.random(1, 3);
		else
			roll = math.random(2, 6);
			sroll = math.random(0, 2);
		end
		
		activator:GiveItem(13, roll, true);
		
		if (sroll != 0) then
			activator:GiveItem(14, sroll, true);
		end
		
		local Pos = self:GetPos();
		local Ang = self:GetAngles();
		self:Remove();
		
		local ent = ents.Create("ent_item");
			ent:SetContents(15, self:GetTable().ItemSpawner);
			ent:SetPos(Pos);
			ent:SetAngles(Ang);
			ent:SetModel("models/props_c17/pottery06a.mdl");
		ent:Spawn();
	elseif self.SpawnTime + POT_GROW_TIME * .5 < CurTime() then		
		self.Entity:GetTable().Tapped = true;
		local roll = math.random(0, 3);
		
		if roll == 0 then
			activator:Notify("You nearly salvaged some, but you picked too early to get any usable marijuana.");
		else
			activator:Notify("You picked too early for any seeds to be found, but some marijuana was usable.");
		end
		
		activator:GiveItem(13, roll, true);
		
		local Pos = self:GetPos();
		local Ang = self:GetAngles();
		self:Remove();
		
		local ent = ents.Create("ent_item");
			ent:SetContents(15, self:GetTable().ItemSpawner);
			ent:SetPos(Pos);
			ent:SetAngles(Ang);
			ent:SetModel("models/props_c17/pottery06a.mdl");
		ent:Spawn();
	end
end

