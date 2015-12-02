


local PANEL = {};

function PANEL:Init ( )
	self:SetVisible(true)
	self.ModelPanel = vgui.Create("DModelPanel", self);
	
	function self.ModelPanel:LayoutEntity ( ) end
	function self.ModelPanel.OnMousePressed ( _, mc ) self:OnMousePressed(mc) end
	function self.ModelPanel.OnMouseReleased ( _, mc ) self:OnMouseReleased(mc) end
	
	self.DownTime = 0;
end

function PANEL:PerformLayout ( )
	self.ModelPanel:InvalidateLayout();
	
	self.ModelPanel:SetPos(3, 3);
	self.ModelPanel:SetSize(self:GetWide() - 6, self:GetTall() - 6);
end

function PANEL:SetItemTable ( itemTable )	
	if !itemTable then
	return
	end
	self.itemTable = itemTable;
	
	self.ModelPanel:SetModel(itemTable.InventoryModel);
	
	self.ModelPanel:SetCamPos(itemTable.ModelCamPos)
	self.ModelPanel:SetLookAt(itemTable.ModelLookAt)
	self.ModelPanel:SetFOV(itemTable.ModelFOV)
	
	local iSeq = self.ModelPanel.Entity:LookupSequence('ragdoll');
	self.ModelPanel.Entity:ResetSequence(iSeq);
end

function PANEL:Think ( )
	if (self.mouseDown) then
		if (!input.IsMouseDown(self.mouseCode)) then
			self:OnMouseReleased(MOUSE_LEFT)
			return;
		end
		
		local mx, my = gui.MousePos();
		self:SetPos(mx + self.InitialOffset_X, my + self.InitialOffset_Y);
	end
end

local OnPress = Sound("UI/buttonclick.wav");
function PANEL:OnMousePressed ( MouseCode )	
	if (MouseCode == MOUSE_LEFT) then
		surface.PlaySound(OnPress);
		
		self.mouseCode = MouseCode;
		self.mouseDown = true;
		
		local mx, my = gui.MousePos();
		local ox, oy = self:GetPos();
		
		self.InitialOffset_X, self.InitialOffset_Y = ox - mx, oy - my;
		self.InitialPos_X, self.InitialPos_Y = self:GetPos();
		
		self.ModelPanel:MoveToFront();
		
		self.trueParent:SetSuperGlow(true);
		
		GAMEMODE.DraggingSomething = self;
		
		if (self.itemTable.EquipZone && self.itemTable.EquipZone == EQUIP_WEAPON_MAIN) then
			self:GetParent().MainWeaponEquip:SetSuperGlow(true);
		elseif (self.itemTable.EquipZone && self.itemTable.EquipZone == EQUIP_WEAPON_SIDE) then
			self:GetParent().SideWeaponEquip:SetSuperGlow(true);
		end
		
		self.DownTime = CurTime();
	elseif (MouseCode == MOUSE_RIGHT) then
		GAMEMODE.DropItem(self.trueParent.itemID);
	end
end

function PANEL:OnMouseReleased( MouseCode )
	if (MouseCode == MOUSE_LEFT) then
		self.mouseDown = nil;
		
		if (self.InitialPos_X) then self:SetPos(self.InitialPos_X, self.InitialPos_Y); end
		self.trueParent:SetSuperGlow(false);
		
		GAMEMODE.DraggingSomething = nil;
		
		if (self.itemTable.EquipZone && self.itemTable.EquipZone == EQUIP_WEAPON_MAIN) then
			self:GetParent().MainWeaponEquip:SetSuperGlow(false);
		elseif (self.itemTable.EquipZone && self.itemTable.EquipZone == EQUIP_WEAPON_SIDE) then
			self:GetParent().SideWeaponEquip:SetSuperGlow(false);
		end
		
		realSlot = self:GetParent():GetHoveredItemSlot();
		
		if (CurTime() - self.DownTime < 1 && realSlot == self.trueParent) then
			GAMEMODE.UseItem(self.trueParent.itemID);
		else
			if (realSlot && self.trueParent.itemID != realSlot.itemID) then
				LocalPlayer():SwapItemPosition(self.trueParent.itemID, realSlot.itemID);
			end
		end
	end
end

vgui.Register("perp2_inventory_block_item", PANEL);