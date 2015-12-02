

GM.chatRecord = {};

GM.linesToShow = 20;

local ColorIDs = {};
local ColorIDNames = {};
ColorIDs[1] = Color(240, 230, 140, 255); 				ColorIDNames[1] = "Local";
ColorIDs[2] = Color(255, 255, 255, 255); 				ColorIDNames[2] = "OOC";
ColorIDs[3] = Color(150, 150, 150, 255);				ColorIDNames[3] = "Local OOC";
ColorIDs[4] = Color(135, 206, 235, 255);				ColorIDNames[4] = "Whisper";
ColorIDs[5] = Color(255, 140, 0, 255); 					ColorIDNames[5] = "Yell";
ColorIDs[6] = Color(50, 205, 50, 255); 					ColorIDNames[6] = "PM";
ColorIDs[7] = Color(255, 50, 50, 255); 					ColorIDNames[7] = "Me";
ColorIDs[8] = Color(255, 0, 0, 255); 					ColorIDNames[8] = "911";
ColorIDs[9] = Color(0, 0, 255, 255); 					ColorIDNames[9] = "Radio";
ColorIDs[10] = Color(255, 0, 255, 255); 				ColorIDNames[10] = "Organization";
ColorIDs[11] = Color(0, 255, 0, 255); 					ColorIDNames[11] = "";
ColorIDs[12] = Color(255, 255, 255, 255); 				ColorIDNames[12] = "Advert";
ColorIDs[13] = Color(0, 255, 0, 255); 					ColorIDNames[13] = "Admin";
ColorIDs[14] = Color(0, 0, 255, 255); 					ColorIDNames[14] = "Hive";
ColorIDs[15] = Color(255, 0, 0, 255); 					ColorIDNames[15] = "Report";
ColorIDs[16] = Color(255, 50, 50, 255); 				ColorIDNames[16]  = "Event";
ColorIDs[17] = Color(255, 50, 50, 255); 				ColorIDNames[17]  = "Roll";

local newMessageSound = Sound("common/talk.wav");

function GM:StartChat ( teamSay )
	GAMEMODE.chatBoxIsOOC = teamSay;
	GAMEMODE.chatBoxText = "";
	GAMEMODE.ChatBoxOpen = true;
	
	if (GAMEMODE.Options_ShowChatBubble:GetBool()) then
		GAMEMODE.ChatBubbleOpen = true;
		RunConsoleCommand("pt", "1");
	end
	
	return true;
end

function GM:FinishChat ( )
	GAMEMODE.chatBoxIsOOC = nil;
	GAMEMODE.chatBoxText = nil;
	GAMEMODE.ChatBoxOpen = nil;
	
	if (GAMEMODE.ChatBubbleOpen) then
		GAMEMODE.ChatBubbleOpen = nil;
		RunConsoleCommand("pt", "0");
	end
end

function GM:ChatTextChanged ( newChat )
	GAMEMODE.chatBoxText = newChat;
end

// This part is handled through UMsgs so baddies can't hear from across the map. Silly exploiters.
function GM:ChatText ( playerID, playerName, text, type )
	if (!LocalPlayer():IsAdmin()) then
		if string.find(text, "joined") then return; end
		if string.find(text, "left") then return; end
	end

	surface.PlaySound(newMessageSound);
	table.insert(GAMEMODE.chatRecord, {CurTime(), "", nil, string.Trim(text), ColorIDs[11], nil});
	Msg(text .. "\n");
end
function GM:OnPlayerChat ( Player, Text, TeamChat, PlayerIsDead ) end

local function getRealChat ( UMsg )
	local pl = UMsg:ReadEntity();
	local text = UMsg:ReadString();
	local id = UMsg:ReadShort();
	
	if ((id == 2 || id == 3) && !GAMEMODE.Options_ShowOOC:GetBool()) then return; end
	
	surface.PlaySound(newMessageSound);
	
	local RPName = pl:GetUMsgString("rp_fname", "John") .. " " .. pl:GetUMsgString("rp_lname", "Doe");
	
	Msg("[" .. ColorIDNames[id] .. "] " .. tostring(RPName) .. ": " .. string.Trim(tostring(text)) .. "\n");
	
	table.insert(GAMEMODE.chatRecord, {CurTime(), RPName, team.GetColor(pl:Team()), string.Trim(text), ColorIDs[id or 1], nil});
