

 

local PANEL = {}

/*---------------------------------------------------------
   Name: 
---------------------------------------------------------*/
function PANEL:Init()

	self:SetCursor( "hand" )

end

/*---------------------------------------------------------
   Name: 
---------------------------------------------------------*/
function PANEL:DoClick( x, y )

	if ( !self:GetParent().Player ) then return end

	self:DoCommand( self:GetParent().Player )
	timer.Simple( 0.1, function() SCOREBOARD.UpdateScoreboard(SCOREBOARD ) end )

end

/*---------------------------------------------------------
   Name: Paint
---------------------------------------------------------*/
function PANEL:Paint()
	
	local bgColor = Color( 0,0,0,10 )

	if ( self.Selected ) then
		bgColor = Color( 0, 200, 255, 255 )
	elseif ( self.Armed ) then
		bgColor = Color( 255, 255, 0, 255 )
	end
	
	draw.RoundedBox( 4, 0, 0, self:GetWide(), self:GetTall(), bgColor )
	
	draw.SimpleText( self.Text, "DefaultSmall", self:GetWide() / 2, self:GetTall() / 2, Color(0,0,0,150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
	
	return true

end


vgui.Register( "SpawnMenuAdminButton", PANEL, "Button" )




PANEL = {}
PANEL.Text = "Slay"

/*---------------------------------------------------------
   Name: DoCommand
---------------------------------------------------------*/
function PANEL:DoCommand( ply )

	RunConsoleCommand("perp_a_sl", ply:UniqueID(), t);
	
end

vgui.Register( "PlayerSlayButton", PANEL, "SpawnMenuAdminButton" )



/*   PlayerPermBanButton */

PANEL = {}
PANEL.Text = "Perma Ban"

/*---------------------------------------------------------
   Name: DoCommand
---------------------------------------------------------*/
function PANEL:DoCommand( ply )

	ShowGetBanTime("Perma Banning " .. ply:Nick(), "Ban Reason", "Ban Player", function ( t )
		if (ply && IsValid(ply) && ply:IsPlayer()) then
			RunConsoleCommand("perp_a_b", "0", ply:UniqueID(), t);
		end
	end);
	
end

vgui.Register( "PlayerPermBanButton", PANEL, "SpawnMenuAdminButton" )



/*   PlayerPermBanButton */

PANEL = {}
PANEL.Text = "Ban"

/*---------------------------------------------------------
   Name: DoCommand
---------------------------------------------------------*/
function PANEL:DoCommand( ply )

	ShowGetBanTime("Banning " .. ply:Nick(), "Ban Reason", "Ban Player", function ( t )
		if (ply && IsValid(ply) && ply:IsPlayer()) then
			RunConsoleCommand("perp_a_b", self:GetParent().scrollerTime:GetValue(), ply:UniqueID(), t);
		end
	end);
	
end

vgui.Register( "PlayerBanButton", PANEL, "SpawnMenuAdminButton" )

/*   Spectate */

PANEL = {}
PANEL.Text = "Spectate"

/*---------------------------------------------------------
   Name: DoCommand
---------------------------------------------------------*/
function PANEL:DoCommand( ply )

	RunConsoleCommand( "perp_a_s", ply:UniqueID() )
	PERP_SpectatingEntity = ply;
	ply:Notify("Press space to exit spectator mode.");
	
end

vgui.Register( "PlayerSpectateButton", PANEL, "SpawnMenuAdminButton" )

/*   Blacklist */

PANEL = {}
PANEL.Text = "Blacklist"

/*---------------------------------------------------------
   Name: DoCommand
---------------------------------------------------------*/
function PANEL:DoCommand( ply )

	if (ply:Team() == TEAM_CITIZEN) then
		LocalPlayer():Notify("You cannot blacklist a player from citizen.");
		return
	end
	
	RunConsoleCommand("perp_a_bl", self:GetParent().scrollerTime:GetValue(), ply:UniqueID());
	
end

vgui.Register( "PlayerBlacklistButton", PANEL, "SpawnMenuAdminButton" )

/*   Blacklist From Serious */

PANEL = {}
PANEL.Text = "SRS Blacklist"

/*---------------------------------------------------------
   Name: DoCommand
---------------------------------------------------------*/
function PANEL:DoCommand( ply )

	RunConsoleCommand("perp_a_bs", self:GetParent().scrollerTime:GetValue(), ply:UniqueID());
	
end

vgui.Register( "PlayerBlacklistFromSeriousButton", PANEL, "SpawnMenuAdminButton" )


/*   Blacklist From Serious */

PANEL = {}
PANEL.Text = "Force Rename"
/*---------------------------------------------------------
   Name: DoCommand
---------------------------------------------------------*/
function PANEL:DoCommand( ply )

	RunConsoleCommand("perp_a_fr", ply:UniqueID());
	
end

vgui.Register( "PlayerForceRenameButton", PANEL, "SpawnMenuAdminButton" )

