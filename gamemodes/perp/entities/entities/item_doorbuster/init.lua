
AddCSLuaFile("shared.lua");
include("shared.lua");

function ENT:Initialize()
	self.Entity:SetModel("models/Items/car_battery01.mdl")
	self.Entity:PhysicsInit(SOLID_VPHYSICS);
	self.Entity:SetMoveType(MOVETYPE_VPHYSICS);
	self.Entity:SetSolid(SOLID_VPHYSICS);
	
	self.Damage = math.random(80, 150)
	
	for i=1, 20 do
		timer.Simple(i, self.Entity.Beep, self.Entity, 100);
	end
	timer.Simple(21, self.Entity.Beep, self.Entity, 110);
	timer.Simple(22, self.Entity.Beep, self.Entity, 120);
	timer.Simple(23, self.Entity.Beep, self.Entity, 130);
	timer.Simple(24, self.Entity.Beep, self.Entity, 140);
	timer.Simple(25, self.Entity.Beep, self.Entity, 150);
	timer.Simple(26, self.Entity.Beep, self.Entity, 160);
	timer.Simple(27, self.Entity.Beep, self.Entity, 170);
	timer.Simple(28, self.Entity.Beep, self.Entity, 180);
	timer.Simple(29, self.Entity.Beep, self.Entity, 190);
	timer.Simple(29.2, self.Entity.Beep, self.Entity, 190);
	timer.Simple(29.4, self.Entity.Beep, self.Entity, 190);
	timer.Simple(30, self.Entity.DestroyDoors, self.Entity);
	
	  
	local phys = self.Entity:GetPhysicsObject();
	  
	if(phys:IsValid()) then
	  phys:Wake();
	 end
 
end

function ENT:Beep(i)
	if(not IsValid(self.Entity)) then return end
	
	self.Entity:EmitSound("buttons/button17.wav", 100,i or 100)
end

function ENT:DestroyDoors()
	if(not IsValid(self.Entity)) then return end
	
	for k,door in pairs(ents.FindInSphere(self.Entity:GetPos(), 64)) do
		if(door:IsVehicle()) then
			door:DisableVehicle()
		end
		if(door:IsDoor()) then
			if(true) then
				if(ValidEntity(door) and (door:GetClass() == "prop_door_rotating" or door:GetClass() == "func_door_rotating" or door:GetClass() == "func_door")) then
				
					door:Fire("unlock", "", 0);
					door:Fire("open", "", 0);
				
				end
							
			end
			if(ValidEntity(door) and door:GetClass() == "prop_door_rotating") then
			
				door:EmitSound(Sound( "physics/wood/wood_box_impact_hard3.wav"));
				
				if(SERVER) then
	
					local pos = door:GetPos();
					local ang = door:GetAngles();
					local model = door:GetModel();
					local skin = door:GetSkin();
						
					door:SetNotSolid(true);
					door:SetNoDraw(true);
					
					local function ResetDoor(door, fakedoor)
						if(not ValidEntity(door)) then return end
						door:SetNotSolid(false);
						door:SetNoDraw(false);
						door:SetNWInt("nodraw", 0)
						if(not ValidEntity(fakedoor)) then return end
						fakedoor:Remove();
					end
					
					local norm = (pos - self.Entity:GetPos()):Normalize();
					local push = 10000 * norm;
	
					if(door:GetNWInt("nodraw") == 0) then
						local ent = ents.Create("prop_physics_multiplayer");
						ent:SetPos(pos);
						ent:SetAngles(ang);
						ent:SetModel(model);
						if(skin) then
							ent:SetSkin(skin);
						end
						ent:Spawn();
						
					
					timer.Simple(.2, ent.SetVelocity, ent, push);					
					timer.Simple(.2, ent:GetPhysicsObject().ApplyForceCenter, ent:GetPhysicsObject(), push);
																
					timer.Simple(300, ResetDoor, door, ent);
	
					end
					
					door:SetNWInt("nodraw", 1)
					
				end
			end
		end
	end
	util.ScreenShake(self.Entity:GetPos(), 15, 15, 3, 2000)  
	util.BlastDamage(self.Entity, self.Entity, self.Entity:GetPos(), 500, self.Damage)
	self.Entity:EmitExplodeEffect();
	self.Entity:Remove()
end

function ENT:EmitExplodeEffect()
	if(not ValidEntity(self.Entity)) then return end
	
	self.Entity:EmitSound("ambient/explosions/explode_" .. math.random(4) .. ".wav");
	self.Entity:EmitSound("ambient/explosions/explode_" .. math.random(4) .. ".wav");
	self.Entity:EmitSound("ambient/explosions/explode_" .. math.random(4) .. ".wav");
	
	local effectdata = EffectData();
	effectdata:SetStart(self.Entity:GetPos());
	effectdata:SetOrigin(self.Entity:GetPos());
	effectdata:SetScale(1);
	util.Effect("effect_doorbuster", effectdata);
end