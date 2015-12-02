


NPC_DATABASE = {};

if SERVER then
	function GM.NPCUsed ( Player, ID )
		umsg.Start("perp_npc_used", Player);
			umsg.Short(ID);
		umsg.End();
	end
	
	function GM:LoadNPC ( NPCTable )
		Msg("\t-> Loaded " .. NPCTable.Name .. " [ID: " .. NPCTable.ID .. "]\n");
		
		local locationsTable = NPCTable.Location;
		local anglesTable = NPCTable.Angles;
		
		if (type(locationsTable) != "table") then locationsTable = {locationsTable}; end
		if (type(anglesTable) != "table") then anglesTable = {anglesTable}; end
		
		if (#locationsTable != #anglesTable) then
			Msg("\t\tWarning: Locations and angles tables not the same size.\n");
		end
		
		NPCTable.NPCs = {};
		
		for k, v in pairs(locationsTable) do
			if (anglesTable[k]) then
				local NPC = ents.Create("npc_vendor");
				NPC.Entity:SetModel(NPCTable.Model);
				NPC.NPCID = NPCTable.ID;
				NPC:SetPos(v);
				NPC:SetAngles(anglesTable[k]);
				
				if (NPCTable.Invisible) then
					NPC:SetColor(Color(255, 255, 255, 0));
					NPC:SetNoDraw(true)
				else
					NPC:SetColor(Color(255, 255, 255, 255));
				end;
				
				if NPCTable.ShowChatBubble == "Normal" then
					NPC:MakeChatBubble();
				elseif NPCTable.ShowChatBubble == "VIP" then
					NPC:MakeVIPChatBubble();
				end;
				
				NPC:Spawn();
				
				NPC:InitializeAnimation(NPCTable.Sequence);
				
				table.insert(NPCTable.NPCs, NPC);
			end
		end
		
		NPC_DATABASE[NPCTable.ID] = NPCTable;
	end
	
	function PLAYER:NearNPC ( NPCID )
		for k, v in pairs(ents.FindByClass("npc_vendor")) do
			if (v.NPCID == NPCID) then
				if (self:GetPos():Distance(v:GetPos()) < 500) then
					return true;
				else
					return false;
				end
			end
		end
		return false;
	end
else
	function GM:LoadNPC ( NPCTable )
		Msg("\t-> Loaded " .. NPCTable.Name .. " [ID: " .. NPCTable.ID .. "]\n");
		NPC_DATABASE[NPCTable.ID] = NPCTable;
	end
	
	local function NPCUsed ( UMsg )
		local ID = UMsg:ReadShort();
		
		local NearestNPC;
		local NearestPos = 9999;
		for k, v in pairs(ents.FindByClass("npc_vendor")) do
			local Dist = v:GetPos():Distance(LocalPlayer():GetPos());
			if (Dist < NearestPos) then
				NearestPos = Dist;
				NearestNPC = v;
			end
		end		
		NPC_DATABASE[ID].OnTalk(LocalPlayer());
	end
	usermessage.Hook("perp_npc_used", NPCUsed);
end
