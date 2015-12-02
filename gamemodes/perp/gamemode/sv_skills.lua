


local function UpgradeGene ( Player, Cmd, Args )
	if (Player:GetPrivateInt("gpoints", 0) == 0) then return; end
	if (!Args[1]) then return; end
	if (Args[2] != Player:UniqueID()) then return; end
	local skillID = tonumber(Args[1]);
	if (Player:GetPERPLevel(skillID) == 5) then return; end
	
	Player:SetPrivateInt("gpoints", Player:GetPrivateInt("gpoints", 1) - 1);
	
	local geneID = GAMEMODE.GetRealGeneID(skillID);
	if (!geneID) then return; end
	
	Player:SetPrivateInt("g_" .. geneID, Player:GetPrivateInt("g_" .. geneID, 0) + 1, true);
end
concommand.Add("perp_upgradegene", UpgradeGene);

local function ResetGenes ( Player, Cmd, Args )
	if (!Player) then return; end
	if (Player:GetBank() < GAMEMODE.GeneResetPrice) then return; end
	
	Player:SetPrivateInt("gpoints", Player:GetNumGenes(), true);
	Player:ResetGenes(true);
	Player:TakeBank(GAMEMODE.GeneResetPrice, true);
end
concommand.Add("perp_s_r", ResetGenes);

local function BuyGene ( Player, Cmd, Args )
	if (!Player) then return; end
	if (Args[1] != Player:UniqueID()) then return; end
	
	local cost = (((GAMEMODE.MaxGenes - 5) - (GAMEMODE.MaxGenes - Player:GetNumGenes())) + 1) * GAMEMODE.NewGenePrice
	
	if (Player:GetBank() < cost) then return; end
	if (Player:GetNumGenes() >= GAMEMODE.MaxGenes) then return; end
	
	Player:SetPrivateInt("gpoints", Player:GetPrivateInt("gpoints", 0) + 1, true);
	Player:TakeBank(cost, true);
end
concommand.Add("perp_s_b", BuyGene);

function PLAYER:AchievedLevel ( skillID, newLevel )
	// Unlock Five-Seven
	if (skillID == SKILL_PISTOL_MARK && newLevel >= 3) then
		self:UnlockMixture(11);
	end
	
	// Unlock Desert Deagle
	if (skillID == SKILL_PISTOL_MARK && newLevel >= 4) then
		self:UnlockMixture(12);
	end
	
	// Unlock Shotgun
	if (skillID == SKILL_PISTOL_MARK && newLevel >= 6) then
		self:UnlockMixture(9);
	end
	
	// Unlock Uzi
	if (skillID == SKILL_SHOTGUN_MARK && newLevel >= 4) then
		self:UnlockMixture(8);
	end
	
	// Unlock AK-47
	if (skillID == SKILL_SMG_MARK && newLevel >= 4) then
		self:UnlockMixture(4);
	end
end

