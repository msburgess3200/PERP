/////////////////////////////////////////
// © 2011-2012 D3lux - D3lux-Gaming    //
//    All rights reserved    		   //
/////////////////////////////////////////
// This material may not be  		   //
//   reproduced, displayed,  		   //
//  modified or distributed  		   //
// without the express prior 		   //
// written permission of the 		   //
//   the copyright holder.  		   //
//		D3lux-Gaming.com   			   //
/////////////////////////////////////////

local tornadoSpawns = 	{
							Vector(-3554.9829, -652.1917, 64.0000), // Exchange
							Vector(-5996.4771, -5382.1733, 64.0313), // City
							Vector(-4646.3965, 6200.4365, 58.0000), // Trailer house
							Vector(-7220.7598, 11656.9990, 186.0313), // Lake
							Vector(628.5442, 13259.8135, 58.0000), // Suburbs fence
							Vector(11439.2305, 12449.4102, 58.0000), // Suburbs tunnel
							Vector(8627.5791, 4007.4221, 64.0313), // zombie place
							Vector(4806.6621, -5035.2554, 64.0313), // BBH
							Vector(809.8457, 5916.3955, 68.0313), // Industrial
						}


local CLOUDS_CLEAR = 1;
local CLOUDS_PARTLY = 2;
local CLOUDS_MOSTLY_PRE = 3;
local CLOUDS_MOSTLY_POST = 4;
local CLOUDS_STORMY = 5;
local CLOUDS_STORMY_LIGHT = 6;
local CLOUDS_STORMY_PRE = 7;
local CLOUDS_STORMY_SEVERE = 8;
local CLOUDS_HEATWAVE = 9;

local SEASON_SPRING = 1;
local SEASON_SUMMER = 2;
local SEASON_AUTUMN = 3;
local SEASON_WINTER = 4;

local CLOUD_CONDITION_TO_STRING = {"CLOUDS_CLEAR", "CLOUDS_PARTLY", "CLOUDS_MOSTLY_PRE", "CLOUDS_MOSTLY_POST", "CLOUDS_STORMY", "CLOUDS_STORMY_LIGHT", "CLOUDS_STORMY_PRE", "CLOUDS_STORMY_SEVERE", "CLOUDS_HEATWAVE"};
local SEASON_TO_STRING = {"SEASON_SPRING", "SEASON_SUMMER", "SEASON_AUTUMN", "SEASON_WINTER"};

local MONTH_SEASON_CONV = {SEASON_WINTER, SEASON_WINTER, SEASON_SPRING, SEASON_SPRING, SEASON_SPRING, SEASON_SUMMER, SEASON_SUMMER, SEASON_SUMMER, SEASON_AUTUMN, SEASON_AUTUMN, SEASON_AUTUMN, SEASON_WINTER};

local CLOUD_CHANGES = {
						CLOUDS_CLEAR 			= {DAY_LENGTH * .025, DAY_LENGTH * .25},
						CLOUDS_PARTLY			= {DAY_LENGTH * .025, DAY_LENGTH * .25},
						CLOUDS_MOSTLY_PRE 		= {DAY_LENGTH * .025, DAY_LENGTH * .25},
						CLOUDS_STORMY_LIGHT 	= {DAY_LENGTH * .025, DAY_LENGTH * .25},
						CLOUDS_STORMY_PRE		= {DAY_LENGTH * .01, DAY_LENGTH * .025},
						CLOUDS_STORMY 			= {DAY_LENGTH * .025, DAY_LENGTH * .25},
						CLOUDS_STORMY_SEVERE 	= {DAY_LENGTH * .025, DAY_LENGTH * .25},
						CLOUDS_MOSTLY_POST 		= {DAY_LENGTH * .025, DAY_LENGTH * .25},
						CLOUDS_HEATWAVE 		= {DAY_LENGTH * .025, DAY_LENGTH * .25},
					}
					
