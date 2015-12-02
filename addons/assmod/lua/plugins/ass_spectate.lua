local PLUGIN = {}

PLUGIN.Name = "PERP3.5 Spectate"				// plugin name
PLUGIN.Author = "RedMist"			// author
PLUGIN.Date = "15th March 2011"		// date of creation / modification
PLUGIN.Filename = PLUGIN_FILENAME		// filename of the plugin
PLUGIN.ClientSide = true			// allow to be loaded clientside
PLUGIN.ServerSide = true			// allow to be loaded serverside
PLUGIN.APIVersion = 2				// API Version
PLUGIN.Gamemodes = {""}				// list of gamemodes that this plugin can be used with. If this
						// is empty, all gamemodes are allowed.

if (CLIENT) then

	// KillPlayer, called from the ASS_PlayerMenu function.
	function PLUGIN.KillPlayer(PLAYER)

		// Pretty simple. All we do is fire off a console command.
		
		if (!PLAYER:IsValid()) then return end

		RunConsoleCommand( "perp_a_s", PLAYER:UniqueID() )
		
		// Returning true at this point would force the menu to stay open,
		// thus allowing the user to re-click then menu item.

	end
	
	function PLUGIN.BuildMenu(NEWMENU)
		
		// ASS_PlayerMenu fills the menu with a list of the players names
		// The first parameter is the menu to fill, the second is a list of options:
		//	"IncludeLocalPlayer"	->	the client is included in the list
		//	"HasSubMenu"		->	the function in the 3rd parameter is
		//					the build menu function, not the on-click
		//					function.
		//	"IncludeAll"		->	if you're the server owner, you get a 3 
		//					menu choice to choose between groups
		//					"all players, "all admins", "all non admins".
		//					if you're not the server owner you get 
		//					"all non admins".
		//	"IncludeAllSO"		->	same as above, but you get the 3 group options
		//					(not dependent on what admin type you are).
		//	Note: If HasSubMenu and one of the IncludeAll flags are both set, then the
		//		"player" parameter of the call back function will actually be a table
		//		of players to act upon.
		--NEWMENU:AddOption("Stop Spectate", function() RunConsoleCommand("perp_a_ss") end )
		ASS_PlayerMenu( NEWMENU, {}, PLUGIN.KillPlayer ) --Whoever made this shit has way too much time on their hands, cause 90% of things don't work correctly. -Misha P.S. Not fixing this, too useless.
	end
	
	// AddMenu, the main callback. This is used to add menu items under the "Plugins" heading
	// of the main menu.
	
	function PLUGIN.AddMenu(DMENU)			

		// Add the Kill option to the menu. The first paramter is the text that appears
		// on the menu item, the second is the function to call when the item is clicked,
		// the third is the function that will build a new menu when the item is hovered
		// over (to create a sub menu).
		
		DMENU:AddSubMenu( "Spectate" , nil, PLUGIN.BuildMenu)
		DMENU:AddOption( "Stop Spectate" , function ( ) RunConsoleCommand("perp_a_ss") end)

	end

end

// Lastly register the plugin. This will ensure the plugin is loaded, and sent to the 
// player if necessary.
ASS_RegisterPlugin(PLUGIN)


