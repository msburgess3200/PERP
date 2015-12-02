


local PANEL = {};
surface.CreateFont("SkillsFont", {
	font="Tahoma",
	size=ScreenScale(8),
	weight=1000,
	antialias=true
})

local Time = .25;

function PANEL:Init ( )
	self.DieTime = CurTime() + Time;
end

function PANEL:PerformLayout ( )
	self:SetPos(0, 0);
	self:SetSize(ScrW(), ScrH());
end

function PANEL:Paint ( )
	if (CurTime() >= self.DieTime) then self:Remove(); return; end
	surface.SetDrawColor(100, 100, 255, 150 * ((self.DieTime - CurTime()) / .25));
	surface.DrawRect(0, 0, self:GetWide(), self:GetTall());
end

vgui.Register('perp2_drown', PANEL);