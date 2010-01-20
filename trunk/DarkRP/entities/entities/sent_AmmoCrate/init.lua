AddCSLuaFile( "cl_init.lua" )   
AddCSLuaFile( "shared.lua" )     
include('shared.lua')     
ENT.PhysicsItem = false
ENT.MASS = 2;

function ENT:Initialize()     	
	self.Entity:SetModel( "models/Items/ammocrate_smg1.mdl" )  	
	self.Entity:PhysicsInit( SOLID_VPHYSICS )        	
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )    	
	self.Entity:SetSolid( SOLID_VPHYSICS )                         
	local phys = self.Entity:GetPhysicsObject()  	
	if (phys:IsValid()) then  		
		phys:Wake()  	
	end  
	self.use = true

end     


function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 16

	local ent = ents.Create( "sent_AmmoCrate" )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end



function ENT:Use(activator)
if (self.use) then
activator:GiveAmmo( 500, "smg1" )
activator:GiveAmmo( 500, "buckshot" )
activator:GiveAmmo( 500, "Pistol" )
self.use = false
timer.Simple(0.3,usereply,self)
end
end

function usereply(self)
self.use = true
end

 