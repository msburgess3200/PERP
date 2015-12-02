


local PANEL = {};
local bloodMaterials = {surface.GetTextureID("PERP2/hud/blood1"), surface.GetTextureID("PERP2/hud/blood2"), surface.GetTextureID("PERP2/hud/blood3"), surface.GetTextureID("PERP2/hud/blood4")}

function PANEL:Init ( )
	self.bloodSplots = {};
end

function PANEL:PerformLayout ( )
	self:SetPos(0, 0);
	self:SetSize(ScrW(), ScrH());
end

function PANEL:Paint ( )
	local health = LocalPlayer():Health();

	local per = 128;
	local marksShouldHave = math.floor(30 * 2) - math.floor(health * 2);
	
	while (marksShouldHave > 0 && #self.bloodSplots != marksShouldHave) do
		if (#self.bloodSplots < marksShouldHave) then
			table.insert(self.bloodSplots, {math.random(1, 4), math.random(0, self:GetWide()), math.random(0, self:GetTall()), math.random(0, 360), math.random(0, 50)});
		elseif (#self.bloodSplots > marksShouldHave) then
			self.bloodSplots[#self.bloodSplots] = nil;
		end
	end
	
	local what = (health / 30);
	
	if (health > 30) then return; end
	
	surface.SetDrawColor(150, 0, 0, 50 - (50 * what));
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall());
	
	for k, v in pairs(self.bloodSplots) do
		surface.SetTexture(bloodMaterials[v[1]]);
		surface.SetDrawColor(125, 125, 125, 150 - (150 * what) + v[5]);
		surface.DrawTexturedRectRotated(v[2], v[3], per, per, v[4]);
	end
end

vgui.Register("perp2_blood", PANEL);