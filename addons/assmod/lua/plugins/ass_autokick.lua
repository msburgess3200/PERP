/*

if !SERVER then return false; end
local PLUGIN = {}

PLUGIN.Name = "Ban Words"
PLUGIN.Author = "RedMist"
PLUGIN.Date = "15th March 2011"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = false
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2
PLUGIN.Gamemodes = {}

--PLUGIN.BannedWords = {};
PLUGIN.BannedWords = {"nigger", "white power", "nigga", "fag", "queer", "kike", "whitepower", "whitpower", "nigg3r", "niggar", "niglet", "niger", "n1gger", "n1gg3r", "nlgger", "nlgg3r", "reggin", "pineapple", "cuntskikbut", "cuntskickbut", "n!gger", "n!gg3r", "pine@pple", "p1ne@pple", "pinapple", "pin@apple", "p1n@pple", "p1ne@ppl", "p1neappl", "k1k3", "kik3", "k1ke"};

function PLUGIN.MonitorChat ( Player, Text, Bool )
	for k, v in pairs(PLUGIN.BannedWords) do
		if string.find(string.lower(Text), string.lower(v)) then
			if Player:GetLevel() < 4 then
				Player:PrintMessage(HUD_PRINTTALK, "As an Admin, you are immune from the auto-kicker, but please watch your language as to avoid aggrivating other players.");
			elseif Player:GetLevel() == 99 then
				Player:PrintMessage(HUD_PRINTTALK, "As a Gold Member, you are immune from the auto-kicker, but please watch your language as to avoid aggrivating other players.");
			elseif Player:GetLevel() == 100 then
				Player:PrintMessage(HUD_PRINTTALK, "As a VIP member, you are immune from the auto-kicker, but please watch your language as to avoid aggrivating other players.");
			else
				Player:Kick("'" .. v .. "' is an auto-kick word.");
				
				for l, j in pairs(player.GetAll()) do
					j:PrintMessage(HUD_PRINTTALK, Player:Nick() .. " was kicked for saying '" .. v .. "', which is an auto-kick word.");
				end
				
				SendLog("Auto Kicker", "AUTO_WORD_KICK", Player:Nick(), v)
				
				return "";
			end
		end
	end
	
	PLUGIN.PlayerLastChats[Player] = CurTime()
end
hook.Add("PlayerSay", "PLUGIN.MonitorChat", PLUGIN.MonitorChat);
*/