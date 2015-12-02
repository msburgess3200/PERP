
resource.AddFile("sound/earthquake.mp3")
util.PrecacheSound("earthquake.mp3")

local next_update_time
local tremor = ents.Create("env_physexplosion")
tremor:SetPos(Vector(0,0,0))
tremor:SetKeyValue("radius",9999999999)
tremor:SetKeyValue("spawnflags", 7)
tremor:Spawn()

if (SERVER) then
    CreateConVar("sv_earthquake", 1)
    CreateConVar("sv_earthquake_chance_is_1_in", 500)
end

for k, v in pairs(player.GetAll()) do
	v:Notify("Earthquake gamescripts have been loaded.");
	if v:IsSuperAdmin() then
		v:Notify("To send an earthquake use 'perp_earthquake' or set 'sv_earthquake' to 1 for random earthquakes.")
		v:ChatPrint("To send an earthquake use 'perp_earthquake' or set 'sv_earthquake' to 1 for random earthquakes.")
	end
end

function EarthquakeCMD(pl, cmd, args)
	if pl and pl:IsValid() and !pl:IsSuperAdmin() then return false end
	Earthquake()
end
concommand.Add('perp_earthquake', EarthquakeCMD)

function Earthquake()
	local force = math.random(10,1000)
    tremor:SetKeyValue("magnitude",force/6)
    for k,v in pairs(plys) do
        v:EmitSound("earthquake.mp3", force/6, 100)
    end
    tremor:Fire("explode","",0.5)
    util.ScreenShake(Vector(0,0,0), force, math.random(25,50), math.random(5,12), 9999999999)
    for k,e in pairs(en) do
        local rand = math.random(650,1000)
        if (rand < force and rand % 2 == 0) then
            e:Fire("enablemotion","",0)
            constraint.RemoveAll(e)
        end
        if (e:IsOnGround()) then
            e:TakeDamage((force / 100) + 5, game.GetWorld())
        end
    end
end

function EarthquakeRandom()
	local en = ents.FindByClass("prop_physics")
    local plys = ents.FindByClass("player")
    if (math.random(0, GetConVarNumber("sv_earthquake_chance_is_1_in")) < 1) then
        Earthquake()
	end
    next_update_time = CurTime() + 1
end

function EarthquakeThink()
    if (GetConVarNumber("sv_earthquakes") ~= 1) then return end
	if ( CurTime() > ( next_update_time or 0 ) ) then
        EarthquakeRandom()
	end
end
hook.Add('Think', 'Earthquake', EarthquakeThink)