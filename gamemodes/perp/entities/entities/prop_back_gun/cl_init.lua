
include('shared.lua')

function ENT:Draw()
	local Owner = self:GetNetworkedEntity("o", nil);
	
	if (!IsValid(Owner) || Owner == LocalPlayer()) then 
		self:DrawShadow(false);
		return false;
	end
	
	local Attachment = Owner:GetAttachment(Owner:LookupAttachment("chest"));
	local Pos = Attachment.Pos;
	local Ang = Attachment.Ang;
	
	if (!Owner:Crouching()) then
		if (Owner:GetVelocity():Length() > 20) then
			self:SetPos(Pos + 				Ang:Right() * 8 + 
											Ang:Forward() * -5 + 
											Ang:Up() * -15);
		else
			self:SetPos(Pos + 				Ang:Right() * 8 + 
											Ang:Forward() * -7 + 
											Ang:Up() * -15);
		end
		
		self:SetAngles(Ang + Angle(-60, 90, 0));
	elseif (Owner:Crouching()) then
		local Forward = -4;
		local Right = 8;
		if (Owner:GetVelocity():Length() > 20) then
			Forward = -5;
			Right = 4;
		end
		
		self:SetPos(Pos + 				Ang:Right() * Right + 
										Ang:Forward() * Forward + 
										Ang:Up() * -15);
		self:SetAngles(Ang + Angle(-90, 40, 60 - Ang.r));
	end
	
	self:DrawModel()
end

function ENT:Initialize ( ) self:DrawShadow(false); end
