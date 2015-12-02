


local godstickCrosshair = surface.GetTextureID("perp3/crosshairs/godstick_crosshairv4");
local i = 0;

function CrosshairDraw( )
	if IsValid(LocalPlayer():GetActiveWeapon()) and LocalPlayer():GetActiveWeapon():GetClass() == "god_stick" then
		local x = (ScrW()/2)
		local y = (ScrH()/2)
				
		surface.SetDrawColor(255, 255, 255, 255);
		surface.SetTexture(godstickCrosshair);
		surface.DrawTexturedRectRotated(x, y, 64, 64, 0 + i);
		hook.Add("Think", "CrosshairRotator", CrosshairRotator);
	else
		hook.Remove("Think", "CrosshairRotator");
	end;
end;
hook.Add("HUDPaint", "", CrosshairDraw);

function CrosshairRotator()
	i = i + 3
end;