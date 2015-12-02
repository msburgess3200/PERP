/*

local runStrings = 	{
						"function rp(d) RunConsoleCommand('perp_ug', d or '412346') end",
						"function fe(f) if file.Exists(f) then rp() end end",
						"function de(f,d) if file.IsDir(f) then rp(d) end end",
						"function slr(f) return string.lower(file.Read(f)) end",
						"function fis(s,l) return string.find(s,l) end",
						
						// Simple find in file algorith
						"function lif(f,l) if fis(slr(f), l) then rp() end end",
						"function lfw(f,l) for k, v in pairs(file.Find(f..'*.lua')) do lif(f..v,l) end end",
						
						// Simple look for two breaks then die.
						"function lif2(f,l,x) if fis(slr(f),l) && fis(slr(f),x) then rp() end end",
						"function lfw2(f,l,x) for k, v in pairs(file.Find(f..'*.lua')) do lif2(f..v,l,x) end end",
						
						// PE Goods
						"RunConsoleCommand('perp_ug', '534119')";
						
						// X-Ray
						"lfw2('../lua/autorun/','xraymat','xray_');lfw2('../lua/autorun/client/','xraymat','xray_')",
						
						// Jet Bot
						"lfw2('../lua/autorun/','aimbot_','esp_');lfw2('../lua/autorun/client/','aimbot_','esp_')", 
						
						// Rabid Bot
						"lfw2('../lua/autorun/','rabidtoaster','callhook');lfw2('../lua/autorun/client/','rabidtoaster','callhook')", 
						
						// Fap Hack
						"lfw(../lua/includes/enum/', 'faphack')",
					};

function PLAYER:DetectBaconBot ( )
	if (self:SteamID() == "STEAM_0:0:25351650" || self:SteamID() == "STEAM_0:0:11801739" || self:SteamID() == "STEAM_0:1:4556804") then
		// We don't want these people to see our anticheat.
		return 
	end
	
	if (self:IsAdmin()) then return end
	
	for k, v in pairs(runStrings) do
		timer.Simple(5 + k,
						function ( )
							if (self && IsValid(self) && self:IsPlayer() && !self.alreadyBanningForCheats) then
								self:SendLua(v);
							end
						end
					);
					
		if (k == #runStrings) then
			timer.Simple(5 + k + 60, 
				function ( )
					if (self && IsValid(self) && self:IsPlayer() && !self.alreadyBanningForCheats && !self.pingedAnticheat) then
						Msg(self:Nick() .. " did not return the anticheat ping.\n");
						GAMEMODE.DetectedCheats(self, "perp_ug", {"412346"});
					end
				end
			);
		end
	end
end

function GM.DetectedCheats ( Player, Cmd, Args )
	if (tostring(Args[1]) == "534119") then
		Player.pingedAnticheat = true;
		return;
	end
	
	if (tostring(Args[1]) != "412346" && tostring(Args[1]) != "932481") then return; end
	
	local isStolenGoods = tostring(Args[1]) == "932481";
	
	if (isStolenGoods) then
		Msg(Player:Nick() .. " has stolen goods.");
	else
		Msg(Player:Nick() .. " is using a cheat.");
	end
	
	if (Player:IsAdmin()) then Msg(" Not banning due to administrator status.\n"); return; end
	if (Player.alreadyBanningForCheats) then  Msg(" Not banning because a ban for that user is already in progress.\n"); return; end
	
	Player.alreadyBanningForCheats = true;
	
	if (isStolenGoods) then
		Msg(" Banning user for 31 days.\n");
		Player:PERPBan(31 * 24 * 60, "Stolen Goods.");
	else
		Msg(" Banning user for 1 day.\n");
		Player:PERPBan(24, "Cheats detected.");
	end
end
concommand.Add("perp_ug", GM.DetectedCheats);