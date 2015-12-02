

local PANEL = {}

local PEMusic_Bass = {0.275, 1.225, 2.15, 4.025, 4.75, 4.975, 5.65, 5.9, 6.6};
local PERPMusic_Bass = {10.825, 11.10, 11.425, 11.575, 11.725, 12.25, 12.35, 13.25, 13.52, 14.15, 14.45, 14.575, 15.625, 16.525, 16.825, 17.125, 18.025, 18.65, 18.925, 19.225, 19.375,19.525, 19.65, 19.425, 20.425, 21.325, 21.625, 21.925, 22.825, 23.425, 23.725, 24.325, 25.225, 26.15, 26.425, 26.725, 27.625, 28.225};
local PEIntro = Sound("PERP2.5/intro/pe.mp3");
local PERPIntro = Sound("PERP2.5/intro/perp2.mp3");

local PELogo = surface.GetTextureID("PERP2/intro/dg");
local PERPLogo = surface.GetTextureID("PERP2/intro/dgrp");
--local PERP2_G = surface.GetTextureID("PERP2/intro/2_g");
--local PERP2_NG = surface.GetTextureID("PERP2/intro/2_ng");

local BASSTime = .1;
local BASSSize = .025;

function PANEL:Init ( )

end

function PANEL:PerformLayout ( )
	self:SetPos(0, 0);
	self:SetSize(ScrW(), ScrH());
	
	self.regSize = ScrW() * .5;
	self.midW = ScrW() * .5;
	self.midH = ScrH() * .5;
end

function PANEL:EnableCreation ( )
	self.registerForm = true;
end

function PANEL:EnableRules ( )
	self.rulesForm = true;
end

function PANEL:Paint ( )
	// bye bye intro
	if (self.registerForm) then
		ShowRegisterForm();
	elseif (self.rulesForm) then
		ShowRulesConfirmation();
	end

	self:Remove();
end

vgui.Register("perp2_intro", PANEL);