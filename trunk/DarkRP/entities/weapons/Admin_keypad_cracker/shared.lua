if (SERVER) then
	AddCSLuaFile("shared.lua")
end

if (CLIENT) then
	SWEP.PrintName = "Admin Keypad Cracker"
	SWEP.Slot = 4
	SWEP.SlotPos = 1
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

-- Variables that are used on both client and server

SWEP.Author = "|ERP| Enzo"
SWEP.Instructions = "Left click to crack a keypad"
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = Model("models/weapons/v_c4.mdl")
SWEP.WorldModel = Model("models/weapons/w_c4.mdl")

SWEP.Spawnable = false
SWEP.AdminSpawnable = true

SWEP.Sound = Sound("weapons/deagle/deagle-1.wav")

SWEP.Primary.ClipSize = -1      -- Size of a clip
SWEP.Primary.DefaultClip = 0        -- Default number of bullets in a clip
SWEP.Primary.Automatic = false      -- Automatic/Semi Auto
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1        -- Size of a clip
SWEP.Secondary.DefaultClip = -1     -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false        -- Automatic/Semi Auto
SWEP.Secondary.Ammo = ""
SWEP.KeyCrackTime = 0

/*---------------------------------------------------------
Name: SWEP:Initialize()
Desc: Called when the weapon is first loaded
---------------------------------------------------------*/
function SWEP:Initialize()
	if (SERVER) then
		self:SetWeaponHoldType("normal")
	end
end

/*---------------------------------------------------------
Name: SWEP:PrimaryAttack()
Desc: +attack1 has been pressed
---------------------------------------------------------*/

function SWEP:PrimaryAttack()
	self.Weapon:SetNextPrimaryFire(CurTime() + .4)
	if self.IsCracking then return end

	local trace = self.Owner:GetEyeTrace()
	local e = trace.Entity
	if ValidEntity(e) and trace.HitPos:Distance(self.Owner:GetShootPos()) <= 300 and (e:GetClass() == "sent_keypad") then
		self.IsCracking = true
		self.StartCrack = CurTime()
		self.EndCrack	= CurTime() + self.KeyCrackTime
		if SERVER then
			self:SetWeaponHoldType("pistol")
			timer.Create("KeyCrackSounds", 1, self.KeyCrackTime, function(wep)
				wep:EmitSound("buttons/blip2.wav", 100, 100)
			end, self)
		end
		if CLIENT then
			self.Dots = self.Dots or ""
			timer.Create("KeyCrackDots", 0.5, 0, function(wep) 
				if not wep:IsValid() then timer.Destroy("KeyCrackDots") return end
				local len = string.len(wep.Dots)
				local dots = {[0]=".", [1]="..", [2]="...", [3]=""}
				wep.Dots = dots[len]
			end, self)
		end
	end 
end

function SWEP:Holster()
	self.IsCracking = false
	if SERVER then timer.Destroy("KeyCrackSounds") end
	if CLIENT then timer.Destroy("KeyCrackDots") end
	return true
end

function SWEP:Succeed()
	self.IsCracking = false
	local trace = self.Owner:GetEyeTrace()
	if ValidEntity(trace.Entity) and trace.Entity:GetClass() == "sent_keypad" then
		local owner = trace.Entity:GetNWEntity("keypad_owner")
		owner:ConCommand("+gm_special " .. trace.Entity:GetNWInt("keypad_keygroup1") .. "\n")
		timer.Simple(trace.Entity:GetNWInt("keypad_length1"), function() owner:ConCommand("-gm_special " .. trace.Entity:GetNWInt("keypad_keygroup1") .. "\n")end)
		trace.Entity:SetNWBool("keypad_access", true)
		trace.Entity:SetNWBool("keypad_showaccess", true)
		if (SERVER) then
			trace.Entity:EmitSound("buttons/button11.wav")
		end
		timer.Simple(2, function() trace.Entity:SetNWBool("keypad_showaccess", false) end)
	end
	if SERVER then timer.Destroy("KeyCrackSounds") end
	if CLIENT then timer.Destroy("KeyCrackDots") end
end

function SWEP:Fail()
	self.IsCracking	= false
	if SERVER then self:SetWeaponHoldType("normal")
	timer.Destroy("KeyCrackSounds") end
	if CLIENT then timer.Destroy("KeyCrackDots") end
end

function SWEP:Think()
	if self.IsCracking then
		local trace = self.Owner:GetEyeTrace()
		if not ValidEntity(trace.Entity) then 
			self:Fail()
		end
		if trace.HitPos:Distance(self.Owner:GetShootPos()) > 300 or (trace.Entity:GetClass() != "sent_keypad") then
			self:Fail()
		end
		if self.EndCrack <= CurTime() then
			self:Succeed()
		end
	end
end

function SWEP:DrawHUD()
	if self.IsCracking then
		self.Dots = self.Dots or ""
		local w = ScrW()
		local h = ScrH()
		local x,y,width,height = w/2-w/10, h/ 2, w/5, h/15
		draw.RoundedBox(8, x, y, width, height, Color(10,10,10,120))
		
		local time = self.EndCrack - self.StartCrack
		local curtime = CurTime() - self.StartCrack
		local status = curtime/time
		local BarWidth = status * (width - 16) + 8
		draw.RoundedBox(8, x+8, y+8, BarWidth, height - 16, Color(255-(status*255), 0+(status*255), 0, 255))
		
		draw.SimpleText("Cracking"..self.Dots, "Trebuchet24", w/2, h/2 + height/2, Color(255,255,255,255), 1, 1)
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end