function PCallError( ... )
	
	local arg = {...}
	
	local errored, retval = pcall( unpack( arg ) )
 
	if ( !errored ) then
		ErrorNoHalt( retval )
		return false, retval
	end
 
	return true, retval
 
end

ASS_LVL_SERVER_OWNER	= 0
ASS_LVL_SUPER_ADMIN		= 1
ASS_LVL_ADMIN			= 2
ASS_LVL_MOD				= 3
ASS_LVL_TEMPADMIN		= 10
ASS_LVL_PREMIUM			= 96
ASS_LVL_DIAMOND			= 97
ASS_LVL_GOLD			= 98
ASS_LVL_SILVER			= 99
ASS_LVL_BRONZE			= 100
ASS_LVL_GUEST			= 200
ASS_LVL_BANNED			= 255

ASS_VERSION = "Underscore Gaming"

LevelIcon		= {}
-- LevelIcon[0] = "icon16/lightning.png"
LevelIcon[0]	= "icon16/user_suit.png"
-- LevelIcon[1] = "icon16/star.png"
LevelIcon[1] 	= "icon16/user_gray.png"
LevelIcon[2]	= "icon16/shield.png"
LevelIcon[3]	= "icon16/asterisk_yellow.png"
LevelIcon[4]	= "icon16/award_star_gold_3.png"
LevelIcon[5]	= "icon16/user.png"
LevelIcon[255]	= "icon16/user_delete.png"



function ASS_Init_Shared()

	local PLAYER = FindMetaTable("Player")
	function PLAYER:IsOwner()	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) <= ASS_LVL_SERVER_OWNER	end
	function PLAYER:IsSuperAdmin()	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) <= ASS_LVL_SUPER_ADMIN	end
	function PLAYER:IsAdmin()	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) <= ASS_LVL_ADMIN		end
	function PLAYER:IsTempAdmin()	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) <= ASS_LVL_TEMPADMIN	end
	function PLAYER:IsPremium()	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) <= ASS_LVL_PREMIUM	end
	function PLAYER:IsDiamond()	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) <= ASS_LVL_DIAMOND	end
	function PLAYER:IsGold()	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) <= ASS_LVL_GOLD	end
	function PLAYER:IsSilver()	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) <= ASS_LVL_SILVER	end
	function PLAYER:IsBronze()	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) <= ASS_LVL_BRONZE	end

	function PLAYER:IsGuest()	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) >= ASS_LVL_GUEST && self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) < ASS_LVL_BANNED end
	function PLAYER:IsUnwanted()	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) >= ASS_LVL_BANNED end

	function PLAYER:GetLevel()		return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST)						end
	function PLAYER:HasLevel(n)		return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) <= n						end
	function PLAYER:IsBetterOrSame(PL2)	return self:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST) <= PL2:GetNetworkedInt("ASS_isAdmin", ASS_LVL_GUEST)	end
	function PLAYER:GetTAExpiry(n)		return self:GetNetworkedFloat("ASS_tempAdminExpiry")	end
	function PLAYER:AssId()	return self:SteamID()	end


-- --delete me
-- 	function PLAYER:Notify ( Text, truefalse )
-- 	if !self or !self:IsValid() then return false; end
		
-- 		if SERVER then
			
-- 		else
-- 			AddNotify(Text, NOTIFY_UNDO, 15, truefalse);
-- 		end
-- 	end

	PLAYER = nil



end

-- function AddNotify( str, type, length, hideSound )

-- 	Msg(str .. '\n');
	
-- end

function IncludeSharedFile( S )
	
	if (SERVER) then
		AddCSLuaFile(S)
	end
	
	include(S)

end

function LevelToString( LEVEL, TIME )

	if (LEVEL <= ASS_LVL_SERVER_OWNER) then								return "Owner";
	elseif (LEVEL <= ASS_LVL_SUPER_ADMIN) then							return "Super Admin";
	elseif (LEVEL <= ASS_LVL_ADMIN) then								return "Admin";
	elseif (LEVEL <= ASS_LVL_TEMPADMIN) then							if (TIME) then return "Admin for " .. TIME else return "Temp Admin" end
	elseif (LEVEL <= ASS_LVL_PREMIUM) then								return "Premium VIP";
	elseif (LEVEL <= ASS_LVL_DIAMOND) then								return "Diamond VIP";
	elseif (LEVEL <= ASS_LVL_GOLD) then									return "Gold VIP";
	elseif (LEVEL <= ALL_LVL_SILVER) then								return "Silver VIP";
	elseif (LEVEL <= ASS_LVL_BRONZE)then								return "Bronze VIP";
	elseif (LEVEL >= ASS_LVL_GUEST && LEVEL < ASS_LVL_BANNED) then		return "Guest"
	else
		//mofo must be banned
		return "Banned";	
	end
end

function ASS_FormatText( TEXT )

	if (CLIENT) then
		TEXT = string.Replace(TEXT, "%assmod%", ASS_VERSION )

		TEXT = string.Replace(TEXT, "%cl_time%", os.date("%H:%M:%S") )
		TEXT = string.Replace(TEXT, "%cl_date%",  os.date("%d/%b/%Y") )
		TEXT = string.Replace(TEXT, "%cl_timedate%", os.date("%H:%M:%S") .. " " ..  os.date("%d/%b/%Y") )

		TEXT = string.Replace(TEXT, "%sv_time%", GetGlobalString("ServerTime") )
		TEXT = string.Replace(TEXT, "%sv_date%", GetGlobalString("ServerDate") )
		TEXT = string.Replace(TEXT, "%sv_timedate%", GetGlobalString("ServerTime") .. " " .. GetGlobalString("ServerDate") )

		TEXT = string.Replace(TEXT, "%hostname%", GetGlobalString( "ServerName" ) )
		TEXT = string.gsub(TEXT, "%%%&([%w_]+)%%", GetConVarString)
	end
	if (SERVER) then
	
		TEXT = string.Replace(TEXT, "%map%", game.GetMap() )
		TEXT = string.Replace(TEXT, "%gamemode%", gmod.GetGamemode().Name )

		TEXT = string.gsub(TEXT, "%%@([%w_]+)%%", GetConVarString)
	
	end
	
	TEXT = ASS_RunPluginFunction("FormatText", TEXT, TEXT)


	return TEXT
	
end

IncludeSharedFile("ass_plugins.lua")
IncludeSharedFile("ass_debug.lua")
IncludeSharedFile("ass_config.lua")
