function GM.FlipDrug ( Player )

	local ET = Player:GetEyeTrace();
	
	if ET.HitWorld then return false; end
	
	if ET.Entity:GetClass() == "ent_pot" or ET.Entity:GetClass() == "ent_coca" then
		ET.Entity:SetAngles(Angle(0,0,0))
	end
	
end
concommand.Add("potflip", GM.FlipDrug)
