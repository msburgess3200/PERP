local PLUGIN = {}

PLUGIN.Name = "Teleport"
PLUGIN.Author = "Who knows"
PLUGIN.Date = "15th March 2011"
PLUGIN.Filename = PLUGIN_FILENAME
PLUGIN.ClientSide = true
PLUGIN.ServerSide = true
PLUGIN.APIVersion = 2

if (SERVER) then

	ASS_NewLogLevel("ASS_ACL_TELEPORT")
	
	function PLUGIN.BringToTarget( PLAYER, CMD, ARGS )

		if (PLAYER:GetLevel() <= 2) then

			local TO_TPTOT = ASS_FindPlayer(ARGS[1])

			if (!TO_TPTOT) then

				ASS_MessagePlayer(PLAYER, "Player not found!\n")
				return

			end
			
			if (TO_TPTOT != PLAYER) then
				if (TO_TPTOT:IsBetterOrSame(PLAYER)) then

					ASS_MessagePlayer(PLAYER, "Access denied! \"" .. TO_TPTOT:Nick() .. "\" has same or better access then you.")
					return
				end
			end
			
			if (ASS_RunPluginFunction( "AllowPlayerKill", true, PLAYER, TO_TPTOT )) then
			
				local trace = {} 
				trace.start = PLAYER:GetShootPos()
				trace.endpos = PLAYER:GetShootPos() + PLAYER:GetAimVector() * 99999
				trace.filter = PLAYER
				local tr = util.TraceLine( trace )
				
				TO_TPTOT:SetPos( tr.HitPos - PLAYER:GetAimVector( ) * 50 + Vector( 0, 0, 15 ) ) -- So they don't get stuck in the wall

				ASS_LogAction( PLAYER, ASS_ACL_TELEPORT, "teleported "..ASS_FullNick(TO_TPTOT).." to his target." )
					
			end


		else

			ASS_MessagePlayer( PLAYER, "Access Denied!\n")

		end

	end
	concommand.Add("ASS_BringToTarget", PLUGIN.BringToTarget)
	
	
	
	
	
	
	
	
	
	
	
	
	-- Code from ULX so thank Megiddo for this. This is so players don't get stuck in the world when you teleport them
	local function playerSend( from, to, force )
		if not to:IsInWorld() and not force then return false end -- No way we can do this one

		local yawForward = to:EyeAngles().yaw
		local directions = { -- Directions to try
			math.NormalizeAngle( yawForward - 180 ), -- Behind first
			math.NormalizeAngle( yawForward + 180 ), -- Front
			math.NormalizeAngle( yawForward + 90 ), -- Right
			math.NormalizeAngle( yawForward - 90 ), -- Left
			yawForward,
		}

		local t = {}
		t.start = to:GetPos() + Vector( 0, 0, 15 ) -- Move them up a bit so they can travel across the ground
		t.filter = { to, from }

		local i = 1
		t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47 -- (33 is player width, this is sqrt( 33^2 * 2 ))
		local tr = util.TraceEntity( t, from )
	    while tr.Hit do -- While it's hitting something, check other angles
	    	i = i + 1
	    	if i > #directions then  -- No place found
				if force then
					return to:GetPos() + Angle( 0, directions[ 1 ], 0 ):Forward() * 47
				else
					return false
				end
			end

			t.endpos = to:GetPos() + Angle( 0, directions[ i ], 0 ):Forward() * 47

			tr = util.TraceEntity( t, from )
	    end

		return tr.HitPos
	end




	
	
	
	
	
	
	
	
	
	
	
	
	function PLUGIN.BringToMe( PLAYER, CMD, ARGS )

		if (PLAYER:GetLevel() <= 2) then

			local TO_BRING = ASS_FindPlayer(ARGS[1])

			if (!TO_BRING) then

				ASS_MessagePlayer(PLAYER, "Player not found!\n")
				return

			end
			
			if (TO_BRING != PLAYER) then
				if (TO_BRING:IsBetterOrSame(PLAYER)) then

					ASS_MessagePlayer(PLAYER, "Access denied! \"" .. TO_BRING:Nick() .. "\" has same or better access then you.")
					return
				end
			end
			
			if (ASS_RunPluginFunction( "AllowPlayerKill", true, PLAYER, TO_BRING )) then
				
				local newpos = playerSend( TO_BRING, PLAYER, TO_BRING:GetMoveType() == MOVETYPE_NOCLIP )
				
				if not newpos then
					ASS_MessagePlayer(PLAYER, "Can't find a place to put "..TO_BRING:Nick().."!")
					return
				end

				local newang = (PLAYER:GetPos() - newpos):Angle()

				TO_BRING:SetPos( newpos )
				TO_BRING:SetEyeAngles( newang )
				TO_BRING:SetLocalVelocity( Vector( 0, 0, 0 ) )

				ASS_LogAction( PLAYER, ASS_ACL_TELEPORT, "brought "..ASS_FullNick(TO_BRING).." to him" )
					
			end


		else

			ASS_MessagePlayer( PLAYER, "Access Denied!\n")

		end

	end
	concommand.Add("ASS_BringToMe", PLUGIN.BringToMe)
	
	
	function PLUGIN.TeleportTo( PLAYER, CMD, ARGS )

		if (PLAYER:GetLevel() <= 3) then

			local TO_TPTO = ASS_FindPlayer(ARGS[1])

			if (!TO_TPTO) then

				ASS_MessagePlayer(PLAYER, "Player not found!\n")
				return

			end
			
			if (ASS_RunPluginFunction( "AllowPlayerKill", true, PLAYER, TO_TPTO )) then

				local newpos = playerSend( PLAYER, TO_TPTO, PLAYER:GetMoveType() == MOVETYPE_NOCLIP )
				
				if not newpos then
					ASS_MessagePlayer(PLAYER, "Can't find a place to put yourself! Get in noclip.")
					return
				end

				local newang = (TO_TPTO:GetPos() - newpos):Angle()

				PLAYER:SetPos( newpos )
				PLAYER:SetEyeAngles( newang )
				PLAYER:SetLocalVelocity( Vector( 0, 0, 0 ) )

				ASS_LogAction( PLAYER, ASS_ACL_TELEPORT, "teleported to "..ASS_FullNick(TO_TPTO) )
					
			end


		else

			ASS_MessagePlayer( PLAYER, "Access Denied!\n")

		end

	end
	concommand.Add("ASS_TeleportTo", PLUGIN.TeleportTo)
	
	
	
	function PLUGIN.TeleportToTarget( PLAYER, CMD, ARGS )

		if (PLAYER:GetLevel() <= 2) then

			local TO_TPTOT = ASS_FindPlayer(ARGS[1])

			if (!TO_TPTOT) then

				ASS_MessagePlayer(PLAYER, "Player not found!\n")
				return

			end
			
			if (TO_TPTOT != PLAYER) then
				if (TO_TPTOT:IsBetterOrSame(PLAYER)) then

					ASS_MessagePlayer(PLAYER, "Access denied! \"" .. TO_TPTOT:Nick() .. "\" has same or better access then you.")
					return
				end
			end
			
			if (ASS_RunPluginFunction( "AllowPlayerKill", true, PLAYER, TO_TPTOT )) then
				
				local trace = {} 
				trace.start = PLAYER:GetShootPos()
				trace.endpos = PLAYER:GetShootPos() + PLAYER:GetAimVector() * 99999
				trace.filter = PLAYER
				local tr = util.TraceLine( trace )
				
				TO_TPTOT:SetPos( tr.HitPos - PLAYER:GetAimVector() * 50 + Vector( 0, 0, 15 ) ) -- So they don't get stuck in the wall


				ASS_LogAction( PLAYER, ASS_ACL_TELEPORT, "teleported " .. ASS_FullNick(TO_TPTOT) .. " to their target." )
					
			end


		else

			ASS_MessagePlayer( PLAYER, "Access Denied!\n")

		end

	end
	concommand.Add("ASS_TeleportToTarget", PLUGIN.TeleportToTarget)


