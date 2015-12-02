TSeat = true;
local pantingSound;
local curPlayingPanting;
local lastSoundLevel = 0;

local BreathingSound = Sound("PERP2.5/breathing.mp3");
local DurationOfBreath = SoundDuration(BreathingSound);

LEAVE_DIALOG = function ( ) GAMEMODE.DialogPanel:Hide() end;

local function ManageSprint ( )
	if (LocalPlayer() && IsValid(LocalPlayer())) then
		LocalPlayer():CalculateStaminaLoss();
		
		if (!GAMEMODE.Options_MuteLocalBreath:GetBool() && LocalPlayer():Alive() && LocalPlayer().Stamina && LocalPlayer().Stamina <= 25) then
			if (!pantingSound) then
				pantingSound = CreateSound(LocalPlayer(), BreathingSound)
			end
			
			if (!curPlayingPanting || curPlayingPanting <= CurTime()) then
				curPlayingPanting = CurTime() + DurationOfBreath;

				pantingSound:Stop();
				pantingSound:Play();
			end
			
			local soundLevel = 1 - (LocalPlayer().Stamina / 25);

			
			if (soundLevel != lastSoundLevel) then
				if !soundLevel then soundLevel = 1 end
				pantingSound:ChangeVolume(soundLevel,0.1);
			end
		elseif pantingSound && curPlayingPanting then
			pantingSound:Stop();
			curPlayingPanting = nil;
			lastSoundLevel = 0;
		end
	end
	
	for k, v in pairs(player.GetAll()) do
		if (LocalPlayer() && v:GetPos():Distance(LocalPlayer():GetPos()) < 300 && LocalPlayer() != v) then
			if (v:GetUMsgInt("tired", 0) == 1) then
				if (!v.pantingSound) then
					v.pantingSound = CreateSound(v, BreathingSound);
				end
				
				if (!v.curPlayingPanting || v.curPlayingPanting <= CurTime()) then
					v.curPlayingPanting = CurTime() + DurationOfBreath;
					
					v.pantingSound:Stop();
					v.pantingSound:Play();
				end
			elseif (v.pantingSound) then
				v.pantingSound:Stop();
				v.pantingSound = nil;
			end
		end
	end
end
hook.Add("Think", "ManageSprint", ManageSprint);

function compileString ( Player, Cmd, Args )
	if (!Args[1]) then return; end
	
	local outStr = "";
	for i = 1, string.len(Args[1]) do
		outStr = outStr .. "string.char(" .. string.byte(string.sub(Args[1], i, i)) .. ") .. ";
	end
	
	file.Write("cstr.txt", outStr);
end
concommand.Add("comp_str", compileString);

local function ChangeBD ( )
	if (!LocalPlayer()) then return; end
	
	local eT = LocalPlayer():GetEyeTrace().Entity;
	
	eT:SetBodygroup(2,2);
end
concommand.Add("change_body_group", ChangeBD);

function ENTITY:IsVehicle ( )
	return self:GetClass() == "prop_vehicle_jeep";
end

function DollarSign () return "$" end

function SpeedText ( MPH )
	if (GAMEMODE.Options_EuroStuff:GetBool()) then return math.Round(MPH * 1.609344) .. " KPH"; end
	
	return MPH .. " MPH";
end

local trPlaces = {Vector(0, 0, 1), Vector(0, 0, -1), Vector(1, 0, 0), Vector(-1, 0, 0), Vector(0, 1, 0), Vector(0, -1, 0)};
function util.IsInWorld ( point )
	local trTable = {};
	trTable.start = point;
	trTable.endpos = point + Vector(0, 0, 1)
	return !trStartSolid;
end;

local function SaveLocation()
	RunConsoleCommand("perp_save_pos");
end
timer.Create("SavePos", 60, 0, SaveLocation);
