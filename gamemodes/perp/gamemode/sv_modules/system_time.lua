


local LIGHT_LOW 	= string.byte('a');
local LIGHT_HIGH 	= string.byte('z');

GM.timeEntities = {};
local lightTable = {};

GM.CurrentTime = NOON;

GM.CurrentMonth = 1;
GM.CurrentDay = 1;
GM.CurrentYear = 1;
GM.CanSaveDate = false;
GM.CurFoggy = false;

function GM.SaveDate ( )
	Msg("Current in-game date: " .. GAMEMODE.CurrentMonth .. "/" .. GAMEMODE.CurrentDay .. "/" .. GAMEMODE.CurrentYear .. "\n");
	
	if (!GAMEMODE.CanSaveDate) then Msg("Not saving date...\n"); return false; end
	
	if (GAMEMODE.LastSaveYear != GAMEMODE.CurrentYear) then
		tmysql.query("UPDATE `perp_system` SET `value`='" .. GAMEMODE.CurrentYear .. "' WHERE `key`='date_year_" .. GAMEMODE.ServerDateIdentifier .. "' LIMIT 1");
	end
	
	if (GAMEMODE.LastSaveMonth != GAMEMODE.CurrentMonth) then
		tmysql.query("UPDATE `perp_system` SET `value`='" .. GAMEMODE.CurrentMonth .. "' WHERE `key`='date_month_" .. GAMEMODE.ServerDateIdentifier .."' LIMIT 1");
	end
	
	if (GAMEMODE.LastSaveDay != GAMEMODE.CurrentDay) then
		tmysql.query("UPDATE `perp_system` SET `value`='" .. GAMEMODE.CurrentDay .. "' WHERE `key`='date_day_" .. GAMEMODE.ServerDateIdentifier .."' LIMIT 1");
	end

	GAMEMODE.LastSaveYear = GAMEMODE.CurrentYear;
	GAMEMODE.LastSaveMonth = GAMEMODE.CurrentMonth;
	GAMEMODE.LastSaveDay = GAMEMODE.CurrentDay;
end

local function WrapAngles(ang)
	if ( ang > 360 ) then
		ang = ang - 360
	elseif ( ang < 0 ) then
		ang = ang + 360
 	end
	return ang
end

