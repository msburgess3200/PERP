local PLUGIN = {}

PLUGIN.Name = "Map"
PLUGIN.Author = "RedMist"
PLUGIN.Date = "15th March 2011"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

if (SERVER) then

	ASS_NewLogLevel("ASS_ACL_MAP")

	function PLUGIN.RefreshMapList(PLAYER)
		local allMaps = file.Find("maps/*.bsp", "GAME")
		for k,v in pairs(allMaps) do
			allMaps[k] = string.gsub(string.lower( v ), ".bsp", "")
		end
		table.sort(allMaps, function(a,b) return a < b end )
		
		umsg.Start( "ASS_MapListInit", PLAYER )
			umsg.Short( #allMaps )
			umsg.String( game.GetMap() )
		umsg.End()		
		local timediff = 0
		for k,v in pairs(allMaps) do
			timer.Simple( timediff, 
				function()
					umsg.Start( "ASS_MapListItem", PLAYER )
						umsg.String(v)
					umsg.End()		
				end
			)
			timediff = timediff + 0.01
		end
		timer.Simple( timediff, 
			function()
				umsg.Start( "ASS_MapListDone", PLAYER )
				umsg.End()		
			end
		)
	end
	concommand.Add("ASS_RefreshMapList", PLUGIN.RefreshMapList)
	
	function PLUGIN.PlayerInitialSpawn(PLAYER)
		PLUGIN.RefreshMapList(PLAYER)
	end

	function PLUGIN.Registered()
		hook.Add("PlayerInitialSpawn",		"PlayerInitialSpawn_" .. PLUGIN.Filename, 		PLUGIN.PlayerInitialSpawn )
	end

	function PLUGIN.DoChangeMap( PLAYER, MAP )
	
		if (PLAYER:IsValid()) then

			ASS_LogAction( PLAYER, ASS_ACL_MAP, "changed map to " .. MAP )

		end
		
		asscmd.ConsoleCommand( "changelevel " .. MAP .. "\n" )

	end

	function PLUGIN.ChangeMap( PLAYER, CMD, ARGS )

		if (PLAYER:IsOwner()) then

			local MAP = ARGS[1]
			local TIME = tonumber(ARGS[2]) or 0

			if (ASS_RunPluginFunction( "AllowMapChange", true, MAP, TIME )) then

				if (TIME == 0) then
				
					PLUGIN.DoChangeMap( PLAYER, MAP )
					
				else
				
					ASS_LogAction( PLAYER, ASS_ACL_MAP, "scheduled a map change to " .. MAP .. " in " .. TIME .. " seconds" )
					
					ASS_NamedCountdownAll( "MapChange", "Map change to " .. MAP, TIME )
					
					timer.Create( "ASS_MapChange", TIME, 1, PLUGIN.DoChangeMap, PLAYER, MAP )
				
				end
			end

		end

	end
	concommand.Add("ASS_ChangeMap", PLUGIN.ChangeMap)
	
	function PLUGIN.RestartMap(PLAYER, CMD, ARGS)

		ARGS[2] = ARGS[1]
		ARGS[1] = game.GetMap()
		
		PLUGIN.ChangeMap( PLAYER, CMD, ARGS )

	end
	concommand.Add("ASS_RestartMap", PLUGIN.RestartMap)
			

	function PLUGIN.AbortChangeMap( PLAYER, CMD, ARGS )
		if (PLAYER:IsOwner()) then
		
			timer.Remove( "ASS_MapChange" )
			ASS_RemoveCountdownAll( "MapChange" )
		
		end
	end
	concommand.Add("ASS_AbortChangeMap", PLUGIN.AbortChangeMap)
end

if (CLIENT) then

	local allMaps = {}
	local maplistLoaded = false
	local numToLoad = 0
	local currentMap = ""
	
	function PLUGIN.AddToFavourites(MAP)
		if (!MAP) then return end
		
		local LMAP = string.lower(MAP)
		ASS_Config["maps"] = ASS_Config["maps"] || {}
		for k,v in pairs(ASS_Config["maps"]) do
			if (LMAP == string.lower(v)) then
				table.remove(ASS_Config["maps"], k)
				break
			end
		end
		
		table.insert(ASS_Config["maps"], LMAP)
		if (#ASS_Config["maps"] > 10) then
			table.remove(ASS_Config["maps"], 1)
		end
		
		ASS_WriteConfig()
	end
	
	function PLUGIN.ChangeMap(MAP, TIME)
	
		if (MAP == nil || type(MAP) == "string") then
		
			if (MAP == nil) then
		
				RunConsoleCommand("ASS_RestartMap", TIME )
				PLUGIN.AddToFavourites(currentMap)
	
			else

				RunConsoleCommand("ASS_ChangeMap", MAP, TIME)
				PLUGIN.AddToFavourites(MAP)
		
			end
			
		else
		
			Derma_StringRequest( "Map...", 
				"Which map do you want to switch to?", 
				currentMap, 
				function( strTextOut ) 
					RunConsoleCommand("ASS_ChangeMap", strTextOut, TIME) 
					PLUGIN.AddToFavourites(strTextOut)
				end 
			)

		end

		return true

	end
	
	function PLUGIN.TimeMenu(MENU, MAP)
		
		MENU:AddOption( "Now", 		function() PLUGIN.ChangeMap(MAP, 0) end 	)
		MENU:AddSpacer()
		MENU:AddOption( "30 seconds",	function() PLUGIN.ChangeMap(MAP, 30) end 	)
		MENU:AddOption( "1 minute",	function() PLUGIN.ChangeMap(MAP, 60) end	)
		MENU:AddOption( "3 minutes",	function() PLUGIN.ChangeMap(MAP, 3 * 60) end	)
		MENU:AddOption( "5 minutes",	function() PLUGIN.ChangeMap(MAP, 5 * 60) end	)
		MENU:AddOption( "15 minutes",	function() PLUGIN.ChangeMap(MAP, 15 * 60) end	)
		MENU:AddOption( "30 minutes",	function() PLUGIN.ChangeMap(MAP, 30 * 60) end	)
		MENU:AddOption( "1 hour",	function() PLUGIN.ChangeMap(MAP, 60 * 60) end	)
		
	end
	
	MAPS_PER_MENU = 30
	
	function PLUGIN.BlockMenu(MENU, BLOCK)

		for k,v in pairs(BLOCK) do

			MENU:AddSubMenu( v, nil, function(NEWMENU) PLUGIN.TimeMenu(NEWMENU, v ) end )

		end
	
	end

	function PLUGIN.FavouritesMenu(MENU)

		if (ASS_Config["maps"] == nil || #ASS_Config["maps"] == 0) then
		
			MENU:AddOption( "(none)", function() end )
		
		else
		
			PLUGIN.BlockMenu(MENU,ASS_Config["maps"])
		
		end

	end
	
	function PLUGIN.MapMenu(MENU)
	
		if (!maplistLoaded) then
		
			MENU:AddOption("Not loaded (" .. math.floor((#allMaps / numToLoad) * 100) .. "%)", function() end )
			return
		
		end
	
		local current = {}
		local blocks = {}
		for k,v in pairs(allMaps) do
			table.insert(current, v)
			
			if (#current > MAPS_PER_MENU) then
				table.insert(blocks, current)
				current = {}
			end
		end
		if (#current > 0) then
			table.insert(blocks, current)
		end
		
		MENU:AddSubMenu( "Current (".. currentMap..")", nil, function(NEWMENU) PLUGIN.TimeMenu( NEWMENU, nil ) end )
		MENU:AddSubMenu( "Custom" , nil, function(NEWMENU) PLUGIN.TimeMenu(NEWMENU, true ) end )
		MENU:AddSubMenu( "Favourites" , nil, function(NEWMENU) PLUGIN.FavouritesMenu(NEWMENU) end )
		MENU:AddSpacer()
		
		if (#blocks == 1) then

			PLUGIN.BlockMenu(MENU, blocks[1], true)
			
		else
		
			for k, v in pairs(blocks) do
			
				local first = ((k - 1) * MAPS_PER_MENU) + 1
				local last = (k * MAPS_PER_MENU)
				MENU:AddSubMenu( first .. " .. " .. last, nil, function(NEWMENU) PLUGIN.BlockMenu( NEWMENU, v, false) end )
			
			end
		
		end
		
		return false

	end

	function PLUGIN.AbortMapChange(MENUITEM)
	
		RunConsoleCommand("ASS_AbortChangeMap")
		return true
	
	end
	
	function PLUGIN.AddMainMenu(DMENU)			
	
		DMENU:AddSpacer()
		DMENU:AddSubMenu( "Change Map", nil, PLUGIN.MapMenu ):SetImage( "gui/silkicons/map" )
		DMENU:AddOption( "Abort Change Map", PLUGIN.AbortMapChange )

	end

	usermessage.Hook( "ASS_MapListInit", function (UMSG)
	
			numToLoad = UMSG:ReadShort()
			currentMap = UMSG:ReadString()
			maplistLoaded = false
			allMaps = {}
			
		end )

	usermessage.Hook( "ASS_MapListItem", function (UMSG)
	
			table.insert(allMaps, UMSG:ReadString())
			
		end )

	usermessage.Hook( "ASS_MapListDone", function (UMSG)
	
			maplistLoaded = true
			
		end )
end

ASS_RegisterPlugin(PLUGIN)
