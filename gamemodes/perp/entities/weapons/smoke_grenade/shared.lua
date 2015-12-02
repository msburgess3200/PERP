if ( SERVER ) then

    AddCSLuaFile( "shared.lua" )
    
end

SWEP.PrintName = "SMOKE GRENADE"
SWEP.Base = "weapon_cs_base"
SWEP.Category = "CSS"
SWEP.Weight = 5
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.IconLetter            = "Q"
SWEP.Slot = 4
SWEP.SlotPos = 3


SWEP.ViewModel = "models/weapons/v_eq_flashbang.mdl" -- This is the model used for clients to see in first person.
SWEP.WorldModel = "models/weapons/w_eq_flashbang.mdl" -- This is the model shown to all other clients and in third-person.

SWEP.Primary = {}
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
    self:SetWeaponHoldType( "grenade" )
   // if CLIENT then killicon.AddFont( self.ClassName, "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) ) end
end

function SWEP:PrimaryAttack()
    if CLIENT then return end
    self:SetNextPrimaryFire( CurTime() + 2 )
    self:SendWeaponAnim( ACT_VM_PULLPIN )
    timer.Simple(1.2,function() self:SendWeaponAnim( ACT_VM_THROW ) self.Owner:SetAnimation(PLAYER_ATTACK1) end)
    timer.Simple(1.6,function()
        local owner = self.Owner
        local grenade = ents.Create("ent_smokegrenade")

        grenade:SetPos( self.Owner:EyePos() + self.Owner:GetAimVector() * 16 )
        grenade:SetAngles( self.Owner:EyeAngles() )    
        grenade:Spawn()
        grenade:Activate()
        grenade:GetPhysicsObject():SetVelocity( self.Owner:GetAimVector() * 1000 )
        grenade:GetPhysicsObject():AddAngleVelocity(Vector(math.random(-500,500),math.random(-500,500),math.random(-500,500)))        
        self:Remove()
        owner:ConCommand("lastinv")
		self.Owner:RemoveEquipped(EQUIP_SIDE);
        timer.Simple(2,function()
            grenade:EmitSound("weapons/smokegrenade/sg_explode.wav")
            exp = ents.Create("env_smoketrail")
            exp:SetKeyValue("startsize","100000")
            exp:SetKeyValue("endsize","130")
            exp:SetKeyValue("spawnradius","250")
            exp:SetKeyValue("minspeed","0.1")
            exp:SetKeyValue("maxspeed","0.5")
            exp:SetKeyValue("startcolor","200 200 200")
            exp:SetKeyValue("endcolor","200 200 200")
            exp:SetKeyValue("opacity","1")
            exp:SetKeyValue("spawnrate","15")
            exp:SetKeyValue("lifetime","7")
            exp:SetPos(grenade:GetPos())
            exp:SetParent(grenade)

            exp:Spawn()
            exp:Fire("kill","",20)
            grenade:Fire("kill","",20)
        end)
    end)
end


local ENT = {}
ENT.Type = "anim"
ENT.PrintName = "Smoke Grenade"
ENT.Base = "base_anim"
function ENT:Initialize()
    if CLIENT then return end
    self.Entity:SetModel("models/weapons/w_eq_smokegrenade.mdl")
    self.Entity:PhysicsInit( SOLID_VPHYSICS )
    self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
    self.Entity:SetSolid( SOLID_VPHYSICS )
    self.Entity:DrawShadow( false )

    self.Entity:SetNetworkedString("Owner", "World")
    self.Entity:GetPhysicsObject():SetMass(10)
    self.Entity:SetGravity( 0.5 )
    local phys = self.Entity:GetPhysicsObject()
    
    if (phys:IsValid()) then
        phys:Wake()
    end
end

function ENT:PhysicsCollide( data, physobj )
    if (data.Speed > 50 && data.DeltaTime > 0.2 ) then
        if data.HitEntity:IsWorld() then
            self:EmitSound( "weapons/flashbang/grenade_hit1.wav")
            local phob = self:GetPhysicsObject();
        end
    end
end

scripted_ents.Register(ENT, "ent_smokegrenade", true)