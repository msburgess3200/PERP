

local REPLACING_TEXTURES = {	
								"customtext/gc textures/blends/grass_dirt_blend04", 
								{"nature/blendgrassdirt001a"},
								"ajacks/ajacks_grass01",
								"de_train/train_cement_floor_01",
								"highrise/se1_cement_office_floor_01",
								"building_template/roof_template001a",
								"de_nuke/nukroofa",
								"wood/woodshingles002a",
								"cs_havana/swampground01a",
								"maps/rp_evocity_v3x/cs_assault/pavement001a_-7835_-10036_144", // ->
								"maps/rp_evocity_v3x/cs_assault/pavement001a_-8124_-10028_144", // ->
								"maps/rp_evocity_v3x/cs_assault/pavement001a_-9310_-9239_200", // ->
								"maps/rp_evocity_v3x/cs_assault/pavement001a_3498_4227_126", // ->
								"maps/rp_evocity_v3x/cs_assault/pavement001a_-6806_-7527_137", // ->
								"maps/rp_evocity_v3x/cs_assault/pavement001a_-6702_-7698_137", // ->
								"maps/rp_evocity_v3x/cs_assault/pavement001a_-9368_-8601_200", // ->
								"de_nuke/nukroof01",
								"maps/rp_evocity_v3x/nature/blendgrassgravel001a_wvt_patch",
								"de_tides/tides_dirt",
								"concrete/concretefloor006a",
								"nature/blendgrassgravel001a",
								"de_train/train_cementwear_01",
								"ajacks/ajacks_road1", // ->
								"ajacks/ajacks_road2", // ->
								"ajacks/ajacks_road7", // ->
								"ajacks/ajacks_road6", // ->
								"ajacks/ajacks_road8", // ->
								"ajacks/ajacks_road5", // ->
								"ajacks/ajacks_road3", // ->
								"ajacks/ajacks_10", // ->
								"sgtsicktextures/sicknessroad_01", // ->
								"sgtsicktextures/sicknessroad_02", // ->
								"sgtsicktextures/gunroad_01", // ->
								"concrete/concretefloor024a", // ->
								{"nature/blendcliffgrass001a"},
								"maps/rp_evocity_v3x/metal/metalroof005a_-3404_11999_241",
								"concrete/prodroofa",
								"de_prodigy/metal01",
								"de_train/train_cement_floor_02",
								"labs/se1_cement_lab_floor_02",
								"de_tides/tides_grass_a",
								"props/rubberroof002a",
								"metal/metalwall026a",
								"metal/milroof002",
								"maps/rp_evocity_v3x/tile/tileroof004b_-2893_-6215_262",
								"maps/rp_evocity_v3x/tile/tileroof004b_3088_-7809_218",
								"concrete/concretefloor038a", // ->
								"nature/grassfloor002a",
								"maps/rp_evocity_v3x/bridge/se1_concrete_flat_01_3088_-7809_218", // ->
								"maps/rp_evocity_v3x/bridge/se1_concrete_flat_01_10142_14229_123", // ->
								"maps/rp_evocity_v3x/bridge/se1_concrete_flat_01_3498_4227_126", // ->
								"metal/milwall002",
								"maps/rp_evocity_v3x/tile/tileroof004b_-2877_-5493_262",
								"maps/rp_evocity_v3x/tile/tileroof004b_-2770_-7024_262",
								"wood/milroof001",
								"nature/gravelfloor003a", // ->
								"buildings/asph_shingles01",
								"wood/milroof005",
								"de_train/train_grass_floor_01",
								"props/tarpaperroof002a",
								"nature/blendpavedirt01",
								"de_cbble/grassfloor01",
								"maps/rp_evocity_v8x/nature/blendgrassdirt02_noprop_wvt_patch",
								"nature/blendgrassdirt02_noprop",
								"nature/blendgrassdirt02_noprop_wvt_patch",
								"maps/rp_evocity_v8x/cs_italy/cobble03_-6480_-8825_136",
								"de_tides/tides_floor_stone_1",
								"stone/infflrd_blend_dirt",
								
								// Trees
								"models/props/cs_militia/trees3b", // ->
								"models/props/cs_militia/trees1b", // ->
								"models/props/cs_militia/trees3", // ->
								"models/props/cs_militia/trees2", // ->
								"models/props_foliage/tree_deciduous_01a_leaves", // ->
								"models/props_foliage/tree_deciduous_01a_leaves2", // ->
								"models/props_foliage/tree_pine_01_branches", // ->
								"models/trees/g_branch01", // ->
								"models/trees/g_branch02", // ->
								"models/trees/g_branch03", // ->
								"models/trees/g_branch05", // ->
								"models/trees/japanese_tree_round_02", // ->
								"models/trees/japanese_tree_round_03", // ->
								"models/trees/japanese_tree_round_04", // ->
								"models/trees/japanese_tree_round_05", // ->
								"models/msc/e_bigbush", // ->
								"models/msc/e_bigbush3", // ->
								"models/msc/e_leaves", // ->
								"models/msc/e_leaves2", // ->
							};
							
							

