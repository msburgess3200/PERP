

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
 
include("shared.lua")

local OurSound = Sound('perp3.0/slots_play.mp3');
local OurSound_Lose = Sound('perp3.0/slots_lose.mp3');
local OurSound_Win = Sound('perp3.0/slots_win.mp3');
local SpinTimes = {2.6410, 2.9713, 3.3902};

local RotationsTable = {120, 265, 45, 335};
local CashWonTable = {50, 100, 500, 1000};
local ChancesTable = {1, 1, 1, 1, 2, 2, 2, 3, 3, 4}; // calculates what the chances are of winning... in an odd way kinda

local LightsTable = {Color(255, 0, 0, 255), Color(0, 0, 255, 255), Color(0, 0, 255, 255), Color(255, 255, 0, 255)};
local ColorsTable = {"red", "blu", "sil", "gol"};
 
function ENT:Initialize()
	self:SetModel("models/pulsar_effect/casino/slot_col_" .. ColorsTable[1] .. ".mdl")
	self:SetUseType(SIMPLE_USE)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:DrawShadow(true)
	
	self.Wheels = {}
	for i = 1, 3 do
		self.Wheels[i] = ents.Create("prop_slotwheel");
		self.Wheels[i]:SetModel("models/pulsar_effect/casino/slotwheel.mdl");
		self.Wheels[i]:SetPos(self.Entity:LocalToWorld(Vector(-0.5, 8 - (4 * i), 20)));
		self.Wheels[i]:SetAngles(Angle(335, self:GetAngles().y, 180));
		self.Wheels[i]:SetSolid(SOLID_NONE);
		self.Wheels[i]:SetMoveType(MOVETYPE_NONE);
		self.Wheels[i]:Spawn();
		self.Wheels[i]:Activate();
		self.Wheels[i]:SetParent(self);
		self.Wheels[i]:DrawShadow(false);
		self.Wheels[i]:GetTable().UnBurnable = true;
		
		self:SetNetworkedEntity('wheel_' .. i, self.Wheels[i]);
	end
end
 
function ENT:Use ( Activator, Player)
	if !Player or !Player:IsValid() or !Player:IsPlayer() then return false; end
	
	if Player:Team() != TEAM_CITIZEN then
		Player:Notify('Government official cannot use this machine.');
		return false;
	end
	
	if self.Spinning then return false; end
	if Player:GetCash() < 15 then Player:Notify('Not enough cash.'); return false; end
	
	//Player:AddProgress(28, 1);
	
	Player:TakeCash(15);
	
	self.Spinning = true;
	self.Player = Player;
	
	for i = 1, 3 do
		self.Wheels[i].StopTime = CurTime() + SpinTimes[i];
		self.Wheels[i].Outcome = ChancesTable[math.random(1, #ChancesTable)];
		self.Wheels[i].StopSpinning = true;
	end
	
	local RP = RecipientFilter();
	RP:AddPVS( Player:GetPos() );
	RP:AddPlayer(Player);
	
	umsg.Start('perp_slots_rotate', RP);
		umsg.Entity(self);
		
		for i = 1, 3 do
			umsg.Short(self.Wheels[i].Outcome);
		end
		
	umsg.End();
end

function ENT:AnnounceResults ( )
	local AmmountWon = 0;
	
	if self.Wheels[1].Outcome == self.Wheels[2].Outcome and self.Wheels[1].Outcome == self.Wheels[3].Outcome then
		AmmountWon = CashWonTable[self.Wheels[1].Outcome];
	end
	
	if AmmountWon != 0 then
		self.Player:GiveCash(AmmountWon);
	end
		
	for i = 1, 3 do
		self.Wheels[i].StopTime = nil;
		self.Wheels[i].Outcome = nil;
		self.Wheels[i].StopSpinning = nil;
	end
	
	self.Spinning = nil;
	self.Player = nil;
end
 
 
function ENT:Think() 

	if self.Spinning then
		if self.Wheels[3].StopTime and CurTime() >= self.Wheels[3].StopTime then
			self:AnnounceResults();
		end
	end
		
	self:NextThink(CurTime() + .01);
	return true
end
