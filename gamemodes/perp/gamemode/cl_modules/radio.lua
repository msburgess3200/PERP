


Msg("Loading bass module... ");
--require("bass");

if (BASS) then
	Msg("done!\n");
else
	Msg("failed!\n");
end 

function WTFBASS()
	if (BASS) then
		Msg("done!\n");
	else
		Msg("failed!\n");
	end 
end
concommand.Add("istherebass", WTFBASS)
	
local FarDistance = 2000;
local StreamTable = {};
local ZeroVector = Vector(0, 0, 0);
local SupressError;
local RadioMsg;
local RadioTime;
local RadioID;

local function cleanupRadios ( )
	for k, v in pairs(StreamTable) do
		if (v && v[1] && v[1].stop) then
			v[1]:stop();
		end
	end
end
hook.Add("StreamTable", "cleanupRadios", cleanupRadios);

local function shutdownRadio ( )
	Msg("Shutting down bass module...\n");
	
	for k, v in pairs(StreamTable) do
		v[1]:stop();
		StreamTable[k] = nil;
	end
end
hook.Add("ShutDown", "shutdownRadio", shutdownRadio);

local function DestroyStreamTable ( Table )
	for k, v in pairs(StreamTable) do
		if v == Table then
			v = nil;
			StreamTable[k] = nil;
			return true;
		end
	end
	
	return false;
end

local function PopNewStation ( Table, NewStation, NewChannel )
	if !GAMEMODE.RadioStations[NewStation][2] then DestroyStreamTable(Table) return false; end
	
	Table[3] = NewStation;
	
	BASS.StreamFileURL(GAMEMODE.RadioStations[NewStation][2], 0, 
		function( BassChannel, Err)
			if !BassChannel then		
				if !SurpressError then
					if Err == 40 || Err == 2 then
						LocalPlayer():PrintMessage(HUD_PRINTTALK, "Error initializing music stream. Your client timed out.");
					elseif Err == 41 then
						LocalPlayer():PrintMessage(HUD_PRINTTALK, "Error initializing music stream. Unsupported file type.");
					elseif Err == 8 then
						LocalPlayer():PrintMessage(HUD_PRINTTALK, "Error initializing music stream. BASS module initialization failure.");
					else
						LocalPlayer():PrintMessage(HUD_PRINTTALK, "Error initializing music stream. Unknown error " .. tostring(Err) .. ".");
					end
					
					SurpressError = true;
				end
				
				DestroyStreamTable(Table);
				
				return;
			end

			if Table and Table[3] == NewStation and IsValid(Table[2]) then
				Table[1] = BassChannel
				Table[1]:set3dposition(Table[2]:GetPos(), ZeroVector, ZeroVector)
				Table[1]:play()
			else
				BassChannel:stop();
				BassChannel = nil;
			end
		end
	);
end