function EnableSnow ( )
	if (GAMEMODE.SnowOnGround) then return; end
	GAMEMODE.SnowOnGround = true;
	
	for k, v in pairs(REPLACING_TEXTURES) do
		if (v[1] && v[3]) then
			v[1]:SetMaterialTexture("$basetexture", v[3]);
			
			if (v[4]) then
				v[1]:SetMaterialTexture("$basetexture2", v[3]);
			end
		end
	end
end

local function DisableSnow ( )
	if true then return end
	if (!GAMEMODE.SnowOnGround) then return; end
	GAMEMODE.SnowOnGround = false;
	
	for k, v in pairs(REPLACING_TEXTURES) do
		v[1]:SetMaterialTexture("$basetexture", v[2]);
		
		if (v[4]) then
			v[1]:SetMaterialTexture("$basetexture2", v[4]);
		end
	end
end

local function BuildSnowMaterials ( )
	for k, v in pairs(REPLACING_TEXTURES) do
		local useName = v
		local newTable = {};
		if (type(v) != "string") then
			useName = v[1]
			newTable[4] = Material("Nature/snowfloor001a"):GetTexture("$basetexture2");
		end
	
		local defaultSnowMaterial = Material("Nature/snowfloor001a"):GetTexture("$basetexture");
		
		newTable[1] = Material(useName);
		
		local snowName = "PERP2/snow" .. string.GetFileFromFilename(useName);
		
		if file.Exists("../materials/" .. snowName .. ".vmt","GAME") then
			newTable[3] = Material(snowName):GetTexture("$basetexture");
		else
			newTable[3] = defaultSnowMaterial;
		end
		
		newTable[2] = newTable[1]:GetTexture("$basetexture");
		
		REPLACING_TEXTURES[k] = newTable;
	end
end
hook.Add("Initialize", "BuildSnowMaterials", BuildSnowMaterials);

// Rain
util.PrecacheSound("PERP2.5/rain_heavy.wav");
util.PrecacheSound("PERP2.5/rain_heavy_fadein.wav");
util.PrecacheSound("PERP2.5/rain_heavy_fadeout.wav");
util.PrecacheSound("PERP2.5/rain_shower.wav");
util.PrecacheSound("PERP2.5/rain_shower_fadein.wav");
util.PrecacheSound("PERP2.5/rain_shower_fadeout.wav");

