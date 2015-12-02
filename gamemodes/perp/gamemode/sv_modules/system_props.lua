

GM.Props = {}
GM.Files = {}


function GM.LoadFiles()
	local props = file.Find("/perp3_props/*.txt","DATA")
	if props then
		for k, v in pairs(props) do 
			table.insert(GAMEMODE.Files,"/perp3_props/" .. v);
			Msg("Loaded Prop File: /perp3_props/" .. v .. "\n");
		end
	end
GAMEMODE.ParseFiles()
end
timer.Simple(5, GM.LoadFiles)
  
function GM.ParseFiles()

	for k,v in pairs(GAMEMODE.Files)do
	
	local buffer = file.Read(v,"DATA")
	local entities = string.Explode("\n", buffer)
	for k,v in pairs(entities) do
		local entity = string.Explode(";", v)
		if type(entity[7]) == "string" then
		
		local pos = Vector(tonumber(entity[1]),tonumber(entity[2]),tonumber(entity[3]))
		local angle = Angle(tonumber(entity[4]) or 0, tonumber(entity[5]) or 0, tonumber(entity[6]) or 0)
		local model = tostring(entity[7])
		local class = tostring(entity[8])
		
		table.insert(GAMEMODE.Props, {pos,angle,model,class})
		end
	end
	end
	GAMEMODE.SpawnProps()
end

function GM.SpawnProps()
	for k,v in pairs(GAMEMODE.Props) do
		local ent = ents.Create('ent_map_prop')
		ent:SetModel(v[3])
		ent:SetPos(v[1])
		ent:SetAngles(v[2])
		ent:Spawn()
/**
		local entphys = ent:GetPhysicsObject();
		if entphys:IsValid() then
		entphys:EnableGravity(false);
		entphys:Wake();
		end		
**/
	end
	
	Msg(tostring(#GAMEMODE.Props) .. " Registered.\n")
end

function SpawnProp(ply,cmd,args)
	local ent = ents.Create("prop_dynamic")
	ent:SetModel("models/props_interiors/bathtub01a.mdl")
	ent:SetPos(Vector(-6233, -6360, 71))
	ent:SetAngle(0,0,90)
	ent:Spawn()
end
concommand.Add("perp_d_spawn", SpawnProp)