local function MonitorRadios ( )
	// make sure we got BASS initiated, if not, unhook us
	if !BASS then
		LocalPlayer():PrintMessage(HUD_PRINTTALK, "You must install the BASS module to interact with radios. It can be found on our website!");
		hook.Remove('Think', 'MonitorRadios');
		return;
	end
	
	// tell bass where we are
	local EyePosition = LocalPlayer():EyePos();
	//EyePosition.z = -EyePosition.z;
	local Velocity = LocalPlayer():GetVelocity();
	local EyeAngs = LocalPlayer():GetAimVector():Angle();
	EyeAngs.p = math.Clamp(EyeAngs.p, -89, 88.9);
	local Forwards = EyeAngs:Forward()
	local Ups = EyeAngs:Up() * -1
	
	local adjUp = (1 - (GAMEMODE.Options_RadioVolume:GetInt() / 100)) * 250
	EyePosition.z = EyePosition.z + adjUp;
	
	BASS.SetPosition(EyePosition, Velocity * 0.005, Forwards, Ups)
	
	// Find all props that could possibly be pushing music
	local RadioProps = {};
	
	for k, v in pairs(ents.FindByClass('ent_prop_item')) do
		if (v:GetModel() == "models/props/cs_office/radio.mdl") then
			local Dist = v:GetPos():Distance(LocalPlayer():GetShootPos());
					
			if (v:GetNetworkedInt('perp_station', 0) != 0 and Dist <= FarDistance) then
				table.insert(RadioProps, {v, Dist});
			end
		end
	end
	
	for k, v in pairs(ents.FindByClass('prop_vehicle_jeep')) do
		local Dist = v:GetPos():Distance(LocalPlayer():GetShootPos());
		
		local vehicleTable = lookForVT(v);
		
		if (vehicleTable && !vehicleTable.requiredClass and v:GetNetworkedInt('perp_station', 0) != 0 and Dist <= FarDistance) then
			table.insert(RadioProps, {v, Dist});
		end
	end
		
	// Get all the radios we should be acting on.
	local TopXSpots = {};
	local NumStreams = math.Clamp(table.Count(RadioProps), 0, GAMEMODE.Options_NumRadioStreams:GetInt());
	
	if table.Count(RadioProps) != 0 then
		for i = 1, NumStreams do
			local ClosestPick, ClosestDist, ClosestPickID = nil, (FarDistance + 1), nil;
			
			for k, v in pairs(RadioProps) do
				if v[2] < ClosestDist then
					ClosestDist = v[2];
					ClosestPick = v[1];
					ClosestPickID = k;
				end
			end
			
			if ClosestPick then
				table.insert(TopXSpots, ClosestPick);
				RadioProps[ClosestPickID] = nil;
			end
		end
	end
	
	// validate each stream. if its not from one of our closest X, block it.
	for k, v in pairs(StreamTable) do
		local ValidStream = false;
		
		for num, prop in pairs(TopXSpots) do
			if prop == v[2] then
				ValidStream = true;
				TopXSpots[num] = nil;
			end
		end
		
		if !ValidStream then
			if v[1] and v[1].stop then
				// stop the stream
				v[1]:stop();
				v[1] = nil;
			end
			
			StreamTable[k] = nil;
			v = nil;
		else
			// perform upkeep. see if we're still on the same station, etc.
			if v[2]:GetNetworkedInt('perp_station', 0) == 0 then
				// stop the stream
				v[1]:stop();
				v[1] = nil;
				
				StreamTable[k] = nil;
			elseif v[3] != v[2]:GetNetworkedInt('perp_station', 0) then
				// we're supposed to be on a different station! stop the stream
				if v[1] and v[1].stop then
					v[1]:stop();
					v[1] = nil;
				end
				
				// send a request for the new station.
				PopNewStation(v, v[2]:GetNetworkedInt('perp_station', 0), false);
				v[2]:EmitSound('PERP2.5/adjust_radio.mp3');
			elseif v[1] and v[1].set3dposition then
				// send location update.
				v[1]:set3dposition(v[2]:GetPos(), ZeroVector, ZeroVector)
			end
		end
	end
	
	// Make sure we have something to work with.
	if table.Count(TopXSpots) == 0 then return; end
	
	// see how many streams we have available...
	local NumStreamsAvailable = NumStreams - table.Count(StreamTable);
	
	// stop right now if we can't do anything new
	if NumStreamsAvailable == 0 then return; end
	
	// lets start tacking streams to the closest props.
	while NumStreamsAvailable > 0 do
		for k, v in pairs(TopXSpots) do
			local NewTable = {};
			NewTable[2] = v;
			NewTable[3] = 0;
			NewTable[1] = nil;
			table.insert(StreamTable, NewTable);
			PopNewStation(NewTable, v:GetNetworkedInt('perp_station', 0), true);
			
			
			NumStreamsAvailable = NumStreamsAvailable - 1;
			TopXSpots[k] = nil;
		end
	end
end
hook.Add('Think', 'MonitorRadios', MonitorRadios);

// Changing station text
local function GetSomeShit ( UMsg )
	RadioID = UMsg:ReadShort();
	RadioMsgTime = CurTime();
	
	if (RadioID == 0) then
		RadioMsg = "Radio Off";
	else
		RadioMsg = GAMEMODE.RadioStations[RadioID][1];
	end
end
usermessage.Hook('perp_rmsg', GetSomeShit);

local function DrawSomeShit ( ) 
	if RadioMsg and RadioMsgTime + 3 > CurTime() then
		if !BASS then
			LocalPlayer():PrintMessage(HUD_PRINTTALK, "You must install the BASS module to interact with radios. It can be found on our website!");
			RadioMsg = nil;
			RadioMsgTime = nil;
			return;
		end
	
		draw.SimpleText(RadioMsg, "MixturesWarningFont", ScrW() * .5 + math.random(-5, 5), ScrH() * .25 + math.random(-5, 5), Color(100, 0, 0, 200), 1, 1);
		draw.SimpleText(RadioMsg, "MixturesWarningFont", ScrW() * .5, ScrH() * .25, Color(200, 0, 0, 200), 1, 1);
	end
end
hook.Add('HUDPaint', 'RadioDrawSomeShit', DrawSomeShit);
