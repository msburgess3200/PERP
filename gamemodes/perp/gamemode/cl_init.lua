
ents.Create = ents.CreateClientProp

// Include the shared init file.
include("sh_init.lua");

// Include the client files.
include("cl_networking.lua");
include("cl_hooks.lua");
include("cl_items.lua");
include("cl_player.lua");
include("cl_misc.lua");
include("cl_chat.lua");
include("cl_vehicles.lua");
include("cl_trade.lua");     
include("cl_scoreboards.lua");
include("cl_test.lua");

// Fonts
local tblFonts = { }
tblFonts["DebugFixed"] = {
	font = "Courier New",
	size = 10,
	weight = 500,
	antialias = true,
}

tblFonts["DebugFixedSmall"] = {
	font = "Courier New",
	size = 7,
	weight = 500,
	antialias = true,
}

tblFonts["DefaultFixedOutline"] = {
	font = "Lucida Console",
	size = 10,
	weight = 0,
	outline = true,
}

tblFonts["MenuItem"] = {
	font = "Tahoma",
	size = 12,
	weight = 500,
}

tblFonts["Default"] = {
	font = "Tahoma",
	size = 13,
	weight = 500,
}

tblFonts["TabLarge"] = {
	font = "Tahoma",
	size = 13,
	weight = 700,
	shadow = true,
}

tblFonts["DefaultBold"] = {
	font = "Tahoma",
	size = 13,
	weight = 1000,
}

tblFonts["DefaultUnderline"] = {
	font = "Tahoma",
	size = 13,
	weight = 500,
	underline = true,
}

tblFonts["DefaultSmall"] = {
	font = "Tahoma",
	size = 11,
	weight = 0,
}

tblFonts["DefaultSmallDropShadow"] = {
	font = "Tahoma",
	size = 11,
	weight = 0,
	shadow = true,
}

tblFonts["DefaultVerySmall"] = {
	font = "Tahoma",
	size = 10,
	weight = 0,
}

tblFonts["DefaultLarge"] = {
	font = "Tahoma",
	size = 16,
	weight = 0,
}

tblFonts["UiBold"] = {
	font = "Tahoma",
	size = 12,
	weight = 1000,
}

tblFonts["UIBold"] = tblFonts["UiBold"];

tblFonts["MenuLarge"] = {
	font = "Verdana",
	size = 15,
	weight = 600,
	antialias = true,
}

tblFonts["ConsoleText"] = {
	font = "Lucida Console",
	size = 10,
	weight = 500,
}

tblFonts["Marlett"] = {
	font = "Marlett",
	size = 13,
	weight = 0,
	symbol = true,
}

tblFonts["Trebuchet24"] = {
	font = "Trebuchet MS",
	size = 24,
	weight = 900,
}

tblFonts["Trebuchet22"] = {
	font = "Trebuchet MS",
	size = 22,
	weight = 900,
}

tblFonts["Trebuchet20"] = {
	font = "Trebuchet MS",
	size = 20,
	weight = 900,
}

tblFonts["Trebuchet19"] = {
	font = "Trebuchet MS",
	size = 19,
	weight = 900,
}

tblFonts["Trebuchet18"] = {
	font = "Trebuchet MS",
	size = 18,
	weight = 900,
}

tblFonts["HUDNumber"] = {
	font = "Trebuchet MS",
	size = 40,
	weight = 900,
}

tblFonts["HUDNumber1"] = {
	font = "Trebuchet MS",
	size = 41,
	weight = 900,
}

tblFonts["HUDNumber2"] = {
	font = "Trebuchet MS",
	size = 42,
	weight = 900,
}

tblFonts["HUDNumber3"] = {
	font = "Trebuchet MS",
	size = 43,
	weight = 900,
}

tblFonts["HUDNumber4"] = {
	font = "Trebuchet MS",
	size = 44,
	weight = 900,
}

tblFonts["HUDNumber5"] = {
	font = "Trebuchet MS",
	size = 45,
	weight = 900,
}

