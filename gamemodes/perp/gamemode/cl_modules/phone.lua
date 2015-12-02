


function monitorKeyPress ( )
	if (!LocalPlayer():Alive()) then return; end
	if (GAMEMODE.ChatBoxOpen) then return; end
	if (GAMEMODE.MayorPanel && GAMEMODE.MayorPanel.IsVisible && GAMEMODE.MayorPanel:IsVisible()) then return; end
	if (GAMEMODE.OrgPanel && GAMEMODE.OrgPanel.IsVisible && GAMEMODE.OrgPanel:IsVisible()) then return; end
	if (GAMEMODE.HelpPanel && GAMEMODE.HelpPanel.IsVisible && GAMEMODE.HelpPanel:IsVisible()) then return; end
		
	if (input.IsKeyDown(GAMEMODE.GetPhoneKey())) then	
		if (GAMEMODE.PhoneText == "Call From") then
			GAMEMODE.PhoneText = "Connected To";
			RunConsoleCommand("perp_ac");
			GAMEMODE.Call_Time = CurTime();
		elseif (GAMEMODE.Call_Player && (CurTime() - GAMEMODE.Call_Time) > 1) then
			GAMEMODE.Call_Player = nil;
			GAMEMODE.Call_Time = nil;
			GAMEMODE.lastRing = nil;
					
			RunConsoleCommand("perp_cp");
			
			GAMEMODE.Phone:GoDown();
		elseif (!GAMEMODE.Phone.CurUp && (!GAMEMODE.Phone.ShowingTime || GAMEMODE.Phone.ShowingTime < CurTime()) && LocalPlayer():HasItem("item_phone")) then
			GAMEMODE.Phone:GoUp();
		end
	end
end
hook.Add("Think", "monitorKeyPress", monitorKeyPress);

local function acceptedCall ( )
	GAMEMODE.PhoneText = "Connected To";
end
usermessage.Hook("perp_acall", acceptedCall);

local function dropCall ( UMsg )
	if (GAMEMODE.Call_Player) then GAMEMODE.Phone:GoDown(); end
	
	GAMEMODE.Call_Player = nil;
	GAMEMODE.Call_Time = nil;
	
	surface.PlaySound(Sound("PERP2.5/phone_busy.mp3"));
end
usermessage.Hook("perp_dcall", dropCall);

local function errorCall ( UMsg )
	GAMEMODE.PhoneText = "Connected To";

	timer.Simple(SoundDuration("PERP2.5/phone_error.mp3"), function ( )
		if (GAMEMODE.Call_Time) then
			if (GAMEMODE.Call_Player) then GAMEMODE.Phone:GoDown(); end
			
			GAMEMODE.Call_Player = nil;
			GAMEMODE.Call_Time = nil;
		end
	end);
	
	surface.PlaySound(Sound("PERP2.5/phone_error.mp3"));
end
usermessage.Hook("perp_ecall", errorCall);

local function hangup ( UMsg )
	if (GAMEMODE.Call_Player) then GAMEMODE.Phone:GoDown(); end
	
	GAMEMODE.Call_Player = nil;
	GAMEMODE.Call_Time = nil;
	GAMEMODE.PhoneText = nil;
end
usermessage.Hook("perp_hangup", hangup);

local function ring ( UMsg )
	local playerRinging = UMsg:ReadEntity();
	local playerRFrom = UMsg:ReadEntity();
	playerRinging.ringing = true;
	
	if (playerRinging == LocalPlayer() && !GAMEMODE.Call_Player) then
		GAMEMODE.Call_Player = playerRFrom:GetRPName();
		GAMEMODE.Call_Time = CurTime();
		GAMEMODE.PhoneText = "Call From";

		GAMEMODE.Phone:GoUp();		
		GAMEMODE.Phone:SetKeyboardInputEnabled();
	end
end
usermessage.Hook("perp_ring", ring);

local function stopRing ( UMsg )
	local playerRinging = UMsg:ReadEntity();
	playerRinging.ringing = nil;
	
	if (playerRinging == LocalPlayer() && GAMEMODE.Call_Player && GAMEMODE.PhoneText == "Call From") then
		GAMEMODE.Call_Player = nil;
		GAMEMODE.Call_Time = nil;
		
		GAMEMODE.Phone:GoDown();
	end
end
usermessage.Hook("perp_sring", stopRing);

local function monitorRinging ( ) 
	for k, v in pairs(player.GetAll()) do
		if (v.ringing) then
			if (!v.lastRingTime || v.lastRingTime < CurTime()) then
				if (!v.ringer) then
					v.ringer = CreateSound(v, Sound("PERP2.5/ringtones/" .. GAMEMODE.Ringtones[v:GetUMsgInt("ringtone", 1)][2]));
				end
								
				v.ringer:Stop();
				v.ringer:Play();
				
				v.lastRingTime = CurTime() + SoundDuration("PERP2.5/ringtones/" .. GAMEMODE.Ringtones[v:GetUMsgInt("ringtone", 1)][2]) + 1;
			end
		elseif (v.lastRingTime) then
			v.lastRingTime = nil;
			v.ringer:Stop();
			v.ringer = nil;
		end
	end
end
hook.Add("Think", "monitorRinging", monitorRinging);