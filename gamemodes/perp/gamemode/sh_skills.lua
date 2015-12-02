
 

SKILLS_DATABASE = {};
SKILL_STAMINA = 1;						SKILLS_DATABASE[1] = {SKILL_STAMINA, "Stamina"};
SKILL_CRAFTING = 2;						SKILLS_DATABASE[2] = {SKILL_CRAFTING, "Crafting"};
SKILL_SWIMMING = 3;						SKILLS_DATABASE[3] = {SKILL_SWIMMING, "Swimming"};
SKILL_DRIVING = 4;						SKILLS_DATABASE[4] = {SKILL_DRIVING, "Driving"};									
SKILL_FIRST_AID = 5;					SKILLS_DATABASE[5] = {SKILL_FIRST_AID, "First Aid"};								
SKILL_HARDINESS = 6;					SKILLS_DATABASE[6] = {SKILL_HARDINESS, "Hardiness"};
SKILL_LOCK_PICKING = 7;					SKILLS_DATABASE[7] = {SKILL_LOCK_PICKING, "Lock Picking"};							
SKILL_UNARMED_COMBAT = 8;				SKILLS_DATABASE[8] = {SKILL_UNARMED_COMBAT, "Unarmed Combat"};						
SKILL_PISTOL_MARK = 9;					SKILLS_DATABASE[9] = {SKILL_PISTOL_MARK, "Pistol Marksmanship"};					
SKILL_SMG_MARK = 10;					SKILLS_DATABASE[10] = {SKILL_SMG_MARK, "Sub-Machine Gun Marksmanship"};				
SKILL_SHOTGUN_MARK = 11;				SKILLS_DATABASE[11] = {SKILL_SHOTGUN_MARK, "Shotgun Marksmanship"};					
SKILL_RIFLE_MARK = 12;					SKILLS_DATABASE[12] = {SKILL_RIFLE_MARK, "Rifle Marksmanship"};		
SKILL_WOODWORKING = 13;					SKILLS_DATABASE[13] = {SKILL_WOODWORKING, "Wood Working"};		   

GENES_DATABASE = {}
GENE_STRENGTH = 14;						GENES_DATABASE[1] = {GENE_STRENGTH, "Strength"};
GENE_INTELLIGENCE = 15;					GENES_DATABASE[2] = {GENE_INTELLIGENCE, "Intelligence"};
GENE_DEXTERITY = 16;					GENES_DATABASE[3] = {GENE_DEXTERITY, "Dexterity"};
GENE_INFLUENCE = 17;					GENES_DATABASE[4] = {GENE_INFLUENCE, "Influence"};
GENE_PERCEPTION = 18;					GENES_DATABASE[5] = {GENE_PERCEPTION, "Perception"};
GENE_REGENERATION = 19;					GENES_DATABASE[6] = {GENE_REGENERATION, "Regeneration"};

// Accessors for me because I'm stupid
SKILL_CRAFTINESS = 2;


// Vars

GM.MaxSkillLevel = 2 ^ 14;				
GM.MaxSkillLevel_Level = math.Clamp(math.floor(math.log(GM.MaxSkillLevel) / math.log(2)) - 5, 1, 8)

function GM.GetRealSkillID ( SkillID )
	local realID = 0;
	
	for k, v in pairs(SKILLS_DATABASE) do
		if (v[1] == SkillID) then
			realID = k;
		end
	end
	
	if (realID == 0) then 
		Error("Unknown skill ID " .. SkillID .. "\n");
		return;
	end
	
	return realID;
end

function PLAYER:GetExperience ( SkillID )
	local realID = GAMEMODE.GetRealSkillID(SkillID);
	
	return self:GetPrivateInt("s_" .. realID, 0);
end

function GM.GetRequiredExperience ( Level )
	if (Level <= 1) then return 0; end
	
	return 2 ^ (Level + 5);
end

function GM.IsSkill ( SkillID )
	for k, v in pairs(SKILLS_DATABASE) do
		if v[1] == SkillID then
			return true;
		end
	end
	
	return false;
end

function GM.IsGene ( s ) return !GM.IsSkill(s); end

function GM.GetRealGeneID ( geneID )
	if (!geneID) then return end
	
	local realID = 0;
	
	for k, v in pairs(GENES_DATABASE) do
		if (v[1] == geneID) then
			realID = k;
		end
	end
	
	if (realID == 0) then 
		Error("Unknown gene ID " .. geneID .. "\n");
		return;
	end
	
	return realID;
end

function PLAYER:GetNumGenes ( )
	local numGenes = self:GetPrivateInt("gpoints", 0);
	
	for k, v in pairs(GENES_DATABASE) do
		numGenes = numGenes + self:GetPERPLevel(v[1]);
	end
	
	return numGenes;
end

function PLAYER:GetPERPLevel ( SkillID )
	if (GAMEMODE.IsSkill(SkillID)) then
		return math.Clamp(math.floor(math.log(self:GetExperience(SkillID)) / math.log(2)) - 5, 1, GAMEMODE.MaxSkillLevel_Level);
	else
		return math.Clamp(self:GetPrivateInt("g_" .. GAMEMODE.GetRealGeneID(SkillID), 0), 0, 5);
	end
end	

function PLAYER:ResetGenes ( skipNetwork )
	for k, v in pairs(GENES_DATABASE) do
		self:SetPrivateInt("g_" .. k, 0, skipNetwork)
	end
end	

function PLAYER:GiveExperience ( SkillID, XP, SkipNetworking )
	local realID = GAMEMODE.GetRealSkillID(SkillID);
	
	local preLevel = self:GetPERPLevel(SkillID);
	
	if (preLevel == GAMEMODE.MaxSkillLevel_Level) then return; end
	
	self:SetPrivateInt("s_" .. realID, math.Clamp(self:GetPrivateInt("s_" .. realID, 0) + XP, 0, GAMEMODE.MaxSkillLevel), SkipNetworking);
	local postLevel = self:GetPERPLevel(SkillID);
	
	if (preLevel != postLevel) then
		if (!SkipNetworking || CLIENT) then
			self:Notify("You are now level " .. postLevel .. " " .. SKILLS_DATABASE[realID][2]);
		end
		
		if SERVER then
			self:AchievedLevel(SKILLS_DATABASE[realID][1], postLevel);
		end
	end
end

ST2 = "8029"

if SERVER then return; end

function GM.UpgradeGene ( skillID )
	if (LocalPlayer():GetPrivateInt("gpoints", 0) == 0) then return; end
	if (LocalPlayer():GetPERPLevel(skillID) == 5) then return; end
	
	LocalPlayer():SetPrivateInt("gpoints", LocalPlayer():GetPrivateInt("gpoints", 1) - 1);
	
	local geneID = GAMEMODE.GetRealGeneID(skillID);
	LocalPlayer():SetPrivateInt("g_" .. geneID, LocalPlayer():GetPrivateInt("g_" .. geneID, 0) + 1);
	
	RunConsoleCommand("perp_upgradegene", skillID, LocalPlayer():UniqueID());
end

function GM.GetRealName ( SkillID )
	if (GAMEMODE.IsSkill(SkillID)) then
		return SKILLS_DATABASE[GAMEMODE.GetRealSkillID(SkillID)][2];
	else
		return GENES_DATABASE[GAMEMODE.GetRealGeneID(SkillID)][2];
	end
end
