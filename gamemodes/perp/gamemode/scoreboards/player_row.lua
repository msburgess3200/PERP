


include("player_infocard.lua"); 


surface.CreateFont("ScoreboardPlayerName", {
	font="coolvetica",
	size=19,
	weight=500,
	antialias=true
})
surface.CreateFont("ScoreboardPlayerNameBig", {
	font="coolvetica",
	size=22,
	weight=500,
	antialias=true
})


local texGradient = surface.GetTextureID( "gui/center_gradient" )

local texRatings = {}
texRatings[ 'none' ] 		= surface.GetTextureID( "gui/silkicons/user" )
texRatings[ 'smile' ] 		= surface.GetTextureID( "gui/silkicons/emoticon_smile" )
texRatings[ 'bad' ] 		= surface.GetTextureID( "gui/silkicons/exclamation" )
texRatings[ 'love' ] 		= surface.GetTextureID( "gui/silkicons/heart" )
texRatings[ 'artistic' ] 	= surface.GetTextureID( "gui/silkicons/palette" )
texRatings[ 'star' ] 		= surface.GetTextureID( "gui/silkicons/star" )
texRatings[ 'builder' ] 	= surface.GetTextureID( "gui/silkicons/wrench" )

surface.GetTextureID( "gui/silkicons/emoticon_smile" )
local PANEL = {}

/*---------------------------------------------------------
   Name: Init
---------------------------------------------------------*/
function PANEL:Init()

	self.Size = 36
	self:OpenInfo( false )
	
	self.infoCard	= vgui.Create( "ScorePlayerInfoCard", self )
		
	self.lblName 	= vgui.Create( "DLabel", self )
	self.lblPing 	= vgui.Create( "DLabel", self )
	
	// If you don't do this it'll block your clicks
	self.lblName:SetMouseInputEnabled( false )
	self.lblPing:SetMouseInputEnabled( false )
	
	self.imgAvatar = vgui.Create( "AvatarImage", self )
	
	self:SetCursor( "hand" )

end

/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:Paint()

	local color = Color( 105, 105, 105, 255)

	if ( !ValidEntity( self.Player ) ) then return end
		
	if ( self.Player:IsOwner()  && (self.Player:GetUMsgInt("Disguise", 0) == 0) ) then
		color = Color( 0, 0, 0, 255);
		self.lblName:SetFGColor(Color(255, 255, 255,  55 + 200 * math.abs(math.sin(CurTime() * 2))));
	elseif ( self.Player:IsSuperAdmin()  && (self.Player:GetUMsgInt("Disguise", 0) == 0)   ) then
		color = Color( 0, 0, 0, 255);
		self.lblName:SetFGColor(Color(128, 0, 128, 55 + 200 * math.abs(math.sin(CurTime() * 2))));
	elseif ( self.Player:IsAdmin()   && (self.Player:GetUMsgInt("Disguise", 0) == 0)  ) then
		color = Color( 0, 0, 0, 255);
		self.lblName:SetFGColor(Color(0, 0, 255, 55 + 200 * math.abs(math.sin(CurTime() * 2))));
	end
	
	if (self.Player:GetLevel() == 100) then
		self.lblName:SetFGColor( Color( 205, 133, 63, 255 ) )
	elseif (self.Player:GetLevel() == 99) then
		self.lblName:SetFGColor( Color( 183, 183, 183, 255) )
	elseif (self.Player:GetLevel() == 98) then
		self.lblName:SetFGColor( Color( 215, 215, 0, 255) )
	elseif (self.Player:GetLevel() == 97) then
		self.lblName:SetFGColor( Color( 135, 206, 250, 255 ) )
	end
	
	if ( self.Open || self.Size != self.TargetSize ) then
	
		draw.RoundedBox( 4, 0, 16, self:GetWide(), self:GetTall() - 16, color )
		draw.RoundedBox( 4, 2, 16, self:GetWide()-4, self:GetTall() - 16 - 2, Color( 250, 250, 245, 255 ) )
		
		surface.SetTexture( texGradient )
		surface.SetDrawColor( 255, 255, 255, 255 )
		surface.DrawTexturedRect( 2, 16, self:GetWide()-4, self:GetTall() - 16 - 2 ) 
	
	end
	
	draw.RoundedBox( 4, 0, 0, self:GetWide(), 36, color )
	
	surface.SetTexture( texGradient )
	if ( self.Player == LocalPlayer() ) then
		surface.SetDrawColor( 255, 255, 255, 150 + math.sin(RealTime() * 2) * 50 )
	else
		surface.SetDrawColor( 255, 255, 255, 70 )
	end
	
	if ( self.Player:IsOwner()  && self.Player:GetUMsgInt("Disguise", 0) != 1  ) then
		surface.SetDrawColor( 150 + math.sin(RealTime() * 2) * 50, 0, 0, 255 )
	elseif ( self.Player:IsSuperAdmin()   && self.Player:GetUMsgInt("Disguise", 0) != 1 ) then
		surface.SetDrawColor(62, 86, 255, 150 + math.sin(RealTime() * 2) * 50 )
	elseif ( self.Player:IsAdmin()   && self.Player:GetUMsgInt("Disguise", 0) != 1 ) then
		surface.SetDrawColor( 62, 255, 183, 150 + math.sin(RealTime() * 2) * 50 )
	elseif ( self.Player:GetUMsgInt("Disguise", 0) == 1) then
		surface.SetDrawColor( 255, 255, 255, 70 )
	end;
	surface.DrawTexturedRect( 0, 0, self:GetWide(), 36 )

	return true

