

local Plugins = {}

function ASS_NewLogLevel( ID, NAME )
	
	_G[ID] = NAME

end

function ASS_FindPlugin(NAME)
	for _,plugin in pairs(Plugins) do
		if (plugin.Name == NAME) then
			return plugin
		end
	end
	return nil
end

function ASS_AllPlugins(f)
	local t = {}
	for _, plugin in pairs(Plugins) do
		if (!f || (f && f(plugin))) then
			table.insert(t, plugin)
		end
	end
	return t
end

function ASS_RunPluginFunction( NAME, DEF_RETURN, ... )
	
	return DEF_RETURN

end

function ASS_RunPluginFunctionFiltered( NAME, FILTER_FUNC, DEF_RETURN, ... )
	
	return DEF_RETURN

end

function ASS_RunPluginFunction( NAME, DEF_RETURN, ... )
	
	local arg = {...}
	
	for _,plugin in pairs(Plugins) do
	
		if (plugin[NAME]) then

			if NAME == "AddMenu" and plugin.Enabled == false then continue end
		
			local err, ret = PCallError( plugin[NAME], unpack(arg) )
			
			if (ret != nil) then
			
				return ret
			
			end
		
		end
	
	end
	
	return DEF_RETURN

end

function ASS_RunPluginFunctionFiltered( NAME, FILTER_FUNC, DEF_RETURN, ... )
	
	local arg = {...}
	
	for _,plugin in pairs(Plugins) do
	
		if (plugin[NAME]) then
		
			if (FILTER_FUNC(plugin)) then
		
				local err, ret = PCallError( plugin[NAME], unpack(arg) )
			
				if (ret != nil) then
			
					return ret
			
				end
				
			end
		
		end
	
	end
	
	return DEF_RETURN

end

function ASS_PluginCheckGamemode( LIST )

	if (LIST == nil || #LIST == 0) then
		return true
	end

	for k,v in pairs(LIST) do
		local lv = string.lower(v)
		local gm = gmod.GetGamemode()
	
		while (gm) do
			if (string.lower(gm.Name) == lv) then
				return true
			end
		
			gm = gm.BaseClass
		end
	end
	
	return false

end

ASS_API_VERSION = 2

function ASS_RegisterPlugin( PLUGIN )

	if (!PLUGIN.APIVersion || PLUGIN.APIVersion != ASS_API_VERSION) then

		Msg( "ASS Plugin -> " .. PLUGIN.Filename .. " not registered (incorrect API version)\n" )
		ASS_Debug( "ASS Plugin -> " .. PLUGIN.Filename .. " not registered (incorrect API version)\n" )
		return
	
	end

	if (!ASS_PluginCheckGamemode(PLUGIN.Gamemodes)) then
	
		ASS_Debug( "ASS Plugin -> " .. PLUGIN.Filename .. " not registered (gamemode check failed)\n" )
		return
	
	end

	if (PLUGIN.ClientSide) then
		
		AddCSLuaFile(PLUGIN.Filename)
		
	end

	if ((PLUGIN.ClientSide && CLIENT) || (PLUGIN.ServerSide && SERVER)) then

		Msg("ASS Plugin -> " .. PLUGIN.Filename .. "\n")
		ASS_Debug( "ASS Plugin -> " .. PLUGIN.Filename .. " registered\n" )

		table.insert( Plugins, PLUGIN )
		
	end
end

function ASS_LoadPlugins( DIR )

	DIR = DIR or "plugins"

	local luaFiles = file.Find(DIR .. "/*.lua", "LUA")

	for k,v in pairs(luaFiles) do
	
		PLUGIN_FILENAME = DIR .. "/" .. v
		
		if (file.IsDir("lua/" .. PLUGIN_FILENAME, "LUA")) then
		
			ASS_LoadPlugins( PLUGIN_FILENAME )
		
		else
		
			include( PLUGIN_FILENAME )
			
		end
		
	end

end

