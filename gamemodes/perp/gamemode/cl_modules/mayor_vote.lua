


local function MayorElectionStart ( UMsg )
	local numNominees = UMsg:ReadShort();
	
	GAMEMODE.VotePanel = vgui.Create("perp2_mayor_election");
	
	for i = 1, numNominees do
		local nominee = UMsg:ReadEntity();
		
		if (nominee && IsValid(nominee)) then
			GAMEMODE.VotePanel:AddPlayer(nominee);
		end
	end
end
usermessage.Hook("perp_mayor_election", MayorElectionStart);

local function MayorElectionFinish ( UMsg )
	local ent = UMsg:ReadEntity();
	local numVotes = UMsg:ReadShort();
	
	if (ent == LocalPlayer()) then
		LocalPlayer():Notify("You won mayordom with " .. numVotes .. " votes.");
	elseif (ent && IsValid(ent)) then
		LocalPlayer():Notify(ent:GetRPName() .. " won mayordom with " .. numVotes .. " votes.");
	end
	
	if (GAMEMODE.VotePanel) then
		GAMEMODE.VotePanel:Remove();
		GAMEMODE.VotePanel = nil;
	end
	
	GAMEMODE.IsRunningForMayor = nil;
end
usermessage.Hook("perp_mayor_end", MayorElectionFinish);