


local ITEM 					= {};

ITEM.ID 					= 26;
ITEM.Reference 				= "drug_beer";

ITEM.Name 					= "Beer";
ITEM.Description			= "Drink your worries away.";

ITEM.Weight 				= 5;
ITEM.Cost					= 200;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_junk/garbage_glassbottle002a.mdl";
ITEM.ModelCamPos 				= Vector(20, 0, 0);
ITEM.ModelLookAt 				= Vector(0, 0, 0);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_junk/garbage_glassbottle002a.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	local function RemoveDrankBeer ( Player )
		if Player and Player:IsValid() and Player:IsPlayer() then
			Player:GetTable().NumBeersDrank = Player:GetTable().NumBeersDrank - 1;
		end
	end
	
	function PLAYER:Puke ( )
		local Group = RecipientFilter();
		Group:AddPVS(self);
		Group:AddPlayer(self);

		umsg.Start('perp_puke', Group);
			umsg.Entity(self);
		umsg.End();
	end
	
	function GM:SetupMove ( Player, Move )
		if Player:Alive() and Player:GetTable().NumBeersDrank and Player:GetTable().NumBeersDrank > 0 then
			if Player:InVehicle() then
				if math.sin(CurTime() / 2) < -.8 and (!Player:GetTable().LastMod or Player:GetTable().LastMod != 1) then
					Player:GetTable().LastMod = 1
					Player:ConCommand("+moveright\n");
				elseif math.sin(CurTime() / 2) > .8 and (!Player:GetTable().LastMod or Player:GetTable().LastMod != 2) then
					Player:ConCommand("+moveleft\n");
					Player:GetTable().LastMod = 2
				elseif !Player:GetTable().LastMod or Player:GetTable().LastMod != 3 then
					Player:ConCommand("-moveright;-moveleft\n");
					Player:GetTable().LastMod = 3
				end
			else
				if Player:GetTable().LastMod then
					Player:ConCommand("-moveright;-moveleft\n");
					Player:GetTable().LastMod = nil;
				end
				
				Move:SetMoveAngles(Move:GetMoveAngles() + Angle(0, math.Clamp(math.sin(CurTime() * 2), -.75, .75) * math.Clamp((Player:GetTable().NumBeersDrank * 20), 0, 60), 0));
			end
		elseif Player:GetTable().LastMod then
			Player:ConCommand("-moveright;-moveleft\n");
			Player:GetTable().LastMod = nil;
		end
	end
	
	local function DrinkEffects ( )
		for k, v in pairs(player.GetAll()) do
			if v:Alive() and v:GetTable().NumBeersDrank and v:GetTable().NumBeersDrank >= 2 then
				v:GetTable().NextBarf = v:GetTable().NextBarf or CurTime() + math.random(5, 10);
				
				if v:GetTable().NextBarf < CurTime() then
					v:GetTable().NextBarf = CurTime() + math.random(20, 45);
					
					v:Puke();
				end
			elseif v:GetTable().NextBarf then
				v:GetTable().NextBarf = nil;
			end
		end
	end
	hook.Add('Think', 'DrinkEffects', DrinkEffects);

	function ITEM.OnUse ( Player )	
		Player:GiveItem(27, 1);
		
		Player:GetTable().NumBeersDrank = Player:GetTable().NumBeersDrank or 0;
		Player:GetTable().NumBeersDrank = Player:GetTable().NumBeersDrank + 1;
		timer.Simple(60, function() RemoveDrankBeer(Player) end );
		
		if Player:GetTable().NumBeersDrank > 6 and math.random(1, 3) == 1 then
			Player:Notify("You have been hit with alcohol poisoning! I hope you get help soon!");
			Player:Kill();
		end
	
		return true;
	end
	
	function ITEM.OnDrop ( Player )
		return true;
	end
	
	function ITEM.Equip ( Player )

	end
	
	function ITEM.Holster ( Player )

	end
	
else
	function ITEM.MakeEffects ( )
		if !GAMEMODE.NumDrunk or GAMEMODE.NumDrunk == 0 then return false; end
 		DrawMotionBlur(math.Clamp(.04 - .005 * (GAMEMODE.NumDrunk - 1), .01, .035), math.Clamp(GAMEMODE.NumDrunk * .2, .1, 1), 0);
	end
	hook.Add("RenderScreenspaceEffects", "ITEM.MakeEffects_BEER", ITEM.MakeEffects)
	
	function GM.Puke ( UMsg )
		local Player = UMsg:ReadEntity();

		if Player and Player:IsValid() and Player:IsPlayer() then
			local effectdata = EffectData();
			effectdata:SetEntity(Player);
			util.Effect("vomit", effectdata);
		end
	end
	usermessage.Hook('perp_puke', GM.Puke)

	function ITEM.OnUse ( slotID )	
		LocalPlayer():GiveItem(27, 1);
	
		GAMEMODE.NumDrunk = GAMEMODE.NumDrunk or 0;
		GAMEMODE.NumDrunk = GAMEMODE.NumDrunk + 1;
		surface.PlaySound('PERP2.5/drinking.mp3');
		timer.Simple(60, function ( ) GAMEMODE.NumDrunk = GAMEMODE.NumDrunk - 1; end);
		
		return true;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);