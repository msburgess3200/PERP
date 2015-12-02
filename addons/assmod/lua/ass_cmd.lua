// The asscmd bypasses the game.ConsoleCommand binding, which restricts 
// certain console commands from being run. asscmd is ONLY used for 
// rcon stuff. There is no client-exec stuff in it.

// require("asscmd") *dll broken*

if (!asscmd || !asscmd.Loaded || !asscmd.Loaded()) then
	
	asscmd = {}
	asscmd.ConsoleCommand = game.ConsoleCommand
	
end