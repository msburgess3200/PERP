

local function finishReport ( SMFID, rpName, ruleID, reporterID, reporterName, comments )
	Msg("Finalize report for " .. rpName .. " ( " .. SMFID .. " ) Rule # " .. ruleID .. ".");

	local compiledChatLog = ""
	for k, v in pairs(GAMEMODE.ChatHistory) do
		compiledChatLog = compiledChatLog .. v;
	end
	
	local serverID = "Developer Server";
	if (GAMEMODE.ServerIdentifier == 1) then
		serverID = "Lite Roleplay";
	elseif (GAMEMODE.ServerIdentifier == 2) then
		serverID = "Serious Roleplay";
	end
	
	local body = '[b]Profile:[/b] [url=http://www.pulsareffect.com/index.php?action=profile;u=' .. SMFID .. ']http://www.pulsareffect.com/index.php?action=profile;u=' .. SMFID .. '[/url]\n[b]RP Name:[/b] ' .. tmysql.escape(rpName) .. '\n[b]Server:[/b] ' .. serverID .. '\n[b]Accusation:[/b] Violation of rule #' .. ruleID .. ' ([url=http://www.pulsareffect.com/PERP2.5/rules.txt]Rule List[/url])\n[b]Additional Comments:[/b] ' .. tmysql.escape(string.gsub(string.gsub(comments, ">", "&#62;"), "<", "&#60;")) .. '\n\n[code]' .. tmysql.escape(compiledChatLog) .. '[/code]\n\n[b]Any edit of this post should mark this chat log as null evidence.[/b]';
	
	local addedTime = os.time();
	tmysql.query("INSERT INTO `smf_messages` (`ID_BOARD`, `posterTime`, `ID_MEMBER`, `subject`, `posterName`, `posterEmail`, `posterIP`, `body`) VALUES ('13', '" .. addedTime .. "', '" .. reporterID .. "', '" .. tmysql.escape(rpName) .. " - Rule #" .. ruleID .. "', '" .. reporterName .. "', 'automated@perp.com', 'Not Available', '" .. body .. "')", function ( res )
		tmysql.query("SELECT `ID_MSG` from `smf_messages` WHERE `ID_MEMBER`='" .. reporterID .. "' AND `posterTime`='" .. addedTime .. "' LIMIT 1", function ( res2 )
			if (!res2 || !res2[1] || !res2[1][1]) then Msg("no res2\n"); return; end
			
			local msgID = res2[1][1];
			
			tmysql.query("INSERT INTO `smf_topics` (`ID_BOARD`, `ID_FIRST_MSG`, `ID_LAST_MSG`, `ID_MEMBER_STARTED`, `numReplies`, `numViews`) VALUES ('13', '" .. msgID .. "', '" .. msgID .. "', '" .. reporterID .. "', '0', '0')", function ( res3 )
				tmysql.query("SELECT `ID_TOPIC` from `smf_topics` WHERE `ID_FIRST_MSG`='" .. msgID .. "' LIMIT 1", function ( res4 )
					if (!res4 || !res4[1] || !res4[1][1]) then Msg("no res3\n"); return; end
					
					local topicID = res4[1][1];
					
					tmysql.query("UPDATE `smf_messages` SET `ID_TOPIC`='" .. topicID .. "' WHERE `ID_MSG`='" .. msgID .. "' LIMIT 1");
					tmysql.query("UPDATE `smf_boards` SET `numTopics`=`numTopics`+'1', `numPosts`=`numPosts`+'1', `ID_LAST_MSG`='" .. msgID .. "', `ID_MSG_UPDATED`='" .. msgID .. "' WHERE `ID_BOARD`='13' LIMIT 1");
				end);
			end);
		end);
	end);
end

function GM.ReportPlayer ( Player, Cmd, Args )
	if (Player:HasBlacklist('a')) then return; end
	if (!Player || !IsValid(Player) || !Player:IsValid()) then return; end
	if (!Args[1] || !Args[2] || !Args[3]) then Msg("args\n"); return; end
	if (Player.LastReportTime && Player.LastReportTime > CurTime()) then Msg("time\n"); return; end
	
	Player:Notify("Your report has been received.");
		
	if (Player:IsAdmin()) then
		Player.LastReportTime = CurTime() + 4;
	elseif (Player:IsBronze()) then
		Player.LastReportTime = CurTime() + 29;
	else
		Player.LastReportTime = CurTime() + 59;
	end
	
	local reporterID = Player.SMFID;
	local reporterName = Player:Nick();
	
	local uniqueID = Args[1];
	local ruleNum = tonumber(Args[2]);
	local comments = Args[3]
	
	local grabSMFID;
	local grabRPName;
	
	for k, v in pairs(player.GetAll()) do
		if (v:UniqueID() == uniqueID) then
			grabSMFID = v.SMFID;
			grabName = v:Nick();
			grabRPName = v:GetRPName();
		end
	end
	
	if (grabSMFID) then
		finishReport(grabSMFID, grabRPName, ruleNum, reporterID, reporterName, comments);
		return
	end
	
	tmysql.query("SELECT `id`, `rp_name_first`, `rp_name_last` FROM `perp_users` WHERE `uid`='" .. uniqueID .. "' LIMIT 1", function ( res )
		if (res && res[1] && res[1][1]) then
			finishReport(res[1][1], res[1][2] .. " " .. res[1][3], ruleNum, reporterID, reporterName, comments);
			return;
		end
		
		if (Player && IsValid(Player) && Player:IsPlayer()) then
			Player:Notify("Could not find reported user.");
		end
	end);
end
concommand.Add("perp_r_p", GM.ReportPlayer);