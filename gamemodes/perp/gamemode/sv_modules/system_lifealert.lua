


function ENTITY:GetZoneName ( )
	local lifeAlertZone;
	local pPos = self:GetPos();
	
	for k, v in pairs(GAMEMODE.LifeAlert) do
		local minVec = Vector(math.Min(v[2].x, v[3].x), math.Min(v[2].y, v[3].y), math.Min(v[2].z, v[3].z));
		local maxVec = Vector(math.Max(v[2].x, v[3].x), math.Max(v[2].y, v[3].y), math.Max(v[2].z, v[3].z));
		
		if (pPos.x >= minVec.x && pPos.y >= minVec.y && pPos.z >= minVec.z && pPos.x <= maxVec.x && pPos.y <= maxVec.y && pPos.z <= maxVec.z) then
			lifeAlertZone = v[1];
			break;
		end
	end
	
	if (!lifeAlertZone) then Msg("Life alert zone not found for '" .. tostring(pPos) .. "'.\n"); end
	
	return lifeAlertZone;
end

function PLAYER:BroadcastLifeAlert ( )
	local lifeAlertZone = self:GetZoneName();
	
	if (!lifeAlertZone) then return; end
		
	GAMEMODE:PlayerSay(self, "/911 [Life Alert] An accident has occured at " .. lifeAlertZone .. ".", true, false);
end

