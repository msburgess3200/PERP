

// Include the shared init file.
include("sh_init.lua");

// Include the server files.
include("sv_config.lua");
include("sv_hooks.lua");
include("sv_networking.lua");
include("sv_player.lua");
include("sv_items.lua");
include("sv_skills.lua");
include("sv_misc.lua");
include("sv_chat.lua");
include("sv_organizations.lua");
include("sv_vehicles.lua");
include("sv_trade.lua");
include("sv_test.lua");

GM.maxPlayers = 50

for k, v in pairs(file.Find("perp/gamemode/sv_modules/*.lua","LUA")) do include("sv_modules/" .. v); end


util.AddNetworkString("ItemHook")
util.AddNetworkString("StorageHook")
// Add client lua resources.
AddCSLuaFile("cl_init.lua");
AddCSLuaFile("cl_player.lua");
AddCSLuaFile("cl_networking.lua");
AddCSLuaFile("cl_hooks.lua");
AddCSLuaFile("cl_misc.lua");
AddCSLuaFile("cl_items.lua");
AddCSLuaFile("cl_chat.lua");
AddCSLuaFile("cl_vehicles.lua");
AddCSLuaFile("cl_trade.lua");
AddCSLuaFile("cl_scoreboards.lua");
AddCSLuaFile("cl_test.lua");

AddCSLuaFile("sh_init.lua");
AddCSLuaFile("sh_player.lua");
AddCSLuaFile("sh_items.lua");
AddCSLuaFile("sh_config.lua");
AddCSLuaFile("sh_npcs.lua");
AddCSLuaFile("sh_shops.lua");
AddCSLuaFile("sh_skills.lua");
AddCSLuaFile("sh_misc.lua");
AddCSLuaFile("sh_mixtures.lua");
AddCSLuaFile("sh_property.lua");
AddCSLuaFile("sh_vehicles.lua");
AddCSLuaFile("sh_bank.lua");

for k, v in pairs(file.Find("perp/gamemode/cl_modules/*.lua","LUA")) do AddCSLuaFile("cl_modules/" .. v); end
for k, v in pairs(file.Find("perp/gamemode/sh_modules/*.lua","LUA")) do AddCSLuaFile("sh_modules/" .. v); end
for k, v in pairs(file.Find("perp/gamemode/vgui/*.lua","LUA")) do AddCSLuaFile("vgui/" .. v); end
for k, v in pairs(file.Find("perp/gamemode/items/*.lua","LUA")) do AddCSLuaFile("items/" .. v); end
for k, v in pairs(file.Find("perp/gamemode/npcs/*.lua","LUA")) do AddCSLuaFile("npcs/" .. v); end
for k, v in pairs(file.Find("perp/gamemode/shops/*.lua","LUA")) do AddCSLuaFile("shops/" .. v); end
for k, v in pairs(file.Find("perp/gamemode/mixtures/*.lua","LUA")) do AddCSLuaFile("mixtures/" .. v); end
for k, v in pairs(file.Find("perp/gamemode/properties/*.lua","LUA")) do AddCSLuaFile("properties/" .. v); end
for k, v in pairs(file.Find("perp/gamemode/vehicles/*.lua","LUA")) do AddCSLuaFile("vehicles/" .. v); end
for k, v in pairs(file.Find("perp/gamemode/scoreboards/*.lua","LUA")) do AddCSLuaFile("scoreboards/" .. v); end

local FOLDER_NAME = "perp"

local ClientResources = 0;
local function ProcessFolder ( Location )
	local files, directories = file.Find(Location .. '*',"GAME")
	if files then
		for k, v in pairs(files) do
			if file.IsDir(Location .. v,"GAME") then
				ProcessFolder(Location .. v .. '/')
			else
				local OurLocation = string.gsub(Location .. v, 'gamemodes/' .. FOLDER_NAME .. '/content/', '')
				if string.sub(OurLocation, -3) == "vmt" || string.sub(OurLocation, -3) == "vtf" || string.sub(OurLocation, -3) == "mdl" || string.sub(OurLocation, -3) == "wav" || string.sub(OurLocation, -3) == "mp3" || string.sub(OurLocation, -3) == "ttf" || string.sub(OurLocation, -3) == "txt" then			
					resource.AddFile(OurLocation)
					if false then
						MsgN("resource.AddFile(\""..OurLocation.."\")") -- for dumping to console
					end
				end
			end
		end
	end
	if directories then
		for k, v in pairs(directories) do
			if file.IsDir(Location .. v,"GAME") then
				ProcessFolder(Location .. v .. '/')
			else
				local OurLocation = string.gsub(Location .. v, 'gamemodes/' .. FOLDER_NAME .. '/content/', '')
				if string.sub(OurLocation, -3) == "vmt" || string.sub(OurLocation, -3) == "vtf" || string.sub(OurLocation, -3) == "mdl" || string.sub(OurLocation, -3) == "wav" || string.sub(OurLocation, -3) == "mp3" || string.sub(OurLocation, -3) == "ttf" || string.sub(OurLocation, -3) == "txt" then			
					resource.AddFile(OurLocation)
					if false then
						MsgN("resource.AddFile(\""..OurLocation.."\")") -- for dumping to console
					end
				end
			end
		end
	end
end

if game.IsDedicated() then
	ProcessFolder('../gamemodes/perp/content/models/');
	ProcessFolder('../gamemodes/perp/content/materials/');
	ProcessFolder('../gamemodes/perp/content/sound/');
	ProcessFolder('../gamemodes/perp/content/resource/');
	ProcessFolder('../gamemodes/perp/content/particles/');
	ProcessFolder('../gamemodes/perp/content/maps/');
end

Msg("Sent " .. ClientResources .. " client resources.\n");