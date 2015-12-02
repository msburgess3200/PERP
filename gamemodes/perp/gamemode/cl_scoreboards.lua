



include( "scoreboards/scoreboard.lua" )

local pScoreBoard = nil


/*---------------------------------------------------------
   Name: gamemode:CreateScoreboard( )
   Desc: Creates/Recreates the scoreboard
---------------------------------------------------------*/
function GM:CreateScoreboard()

	if ( pScoreBoard ) then
	
		pScoreBoard:Remove()
		pScoreBoard = nil
	
	end

	pScoreBoard = vgui.Create( "ScoreBoard" )

end

/*---------------------------------------------------------
   Name: gamemode:ScoreboardShow( )
   Desc: Sets the scoreboard to visible
---------------------------------------------------------*/
function GM:ScoreboardShow()
	

	GAMEMODE.ShowScoreboard = true
	gui.EnableScreenClicker( true )
	
	if ( !pScoreBoard ) then
		self:CreateScoreboard()
	end
	
	pScoreBoard:SetVisible( true )
	pScoreBoard:UpdateScoreboard( true )
	
end

/*---------------------------------------------------------
   Name: gamemode:ScoreboardHide( )
   Desc: Hides the scoreboard
---------------------------------------------------------*/
function GM:ScoreboardHide()

	

	GAMEMODE.ShowScoreboard = false
	gui.EnableScreenClicker( false )
	
	if ( pScoreBoard ) then pScoreBoard:SetVisible( false ) end
	
end

function GM:HUDDrawScoreBoard()

	// Do nothing (We're vgui'd up)
	
end

