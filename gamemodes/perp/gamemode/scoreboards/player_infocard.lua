

 
include( "admin_buttons.lua" )

local PANEL = {}

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:Init()

	self.InfoLabels = {}
	self.InfoLabels[ 1 ] = {}
	self.InfoLabels[ 2 ] = {}
	
	self.btnBan = vgui.Create( "PlayerBanButton", self )
	self.btnPBan = vgui.Create( "PlayerPermBanButton", self )
	self.btnSpectate = vgui.Create( "PlayerSpectateButton", self )
	self.btnBlacklist = vgui.Create( "PlayerBlacklistButton", self )
	self.btnRename = vgui.Create( "PlayerForceRenameButton", self )
	self.btnSlay = vgui.Create( "PlayerSlayButton", self )
	
	self.btnBlacklistFromSerious 	= vgui.Create( "PlayerBlacklistFromSeriousButton", self )
	
	self.scrollerTime = vgui.Create( "DNumSlider", self )
	self.scrollerTime:SetDecimals(0);
	self.scrollerTime:SetValue(24);
	self.scrollerTime:SetMin(0);
	self.scrollerTime:SetMax(720);
	self.scrollerTime:SetText("Punishment Time ( Hours )");
end

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:SetInfo( column, k, v )

	if ( !v || v == "" ) then v = "N/A" end

	if ( !self.InfoLabels[ column ][ k ] ) then
	
		self.InfoLabels[ column ][ k ] = {}
		self.InfoLabels[ column ][ k ].Key 	= vgui.Create( "Label", self )
		self.InfoLabels[ column ][ k ].Value 	= vgui.Create( "Label", self )
		self.InfoLabels[ column ][ k ].Key:SetText( k )
		self:InvalidateLayout()
	
	end
	
	self.InfoLabels[ column ][ k ].Value:SetText( v )
	return true

end


/*---------------------------------------------------------
   Name: UpdatePlayerData
---------------------------------------------------------*/
function PANEL:SetPlayer( ply )

	self.Player = ply
	self:UpdatePlayerData()

end

/*---------------------------------------------------------
   Name: UpdatePlayerData
---------------------------------------------------------*/
local titles = {};

titles[0] = "Owner";
titles[1] = "Super Admin";
titles[2] = "Admin";
titles[3] = "Mod";
titles[4] = "Administrator";
titles[10] = "Trial Administrator";
titles[97] = "Diamond VIP";
titles[98] = "Gold VIP";
titles[99] = "Silver VIP";
titles[100] = "Bronze VIP";
titles[200] = "Guest";
titles[255] = "Banned";


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

function PANEL:UpdatePlayerData()

	if (!self.Player) then return end
	if ( !self.Player:IsValid() ) then return end
	
	self:SetInfo( 1, "SteamID:", self.Player:SteamID())
	self:SetInfo( 1, "UniqueID:", self.Player:UniqueID() )
	self:SetInfo( 1, "Steam Name:", self.Player:Nick() )
	self:SetInfo( 1, "RP Name:", self.Player:GetRPName() )
	
	if (titles[self.Player:GetAccessLevel()]) then
		self:SetInfo(1, "Position: ", titles[self.Player:GetAccessLevel()]);
		if (self.Player:SteamID() == "STEAM_0:0") then
			self:SetInfo(1, "Position: ", "Programmer");
		end;
	else
		self:SetInfo(1, "Position: ", "Unknown Access");
	end
	
	if (self.Player:Team() && IDsToClass[self.Player:Team()]) then
		self:SetInfo(1, "Class: ", IDsToClass[self.Player:Team()]);
	else
		self:SetInfo(1, "Class: ", "Unknown Class");
	end
	
	self:InvalidateLayout()

end

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:ApplySchemeSettings()

	for _k, column in pairs( self.InfoLabels ) do

		for k, v in pairs( column ) do
		
			v.Key:SetFGColor( 0, 0, 0, 100 )
			v.Value:SetFGColor( 0, 70, 0, 200 )
		
		end
	
	end

end

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:Think()

	if ( self.PlayerUpdate && self.PlayerUpdate > CurTime() ) then return end
	self.PlayerUpdate = CurTime() + 0.25
	
	self:UpdatePlayerData()
	
	self.scrollerTime:SetText("Punishment Time ( Hours; 0 = Perm ) - " .. (self.scrollerTime:GetValue() / 24) .. " Days");

end

/*---------------------------------------------------------
   Name: PerformLayout
---------------------------------------------------------*/
function PANEL:PerformLayout()	

	local x = 5

	for colnum, column in pairs( self.InfoLabels ) do
	
		local y = 0
		local RightMost = 0
	
		for k, v in pairs( column ) do
	
			v.Key:SetPos( x, y )
			v.Key:SizeToContents()
			
			v.Value:SetPos( x + 70 , y )
			v.Value:SizeToContents()
			
			y = y + v.Key:GetTall() + 2
			
			RightMost = math.max( RightMost, v.Value.x + v.Value:GetWide() )
		
		end
		
		//x = RightMost + 10
		x = x + 300
	
	end
	
	if ( !self.Player || !LocalPlayer():IsAdmin() ) then 
	

		self.btnBan:SetVisible( false )
		self.btnPBan:SetVisible( false )
		self.btnSpectate:SetVisible( false )
		self.btnBlacklist:SetVisible( false )
		self.btnBlacklistFromSerious:SetVisible( false )
		self.btnRename:SetVisible( false )
	
	else
	

		self.btnBan:SetVisible( true )
		self.btnSpectate:SetVisible( true )
		self.btnBlacklist:SetVisible( true )
		self.btnBlacklistFromSerious:SetVisible( true )
		self.btnRename:SetVisible( true )
	
		local sizeOButton = 60;
	
		self.btnBlacklistFromSerious:SetPos( self:GetWide() - (sizeOButton + 4) * 5, 80 )
		self.btnBlacklistFromSerious:SetSize( sizeOButton, 20 )
		
		self.btnRename:SetPos( self:GetWide() - (sizeOButton + 4) * 6, 80 )
		self.btnRename:SetSize( sizeOButton, 20 )
		
		self.btnBlacklist:SetPos( self:GetWide() - (sizeOButton + 4) * 4, 80 )
		self.btnBlacklist:SetSize( sizeOButton, 20 )
	
		self.btnSpectate:SetPos( self:GetWide() - (sizeOButton + 4) * 3, 80 )
		self.btnSpectate:SetSize( sizeOButton, 20 )
	
		self.btnBan:SetPos( self:GetWide() - (sizeOButton + 4) * 2, 80 )
		self.btnBan:SetSize( sizeOButton, 20 )
		
		self.btnSlay:SetPos( self:GetWide() - (sizeOButton + 4) * 7, 80 )
		self.btnSlay:SetSize( sizeOButton, 20 )
		
		if (LocalPlayer():IsSuperAdmin()) then
			self.btnPBan:SetPos( self:GetWide() - (sizeOButton + 4) * 8, 80 )
			self.btnPBan:SetSize( sizeOButton, 20 )
			self.btnPBan:SetVisible( true )
		else
			self.btnPBan:SetVisible( false )
		end
	
	end
	
	self.scrollerTime:SetPos(self:GetWide() - 305, 5);
	self.scrollerTime:SetSize(300, 30);
end

function PANEL:Paint()
	return true
end


vgui.Register( "ScorePlayerInfoCard", PANEL, "Panel" )