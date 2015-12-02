

function ASS_ConfigFilename()

	if (CLIENT) then
		return "ass_config_client.txt"
	elseif (SERVER) then
		return "ass_config_server.txt"
	else
		return "ass_config_unknown.txt"
	end

end

function ASS_WriteConfig()

	local cfgfile = util.TableToKeyValues( ASS_Config )
	
	file.Write( ASS_ConfigFilename(), cfgfile )

end

local function FixTable( t )

	local new = {}
	for k,v in pairs(t) do
		if (tostring(tonumber(k)) == k) then
			new[tonumber(k)] = v	
		else
			new[k] = v
		end
	end
	return new

end

function ASS_ReadConfig()

	if (file.Exists( ASS_ConfigFilename(), "DATA" ) ) then
	
		local cfgfile = file.Read( ASS_ConfigFilename() )
		
		if (cfgfile and #cfgfile > 0) then

			local cfg = util.KeyValuesToTable( cfgfile )
			
			if (cfg) then
				ASS_Config = cfg

				// Fix any tables with numerical indices
				for k,v in pairs(cfg) do
					if (type(v) == "table") then
						ASS_Config[k] = FixTable(v)
					end
				end

				// Copy any parts missing from the default config
				// If a table is in the default, put an empty table in the
				// config (since util.TableToKeyValues doesn't save empty tables).
				for k,v in pairs(ASS_DefaultConfig) do
					if (ASS_Config[k] == nil) then
						if (type(ASS_DefaultConfig[k]) == "table") then
							ASS_Config[k] = {}
						else
							ASS_Config[k] = v
						end
					end
				end
			end
			
		end
	
	else
	
		ASS_WriteConfig()
	
	end

end


ASS_Config = {}
IncludeSharedFile("ass_default_config.lua")
ASS_DefaultConfig = table.Copy(ASS_Config)
ASS_ReadConfig()
