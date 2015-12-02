

local PANEL = {}

function PANEL:Init ()
	self.points = {}
	
	local function AddRadarPoint(um)
		local strID = um:ReadString()
		if(self.points[strID]) then
			self.points[strID] = nil
		end
		
		local vPos = um:ReadVector()
		local strT = um:ReadString()
		local tblC = Color(um:ReadShort(), um:ReadShort(), um:ReadShort(), um:ReadShort())
		
		self.points[strID] = {vPos, strT, tblC}
	end
	usermessage.Hook("AddRadarPoint", AddRadarPoint)
	
	local function RemoveRadarEntry(um)
		self.points[um:ReadString()] = nil
	end
	usermessage.Hook("RemoveRadarEntry", RemoveRadarEntry)
	
	self:SetSize(ScrW() * 0.15, ScrH() * 0.15)
	self:SetPos(5, 15)
	self.alpha = 0
end

function PANEL:Think()
	if(table.Count(self.points) < 1) then
		self.alpha = math.Clamp(self.alpha - FrameTime() * 500, 0, 200)
		self:SetAlpha(self.alpha)
	else
		self.alpha = math.Clamp(self.alpha + FrameTime() * 500, 0, 250)
		self:SetAlpha(self.alpha)
	end
end

function PANEL:PerformLayout()
end

function PANEL:Paint()
	surface.SetDrawColor(Color(25, 25, 25, 200))
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall())
	
	surface.SetDrawColor(Color(200, 200, 200, 200))
	surface.DrawRect(self:GetWide() * 0.5 - 2, self:GetTall() * 0.5 - 2, 4, 4)
	
	for k,v in pairs(self.points) do
		local vPos = v[1]
		if(type(vPos) == "function") then
			vPos = vPos()
		elseif(vPos == nil) then
			self.points[k] = nil
		end
		
		vPos = LocalPlayer():GetPos() - vPos
		vPos:Rotate(Angle(0, 90 + LocalPlayer():EyeAngles().y * -1, 0))
		local strText = v[2]
		local tblColor = v[3]
		local x, y = vPos.x * -0.01, vPos.y * 0.01
		
		surface.SetDrawColor(tblColor)
		surface.DrawRect(((self:GetWide() * 0.5) + x) - 2, ((self:GetTall() * 0.5) + y) - 2, 4, 4)
		
		surface.SetFont("DefaultSmall")
		surface.SetTextColor(Color(255, 255, 255, 150))
		
		local xs, ys = surface.GetTextSize(strText)
		surface.SetTextPos((self:GetWide() * 0.5) - (xs * 0.5) + x, (self:GetTall() * 0.5) - (ys * 0.5) + y + 5)
		surface.DrawText(strText)
	end
end

vgui.Register('perp_radar', PANEL)