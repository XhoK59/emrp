-- Weapon Drop v2 by Maxter(v2) and iThermal(v1)

dropweps = 1

dontdrop = {}
dontdrop[1] = "weapon_physgun"
dontdrop[2] = "weapon_physcannon"
dontdrop[3] = "gmod_tool"
dontdrop[4] = "gmod_camera"
dontdrop[5] = "arrest_stick"
dontdrop[6] = "door_ram"
dontdrop[7] = "keys"
dontdrop[8] = "med_kit"
dontdrop[9] = "weaponchecker"
dontdrop[10] = "stunstick"
dontdrop[11] = "unarrest_stick"
dontdrop[12] = "pocket"
dontdrop[14] = "hl2_combo_fists"
dontdrop[15] = "tf2_combo_fists"
dontdrop[16] = "grapplehook"
dontdrop[17] = "pickpocket"
dontdrop[18] = "spiderman's_swep"
dontdrop[19] = "weapon_real_cs_admin_weapon"
dontdrop[20] = "med_kit"
dontdrop[21] = "stunstick"
dontdrop[22] = "lockpick"
dontdrop[23] = "keypad_cracker"
dontdrop[24] = "Admin_keypad_cracker"



function droptheweapon(ply)

	if dropweps == 1 then
	
	droppos = ply:GetPos() + Vector(0, 0, 30)
	
		for k, v in pairs (ply:GetWeapons()) do
		
			loopwep = v:GetClass()
		
			if not table.HasValue(dontdrop, loopwep) then
		
				local dropthiswep = ents.Create(loopwep)
				dropthiswep:SetPos(droppos)
				dropthiswep:Spawn()
		
			end
		
		end
	
	end

end

function toggledropweps(caller)

	if caller:IsAdmin() then
	
		if dropweps == 1 then
		
			dropweps = 0
			
			caller:ChatPrint("You turned off weapon dropping!")
			
		elseif dropweps == 0 then
		
			dropweps = 1
			
			caller:ChatPrint("You turned on weapon dropping!")
			
		end
	
	end

end

concommand.Add("toggleweapondrop", toggledropweps)
hook.Add("DoPlayerDeath", "pldrophook", droptheweapon)