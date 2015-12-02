


function PLAYER:Notify ( Text, truefalse )
	if !self or !self:IsValid() then return false; end
		
	if SERVER then
		umsg.Start('perp_notify', self);
			umsg.String(Text);
		umsg.End();
	else
		AddNotify(Text, NOTIFY_UNDO, 15, truefalse);
	end
end

function PLAYER:GetRPName ( )
	return self:GetUMsgString("rp_fname", "John") .. " " .. self:GetUMsgString("rp_lname", "Doe");
end

function PLAYER:GetFirstName ( )
	return self:GetUMsgString("rp_fname", "John");
end

function PLAYER:GetLastName ( )
	return self:GetUMsgString("rp_lname", "Doe");
end

function PLAYER:GetUMsgString ( ID, Default )
	if (!self.StringRedun or !self.StringRedun[ID]) then return Default; end
	return self.StringRedun[ID].value;
end

PLAYER.GetUMsgInt = PLAYER.GetUMsgString;
PLAYER.GetUMsgBool = PLAYER.GetUMsgString;

function PLAYER:GetPrivateString ( ID, Default )
	if (!self.StringRedunP or !self.StringRedunP[ID]) then return Default; end
	return self.StringRedunP[ID].value;
end

PLAYER.GetPrivateInt = PLAYER.GetPrivateString;
PLAYER.GetPrivateBool = PLAYER.GetPrivateString;

function PLAYER:SetPrivateString ( StringID, StringValue, stopSendToClient )
	self.StringRedunP = self.StringRedunP or {};
	
	if StringValue == nil then
		self.StringRedun[StringID] = nil;
		
		if SERVER && !stopSendToClient then
			umsg.Start("perp_ps");
				umsg.String(StringID);
				umsg.Short(5);
			umsg.End();
		end
		
		return;
	end

	self.StringRedunP[StringID] = {entity = self, value = StringValue};
	
	if CLIENT || stopSendToClient then return; end
	
	self:SendUMsgVar("perp_ps", self, nil, StringID, StringValue);
end

PLAYER.SetPrivateInt = PLAYER.SetPrivateString;
PLAYER.SetPrivateBool = PLAYER.SetPrivateString;

function GetVectorTraceUp ( vec )
	local trace = {};
	trace.start = vec;
	trace.endpos = vec + Vector(0, 0, 999999999);
	trace.mask = MASK_SOLID_BRUSHONLY;
	
	return util.TraceLine(trace);
end

function PLAYER:GetUpTrace ( )
	local ourEnt = self;
	if (self:InVehicle()) then
		ourEnt = self:GetVehicle();
	end
	
	return GetVectorTraceUp(ourEnt:GetPos());
end

function PLAYER:IsOutside ( ) return self:GetUpTrace().HitSky; end
function PLAYER:IsInside ( ) return !self:IsOutside(); end

function PLAYER:GetAccessLevel ( ) return self:GetLevel() end
function PLAYER:HasAccessLevel ( num ) return self:GetLevel() <= num; end

function PLAYER:GetCash ( ) return self:GetPrivateInt("cash", 0); end
function PLAYER:GetBank ( ) return self:GetPrivateInt("bank", 0); end
function PLAYER:GetFuel ( ) return self:GetPrivateInt("fuelleft", 0); end
function PLAYER:GetLastCar ( ) return self:GetPrivateString("lastcar") or "none"; end
function PLAYER:GetLastCarF ( ) return self:GetPrivateString("lastcarfuel"); end
function PLAYER:GetCarUsed ( ) return self:GetPrivateString("lastcarid"); end
function PLAYER:GetCUID ( ) return self:GetPrivateInt("cuid", 0); end


	function PLAYER:SetCUID ( value, stopSendToClient) self:SetPrivateInt("cuid", value, stopSendToClient); end
	function PLAYER:AddFuel ( value, stopSendToClient) self:SetPrivateInt("fuelleft", math.Clamp((self:GetFuel() + value) or 0, 0 , 10000),stopSendToClient); end
	function PLAYER:TakeFuel ( value, stopSendToClient) self:SetPrivateInt("fuelleft", math.Clamp((self:GetFuel() - value) or 0,0,10000), stopSendToClient); end
	function PLAYER:SetFuel ( value, stopSendToClient) self:SetPrivateInt("fuelleft", value, stopSendToClient); end
	function PLAYER:SetLastCarF ( value, stopSendToClient) self:SetPrivateInt("lastcarfuel", value, stopSendToClient); end
	
