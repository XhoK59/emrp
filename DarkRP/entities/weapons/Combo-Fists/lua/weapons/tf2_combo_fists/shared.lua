if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "fist"

	local ActIndex = {}
		ActIndex[ "fist" ]		= ACT_HL2MP_IDLE_FIST

	function SWEP:SetWeaponHoldType( t )

		local index 								= ActIndex[ t ]
			
		if (index == nil) then
			return
		end

		self.ActivityTranslate 							= {}
		self.ActivityTranslate [ ACT_HL2MP_IDLE ] 			= index
		self.ActivityTranslate [ ACT_HL2MP_WALK ] 			= index + 1
		self.ActivityTranslate [ ACT_HL2MP_RUN ] 				= index + 2
		self.ActivityTranslate [ ACT_HL2MP_IDLE_CROUCH ] 		= index + 3
		self.ActivityTranslate [ ACT_HL2MP_WALK_CROUCH ] 		= index + 4
		self.ActivityTranslate [ ACT_HL2MP_GESTURE_RANGE_ATTACK ] 	= index + 5
		self.ActivityTranslate [ ACT_HL2MP_GESTURE_RELOAD ] 		= index + 6
		self.ActivityTranslate [ ACT_HL2MP_JUMP ] 			= index + 7
		self.ActivityTranslate [ ACT_RANGE_ATTACK1 ] 			= index + 8
	
		self:SetupWeaponHoldTypeForAI( t )
	end
end

if( CLIENT ) then
	SWEP.PrintName = "Combo-Fists (TF2)"
	SWEP.Slot = 3
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	
	if(file.Exists("../materials/VGUI/killicons/cf_killicon.vmt")) then

		killicon.Add("tf2_combo_fists","VGUI/killicons/cf_killicon",Color(255,255,255));

	end 
end

SWEP.Author			= "-[SB]- Spy"
SWEP.Instructions	= "Left click for a left-hand swing \nRight click for a right-hand swing \nReload to say something provoking."
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 50
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true


SWEP.ViewModel      = "models/weapons/v_models/v_fist_heavy.mdl"
SWEP.WorldModel   = "models/weapons/w_fists_t.mdl"
  
-- Primary Fire Attributes --
SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= 0
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic   	= false	
SWEP.Primary.Ammo         	= "none"
 
-- Secondary Fire Attributes --
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "none"

-- Various configs --
SWEP.ComboActivated			= false 
SWEP.Delay					= 0.35
SWEP.Delay2					= 0.25

