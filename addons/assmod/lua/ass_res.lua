function ASS_InitResources()

	local function AddTexture(mat) 
		resource.AddFile( mat .. ".vmt" )
		resource.AddFile( mat .. ".vtf" )
	end
	
	AddTexture("materials/gui/silkicons/application_xp_terminal")
	AddTexture("materials/gui/silkicons/bomb")
	AddTexture("materials/gui/silkicons/error")
	AddTexture("materials/gui/silkicons/key")
	AddTexture("materials/gui/silkicons/map")
	AddTexture("materials/gui/silkicons/pill")
	AddTexture("materials/gui/silkicons/sport_soccer")
	AddTexture("materials/gui/silkicons/status_offline")
	AddTexture("materials/gui/silkicons/thumb_down")
	AddTexture("materials/gui/silkicons/newspaper")


end