local function buildLightTable ( )
	local startTime = CurTime();
	Msg("Building lighting tables... ");
	
	for x = 1, DAY_LENGTH * 2 do
		local i = x / 2;
		// reset current time information.
		lightTable[i] = { };
		
		// defaults for regular colors
		local letter = string.char( LIGHT_LOW );
		local red = 0;
		local green = 0;
		local blue = 0;
	
		// calculate which letter to use in the light pattern.
		if ( i >= DAY_START && i < NOON ) then
			local progress = ( NOON - i ) / ( NOON - DAY_START );
			local letter_progress = 1 - math.EaseInOut( progress , 0 , 1 );
						
			letter = ( ( LIGHT_HIGH - LIGHT_LOW ) * letter_progress ) + LIGHT_LOW;
			letter = math.ceil( letter );
			letter = string.char( letter );
		elseif (i  >= NOON && i < DAY_END ) then
		
			local progress = ( i - NOON ) / ( DAY_END - NOON );
			local letter_progress = 1 - math.EaseInOut( progress , 0 , 1 );
						
			letter = ( ( LIGHT_HIGH - LIGHT_LOW ) * letter_progress ) + LIGHT_LOW;
			letter = math.ceil( letter );
			letter = string.char( letter );
		end
		
		// calculate colors.
		if ( i >= DAWN_START && i <= DAWN_END ) then
			// golden dawn.
			local frac = ( i - DAWN_START ) / ( DAWN_END - DAWN_START );
			if ( i < DAWN ) then
				red = 200 * frac;
				green = 128 * frac;
			else
				red = 200 - ( 200 * frac );
				green = 128 - ( 128 * frac );
			end
		elseif ( i >= DUSK_START && i <= DUSK_END ) then
			// red dusk.
			local frac = ( i - DUSK_START ) / ( DUSK_END - DUSK_START );
			if ( i < DUSK ) then
				red = 85 * frac;
			else
				red = 85 - ( 85 * frac );
			end
		elseif ( i >= DUSK_END || i <= DAWN_START ) then
			// blue hinted night sky.
			if ( i > DUSK_END ) then
				local frac = ( i - DUSK_END ) / ( DAY_LENGTH - DUSK_END );
				blue = 15 * frac;
			elseif ( i < DAWN_START ) then			
				local frac = i / DAWN_START;
				blue = 15 - ( 15 * frac );
			else
				local frac = i / DAWN_START;
				blue = 30 - ( 30 * frac );
			end
		end

		// Fog color and distance calculations
		local fBaseDist = 750
		local fNum = 300
		local fRed = math.floor( math.Clamp( math.Clamp(98 - (98 * math.Clamp( math.abs( ( i - NOON ) / NOON ), 0, 1 ) ), 0, 98 ) + ( math.floor( red ) * math.Clamp( math.abs( ( i - NOON ) / NOON ), 0.05, 0.7 ) ), 0, 255  ) );
		local fGrn = math.floor( math.Clamp( math.Clamp(105 - (105 * math.Clamp( math.abs( ( i - NOON ) / NOON ), 0, 1 ) ), 0, 105 ) + ( math.floor( green ) * math.Clamp( math.abs( ( i - NOON ) / NOON ), 0.05, 0.7 ) ), 0, 255  ) );
		local fBlu = math.floor( math.Clamp( math.Clamp(111 - (111 * math.Clamp( math.abs( ( i - NOON ) / NOON ), 0, 1 ) ), 0, 111 ) + ( math.floor( blue ) * math.Clamp( math.abs( ( i - NOON ) / NOON ), 0.05, 0.7 ) ), 0, 255  ) );
		local fDist = math.floor( (fBaseDist) * (fNum) / (255 * math.Clamp( math.abs( ( i - NOON ) / NOON ) , 0.2 , 0.8 ) ) )

		// Sun & Shadow Angle Calcs
		local piday = ( DAY_LENGTH / 4 ) + i
		if ( piday > DAY_LENGTH ) then
			piday = piday - DAY_LENGTH
		end
		piday = ( piday / DAY_LENGTH ) * math.pi * 2
		local sAng = 65  // angle of elevation of sun at NOON
		local sAngOffset = sAng / 90
		local sPitch = math.deg( sAngOffset * math.sin(piday) )
		local sYaw = math.deg(piday * -1)
		local sRoll = 0

		// wrap around the sun angles (keep things simple)
		sPitch = WrapAngles(sPitch)
		sYaw = WrapAngles(sYaw)
		sRoll = WrapAngles(sRoll)

		// calculate shadow angles, opposite of sun angles
		local xPitch = sPitch + 180
		local xYaw = sYaw + 180
		local xRoll = sRoll
		
		if ( i > ((DUSK_END + DUSK_START) * .5) || i < DAWN_START ) then
			xPitch = 90;
			xYaw = 90;
			xRoll = 0;
		end

		// wrap around AGAIN for the shadows
		xPitch = WrapAngles(xPitch)
		xYaw = WrapAngles(xYaw)
		xRoll = WrapAngles(xRoll)

		// store information.
		lightTable[i].pattern = letter;
		lightTable[i].sky_overlay_alpha = math.floor( 255 * math.Clamp( math.abs( ( i - NOON) / (NOON - DAWN_START) ) , 0 , 0.99 ) );
		lightTable[i].sky_overlay_color = math.floor( red ) .. ' ' .. math.floor( green ) .. ' ' .. math.floor( blue );
		lightTable[i].sky_fog_color = math.floor( fRed ) .. ' ' .. math.floor( fGrn ) .. ' ' .. math.floor ( fBlu );
		lightTable[i].sky_fog_dist = math.Clamp(math.floor( (fBaseDist) * (fNum) / (255 * math.Clamp( math.abs( ( i - NOON ) / NOON ) , 0.1 , 0.7 ) ) ), 1856, 3072 );
		lightTable[i].env_sun_angle = 'angles ' .. sPitch .. ' ' .. sYaw .. ' ' .. sRoll
		lightTable[i].env_sun_pitch = 'pitch ' .. sPitch
		lightTable[i].shadow_angle = 'angles ' .. xPitch .. ' ' .. xYaw .. ' ' .. xRoll
	end
	
	Msg("done! ( " .. CurTime() - startTime .. " seconds elapsed. )\n");
end

