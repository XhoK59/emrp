-- =======================
-- =Crate SENT by Mahalis
-- =======================

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_lab/crematorcase.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if phys and phys:IsValid() then phys:Wake() end
	self.sparking = false
	self.damage = 100
	local ply = self:GetNWEntity("owning_ent")
	self.Entity.SID = ply.SID
	self.SID = ply.SID
	self.Entity:SetNWInt("price", 100)
	self.Entity.CanUse = true
	self.ShareGravgun = true
end

function ENT:OnTakeDamage(dmg)
	self.damage = self.damage - dmg:GetDamage()
	if (self.damage <= 0) then
		self:Remove()
	end
end

function ENT:Destruct()
	local vPoint = self:GetPos()
	local effectdata = EffectData()
	effectdata:SetStart(vPoint)
	effectdata:SetOrigin(vPoint)
	effectdata:SetScale(1)
	util.Effect("Explosion", effectdata)
end

function ENT:Use(activator,caller)
	if not self.Entity.CanUse then return false end
	self.Entity.CanUse = false
	self.drug_user = activator
	if (activator.maxDrugs and activator.maxDrugs >= CfgVars["maxdrugs"]) then
		Notify(activator, 1, 3, "You can't make anymore drugs as the limit is reached.")
		timer.Simple(0.5, function() self.Entity.CanUse = true end)
	else
		
		local productioncost = math.random(self.Entity:GetNWInt("price") / 8, self.Entity:GetNWInt("price") / 4)
		if not activator:CanAfford(productioncost) then
			Notify(activator, 1, 4, "You do not have enough money to produce drugs.")
			return false
		end
		activator:AddMoney(-productioncost)
		Notify(activator, 1, 4, "You have made drugs! production cost: " .. CUR .. tostring(productioncost).."!")
		self.sparking = true
		timer.Create(self:EntIndex() .. "drug", 1, 1, self.createDrug, self)
	end
end

function ENT:createDrug()
	self.Entity.CanUse = true
	local userb = self.drug_user
	local drugPos = self:GetPos()
	drug = ents.Create("drug")
	drug:SetPos(Vector(drugPos.x,drugPos.y,drugPos.z + 35))
	drug:SetNWEntity("owning_ent", userb)
	drug.SID = userb.SID
	drug.ShareGravgun = true
	drug.nodupe = true
	drug:SetNWInt("price", self.Entity:GetNWInt("price"))
	drug:Spawn()
	if not userb.maxDrugs then
		userb.maxDrugs = 0
	end
	userb.maxDrugs = userb.maxDrugs + 1
	self.sparking = false
end

function ENT:Think()
	if not self.SID then 
		self.SID = self:GetNWEntity("owning_ent")
	end
	if self.sparking then
		local effectdata = EffectData()
		effectdata:SetOrigin(self:GetPos())
		effectdata:SetMagnitude(1)
		effectdata:SetScale(1)
		effectdata:SetRadius(2)
		util.Effect("Sparks", effectdata)
	end
end

function ENT:OnRemove()
	self:Destruct()
	timer.Destroy(self)
end