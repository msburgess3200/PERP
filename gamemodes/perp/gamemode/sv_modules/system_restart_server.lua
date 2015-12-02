


RestartGoing = false;

function PrintMessageAll ( Text )
	Msg(Text .. '\n');

	for k, v in pairs(player.GetAll()) do
		if v and v:IsValid() and v:IsPlayer() then
			v:Notify(Text)
		end
	end
end

function GM.RestartMap ( Player, Command, Args )
	if !Player:Owner() then return false; end
	if RestartGoing then return false; end
	
	RestartGoing = true;
	
	PrintMessageAll('Server restart in 10 minutes.');
	timer.Simple(60 * 1, function() PrintMessageAll( 'Server restart in 9 minutes.') end);
	timer.Simple(60 * 2, function() PrintMessageAll( 'Server restart in 8 minutes.') end);
	timer.Simple(60 * 3, function() PrintMessageAll( 'Server restart in 7 minutes.') end);
	timer.Simple(60 * 4, function() PrintMessageAll( 'Server restart in 6 minutes.') end);
	timer.Simple(60 * 5, function() PrintMessageAll( 'Server restart in 5 minutes.') end);
	timer.Simple(60 * 6, function() PrintMessageAll( 'Server restart in 4 minutes.') end);
	timer.Simple(60 * 7, function() PrintMessageAll( 'Server restart in 3 minutes.') end);
	timer.Simple(60 * 8, function() PrintMessageAll( 'Server restart in 2 minutes.') end);
	timer.Simple(60 * 9, function() PrintMessageAll( 'Server restart in 1 minutes.') end);
	timer.Simple(60 * 9 + 30, function() PrintMessageAll( 'Server restart in 30 seconds.') end);
	timer.Simple(60 * 9 + 45, function() PrintMessageAll( 'Server restart in 15 seconds.') end);
	timer.Simple(60 * 9 + 50, function() PrintMessageAll( 'Server restart in 10 seconds.') end);
	
	for i = 1, 8 do
		timer.Simple(60 * 9 + 50 + i, function() PrintMessageAll( 'Server restart in ' .. 10 - i .. ' seconds.') end);
	end
	
	timer.Simple(60 * 9 + 59, function() PrintMessageAll( 'Server restart in 1 second.') end);
	
	timer.Simple(60 * 10, function() RunConsoleCommand( 'changelevel', game.GetMap, game.GetGamemode()) end);
	timer.Simple(60 * 9 + 55, function() RunConsoleCommand('changelevel', function ( ) for k, v in pairs(player.GetAll()) do v:ForceItemCommitage() end end) end);
end
concommand.Add('perp_restart_server', GM.RestartMap);