local function setupTime ( )
	GAMEMODE.timeEntities.light_environment = ents.FindByClass('light_environment');
	GAMEMODE.timeEntities.env_sun = ents.FindByClass('env_sun');
	GAMEMODE.timeEntities.shadow_control = ents.FindByClass('shadow_control');
	GAMEMODE.timeEntities.sky_fog = ents.FindByClass('env_fog_controller');
	GAMEMODE.timeEntities.sky_overlay = ents.FindByName('daynight_brush');
	GAMEMODE.timeEntities.night_events = ents.FindByName('night_events');
	GAMEMODE.timeEntities.day_events = ents.FindByName('day_events');
	GAMEMODE.timeEntities.tonemap = ents.FindByClass('env_tonemap_controller');
	
	if !GAMEMODE.timeEntities.shadow_control then return end
	
	// start at night.
	for _ , light in pairs(GAMEMODE.timeEntities.light_environment) do
		light:Fire('FadeToPattern', string.char(LIGHT_LOW), 0);
		light:Activate();
	end

	// setup the sun entities materials (fixes a repeating console error)
	for _ , sun in pairs(GAMEMODE.timeEntities.env_sun) do
		sun:SetKeyValue('material' , 'sprites/light_glow02_add_noz.vmt');
		sun:SetKeyValue('overlaymaterial' , 'sprites/light_glow02_add_noz.vmt');
	end

	// fog defaults
	for _ , fog in pairs(GAMEMODE.timeEntities.sky_fog) do
		fog:Fire("SetColor", "0 0 0" , 0.1)
		fog:Fire("SetColorSecondary", "0 0 0" , 0.1)
	end
	
	// brush color defaults
	for _ , brush in pairs(GAMEMODE.timeEntities.sky_overlay) do
		brush:Fire('Enable' , '' , 0);
		brush:Fire('Color' , '0 0 0' , 0.01);
	end

	// build the light information table.
	buildLightTable( );
end
hook.Add("InitPostEntity", "setupTime", setupTime);

