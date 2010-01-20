if (SERVER) then 
    AddCSLuaFile("shared.lua") 
end 
  
if (CLIENT) then 
    SWEP.PrintName = "Pickpocket" 
    SWEP.Slot = 5 
    SWEP.SlotPos = 1 
    SWEP.DrawAmmo = false 
    SWEP.DrawCrosshair = false 
end 

local meta = FindMetaTable( "Entity" ); 
  

  
-- Variables that are used on both client and server 
  
SWEP.Author = "Capsup" 
SWEP.Instructions = "Left click to pickpocket" 
SWEP.Contact = "Don't" 
SWEP.Purpose = "OMG A PICKPOCKETER!" 
  
SWEP.ViewModelFOV = 62 
SWEP.ViewModelFlip = false 
SWEP.ViewModel = Model("models/weapons/v_crowbar.mdl") 
SWEP.WorldModel = Model("models/weapons/w_crowbar.mdl") 
  
SWEP.Spawnable = false 
SWEP.AdminSpawnable = true 
  
SWEP.Sound = Sound("weapons/iceaxe/iceaxe_swing1.wav") 
  
SWEP.Primary.ClipSize = -1      -- Size of a clip 
SWEP.Primary.DefaultClip = 0        -- Default number of bullets in a clip 
SWEP.Primary.Automatic = false      -- Automatic/Semi Auto 
SWEP.Primary.Ammo = "" 
  
SWEP.Secondary.ClipSize = -1        -- Size of a clip 
SWEP.Secondary.DefaultClip = -1     -- Default number of bullets in a clip 
SWEP.Secondary.Automatic = false        -- Automatic/Semi Auto 
SWEP.Secondary.Ammo = "" 
  
/*--------------------------------------------------------- 
Name: SWEP:Initialize() 
Desc: Called when the weapon is first loaded 
---------------------------------------------------------*/ 
function SWEP:Initialize() 
    if (SERVER) then 
        self:SetWeaponHoldType("crowbar") 
    end 
    util.PrecacheSound("weapons/iceaxe/iceaxe_swing1.wav") 
end 
  
/*--------------------------------------------------------- 
Name: SWEP:PrimaryAttack() 
Desc: +attack1 has been pressed 
---------------------------------------------------------*/ 
  
function SWEP:PrimaryAttack() 
    self.BaseClass.ShootEffects( self ) 
    self.Weapon:SetNextPrimaryFire( CurTime() + 1 ); 
    local trace = { } 
    trace.start = self.Owner:EyePos(); 
    trace.endpos = trace.start + self.Owner:GetAimVector() * 60; 
    trace.filter = self.Owner; 
        
    local tr = util.TraceLine( trace ); 
    
    if( tr.Entity:IsValid() && tr.Entity:IsPlayer() ) then 
        local CanI = math.random(10) 
        
        if CanI == 2 then 
            local take = math.random(10, 35) 
            tr.Entity:AddMoney(take * -1); 
            self.Owner:AddMoney(take * 1 ); 
                           self.Owner:PrintMessage( 3, "Succeded."); 
                           self.Weapon:SetNextPrimaryFire( CurTime() + 8 ); 
            
        else 
            self.Owner:PrintMessage( 3, "Failed." ); 
            self.Weapon:SetNextPrimaryFire( CurTime() + 4 ); 
        end 
    end  
end

