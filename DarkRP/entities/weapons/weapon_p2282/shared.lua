if (SERVER) then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "pistol"
end

if (CLIENT) then
	SWEP.PrintName = "P228"
	SWEP.Author = "PhilXYZ + FPtje"
	SWEP.Slot = 1
	SWEP.SlotPos = 5
	SWEP.IconLetter = "y"

	killicon.AddFont("weapon_p228", "CSKillIcons", SWEP.IconLetter, Color(255, 80, 0, 255))
end

SWEP.Base = "weapon_cs_base2"

SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.ViewModel = "models/weapons/v_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Primary.Sound = Sound("Weapon_p228.Single")
SWEP.Primary.Recoil = 0.8
SWEP.Primary.Damage = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0.04
SWEP.Primary.ClipSize = 12
SWEP.Primary.Delay = 0.1
SWEP.Primary.DefaultClip = 12
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "pistol"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.IronSightsPos = Vector (4.7287, -2.5911, 2.7307)
SWEP.IronSightsAng = Vector (0, 0, 0)
