

ASS_EnableDebug = false

if (CLIENT) then
	ASS_DebugFilename = "ass_debug_cl.txt"
elseif (SERVER) then
	ASS_DebugFilename = "ass_debug_sv.txt"
end

function ASS_Debug( msg )

	if (!ASS_EnableDebug) then return end

	local log = ""
	if (file.Exists(ASS_DebugFilename)) then
		log = file.Read(ASS_DebugFilename)
	end
	
	log = log .. tostring(msg)
	
	file.Write(ASS_DebugFilename, log)
	
end