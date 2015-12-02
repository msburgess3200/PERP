


function GM.PlayerDieingSounds ( )
	// Local player heartbeat on death.
	if !LocalPlayer():Alive() then		
		if !GAMEMODE.HeartbeatNoise then
			GAMEMODE.HeartbeatNoise = CreateSound(LocalPlayer(), Sound('player/heartbeat1.wav'));
		end
		
		GAMEMODE.LastHeartBeatPlay = GAMEMODE.LastHeartBeatPlay or 0;
		
		if GAMEMODE.LastHeartBeatPlay + .717 <= CurTime() then
			GAMEMODE.LastHeartBeatPlay = CurTime();
			GAMEMODE.HeartbeatNoise:Stop();
			GAMEMODE.HeartbeatNoise:Play();
		end
	elseif GAMEMODE.HeartbeatNoise then
		GAMEMODE.HeartbeatNoise:Stop();
		GAMEMODE.HeartbeatNoise = nil;
	end
	
	// global player moaning on death
	for k, v in pairs(player.GetAll()) do
		if !v:Alive() then
			v:GetTable().NextGroan = v:GetTable().NextGroan or CurTime() + math.random(5, 15);
			
			if v:GetTable().NextGroan < CurTime() then				
				v:GetTable().NextGroan = nil;
				
				local ToUse = "male";
				if (v:GetSex() == SEX_FEMALE) then ToUse = "female"; end
				
				local MoanFile = Sound('vo/npc/' .. ToUse .. '01/moan0' .. math.random(1, 5) .. '.wav');
				sound.Play(MoanFile, v:GetPos(), 100, 100);
			end
		elseif v:GetTable().NextGroan then
			v:GetTable().NextGroan = nil;
		end
	end
end
hook.Add('Think', 'GM.PlayerDieingSounds', GM.PlayerDieingSounds);