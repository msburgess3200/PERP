
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include('shared.lua')

MixRange = 150;

function ENT:Initialize()
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	self.Entity:SetUseType( SIMPLE_USE )
	
	self.Entity:GetPhysicsObject():Wake();
	
	self.willBurn = (math.random(1, 10) == 1);
end

function ENT:Use( activator, caller )
	if !activator:IsPlayer() then return false; end
	if !self:GetTable().ItemID then self:Remove(); return false; end
	if self.Entity:GetTable().Tapped and self.Entity:GetTable().Tapped > CurTime() then return false; end
	
	if ((activator:Team() == TEAM_POLICE || activator:Team() == TEAM_SWAT) && ITEM_DATABASE[self:GetTable().ItemID].RestrictedSelling) then
		self.Entity:GetTable().Tapped = CurTime() + 5;
		activator:GiveCash(GAMEMODE.CopReward_Arrest);
		activator:PrintMessage(HUD_PRINTTALK, "You have been rewarded $" .. GAMEMODE.CopReward_Arrest .. " for destroying a controlled substance.");
		self:Remove();
		return;
	end
	
	if (activator:Team() != TEAM_CITIZEN && ITEM_DATABASE[self:GetTable().ItemID].RestrictedSelling) then return; end
	
	if (self:GetTable().ItemID == 9 && self:GetNetworkedBool("smoking", false)) then
		if ((CurTime() - self.smokeStart) >= METH_BURN_TIME) then
			activator:GiveItem(11, 1, true);
		else
			activator:GiveItem(10, 1, true);
		end
	elseif (self:GetNetworkedString("title", "") != "" && activator != self:GetTable().Owner) then
		local ourPrice = self:GetNetworkedInt("price", -1)
		
		if (ourPrice == -1) then return end
		if (activator:GetCash() < ourPrice) then return end
		
		activator:TakeCash(ourPrice, true)
		local salesTax = math.Round(ourPrice * GAMEMODE.GetTaxRate_Sales())
		local winCash = ourPrice - salesTax
		GAMEMODE.GiveCityMoney(salesTax)
		self:GetTable().Owner:GiveCash(winCash)
		self:GetTable().Owner:Notify(activator:GetRPName() .. " bought your '" .. self:GetNetworkedString("title", "") .. "'. You earned $" .. winCash .. " (" .. GAMEMODE.GetTaxRate_Sales_Text() .. " Sales Tax)")
		
		activator:GiveItem(self:GetTable().ItemID, 1, true);
	else
		activator:GiveItem(self:GetTable().ItemID, 1, true);
	end
	
	self.Entity:GetTable().Tapped = CurTime() + 5;
	
	self:Remove();
end

function ENT:SetContents ( ItemID, Owner )
	self:GetTable().ItemID = tonumber(ItemID);
	self:GetTable().Owner = Owner;
end

function ENT:Explode ( )
	local effect = EffectData();
		effect:SetOrigin(self:GetPos());
	util.Effect("explosion_meth", effect);
				
	local f = ents.Create("ent_fire");
		f:SetPos(self:GetPos());
	f:Spawn();
	
	util.BlastDamage(self, self.Owner, self:GetPos(), 300, 300 )
	
	self:Remove();
end

function ENT:Think ( )
	// Wet Meth
	if (self:GetTable().ItemID && self:GetTable().ItemID == 9) then
		local nearHeatSource = GAMEMODE.FindHeatSource(self:GetPos(), MixRange, true)
		
		if (nearHeatSource) then
			if (!self.smokeStart) then self.smokeStart = CurTime(); end
			
			if (self.willBurn && (CurTime() - self.smokeStart) >= (METH_COOK_TIME * .25)) then				
				for k, v in pairs(ents.FindInSphere(self:GetPos(), 128)) do
					if (v.ItemID && v.ItemID == self:GetTable().ItemID) then
						v:Explode();
					end
				end
				
				self:Explode();
			elseif ((CurTime() - self.smokeStart) >= METH_COOK_TIME && !self:GetNetworkedBool("smoking", false)) then
				self:SetNetworkedBool("smoking", true);
			elseif ((CurTime() - self.smokeStart) >= METH_BURN_TIME) then
				self:SetColor(150, 150, 150, 255);
			end
		elseif (self.smokeStart) then
			self.smokeStart = nil;
		end
	end
	
	if (self:GetNetworkedString("title", "") != "" && !self.pushedOBBMaxs) then
		local maxs = self:OBBMaxs()
		local mins = self:OBBMins()
		
		self:SetNetworkedVector("maxs", Vector((mins.x + maxs.x) * 0.5, (mins.y + maxs.y) * 0.5, maxs.z))
	end
end

