

local ITEM = {};

ITEM.ID = 83;
ITEM.Reference = "drug_shroom"
ITEM.Weight = 10;
ITEM.Cost = 200;
ITEM.MaxStack = 500;
ITEM.Name = '"Magic" Mushrooms';
ITEM.Description = "I wouldn't eat these\nby themselves...\n\nUse to eat.\nDrop to plant.";

ITEM.InventoryModel = "models/fungi/sta_skyboxshroom1.mdl";
ITEM.WorldModel = "models/fungi/sta_skyboxshroom1.mdl";
ITEM.ModelCamPos = Vector(16, 30, 20);
ITEM.ModelLookAt = Vector(0, 0, 14);
ITEM.ModelFOV = 70;

ITEM.StopDropSounds = true;
ITEM.RestrictSelling = true;
ITEM.PredictUseDrop	= true;

if SERVER then

	function ITEM.OnUse ( Player )		
		umsg.Start('perp_do_shrooms', Player);
		umsg.End();
		
		return true;
	end
	
	function ITEM.OnDrop ( Player, Trace )
		if Player:IsGovernmentOfficial() then
			Player:Notify('You cannot do this as a government official!');
			return false;
		end
		
		local NumShroomsAlready = 0;
		for k, v in pairs(ents.FindByClass('ent_shroom')) do
			if v:GetTable().ItemSpawner and v:GetTable().ItemSpawner == Player then
				NumShroomsAlready = NumShroomsAlready + 1;
			end
		end
		
		local Max_Shroom = 10;
		if(Player:GetLevel() == 100) then
			Max_Shroom = Max_Shroom + 2;
		elseif(Player:GetLevel() == 99) then
			Max_Shroom = Max_Shroom + 4
		elseif(Player:GetLevel() == 98) then
			Max_Shroom = Max_Shroom + 6
		elseif(Player:GetLevel() == 97) then
			Max_Shroom = Max_Shroom + 8
		end
		
		if NumShroomsAlready >= Max_Shroom then
			Player:Notify("It looks like the soil can't handle any more vegitation.");
			return false;
		end
	
		local Trace = util.TraceLine(util.GetPlayerTrace(Player))
		
		if Trace.HitWorld and Trace.MatType == MAT_DIRT then
			local Shroom = ents.Create('ent_shroom');
			Shroom:SetPos(Trace.HitPos);
			Shroom:Spawn();
			Shroom:GetTable().ItemSpawner = Player;
			Shroom.pickupPlayer = Player;
			return true;
			
		else
			Player:Notify("You must plant these in soil!");
			return false;
		end
	end
	
	function ITEM.Equip ( Player )

	end
	
	function ITEM.Holster ( Player )

	end
	
else


	
end

if CLIENT then
		local TransitionTime = 6;
		local TimeLasting = 60;
		function ITEM.DoShrooms ( )
		surface.PlaySound('perp2.5/eating.mp3');
		
		timer.Simple(math.random(3, 7), function ( ) GAMEMODE.ShroomStart = CurTime() end);
		end
		usermessage.Hook('perp_do_shrooms', ITEM.DoShrooms);

	function ITEM.MakeEffects ( )
		if !GAMEMODE.ShroomStart then return; end
		
		local End = GAMEMODE.ShroomStart + TimeLasting + TransitionTime * 2;
		
		if End < CurTime() then return false; end
	
		local shroom_tab = {}
		shroom_tab["$pp_colour_addr"] = 0
		shroom_tab["$pp_colour_addg"] = 0
		shroom_tab["$pp_colour_addb"] = 0
		shroom_tab["$pp_colour_mulr"] = 0
		shroom_tab["$pp_colour_mulg"] = 0
		shroom_tab["$pp_colour_mulb"] = 0
		
		local TimeGone = CurTime() - GAMEMODE.ShroomStart;
		
		if TimeGone < TransitionTime then
			local s = GAMEMODE.ShroomStart;
			local e = s + TransitionTime;
			local c = CurTime();
			local pf = (c-s) / (e-s);
				
			shroom_tab["$pp_colour_colour"] =   1 - pf * 0.37
			shroom_tab["$pp_colour_brightness"] = -pf * 0.15
			shroom_tab["$pp_colour_contrast"] = 1 + pf * 1.57

			DrawColorModify(shroom_tab) 
			DrawSharpen(8.32, 1.03 * pf)
		elseif TimeGone > TransitionTime + TimeLasting then
			local e = End;
			local s = e - TransitionTime;
			local c = CurTime();
			local pf = 1 - (c - s) / (e - s);
				
			shroom_tab["$pp_colour_colour"] = 1 - pf * 0.37
			shroom_tab["$pp_colour_brightness"] = -pf * 0.15
			shroom_tab["$pp_colour_contrast"] = 1 + pf * 1.57
			
			DrawColorModify(shroom_tab) 
			DrawSharpen(8.32, 1.03 * pf)
		else
			shroom_tab["$pp_colour_colour"] = 0.63
			shroom_tab["$pp_colour_brightness"] = -0.15
			shroom_tab["$pp_colour_contrast"] = 2.57

			DrawColorModify(shroom_tab) 
			DrawSharpen(8.32,1.03)
		end
	end
	hook.Add("RenderScreenspaceEffects", "ITEM.MakeEffects_SHROOMS", ITEM.MakeEffects)
	
	function ITEM.OnDrop(  )
			local Trace = util.TraceLine(util.GetPlayerTrace(LocalPlayer()))
				if Trace.HitWorld and Trace.MatType == MAT_DIRT then
			return true;
			
		else
			return false;
		end
	end
	
		function ITEM.OnUse ( slotID )			
		return true;
	end
end


GM:RegisterItem(ITEM);