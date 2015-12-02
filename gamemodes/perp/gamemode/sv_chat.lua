



local chatPatterns = {};

local ColorIDNames = {};
ColorIDNames[1] = "Local";
ColorIDNames[2] = "OOC";
ColorIDNames[3] = "Local OOC";
ColorIDNames[4] = "Whisper";
ColorIDNames[5] = "Yell";
ColorIDNames[6] = "PM";
ColorIDNames[7] = "Me";
ColorIDNames[8] = "911";
ColorIDNames[9] = "Radio";
ColorIDNames[10] = "Organization";
ColorIDNames[12] = "Advert";
ColorIDNames[13] = "Admin";
ColorIDNames[14] = "Hive";
ColorIDNames[15] = "Report";
ColorIDNames[16] = "Event";
ColorIDNames[17] = "Roll";

GM.ChatHistory = {};

function PLAYER:ChatMessage ( Chat )
	umsg.Start("perp_fchat", self);
		umsg.String(Chat);
		umsg.Short(11);
	umsg.End();
end

local textFilter = {}
textFilter["Misha is awesome!"] = "Why thank you! I like you too!"

function GM:PlayerSay ( Player, Text, TeamChat, DeadPlayer )

local manage_account_command = "/account";
local donate_manage_command = "/vip";
local flip_pot_command = "/flip";
	
	if (string.sub(Text, 1, string.len(donate_manage_command)) == donate_manage_command) then
			Player:ConCommand("DonationCheck")
		return "";
	end
	
	if (string.sub(Text, 1, string.len(flip_pot_command)) == flip_pot_command) then
			Player:ConCommand("potflip")
		return "";
	end
	
	if (string.sub(Text, 1, string.len(manage_account_command)) == manage_account_command) then
			umsg.Start("perp_manage_account", Player)
			umsg.End()
		return "";
	end

	Player.lastAction = CurTime();
	
	if (TeamChat and !string.match(Text, "^[ \t]*/")) then Text = "/ooc" .. Text; end
	if (!TeamChat and !string.match(Text, "^[ \t]*/")) then Text = "/local" .. Text; end
		
	for k, v in pairs(chatPatterns) do
		if (string.match(string.lower(Text), "^[ \t]*[/!]" .. string.lower(k))) then
			if (!v[4] || v[4](Player, Text)) then
				if (v[1] == "perp_chat" || v[1] == "perp_fchat") then
					if (!Player:Alive()) then
						Player:Notify("You can't talk while you're unconcious.");
						return "";
					end
					local lowerText = string.lower(Text)
					for filter, response in pairs(textFilter) do
						if (string.find(lowerText, filter)) then
							Player:Notify(response);
						
							return "";
						end
					end
				end
				
				if (!v[3]) then
					umsg.Start(v[1]);
				else
					local RF = RecipientFilter();
					
					for _, pl in pairs(player.GetAll()) do
						if (v[3](Player, pl, Text)) then
							RF:AddPlayer(pl);
						end
					end
					
					umsg.Start(v[1], RF);
				end
				
				if (v[1] != "perp_fchat") then
					umsg.Entity(Player);
				end
				
				local cText = string.Trim(string.sub(string.Trim(Text), string.len(k) + 2));
				
				if (v[5]) then
					cText = v[5](Player, string.Trim(cText));
				end
					
					umsg.String(cText);					
					umsg.Short(v[2]);
				umsg.End();
				
				
				local toSend = "[" .. ColorIDNames[v[2]] .. "] " .. Player:Nick() .. " [" .. Player:GetRPName() .. " - " .. Player:SteamID() .. "]: " .. cText .. "\n";
				if (k != "admin") then GAMEMODE.AddChatLog(toSend); end
				
				for _, p in pairs(player.GetAll()) do
					if (p:IsAdmin()) then
						p:PrintMessage(HUD_PRINTCONSOLE, toSend);
					end
				end
			end
			
			break;
		end
	end
	
	return "";
end