function GM.progressTime ( )
	GAMEMODE.calculateWeather();
	if !GAMEMODE.CurrentTime then GAMEMODE.CurrentTime = NOON end
	local ourTable = GAMEMODE.manipulateLightTable(table.Copy(lightTable[GAMEMODE.CurrentTime]));
	
	if (GAMEMODE.CurrentTime == DAWN_START) then
		if (math.random(1, 40) == 1) then
			GAMEMODE.CurFoggy = true;
		end
	elseif (GAMEMODE.CurrentTime == DAWN_END) then GAMEMODE.CurFoggy = false; end
	
	if (GAMEMODE.CurrentTime == DUSK_START) then
		if (math.random(1, 40) == 1) then
			GAMEMODE.CurFoggy = true;
		end
	elseif (GAMEMODE.CurrentTime == DUSK_END) then GAMEMODE.CurFoggy = false; end
	
	// light pattern.
	local pattern = ourTable.pattern;
	if ( GAMEMODE.timeEntities.light_environment && GAMEMODE.timeEntities.pattern != pattern ) then
		local light;
		for _ , light in pairs( GAMEMODE.timeEntities.light_environment ) do
			light:Fire( 'FadeToPattern' , pattern , 0 );
			light:Activate( );
		end
	end
	GAMEMODE.timeEntities.pattern = pattern;
	
	// sky overlay attributes.
	local sky_overlay_alpha = math.Clamp(ourTable.sky_overlay_alpha, GAMEMODE.MinSkyAlpha, 255) ;
	local sky_overlay_color = ourTable.sky_overlay_color;
	
	local updateAlpha = false
	GAMEMODE.timeEntities.sky_overlay_alpha = GAMEMODE.timeEntities.sky_overlay_alpha or 255
	local dif = math.abs(GAMEMODE.timeEntities.sky_overlay_alpha, sky_overlay_alpha)
	
	if (dif > 100) then
		GAMEMODE.timeEntities.sky_overlay_alpha = sky_overlay_alpha
		updateAlpha = true
	else
		if (GAMEMODE.timeEntities.sky_overlay_alpha < sky_overlay_alpha) then
			GAMEMODE.timeEntities.sky_overlay_alpha = GAMEMODE.timeEntities.sky_overlay_alpha + 1
			updateAlpha = true
		elseif (GAMEMODE.timeEntities.sky_overlay_alpha > sky_overlay_alpha) then
			GAMEMODE.timeEntities.sky_overlay_alpha = GAMEMODE.timeEntities.sky_overlay_alpha - 1
			updateAlpha = true
		end
	end
	
	if ( GAMEMODE.timeEntities.sky_overlay ) then
		local brush;
		for _ , brush in pairs( GAMEMODE.timeEntities.sky_overlay ) do
			// change the alpha if needed.
			if (updateAlpha) then
				brush:Fire( 'Alpha' , GAMEMODE.timeEntities.sky_overlay_alpha, 0 );
			end
			
			// change the color if needed.
			if ( GAMEMODE.timeEntities.sky_overlay_color != sky_overlay_color ) then
				brush:Fire( 'Color' , sky_overlay_color , 0 );
			end
		end
	end
	GAMEMODE.timeEntities.sky_overlay_color = sky_overlay_color;

	// sky fog attributes
	if ( GAMEMODE.timeEntities.sky_fog ) then
		local sky_fog_color = ourTable.sky_fog_color
		
		local sky_fog_dist = ourTable.sky_fog_dist
		local sky_fog_z = math.Clamp( (sky_fog_dist + 4000), 7500, 15000 )
		if (GAMEMODE.CurFoggy) then
			local dist_da = math.Clamp(1 - ((1 - (math.abs(GAMEMODE.CurrentTime - DAWN) / 144)) * .8), .25, 1);
			local dist_du = math.Clamp(1 - ((1 - (math.abs(GAMEMODE.CurrentTime - DUSK) / 144)) * .8), .25, 1);
			
			if (GAMEMODE.CurrentTime < NOON) then
				sky_fog_dist = sky_fog_dist * dist_da;
			else
				sky_fog_dist = sky_fog_dist * dist_du;
			end
		end
		
		local fog;
		for _ , fog in pairs( GAMEMODE.timeEntities.sky_fog ) do
			if (GAMEMODE.timeEntities.sky_fog_color != sky_fog_color ) then
				fog:Fire( 'SetColor' , sky_fog_color , 0 )
				fog:Fire( 'SetColorSecondary' , sky_fog_color , 0 )
			end
			if (GAMEMODE.timeEntities.sky_fog_dist != sky_fog_dist ) then
				fog:Fire( 'SetEndDist' , sky_fog_dist * 2 , 0 )
				fog:Fire( 'SetStartDist' , sky_fog_dist * 0.5 , 0 )
				fog:Fire( 'SetFarZ' , sky_fog_z , 0 )
			end
		end
		
		GAMEMODE.timeEntities.sky_fog_color = sky_fog_color
		GAMEMODE.timeEntities.sky_fog_dist = sky_fog_dist
	end


	// Sun and Shadow angles (update at the same time)
	local env_sun_angle = ourTable.env_sun_angle;
	local env_sun_pitch = ourTable.env_sun_pitch;
	local shadow_angles = ourTable.shadow_angle;
	if ( GAMEMODE.timeEntities.env_sun && GAMEMODE.timeEntities.env_sun_angle != env_sun_angle ) then
		local sun;
		for _ , sun in pairs( GAMEMODE.timeEntities.env_sun ) do
			sun:Fire( 'addoutput' , env_sun_angle , 0 );
			sun:Fire( 'addoutput' , env_sun_pitch , 0 );
			sun:Activate( );
		end
		if ( GAMEMODE.timeEntities.shadow_control ) then
			local shadow;
			for _ , shadow in pairs( GAMEMODE.timeEntities.shadow_control ) do
				shadow:Fire( 'addoutput', shadow_angles )
			end
		end
	end
	GAMEMODE.timeEntities.env_sun_angle = env_sun_angle;

	if ( GAMEMODE.CurrentTime == DAWN - 16 ) then
		GAMEMODE.PushDayEffects(true);
		
		for _, dEvents in pairs( GAMEMODE.timeEntities.day_events ) do
			dEvents:Fire( 'trigger', 0 );
		end
	elseif (GAMEMODE.CurrentTime == DUSK + 32 ) then
		GAMEMODE.PushDayEffects(false);
		
		for _, nEvents in pairs( GAMEMODE.timeEntities.night_events ) do
			nEvents:Fire( 'trigger', 0 );
		end
	end
end

function GM.PushDayEffects ( isDay )
	if (isDay == GAMEMODE.DayEffects) then return false; end
	
	GAMEMODE.DayEffects = isDay;
	
	if (isDay) then
		for _, nTone in pairs( GAMEMODE.timeEntities.tonemap ) do
			nTone:Fire('setautoexposuremax', '2', 0 )
		end
	else
		for _, nTone in pairs( GAMEMODE.timeEntities.tonemap ) do
			nTone:Fire('setautoexposuremax', '0.5', 0 ) 
		end
	end
end
