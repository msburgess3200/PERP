


function PLAYER:ForceEyeAngles ( NPC )
	self.ForceEyeAnglesObj = NPC
end

local function ControlEyeAngles ( )
	if (LocalPlayer() && IsValid(LocalPlayer()) && IsValid(LocalPlayer().ForceEyeAnglesObj)) then
		LocalPlayer():SetEyeAngles(((LocalPlayer().ForceEyeAnglesObj:GetPos() + Vector(0, 0, 64)) - LocalPlayer():GetShootPos()):Angle());
	end
end
hook.Add("Think", "ControlEyeAngles", ControlEyeAngles);

function PLAYER:ClearForcedEyeAngles ( )
	self.ForceEyeAnglesObj = nil;
end

function PLAYER:HasBuddy ( otherPlayer )
	if (self == otherPlayer) then return true; end

	for k, v in pairs(GAMEMODE.Buddies) do
		if (v[2] && v[2] == tostring(otherPlayer:UniqueID())) then
			return true;
		end
	end
	
	return false;
end

GM.OrganizationData  = {};
GM.OrganizationMembers  = {};
function PLAYER:GetOrganizationName ( )
	if (self:GetUMsgInt("org", 0) == 0) then return nil; end
	
	if (GAMEMODE.OrganizationData[self:GetUMsgInt("org", 0)] && GAMEMODE.OrganizationData[self:GetUMsgInt("org", 0)][1] != "fa") then
		if (GAMEMODE.OrganizationData[self:GetUMsgInt("org", 0)][1] == "f") then
			return nil;
		else
			return GAMEMODE.OrganizationData[self:GetUMsgInt("org", 0)][1];
		end
	end
	
	RunConsoleCommand("perp_srod", self:GetUMsgInt("org", 0));
	GAMEMODE.OrganizationData[self:GetUMsgInt("org", 0)] = {"f"};
	
	return nil;
end

// Source: TetaBonita's Harmless Companion Cube
// Edited to fit needs.
function PLAYER:HasLOS ( Entity )
	local tr = util.TraceLine(
	{
		start 	= self:GetShootPos(),
		endpos 	= Entity:GetPos() + Vector(0, 0, 64),
		filter 	= { Entity, self, self:GetActiveWeapon() },
		mask 	= CONTENTS_SOLID || CONTENTS_OPAQUE || CONTENTS_MOVEABLE
	} )
	
	local tr2 = util.TraceLine(
	{
		start 	= self:GetShootPos(),
		endpos 	= Entity:GetPos(),
		filter 	= { Entity, self, self:GetActiveWeapon() },
		mask 	= CONTENTS_SOLID || CONTENTS_OPAQUE || CONTENTS_MOVEABLE
	} )
	
	if tr.Fraction > 0.98 or tr2.Fraction > 0.98 then return true; end
	return false;
end

// Source: TetaBonita's Harmless Companion Cube
// Edited to fit needs.
function PLAYER:CanSee ( Entity, Strict )
	if Strict then
		if !self:HasLOS(Entity) then return false; end
	end

	local fov = self:GetFOV()
	local Disp = Entity:GetPos() - self:GetPos()
	local Dist = Disp:Length()
	local EntWidth = Entity:BoundingRadius() * 0.5;
	
	local MaxCos = math.abs( math.cos( math.acos( Dist / math.sqrt( Dist * Dist + EntWidth * EntWidth ) ) + fov * ( math.pi / 180 ) ) )
	Disp:Normalize()

	if Disp:Dot( self:EyeAngles():Forward() ) > MaxCos and Entity:GetPos():Distance(self:GetPos()) < 5000 then
		return true
	end
	
	return false
end

