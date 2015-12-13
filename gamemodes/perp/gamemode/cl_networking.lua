

function GM.GetExpectedInfo ( UMsg )
	GAMEMODE.ExpectedUMsg_Start = UMsg:ReadShort();
	GAMEMODE.ExpectedUMsg = GAMEMODE.ExpectedUMsg_Start
	Msg("Expecting " .. GAMEMODE.ExpectedUMsg_Start .. " load vars.\n");
end
usermessage.Hook("perp_expect", GM.GetExpectedInfo);

function GM.GetUMsgString ( UMsg )
	local Entity = UMsg:ReadEntity();
	local ID = UMsg:ReadString();
	local Type = UMsg:ReadShort();
	
	if (!Entity || !IsValid(Entity)) then Msg("Failed to receive a UMsg string.\n"); return; end
	
	Entity.StringRedun = Entity.StringRedun or {};
	
	local Table = {entity = Entity};
	if (Type == 1) then
		Table.value = UMsg:ReadString();
	elseif (Type == 2) then
		Table.value = UMsg:ReadFloat();
	elseif (Type == 3) then
		if (ID == "cash" || ID == "bank" || ID == "fuel") then
			Table.value = UMsg:ReadLong();
		else
			Table.value = UMsg:ReadShort();
		end
	elseif (Type == 4) then
		Table.value = UMsg:ReadBool();
	else
		Entity.StringRedun[ID] = nil;
		return
	end
	
	local loadVar = UMsg:ReadBool();
	
	if (!Entity.StringRedun) then Entity.StringRedun = {}; end
	
	if (loadVar) then
		if (Entity.StringRedun[ID]) then return; end
	end
	
	if (GAMEMODE.ExpectedUMsg) then
		GAMEMODE.ExpectedUMsg = GAMEMODE.ExpectedUMsg - 1;
	end
	
	Entity.StringRedun[ID] = Table;
end
usermessage.Hook("perp_ums", GM.GetUMsgString);

local function fakeUMS ( )
	if (GAMEMODE.ExpectedUMsg) then
		GAMEMODE.ExpectedUMsg = GAMEMODE.ExpectedUMsg - 1;
	end
end
usermessage.Hook("perp_umsg_f", fakeUMS);

function GM.GetPrivateString ( UMsg )
	local Entity = LocalPlayer();
	local ID = UMsg:ReadString();
	local Type = UMsg:ReadShort();
	
	Entity.StringRedunP = Entity.StringRedunP or {};
	
	local Table = {entity = Entity};
	if (Type == 1) then
		Table.value = UMsg:ReadString();
	elseif (Type == 2) then
		Table.value = UMsg:ReadFloat();
	elseif (Type == 3) then
		if (ID == "cash" || ID == "bank") then
			Table.value = UMsg:ReadLong();
		else
			Table.value = UMsg:ReadShort();
		end
	elseif (Type == 4) then
		Table.value = UMsg:ReadBool();
	else
		Entity.StringRedunP[ID] = nil;
		return
	end
	
	Entity.StringRedunP[ID] = Table;
end
usermessage.Hook("perp_ps", GM.GetPrivateString);

function GM.GetStartupVals ( UMsg )
	local TimePlayed 		= UMsg:ReadString();
	local Cash 				= UMsg:ReadLong();
	local BankCash 			= UMsg:ReadLong();
	local FuelLeft			= UMsg:ReadShort();
	GAMEMODE.CurrentTime 	= UMsg:ReadShort();
	GAMEMODE.CurrentDay 	= UMsg:ReadShort();
	GAMEMODE.CurrentMonth 	= UMsg:ReadShort();
	GAMEMODE.CurrentYear 	= UMsg:ReadShort();
	
	GAMEMODE.LoadTime = CurTime();
		
	LocalPlayer():SetPrivateInt("time_played", tonumber(TimePlayed));
	LocalPlayer():SetPrivateInt("cash", Cash);
	LocalPlayer():SetPrivateInt("bank", BankCash);
	LocalPlayer():SetPrivateInt("fuelleft", FuelLeft);
	
	GAMEMODE.CurrentLoadStatus = 3;
end
usermessage.Hook("perp_startup", GM.GetStartupVals);

function GM.GetAccountInfo(UMsg)
	local AccUName = UMsg:ReadString();
	local GroupID  = UMsg:ReadString();
	local EmailAd  = UMsg:ReadString();
	
	LocalPlayer():SetPrivateString("accountname", AccUName);
	LocalPlayer():SetPrivateString("idgroup", GroupID);
	LocalPlayer():SetPrivateString("email", EmailAd);
end
usermessage.Hook("perp_accountinfo", GM.GetAccountInfo)

/*
function GM.LastFuckingCar (UMsg)
	local LastCar = UMsg:ReadString();	
	
	timer.Simple(10, function() LocalPlayer():Notify(LastCar); end)
end
usermessage.Hook("perp_lastcar", GM.LastFuckingCar)
*/

function GM.SetUmsgFuel ( UMsg )
	local FuelLeft			= UMsg:ReadShort();
	
	LocalPlayer():SetPrivateInt("fuelleft", FuelLeft);
end
usermessage.Hook("send_fuel", GM.SetUmsgFuel);


function GM.OpenInventory ( )
	local newMode = !GAMEMODE.InventoryPanel:IsVisible();
	
	if (GAMEMODE.ShopPanel) then
		GAMEMODE.ShopPanel:Remove();
		GAMEMODE.ShopPanel = nil;
		gui.EnableScreenClicker(false);
		
		return;
	end
	
	if (GAMEMODE.BankIPanel) then
		GAMEMODE.BankIPanel:Remove();
		GAMEMODE.BankIPanel = nil;
		gui.EnableScreenClicker(false);
		
		return;
	end
	
	GAMEMODE.InventoryPanel:SetVisible(newMode);
	gui.EnableScreenClicker(newMode)