if SERVER then
	function PLAYER:SetCash ( value, stopSendToClient) self:SetPrivateInt("cash", value); end
	function PLAYER:GiveCash ( value, stopSendToClient) self:SetPrivateInt("cash", self:GetCash() + value); end
	function PLAYER:AddCash ( value, stopSendToClient) self:SetPrivateInt("cash", self:GetCash() + value); end
	function PLAYER:TakeCash ( value, stopSendToClient) self:SetPrivateInt("cash", self:GetCash() - value); end
	function PLAYER:RemoveCash ( value, stopSendToClient) self:SetPrivateInt("cash", self:GetCash() - value); end

	function PLAYER:SetBank ( value, stopSendToClient) self:SetPrivateInt("bank", value); end
	function PLAYER:GiveBank ( value, stopSendToClient) self:SetPrivateInt("bank", self:GetBank() + value); end
	function PLAYER:AddBank ( value, stopSendToClient) self:SetPrivateInt("bank", self:GetBank() + value); end
	function PLAYER:TakeBank ( value, stopSendToClient) self:SetPrivateInt("bank", self:GetBank() - value); end
	function PLAYER:RemoveBank ( value, stopSendToClient) self:SetPrivateInt("bank", self:GetBank() - value); end
	
	function PLAYER:SetLastCar ( value, stopSendToClient) self:SetPrivateInt("lastcar", value, stopSendToClient); end
	function PLAYER:SetCarUsed ( value, stopSendToClient) self:SetPrivateInt("lastcarid", value, stopSendToClient); end
	
else
	function PLAYER:SetCash ( value, stopSendToClient)  end
	function PLAYER:GiveCash ( value, stopSendToClient) end
	function PLAYER:AddCash ( value, stopSendToClient) end
	function PLAYER:TakeCash ( value, stopSendToClient) end
	function PLAYER:RemoveCash ( value, stopSendToClient) end

	function PLAYER:SetBank ( value, stopSendToClient) end
	function PLAYER:GiveBank ( value, stopSendToClient) end
	function PLAYER:AddBank ( value, stopSendToClient) end
	function PLAYER:TakeBank ( value, stopSendToClient) end
	function PLAYER:RemoveBank ( value, stopSendToClient) end
	
	function PLAYER:SetLastCar ( value, stopSendToClient) end
	function PLAYER:SetCarUsed ( value, stopSendToClient) end
end