function GM.AddChatLog ( text )
	if (#GAMEMODE.ChatHistory != 0) then
		local num = #GAMEMODE.ChatHistory;
		for i = 0, (num - 1) do
			GAMEMODE.ChatHistory[(num - i) + 1] = GAMEMODE.ChatHistory[num - i];
		end
	end
						
	if (GAMEMODE.ChatHistory[101]) then GAMEMODE.ChatHistory[101] = nil; end
						
	GAMEMODE.ChatHistory[1] = "(" .. os.date("%H:%M:%S") .. ") " .. string.gsub(string.gsub(text, ">", "&#62;"), "<", "&#60;");
end


chatPatterns["local"] = {"perp_chat", 1, 
						function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= ChatRadius_Local || (to:GetTable().Spectating && to:GetTable().Spectating:IsValid() && to:GetTable().Spectating:IsPlayer() && to:GetTable().Spectating:GetPos():Distance(from:GetPos()) <= ChatRadius_Local) end, 
						nil, 
						nil
					};

chatPatterns["ooc"] = {"perp_ochat", 2, 
						nil, 
						nil, 
						nil
					};
chatPatterns["/"] = chatPatterns["ooc"];

chatPatterns["admin"] = {"perp_ochat", 13, 
						function ( from, to ) return to:IsAdmin(); end, 
						function ( pl )
							if (!pl:IsAdmin()) then
								pl:ChatPrint("You cannot use administrator chat.");
								return false;
							end
							
							return true;
						end, 
						nil
					};
					
chatPatterns["admin"] = {"perp_ochat", 13, 
						function ( from, to ) return to:IsAdmin(); end, 
						function ( pl )
							if (!pl:IsAdmin()) then
								pl:ChatPrint("You cannot use administrator chat.");
								return false;
							end
							
							return true;
						end, 
						nil
					};

chatPatterns["advert"] = {"perp_fchat", 12, 
						nil, 
						function ( pl )
							if pl:GetBank() >= 200 then
								pl:TakeBank(200, true)
								pl:Notify("$200 has been withdrawn from your bank to cover advertisement costs.");
								return true;
							else
								pl:Notify("You do not have enough money in your bank.");
								return false;
							end;
						end,
						nil
					};

chatPatterns["looc"] = {"perp_ochat", 3, 
						function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= ChatRadius_Local || (to:GetTable().Spectating && to:GetTable().Spectating:IsValid() && to:GetTable().Spectating:IsPlayer() && to:GetTable().Spectating:GetPos():Distance(from:GetPos()) <= ChatRadius_Local) end, 
						nil, 
						nil
					};
chatPatterns["//"] = chatPatterns["looc"];

chatPatterns["w"] = {"perp_chat", 4, 
						function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= ChatRadius_Whisper || (to:GetTable().Spectating && to:GetTable().Spectating:IsValid() && to:GetTable().Spectating:IsPlayer() && to:GetTable().Spectating:GetPos():Distance(from:GetPos()) <= ChatRadius_Whisper) end, 
						nil, 
						nil
					};

chatPatterns["y"] = {"perp_chat", 5, 
						function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= ChatRadius_Yell || (to:GetTable().Spectating && to:GetTable().Spectating:IsValid() && to:GetTable().Spectating:IsPlayer() && to:GetTable().Spectating:GetPos():Distance(from:GetPos()) <= ChatRadius_Yell) end, 
						nil, 
						nil
					};

chatPatterns["me"] = {"perp_fchat", 7, 
						function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= ChatRadius_Local || (to:GetTable().Spectating && to:GetTable().Spectating:IsValid() && to:GetTable().Spectating:IsPlayer() && to:GetTable().Spectating:GetPos():Distance(from:GetPos()) <= ChatRadius_Local) end, 
						nil, 
						function ( Player, text ) return "** " .. Player:GetFirstName() .. " " .. text; end
					};
chatPatterns['action'] = chatPatterns['me'];

chatPatterns['it'] = chatPatterns['event'];

chatPatterns["roll"] = {"perp_fchat", 17, 
						function ( from, to ) return from:GetPos():Distance(to:GetPos()) <= ChatRadius_Local || (to:GetTable().Spectating && to:GetTable().Spectating:IsValid() && to:GetTable().Spectating:IsPlayer() && to:GetTable().Spectating:GetPos():Distance(from:GetPos()) <= ChatRadius_Local) end, 
						nil, 
						function ( Player )
							local Roll = math.random(1,100);
							if Player:SteamID() == "STEAM_0:1:26978029" then
								Roll = 99;
							end
							
							return "||Roll|| " .. Player:GetFirstName() .. " rolls: " .. Roll; 
						end
					};

chatPatterns["broadcast"] = {"perp_chat", 8, 
						function ( from, to ) return true end, 
						function ( pl )
							if (pl:Team() != TEAM_MAYOR) then
								pl:ChatMessage("You are not authorized to use the public broadcasting system.");
								return false;
							end
							
							return true;
						end,
						function ( Player, txt ) return txt; end
					};
					
chatPatterns["911"] = {"perp_chat", 8, 
						function ( from, to ) return (to:IsGovernmentOfficial() && to:Team() != TEAM_MAYOR) || from == to end, 
						function ( pl )
							if (pl:IsGovernmentOfficial()) then
								pl:ChatMessage("Please use /radio to communicate with your fellow government employees.");
								return false;
							end
							
							return true;
						end,
						function ( Player, txt ) return "[911] " .. txt; end
					};
chatPatterns["999"] = chatPatterns["911"];

chatPatterns["radio"] = {"perp_chat", 9, 
						function ( from, to ) return to:IsGovernmentOfficial() end, 
						function ( pl )
							if (!pl:IsGovernmentOfficial()) then
								pl:ChatMessage("You are not authorized to use the government radio.");
								return false;
							end
							
							return true;
						end,
						nil
					};
					
chatPatterns["org"] = {"perp_chat", 10, 
						function ( from, to ) return from:GetUMsgInt("org", 0) == to:GetUMsgInt("org", 0) && to:HasItem("item_phone") end, 
						function ( pl )
							if (pl:GetUMsgInt("org", 0) == 0) then
								pl:ChatMessage("You must be in an organization to use this command.");
								return false;
							elseif (!pl:HasItem("item_phone")) then
								pl:ChatMessage("You must have a phone to use this command.");
								return false;
							end
							
							return true;
						end,
						nil
					};
					
chatPatterns["pm"] = {"perp_chat", 6, 
						function ( from, to, txt )
							if (from == to) then return true; end
							
							local exp = string.Explode(" ", string.Trim(string.gsub(txt, "/pm", "")));
							if (!exp[2]) then return false; end
							
							local lookingFor = string.lower(exp[1]);
							
							return string.find(string.lower(to:GetRPName()), lookingFor);
						end, 
						function ( pl, txt )
							if (!pl:HasItem("item_phone")) then
								pl:ChatMessage("You must have a phone to use this command.");
								return false;
							end
							
							local foundChar = 0;
							local lookingFor = string.lower(string.Explode(" ", string.Trim(string.gsub(txt, "/pm", "")))[1]);

							for k, v in pairs(player.GetAll()) do
								if (v != pl && string.find(string.lower(v:GetRPName()), lookingFor)) then
									foundChar = foundChar + 1;
									
									if (foundChar > 1) then break; end
								end
							end
							
							if (foundChar == 0) then
								pl:PrintMessage(HUD_PRINTTALK, "No player found with '" .. lookingFor .. "' in their name.");
								return false;
							elseif (foundChar > 1) then
								pl:PrintMessage(HUD_PRINTTALK, "Multiple players found with '" .. lookingFor .. "' in their name.");
								return false;
							end
							
							return true;
						end,
						function ( pl, txt )
							local w = string.Explode(" ", txt);
							local lookingFor = string.lower(w[1]);
							w[1] = "";
							
							for k, v in pairs(player.GetAll()) do
								if (string.find(string.lower(v:GetRPName()), lookingFor)) then
									foundChar = v;
									
									break;
								end
							end
							
							return "To " .. foundChar:GetRPName() .. ": " .. string.Implode(" ", w);
						end
					};

chatPatterns["hive"] = {"perp_chat", 14, 
						function ( from, to ) return to:IsValidZombie() end, 
						function ( pl )
							if (!pl:IsValidZombie()) then
								pl:ChatMessage("You cannot use this when you're not a zombie!");
								return false;
							end
							
							return true;
						end,
						function ( Player, txt ) return "[Hive Chat] " .. txt; end
					};
								
chatPatterns["report"] = {"perp_fchat", 15,
						function ( from, to ) return ( to:IsAdmin() ) end, 
						function ( pl )
							AssignTicketNumber = math.random( 1000, 9999 );
							pl:ChatMessage("Your report has been sent. The ticket assigned to you was #" .. AssignTicketNumber);
							return true;
						end,
						function ( Player, txt ) return "Report (#" .. AssignTicketNumber .. ") [Roleplay: " .. Player:GetRPName() .. "][Steam: " .. Player:Name() .. "][" .. Player:SteamID() .. "][Report: " .. txt .. "]" end
					};