function SWEP:Initialize()
	if( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
	self.ComboHit = {
	Sound("player/crit_hit.wav"),
	Sound("player/crit_hit2.wav"),
	Sound("player/crit_hit3.wav"),
	Sound("player/crit_hit4.wav"),
	Sound("player/crit_hit5.wav")	}
	self.HitHuman = {
	Sound("weapons/cbar_hitbod1.wav"),
	Sound("weapons/cbar_hitbod2.wav"),
	Sound("weapons/cbar_hitbod3.wav")	}
	
	self.HitElse = {
	Sound("weapons/fist_hit_world1.wav"),
	Sound("weapons/fist_hit_world2.wav")   }
	
	self.DrawSounds = {
	Sound("weapons/metal_hit_hand1.wav"),
	Sound("weapons/metal_hit_hand2.wav"),
	Sound("weapons/metal_hit_hand3.wav")   }
	
	self.PushElse = {
	Sound("physics/body/body_medium_impact_hard1.wav"),
	Sound("physics/body/body_medium_impact_hard2.wav"),
	Sound("physics/body/body_medium_impact_hard3.wav"),
	Sound("physics/body/body_medium_impact_hard4.wav"),
	Sound("physics/body/body_medium_impact_hard5.wav"),
	Sound("physics/body/body_medium_impact_hard6.wav") }
	
	self.Provoke = {
	Sound("vo/heavy_meleedare01.wav"),
	Sound("vo/heavy_meleedare03.wav"),
	Sound("vo/heavy_meleedare04.wav"),
	Sound("vo/heavy_meleedare05.wav"),
	Sound("vo/heavy_meleedare06.wav"),
	Sound("vo/heavy_meleedare11.wav"),
	Sound("vo/heavy_domination02.wav"),		
	Sound("vo/heavy_domination13.wav"),	
	Sound("vo/heavy_revenge05.wav") }
	
	self.DrawTalk = {
	Sound("vo/heavy_meleedare01.wav"),
	Sound("vo/heavy_meleedare02.wav"),
	Sound("vo/heavy_meleedare03.wav"),
	Sound("vo/heavy_meleedare04.wav"),
	Sound("vo/heavy_meleedare05.wav"),
	Sound("vo/heavy_meleedare06.wav"),
	Sound("vo/heavy_meleedare07.wav"),
	Sound("vo/heavy_meleedare09.wav"),
	Sound("vo/heavy_meleedare10.wav"),
	Sound("vo/heavy_meleedare11.wav"),
	Sound("vo/heavy_meleedare12.wav"),
	Sound("vo/heavy_meleedare13.wav") }
	
	
	self.QuickHittingTime		= 0
	self.ProvokeTime			= 0
end

function SWEP:Precache()
end

function SWEP:Think()
	if self:GetNWInt("Right") >= 2 then -- If we hit an NPC/Player with our left hand 2 times, then
		self.ComboActivated = true -- Let us do a Combo-Hit!
	elseif self:GetNWInt("Left") >= 2 then --If we hit an NPC/Player with our left hand 2 times, then
		self.ComboActivated = true -- Let us do a Combo-Hit!
	end
	
	if (CurTime() < self.QuickHittingTime) then -- If we can keep up the left-right hand swinging/hitting pace, then
		self.Delay 	= 0.2 -- Let us swing abit faster!
		self.Delay2	= 0.2 -- Let us swing abit faster!
	else -- Otherwise
		self.Delay	= 0.35 -- Make us swing with default speed
		self.Delay2	= 0.25 -- Make us swing with default speed
	end
	
end 

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	timer.Simple(0.2, function() self.Weapon:EmitSound(self.DrawSounds[math.random(#self.DrawSounds)]) end)
	self.Weapon:EmitSound(self.DrawTalk[math.random(#self.DrawTalk)])
	self:SetNextPrimaryFire(CurTime() + 0.7)
	self:SetNextSecondaryFire(CurTime() + 0.7)
	return true
end

function SWEP:Holster()
	self:SetNWInt("Left", 0)
	self:SetNWInt("Right", 0)
	return true
end

function SWEP:Reload()
	if (CurTime() < self.ProvokeTime) then return end
	self.ProvokeTime = (CurTime() + 2)
	self.Weapon:EmitSound(self.Provoke[math.random(#self.Provoke)])
end

function SWEP:PrimaryAttack()
	local extradamage = 6 * (self:GetNWInt("Left") + self:GetNWInt("Right"))
	local trace = self.Owner:GetEyeTrace()
	local phys = trace.Entity:GetPhysicsObject()
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 70 then -- If we're in range
		if self.ComboActivated == true then -- If we activate a Combo
			if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then -- And if we hit a player or an NPC
				self.Weapon:EmitSound(self.HitHuman[math.random(#self.HitHuman)])
			else
				self.Weapon:EmitSound(self.HitElse[math.random(#self.HitElse)])
				if phys:IsValid() then
					phys:ApplyForceOffset(self.Owner:GetAimVector():GetNormalized() * math.random(5000, 7000), trace.HitPos)
				else
					if SERVER then
						trace.Entity:SetVelocity(self.Owner:GetAimVector():GetNormalized() * math.random(5000, 7000))
					end
				end
			end
			if SERVER then
				trace.Entity:TakeDamage(math.random(15, 30) + extradamage, self.Owner, self.Owner) -- Do more damage
			end
			self.Weapon:SendWeaponAnim( ACT_VM_SWINGHARD ) -- Display a different animation
			timer.Simple(0.07, function() self.Owner:ViewPunch(Angle(-20, 0, 0)) end)
			self.Weapon:EmitSound(self.ComboHit[math.random(#self.ComboHit)]) -- Emit a Combo sound
			self:SetNWInt("Left", 0)
			self:SetNWInt("Right", 0)
			self.ComboActivated = false
		else -- Otherwise
			if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then -- And if we hit a player or an NPC
				self.Weapon:EmitSound(self.HitHuman[math.random(#self.HitHuman)])
				self:SetNWInt("Left", self:GetNWInt("Left") + 1) -- Add 1 point to left-hand hitting combo
			else
				self.Weapon:EmitSound(self.HitElse[math.random(#self.HitElse)])
				if phys:IsValid() then
					phys:ApplyForceOffset(self.Owner:GetAimVector():GetNormalized() * math.random(5000, 7000), trace.HitPos)
				else
					if SERVER then
						trace.Entity:SetVelocity(self.Owner:GetAimVector():GetNormalized() * math.random(5000, 7000))
					end
				end
			end
			if SERVER then
				trace.Entity:TakeDamage(math.random(7, 14), self.Owner, self.Owner) -- Do less damage
			end
			self.Weapon:SendWeaponAnim( ACT_VM_HITLEFT ) -- Display a normal animation
			self.Owner:ViewPunch(Angle(-1.5, -2.0, 0))
		end
	else
		self.Weapon:SendWeaponAnim( ACT_VM_HITLEFT )
		self.Weapon:EmitSound("weapons/bat_draw_swoosh1.wav", 100, math.random(95, 105))
		self.Owner:ViewPunch(Angle(-1, -1.5, 0))
	end
	self:SetNextPrimaryFire(CurTime() + self.Delay)
	self:SetNextSecondaryFire(CurTime() + self.Delay2)
	self.QuickHittingTime = (CurTime() + 0.3)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
end 

function SWEP:SecondaryAttack()
	local extradamage = 6 * (self:GetNWInt("Left") + self:GetNWInt("Right"))
	local trace = self.Owner:GetEyeTrace()
	local phys = trace.Entity:GetPhysicsObject()
	if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 70 then -- If we're in range
		if self.ComboActivated == true then -- If we activate a Combo
			if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then -- And if we hit a player or an NPC
				self.Weapon:EmitSound(self.HitHuman[math.random(#self.HitHuman)])
			else
				self.Weapon:EmitSound(self.HitElse[math.random(#self.HitElse)])
				if phys:IsValid() then
					phys:ApplyForceOffset(self.Owner:GetAimVector():GetNormalized() * math.random(5000, 7000), trace.HitPos)
				else
					if SERVER then
						trace.Entity:SetVelocity(self.Owner:GetAimVector():GetNormalized() * math.random(5000, 7000))
					end
				end
				
			end
			if SERVER then
				trace.Entity:TakeDamage(math.random(15, 30) + extradamage, self.Owner, self.Owner) -- Do more damage
			end
			self.Weapon:SendWeaponAnim( ACT_VM_SWINGHARD ) -- Display a different animation
			timer.Simple(0.07, function() self.Owner:ViewPunch(Angle(-20, 0, 0)) end)
			self.Weapon:EmitSound(self.ComboHit[math.random(#self.ComboHit)]) -- Emit a Combo sound
			self:SetNWInt("Left", 0)
			self:SetNWInt("Right", 0)
			self.ComboActivated = false
		else -- Otherwise
			if trace.Entity:IsPlayer() or trace.Entity:IsNPC() then -- And if we hit a player or an NPC
				self.Weapon:EmitSound(self.HitHuman[math.random(#self.HitHuman)])
				self:SetNWInt("Right", self:GetNWInt("Right") + 1) -- Add 1 point to left-hand hitting combo
			else
				self.Weapon:EmitSound(self.HitElse[math.random(#self.HitElse)])
				
				if phys:IsValid() then
					phys:ApplyForceOffset(self.Owner:GetAimVector():GetNormalized() * math.random(5000, 7000), trace.HitPos)
				else
					if SERVER then
						trace.Entity:SetVelocity(self.Owner:GetAimVector():GetNormalized() * math.random(5000, 7000))
					end
				end
			end
			if SERVER then
				trace.Entity:TakeDamage(math.random(7, 14), self.Owner, self.Owner) -- Do less damage
			end
			self.Owner:ViewPunch(Angle(-1.5, 2.0, 0))
			self.Weapon:SendWeaponAnim( ACT_VM_HITRIGHT ) -- Display a normal animation
		end
	else
		self.Weapon:SendWeaponAnim( ACT_VM_HITRIGHT )
		self.Weapon:EmitSound("weapons/bat_draw_swoosh1.wav", 100, math.random(95, 105))
		self.Owner:ViewPunch(Angle(-1, 1.5, 0))
	end
	self:SetNextPrimaryFire(CurTime() + self.Delay2)
	self:SetNextSecondaryFire(CurTime() + self.Delay)
	self.QuickHittingTime = (CurTime() + 0.3)
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
end 

function SWEP:DrawHUD()
	local extradamage = 6 * (self:GetNWInt("Left") + self:GetNWInt("Right"))
	draw.DrawText("Left-Hand Hits: ".. self:GetNWInt("Left") .." ", "ScoreboardText", ScrW() / 2 - 417, ScrH() - 140, Color(255, 255, 255, 255), 1)
	draw.DrawText("Right-Hand Hits: ".. self:GetNWInt("Right") .." ", "ScoreboardText", ScrW() / 2 - 413, ScrH() - 125, Color(255, 255, 255, 255), 1)
	draw.DrawText("Additional Combo Damage: ", "ScoreboardText", ScrW() / 2 - 386, ScrH() - 109, Color(255, 255, 255, 255), 1) 
	draw.DrawText(" ".. extradamage .." ", "ScoreboardText", ScrW() / 2 - 290, ScrH() - 109, Color(0, 255, 0, 255), 1)
	draw.RoundedBox(4, 27, (ScrH() / 2) + 240, ScrW() / 2 - 300 , ScrH() / 2 - 325, Color(0, 0, 0, 100))
	return true
end -- Beta version's last line ends here, gotta say, this is my biggest code written for now. :D