end
usermessage.Hook("perp_inventory", GM.OpenInventory);

function GM.OpenBuddies ( )
	if (GAMEMODE.InventoryPanel:IsVisible() || GAMEMODE.ShopPanel) then return; end

	GAMEMODE.BuddyPanel = vgui.Create("perp2_buddies");
end
usermessage.Hook("perp_buddies", GM.OpenBuddies);

function GM.OpenHelp ( )
	if (GAMEMODE.InventoryPanel:IsVisible() || GAMEMODE.ShopPanel) then return; end

	GAMEMODE.HelpPanel = vgui.Create("perp2_help");
end
usermessage.Hook("perp_help", GM.OpenHelp);

function GM.OpenOrg ( )
	if (GAMEMODE.InventoryPanel:IsVisible() || GAMEMODE.ShopPanel) then return; end

	if (LocalPlayer():Team() == TEAM_MAYOR) then
		GAMEMODE.MayorPanel = vgui.Create("perp2_mayor_tab");
	else
		GAMEMODE.OrgPanel = vgui.Create("perp2_organization");
	end
end
usermessage.Hook("perp_org", GM.OpenOrg);

local function ForceChangeName ( )
	ShowRenamePanel(true);
end
usermessage.Hook("perp_rename", ForceChangeName);

local function ForceChangeFUN ( )
	ShowRenamePanel2(true);
end
usermessage.Hook("perp_fun", ForceChangeFUN);

local function getSRod ( UMsg ) 
	local id = UMsg:ReadShort();
	local str = UMsg:ReadString();
	
	GAMEMODE.OrganizationData[id] = GAMEMODE.OrganizationData[id] or {};
	GAMEMODE.OrganizationData[id][1] = str;
end
usermessage.Hook("perp_srod", getSRod);

local function getRod ( UMsg ) 
	local id = UMsg:ReadShort();
	local str = UMsg:ReadString();
	local motd = UMsg:ReadString();
	local name = UMsg:ReadString();
	local wereLeader = UMsg:ReadBool();
	
	GAMEMODE.OrganizationData[id] = {str, motd, name, wereLeader};
end
usermessage.Hook("perp_rod", getRod);

local function getRodM ( UMsg ) 
	local id = UMsg:ReadShort();
	local name = UMsg:ReadString();
	local uid = UMsg:ReadString();
	
	GAMEMODE.OrganizationMembers[id] = GAMEMODE.OrganizationMembers[id] or {};
	
	table.insert(GAMEMODE.OrganizationMembers[id], {name, uid});
end
usermessage.Hook("perp_rod_m", getRodM);

local function getRodC ( UMsg ) 
	local id = UMsg:ReadShort();
	local uid = UMsg:ReadString();

	if (!GAMEMODE.OrganizationMembers[id]) then return; end
	
	for k, v in pairs(GAMEMODE.OrganizationMembers[id]) do
		if (v[2] == uid) then
			GAMEMODE.OrganizationMembers[id][k] = nil;
			break;
		end
	end
end
usermessage.Hook("perp_rod_c", getRodC);

local function getInvite ( UMsg ) 
	local name = UMsg:ReadString();
	
	if (GAMEMODE.InvitePanel) then
		GAMEMODE.InvitePanel:Remove();
	end
	
	GAMEMODE.InvitePanel = vgui.Create("perp2_invite");
	GAMEMODE.InvitePanel:SetOrg(name);
end
usermessage.Hook("perp_invite", getInvite);

local function stripMain ( )
	for i = 1, 2 do
		if (GAMEMODE.PlayerItems[i]) then
			GAMEMODE.PlayerItems[i] = nil;
			GAMEMODE.InventoryBlocks_Linear[i]:GrabItem();
		end
	end
end
usermessage.Hook('perp_strip_main', stripMain);

local function weArrested ( UMsg )
	local ARREST_TIME = UMsg:ReadShort();
	GAMEMODE.UnarrestTime = CurTime() + ARREST_TIME;
end
usermessage.Hook('perp_arrested', weArrested);

function GM.CarAlarm ( UMsg )
	local Entity = UMsg:ReadEntity();
	
	if !Entity or !Entity:IsValid() then return false; end

	for i=1,10 do
		if !Entity or !Entity:IsValid() then return false; end
		Entity:EmitSound("PERP2.5/car_horn_long.wav");
		timer.Simple(i, function() 
		if !Entity or !Entity:IsValid() then return false; end
		Entity:EmitSound("PERP2.5/car_horn_long.wav"); 
		end);
	end
	
	CarsHornEnabled = true
end
usermessage.Hook('perp_car_alarm', GM.CarAlarm);

function GM.HouseAlarm ( UMsg )
	local Entity = UMsg:ReadEntity();
	
	if !Entity or !Entity:IsValid() then return false; end
	
	Entity:EmitSound("PERP2.5/house_alarm_long.mp3");
end
usermessage.Hook('perp_house_alarm', GM.HouseAlarm);

function BombInit ( UMsg )
	local pos = UMsg:ReadVector();
	
	local effectdata = EffectData()
		effectdata:SetOrigin( pos )
	util.Effect( "explosion_car", effectdata )
								
	local effectdata = EffectData()
		effectdata:SetOrigin( pos )
	util.Effect( "Explosion", effectdata, true, true )
end
usermessage.Hook("perp_bomb", BombInit);

local function resetStam ( )
	LocalPlayer().Stamina = 100;
end
usermessage.Hook("perp_reset_stam", resetStam);