
GM.UMsgRedun = {};
function PLAYER:SetUMsgString ( StringID, StringValue )
	self.StringRedun = self.StringRedun or {};
	
	if StringValue == nil then
		self.StringRedun[StringID] = nil;
		
		umsg.Start("perp_ums");
			umsg.Entity(self);
			umsg.String(StringID);
			umsg.Short(5);
		umsg.End();
		
		return;
	end

	self.StringRedun[StringID] = {entity = self, value = StringValue};
	
	self:SendUMsgVar("perp_ums", nil, self, StringID, StringValue);
end

PLAYER.SetUMsgInt = PLAYER.SetUMsgString;
PLAYER.SetUMsgBool = PLAYER.SetUMsgString;

function PLAYER:SendUMsgVar ( Type, ToWho, Entity, StringID, StringValue, loadVar )
	if (ToWho && !IsValid(ToWho)) then return; end
	
	umsg.Start(Type, ToWho);
		if (Type == "perp_ums") then
			umsg.Entity(Entity);
		end
		
		umsg.String(StringID);
		
		if type(StringValue) == "string" then
			umsg.Short(1);
			umsg.String(StringValue);
		elseif type(StringValue) == "number" then
			if (math.floor(StringValue) != StringValue) then
				umsg.Short(2);
				umsg.Float(StringValue);
			else
				umsg.Short(3);
				
				if (StringID == "cash" || StringID == "bank") then
					umsg.Long(StringValue);
				else
					umsg.Short(StringValue);
				end
			end
		elseif type(StringValue) == "boolean" then
			umsg.Short(4);
			umsg.Bool(StringValue);
		end
		
		if (loadVar) then
			umsg.Bool(true);
		else
			umsg.Bool(false);
		end
	umsg.End();
end
	
function PLAYER:FindRunSpeed()
	if (!self.Stamina) then return; end
	
	self.LastSetSprint = self.LastSetSprint or "";
	
	local newSetSprint = {200, 300};
	if self.Crippled || self.currentlyRestrained then
		newSetSprint = {50, 75};
	else
		if GAMEMODE.IsSerious then
			if (self.Stamina > 0) then
				newSetSprint = {100, 300};
			else
				newSetSprint = {100, 100};
			end
		else
			if (self.Stamina > 0) then
				newSetSprint = {200, 300};
			else
				newSetSprint = {200, 200};
			end
		end
	end
	
	local prospectiveNewSprint = tostring(newSetSprint[1]) .. tostring(newSetSprint[2]);
	
	if (prospectiveNewSprint == self.LastSetSprint) then return; end
	
	self.LastSetSprint = prospectiveNewSprint;
	GAMEMODE:SetPlayerSpeed(self, newSetSprint[1], newSetSprint[2]);
end

function PLAYER:ForceRename ( )
	self.CanRenameFree = true;
		
	umsg.Start("perp_rename", self);
	umsg.End();
end

function PLAYER:ForceFUN ( )
		
	umsg.Start("perp_fun", self);
	umsg.End();
end


function PLAYER:HasBuddy ( otherPlayer )
	if (self == otherPlayer) then return true; end
	
	for k, v in pairs(self.Buddies) do
		if (v == tostring(otherPlayer:UniqueID())) then
			return true;
		end
	end
	
	return false;
end

function PLAYER:SpawnProp ( ItemTable, overrideType )
	if (self.lastSpawnProp && self.lastSpawnProp > CurTime() && !self:IsAdmin()) then
self:Notify("Please slow down your prop spawning.");
return false; 
end;

	
	self.lastSpawnProp = CurTime() + 2;

	self.theirNumItems = self.theirNumItems or 0;
	
	 if (self.theirNumItems >= MAX_PROPS_VIP && !self:IsAdmin() || (!self:IsBronze() && self.theirNumItems >= MAX_PROPS_NORM) && !self:IsAdmin()) then
