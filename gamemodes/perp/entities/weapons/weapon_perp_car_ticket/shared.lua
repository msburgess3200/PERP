
SWEP.Author		= "RedMist"
SWEP.Contact		= ""
SWEP.Purpose		= "Left click on a car to give the owner a ticket."
SWEP.Instructions	= ""

SWEP.ViewModel		= "models/props_lab/clipboard.mdl"
SWEP.WorldModel		= "models/props_lab/clipboard.mdl"

util.PrecacheModel(SWEP.ViewModel);
util.PrecacheModel(SWEP.WorldModel);

SWEP.Primary.ClipSize		= -1;
SWEP.Primary.DefaultClip	= -1;
SWEP.Primary.Automatic		= false;
SWEP.Primary.Ammo			= "none";

SWEP.Secondary.ClipSize		= -1;
SWEP.Secondary.DefaultClip	= -1;
SWEP.Secondary.Automatic	= false;
SWEP.Secondary.Ammo			= "none";


function SWEP:Initialize()
end

function SWEP:Deploy()
	return true;
end

function SWEP:Holster()
	return true;
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	if(self.Owner:Team() != TEAM_POLICE) then return; end
	
	local trEntity = self.Owner:GetEyeTrace().Entity
	local CarOwny = trEntity:GetNetworkedEntity("owner");
	print(CarOwny)
	if(ValidEntity(trEntity) and trEntity:IsVehicle() and trEntity:GetPos():Distance(self.Owner:GetPos()) < 200 and CarOwny) then
		if(CarOwny:IsGovernmentOfficial()) then
			self.Owner:ChatPrint("Can't ticket government or job workers.");
			return
		end
		if(trEntity.Disabled) then
			self.Owner:ChatPrint("This car and its owner have just experienced a terrible accident. Why would you give the owner a ticket?");
			return
		end
		
		if(!CarOwny:HasItem("item_parkingticket")) then
			self:EmitSound("ambient/materials/footsteps_glass2.wav");
			self.Owner:ChatPrint("Traffic ticket given to " .. trEntity.CarOwny:Nick());
			
			CarOwny:GiveItem(107, 1, true)
			CarOwny:EmitSound("ambient/materials/footsteps_glass2.wav");
			CarOwny:SendLua([[Derma_Message("You have received a traffic ticket from ]] .. self.Owner:Nick() .. [[ (]] .. self.Owner:SteamID() .. [[).", "Traffic Ticket", "I'll pay it.")]]);
		else
			self.Owner:ChatPrint("This person has already recieved a ticket.");
		end
	end
	
	self:SetNextPrimaryFire(CurTime() + 6);
end

function SWEP:SecondaryAttack()

end

function SWEP:Think()
end