end

if (CLIENT) then

	function PLUGIN.BringToTarget(PLAYER)
		
		if (!PLAYER:IsValid()) then return end

		RunConsoleCommand( "ASS_BringToTarget", PLAYER:UniqueID() )

	end	
	
	function PLUGIN.BringToMe(PLAYER)
		
		if (!PLAYER:IsValid()) then return end

		RunConsoleCommand( "ASS_BringToMe", PLAYER:UniqueID() )

	end
	
	function PLUGIN.TeleportTo(PLAYER)
		
		if (!PLAYER:IsValid()) then return end

		RunConsoleCommand( "ASS_TeleportTo", PLAYER:UniqueID() )

	end
	
	function PLUGIN.TeleportToTarget(PLAYER)
		
		if (!PLAYER:IsValid()) then return end

		RunConsoleCommand( "ASS_TeleportToTarget", PLAYER:UniqueID() )

	end
	
	
	function PLUGIN.BuildMenuA(NEWMENU)
		
		ASS_PlayerMenu( NEWMENU, {"IncludeLocalPlayer", "IncludeAll"}, PLUGIN.BringToTarget  )
		
	end	
	
	function PLUGIN.BuildMenuB(NEWMENU)
		
		ASS_PlayerMenu( NEWMENU, {"IncludeLocalPlayer", "IncludeAll"}, PLUGIN.BringToMe  )
		
	end
	
	function PLUGIN.BuildMenuC(NEWMENU)
		
		ASS_PlayerMenu( NEWMENU, {"IncludeLocalPlayer", "IncludeAll"}, PLUGIN.TeleportTo  )
		
	end
	
	function PLUGIN.BuildMenuD(NEWMENU)
		
		ASS_PlayerMenu( NEWMENU, {"IncludeLocalPlayer", "IncludeAll"}, PLUGIN.TeleportToTarget  )
		
	end
	
	function PLUGIN.AddMenu(DMENU)
		
		DMENU:AddSubMenu( "Bring To My Target" , nil, PLUGIN.BuildMenuA)		
		DMENU:AddSubMenu( "Bring To Me" , nil, PLUGIN.BuildMenuB)
		DMENU:AddSubMenu( "Teleport To" , nil, PLUGIN.BuildMenuC)
		//DMENU:AddSubMenu( "[SA] Teleport To Target" , nil, PLUGIN.BuildMenuD)

	end

end

ASS_RegisterPlugin(PLUGIN)