local SEASON_LIGHT_VALUES = {
								SEASON_WINTER = {
													CLOUDS_CLEAR 			= 'q',
													CLOUDS_HEATWAVE 	 	= 'z',
													
													CLOUDS_PARTLY 			= 'j',
													
													CLOUDS_MOSTLY_PRE 		= 'g',
													CLOUDS_STORMY_LIGHT		= 'g',
													CLOUDS_MOSTLY_POST 	 	= 'g',
													
													CLOUDS_STORMY_PRE 		= 'd',
													CLOUDS_STORMY	 		= 'd',
													
													CLOUDS_STORMY_SEVERE 	= 'c',
												},
												
								SEASON_SPRING = {
													CLOUDS_CLEAR 			= 'z',
													CLOUDS_HEATWAVE 	 	= 'z',
													
													CLOUDS_PARTLY 			= 'l',
													
													CLOUDS_MOSTLY_PRE 		= 'd',
													CLOUDS_STORMY_LIGHT		= 'd',
													CLOUDS_MOSTLY_POST 	 	= 'd',
													
													CLOUDS_STORMY_PRE 		= 'c',
													CLOUDS_STORMY	 		= 'b',
													
													CLOUDS_STORMY_SEVERE 	= 'b',
												},
												
								SEASON_SUMMER = {
													CLOUDS_CLEAR 			= 'z',
													CLOUDS_HEATWAVE 	 	= 'z',
													
													CLOUDS_PARTLY 			= 'l',
													
													CLOUDS_MOSTLY_PRE 		= 'c',
													CLOUDS_STORMY_LIGHT		= 'c',
													CLOUDS_MOSTLY_POST 	 	= 'c',
													
													CLOUDS_STORMY_PRE 		= 'c',
													CLOUDS_STORMY	 		= 'b',
													
													CLOUDS_STORMY_SEVERE 	= 'b',
												},
												
								SEASON_AUTUMN = {
													CLOUDS_CLEAR 			= 'z',
													CLOUDS_HEATWAVE 	 	= 'z',
													
													CLOUDS_PARTLY 			= 'l',
													
													CLOUDS_MOSTLY_PRE 		= 'c',
													CLOUDS_STORMY_LIGHT		= 'c',
													CLOUDS_MOSTLY_POST 	 	= 'c',
													
													CLOUDS_STORMY_PRE 		= 'c',
													CLOUDS_STORMY	 		= 'b',
													
													CLOUDS_STORMY_SEVERE 	= 'b',
												},
							}

local SEASON_TEMP_CLOUDS = {
								SEASON_WINTER = {						// 	     Day, 	      Night
													CLOUDS_CLEAR 			= {	{1, 2}	, 	{-1, 1} },
													CLOUDS_PARTLY 			= {	{0, 1}	, 	{-1, 0} },
													CLOUDS_MOSTLY_PRE 		= {	{-1, 0}	, 	{-2, -1} },
													CLOUDS_STORMY_LIGHT		= {	{-1, 1}	,	{-2, -1} },
													CLOUDS_STORMY_PRE 		= {	{-1, 1}	,	{-2, -1} },
													CLOUDS_STORMY	 		= {	{-1, 1}	,	{-2, -1} },
													CLOUDS_STORMY_SEVERE 	= {	{-1, 1}	,	{-2, -1} },
													CLOUDS_MOSTLY_POST 	 	= {	{-1, 1}	,	{-2, -1} },
													CLOUDS_HEATWAVE 	 	= {	{1, 3}	,	{-0.5, 2} },
												},
												
								SEASON_SPRING = {						// 	     Day, 		  Night
													CLOUDS_CLEAR 			= {	{0, 2}	, 	{-1, 1} },
													CLOUDS_PARTLY 			= {	{0, 2}	, 	{-1, 1} },
													CLOUDS_MOSTLY_PRE 		= {	{0, 1}	, 	{-1, 1} },
													CLOUDS_STORMY_LIGHT		= {	{-1, 0}	,	{-2, 0} },
													CLOUDS_STORMY_PRE 		= {	{-1, 0}	,	{-2, 0} },
													CLOUDS_STORMY	 		= {	{-1, 0}	,	{-2, 0} },
													CLOUDS_STORMY_SEVERE 	= {	{-2, 0}	,	{-2, 0} },
													CLOUDS_MOSTLY_POST 	 	= {	{-1, 0}	,	{-2, 0} },
													CLOUDS_HEATWAVE 	 	= {	{2, 4}	,	{0, 3} },
												},
												
								SEASON_SUMMER = {						// 	     Day, 		  Night
													CLOUDS_CLEAR 			= {	{1, 3}	, 	{-1, 2} },
													CLOUDS_PARTLY 			= {	{1, 2}	, 	{-1, 1} },
													CLOUDS_MOSTLY_PRE 		= {	{0, 1}	, 	{-1, 1} },
													CLOUDS_STORMY_LIGHT		= {	{-1, 1}	,	{-1, 0} },
													CLOUDS_STORMY_PRE 		= {	{0, 1}	,	{-1, 0} },
													CLOUDS_STORMY	 		= {	{-1, 1}	,	{-1, 0} },
													CLOUDS_STORMY_SEVERE 	= {	{-2, 0}	,	{-2, 0} },
													CLOUDS_MOSTLY_POST 	 	= {	{0, 1}	,	{-1, 0} },
													CLOUDS_HEATWAVE 	 	= {	{2, 5}	,	{1, 4} },
												},
												
								SEASON_AUTUMN = {						// 	     Day, 		  Night
													CLOUDS_CLEAR 			= {	{0, 2}	, 	{-1, 1} },
													CLOUDS_PARTLY 			= {	{0, 2}	, 	{-1, 1} },
													CLOUDS_MOSTLY_PRE 		= {	{0, 1}	, 	{-1, 1} },
													CLOUDS_STORMY_LIGHT		= {	{-1, 0}	,	{-2, 0} },
													CLOUDS_STORMY_PRE 		= {	{-1, 0}	,	{-2, 0} },
													CLOUDS_STORMY	 		= {	{-1, 0}	,	{-2, 0} },
													CLOUDS_STORMY_SEVERE 	= {	{-1, 0}	,	{-2, 0} },
													CLOUDS_MOSTLY_POST 	 	= {	{-1, 0}	,	{-2, 0} },
													CLOUDS_HEATWAVE 	 	= {	{2, 4}	,	{0, 3} },
												},
							};

