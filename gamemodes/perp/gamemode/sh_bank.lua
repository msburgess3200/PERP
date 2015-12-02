if SERVER then return end

function GM.OpenBank ( )
	if (GAMEMODE.BankIPanel) then 
		GAMEMODE.BankIPanel:Remove()
		GAMEMODE.BankIPanel = nil;
		gui.EnableScreenClicker(false);
	else
		gui.EnableScreenClicker(true);
		GAMEMODE.BankIPanel = vgui.Create("perp_bank");
	end
end

