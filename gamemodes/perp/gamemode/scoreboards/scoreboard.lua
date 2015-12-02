

 
 
include( "player_row.lua" )
include( "player_frame.lua" )

surface.CreateFont("ScoreboardHeader", {
	font="coolvetica",
	size=32,
	weight=500,
	antialias=true
})
surface.CreateFont("ScoreboardSubtitle", {
	font="coolvetica",
	size=22,
	weight=500,
	antialias=true
})


local texGradient 	= surface.GetTextureID( "gui/center_gradient" )
local texLogo 		= surface.GetTextureID( "gui/gmod_logo" )


local PANEL = {}
local Disguised = {}

/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:Init()

	SCOREBOARD = self
	
	self.Hostname = vgui.Create( "DLabel", self )
	self.Hostname:SetText( GetHostName() )
	
	self.Description = vgui.Create( "DLabel", self )
	self.Description:SetText( "CTSGaming.com | Roleplay" )
	
	self.PlayerFrame = vgui.Create( "PlayerFrame", self )
	
	self.PlayerRows = {}

	self:UpdateScoreboard()
	
	// Update the scoreboard every 1 second
	timer.Create( "ScoreboardUpdater", 1, 0, function() self:UpdateScoreboard() end)
	
		
	self.lblPing = vgui.Create( "DLabel", self )
	self.lblPing:SetText( "Ping" )
	
	self.lblRoadCrew = vgui.Create( "DLabel", self )
	self.lblRoadCrew:SetText( "" ) 
	
	self.lblBusDriver = vgui.Create( "DLabel", self )
	self.lblBusDriver:SetText( "" )
	
	self.lblPolice = vgui.Create( "DLabel", self )
	self.lblPolice:SetText( "" )
	
	self.lblFiremen = vgui.Create( "DLabel", self )
	self.lblFiremen:SetText( "" )
	
	self.lblMedics = vgui.Create( "DLabel", self )
	self.lblMedics:SetText( "" )

	self.lblSWAT = vgui.Create( "DLabel", self )
	self.lblSWAT:SetText( "" )
	
	self.lblDispatcher = vgui.Create( "DLabel", self )
	self.lblDispatcher:SetText( "" )
	
	self.lblSecretService = vgui.Create( "DLabel", self )
	self.lblSecretService:SetText( "" )
	
	self.lblRoadCrew = vgui.Create( "DLabel", self )
	self.lblRoadCrew:SetText( "" ) 
	
	self.lblBusDriver = vgui.Create( "DLabel", self )
	self.lblBusDriver:SetText( "" )

end

/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:AddPlayerRow( ply )

	local button = vgui.Create( "ScorePlayerRow", self.PlayerFrame:GetCanvas() )
	button:SetPlayer( ply )
	self.PlayerRows[ ply ] = button

end

/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:GetPlayerRow( ply )

	return self.PlayerRows[ ply ]

end