end

/*---------------------------------------------------------
   Name: UpdatePlayerData
---------------------------------------------------------*/
function PANEL:SetPlayer( ply )

	self.Player = ply
	
	self.infoCard:SetPlayer( ply )
	self.imgAvatar:SetPlayer( ply )
	
	self:UpdatePlayerData()

end

function PANEL:CheckRating( name, count )

	if ( self.Player:GetNetworkedInt( "Rating."..name, 0 ) > count ) then
		count = self.Player:GetNetworkedInt( "Rating."..name, 0 )
		self.texRating = texRatings[ name ]
	end
	
	return count

end


local IDsToClass = {};
IDsToClass[TEAM_CITIZEN] = "Citizen";
IDsToClass[TEAM_POLICE] = "Police Officer";
IDsToClass[TEAM_SECRET_SERVICE] = "SS Agent";
IDsToClass[TEAM_SWAT] = "SWAT Officer";
IDsToClass[TEAM_MAYOR] = "Mayor";
IDsToClass[TEAM_FIREMAN] = "Fireman";
IDsToClass[TEAM_MEDIC] = "Medic";
IDsToClass[TEAM_DISPATCHER] = "Dispatch";
IDsToClass[TEAM_ROADCREW] = "Road Crew";
IDsToClass[TEAM_BUSDRIVER] = "Bus Driver";


/*---------------------------------------------------------
   Name: UpdatePlayerData
---------------------------------------------------------*/
function PANEL:UpdatePlayerData()

	if ( !self.Player ) then return end
	if ( !self.Player:IsValid() ) then return end

	if LocalPlayer():IsAdmin() then
		self.lblName:SetText( self.Player:Nick() .. " [ " .. self.Player:GetRPName() .. " ]" .. " [ " .. IDsToClass[self.Player:Team()] .. " ] ")
	else
		self.lblName:SetText( self.Player:Nick() )
	end
	
	self.lblPing:SetText( self.Player:Ping() )
end



/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:ApplySchemeSettings()

	self.lblName:SetFont( "ScoreboardPlayerNameBig" )
	self.lblPing:SetFont( "ScoreboardPlayerName" )
	
	self.lblName:SetFGColor( color_white )
	self.lblPing:SetFGColor( color_white )
	
	if (self.Player:GetLevel() == 100) then
		self.lblName:SetFGColor( Color( 205, 133, 63, 255 ) )
	elseif (self.Player:GetLevel() == 99) then
		self.lblName:SetFGColor( Color( 183, 183, 183, 255) )
	elseif (self.Player:GetLevel() == 98) then
		self.lblName:SetFGColor( Color( 215, 215, 0, 255) )
	elseif (self.Player:GetLevel() == 97) then
		self.lblName:SetFGColor( Color( 135, 206, 250, 255 ) )
	end
end

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:DoClick( x, y )
	if (!LocalPlayer():IsAdmin()) then return; end

	if ( self.Open ) then
		surface.PlaySound( "ui/buttonclickrelease.wav" )
	else
		surface.PlaySound( "ui/buttonclick.wav" )
	end

	self:OpenInfo( !self.Open )
end

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:OpenInfo( bool )

	if ( bool ) then
		self.TargetSize = 150
	else
		self.TargetSize = 36
	end
	
	self.Open = bool

end

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:Think()

	if ( self.Size != self.TargetSize ) then
	
		self.Size = math.Approach( self.Size, self.TargetSize, (math.abs( self.Size - self.TargetSize ) + 1) * 10 * FrameTime() )
		self:PerformLayout()
		SCOREBOARD:InvalidateLayout()
	//	self:GetParent():InvalidateLayout()
	
	end
	
	if ( !self.PlayerUpdate || self.PlayerUpdate < CurTime() ) then
	
		self.PlayerUpdate = CurTime() + 0.5
		self:UpdatePlayerData()
		
	end

end

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:PerformLayout()

	self.imgAvatar:SetPos( 2, 2 )
	self.imgAvatar:SetSize( 32, 32 )

	self:SetSize( self:GetWide(), self.Size )
	
	self.lblName:SizeToContents()
	self.lblName:SetPos( 24, 2 )
	self.lblName:MoveRightOf( self.imgAvatar, 8 )
	
	local COLUMN_SIZE = 50
	
	self.lblPing:SetPos( self:GetWide() - COLUMN_SIZE * 1, 0 )
	
	if ( self.Open || self.Size != self.TargetSize ) then
	
		self.infoCard:SetVisible( true )
		self.infoCard:SetPos( 4, self.imgAvatar:GetTall() + 10 )
		self.infoCard:SetSize( self:GetWide() - 8, self:GetTall() - self.lblName:GetTall() - 10 )
	
	else
	
		self.infoCard:SetVisible( false )
	
	end	

end

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:HigherOrLower( row )

	if ( !self.Player:IsValid() || self.Player:Team() == TEAM_CONNECTING ) then return false end
	if ( !row.Player:IsValid() || row.Player:Team() == TEAM_CONNECTING ) then return true end

	if self.Player:GetUMsgInt("Disguise", 0) == 1 then
		return 100 < row.Player:GetAccessLevel()
	
	elseif row.Player:GetUMsgInt("Disguise", 0) == 1 then
		return self.Player:GetAccessLevel() < 100
	end
	return self.Player:GetAccessLevel() < row.Player:GetAccessLevel()

end


vgui.Register( "ScorePlayerRow", PANEL, "Button" )