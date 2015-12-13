///////////////////////////////
// © 2009-2010 Pulsar Effect //
//    All rights reserved    //
///////////////////////////////
// This material may not be  //
//   reproduced, displayed,  //
//  modified or distributed  //
// without the express prior //
// written permission of the //
//   the copyright holder.   //
///////////////////////////////


local FireHydrants = {
						Vector(-5714.232421875, -7911.0551757813, 72), 
						Vector(-7039.1655273438, -7534.3193359375, 72), 
						Vector(-7295.431640625, -5735.9267578125, 72), 
						Vector(-7205.376953125, -4466.921875, 72), 
						Vector(-5712.08203125, -4332.5288085938, 72), 
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
//timer.Simple(1, SpawnHydrants);