function PLAYER:CalculateStaminaLoss ()
	if (!self || !IsValid(self)) then return; end
	if (!self.Stamina) then return; end
	if string.find(self:GetModel(), "zomb") then return; end // Zombie (Infinite Stamina)
	if (self:SteamID() == "STEAM_0:0:21513525") then return; end //<- Misha's Steam ID
	
	local realSpeed = self:GetVelocity():Length();
	
	if (self:GetUMsgInt("typing", nil) && realSpeed >= 20 && self.StartedTyping && self.StartedTyping + 2 < CurTime()) then
		self.StartedTyping = nil;
		self:SetUMsgInt("typing", nil)
	end
	
	if ((!self:InVehicle() && ((!self.Crippled && self:KeyDown(IN_SPEED) && realSpeed >= 50))) && self:GetMoveType() != MOVETYPE_NOCLIP) then
		// Take
		self.LastStaminaSteal = self.LastStaminaSteal or 0;
		self.NextStaminaExperience = self.NextStaminaExperience or 5;
			
		if (self.LastStaminaSteal + (GAMEMODE.SprintDecay * (1 + (self:GetPERPLevel(SKILL_STAMINA) - 1) * .2)) <= CurTime()) then
			self.Stamina = math.Clamp(self.Stamina - 1, 0, 100);
			
			if (SERVER && self.Stamina == 25) then
				self:SetUMsgInt("tired", 1);
			end
			
			self.LastStaminaSteal = CurTime();
			self.LastStaminaAdd = CurTime();
			
			self.NextStaminaExperience = self.NextStaminaExperience - 1;
			if (self.Stamina != 0 && self.NextStaminaExperience == 0) then
				self.NextStaminaExperience = 5;
				
				self:GiveExperience(SKILL_STAMINA, GAMEMODE.ExperienceForSprint, true);
			end
		end
	elseif (self:OnGround() || self:InVehicle() || !self:OnGround()) then
		// Restore
		self.LastStaminaAdd = self.LastStaminaAdd or 0;
		
		if (self.LastStaminaAdd + (GAMEMODE.SprintDecay * 6) <= CurTime()) then
			self.Stamina = math.Clamp(self.Stamina + 1, 0, 100);
			
			if (SERVER && self.Stamina >= 26 && self:GetUMsgInt("tired", 0) == 1) then
				self:SetUMsgInt("tired", nil);
			end
			
			self.LastStaminaAdd = CurTime();
		end
	end
	
	if SERVER then self:FindRunSpeed(); end
end



function PLAYER:CalculateRegeneration ( )
	if (self:GetPERPLevel(GENE_REGENERATION) <= 0) then return; end
	if (!self:Alive()) then return; end
	if (self:Health() >= 100) then return; end
	
	if (self:GetPERPLevel(GENE_REGENERATION) == 1) then
		NewHealth = math.Approach(self:Health(), 100, 1);
	elseif (self:GetPERPLevel(GENE_REGENERATION) == 2) then
		NewHealth = math.Approach(self:Health(), 100, 2);
	elseif (self:GetPERPLevel(GENE_REGENERATION) == 3) then
		NewHealth = math.Approach(self:Health(), 100, 3);
	elseif (self:GetPERPLevel(GENE_REGENERATION) == 4) then
		NewHealth = math.Approach(self:Health(), 100, 4);
	elseif (self:GetPERPLevel(GENE_REGENERATION) == 5) then
		NewHealth = math.Approach(self:Health(), 100, 5);
	end;
	
	self:SetHealth(NewHealth);
end

function PLAYER:IsGovernmentOfficial ( )
	return self:Team() != TEAM_CITIZEN;
end

function PLAYER:IsValidZombie ( )
	return string.find(self:GetModel(), "zomb")
end

function PLAYER:HasBlacklist ( blacklistID, recompiling )
	if (string.find(self:GetPrivateString("blacklists", ""), blacklistID)) then
		local explodedString = string.Explode(";", self:GetPrivateString("blacklists", ""));
		
		for _, chunk in pairs(explodedString) do
			local explodedMore = string.Explode(",", chunk);
							
			if (#explodedMore == 2) then
				if (explodedMore[1] == blacklistID) then
					local expires = tonumber(explodedMore[2]);
						
					if (SERVER && expires != 0 && expires <= os.time()) then
						if (!recompiling) then
							self:RecompileBlacklists();
						end
						
						return false;
					else
						return expires;
					end
				end
			end
		end
	end
	
	return false;
end


function PLAYER:GetTimePlayed ( )
	if CLIENT then
		GAMEMODE.LoadTime = GAMEMODE.LoadTime or 0;
		
		return self:GetPrivateInt("time_played", 0) + (CurTime() - GAMEMODE.LoadTime);
	else
		return self:GetPrivateInt("time_played", 0) + (CurTime() - self.joinTime);
	end
end