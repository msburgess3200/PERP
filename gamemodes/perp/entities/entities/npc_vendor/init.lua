AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
 
include("shared.lua");

function ENT:Initialize ( )

	self:SetSolid(SOLID_BBOX);
	self:PhysicsInit(SOLID_BBOX); --BBOX
	self:SetMoveType(MOVETYPE_NONE);
	self:DrawShadow(true);
	--self:SetRenderMode(RENDERMODE_TRANSALPHA)
	self:SetUseType(SIMPLE_USE);
end

function ENT:MakeChatBubble ( )
	self.Bubble = ents.Create("npc_bubble");
	self.Bubble:SetPos(self:GetPos() + Vector(0, 0, 90));
	self.Bubble:Spawn();
end

function ENT:MakeVIPChatBubble ( )
	self.Bubble = ents.Create("npc_bubble");
	self.Bubble:SetSkin(1);
	self.Bubble:SetPos(self:GetPos() + Vector(0, 0, 90));
	self.Bubble:Spawn();
end

function ENT:UseFake ( User )
	if (!IsValid(User) || !User:IsPlayer()) then return false; end
	
	GAMEMODE.NPCUsed(User, self.NPCID);
end