self:Notify("You have reached the prop limit.");
return;
end;

	self.theirNumItems = self.theirNumItems + 1;

	local ty = overrideType or "ent_prop_item";

	local trace = {};
		trace.start = self:GetShootPos();
		trace.endpos = self:GetShootPos() + self:GetAimVector() * 50;
		trace.filter = self;
	local tRes = util.TraceLine(trace);

	local itemDrop = ents.Create(ty);
		if (!overrideType || overrideType == "prop_vehicle_prisoner_pod") then
			itemDrop:SetModel(ItemTable.WorldModel);
		end
		
		if (overrideType == "prop_vehicle_prisoner_pod") then
			itemDrop:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt");
			
			local SeatDatabase = list.Get("Vehicles")["Seat_Jeep"];
			if SeatDatabase.Members then table.Merge(itemDrop, SeatDatabase.Members); end
			if SeatDatabase.KeyValues then
				for k, v in pairs(SeatDatabase.KeyValues) do
					itemDrop:SetKeyValue(k, v);
				end
			end
		end
		
		if (itemDrop.SetContents) then
			itemDrop:SetContents(ItemTable.ID, self);
		end
		
		itemDrop:SetPos(tRes.HitPos);
	itemDrop:Spawn();
	
	itemDrop.pickupTable = ItemTable.ID;
	itemDrop.pickupPlayer = self;
	
	return itemDrop;
end

local allPossibleBlacklists = {'a', 'b'};
for k, v in pairs(GM.teamToBlacklist) do table.insert(allPossibleBlacklists, v); end
function PLAYER:RecompileBlacklists ( )
	local blacklistString = "";
	
	for k, v in pairs(allPossibleBlacklists) do
		local hasBL = self:HasBlacklist(v, true);
		
		if (hasBL) then
			blacklistString = blacklistString .. v .. "," .. hasBL .. ";";
		end
	end
	
	if (blacklistString == self:GetPrivateString("blacklists", "")) then return; end
		
	self:SetPrivateString("blacklists", blacklistString)
	tmysql.query("UPDATE `perp_users` SET `blacklists`='" .. blacklistString .. "' WHERE `id`='" .. self.SMFID .. "'");
end

function PLAYER:GiveBlacklist ( id, time )
	if self:HasBlacklist(id) then return; end
	
	local endTime = os.time() + (time * 60 * 60);
	if (time == 0) then endTime = 0; end

	local newString = self:GetPrivateString("blacklists", "") .. id .. "," .. endTime .. ";";
	self:SetPrivateString("blacklists", newString);
	tmysql.query("UPDATE `perp_users` SET `blacklists`='" .. newString .. "' WHERE `id`='" .. self.SMFID .. "'");
end

function PLAYER:StripMains ( )
	if (self.PlayerItems[1]) then
		self.PlayerItems[1].Table.Holster(self);
	end
		
	if (self.PlayerItems[2]) then
		self.PlayerItems[2].Table.Holster(self);
	end
end

function PLAYER:EquipMains ( )
	if (self.PlayerItems[1]) then
		self.PlayerItems[1].Table.Equip(self);
	end
		
	if (self.PlayerItems[2]) then
		self.PlayerItems[2].Table.Equip(self);
	end
end

function PLAYER:RemoveEquipped ( ID )
	local id;
	if (ID == EQUIP_MAIN) then id = 1; end
	if (ID == EQUIP_SIDE) then id = 2; end
	
	if (!id) then return; end
	
	self.PlayerItems[id].Table.Holster(self);
	self.PlayerItems[id] = nil;
	
	umsg.Start("perp_rem_eqp", self);
		umsg.Short(id);
	umsg.End();
end

function PLAYER:Arrest ( byWho )
	if (self:Team() != TEAM_CITIZEN) then return; end
	self.currentlyRestrained = !self.currentlyRestrained
	self.arrestingOfficer = byWho
	
	if (self.currentlyRestrained) then
		self:StripWeapons()
	else
		GAMEMODE:PlayerLoadout(self)
	end
	
	self:FindRunSpeed()

