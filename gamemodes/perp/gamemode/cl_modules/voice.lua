


local static_Start = Sound("PERP2.5/cradio_start.mp3");
local static_Stop = Sound("PERP2.5/cradio_close.mp3");

local function thinkRadioStatic ( )
	if (GAMEMODE.PlayStatic) then
		if (!GAMEMODE.StaticNoise) then
			GAMEMODE.StaticNoise = CreateSound(LocalPlayer(), Sound("PERP2.5/cradio_static.mp3"));
		end
		
		if (!GAMEMODE.NextStaticPlay || GAMEMODE.NextStaticPlay < CurTime()) then
			GAMEMODE.NextStaticPlay = CurTime() + SoundDuration("PERP2.5/cradio_static.mp3") - .1;
			GAMEMODE.StaticNoise:Stop();
			GAMEMODE.StaticNoise:Play();
		end
	elseif (GAMEMODE.NextStaticPlay) then
		GAMEMODE.NextStaticPlay = nil;
		GAMEMODE.StaticNoise:Stop();
	end
end
hook.Add("Think", "thinkRadioStatic", thinkRadioStatic);

-- local PlayerMetaTable = FindMetaTable('Player');

-- function PlayerMetaTable:SetMuteState ( Boolean )	
	-- if self:IsMuted() != Boolean then
		-- self:SetMuted(Boolean);
	-- end
-- end

-- function GM.VoiceFadeDistance ( )
	-- local OurPos = LocalPlayer():GetPos();
	-- if PERP_SpectatingEntity and PERP_SpectatingEntity:IsValid() and PERP_SpectatingEntity:IsPlayer() then
		-- OurPos = PERP_SpectatingEntity:GetPos();
	-- end

	-- for k, v in pairs(player.GetAll()) do
		-- if v == LocalPlayer() then
			-- v:SetMuteState(true);
		-- else
			-- if v:InVehicle() and LocalPlayer():InVehicle() and (v:GetVehicle():IsGovVehicle() and LocalPlayer():GetVehicle():IsGovVehicle() && LocalPlayer():Team() != TEAM_CITIZEN && LocalPlayer():Team() != TEAM_MAYOR && LocalPlayer():GetRPName() != GAMEMODE.Call_Player) then
				-- v:SetMuteState(false);
			-- elseif v:GetPos():Distance(OurPos) < ChatRadius_Local then
				-- v:SetMuteState(false);
			-- else
				-- v:SetMuteState(true);
			-- end
		-- end
	-- end
-- end
-- timer.Create('GAMEMODE.VoiceFadeDistance', 1, 0, GM.VoiceFadeDistance);


function GM:PlayerStartVoice ( ply ) 
	if (ply == LocalPlayer()) then GAMEMODE.CurrentlyTalking = true; return; end
	
	if (ply:GetPos():Distance(LocalPlayer():GetPos()) > (ChatRadius_Local + 50) && ply:Team() != TEAM_CITIZEN && ply:Team() != TEAM_MAYOR && ply:GetRPName() != GAMEMODE.Call_Player) then
		GAMEMODE.PlayStatic = true;
		ply.PlayingStaticFor = true;
		
		surface.PlaySound(static_Start);
	end
end
	
function GM:PlayerEndVoice ( ply ) 
	if (ply == LocalPlayer()) then GAMEMODE.CurrentlyTalking = nil; return ;end
	
	if (ply.PlayingStaticFor) then
		ply.PlayingStaticFor = nil;
		surface.PlaySound(static_Stop);
	end
	
	if (!GAMEMODE.PlayStatic) then return; end
	
	local shouldPlayStatic = false;
	for k, v in pairs(player.GetAll()) do
		if (v.PlayingStaticFor) then
			shouldPlayStatic = true;
		end
	end
	
	GAMEMODE.PlayStatic = shouldPlayStatic;
end

local function monitorKeyPress_WalkieTalkie ( )
	if (GAMEMODE.ChatBoxOpen) then return; end
	if (GAMEMODE.MayorPanel && GAMEMODE.MayorPanel.IsVisible && GAMEMODE.MayorPanel:IsVisible()) then return; end
	if (GAMEMODE.OrgPanel && GAMEMODE.OrgPanel.IsVisible && GAMEMODE.OrgPanel:IsVisible()) then return; end
	if (GAMEMODE.HelpPanel && GAMEMODE.HelpPanel.IsVisible && GAMEMODE.HelpPanel:IsVisible()) then return; end
	
	if (input.IsKeyDown(KEY_T)) then
		if (!GAMEMODE.lastTDown) then
			GAMEMODE.lastTDown = true;
			
			if (LocalPlayer():GetUMsgBool("tradio", false)) then
				RunConsoleCommand("perp_tr", "0")
				LocalPlayer().StringRedun["tradio"] = {entity = LocalPlayer(), value = false};
			else
				RunConsoleCommand("perp_tr", "1");
				LocalPlayer().StringRedun["tradio"] = {entity = LocalPlayer(), value = true};
			end
		end
	else GAMEMODE.lastTDown = nil; end
end
hook.Add("Think", "monitorKeyPress_WalkieTalkie", monitorKeyPress_WalkieTalkie);