
include("shared.lua")

local OurOffset = Vector(-5, -0.1900, 35);
local BlareTime = SoundDuration('perp/slots_win.mp3');

local LightsTable = {Color(255, 0, 0, 255), Color(0, 0, 255, 255), Color(0, 0, 255, 255), Color(255, 255, 0, 255)};
local ColorsTable = {"red", "blu", "sil", "gol"};

local SpinTimes = {2.6410, 2.9713, 3.3902};
local RotationsTable = {120, 265, 45, 335};

local OurSound = Sound('perp3.0/slots_play.mp3');
local OurSound_Lose = Sound('perp3.0/slots_lose.mp3');
local OurSound_Win = Sound('perp3.0/slots_win.mp3');

function ENT:Initialize()

	self.PixVis = util.GetPixelVisibleHandle();
	
	self.NextRotationTime = CurTime();
	
end

function ENT:Draw()
	self.Entity:DrawModel()
	
	if !self.LightColor then
		for k, v in pairs(ColorsTable) do
			if string.find(self:GetModel(), "_" .. v) then
				self.LightColor = LightsTable[k];
			end
		end
	end
	
	if self.BlareEndTime then
		local LightPos = self:LocalToWorld(OurOffset);
		
		local Trace = {}
		Trace.start = LocalPlayer():GetShootPos();
		Trace.endpos = self:GetPos();
		Trace.filter = {self, LocalPlayer()}
		
		local TR = util.TraceLine(Trace);
		
		if util.PixelVisible(LightPos, 32, self.PixVis) or !TR.Hit then
			if self.BlareEndTime < CurTime() then
				self.BlareEndTime = nil;
			end
			
			if math.Round(math.abs(math.cos(CurTime() * 10))) == 1 then
				local dlight = DynamicLight( self:EntIndex() )
				if ( dlight ) then
					dlight.Pos = LightPos;
					dlight.r = self.LightColor.r;
					dlight.g = self.LightColor.g;
					dlight.b = self.LightColor.b;
					dlight.Brightness = 2
					dlight.Decay = 128
					dlight.Size = 128
					dlight.DieTime = CurTime() + .05;
				end
			end
		end
	end
	
	if self.RotationBegin then		
		for i = 1, 3 do
			slotwheel = self:GetNetworkedEntity('wheel_' .. i, nil);
			
			if self.StopTimes[i] and self.StopTimes[i] <= CurTime() then
				self.StopTimes[i] = nil;
				
				if slotwheel and slotwheel:IsValid() then
					local OldAngles = slotwheel:GetAngles();
					
					slotwheel:SetAngles(Angle(RotationsTable[self:GetTable().Results[i]], OldAngles.y, OldAngles.r));
				end
				
				if i == 3 then
					if math.Round(tonumber(self:GetTable().Results[1])) == math.Round(tonumber(self:GetTable().Results[2])) and math.Round(tonumber(self:GetTable().Results[2])) == math.Round(tonumber(self:GetTable().Results[3])) then
					
						if !self.OurSound_Win then
							self.OurSound_Win = CreateSound(self, OurSound_Win);
						end
						
						self.OurSound_Win:Stop();
						self.OurSound_Win:Play();
						
						self.BlareEndTime = CurTime() + BlareTime;
					else
						if !self.OurSound_Lose then
							self.OurSound_Lose = CreateSound(self, OurSound_Lose);
						end
						
						self.OurSound_Lose:Stop();
						self.OurSound_Lose:Play();
					end
				
					self.RotationBegin = nil;
				end
			end
		end
		
		if self.NextRotationTime < CurTime() then
			self.NextRotationTime = CurTime() + .01;
			
			for i = 1, 3 do
				slotwheel = self:GetNetworkedEntity('wheel_' .. i, nil);
				
				if self.StopTimes[i] and slotwheel and slotwheel:IsValid() then
					local OldAngles = slotwheel:GetAngles();
					
					slotwheel:SetAngles(Angle(OldAngles.p + 10, OldAngles.y, OldAngles.r));
				end
			end
		end
	end
end

function ENT:StartRotate ( )
	self.RotationBegin = CurTime();
	
	self.StopTimes = {};
	
	if !self.OurSound then
		self.OurSound = CreateSound(self, OurSound);
	end
	
	self.OurSound:Stop();
	self.OurSound:Play();
		
	for i = 1, 3 do
		self.StopTimes[i] = CurTime() + SpinTimes[i];
	end
end

function BeginSlotMachineRotation ( UMsg )
	local Ent = UMsg:ReadEntity();
		
	if !Ent or !Ent:IsValid() then return false; end
	
	Ent:StartRotate();
	
	Ent:GetTable().Results = {};
	Ent:GetTable().Results[1] = UMsg:ReadShort();
	Ent:GetTable().Results[2] = UMsg:ReadShort();
	Ent:GetTable().Results[3] = UMsg:ReadShort();
end
usermessage.Hook('perp_slots_rotate', BeginSlotMachineRotation);

local function BeginSlotMachineFlash ( UMsg )
	local Ent = UMsg:ReadEntity();
	
	Ent.BlareEndTime = CurTime() + BlareTime;
end
usermessage.Hook('perp_slots_flash', BeginSlotMachineFlash);