tblFonts["HudHintTextLarge"] = {
	font = "Verdana",
	size = 14,
	weight = 1000,
	antialias = true,
	additive = true,
}

tblFonts["HudHintTextSmall"] = {
	font = "Verdana",
	size = 11,
	weight = 0,
	antialias = true,
	additive = true,
}

tblFonts["CenterPrintText"] = {
	font = "Trebuchet MS",
	size = 18,
	weight = 900,
	antialias = true,
	additive = true,
}

tblFonts["DefaultFixed"] = {
	font = "Lucida Console",
	size = 10,
	weight = 0,
}

tblFonts["DefaultFixedDropShadow"] = {
	font = "Lucida Console",
	size = 10,
	weight = 0,
	shadow = true,
}

tblFonts["CloseCaption_Normal"] = {
	font = "Tahoma",
	size = 16,
	weight = 500,
}

tblFonts["CloseCaption_Italic"] = {
	font = "Tahoma",
	size = 16,
	weight = 500,
	italic = true,
}

tblFonts["CloseCaption_Bold"] = {
	font = "Tahoma",
	size = 16,
	weight = 900,
}

tblFonts["CloseCaption_BoldItalic"] = {
	font = "Tahoma",
	size = 16,
	weight = 900,
	italic = true,
}

tblFonts["TargetID"] = {
	font = "Trebuchet MS",
	size = 22,
	weight = 900,
	antialias = true,
}

tblFonts["TargetIDSmall"] = {
	font = "Trebuchet MS",
	size = 18,
	weight = 900,
	antialias = true,
}

tblFonts["BudgetLabel"] = {
	font = "Courier New",
	size = 14,
	weight = 400,
	outline = true,
}


for k,v in SortedPairs( tblFonts ) do
	surface.CreateFont( k, tblFonts[k] );

	--print( "Added font '"..k.."'" );
end
surface.CreateFont("perp2_IntroTextBig", {
	font="coalition",
	size=ScaleToWideScreen(70),
	weight=100,
	antialias=true
})
--surface.CreateFont("coalition", ScaleToWideScreen(70), 100, true, false, "perp2_IntroTextBig");

surface.CreateFont("perp2_IntroTextSmall", {
	font="coalition",
	size=ScaleToWideScreen(16),
	weight=100,
	antialias=true
})
--surface.CreateFont("coalition", ScaleToWideScreen(15), 100, true, false, "perp2_IntroTextSmall");

surface.CreateFont("perp2_TextHUDBig", {
	font="coalition",
	size=ScaleToWideScreen(16),
	weight=100,
	antialias=true
})
--surface.CreateFont("coalition", ScaleToWideScreen(16), 100, true, false, "perp2_TextHUDBig");

surface.CreateFont("perp2_TextHUDSmall", {
	font="coalition",
	size=ScaleToWideScreen(12),
	weight=100,
	antialias=true
})
--surface.CreateFont("coalition", ScaleToWideScreen(12), 100, true, false, "perp2_TextHUDSmall");

surface.CreateFont("perp2_RealtorFontNew", {
	font="coalition",
	size=ScaleToWideScreen(24),
	weight=100,
	antialias=true
})
--surface.CreateFont("coalition", ScaleToWideScreen(24), 100, true, false, "perp2_RealtorFontNew");

surface.CreateFont("perp3_HeaderFontLarge", {
	font="coalition",
	size=ScaleToWideScreen(32),
	weight=100,
	antialias=true
})
--urface.CreateFont("coalition", ScaleToWideScreen(32), 100, true, false, "perp3_HeaderFontLarge");

surface.CreateFont("movietheater", {
	font="coalition",
	size=ScaleToWideScreen(128),
	weight=100,
	antialias=true
})
--surface.CreateFont("coalition", ScaleToWideScreen(128), 100, true, false, "movietheater");


for k, v in pairs(file.Find("perp/gamemode/cl_modules/*.lua","LUA")) do include("cl_modules/" .. v); end
for k, v in pairs(file.Find("perp/gamemode/vgui/*.lua","LUA")) do include("vgui/" .. v); end