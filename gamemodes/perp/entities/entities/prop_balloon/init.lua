
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

local MODEL = Model( "models/dav0r/balloon/balloon.mdl" )

/*---------------------------------------------------------
   Name: Initialize
---------------------------------------------------------*/
function ENT:Initialize()

	// Use the helibomb model just for the shadow (because it's about the same size)
	self.Entity:SetModel( MODEL )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	
	// Set up our physics object here
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
	
		phys:SetMass( 100 )
		phys:Wake()
		phys:EnableGravity( false )
		
	end
	
	self:SetForce( 1 )
	self.Entity:StartMotionController()
	
	self.DieTime = CurTime() + 60 * 5;
	
end

/*---------------------------------------------------------
   Name: SetForce
---------------------------------------------------------*/
function ENT:SetForce( force )
	self.Force = force * 5000
end


/*---------------------------------------------------------
   Name: OnTakeDamage
---------------------------------------------------------*/
function ENT:OnTakeDamage( dmginfo )

	if (self.Entity:GetTable().Indestructible) then 
		return 
	end
	
	local r, g, b = self.Entity:GetColor()
	
	local effectdata = EffectData()
		effectdata:SetOrigin( self.Entity:GetPos() )
		effectdata:SetStart( Vector( r, g, b ) )
	util.Effect( "perp_balloon_pop", effectdata )
	
	self.Entity:Remove()
	
end


/*---------------------------------------------------------
   Name: Simulate
---------------------------------------------------------*/
function ENT:PhysicsSimulate( phys, deltatime )

	local Force = self.Force;
	
	if self.DieTime - 60 < CurTime() then
		Perc = 1 - (CurTime() / self.DieTime);
		Force = (Force * Perc) - 100;
	end

	local vLinear = Vector( 0, 0, Force ) * deltatime
	local vAngular = Vector( 0, 0, 0 )

	return vAngular, vLinear, SIM_GLOBAL_FORCE
	
end


/*---------------------------------------------------------
   Name: OnRestore
---------------------------------------------------------*/
function ENT:OnRestore( )

	self.Force = self.Entity:GetNetworkedFloat( 0 )
	
end

function ENT:Think ( )
	if self.DieTime < CurTime() then
		self:TakeDamage(100);
	end
end