/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:Paint()
	
	self.lblPolice:SetText("Officers: " .. team.NumPlayers(TEAM_POLICE) .. " / " .. GAMEMODE.MaximumCops);
	self.lblFiremen:SetText("Firemen: " .. team.NumPlayers(TEAM_FIREMAN) .. " / " .. GAMEMODE.MaximumFireMen);
	self.lblMedics:SetText("Medics: " .. team.NumPlayers(TEAM_MEDIC) .. " / " .. GAMEMODE.MaximumParamedic);
	self.lblSWAT:SetText("SWAT: " .. team.NumPlayers(TEAM_SWAT) .. " / " .. GAMEMODE.MaximumSWAT);
	self.lblDispatcher:SetText("Dispatchers: " .. team.NumPlayers(TEAM_DISPATCHER) .. " / " .. GAMEMODE.MaximumDispatchers);
	self.lblSecretService:SetText("Secret Service: " .. team.NumPlayers(TEAM_SECRET_SERVICE) .. " / " .. GAMEMODE.MaximumSecretService);
	self.lblRoadCrew:SetText("Road Crew Workers: " .. team.NumPlayers(TEAM_ROADCREW) .. " / " .. GAMEMODE.MaximumRoadCrew);
	self.lblBusDriver:SetText("Public Transportation Drivers: " .. team.NumPlayers(TEAM_BUSDRIVER) .. " / " .. GAMEMODE.MaximumBusDrivers);
	
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), Color( 50, 50, 50, 255 ) )
	surface.SetTexture( texGradient )
	surface.SetDrawColor( 255, 255, 255, 50 )
	surface.DrawTexturedRect( 0, 0, self:GetWide(), self:GetTall() ) 
	
	// White Inner Box
	draw.RoundedBox( 4, 4, self.Description.y - 4, self:GetWide() - 8, self:GetTall() - self.Description.y - 4, Color( 230, 230, 230, 200 ) )
	surface.SetTexture( texGradient )
	surface.SetDrawColor( 255, 255, 255, 50 )
	surface.DrawTexturedRect( 4, self.Description.y - 4, self:GetWide() - 8, self:GetTall() - self.Description.y - 4 )
	
	// Sub Header
	draw.RoundedBox( 4, 5, self.Description.y - 3, self:GetWide() - 10, self.Description:GetTall() + 5, Color( 10, 10, 10, 200 ) )
	surface.SetTexture( texGradient )
	surface.SetDrawColor( 100, 100, 100, 50 )
	surface.DrawTexturedRect( 4, self.Description.y - 4, self:GetWide() - 8, self.Description:GetTall() + 8 ) 
	
	// Logo!
	surface.SetTexture( texLogo )
	surface.SetDrawColor( 255, 255, 255, 255 )
	surface.DrawTexturedRect( 0, 0, 128, 128 ) 
	
	
	
	//draw.RoundedBox( 4, 10, self.Description.y + self.Description:GetTall() + 6, self:GetWide() - 20, 12, Color( 0, 0, 0, 50 ) )

end


/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:PerformLayout()

	self.Hostname:SizeToContents()
	self.Hostname:SetPos( 115, 16 )
	
	self.Description:SizeToContents()
	self.Description:SetPos( 128, 64 )
	
	local iTall = self.PlayerFrame:GetCanvas():GetTall() + self.Description.y + self.Description:GetTall() + 30
	iTall = math.Clamp( iTall, 100, ScrH() * 0.9 )
	local iWide = math.Clamp( ScrW() * 0.8, 700, ScrW() * 0.6 )
	
	self:SetSize( iWide, iTall )
	self:SetPos( (ScrW() - self:GetWide()) / 2, (ScrH() - self:GetTall()) / 4 )
	
	self.PlayerFrame:SetPos( 5, self.Description.y + self.Description:GetTall() + 20 )
	self.PlayerFrame:SetSize( self:GetWide() - 10, self:GetTall() - self.PlayerFrame.y - 10 )
	
	local y = 0
	
	local PlayerSorted = {}
	
	for k, v in pairs( self.PlayerRows ) do
	
		table.insert( PlayerSorted, v )
		
	end
	
	table.sort( PlayerSorted, function ( a , b) return a:HigherOrLower( b ) end )
	
	for k, v in ipairs( PlayerSorted ) do
	
		v:SetPos( 0, y )	
		v:SetSize( self.PlayerFrame:GetWide(), v:GetTall() )
		
		self.PlayerFrame:GetCanvas():SetSize( self.PlayerFrame:GetCanvas():GetWide(), y + v:GetTall() )
		
		y = y + v:GetTall() + 1
	
	end
	
	self.Hostname:SetText( GetHostName() )
	
	self.lblPing:SizeToContents()
	self.lblPing:SetPos( self:GetWide() - 50 - self.lblPing:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3  )
	
		
	self.lblPolice:SizeToContents()
	self.lblPolice:SetPos( self:GetWide() - 75*5 - self.lblPolice:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3  )
	
	self.lblDispatcher:SizeToContents()
	self.lblDispatcher:SetPos( self:GetWide() - 75*6 - self.lblDispatcher:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3  )
	
	self.lblSecretService:SizeToContents()
	self.lblSecretService:SetPos( self:GetWide() - 75*7.5 - self.lblDispatcher:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3  )
	
	self.lblRoadCrew:SizeToContents()
	self.lblRoadCrew:SetPos( self:GetWide() - 75*9 - self.lblRoadCrew:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3  )
		
	self.lblBusDriver:SizeToContents()
	self.lblBusDriver:SetPos( self:GetWide() - 75*11 - self.lblBusDriver:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3  )
	
	self.lblFiremen:SizeToContents()
	self.lblFiremen:SetPos( self:GetWide() - 75*2 - self.lblFiremen:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3  )
	
	self.lblMedics:SizeToContents()
	self.lblMedics:SetPos( self:GetWide() - 75*3 - self.lblMedics:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3  )
	
	self.lblSWAT:SizeToContents()
	self.lblSWAT:SetPos( self:GetWide() - 75*4 - self.lblSWAT:GetWide()/2, self.PlayerFrame.y - self.lblPing:GetTall() - 3  )
	
	//self.lblKills:SetFont( "DefaultSmall" )
	//self.lblDeaths:SetFont( "DefaultSmall" )

