

local PANEL = {}

local PELogo = surface.GetTextureID("PERP2/intro/pe");
local PERPLogo = surface.GetTextureID("PERP2/intro/perp");

local Loading_Vars = surface.GetTextureID("PERP2/intro/loading_vars");
local Loading_SMFID = surface.GetTextureID("PERP2/intro/loading_user_info");
local Loading_RP = surface.GetTextureID("PERP2/intro/loading_rp_info");

local bar_width = .5;
local bar_height = .1;


surface.CreateFont("HintFont", {
	font="Tahoma",
	size=ScreenScale(8),
	weight=1000,
	antialias=true
})


local hints = 	{
					"In order to call someone with your phone, they must be on your buddies list.",
					"Some mixtures are not unlocked until you get to a high enough skill level.",
					"Some mixtures are rare and can only be unlocked under certain conditions.",
					"You can change the colour settings on your phone including backlight, highlight, text colour and ringtone.",
					"VIPs get extra bonuses including extra income during payday and personalised features on cars.",
					"Pressing F1 will bring up your main control panel, where you can review the rules, add gene points to your preferred stats and much more.",
					"Organizations automatically add players who are in that org to your contacts list and you share any properties that players in your org own.",
					"",
					"",
					"See a troublesome player breaking a rule? Report him using the Report Player feature in the F1 menu.",
					"",
				};

function PANEL:Init ( )
	self.requestAgain = CurTime() + 20;
	self.requestAgain_SMF = CurTime() + 15;
	self.giveUp = CurTime() + 60;
	
	self.Hints = hints[math.random(1, #hints)];
end

function PANEL:PerformLayout ( )
	self:SetPos(0, 0);
	self:SetSize(ScrW(), ScrH());
end

function PANEL:Paint ( )
	surface.SetDrawColor(0, 0, 0, 255);
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall());
	
	surface.SetDrawColor(255, 255, 255, 255);
	
	surface.SetTexture(PERPLogo);
	surface.DrawTexturedRect(self:GetWide() * .5 - 256, 20, 512, 512);
	
	if (GAMEMODE.CurrentLoadStatus == 1) then
		surface.SetTexture(Loading_SMFID);
		
		if (self.requestAgain_SMF && CurTime() >= self.requestAgain_SMF) then
			RunConsoleCommand("perp_rsl");
			self.requestAgain_SMF = nil;
		end
	elseif (GAMEMODE.CurrentLoadStatus == 2) then
		surface.SetTexture(Loading_RP);
		
		if (self.requestAgain && CurTime() >= self.requestAgain) then
			RunConsoleCommand("perp_lp");
			self.requestAgain = nil
		end
	elseif (GAMEMODE.CurrentLoadStatus == 3) then
		surface.SetTexture(Loading_Vars);
	end
	
	local bar_x = self:GetWide() * (.5 - bar_width * .5);
	local bar_y = self:GetTall() * (.5 - bar_height * .5);
	local bar_w = self:GetWide() * bar_width;
	local bar_h = self:GetTall() * bar_height;
	
	surface.DrawTexturedRect(self:GetWide() * .5 - 128, self:GetTall() * .5 + bar_h * .7, 256, 128);
	
	surface.DrawRect(bar_x, bar_y, bar_w, bar_h);
	
	surface.SetDrawColor(0, 0, 0, 255);
	surface.DrawRect(bar_x + 2, bar_y + 2, bar_w - 4, bar_h - 4);
	
	GAMEMODE.ExpectedUMsg = GAMEMODE.ExpectedUMsg or 1;
	GAMEMODE.ExpectedUMsg_Start = GAMEMODE.ExpectedUMsg_Start or 1;
	local percDone = math.Clamp((GAMEMODE.ExpectedUMsg_Start - GAMEMODE.ExpectedUMsg) / GAMEMODE.ExpectedUMsg_Start, 0, 1);
	if (GAMEMODE.ExpectedUMsg_Start == 0) then percDone = 1; end
	
	surface.SetDrawColor(255, 255, 255, 255);
	surface.DrawRect(bar_x + 3, bar_y + 3, (bar_w - 6) * percDone, bar_h - 6);
	
	if (GAMEMODE.CurrentLoadStatus < 3 && CurTime() >= (self.giveUp - 5)) then
		draw.SimpleTextOutlined("Reconnecting in " .. math.Clamp(math.ceil(self.giveUp - CurTime()), 0, 10) .. " seconds...", "HUDFont", ScrW() * .5, ScrH() * .5, Color(0, 0, 0, 255), 1, 1, 1, Color(255, 255, 255, 255));
	elseif (GAMEMODE.CurrentLoadStatus == 2 && !self.requestAgain) then
		draw.SimpleTextOutlined("Refreshing request for RP Account...", "HUDFont", ScrW() * .5, ScrH() * .5, Color(0, 0, 0, 255), 1, 1, 1, Color(255, 255, 255, 255));
	elseif (GAMEMODE.CurrentLoadStatus == 1 && !self.requestAgain_SMF) then
		draw.SimpleTextOutlined("Refreshing request for SMFID...", "HUDFont", ScrW() * .5, ScrH() * .5, Color(0, 0, 0, 255), 1, 1, 1, Color(255, 255, 255, 255));
	elseif (percDone == 1) then
		draw.SimpleTextOutlined("Waiting for account info...", "HUDFont", ScrW() * .5, ScrH() * .5, Color(0, 0, 0, 255), 1, 1, 1, Color(255, 255, 255, 255));
	else
		draw.SimpleTextOutlined(math.Clamp(math.Round(percDone * 100), 0, 100) .. "%", "HUDFont", ScrW() * .5, ScrH() * .5, Color(0, 0, 0, 255), 1, 1, 1, Color(255, 255, 255, 255));
	end
	
	draw.SimpleText("HINT: " .. self.Hints, "HintFont", ScrW() * .5, ScrH() - 30, Color(255, 255, 255, 255), 1, 2);
	
	if (percDone == 1 && GAMEMODE.CurrentLoadStatus == 3) then
		GAMEMODE.ExpectedUMsg = nil;
		GAMEMODE.LoadScreen:Remove();
		GAMEMODE.LoadScreen = nil;
		GAMEMODE.CinematicIntro = vgui.Create("perp2_cinematic_intro");
		
		Msg("Var transfer completed.\n");
	elseif (GAMEMODE.CurrentLoadStatus < 3 && CurTime() >= self.giveUp) then
		RunConsoleCommand("retry");
	end
end

vgui.Register("perp2_loading", PANEL);