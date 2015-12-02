local ITEM 					= {}

ITEM.ID 					= 160
ITEM.Reference 				= "drug_cocaine"

ITEM.Name 					= 'Cocaine'
ITEM.Description 			= 'Drugs are bad -WHO GIVES A FUCK??'

ITEM.Weight 				= 5
ITEM.Cost					= 225

ITEM.MaxStack 				= 2000

ITEM.InventoryModel 		= "models/cocn.mdl"
ITEM.ModelCamPos 			= Vector(0, 0, 9)
ITEM.ModelLookAt	 		= Vector(0, 0, 0)
ITEM.ModelFOV 				= 70
ITEM.WorldModel 			= "models/cocn.mdl"

ITEM.RestrictedSelling	 	= true // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil											
ITEM.PredictUseDrop			= true // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		return false;
	end
	
	function ITEM.OnDrop ( Player )
		return false;
	end
	
	function ITEM.Equip ( Player )

	end
	
	function ITEM.Holster ( Player )

	end
	
else

	function ITEM.OnUse ( slotID )		
		return false;
	end
	
	function ITEM.OnDrop ( )
		return false;
	end
	
end

GM:RegisterItem(ITEM)