local function initializeRainSounds ( )
	local heavyLoop = CreateSound(LocalPlayer(), "PERP2.5/rain_heavy.wav");
	local lightLoop = CreateSound(LocalPlayer(), "PERP2.5/rain_shower.wav");
	
	local heavyLoopDuration = SoundDuration("PERP2.5/rain_heavy.wav");
	local lightLoopDuration = SoundDuration("PERP2.5/rain_shower.wav");
	
	local stormTables = {};
	// Snow
	stormTables[1] = {};
		stormTables[1][1] = {   ALLOW_SNOWGROUND		= true;   } // Clear skies
		stormTables[1][2] = {   ALLOW_SNOWGROUND		= true;   } // Partly Cloudy
		stormTables[1][3] = {   ALLOW_SNOWGROUND		= true;   } // Mostly Cloudy 
		stormTables[1][4] = {   ALLOW_SNOWGROUND		= true;   } // Mostly Cloudy
	
		// Stormy
		stormTables[1][5] = {
								SHOULD_SNOWGROUND 		= true;
								ALLOW_SNOWGROUND		= true;
								PRECIP_EFFECT			= "snow_heavy",
							}
		// Stormy_Light
		stormTables[1][6] = {
								SHOULD_SNOWGROUND 		= true;
								ALLOW_SNOWGROUND		= true;
								PRECIP_EFFECT			= "snow_light",
							}
		// Stormy_Pre
		stormTables[1][7] = {
								SHOULD_SNOWGROUND 		= true;
								ALLOW_SNOWGROUND		= true;
								PRECIP_EFFECT			= "snow_light",
							}
		// Stormy_Severe
		stormTables[1][8] = {
								SHOULD_SNOWGROUND 		= true;
								ALLOW_SNOWGROUND		= true;
								PRECIP_EFFECT			= "snow_blizzard",
							}
							
		stormTables[1][9] = {   ALLOW_SNOWGROUND		= true;   } // Heatwave
							
	// "Slush"
	stormTables[2] = {};
		stormTables[2][1] = {   ALLOW_SNOWGROUND		= false;   } // Clear skies
		stormTables[2][2] = {   ALLOW_SNOWGROUND		= true;   } // Partly Cloudy
		stormTables[2][3] = {   ALLOW_SNOWGROUND		= true;   } // Mostly Cloudy 
		stormTables[2][4] = {   ALLOW_SNOWGROUND		= true;   } // Mostly Cloudy
		
		// Stormy
		stormTables[2][5] = {
								FADE_IN_SOUND			= "rain_shower_fadein.wav",
								FADE_OUT_SOUND			= "rain_shower_fadeout.wav",
								LOOP_SOUND				= lightLoop,
								LOOP_SOUND_DURATION		= lightLoopDuration,
		
								PRECIP_EFFECT			= "rain_light",
								ALLOW_SNOWGROUND		= true;
							}
		// Stormy_Light
		stormTables[2][6] = {
								FADE_IN_SOUND			= "rain_shower_fadein.wav",
								FADE_OUT_SOUND			= "rain_shower_fadeout.wav",
								LOOP_SOUND				= lightLoop,
								LOOP_SOUND_DURATION		= lightLoopDuration,
		
								PRECIP_EFFECT			= "rain_light",
								ALLOW_SNOWGROUND		= true;
							}
		// Stormy_Pre
		stormTables[2][7] = {
								ALLOW_SNOWGROUND		= true;
							}
		// Stormy_Severe
		stormTables[2][8] = {
								FADE_IN_SOUND			= "rain_heavy_fadein.wav",
								FADE_OUT_SOUND			= "rain_heavy_fadeout.wav",
								LOOP_SOUND				= heavyLoop,
								LOOP_SOUND_DURATION		= heavyLoopDuration,
								
								PRECIP_EFFECT			= "rain_heavy",
							}
		
		stormTables[2][9] = {   ALLOW_SNOWGROUND		= false;   } // Heatwave
	
	// Rain
	stormTables[3] = {};
		// Stormy
		stormTables[3][5] = {
								FADE_IN_SOUND			= "rain_heavy_fadein.wav",
								FADE_OUT_SOUND			= "rain_heavy_fadeout.wav",
								LOOP_SOUND				= heavyLoop,
								LOOP_SOUND_DURATION		= heavyLoopDuration,
								
								PRECIP_EFFECT			= "rain_heavy",
								
								SHOULD_LIGHTNING		= true,
								SHOULD_THUNDER			= true,
								THUNDER_FREQUENCY		= function ( ) return math.random(5, 15); end,
							}
		// Stormy_Light
		stormTables[3][6] = {
								FADE_IN_SOUND			= "rain_shower_fadein.wav",
								FADE_OUT_SOUND			= "rain_shower_fadeout.wav",
								LOOP_SOUND				= lightLoop,
								LOOP_SOUND_DURATION		= lightLoopDuration,
								
								PRECIP_EFFECT			= "rain_light",
							}
		// Stormy_Pre
		stormTables[3][7] = {
								SHOULD_THUNDER			= true;
								LIGHTNING_FREQUENCY 	= 3;
								THUNDER_FREQUENCY		= function ( ) return math.random(10, 25); end,
							}
		// Stormy_Severe
		stormTables[3][8] = {
								FADE_IN_SOUND			= "rain_heavy_fadein.wav",
								FADE_OUT_SOUND			= "rain_heavy_fadeout.wav",
								LOOP_SOUND				= heavyLoop,
								LOOP_SOUND_DURATION		= heavyLoopDuration,
								
								PRECIP_EFFECT			= "rain_heavy",
								
								SHOULD_LIGHTNING		= true,
								SHOULD_THUNDER			= true,
								THUNDER_FREQUENCY		= function ( ) return math.random(1, 7); end,
							}
							
	GAMEMODE.StormTable = stormTables;
