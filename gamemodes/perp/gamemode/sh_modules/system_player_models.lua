


// Helpers
SEX_MALE = 1;
SEX_FEMALE = 2;
SEX_TO_STRING = {"m", "f"};

// AVAILABLE_MALE_MODELS[SEX][FACE_ID] = {AVAILABLE_CLOTHES}
MODEL_AVAILABLE = {};

MODEL_AVAILABLE["f"] = {};
MODEL_AVAILABLE["f"][1] = {1, 2, 3, 4, 5};
MODEL_AVAILABLE["f"][2] = {1, 2, 3, 4, 5};
MODEL_AVAILABLE["f"][3] = {1, 2, 3, 4, 5};
MODEL_AVAILABLE["f"][4] = {1, 2, 3, 4, 5};
MODEL_AVAILABLE["f"][6] = {1, 2, 3, 4, 5};
MODEL_AVAILABLE["f"][7] = {1, 2, 3, 4, 5};

MODEL_AVAILABLE["m"] = {};
MODEL_AVAILABLE["m"][1] = {1, 2, 3, 4, 5, 6, 8};
MODEL_AVAILABLE["m"][2] = {1, 2, 3, 4, 5, 6, 8};
MODEL_AVAILABLE["m"][3] = {1, 2, 3, 4, 5, 6, 8};
MODEL_AVAILABLE["m"][4] = {1, 2, 3, 4, 5, 6, 8};
MODEL_AVAILABLE["m"][5] = {1, 2, 3, 4, 5, 6, 8};
MODEL_AVAILABLE["m"][6] = {1, 2, 3, 4, 5, 6, 8};
MODEL_AVAILABLE["m"][7] = {1, 2, 3, 4, 5, 6, 8};
MODEL_AVAILABLE["m"][8] = {1, 2, 3, 4, 5, 6, 8};
MODEL_AVAILABLE["m"][9] = {1, 2, 3, 4, 5, 6, 8};

JOB_MODELS = {}
JOB_MODELS[TEAM_POLICE] = {};
JOB_MODELS[TEAM_POLICE][1] = "models/humans/SCPD/male_01.mdl";
JOB_MODELS[TEAM_POLICE][2] = "models/humans/SCPD/male_02.mdl";
JOB_MODELS[TEAM_POLICE][3] = "models/humans/SCPD/male_03.mdl";
JOB_MODELS[TEAM_POLICE][4] = "models/humans/SCPD/male_04.mdl";
JOB_MODELS[TEAM_POLICE][5] = "models/humans/SCPD/male_05.mdl";
JOB_MODELS[TEAM_POLICE][6] = "models/humans/SCPD/male_06.mdl";
JOB_MODELS[TEAM_POLICE][7] = "models/humans/SCPD/male_07.mdl";
JOB_MODELS[TEAM_POLICE][8] = "models/humans/SCPD/male_08.mdl";
JOB_MODELS[TEAM_POLICE][9] = "models/humans/SCPD/male_09.mdl";

JOB_MODELS[TEAM_SECRET_SERVICE] = {};
JOB_MODELS[TEAM_SECRET_SERVICE][1] = "models/players/perp2suit/male_01.mdl";
JOB_MODELS[TEAM_SECRET_SERVICE][2] = "models/players/perp2suit/male_02.mdl";
JOB_MODELS[TEAM_SECRET_SERVICE][3] = "models/players/perp2suit/male_03.mdl";
JOB_MODELS[TEAM_SECRET_SERVICE][4] = "models/players/perp2suit/male_04.mdl";
JOB_MODELS[TEAM_SECRET_SERVICE][5] = "models/players/perp2suit/male_05.mdl";
JOB_MODELS[TEAM_SECRET_SERVICE][6] = "models/players/perp2suit/male_06.mdl";
JOB_MODELS[TEAM_SECRET_SERVICE][7] = "models/players/perp2suit/male_07.mdl";
JOB_MODELS[TEAM_SECRET_SERVICE][8] = "models/players/perp2suit/male_08.mdl";
JOB_MODELS[TEAM_SECRET_SERVICE][9] = "models/players/perp2suit/male_09.mdl";

JOB_MODELS[TEAM_FIREMAN] = {}
JOB_MODELS[TEAM_FIREMAN][1] = "models/players/perp2/fire_01.mdl";
JOB_MODELS[TEAM_FIREMAN][2] = "models/players/perp2/fire_02.mdl";
JOB_MODELS[TEAM_FIREMAN][3] = "models/players/perp2/fire_03.mdl";

JOB_MODELS[TEAM_SWAT] = "models/player/swa2.mdl";


JOB_MODELS[TEAM_MAYOR] = {};
JOB_MODELS[TEAM_MAYOR][SEX_MALE] = "models/player/breen.mdl";
JOB_MODELS[TEAM_MAYOR][SEX_FEMALE]= "models/player/mossman.mdl"

