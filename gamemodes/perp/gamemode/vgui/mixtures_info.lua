local PANEL = {}



surface.CreateFont("MixturesInfoFont", {
	font="Tahoma",
	size=ScreenScale(6),
	weight=1000,
	antialias=true
})


local WarningTexture = surface.GetTextureID("perp2/warning")

function PANEL:Init ( )
	self.NameLabel = vgui.Create("DLabel", self)
	self.RequiredLabel = vgui.Create("DLabel", self)
	self.RequiredSkillsLabel = vgui.Create("DLabel", self)
	
	
end

function PANEL:PerformLayout ( )
	surface.SetFont("MixturesWarningFont")
	self:SetHeight(110)
	
	self.CanMix = false
	
	surface.SetFont("MixturesInfoFont")
	self.MinX, self.MinY = surface.GetTextSize("whatever.")
	
	if (self.ModelPanel) then
		self.ModelPanel:SetPos(9, 9)
		self.ModelPanel:SetSize(self:GetTall() - 18, self:GetTall() - 18)
	end	
	
	self.NameLabel:SetSize(self:GetWide() * 0.75, 40)
	self.NameLabel:SetPos(self:GetTall() + 10, 5)
	self.NameLabel:SetFont("MixturesInfoFont")
	self.NameLabel:SetTextColor(Color(255, 255, 255, 255))
	if(self.Mixture.MixInWorld) then
		self.NameLabel:SetText(self.Mixture.Name .. "\n(World Mixture)")
	else
		self.NameLabel:SetText(self.Mixture.Name)
	end
	
	self.RequiredLabel:SetSize(self:GetWide() * 0.75, 40)
	self.RequiredLabel:SetPos(self:GetTall() + 10, 30)
	self.RequiredLabel:SetFont("MixturesInfoFont")
	self.RequiredLabel:SetWrap(true)
	self.RequiredLabel:SetTextColor(Color(255, 255, 255, 255))
	self.RequiredLabel:SetText(self.requiresText)
	
	self.RequiredSkillsLabel:SetSize(self:GetWide() * 0.75, 40)
	self.RequiredSkillsLabel:SetPos(self:GetTall() + 10, 60)
	self.RequiredSkillsLabel:SetFont("MixturesInfoFont")
	self.RequiredSkillsLabel:SetWrap(true)
	self.RequiredSkillsLabel:SetTextColor(Color(255, 255, 255, 255))
	self.RequiredSkillsLabel:SetText(self.requiredSkillsText)
	
	
	self.Button:SetPos(9, 9)
	self.Button:SetSize(self:GetTall() - 18, self:GetTall() - 18)
end

local unOccupied = surface.GetTextureID("perp2/inventory/inv_empty")
local mouseOver = surface.GetTextureID("materials/hui/center_gradient")
function PANEL:Paint ( )
	draw.RoundedBox(4, 0, 0, self:GetWide(), self:GetTall(), SKIN.control_color)
	
	surface.SetDrawColor(0, 0, 0, 230)
	surface.DrawOutlinedRect(4, 4, self:GetTall() - 8, self:GetTall() - 8)
	surface.SetDrawColor(255, 255, 255, 230)
	surface.SetTexture(unOccupied)
	surface.DrawTexturedRect(5, 5, self:GetTall() - 10, self:GetTall() - 10)
	
	if(self.CanMix) then
		if(self.Mixture.MixInWorld) then
			surface.SetDrawColor(Color(0, 0, 255, 100))
		else
			surface.SetDrawColor(Color(0, 255, 0, 100))
		end
	else
		surface.SetDrawColor(Color(255, 0, 0, 100))
	end
	
	surface.SetTexture(unOccupied)
	surface.DrawTexturedRect(5, 5, self:GetTall() - 10, self:GetTall() - 10)
	--draw.SimpleText(self.Mixture.Name, "MixturesWarningFont", self:GetTall() + 10, 5, Color(255, 255, 255, 255), 0, 0)
	--draw.SimpleText(self.requiresText, "MixturesInfoFont", self:GetTall() + 10, 8 + self.MainY, Color(255, 255, 255, 255), 0, 0)
	--draw.SimpleText(self.requiredSkillsText, "MixturesInfoFont", self:GetTall() + 10, 8 + self.MainY + self.MinY, Color(255, 255, 255, 255), 0, 0)
end

function PANEL:Think()
	local realTable = {}
	for k, v in pairs(self.Mixture.Ingredients) do
		realTable[v] = realTable[v] or 0
		realTable[v] = realTable[v] + 1
	end
	
	
	
	local Has = true
	for k, v in pairs(realTable) do
		if(LocalPlayer():GetItemCount(k) < v) then
			Has = false
		end
	end
	
	for _, req in pairs(self.Mixture.Requires) do
		if(LocalPlayer():GetPERPLevel(req[1]) < req[2]) then
			Has = false
		end
	end
	
	self.CanMix = Has
end

function PANEL:SetMixture ( mID )
	self.Mixture = mID
	
	self.requiresText = "Required Items: "
	
	if (self.Mixture.RequiresHeatSource) then
		self.requiresText = self.requiresText .. "Heat Source, "
	end
	
	if (self.Mixture.RequiresWaterSource) then
		self.requiresText = self.requiresText .. "Water Source, "
	end
	
	local realTable = {}
	for k, v in pairs(self.Mixture.Ingredients) do
		realTable[v] = realTable[v] or 0
		realTable[v] = realTable[v] + 1
	end
	
	local num = 0
	for k, v in pairs(realTable) do
		num = num + 1
		self.requiresText = self.requiresText .. ITEM_DATABASE[k].Name .. " x " .. v
		
		if (num != table.Count(realTable)) then
			self.requiresText = self.requiresText .. ", "
		end
	end
	
	self.requiredSkillsText = "Required Skills: "
	for k, v in pairs(self.Mixture.Requires) do
		self.requiredSkillsText = self.requiredSkillsText .. GAMEMODE.GetRealName(v[1]) .. " level " .. v[2]
		
		if (k != #self.Mixture.Requires) then
			self.requiredSkillsText = self.requiredSkillsText .. ", "
		end
	end
	
	local itemTable = ITEM_DATABASE[self.Mixture.Results]
	
	self.ModelPanel = vgui.Create("DModelPanel", self)
	self.ModelPanel:SetModel(itemTable.InventoryModel)
	
	self.ModelPanel:SetCamPos(itemTable.ModelCamPos)
	self.ModelPanel:SetLookAt(itemTable.ModelLookAt)
	self.ModelPanel:SetFOV(itemTable.ModelFOV)
	
	local iSeq = self.ModelPanel.Entity:LookupSequence('ragdoll')
	self.ModelPanel.Entity:ResetSequence(iSeq)
	
	self.ModelPanel:SetPos(9, 9)
	self.ModelPanel:SetSize(self:GetTall() - 18, self:GetTall() - 18)
	function self.ModelPanel:LayoutEntity ( ) end
	
	self.Button = vgui.Create("DButton", self)
	self.Button:SetPos(9, 9)
	self.Button.Dadda = self
	self.Button:SetSize(self:GetTall() - 18, self:GetTall() - 18)
	self.Button:SetText("")
	self.Button.Paint = function()
	end
	self.Button.DoClick = function()
		RunConsoleCommand("perp_mix", self.Mixture.ID)
	end
	
	return self
end

vgui.Register('perp2_mixtures_info', PANEL)