end
hook.Add("InitPostEntity", "initializeRainSounds", initializeRainSounds);

// Actual stuff.
local lastWeather = 0;
local lastStormTable = nil;
local nextSound = 0;
local nextPrecip = 0;
local nextThunder = 0;
local lastLighteningTime = 0;
local lighteningTime = .5;
local allowSnow = 0;

local CLOUDS_STORMY = 5;
local CLOUDS_STORMY_LIGHT = 6;
local CLOUDS_STORMY_PRE = 7;
local CLOUDS_STORMY_SEVERE = 8;

local function weatherThink ( )
	// Standard global stuff
	local currentWeather = GetGlobalInt("clouds", 1);
	local currentTemp = GetGlobalInt("temp", 30);
	
	// Discover our storm values;
	local shouldSnow = currentTemp <= 34;
	local shouldSlush = currentTemp < 37 && currentTemp > 34;
	local shouldRain = currentTemp >= 38;
	
	local ourShouldVal = 1;
	if (shouldSlush) then ourShouldVal = 2; end
	if (shouldRain) then ourShouldVal = 3; end
	
	// Transition noises
	if (currentWeather != lastWeather && LocalPlayer():IsOutside()) then
		local currentStormTable = GAMEMODE.StormTable[ourShouldVal][currentWeather];
		
		if (currentStormTable && currentStormTable["FADE_IN_SOUND"]) then
			if (!lastStormTable || !lastStormTable["LOOP_SOUND"]) then
				// They weren't playing a sound. Lets fade in.
				surface.PlaySound("PERP2.5/" .. currentStormTable["FADE_IN_SOUND"]);
				nextSound = CurTime() + SoundDuration("PERP2.5/" .. currentStormTable["FADE_IN_SOUND"]);
			end
		elseif (lastStormTable &&  lastStormTable["LOOP_SOUND"]) then
			lastStormTable["LOOP_SOUND"]:Stop()
			surface.PlaySound("PERP2.5/" .. lastStormTable["FADE_OUT_SOUND"]);
			nextSound = CurTime() + SoundDuration("PERP2.5/" .. lastStormTable["FADE_OUT_SOUND"]);
		end
		
		lastStormTable = currentStormTable;
		lastWeather = currentWeather;
		allowSnow = CurTime() + math.random(10, 20);
	end
	
	// Looping sounds.
	if (lastStormTable && lastStormTable["LOOP_SOUND"] && nextSound <= CurTime() && LocalPlayer():IsOutside()) then
		lastStormTable["LOOP_SOUND"]:Stop();
		lastStormTable["LOOP_SOUND"]:Play();
		nextSound = CurTime() + (lastStormTable["LOOP_SOUND_DURATION"] * .98);
	elseif (LocalPlayer():IsInside() && !LocalPlayer().startInside) then
		LocalPlayer().startInside = CurTime()
	elseif (lastStormTable && LocalPlayer():IsInside() && lastStormTable["LOOP_SOUND"] && LocalPlayer().startInside && LocalPlayer().startInside + 5 < CurTime()) then
		lastStormTable["LOOP_SOUND"]:Stop();
	elseif (LocalPlayer():IsOutside()) then
		LocalPlayer().startInside = nil;
	end
	
	// Precipitation
	if (lastStormTable && lastStormTable["PRECIP_EFFECT"] && nextPrecip <= CurTime()) then	
		util.Effect(lastStormTable["PRECIP_EFFECT"], EffectData());
		
		if (lastStormTable["PRECIP_EFFECT"] == "rain_heavy") then
			nextPrecip = CurTime() + .5;
		else
			nextPrecip = CurTime() + 1;
		end
	end
	
	// Thunder
	if (lastStormTable && lastStormTable["SHOULD_THUNDER"] && nextThunder <= CurTime()) then	
		surface.PlaySound('ambient/atmosphere/thunder' .. math.random(1, 4) .. '.wav');
		
		if (lastStormTable["SHOULD_LIGHTNING"] && LocalPlayer():IsOutside()) then
			if (LIGHTNING_FREQUENCY && math.random(1, LIGHTNING_FREQUENCY) == 1) then
				lastLighteningTime = CurTime();
			elseif (!LIGHTNING_FREQUENCY) then
				lastLighteningTime = CurTime();
			end
		end
		
		nextThunder = CurTime() + lastStormTable.THUNDER_FREQUENCY();
	end
	
	if (GAMEMODE.SnowOnGround && allowSnow < CurTime() && (!lastStormTable || !lastStormTable["ALLOW_SNOWGROUND"] || currentTemp > 32)) then
		DisableSnow();
	elseif (lastStormTable && lastStormTable["SHOULD_SNOWGROUND"] && allowSnow < CurTime()) then
		EnableSnow();
	end
