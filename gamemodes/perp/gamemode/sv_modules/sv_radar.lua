

radar = {}
local playermeta = FindMetaTable("Player")

function playermeta:AddRadarPoint(strID, vPos, strText, tblColor)
	umsg.Start("AddRadarPoint", self)
		umsg.String(strID)
		umsg.Vector(vPos)
		umsg.String(strText)
		umsg.Short(tblColor.r)
		umsg.Short(tblColor.g)
		umsg.Short(tblColor.b)
		umsg.Short(tblColor.a)
	umsg.End()
end

function playermeta:RemoveRadarPoint(strID)
	umsg.Start("RemoveRadarEntry", self)
		umsg.String(strID)
	umsg.End()
end

local tblAlerts = {}
function radar.AddAlertTeam(strID, tblTeam, vPos, strText, tblColor)
	for k,v in pairs(player.GetAll()) do
		if(table.HasValue(tblTeam, v:Team())) then
			v:AddRadarPoint(strID, vPos, strText, tblColor)
		end
	end
	
	tblAlerts[strID] = {tblTeam, vPos, strText, tblColor}
end

function radar.RemoveAlert(strID)
	local tbl = tblAlerts[strID]
	if(tbl) then
		for k,v in pairs(player.GetAll()) do
			if(table.HasValue(tbl[1], v:Team())) then
				v:RemoveRadarPoint(strID)
			end
		end
	end
end