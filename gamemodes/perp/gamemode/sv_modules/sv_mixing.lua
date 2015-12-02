MixRange = 150


local combineSound = Sound("buttons/button19.wav")

local function MixItems(objPl, _, tblArgs)
	local iID = tonumber(tblArgs[1])
	
	local tblMixture
	for k, v in pairs(MIXTURE_DATABASE) do
		if(v.ID == iID) then
			tblMixture = v
		end
	end
	
	if(not tblMixture) then
		objPl:Notify("Invalid mixture!")
		return
	end
	
	if(tblMixture.MixInWorld) then
		objPl:Notify("You can't create this mixture from the menu. Mix the ingredients together in the game world.")
		return
	end
	
	local tblRequired = {}
	for k, v in pairs(tblMixture.Ingredients) do
		tblRequired[v] = tblRequired[v] or 0
		tblRequired[v] = tblRequired[v] + 1
	end
	
	for i, a in pairs(tblRequired) do
		if(objPl:GetItemCount(i) < a) then
			objPl:Notify("You don't have the resources to create this mixture.")
			return
		end
	end
	
	for _, req in pairs(tblMixture.Requires) do
		if(objPl:GetPERPLevel(req[1]) < req[2]) then
			objPl:Notify("You don't have the required skills to do this.")
			return
		end
	end
	
	if(tblMixture.RequiresWaterSource and !GAMEMODE.FindWaterSource(objPl:GetPos(), MixRange)) then
		objPl:Notify("This mixture requires a water source.")
		return
	end
	
	if (tblMixture.RequiresHeatSource and !GAMEMODE.FindHeatSource(objPl:GetPos(), MixRange)) then
		objPl:Notify("This mixture requires a heat source.")
		return
	end

	if (tblMixture.RequiresSawHorse) then
		if(!GAMEMODE.FindSawHorse(objPl:GetPos(), MixRange)) then
			objPl:Notify("This mixture requires a saw horse.")
			return
		else
			objPl:GiveExperience(SKILL_WOODWORKING, GAMEMODE.ExperienceForWoordWorking)
		end
	end
	
	local iResults = tblMixture.Results
	if(not iResults) then
		objPl:Notify("Error creating item - invalid mixture result!")
		return
	end
	if(type(iResults) == "string") then
		objPl:Notify("Error creating item - mixture result is string!!")
		return
	end
	
	local trd	= {}
	trd.start = objPl:EyePos()
	trd.endpos = trd.start + objPl:GetAimVector() * 200
	trd.filter = objPl
		
	local tr = util.TraceLine(trd)
		
	local item = ITEM_DATABASE[iResults]
	if(not item) then
		objPl:Notify("Error creating item - invalid result from table!")
		return
	end
	
	if (item.ID == 13) then //weed
	
		if !tblMixture.CanMix(objPl) then return; end 
		
			local newItem = ents.Create("ent_pot");
			newItem:SetPos(tr.HitPos + Vector(0, 0, 5));
			newItem:Spawn();
			newItem:EmitSound(combineSound);
			newItem.ItemSpawner = objPl;
			
	elseif (item.ID == 160) then //cocain
	
		if !tblMixture.CanMix(objPl) then return; end 
		
			local newItem = ents.Create("ent_coca");
			newItem:SetPos(tr.HitPos + Vector(0, 0, 5));
			newItem:Spawn();
			newItem:EmitSound(combineSound);
			newItem.ItemSpawner = objPl;	
	
	else
	
		if !tblMixture.CanMix(objPl) then return; end 
	
			local newItem = ents.Create("ent_item")
			newItem:SetPos(tr.HitPos + Vector(0, 0, 10))
			newItem:SetModel(item.WorldModel)
			newItem:SetContents(item.ID, objPl)
		newItem:Spawn()
		newItem:EmitSound(combineSound);
		newItem.ItemOwner = objPl
	
	end
	
	for k, v in pairs(tblRequired) do
		objPl:TakeItemByID(k, v, true)
	end
	
	objPl:GiveExperience(SKILL_CRAFTING, GAMEMODE.ExperienceForCraft)
end
concommand.Add("perp_mix", MixItems)
	
