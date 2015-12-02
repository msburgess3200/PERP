
include('shared.lua')

/*---------------------------------------------------------
   Name: DrawTranslucent
   Desc: Draw translucent
---------------------------------------------------------*/

local SHeight = 5;
local SWidth = 2.5
local MaxHeight = 25;
local MaxWidth = 15;

function ENT:Draw()
	local GrowthPercent = (CurTime() - self.SpawnTime) / POT_GROW_TIME;

	if GrowthPercent <= 1 then
		local W = SWidth + (GrowthPercent * MaxWidth );
		local mat = Matrix()
		mat:Scale(.05 * Vector(W, W, SHeight + (GrowthPercent * MaxHeight)))
		self:EnableMatrix( "RenderMultiply", mat )
	end
	
	self:DrawModel();
end

function ENT:Think ( )	

end

function ENT:Initialize ( )	
	self.SpawnTime = CurTime();
end
