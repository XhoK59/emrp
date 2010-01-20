//Disable the show-kills function, then only admins can see who kills who with this script.

function whokilledwho(victim,inflictor,killer)
	for k,v in pairs(player.GetAll()) do
		if v:IsAdmin() then
			if victim:IsValid() and killer:IsValid() and victim:IsPlayer() and killer:IsPlayer() then
				v:PrintMessage(HUD_PRINTTALK,victim:Nick().." was killed by "..killer:Nick().."!")
			end
		end
	end
end
hook.Add("PlayerDeath","informTheAdmins",whokilledwho)