/*
	if (self.CurrentlyJailed) then return; end
	if (self:Team() != TEAM_CITIZEN) then return; end
	
	local goTime = JAIL_TIME;
	if (self:GetNetworkedBool("warrent", false)) then
		goTime = JAIL_TIME_WARRENTED;
		self:SetNetworkedBool("warrent", false);
	end
	
	local arrestPos = GAMEMODE.JailLocations[1];
	for k, v in pairs(GAMEMODE.JailLocations) do
		local dontDo;
		for _, ent in pairs(player.GetAll()) do
			if (ent:GetPos():Distance(v) <= 100) then
				dontDo = true;
			end
		end
		
		if (!dontDo) then
			arrestPos = v;
			break;
		end
	end
	
	umsg.Start('perp_arrested', self);
		umsg.Short(goTime);
	umsg.End();
	
	for i = 1, 2 do
		if (self.PlayerItems[i]) then
			self.PlayerItems[i] = nil;
		end
	end
	umsg.Start('perp_strip_main', self); umsg.End();
	
	self.CurrentlyJailed = true;
	
	self:SetPos(arrestPos);
	
	timer.Simple(goTime, function ( )
		if (self && IsValid(self) && self:IsPlayer()) then
			self.CurrentlyJailed = nil;
			
			local arrestPos = GAMEMODE.UnjailLocations[1];
			for k, v in pairs(GAMEMODE.UnjailLocations) do
				local dontDo;
				for _, ent in pairs(player.GetAll()) do
					if (ent:GetPos():Distance(v) <= 100) then
						dontDo = true;
					end
				end
				
				if (!dontDo) then
					arrestPos = v;
					break;
				end
			end
			
			self:SetPos(arrestPos);
		end
	end);
*/
end

local saveString = "UPDATE `perp_users` SET `cash`='%d', `time_played`='%d', `last_played`='%d', `items`='%s', `storage`='%s', `skills`='%s', `genes`='%s', `formulas`='%s', `bank`='%d', `ringtone`='%d', `ammo_pistol`='%d', `ammo_rifle`='%d', `ammo_shotgun`='%d', `fuelleft`='%d', `lastcar`='%s' WHERE `id`='%s'";
function PLAYER:Save ( )
	if (!self.SMFID) then return false; end
	
	local rpName = tmysql.escape(self:GetRPName())
	tmysql.query("UPDATE `ip_intel` SET `rp_name`='" .. rpName .. "' WHERE `steamid`='" .. self:SteamID() .. "' LIMIT 1")
	
	if (!self.AlreadyLoaded) then
		for i = 1, 5 do
			self:ChatPrint("Your account is not authorized to save. Reconnect or your progress will not be saved.");
		end
		
		Msg("Refused to save " .. self:Nick() .. ".\n");
		
		return
	end
	
	Msg("Saved " .. self:Nick() .. ".\n");
	
	local timeSinceJoin = CurTime() - math.Round(self.joinTime or CurTime());
	
	local skills = "";
	for i = 1, #SKILLS_DATABASE do	
		skills = skills .. self:GetPrivateInt("s_" .. i, 0) .. ";";
	end
	
	local genes = self:GetPrivateInt("gpoints", 0) .. ";";
	for i = 1, #GENES_DATABASE do	
		genes = genes .. self:GetPrivateInt("g_" .. i, 0) .. ";";
	end
	
	local formulas = self:GetPrivateString("mixtures", "");
	
	tmysql.query(string.format(saveString, 	
											self:GetPrivateInt("cash", 0), 
											self:GetPrivateInt("time_played", 0) + timeSinceJoin, 
											os.time(), 
											self:CompileItems(),
											self:CompileStorage(),
											skills,
											genes,
											formulas,
											self:GetPrivateInt("bank", 0), 
											tonumber(self:GetUMsgInt("ringtone", 1)),
											self:GetAmmoCount('pistol'),
											self:GetAmmoCount('smg1'),
											self:GetAmmoCount('buckshot'),
											self:GetPrivateInt("fuelleft", 0),
											self:GetPrivateInt("lastcar", 0),
											
											self.SMFID
								)
				);
end