end
usermessage.Hook("perp_chat", getRealChat);

local function getRealChatOOC ( UMsg )
	local pl = UMsg:ReadEntity();
	local text = UMsg:ReadString();
	local id = UMsg:ReadShort();
	
	if ((id == 2 || id == 3) && !GAMEMODE.Options_ShowOOC:GetBool()) then return; end
	
	surface.PlaySound(newMessageSound);
	
	local RPName = pl:Nick();
	
	local glowType;
	if (pl:SteamID() == "STEAM_0:0:21513525" && pl:GetUMsgInt("Disguise", 0) != 1 ) then //Misha's ID, not sure what this does.
		glowType = Color(255, 0, 0);
	elseif (pl:SteamID() == "STEAM_0:0:0" && pl:GetUMsgInt("Disguise", 0) != 1 ) then //Someone's ID was here!
		glowType = Color(255, 0, 0);
	elseif (pl:IsOwner()  && pl:GetUMsgInt("Disguise", 0) != 1 ) then
		glowType = Color(255, 0, 0)
	elseif (pl:IsSuperAdmin()  && pl:GetUMsgInt("Disguise", 0) != 1 ) then
		glowType = Color(28, 50, 176)
	elseif (pl:IsAdmin()  && pl:GetUMsgInt("Disguise", 0) != 1 ) then
		glowType = Color(0, 147, 81)
	end
	
	Msg("[" .. ColorIDNames[id] .. "] " .. RPName .. ": " .. string.Trim(text) .. "\n");

	table.insert(GAMEMODE.chatRecord, {CurTime(), RPName, team.GetColor(TEAM_CITIZEN), string.Trim(text), ColorIDs[id or 1], glowType});
	
end
usermessage.Hook("perp_ochat", getRealChatOOC);

local function getFakeChat ( UMsg )
	local text = UMsg:ReadString();
	local id = UMsg:ReadShort();
	
	surface.PlaySound(newMessageSound);
	
	if (ColorIDNames[id] != "") then
		Msg("[" .. ColorIDNames[id] .. "] " .. string.Trim(text) .. "\n");
	end
	
	table.insert(GAMEMODE.chatRecord, {CurTime(), "", nil, string.Trim(text), ColorIDs[id or 1], nil});
end
usermessage.Hook("perp_fchat", getFakeChat);

function PLAYER:ChatMessage ( Chat )
	table.insert(GAMEMODE.chatRecord, {CurTime(), "", nil, string.Trim(Chat), ColorIDs[11], nil});
end

GM.chatPrefixes = {}
GM.chatPrefixes["ooc"] = "OOC";
GM.chatPrefixes["/"] = "OOC";
GM.chatPrefixes["//"] = "Local OOC";
GM.chatPrefixes["looc"] = "Local OOC";
GM.chatPrefixes["me"] = "Action";
GM.chatPrefixes["action"] = "Action";
GM.chatPrefixes["w"] = "Whisper";
GM.chatPrefixes["y"] = "Yell";
GM.chatPrefixes["911"] = "Emergency";
GM.chatPrefixes["999"] = "Emergency";
GM.chatPrefixes["broadcast"] = "Broadcast";
GM.chatPrefixes["radio"] = "Government Radio";
GM.chatPrefixes["org"] = "Organization";
GM.chatPrefixes["pm"] = "Private Message";
GM.chatPrefixes["tm"] = "Text Message";
GM.chatPrefixes["admin"] = "Admin Talk";
GM.chatPrefixes["advert"] = "Advertisement";
GM.chatPrefixes["hive"] = "Hive";
GM.chatPrefixes["report"] = "Report";
GM.chatPrefixes["it"] = "Event";
GM.chatPrefixes["event"] = "Event";
GM.chatPrefixes["roll"] = "Roll";

