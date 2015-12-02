

/*
These are just some various commands that I use and I figured instead of putting them in little decrepit spots within the files I would just make one centralized location
*/

Debug = {}

function Debug.GatekeeperTotals(ply,cmd,args)
if(!ply:IsValid()) then print(gatekeeper.GetNumClients().total)
ply:Notify("Current Number of Clients" .. gatekeeper.GetNumClients().total)
end
end
concommand.Add("perp_d_gkt", Debug.GatekeeperTotals)

function Debug.AssRankingTable(ply,cmd,args)

rt = ASS_GetRankingTable()

if(!ply:IsValid()) then PrintTable(rt)
else
ply:PrintTable(rt)
end
end
concommand.Add("perp_d_art", Debug.AssRankingTable)

function Debug.SetDrugBuy(ply,cmd,args)
if (!ply:IsAdmin()) then return; end
if (!args[1]) then return; end

SetGlobalInt('perp_druggy_buy', tonumber(args[1]))
end
concommand.Add("perp_d_drugb", Debug.SetDrugBuy)



function Debug.SetDrugSell(ply,cmd,args)
if (!ply:IsAdmin()) then return; end
if (!args[1]) then return; end

SetGlobalInt('perp_druggy_sell', tonumber(args[1]))
end
concommand.Add("perp_d_drugs", Debug.SetDrugSell)

function Debug.GetPlayerInfo(ply,cmd,args)
if (!ply:IsAdmin()) then return; end
if (!args[1]) then return; end

print("Last Car: " .. ply:GetLastCar())
print("Last Car's Fuel: " .. (ply:GetLastCarF() or "0"))
print("Fuel Left: " .. ply:GetFuel())
print("First Name: " .. ply:GetUMsgString("rp_fname", "John"))
print("Full Name: " .. ply:GetRPName())
end
concommand.Add("perp_d_gpi", Debug.GetPlayerInfo)  

function Debug.SetPlayerFirstName(ply, cmd, args)
if (!ply:IsAdmin()) then return; end
if (!args[1]) then return; end
if (!args[2]) then return; end

target = FindPlayer(args[1])

if target then
	target:SetUMsgString("rp_fname", tostring(args[2]))
end
end
concommand.Add("perp_d_spfn", Debug.SetPlayerFirstName)

function Debug.WriteItemIDS(ply,cmd,args)

if(!ply:IsAdmin()) then return; end
buffer = ""
for k,v in pairs(ITEM_DATABASE) do
	buffer = buffer .. "\nID: " .. k .. " Name: " .. v.Name;
end
file.Write("items.txt" ,buffer)
end
concommand.Add("perp_d_outitems", Debug.WriteItemIDS)

function Debug.WritePropertyIDS(ply,cmd,args)
if(!ply:IsAdmin()) then return; end
buffer = ""
for k,v in pairs(PROPERTY_DATABASE) do
	buffer = buffer .. "\nID: " .. k .. " Name: " .. v.Name;
end
file.Write("properties.txt" ,buffer)
end
concommand.Add("perp_d_outproperties", Debug.WritePropertyIDS)

function Debug.WriteLocToFile(ply,cmd,args)
if !ply:IsAdmin() then ply:ChatMessage("Your not an admin!"); return end
if !args[1] then ply:ChatMessage("Give me a goddamn Name for this Location!") return end
//Let's create a buffer in case there's already a file, we'll just add onto it.
local buffer;
if (file.Exists("locations.txt","DATA")) then buffer = file.Read("locations.txt","DATA"); else buffer = "" end
//Position Vector
local pos = ply:GetPos()
local ang = ply:GetAngle()
//String to add to the buffer
local add = tostring(args[1]) .. "\nVector(" .. pos.x .. " , " .. pos.y .. " , " .. pos.z .. ")\n" .. "Angle(" .. ang.x .. "," .. ang.y .. "," .. ang.z ")\n";
buffer = buffer .. add
file.Write("locations.txt", buffer)

end
concommand.Add("perp_d_wlf", Debug.WriteLocToFile)

function Debug.GoToLocation(ply,cmd,args)
if !ply:IsAdmin() then ply:ChatMessage("You're not an admin!") return end

local x = args[1]
local y = args[2]
local z = args[3]

local pos = Vector(x,y,z)

ply:SetPos(pos)
end
concommand.Add("perp_d_gtl", Debug.GoToLocation)