GM.LifeAlert = 	{
					// Tunnels
					{"the City-Junction Tunnel", Vector(-5764.0313, -3486.4773, 70.9047), Vector(-6243.9688, -1408.4537, 318.8611)},
					{"the UM-Junction Tunnel", Vector(-5219.3721, 614.9688, 318.8607), Vector(-4740.0313, 4114.8452, 64.5190)},
					{"the Industrial-Junction Tunnel", Vector(-203.1712, 614.9688, 319.0378), Vector(275.9688, 2879.3359, 66.5753)},
					{"the Outlands-Junction Tunnel", Vector(-1206.9688, -1406.9120, 319.2815), Vector(-727.0313, -4766.9912, 65.5102)},
					{"the Forest-Suburbs Tunnel", Vector(11809.8516, 5496.2520, 319.9688), Vector(12287.9688, 11258.9121, 65.9705)},
					{"the UM-Suburbs Tunnel", Vector(-7429.4316, 10397.0313, 441.0585), Vector(-7939.9688, 10174.7441, 186.5152)},
					
					
					// City
					{"Kentucky Friend Chicken", Vector(-6246.1431, -5204.2129, 64.0313), Vector(-7627.9688, -3936.8569, 710.1341)},
					{"the BP Station", Vector(-6255.8945, -5688.7749, 64.0313), Vector(-7431.7856, -7444.1382, 434.0313)},
					{"Bank of America", Vector(-6242.5786, -8032.7383, 64.0312), Vector(-7431.7856, -7444.1382, 434.0313)},
					{"Metro Cafe", Vector(-5164.4624, -6159.9688, 199.8826), Vector(-5676.1123, -5776.6108, 72.0313)},
					{"Giga Computer", Vector(-5672.0479, -6543.9688, 191.6583), Vector(-5164.8271, -6164.0313, 72.3005)},
					{"Main Street Boutique", Vector(-5671.9688, -6548.2637, 199.0131), Vector(-5164.0313, -6927.0337, 72.8944)},
					{"the Flea Market", Vector(-3851.5959, -6583.4116, 581.9688), Vector(-2404.3896, -5128.0313, 198.4103)},
					{"Cub Foods", Vector(-3851.2109, -8183.5439, 581.9688), Vector(-2404.0313, -6592.9033, 199.1565)},
					{"City Shop #2", Vector(-4658.5459, -6254.0313, 331.4819), Vector(-5599.0381, -6925.3901, 204.0313)},
					{"City Shop #1", Vector(-4658.0313, -5782.1372, 331.1591), Vector(-5599.0459, -6124.9312, 204.0313)},
					{"the Sky Scraper", Vector(-5674.8135, -8612.9688, 73.2748), Vector(-3629.0637, -9669.0313, 1727.6929)},
					{"the City Parking Garage", Vector(-5667.4810, -9965.0313, 256.6019), Vector(-3636.0313, -10732.7881, 71.0554)},
					{"the Penthouse Apartment", Vector(5615.5747, -12985.9688, 493.9517), Vector(6621.4321, -12490.0313, 368.6328)},
					{"the Car Paint Shop", Vector(-9619.2705, -9629.0313, 255.2219), Vector(-8988.6230, -10420.9688, 72.5311)},
					
					{"Slums Shop #1", Vector(-8291.9688, -10259.8291, 199.3192), Vector(-7748.0313, -9837.1943, 72.4427)},
					{"Slums Shop #2", Vector(-7748.3237, -10844.9688, 323.2253), Vector(-8291.4307, -9837.0313, 204.2338)},
					{"Slums Shop #2", Vector(-7748.0313, -10269.3252, 199.0714), Vector(-8163.9688, -10412.7227, 72.1656)},
					{"Slums Shop #3", Vector(-8291.9688, -10421.9717, 197.4464), Vector(-7748.0313, -10844.6465, 72.9328)},
					{"the Slums Shops", Vector(-8300.0313, -10852.5254, 74.0382), Vector(-7739.9688, -9829.4150, 326.2478)},
					
					{"Slums Apartment Room #1", Vector(-9495.9688, -9611.8320, 255.5894), Vector(-9124.4648, -9369.0313, 136.7395)},
					{"Slums Apartment Room #2", Vector(-9495.5996, -9117.0313, 255.4958), Vector(-9124.4648, -9369.0313, 136.7395)},
					{"Slums Apartment Room #3", Vector(-9491.9688, -8972.1875, 255.0429), Vector(-9244.4668, -8733.5225, 136.0313)},
					{"Slums Apartment Room #4", Vector(-9491.3750, -8477.4023, 255.9688), Vector(-9244.4668, -8733.5225, 136.0313)},
					{"the Slums Apartments", Vector(-9115.9688, -9620.4414, 78.2890), Vector(-9619.9053, -8477.0313, 255.2920)},
					
					{"the Government Center Parking Garage", Vector(-6331.9688, -8612.9912, 73.9008), Vector(-8754.6533, -9483.7021, -375.9688)},
					{"the Government Center Basement", Vector(-7895.9688, -8736.5967, -1924.8534), Vector(-6464.0469, -7686.1875, -2591.9688)},
					{"the Government Center", Vector(-6331.9688, -8612.9912, 73.9008), Vector(-8359.6152, -9650.9297, 2820.7910)},
					
					{"City Apartments Room #100", Vector(-5099.4082, -7508.9688, 327.8414), Vector(-4660.6748, -7077.5923, 336.0313)},
					{"City Apartments Room #101", Vector(-5228.3691, -7077.0313, 326.9897), Vector(-5667.9688, -7508.8564, 336.0313)},
					{"City Apartments Room #102", Vector(-5099.1416, -7948.9688, 327.4092), Vector(-4660.0313, -7517.1450, 336.0313)},
					{"City Apartments Room #103", Vector(-5228.0313, -7517.8140, 327.9484), Vector(-5667.9688, -7948.4282, 336.0313)},
					{"City Apartments Room #200", Vector(-5099.4082, -7508.9688, 463.9688), Vector(-4660.6748, -7077.5923, 336.0313)},
					{"City Apartments Room #201", Vector(-5228.3691, -7077.0313, 463.9688), Vector(-5667.9688, -7508.8564, 336.0313)},
					{"City Apartments Room #202", Vector(-5099.1416, -7948.9688, 463.9688), Vector(-4660.0313, -7517.1450, 336.0313)},
					{"City Apartments Room #203", Vector(-5228.0313, -7517.8140, 463.9688), Vector(-5667.9688, -7948.4282, 336.0313)},
					{"City Apartments Room #300", Vector(-5099.4082, -7508.9688, 599.9688), Vector(-4660.6748, -7077.5923, 472.0313)},
					{"City Apartments Room #301", Vector(-5228.3691, -7077.0313, 599.9688), Vector(-5667.9688, -7508.8564, 472.0313)},
					{"City Apartments Room #302", Vector(-5099.1416, -7948.9688, 599.9688), Vector(-4660.0313, -7517.1450, 472.0313)},
					{"City Apartments Room #303", Vector(-5228.0313, -7517.8140, 599.9688), Vector(-5667.9688, -7948.4282, 472.0313)},
					{"the City Apartments", Vector(-5667.5664, -6941.0313, 599.5629), Vector(-4660.9043, -7948.6729, 200.0313)},
					
					{"Tides Hotel Room #1", Vector(-4684.9688, -4856.3481, 321.9185), Vector(-5102.9688, -5111.7451, 208.6380)},
					{"Tides Hotel Room #1", Vector(-4690.9688, -4989.0742, 326.5301), Vector(-4431.0942, -5111.5171, 208.0313)},
					{"Tides Hotel Room #2", Vector(-4119.0313, -4352.5078, 327.0667), Vector(-4414.3052, -4855.9688, 208.6610)},
					{"Tides Hotel Room #3", Vector(-4110.9688, -4855.8564, 327.6319), Vector(-3655.0313, -4352.3062, 208.0000)},
					{"the Tides Hotel Lobby", Vector(-5455.0313, -4862.3198, 72.6536), Vector(-4423.8271, -4360.0313, 455.9032)},
					{"the Tides Hotel", Vector(-5676.0313, -5119.6455, 74.0910), Vector(-3646.9688, -4097.9009, 832.8479)},
					
					{"Main Street", Vector(-5719.0313, -3490.3699, 72.6370), Vector(-6344.6328, -11496.9688, 463.7588)},
					{"the City Slums", Vector(-7355.7373, -7957.0313, 318.0265), Vector(-9497.5488, -11509.0313, 73.5651)},
					{"the City", Vector(-3135.0129, -5119.9688, 3000), Vector(-9497.5488, -11509.0313, -2500)},
					
					// Exchange
					{"the Junction Warehouse", Vector(-1825.3981, -361.7719, 288.7318), Vector(-4188.9131, 615.0000, 64.4348)},
					{"the Junction", Vector(-6563.0044, -1408.4941, 667.5457), Vector(553.4925, 608.2149, 50)},
					
					// Industrial Zone
					{"the MTL Complex", Vector(4276.0313, 5376.1606, 512.0801), Vector(532.6259, 8120.5762, 63.0404)},
					{"the Power Plant", Vector(2869.1091, 4607.0313, 701.2580), Vector(4263.1411, 3595.0313, 64.4830)},
					{"the Industrial Warehouse", Vector(2098.3638, 3582.9688, 567.2377), Vector(435.9688, 4606.4268, 68.4741)},
					{"the Industrial Zone", Vector(-716.8180, 2879.0000, 669.4042), Vector(5392.9546, 9193.5645, 60)},
					
					// Sickness Road Area
					{"the Old Inn", Vector(-591.2158, -6685.8267, 188.9688), Vector(-1622.9688, -6014.3623, 62.3013)},
					{"the Bar", Vector(12064.9688, -34.6617, 204.7520), Vector(11561.0313, 467.1471, 73.9404)},
					{"Sickness Road", Vector(-1753.6481, -4742.0313, 674.7412), Vector(8396.9775, -6708.9014, 60)},
					{"Forest Road", Vector(8414.3809, -6691.6226, 664.1188), Vector(6539.4580, 5468.7783, 60)},
					{"Forest Road", Vector(12548.8789, 3604.0818, 667.7830), Vector(6539.4580, 5468.7783, 60)},
					{"EvoCity State Forest", Vector(12548.8789, 3604.0818, 667.7830), Vector(7998.6572, -642.5778, 60.9937)},
					{"the Radio Station", Vector(6388.8501, -6749.3306, 669.4750), Vector(4246.7324, -8763.5283, 70.0909)},
					{"the Swimming Pool", Vector(2114.7710, -6683.0957, 606.2475), Vector(4246.7324, -8763.5283, 70.0909)},
					{"Big Bill Hell's", Vector(2399.0264, -4847.8892, 60), Vector(8455.0186, -2768.3093, 668.6873)},
					
					// Lake Area
					{"Suburbs House #3", Vector(-4272.3657, 13712.9688, 315.6692), Vector(-4654.7480, 14225.0313, 186.6754)},
					{"Suburbs House #4", Vector(-3312.8579, 13712.9688, 314.0014), Vector(-3694.6563, 14225.0313, 185.9095)},
					{"Suburbs House #5", Vector(-3311.9968, 12255.0469, 313.4655), Vector(-3696.0313, 11743.8613, 181.2888)},
					{"Suburbs House #6", Vector(-4271.9688, 11743.7852, 316.2161), Vector(-4656.0313, 12254.5029, 186.7185)},
					{"Lake House #1", Vector(-5704.2461, 12495.9688, 362.6231), Vector(-6088.0313, 13134.4287, 188.8057)},
					{"Lake House #2", Vector(-6273.5640, 14439.9688, 363.3763), Vector(-5889.9688, 15076.9268, 187.7479)},
					{"the Lake Neighborhood", Vector(-9582.9971, 10386.2295, 669.8423), Vector(1046.5725, 15262.5264, 60.3583)},
					
					// Suburbs
					{"Suburbs House #2", Vector(6263.6284, 14208.2314, 317.5310), Vector(5622.8276, 13816.1689, 61.1567)},
					{"Suburbs House #1", Vector(10452.5664, 13756.9688, 320.7454), Vector(9940.9688, 14525.2715, 59.4056)},
					{"the Suburbs", Vector(12872.3896, 11283.7266, 665.2120), Vector(1046.5725, 15262.5264, 60.3583)},
				};