--[[	
	local toMake
	for k, v in pairs(MIXTURE_DATABASE) do
		if (self:GetTable().Owner:HasMixture(k)) then
			self:GetTable().Owner.LastAttemptedTable = self:GetTable().Owner.LastAttemptedTable or {}
			
			if (!self:GetTable().Owner.LastAttemptedTable[k] || self:GetTable().Owner.LastAttemptedTable[k] <= CurTime()) then
				self:GetTable().Owner.LastAttemptedTable[k] = CurTime() + 1
			
				local hasFirstItem = false
				local hasSecondItem = false
			
				local checkList = {}
				
				// See if our two main ingredients are even involved.
				for _, req in pairs(v.Ingredients) do
					checkList[tonumber(req)] = checkList[tonumber(req)] or 0
					checkList[tonumber(req)] = checkList[tonumber(req)] + 1
					
					if (!hasFirstItem && req == self:GetTable().ItemID) then
						hasFirstItem = true
					elseif (!hasSecondItem && req == Ent:GetTable().ItemID) then
						hasSecondItem = true
					end
				end
				
				// Okay, we have the first two ingredients for sure. See if we have the skills.
				if (hasFirstItem && hasSecondItem) then
					local hasAllReqs = true
					
					for _, req in pairs(v.Requires) do
						if (self:GetTable().Owner:GetLevel(req[1]) < req[2]) then
							hasAllReqs = false
							break
						end
					end
					
					if (hasAllReqs) then
						// Wonderful, we have all the reqs. Now make sure we have the rest of the ingredients!
						
						for k, v in pairs(ents.FindInSphere(self:GetPos(), MixRange)) do
							if (v:GetClass() == "ent_item" && v:GetTable().ItemID && (!v:GetTable().Tapped || v:GetTable().Tapped < CurTime()) && checkList[v:GetTable().ItemID]) then
								checkList[v:GetTable().ItemID] = checkList[v:GetTable().ItemID] - 1
							end
						end
						
						local usedAllIngredients = true
						for k, v in pairs(checkList) do
							if (v > 0) then
								usedAllIngredients = false
							end
						end
						
						if (usedAllIngredients) then
							// Okay, so we have all ingridients what about water / heat sources?
							
							if (!v.RequiresHeatSource || GAMEMODE.FindHeatSource(self:GetPos(), MixRange)) then
								if (!v.RequiresWaterSource || GAMEMODE.FindWaterSource(self:GetPos(), MixRange)) then
									// Wonderful, now lets make sure the mixture wants us to do this.
									
									if (!v.CanMix || v.CanMix(self:GetTable().Owner, self:GetPos())) then
										toMake = v
										break
									end
								else
									self:GetTable().Owner:Notify("This mixture requires a water source.")
								end
							else
								self:GetTable().Owner:Notify("This mixture requires a heat source.")
							end
						end
					end
				end
			end
		end
	end
	
	if (!toMake) then return end
		
	local checkList = {}
	for _, req in pairs(toMake.Ingredients) do
		checkList[tonumber(req)] = checkList[tonumber(req)] or 0
		checkList[tonumber(req)] = checkList[tonumber(req)] + 1
	end
	
	local oldOwner = self:GetTable().Owner
	local oldPos = self:GetPos()
	
	for k, v in pairs(ents.FindInSphere(self:GetPos(), MixRange)) do
		if (v:GetClass() == "ent_item" && v:GetTable().ItemID && (!v:GetTable().Tapped || v:GetTable().Tapped < CurTime()) && checkList[v:GetTable().ItemID] && checkList[v:GetTable().ItemID] > 0) then
			checkList[v:GetTable().ItemID] = checkList[v:GetTable().ItemID] - 1
			v:GetTable().Tapped = CurTime() + 5
			v:Remove()
		end
	end
	
	if (toMake.Results == 13) then		
		local newItem = ents.Create("ent_pot")
			newItem:SetPos(oldPos + Vector(0, 0, 10))
		newItem:Spawn()
		
		newItem.ItemSpawner = oldOwner
	elseif (toMake.Results == 69) then		
		local newItem = ents.Create("ent_coca")
			newItem:SetPos(oldPos + Vector(0, 0, 10))
		newItem:Spawn()
		
		newItem.ItemSpawner = oldOwner
	else
		local results = ITEM_DATABASE[toMake.Results]
		
		local newItem = ents.Create("ent_item")
			newItem:SetPos(oldPos + Vector(0, 0, 10))
			newItem:SetModel(results.WorldModel)
			newItem:SetContents(results.ID, oldOwner)
		newItem:Spawn()
		newItem.ItemOwner = self.ItemOwner or NULL
	end
	
	oldOwner:GiveExperience(SKILL_CRAFTING, GAMEMODE.ExperienceForCraft)
	
	self:EmitSound(combineSound)]]