local combineSound = Sound("buttons/button19.wav");
function ENT:StartTouch ( Ent )
	if (self:GetTable().Tapped && self:GetTable().Tapped > CurTime()) then return; end
	if (Ent:GetTable().Tapped && Ent:GetTable().Tapped > CurTime()) then return; end
	if (Ent:GetClass() != "ent_item") then return; end
	if (!self:GetTable().ItemID || !Ent:GetTable().ItemID) then return; end
	if (!self:GetTable().Owner || !IsValid(self:GetTable().Owner)) then return; end
	if (self:GetNetworkedString("title", "") != "") then return end
	
	local toMake;
	for k, v in pairs(MIXTURE_DATABASE) do
		if (self:GetTable().Owner:HasMixture(k)) then
			self:GetTable().Owner.LastAttemptedTable = self:GetTable().Owner.LastAttemptedTable or {}
			
			if (!self:GetTable().Owner.LastAttemptedTable[k] || self:GetTable().Owner.LastAttemptedTable[k] <= CurTime()) then
				self:GetTable().Owner.LastAttemptedTable[k] = CurTime() + 1;
			
				local hasFirstItem = false;
				local hasSecondItem = false
			
				local checkList = {};
				
				// See if our two main ingredients are even involved.
				for _, req in pairs(v.Ingredients) do
					checkList[tonumber(req)] = checkList[tonumber(req)] or 0;
					checkList[tonumber(req)] = checkList[tonumber(req)] + 1;
					
					if (!hasFirstItem && req == self:GetTable().ItemID) then
						hasFirstItem = true;
					elseif (!hasSecondItem && req == Ent:GetTable().ItemID) then
						hasSecondItem = true;
					end
				end
				
				// Okay, we have the first two ingredients for sure. See if we have the skills.
				if (hasFirstItem && hasSecondItem) then
					local hasAllReqs = true;
					
					for _, req in pairs(v.Requires) do
						if (self:GetTable().Owner:GetPERPLevel(req[1]) < req[2]) then
							hasAllReqs = false;
							break;
						end
					end
					
					if (hasAllReqs) then
						// Wonderful, we have all the reqs. Now make sure we have the rest of the ingredients!
						
						for k, v in pairs(ents.FindInSphere(self:GetPos(), MixRange)) do
							if (v:GetClass() == "ent_item" && v:GetTable().ItemID && (!v:GetTable().Tapped || v:GetTable().Tapped < CurTime()) && checkList[v:GetTable().ItemID]) then
								checkList[v:GetTable().ItemID] = checkList[v:GetTable().ItemID] - 1;
							end
						end
						
						local usedAllIngredients = true;
						for k, v in pairs(checkList) do
							if (v > 0) then
								usedAllIngredients = false;
							end
						end
						
						if (usedAllIngredients) then
							// Okay, so we have all ingridients; what about water / heat sources?
							
							if (!v.RequiresHeatSource || GAMEMODE.FindHeatSource(self:GetPos(), MixRange)) then
								if (!v.RequiresWaterSource || GAMEMODE.FindWaterSource(self:GetPos(), MixRange)) then
									if (!v.RequiresSawHorse || GAMEMODE.FindSawHorse(self:GetPos(), MixRange)) then
										// Wonderful, now lets make sure the mixture wants us to do this.
										
										if (!v.CanMix || v.CanMix(self:GetTable().Owner, self:GetPos())) then
											toMake = v;
											break;
										end
									else
										self:GetTable().Owner:Notify("This mixture requires a saw horse.");
									end
								else
									self:GetTable().Owner:Notify("This mixture requires a water source.");
								end
							else
								self:GetTable().Owner:Notify("This mixture requires a heat source.");
							end
						end
					end
				end
			end
		end
	end
	
	if (!toMake) then return; end
		
	local checkList = {};
	for _, req in pairs(toMake.Ingredients) do
		checkList[tonumber(req)] = checkList[tonumber(req)] or 0;
		checkList[tonumber(req)] = checkList[tonumber(req)] + 1;
	end
	
	local oldOwner = self:GetTable().Owner;
	local oldPos = self:GetPos();
	
	for k, v in pairs(ents.FindInSphere(self:GetPos(), MixRange)) do
		if (v:GetClass() == "ent_item" && v:GetTable().ItemID && (!v:GetTable().Tapped || v:GetTable().Tapped < CurTime()) && checkList[v:GetTable().ItemID] && checkList[v:GetTable().ItemID] > 0) then
			checkList[v:GetTable().ItemID] = checkList[v:GetTable().ItemID] - 1;
			v:GetTable().Tapped = CurTime() + 5;
			v:Remove();
		end
	end
	
	if (toMake.Results == 13) then //weed
	
		//local NumDrugs = 0;
		/*
		for k, v in pairs(ents.FindByClass('ent_pot')) do
			if v:GetTable().ItemSpawner:SteamID() == oldOwner:SteamID() then
			//NumDrugs = NumDrugs + 1;
		end
		end
		*/
		
			local newItem = ents.Create("ent_pot");
			newItem:SetPos(oldPos + Vector(0, 0, 5));
			newItem:Spawn();
			newItem.ItemSpawner = oldOwner;
		
		/*
		if (GAMEMODE.IsSerious == true) && (NumDrugs < 3) then
		local newItem = ents.Create("ent_pot");
			newItem:SetPos(oldPos + Vector(0, 0, 10));
			newItem:Spawn();
			newItem.ItemSpawner = oldOwner;
		elseif GAMEMODE.IsSerious == true then
			oldOwner:Notify("You have hit the limit on Serious.")
		end
		if !GAMEMODE.IsSerious then
		local newItem = ents.Create("ent_pot");
		newItem:SetPos(oldPos + Vector(0, 0, 10));
		newItem:Spawn();
		newItem.ItemSpawner = oldOwner;
		end
		*/
		
	elseif (toMake.Results == 160) then //cocain
		
			local newItem = ents.Create("ent_coca");
			newItem:SetPos(oldPos + Vector(0, 0, 5));
			newItem:Spawn();
			newItem.ItemSpawner = oldOwner;
		
	else
		local results = ITEM_DATABASE[toMake.Results];
		
		local newItem = ents.Create("ent_item");
			newItem:SetPos(oldPos + Vector(0, 0, 10));
			newItem:SetModel(results.WorldModel);
			newItem:SetContents(results.ID, oldOwner);
		newItem:Spawn();
		
		if string.find(results.Reference, "wood") then
			oldOwner:GiveExperience(SKILL_WOODWORKING, math.Round(GAMEMODE.ExperienceForCraft * 1.5));
		end
	end
	
	oldOwner:GiveExperience(SKILL_CRAFTING, GAMEMODE.ExperienceForCraft);
	
	self:EmitSound(combineSound);
end

