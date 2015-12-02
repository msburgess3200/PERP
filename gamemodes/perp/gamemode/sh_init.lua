
// Random
PLAYER 						= 	FindMetaTable("Player");
ENTITY						= 	FindMetaTable("Entity");
VIEW_LOCK					=   999;

_G.ValidEntity = _G.IsValid
_G._R = debug.getregistry()

// Include shared files.
include("sh_config.lua");
include("sh_player.lua");
include("sh_items.lua");
include("sh_npcs.lua");
include("sh_shops.lua");
include("sh_skills.lua");
include("sh_mixtures.lua");
include("sh_misc.lua");
include("sh_property.lua");
include("sh_vehicles.lua");
include("sh_bank.lua");

for k, v in pairs(file.Find("perp/gamemode/sh_modules/*.lua","LUA")) do include("sh_modules/" .. v); end

Msg("Loading Items...\n");
for k, v in pairs(file.Find("perp/gamemode/items/*.lua","LUA")) do include("items/" .. v); end

Msg("Loading Shops...\n");
for k, v in pairs(file.Find("perp/gamemode/shops/*.lua","LUA")) do include("shops/" .. v); end

Msg("Loading Mixtures...\n");
for k, v in pairs(file.Find("perp/gamemode/mixtures/*.lua","LUA")) do include("mixtures/" .. v); end

Msg("Loading Vehicles...\n");
for k, v in pairs(file.Find("perp/gamemode/vehicles/*.lua","LUA")) do include("vehicles/" .. v); end

local function loadPostInt ( )
	Msg("Loading Properties...\n");
	for k, v in pairs(file.Find("perp/gamemode/properties/*.lua","LUA")) do include("perp/gamemode/properties/" .. v); end
	
	Msg("Loading NPCs...\n");
	for k, v in pairs(file.Find("perp/gamemode/npcs/*.lua","LUA")) do include("perp/gamemode/npcs/" .. v);	end
end
hook.Add("InitPostEntity", "loadPostInt", loadPostInt);

