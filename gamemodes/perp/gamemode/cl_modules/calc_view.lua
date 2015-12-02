


function lookForVT ( Vehicle )
	if (IsValid(Vehicle)) then
		if (!Vehicle.vehicleTable) then
			for k, v in pairs(VEHICLE_DATABASE) do
				for _, PJ in pairs(v.PaintJobs) do
					if (PJ.model == Vehicle:GetModel()) then
						Vehicle.vehicleTable = v;
						break;
					end
				end
				
				if (Vehicle.vehicleTable) then break; end
			end
		end
	end
	
	return Vehicle.vehicleTable;
end

/*
hook.Add( "CalcView", "chairs.CalcView", function( pl, origin, angles, fov )
	
	if !pl:InVehicle() then return end
	if !
	
	local view = {}
	
	pl:SetNoDraw( true )
	origin = pl:GetPos() + pl:GetUp() * 50
	angles = (pl.sitview and vgui.CursorVisible()) and (pl.sitview-pl:EyePos()):Angle() or angles
	
	view.angles = angles
	view.origin = origin
	view.fov = fov
	
	return view
	
end )
*/

function GM:CalcView( ply, origin, angles, fov )
	
	local Vehicle = ply:GetVehicle()
	lookForVT(Vehicle);
	
	local wep = ply:GetActiveWeapon()

	
	if ( ValidEntity( Vehicle ) && 
		 (GetConVar("gmod_vehicle_viewmode"):GetInt() == 1)
		 /*&& ( !ValidEntity(wep) || !wep:IsWeaponVisible() )*/
		) then
		
		return GAMEMODE:CalcVehicleThirdPersonView( Vehicle, ply, origin*1, angles*1, fov )
		
	end


	local view = {}
	view.origin 	= origin
	view.angles		= angles
	
	
	if ply:InVehicle() then
	
	
		if (Vehicle.vehicleTable && Vehicle.vehicleTable.ViewAdjustments_FirstPerson) then
			if (Vehicle.vehicleTable.ViewAdjustments_FirstPerson == VIEW_LOCK) then
				view.angles	= ply:GetAimVector():Angle();
			else
				view.origin = origin + 
									(ply:GetVehicle():GetAngles():Up() * Vehicle.vehicleTable.ViewAdjustments_FirstPerson.z) + 
									(ply:GetVehicle():GetAngles():Forward() * Vehicle.vehicleTable.ViewAdjustments_FirstPerson.x) + 
									(ply:GetVehicle():GetAngles():Right() * Vehicle.vehicleTable.ViewAdjustments_FirstPerson.y);
			end
		end
	end;

	
	view.fov 		= fov 
	view.fov 		= fov
	
	// Give the active weapon a go at changing the viewmodel position
	
	if ( ValidEntity( wep ) ) then
	
		local func = wep.GetViewModelPosition
		if ( func ) then
			view.vm_origin,  view.vm_angles = func( wep, origin*1, angles*1 ) // Note: *1 to copy the object so the child function can't edit it.
		end
		
		local func = wep.CalcView
		if ( func ) then
			view.origin, view.angles, view.fov = func( wep, ply, origin*1, angles*1, fov ) // Note: *1 to copy the object so the child function can't edit it.
		end
	
	end
	
	return view
end

function GM:CalcVehicleThirdPersonView( Vehicle, ply, origin, angles, fov )

	local view = {}
	
	if Vehicle.vehicleTable && Vehicle.vehicleTable.ViewAdjustments_FirstPerson && Vehicle.vehicleTable.ViewAdjustments_FirstPerson == VIEW_LOCK then
		view.angles		= ply:GetAimVector():Angle();
	else
		view.angles = angles;
	end
	
	view.fov 		= fov
	
	if ( !Vehicle.CalcView ) then
	
		Vehicle.CalcView = {}
		
		// Try to work out the size
		local min, max = Vehicle:WorldSpaceAABB()
		local size = max - min
		
		Vehicle.CalcView.OffsetUp = size.z
		Vehicle.CalcView.OffsetOut = (size.x + size.y + size.z) * 0.33
	
	end
	
	// Offset the origin
	local Up = view.angles:Up() * Vehicle.CalcView.OffsetUp * 0.66
	local Offset = view.angles:Forward() * -Vehicle.CalcView.OffsetOut
	
	if Vehicle.vehicleTable && Vehicle.vehicleTable.ViewAdjustments_ThirdPerson then
		Up = Up + Vehicle.vehicleTable.ViewAdjustments_ThirdPerson;
	end
	
	// Trace back from the original eye position, so we don't clip through walls/objects
	local TargetOrigin = Vehicle:GetPos() + Up + Offset
	local distance = origin - TargetOrigin
	
	local Filter = ents.FindByClass('prop_vehicle_prisoner_pod');
	table.insert(Filter, Vehicle);
	
	local trace = {
					start = origin,
					endpos = TargetOrigin,
					filter = Filter
				}
				  
				  
	local tr = util.TraceLine( trace ) 
	
	view.origin = origin + tr.Normal * (distance:Length() - 10) * tr.Fraction
	

	return view

end