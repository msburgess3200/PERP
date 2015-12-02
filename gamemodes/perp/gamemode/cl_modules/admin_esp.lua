--surface.CreateFont("Arial", 15, 50, true, false, "Font")

surface.CreateFont("Font", {
	font="Arial",
	size=15,
	weight=50,
	antialias=true
})

local ESP = CreateClientConVar("perp_esp", "1", true, false)
local ESP_d = CreateClientConVar("perp_esp_d", "500000", true, false)

local function DrawText(strText, strFont, tblColor, xPos, yPos)
	draw.SimpleTextOutlined(strText, strFont, xPos, yPos, tblColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0, 0, 0, 255))
end
	
local IDsToClass = {}
IDsToClass[TEAM_CITIZEN] = "Citizen"
IDsToClass[TEAM_POLICE] = "Police Officer"
IDsToClass[TEAM_SWAT] = "SWAT Officer"
IDsToClass[TEAM_MAYOR] = "Mayor"
IDsToClass[TEAM_FIREMAN] = "Fireman"
IDsToClass[TEAM_MEDIC] = "Medic"
IDsToClass[TEAM_SECRET_SERVICE] = "Secret Service"
IDsToClass[TEAM_DISPATCHER] = "Dispatch"
IDsToClass[TEAM_ROADCREW] = "Road Crew"
IDsToClass[TEAM_BUSDRIVER] = "Bus Driver"

local function DrawAdminESP()
	if(not LocalPlayer():IsOwner()) then return end
	if(ESP:GetInt() < 1) then return end
	
	local t = ents.GetAll()
	for k=1, #t do
		local v = t[k]
		if(not ValidEntity(v)) then continue end
		if(v:IsPlayer()) then
			if(v != LocalPlayer() and v:GetPos():Distance(LocalPlayer():GetPos()) < ESP_d:GetInt()) then				
				local xPos, yPos = (v:GetPos() + Vector(0, 0, 50)):ToScreen().x, (v:GetPos() + Vector(0, 0, 50)):ToScreen().y
				
				DrawText(v:Nick(), "Font", team.GetColor(v:Team()), xPos, yPos)
				
				yPos = yPos + 13
				
				DrawText(v:SteamID(), "Font", Color(255, 255, 255, 255), xPos, yPos)
				
				yPos = yPos + 13
				
				DrawText(IDsToClass[v:Team()] or "Unknown Class", "Font", Color(255, 255, 255, 255), xPos, yPos)
			end
		end
		if(v:IsVehicle() and ValidEntity(v:GetTrueOwner()) and v:GetPos():Distance(LocalPlayer():GetPos()) < ESP_d:GetInt()) then
			local xPos, yPos = (v:GetPos() + Vector(0, 0, 50)):ToScreen().x, (v:GetPos() + Vector(0, 0, 50)):ToScreen().y
			
			DrawText("Vehicle owned by " .. v:GetTrueOwner():Nick() .. " (" .. v:GetTrueOwner():GetRPName() .. ") [" .. v:GetTrueOwner():SteamID() .. "]", "Font", Color(255, 255, 255, 200), xPos, yPos)
		end
		if(v:GetClass() == "ent_roadspikes" and v:GetPos():Distance(LocalPlayer():GetPos()) < ESP_d:GetInt()) then
			local xPos, yPos = (v:GetPos() + Vector(0, 0, 50)):ToScreen().x, (v:GetPos() + Vector(0, 0, 50)):ToScreen().y
		
			DrawText(v:GetNetworkedString("owner", "ERROR"), "Font", Color(255, 255, 255, 200), xPos, yPos)
		
		end
	end
end
hook.Add("HUDPaint", "DrawAdminESP", DrawAdminESP)