


local function setRingTone ( Player, cmd, Args)
	if (!Player) then return; end
	if (!Args[1]) then return; end
	if (!GAMEMODE.Ringtones[tonumber(Args[1])]) then return; end
	if (GAMEMODE.Ringtones[tonumber(Args[1])][3] && !Player[GAMEMODE.Ringtones[tonumber(Args[1])][3]](Player)) then return; end
	
	Player:SetUMsgInt("ringtone", tonumber(Args[1]));
end
concommand.Add("perp_rt", setRingTone);

local function CallPlayer ( Player, cmd, Args )
	if (!Player) then return; end
	if (!Args[1]) then return; end
	if (!Player:HasItem("item_phone")) then return; end
	
	local playerUniqueID = Args[1];
		
	local playerToCall;
	for k, v in pairs(player.GetAll()) do
		if (tostring(v:UniqueID()) == playerUniqueID) then
			playerToCall = v;
		end
	end
	if (!playerToCall) then 
		umsg.Start("perp_dcall", Player); umsg.End();
	return; end
	
	if (playerToCall == Player) then 
		umsg.Start("perp_dcall", Player); umsg.End();
	return; end
	
	if (playerToCall.Calling) then
		umsg.Start("perp_dcall", Player); umsg.End();
	return; end
	
	if (!playerToCall:HasItem("item_phone")) then
		umsg.Start("perp_ecall", Player); umsg.End();
	return; end

	umsg.Start("perp_ring");
		umsg.Entity(playerToCall);
		umsg.Entity(Player);
	umsg.End();
	
	Player.Calling = playerToCall;
	Player.PickedUp = false;
	Player.Initiator = true;
	Player.StartCall = CurTime();
	
	playerToCall.Calling = Player;
	playerToCall.PickedUp = false;
	playerToCall.StartCall = CurTime();
end
concommand.Add("perp_dp", CallPlayer);

function DropCall ( Player )
	if (!Player.Calling) then return; end
	
	if (Player.Calling) then
		if (!Player.PickedUp) then
			umsg.Start("perp_sring");
				umsg.Entity(Player.Calling);
			umsg.End();
		else
			umsg.Start("perp_hangup", Player.Calling);
			umsg.End();
		end
		
		Player.Calling.Initiator = nil;
		Player.Calling.PickedUp = nil;
		Player.Calling.Calling = nil;
	end
	
	Player.Initiator = nil;
	Player.PickedUp = nil;
	Player.Calling = nil;
end
concommand.Add("perp_cp", DropCall);

local function AcceptCall ( Player )
	if (!Player.Calling) then return; end
	
	if (!Player.Calling || !IsValid(Player.Calling)) then
		umsg.Start("perp_hangup", Player.Calling);
		umsg.End();
		
		Player.PickedUp = nil;
		Player.Calling = nil;
		Player.Initiator = nil
	else
		umsg.Start("perp_acall", Player.Calling); umsg.End();
	end
	
	umsg.Start("perp_sring"); umsg.Entity(Player); umsg.End();
	
	Player.Calling.PickedUp = true;
	Player.PickedUp = true;
end
concommand.Add("perp_ac", AcceptCall);

local function monitorCallTimes ( )
	for k, v in pairs(player.GetAll()) do
		if (v.Calling && !IsValid(v.Calling)) then
			umsg.Start("perp_dcall", v);
			umsg.End();
			
			v.Calling = nil;
			v.PickedUp = nil;
			v.Initiator = nil;
			v.StartCall = nil;
		elseif (v.Calling && !v.PickedUp && CurTime() - v.StartCall > 15 && v.Initiator) then
			umsg.Start("perp_sring");
				umsg.Entity(v.Calling);
			umsg.End();
			
			umsg.Start("perp_dcall", v);
			umsg.End();
			
			v.Calling.PickedUp = nil;
			v.Calling.StartCall = nil;
			v.Calling.Initiator = nil;
			v.Calling.Calling = nil;
			v.Calling = nil;
			v.PickedUp = nil;
			v.Initiator = nil;
			v.StartCall = nil;
		end
	end
end
hook.Add("Think", "monitorCallTimes", monitorCallTimes);