end

/*---------------------------------------------------------
   Name: ApplySchemeSettings
---------------------------------------------------------*/
function PANEL:ApplySchemeSettings()

	self.Hostname:SetFont( "ScoreboardHeader" )
	self.Description:SetFont( "ScoreboardSubtitle" )
	
	self.Hostname:SetFGColor( Color( 0, 0, 0, 200 ) )
	self.Description:SetFGColor( color_white )
	
	self.lblPing:SetFont( "DefaultSmall" )
	self.lblPolice:SetFont( "DefaultSmall" )
	self.lblFiremen:SetFont( "DefaultSmall" )
	self.lblMedics:SetFont( "DefaultSmall" )
	self.lblSWAT:SetFont( "DefaultSmall" )
	self.lblDispatcher:SetFont( "DefaultSmall" )
	self.lblSecretService:SetFont( "DefaultSmall" )
	self.lblRoadCrew:SetFont( "DefaultSmall" )
	self.lblBusDriver:SetFont( "DefaultSmall" )
	
	self.lblPing:SetFGColor( Color( 0, 0, 0, 200 ) )
	self.lblPolice:SetFGColor( Color( 0, 0, 0, 200 ) )
	self.lblFiremen:SetFGColor( Color( 0, 0, 0, 200 ) )
	self.lblMedics:SetFGColor( Color( 0, 0, 0, 200 ) )
	self.lblSWAT:SetFGColor( Color( 0, 0, 0, 200 ) )
	self.lblDispatcher:SetFGColor( Color( 0, 0, 0, 200 ) )
	self.lblSecretService:SetFGColor( Color( 0, 0, 0, 200 ) )
	self.lblRoadCrew:SetFGColor( Color( 0, 0, 0, 200 ) )
	self.lblBusDriver:SetFGColor( Color( 0, 0, 0, 200 ) )

end


function PANEL:UpdateScoreboard( force )

	if ( !force && !self:IsVisible() ) then return end

	for k, v in pairs( self.PlayerRows ) do
	
		if ( !k:IsValid() ) then
		
			v:Remove()
			self.PlayerRows[ k ] = nil
			
		end
		
		if ( k:GetUMsgInt("Disguise", 0) == 1 && !Disguised[k]) then
			v:Remove()
			self.PlayerRows[ k ] = nil
		end
		
		if (k:GetUMsgInt("Disguise", 0) == 0 && Disguised[k]) then
			v:Remove()
			self.PlayerRows[k] = nil
			Disguised[k] = nil
		end
	
	end
	
	local PlayerList = player.GetAll()	
	for id, pl in pairs( PlayerList ) do
		
		if ( !self:GetPlayerRow( pl ) ) then
		
			self:AddPlayerRow( pl )
			
			if (pl:GetUMsgInt("Disguise", 0) == 1) then
				Disguised[pl] = true
			end
		
		end
		
	end
	
	// Always invalidate the layout so the order gets updated
	self:InvalidateLayout()

end

vgui.Register( "ScoreBoard", PANEL, "Panel" )