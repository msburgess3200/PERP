


local ITEM 					= {};

ITEM.ID 					= 120;
ITEM.Reference 				= "item_lawbook";

ITEM.Name 					= "Book of the Law";
ITEM.Description			= "This book sells you the current laws and limits.";

ITEM.Weight 				= 5;
ITEM.Cost					= 250;

ITEM.MaxStack 				= 100;

ITEM.InventoryModel 		= "models/props_lab/bindergreenlabel.mdl";
ITEM.ModelCamPos 				= Vector(1, -17, 6);
ITEM.ModelLookAt 				= Vector(0, 0, 5);
ITEM.ModelFOV 					= 70;
ITEM.WorldModel 			= "models/props_lab/bindergreenlabel.mdl";

ITEM.RestrictedSelling	 	= false; // Used for drugs and the like. So we can't sell it.

ITEM.EquipZone 				= nil;											
ITEM.PredictUseDrop			= true; // If this isn't true, the server will tell the client when something happens to us based on the server's OnUse

if SERVER then

	function ITEM.OnUse ( Player )		
		return false;
	end
	
	function ITEM.OnDrop ( Player )
		return true;
	end
	
	function ITEM.Equip ( Player )

	end
	
	function ITEM.Holster ( Player )

	end
	
else

	function ITEM.OnUse ( slotID )
		local str = [[
		<body background="http://www.parisfleamarkethfc.com/images/paper-background.jpg"> 
		<h1>The mayor has stated the following laws in town:</h1><br>
		Guns Are Illegal, Both Selling And Using, Only Pistols Can Be Used For Self Defence At Home.<br><br>
		Sales Tax Rate: ]] .. GAMEMODE.GetTaxRate_Sales () * 100 .. [[%<br>
		Income Tax Rate: ]] .. GAMEMODE.GetTaxRate_Income() * 100 .. [[%<br>
		Traffic Ticket Price: $]] .. GetGlobalInt("ticket_price") .. [[<br>
		Inner City Speedlimit: ]] .. GetGlobalInt("innercity_speedlimit_i") .. [[ MPH<br>
		Outter City Speedlimit: ]] .. GetGlobalInt("innercity_speedlimit_o") .. [[ MPH<br>


		<h1>The mayor has stated the following governmental job limits:</h1><br>
		Maximum police officer employment: ]] .. GAMEMODE.MaximumCops .. [[ player(s)<br>
		Maximum police officer salary: $]] .. GAMEMODE.PayDay_Police .. [[<br>
		Maximum police vehicle upkeep: ]] .. GAMEMODE.MaxCopCars .. [[ vehicle(s)<br>
		Maximum swat employment: ]] .. GAMEMODE.MaximumSWAT .. [[ player(s)<br>
		Maximum swat salary: $]] .. GAMEMODE.PayDay_SWAT .. [[<br>
		Maximum swat van upkeep: ]] .. GAMEMODE.MaxSWATVans .. [[ vehicle(s)<br>
		Maximum dispatcher salary: $]] .. GAMEMODE.PayDay_Dispatcher .. [[<br>

		Maximum fireman employment: ]] .. GAMEMODE.MaximumFireMen .. [[ player(s)<br>
		Maximum fireman salary: $]] .. GAMEMODE.PayDay_Fireman .. [[<br>
		Maximum fire engine upkeep: ]] .. GAMEMODE.MaxFireTrucks .. [[ vehicle(s)<br>
		Maximum paramedic employment: ]] .. GAMEMODE.MaximumParamedic .. [[ player(s)<br>
		Maximum paramedic salary: $]] .. GAMEMODE.PayDay_Medic .. [[<br>
		Maximum ambulance upkeep: ]] .. GAMEMODE.MaxAmbulances .. [[ vehicle(s)<br>
		]]

		local Frame = vgui.Create("DFrame")
		Frame:SetSize(ScrW() * 0.8, ScrH() * 0.8)
		Frame:Center()
		Frame:SetTitle("Book of the Law")
		Frame:MakePopup()
		
		local HTML = vgui.Create("HTML", Frame)
		HTML:StretchToParent(5, 27, 5, 5)
		HTML:SetHTML(str)
		
		return false;
	end
	
	function ITEM.OnDrop ( )
		return true;
	end
	
end

GM:RegisterItem(ITEM);