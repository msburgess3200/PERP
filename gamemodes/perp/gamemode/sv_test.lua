


concommand.Add("perp_pimpmyride", function(objPl, _, tblArgs)
	if(not game.SinglePlayer()) then
		if(not objPl:IsOwner()) then return end
		if(not IsValid(objPl:GetVehicle())) then return end
	end
	
	objPl:GetVehicle():SetVehicleParameter(unpack(tblArgs))
end)

concommand.Add("perpx_giveitembeg", function(objPl, _, tblArgs)
	if(not game.SinglePlayer() and not objPl:IsSuperAdmin()) then return end
	
	objPl:GiveItem(tonumber(tblArgs[1]), 1, true)
end)

concommand.Add("perpx_spv", function(objPl, _, tblArgs)
	if(not game.SinglePlayer() and not objPl:IsSuperAdmin()) then return end
	GAMEMODE.SpawnVehicle(objPl, tblArgs[1], {1,1,0})
end)