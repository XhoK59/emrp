if( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if( CLIENT ) then

	SWEP.PrintName = "Civil Protection Chief Costume";
	SWEP.Slot = 3;
	SWEP.SlotPos = 1;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = false;

end

// Variables that are used on both client and server

SWEP.Author			= "Bloodstone"
SWEP.Instructions	= "Left Click To Dress As The Civil Protection Chief. Right Click To Change Back."
SWEP.Category		= "NBRP Costumes"
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true

SWEP.NextStrike = 0;
  
SWEP.ViewModel = Model( "models/weapons/v_c4.mdl" );
SWEP.WorldModel = Model( "models/weapons/w_c4.mdl" );
  
local ShootSound = Sound( "weapons/ar_reload.wav" );
  
SWEP.Primary.ClipSize		= -1					// Size of a clip
SWEP.Primary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Primary.Automatic		= false				// Automatic/Semi Auto
SWEP.Primary.Ammo			= ""

SWEP.Secondary.ClipSize		= -1			// Size of a clip
SWEP.Secondary.DefaultClip	= 0				// Default number of bullets in a clip
SWEP.Secondary.Automatic	= false				// Automatic/Semi Auto
SWEP.Secondary.Ammo			= ""
SWEP.Spawnable			= false
SWEP.AdminSpawnable		= true
SWEP.ActivateTime = 0
SWEP.CountTime = 0
SWEP.HUDTime = 0

/*---------------------------------------------------------
	Name: Equip
	Desc: A player or NPC has picked the weapon up
//-------------------------------------------------------*/ 
function SWEP:Equip( NewOwner )
local gw = self.Owner:GetModel()
	self.Owner:SetNWString("OriginalModel", gw)
end
/*---------------------------------------------------------
   Name: SWEP:PrimaryAttack( )
   Desc: +attack1 has been pressed
---------------------------------------------------------*/
function SWEP:PrimaryAttack()
	self.BaseClass.ShootEffects( self );
	self.Weapon:EmitSound (ShootSound); 
	self.Owner:SetModel("models/player/combine_soldier_prisonguard.mdl")
end
 
/*---------------------------------------------------------
  SecondaryAttack
  ---------------------------------------------------------*/
function SWEP:SecondaryAttack()
local originalmodel = self.Owner:GetNWString("OriginalModel")
	self.Weapon:EmitSound( ShootSound );
	self.BaseClass.ShootEffects( self )
	self.Owner:SetModel( originalmodel )
end