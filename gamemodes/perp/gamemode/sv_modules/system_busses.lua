


local BusBeginSpawn = 	{
							Vector(309, 13559, 90.4), Angle(0, -90, 0)
						}

local BusStopSpawns = 	{
							{Vector(-6370, -4671, 72), Angle(0, 0, 0)},
							{Vector(-8278, -9024, 74), Angle(0, 180, 0)},
							{Vector(-5000, 12435, 185), Angle(0, 180, 0)},
							{Vector(875, 13176, 75), Angle(0, 180, 0)},
							{Vector(115, 13176, 75), Angle(0, 0, 0)},
							{Vector(3792, -6097, 58), Angle(0, 90, 0)},
							{Vector(-2639, -995, 68), Angle(0, 90, 0)},
							{Vector(387, 5976, 68), Angle(0, 180, 0)},
						}	
					
					
local function SpawnBus ( )
/*
	local e = ents.Create("bushalt")
	e:SetModel("models/perp2.5/bushalt1.mdl")
	e:SetPos(BusBeginSpawn[1])
	e:SetAngles(BusBeginSpawn[2])
	e:Spawn()
	e:Activate()

	for k, v in pairs(BusStopSpawns) do
		local e = ents.Create("bushalt")
		e:SetModel("models/sickness/busstop_01.mdl")
		e:SetPos(v[1])
		e:SetAngles(v[2])
		e:Spawn()
		e:Activate()
	end
*/
end;
timer.Simple(1, SpawnBus);