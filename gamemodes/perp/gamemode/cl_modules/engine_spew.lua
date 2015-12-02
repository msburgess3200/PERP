

--require("enginespew")

local function monitorErrors ( spewTime, msg, group, level )
	if (msg == "Too many vertex format changes in frame, whole world not rendered\n") then return false end
end
hook.Add("EngineSpew", "ES", monitorErrors)
