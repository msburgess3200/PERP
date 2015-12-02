

ASS_Config["writer"] = "Default Writer"
ASS_Config["max_temp_admin_time"] = 	4 * 60
ASS_Config["max_temp_admin_ban_time"] = 1 * 60

ASS_Config["bw_background"] = 1
ASS_Config["tell_admins_what_happened"] = 1

ASS_Config["demomode"] = 0
ASS_Config["demomode_ta_time"] = 30

ASS_Config["admin_speak_prefix"] = "@"

ASS_Config["reasons"] = {

	{	name = "(none)", 		reason = ""					},
	{	name = "Excessive Non-RP",	reason = "Poor RP"				},
	{	name = "Unrealistic Driving",	reason = "Excessive Unrealistic Driving"	},
	{	name = "Career Camping",	reason = "Career Camping"			},
	{	name = "Breaking NLR",		reason = "Breaking NLR"				},
	{	name = "RDM",			reason = "Random Deathmatch"			},
	{	name = "NLR",			reason = "Breaking NLR"				},
	{	name = "Player Disrespect",	reason = "Player Disrespect"			},
	{	name = "Admin Disrespect",	reason = "Admin Disrespect"			},
	{	name = "Metagaming",		reason = "Metagaming"				},
	{	name = "Powergaming",		reason = "Powergaming"				},
	

}

ASS_Config["ban_times"] = {

	{ 	time = 5,			name = "5 Min"		},
	{ 	time = 10,			name = "10 Min"		},
	{ 	time = 20,			name = "20 Min"		},
	{ 	time = 30,			name = "30 Min" 	},
	{ 	time = 45,			name = "45 Min" 	},
	{ 	time = 60,			name = "1 Hour"		},
	{ 	time = 120,			name = "2 Hours"	},
	{ 	time = 180,			name = "3 Hours"	},
	{ 	time = 120 * 2,			name = "4 Hours"	},
	{ 	time = 120 * 3,			name = "6 Hours"	},
	{ 	time = 120 * 6,			name = "12 Hours"	},
	{ 	time = 1440,			name = "1 Day"		},
	{ 	time = 2880,			name = "2 Days"		},
	{ 	time = 1440 * 7, 		name = "1 Week"		},
	{ 	time = 1440 * 14, 		name = "2 Weeks"	},
	{ 	time = 1440 * 21, 		name = "3 Weeks"	},
	{ 	time = 1440 * 28, 		name = "4 Weeks"	},
	{ 	time = 1440 * 56, 		name = "8 Weeks"	},
	{ 	time = 0,			name = "Perma"		},

}

ASS_Config["temp_admin_times"] = {

	{ 	time = 5,		name = "5 Min"		},
	{ 	time = 15,		name = "15 Min"		},
	{ 	time = 30,		name = "30 Min" 	},
	{ 	time = 60,		name = "1 Hour"		},
	{ 	time = 120,		name = "2 Hours"	},
	{ 	time = 240,		name = "4 Hours"	},

}

ASS_Config["fixed_notices"] = {

	{	duration = 10,		text = "Welcome to %hostname%. Please play nice!"			},
	{	duration = 10,		text = "Running %gamemode% on %map%"					},
	{	duration = 10,		text = "%assmod% - If you're an admin, bind a key to +ASS_Menu"		},

}
		
ASS_Config["rcon"] = {

	{	cmd = "sv_cheats 1"	},
	{	cmd = "sv_cheats 0"	},
	
}