JOB_MODELS[TEAM_MEDIC] = {};
JOB_MODELS[TEAM_MEDIC][SEX_MALE] = {};
JOB_MODELS[TEAM_MEDIC][SEX_MALE][1] = "models/players/perp2/m_1_07.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_MALE][2] = "models/players/perp2/m_2_07.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_MALE][3] = "models/players/perp2/m_3_07.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_MALE][4] = "models/players/perp2/m_4_07.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_MALE][5] = "models/players/perp2/m_5_07.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_MALE][6] = "models/players/perp2/m_6_07.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_MALE][7] = "models/players/perp2/m_7_07.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_MALE][8] = "models/players/perp2/m_8_07.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_MALE][9] = "models/players/perp2/m_9_07.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_FEMALE] = {}
JOB_MODELS[TEAM_MEDIC][SEX_FEMALE][1] = "models/players/perp2/f_1_06.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_FEMALE][2] = "models/players/perp2/f_2_06.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_FEMALE][3] = "models/players/perp2/f_3_06.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_FEMALE][4] = "models/players/perp2/f_4_06.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_FEMALE][6] = "models/players/perp2/f_6_06.mdl";
JOB_MODELS[TEAM_MEDIC][SEX_FEMALE][7] = "models/players/perp2/f_7_06.mdl";

CAM_LOOK_AT = {};
CAM_LOOK_AT[SEX_MALE] = Vector(-1, 0, 67);
CAM_LOOK_AT[SEX_FEMALE] = Vector(-1, 0, 65);
CAM_LOOK_AT["f"] = CAM_LOOK_AT[SEX_FEMALE];
CAM_LOOK_AT["m"] = CAM_LOOK_AT[SEX_MALE];


// MODEL_REDIRECTS
MODEL_REDIRECTS = {};
MODEL_REDIRECTS["m_1_08"] = "models/players/perp2suit/male_01.mdl";
MODEL_REDIRECTS["m_2_08"] = "models/players/perp2suit/male_02.mdl";
MODEL_REDIRECTS["m_3_08"] = "models/players/perp2suit/male_03.mdl";
MODEL_REDIRECTS["m_4_08"] = "models/players/perp2suit/male_04.mdl";
MODEL_REDIRECTS["m_5_08"] = "models/players/perp2suit/male_05.mdl";
MODEL_REDIRECTS["m_6_08"] = "models/players/perp2suit/male_06.mdl";
MODEL_REDIRECTS["m_7_08"] = "models/players/perp2suit/male_07.mdl";
MODEL_REDIRECTS["m_8_08"] = "models/players/perp2suit/male_08.mdl";
MODEL_REDIRECTS["m_9_08"] = "models/players/perp2suit/male_09.mdl";

// MODEL_RESTRICTIONS
MODEL_RESTRICTIONS = {};
MODEL_RESTRICTIONS["m_1_08"] = 998;
MODEL_RESTRICTIONS["m_2_08"] = 998;
MODEL_RESTRICTIONS["m_3_08"] = 998;
MODEL_RESTRICTIONS["m_4_08"] = 998;
MODEL_RESTRICTIONS["m_5_08"] = 998;
MODEL_RESTRICTIONS["m_6_08"] = 998;
MODEL_RESTRICTIONS["m_7_08"] = 998;
MODEL_RESTRICTIONS["m_8_08"] = 998;
MODEL_RESTRICTIONS["m_9_08"] = 998;

// Helper functions
function GM.ExplodeModelInfo ( path )
	local split = string.Explode("_", path);
	
	local newTable = {};
	
	newTable.sex = SEX_MALE;
	if (split[1] == "f") then newTable.sex = SEX_FEMALE; end
	if (tonumber(split[1]) == 2) then newTable.sex = SEX_FEMALE; end
	
	newTable.face = tonumber(split[2]);
	newTable.clothes = tonumber(split[3]);
	
	return newTable;
end

function PLAYER:GetModelInfo ( )
	return GAMEMODE.ExplodeModelInfo(string.gsub(string.gsub(string.GetFileFromFilename(self:GetPrivateString("model", self:GetModel())), ".mdl", ""), "/", ""));
end

function PLAYER:GetSex ( ) return self:GetModelInfo().sex; end
function PLAYER:GetFace ( ) return tonumber(self:GetModelInfo().face or 1) or 1; end
function PLAYER:GetClothes ( ) return self:GetModelInfo().clothes; end

function PLAYER:GetModelPath ( sex, face, clothes )
	if (type(sex) == "number") then
		if (sex == SEX_MALE) then
			sex = "m";
		else
			sex = "f";
		end
	end
	
	if (!MODEL_AVAILABLE[sex][tonumber(face)]) then
		face = 1;
	end
	
	local clothesExists = false;
	for k, v in pairs(MODEL_AVAILABLE[sex][tonumber(face)]) do
		if (v == tonumber(clothes)) then
			clothesExist = true;
		end
	end
	
	if (!clothesExist) then clothes = 1; end
	
	if (clothes < 10) then
		clothes = "0" .. tonumber(clothes);
	end
	
	local tempPath = sex .. "_" .. face .. "_" .. clothes;
	
	if (MODEL_RESTRICTIONS[tempPath]) then
		if (!self:HasAccessLevel(MODEL_RESTRICTIONS[tempPath])) then
			tempPath = sex .. "_" .. face .. "_01";
		end
	end
	
	if (MODEL_REDIRECTS[tempPath]) then
		return MODEL_REDIRECTS[tempPath];
	else
		return "models/players/perp2/" .. tempPath .. ".mdl";
	end
end