local SEASON_WEATHER_PROB = {
								SEASON_WINTER = {
											CLOUDS_CLEAR = {
													{30, CLOUDS_PARTLY}, 
													{60, CLOUDS_CLEAR}, 
													{10, CLOUDS_MOSTLY_PRE},
												},
											CLOUDS_PARTLY = {
													{40, CLOUDS_CLEAR},
													{30, CLOUDS_PARTLY},
													{30, CLOUDS_MOSTLY_PRE},
												},
											CLOUDS_MOSTLY_PRE = {
													{40, CLOUDS_STORMY_LIGHT},
													{20, CLOUDS_STORMY_PRE}, 
													{30, CLOUDS_MOSTLY_PRE}, 
													{10, CLOUDS_PARTLY}, 
												},
											CLOUDS_STORMY_LIGHT = {
													{30, CLOUDS_STORMY_LIGHT},
													{20, CLOUDS_STORMY},
													{50, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_STORMY_PRE = {
													{100, CLOUDS_STORMY},
												},
											CLOUDS_STORMY = {
													{40, CLOUDS_STORMY},
													{10, CLOUDS_STORMY_SEVERE},
													{50, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_STORMY_SEVERE = {
													{100, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_MOSTLY_POST = {
													{30, CLOUDS_STORMY},
													{40, CLOUDS_PARTLY},
													{30, CLOUDS_CLEAR},
												},
											},
											
								SEASON_SPRING = {
											CLOUDS_CLEAR = {
													{40, CLOUDS_PARTLY},
													{40, CLOUDS_CLEAR}, 
													{10, CLOUDS_HEATWAVE}, 
													{10, CLOUDS_MOSTLY_PRE},
												},
											CLOUDS_HEATWAVE = {
													{100, CLOUDS_CLEAR}, 
												},
											CLOUDS_PARTLY = {
													{20, CLOUDS_CLEAR},
													{25, CLOUDS_PARTLY},
													{55, CLOUDS_MOSTLY_PRE},
												},
											CLOUDS_MOSTLY_PRE = {
													{40, CLOUDS_STORMY_LIGHT},
													{30, CLOUDS_STORMY_PRE},
													{30, CLOUDS_MOSTLY_PRE}, 
												},
											CLOUDS_STORMY_LIGHT = {
													{20, CLOUDS_STORMY_LIGHT},
													{20, CLOUDS_STORMY},
													{60, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_STORMY_PRE = {
													{100, CLOUDS_STORMY},
												},
											CLOUDS_STORMY = {
													{35, CLOUDS_STORMY},
													{25, CLOUDS_STORMY_SEVERE},
													{40, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_STORMY_SEVERE = {
													{100, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_MOSTLY_POST = {
													{30, CLOUDS_STORMY},
													{40, CLOUDS_PARTLY},
													{30, CLOUDS_CLEAR},
												},
											},
											
								SEASON_SUMMER = {
											CLOUDS_CLEAR = {
													{20, CLOUDS_PARTLY}, 
													{50, CLOUDS_CLEAR}, 
													{20, CLOUDS_HEATWAVE}, 
													{10, CLOUDS_MOSTLY_PRE},
												},
											CLOUDS_HEATWAVE = {
													{30, CLOUDS_HEATWAVE}, 
													{70, CLOUDS_CLEAR}, 
												},
											CLOUDS_PARTLY = {
													{25, CLOUDS_CLEAR},
													{20, CLOUDS_PARTLY},
													{55, CLOUDS_MOSTLY_PRE},
												},
											CLOUDS_MOSTLY_PRE = {
													{40, CLOUDS_STORMY_LIGHT},
													{20, CLOUDS_STORMY_PRE},
													{30, CLOUDS_MOSTLY_PRE}, 
													{10, CLOUDS_PARTLY}, 
												},
											CLOUDS_STORMY_LIGHT = {
													{30, CLOUDS_STORMY_LIGHT},
													{10, CLOUDS_STORMY},
													{60, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_STORMY_PRE = {
													{100, CLOUDS_STORMY},
												},
											CLOUDS_STORMY = {
													{40, CLOUDS_STORMY},
													{20, CLOUDS_STORMY_SEVERE},
													{40, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_STORMY_SEVERE = {
													{100, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_MOSTLY_POST = {
													{30, CLOUDS_STORMY},
													{40, CLOUDS_PARTLY},
													{30, CLOUDS_CLEAR},
												},
											},
							
								SEASON_AUTUMN = {
											CLOUDS_CLEAR = {
													{40, CLOUDS_PARTLY}, 
													{40, CLOUDS_CLEAR}, 
													{10, CLOUDS_HEATWAVE}, 
													{10, CLOUDS_MOSTLY_PRE},
												},
											CLOUDS_HEATWAVE = {
													{100, CLOUDS_CLEAR}, 
												},
											CLOUDS_PARTLY = {
													{25, CLOUDS_CLEAR},
													{20, CLOUDS_PARTLY},
													{55, CLOUDS_MOSTLY_PRE},
												},
											CLOUDS_MOSTLY_PRE = {
													{40, CLOUDS_STORMY_LIGHT},
													{20, CLOUDS_STORMY_PRE},
													{30, CLOUDS_MOSTLY_PRE}, 
													{10, CLOUDS_PARTLY}, 
												},
											CLOUDS_STORMY_LIGHT = {
													{20, CLOUDS_STORMY_LIGHT},
													{20, CLOUDS_STORMY},
													{60, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_STORMY_PRE = {
													{100, CLOUDS_STORMY},
												},
											CLOUDS_STORMY = {
													{40, CLOUDS_STORMY},
													{15, CLOUDS_STORMY_SEVERE},
													{45, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_STORMY_SEVERE = {
													{100, CLOUDS_MOSTLY_POST},
												},
											CLOUDS_MOSTLY_POST = {
													{30, CLOUDS_STORMY},
													{40, CLOUDS_PARTLY},
													{30, CLOUDS_CLEAR},
												},
											},
							};

AVERAGE_TEMPERATURES = {
								{20, 41},
								{24, 46},
								{34, 57},
								{44, 67},
								{55, 77},
								{64, 87},
								{69, 93},
								{68, 91},
								{58, 82},
								{45, 69},
								{32, 54},
								{23, 43}
							  };
							  
local TRUE_TEMPERATURES = {};

GM.CurrentTemperature = 30;
GM.CloudCondition = CLOUDS_CLEAR;
GM.NextCloudChange = DAY_LENGTH * .25;
GM.NextTempChange = DAY_LENGTH / 24;
local CLOUD_DIRECTION = 1;

local function setupWeather ( )
	local lastTempHigh = (AVERAGE_TEMPERATURES[1][1] + AVERAGE_TEMPERATURES[1][2] + AVERAGE_TEMPERATURES[1][2]) * (1/3);
	local lastTempLow = (AVERAGE_TEMPERATURES[1][1] + AVERAGE_TEMPERATURES[1][1] + AVERAGE_TEMPERATURES[1][2]) * (1/3);
	local curPattern = -1;
	local nextChange = 2;

	for k, v in pairs(AVERAGE_TEMPERATURES) do
		TRUE_TEMPERATURES[k] = {};
		
		local average = (v[1] + v[2]) * .5;
		local trueMaxMin, trueMinMin = v[2] - 5, v[1] - 5;
		local trueMaxMax, trueMinMax = v[2] + 10, v[1] + 5;
		
		for i = 1, MONTH_DAYS[k] do
			if (nextChange == 0) then
				curPattern = 0;
				
				if (lastTempHigh + lastTempLow) * .5 > average then
					while (curPattern == 0) do
						curPattern = math.Clamp(math.random(-5, 2), -2, 1);
					end
				else
					while (curPattern == 0) do
						curPattern = math.Clamp(math.random(-2, 5), -2, 1);
					end
				end
				
				nextChange = math.random(3, 5);
			end
			nextChange = nextChange - 1;
			
			local thisChangeUpper = math.random(50, 200) * curPattern * .01;
			local thisChangeLower = math.random(50, 200) * curPattern * .01;
			
			lastTempLow = math.Clamp(lastTempLow + thisChangeLower, trueMinMin, trueMinMax);
			lastTempHigh = math.Clamp(lastTempHigh + thisChangeUpper, trueMaxMin, trueMaxMax);
		
			TRUE_TEMPERATURES[k][i] = {lastTempLow, lastTempHigh};
		end
	end
end
hook.Add("Initialize", "setupWeather", setupWeather);

function GM.handleSnow ( )
	local storming = GAMEMODE.CloudCondition == CLOUDS_STORMY || GAMEMODE.CloudCondition == CLOUDS_STORMY_LIGHT || GAMEMODE.CloudCondition == CLOUDS_STORMY_SEVERE;

	if (!GAMEMODE.SnowOnGround && GetGlobalInt("temp", 35) <= 32 && storming && GAMEMODE.LastWeatherChange + 20 <= CurTime()) then
		GAMEMODE.SnowOnGround = true;
	elseif (GAMEMODE.SnowOnGround && GetGlobalInt("temp", 35) > 32 && GAMEMODE.LastWeatherChange + 10 <= CurTime()) then
		GAMEMODE.SnowOnGround = nil;
	end
end
hook.Add("Think", "handleSnow", GM.handleSnow);

local CLOUDS_CLEAR = 1;
local CLOUDS_PARTLY = 2;
local CLOUDS_MOSTLY_PRE = 3;
local CLOUDS_MOSTLY_POST = 4;
local CLOUDS_STORMY = 5;
local CLOUDS_STORMY_LIGHT = 6;
local CLOUDS_STORMY_PRE = 7;
local CLOUDS_STORMY_SEVERE = 8;
local CLOUDS_HEATWAVE = 9;

function GM.calculateWeather ( ) 
	local CurrentSeason = MONTH_SEASON_CONV[GAMEMODE.CurrentMonth];

	// Cloud Conditions
	if (GAMEMODE.NextCloudChange <= 0) then
		GAMEMODE.CloudCondition = GAMEMODE.NextCloudCondition;
		GAMEMODE.NextCloudChange = math.random(DAY_LENGTH * .1, DAY_LENGTH * .5);
		GAMEMODE.LastWeatherChange = CurTime();
		GAMEMODE.NextWeatherChange = CurTime() + GAMEMODE.NextCloudChange;
		
		SetGlobalInt("clouds", GAMEMODE.CloudCondition);
		GAMEMODE.NextCloudCondition = nil
		Msg("Weather pattern changed to '" .. CLOUD_NAMES[GAMEMODE.CloudCondition] .. "'.\n");
		
		if (GAMEMODE.CloudCondition == CLOUDS_STORMY_SEVERE && math.random(1, 2) == 1) then
			local spawnLoc = table.Random(tornadoSpawns);
			
			local tornadoEnt = ents.Create("weather_tornado");
			tornadoEnt:SetPos(spawnLoc);
			tornadoEnt:Spawn();
		end
	end
	GAMEMODE.NextCloudChange = GAMEMODE.NextCloudChange - .5;
	
	if (!GAMEMODE.NextCloudCondition) then
		local rand = math.random(1, 100);
		local ourTable = SEASON_WEATHER_PROB[SEASON_TO_STRING[CurrentSeason]][CLOUD_CONDITION_TO_STRING[GAMEMODE.CloudCondition]];
		
		for k, v in pairs(ourTable) do
			if (rand <= v[1]) then
				GAMEMODE.NextCloudCondition = v[2];
				break;
			else
				rand = rand - v[1];
			end
		end
				
		SetGlobalInt("cloudsf", GAMEMODE.NextCloudCondition);
	end
	
	// Temperature
	if (GAMEMODE.NextTempChange <= 0) then
		local ourTable = SEASON_TEMP_CLOUDS[SEASON_TO_STRING[CurrentSeason]][CLOUD_CONDITION_TO_STRING[GAMEMODE.CloudCondition]];
		
		if (GAMEMODE.CurrentTime < DAWN_START || GAMEMODE.CurrentTime > DUSK_START) then
			ourTable = ourTable[2];
		else
			ourTable = ourTable[1];
		end
		
		local tempChange = math.random(ourTable[1], ourTable[2]);
		
		local trueTempChange = math.random(20, 50) * .01 * tempChange;
		GAMEMODE.CurrentTemperature = math.Clamp(GAMEMODE.CurrentTemperature + trueTempChange, TRUE_TEMPERATURES[GAMEMODE.CurrentMonth][GAMEMODE.CurrentDay][1], TRUE_TEMPERATURES[GAMEMODE.CurrentMonth][GAMEMODE.CurrentDay][2]);
		
		SetGlobalInt("temp", GAMEMODE.CurrentTemperature);
		Msg("Temperature changed to " .. GAMEMODE.CurrentTemperature .. ". ( Change: " .. trueTempChange .. " )\n");
	
		GAMEMODE.NextTempChange = DAY_LENGTH / math.random(30, 60);
	end
	GAMEMODE.NextTempChange = GAMEMODE.NextTempChange - .5;
end

GM.MinSkyAlpha = 0
function GM.manipulateLightTable ( ourTable )
	local originalPattern = ourTable.pattern;
	local CurrentSeason = MONTH_SEASON_CONV[GAMEMODE.CurrentMonth];
	
	local maxLight = SEASON_LIGHT_VALUES[SEASON_TO_STRING[CurrentSeason]][CLOUD_CONDITION_TO_STRING[GAMEMODE.CloudCondition]];
	GAMEMODE.MinSkyAlpha = 255 - (((string.byte(maxLight) - 97) / 25) * 255);
	local newPatByte = math.Clamp(string.byte(ourTable.pattern), string.byte(ourTable.pattern), string.byte(maxLight));
	
	GAMEMODE.LastLightingCond = GAMEMODE.LastLightingCond or newPatByte;
	if (newPatByte > GAMEMODE.LastLightingCond) then
		GAMEMODE.LastLightingCond = GAMEMODE.LastLightingCond + 1;
	elseif (newPatByte < GAMEMODE.LastLightingCond) then
		GAMEMODE.LastLightingCond = GAMEMODE.LastLightingCond - 1;
	end
	
	ourTable.pattern = string.char(GAMEMODE.LastLightingCond);
	
	if (maxLight != 'z' || GAMEMODE.CurrentTemperature <= 33) then
		GAMEMODE.PushDayEffects(false);
	elseif (maxLight == 'z' && originalPattern != 'a') then
		GAMEMODE.PushDayEffects(true);
	end
	
	return ourTable;
end
