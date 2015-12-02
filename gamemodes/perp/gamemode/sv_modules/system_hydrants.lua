/////////////////////////////////////////
// © 2011-2012 D3lux - D3lux-Gaming    //
//    All rights reserved    		   //
/////////////////////////////////////////
// This material may not be  		   //
//   reproduced, displayed,  		   //
//  modified or distributed  		   //
// without the express prior 		   //
// written permission of the 		   //
//   the copyright holder.  		   //
//		D3lux-Gaming.com   			   //
/////////////////////////////////////////


/*local DoorSpawns = {

						Vector(-5715.59375, -7260.78125, 116.9375), Angle(0,0,0),
						
					};
					
					
local function SpawnDoors ( )
	for i=1, #DoorSpawns, 2 do
		local NewDoor = ents.Create('func_door_rotating');
		NewDoor:SetModel("models/props_c17/door02_double.mdl");
		NewDoor:SetPos(DoorSpawns[i])
		NewDoor:SetAngles(DoorSpawns[i+1])
		NewDoor:Spawn()
	end

end;
timer.Simple(1, SpawnDoors);
*/		

local SlotRape = {
						Vector(-6762.6196, -14017.6504, 111.4622), Angle(0.3932,90.004,-0.0682),
						Vector(-6722.8491, -14017.6475, 111.5096), Angle(0.3932,90.004,-0.0682),
						Vector(-6660.8062, -14080.7119, 111.5909), Angle(-0.0079,-0.0339,0.1364),
						Vector(-6660.8296, -14120.4824, 111.4962), Angle(-0.0079,-0.0339,0.1365),

					};

local function SpawnSlots ( )					
	for i=1, #SlotRape, 2 do
		local NewProp = ents.Create('slot_machine');
		NewProp:SetPos(SlotRape[i])
		NewProp:SetAngles(SlotRape[i+1])
		NewProp:Spawn()
	end
		
	
end;
timer.Simple(1, SpawnSlots);				

local SlotTables = {
						Vector(-6684.2661, -14040.3184, 79.9379), Angle(0,-90,0), Model('models/sickness/cubicledesk_01.mdl'),
					};

					
local function SpawnTables ( )
	for i=1, #SlotTables, 3 do
		local Table = ents.Create('prop_physics');
		Table:SetModel(SlotTables[i+2])
		Table:SetPos(SlotTables[i])
		Table:SetAngles(SlotTables[i+1])
		Table:Spawn()
		Table:GetPhysicsObject():EnableMotion(false);
	end
end;
timer.Simple(1, SpawnTables);

local FireHydrants = {
						Vector(-5714.232421875, -7911.0551757813, 72), 
						Vector(-7039.1655273438, -7534.3193359375, 72), 
						Vector(-7295.431640625, -5735.9267578125, 72), 
						Vector(-7205.376953125, -4466.921875, 72), 
						Vector(-5712.08203125, -4332.5288085938, 72), 
						Vector(-4789.208984, -6930.316895, 198), 
						Vector(-5715.2578125, -9791.66015625, 72), 
						Vector(-8356.0869140625, -11045.198242188, 72),
					};
					
					
local function SpawnHydrants ( )
	for k, v in pairs(FireHydrants) do
		Hydrant = ents.Create("prop_physics");
		Hydrant:SetModel("models/props/cs_assault/FireHydrant.mdl");
		Hydrant:SetPos(v);
		Hydrant:Spawn();
		Hydrant:GetPhysicsObject():EnableMotion(false);
	end;
end;
timer.Simple(1, SpawnHydrants);