end
hook.Add("Think", "weatherThink", weatherThink);

function GM.WeatherEffects ( )	
	if render.SupportsPixelShaders_2_0() && lastLighteningTime + lighteningTime > CurTime() then	
		local bloom = {};
		bloom.darken = 0;
	
		local DoPerc
		if lastLighteningTime + (lighteningTime * .5) > CurTime() then
			DoPerc = (CurTime() - lastLighteningTime) / (lighteningTime * .5);
		else
			DoPerc = 1 - ((CurTime() - (lastLighteningTime + (lighteningTime * .5))) / (lighteningTime * .5));// going down
		end
		
		bloom.multiply = 1.1 * DoPerc;
		bloom.sizex = 3 * DoPerc;
		bloom.sizey = 3 * DoPerc;
		bloom.passes = 4 * DoPerc;
		
		DrawBloom(bloom.darken, bloom.multiply, bloom.sizex, bloom.sizey, math.Round(bloom.passes), 0, 1, 1, 1);
	end
end
hook.Add("RenderScreenspaceEffects", "GM.WeatherEffects", GM.WeatherEffects)

function GM.GetWeatherSpawnPos ( PredictSpeed, Filter )
	local SPos = {}
	SPos.start = LocalPlayer():GetPos() + PredictSpeed;
	SPos.endpos = SPos.start + Vector(0,0,51200);
	SPos.filter = Filter
	
	local TrRes = util.TraceLine(SPos);
	
	local SpawnPos;
	if (TrRes.HitSky) then
		local SPos = {}
		SPos.start = LocalPlayer():GetPos() + PredictSpeed;
		SPos.endpos = SPos.start + Vector(0,0,1024);
		SPos.filter = Filter
		
		local TrRes2 = util.TraceLine(SPos);
			
		SpawnPos = TrRes2.HitPos;
	else
		local SPos = {}
		SPos.start = LocalPlayer():GetPos() + PredictSpeed;
		SPos.endpos = SPos.start + Vector(0,0,51200);
		SPos.filter = Filter
		
		local TrRes2 = util.TraceLine(SPos);
			
		SpawnPos = TrRes2.HitPos + Vector(0, 0, 128);
	end
	
	return SpawnPos;
end
