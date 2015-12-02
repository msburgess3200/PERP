


/*local explodedIP = {"208", "122", "52"}
 
 local function parseXML(s)
	local stack = {};
	local top = {};
	
	table.insert(stack, top);
	
	local ni, c, label, xarg, empty;
	local i, j = 1, 1;
	
	while true do
		ni, j, c, label, xarg, empty = string.find(s, "<(%/?)([%w:]+)(.-)(%/?)>", i);
		
		if(not ni) then break; end
		
		local text = string.sub(s, i, ni - 1);
		
		if(not string.find(text, "^%s*$")) then
			table.insert(top, text);
		end
		
		if(empty == "/") then -- empty element tag
			local arg = {};
	
			string.gsub(xarg, "(%w+)=([\"'])(.-)%2", function (w, _, a) -- ' function
				arg[w] = a;
			end);
			
			table.insert(top, {label = label, xarg = arg, empty = 1});
		elseif(c == "") then -- start tag
			local arg = {};
	
			string.gsub(xarg, "(%w+)=([\"'])(.-)%2", function (w, _, a) -- ' function
				arg[w] = a;
			end);
		
			top = {label = label, xarg = arg};
			table.insert(stack, top); -- new level
		else
			local toclose = table.remove(stack); -- remove top
			
			top = stack[#stack];
			
			if(#stack < 1 or toclose.label ~= label) then
				return false; -- error
			end
			
			table.insert(top, toclose);
		end
		
		i = j + 1;
	end
	
	local text = string.sub(s, i);
	
	if(not string.find(text, "^%s*$")) then
		table.insert(stack[#stack], text)
	end
	
	if(#stack > 1) then
		return false; -- error
	end
	
	return stack[1];
 end
 
 local function kickPlayer(ply, optional)
	if (!optional) then
		RunConsoleCommand("addip", "2880", ply:IPAddress());
		RunConsoleCommand("writeip");
	end
	
	ply:Kick(optional or "Serenity Detected")
 end
 
 local function checkPlayer(ply) 
	local steamid = ply:SteamID();
	
	if(type(tonumber(steamid:sub(9, 9))) ~= "number" or type(tonumber(steamid:sub(11))) ~= "number") then
		Msg("Verifying " .. ply:Nick() .. "'s SteamID... Failed! (Incorrect Format)\n")
		kickPlayer(ply);
		return;
	end
	
	local communityid = steamid:sub(11) * 2 + steamid:sub(9, 9) + 1197960265728;
	
	for k, v in pairs(player.GetAll()) do
		if (ply != v && v:SteamID() == ply:SteamID()) then
			Msg("Verifying " .. ply:Nick() .. "'s SteamID... Failed! (Two Users With SteamID)\n")
			kickPlayer(ply)
			return
		end 
	end
	
	http.Get("http://steamcommunity.com/profiles/7656" .. communityid .. "/?xml=1", "", function(c, s)		
		local xml = parseXML(c);		
		if(xml[2][1][1] ~= "0" and xml[2][1][1] ~= "<![CDATA[The specified profile could not be found.]]>") then
			if(xml[2][5][1] == "public") then
				if(xml[2][3][1] == "in-game") then
					if(string.sub(xml[2][4][3], 1, 11) == "Garry's Mod") then
						local explodedTheirs = string.Explode(".", xml[2][12][1])
						if (#explodedTheirs < 3) then explodedTheirs = string.Explode(".", xml[2][13][1]) end 
						
						if(explodedTheirs[1] == explodedIP[1] && explodedTheirs[2] == explodedIP[2] && explodedTheirs[3] == explodedIP[3]) then
							Msg("Verifying " .. ply:Nick() .. "'s SteamID... Passed!\n")
						else
							Msg("Verifying " .. ply:Nick() .. "'s SteamID... Failed! (Not In Server " .. explodedTheirs[1] .. "." .. explodedTheirs[2] .. "." .. explodedTheirs[3] .. "/" .. explodedIP[1] .. "." .. explodedIP[2] .. "." .. explodedIP[3] .. ")\n")
							kickPlayer(ply);
						end
					else
						Msg("Verifying " .. ply:Nick() .. "'s SteamID... Failed! (Not In Garry's Mod)\n")
						kickPlayer(ply);
					end
				else
					Msg("Verifying " .. ply:Nick() .. "'s SteamID... Failed! (Not In Game)\n")
					kickPlayer(ply, "Go online on steam friends.");
				end
			else
				Msg("Verifying " .. ply:Nick() .. "'s SteamID... Failed! (Profile Private)\n")
				kickPlayer(ply, "Make Your Steam Community Profile Public, Please - This Is Anti-Serenity.")
			end
		else
			Msg("Verifying " .. ply:Nick() .. "'s SteamID... Failed! (Profile Non-Existant)\n")
			kickPlayer(ply);
		end
	end);
 end
 
 hook.Add("PlayerInitialSpawn", "Anti-Serenity", function(ply)
	timer.Simple(5, checkPlayer, ply);
 end);
 */
 