if (SERVER) then

	concommand.Add("preload", function() RunConsoleCommand("changelevel",game.GetMap())  end)

	-- if true then
	-- 	require("tmysql")
	-- 	require("gatekeeper")
	-- 	SQL_INFO_1 = "remscar.com";
	-- 	SQL_INFO_2 = "remscar_client";
	-- 	SQL_INFO_3 = "reddog01";
	-- 	SQL_INFO_4 = "remscar_workspace";

	-- 	tmysql.initialize(SQL_INFO_1, SQL_INFO_2, SQL_INFO_3, SQL_INFO_4, 3306, 8, 8);
	-- end
	include("ass_server.lua")
elseif (CLIENT) then
	include("ass_client.lua")
end