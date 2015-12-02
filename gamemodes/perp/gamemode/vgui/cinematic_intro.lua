

local PANEL = {};
//local blackOut = 255;
local cinematicAlpha = 255;
local topSlider = 100;
local bottomSlider = 100;
local defaultColor = 0;

function PANEL:Init ( )
	self:SetMouseInputEnabled( false );
end;

function PANEL:PerformLayout ( )
	self:SetPos(0, 0);
	self:SetSize(ScrW(), ScrH());
end;

function PANEL:Paint ( )
	surface.SetDrawColor( 0, 0, 0, 255);
	
	// Blackout
//	surface.DrawRect(0, 0, ScrW(), ScrH());
//	surface.
	
	// Sliders
	surface.DrawRect(0 , 0, ScrW(), topSlider );
	surface.DrawRect(0 , (ScrH())-bottomSlider, ScrW(), 100 );
	
	// Center Cinematic Text
	draw.SimpleText("EvoCity, 2020", "perp2_IntroTextBig", ScrW()/2, ScrH()/2, Color(255, 255, 255, cinematicAlpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	draw.SimpleText("A new beginning, to a new year.", "perp2_IntroTextSmall", ScrW()/2, (ScrH()/2)+35, Color(255, 255, 255, cinematicAlpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER);
	
	
end;

function PANEL:Think()
timer.Simple(2, function() cinematicAlpha = math.Approach(cinematicAlpha, 0, 2) end );
	
	if cinematicAlpha < 10 then
		value = true;
	end;
	
	if (value) then
		topSlider = math.Approach(topSlider, 0, 1);
		bottomSlider = math.Approach(bottomSlider, 0, 1);
		defaultColor = math.Approach(defaultColor, 100, 1);
	end;
	
	if defaultColor > 99 then
		vgui.Create("perp3_headerVGUI");
		hook.Remove("RenderScreenspaceEffects", "BlackWhite");
		self:Remove();
	end;
end;

function BlackWhiteEffect ( )
    local bwe = {}
    bwe[ "$pp_colour_addr" ]        = 0
    bwe[ "$pp_colour_addg" ]        = 0
    bwe[ "$pp_colour_addb" ]        = 0
    bwe[ "$pp_colour_brightness" ]  = 0
    bwe[ "$pp_colour_contrast" ]    = 1
    bwe[ "$pp_colour_colour" ]      = defaultColor/100;
    bwe[ "$pp_colour_mulr" ]        = 0
    bwe[ "$pp_colour_mulg" ]        = 0
    bwe[ "$pp_colour_mulb" ]        = 0
     
    --DrawColorModify( bwe )
end;
hook.Add( "RenderScreenspaceEffects", "BlackWhite", BlackWhiteEffect )
	
vgui.Register("perp2_cinematic_intro", PANEL);