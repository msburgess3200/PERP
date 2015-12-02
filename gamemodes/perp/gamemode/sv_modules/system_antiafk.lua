local function AntiAFK( Player )
	
	Player.Position2 = Player:GetPos();
	
	if !Player.Position1 then
		Player.Position1 = Player:GetPos();
	elseif Player.Position1 == Player.Position2 then
		if Player:GetLevel() > 100 then
			Player.Position1 = nil;
			Player.Position2 = nil;
			Player:Kick("AFK");
		else
			Player:Notify("AFK: Not kicked cause of " .. Player:GetRankString() .. " Status.");
		end
	else
		Player.Position1 = Player:GetPos();
	end
	
end

local function AntiAFKMainTimer ( )
	for k, v in pairs(player.GetAll()) do
		AntiAFK(v);
	end
end
timer.Create("afktimer", 900, 0, AntiAFKMainTimer) 