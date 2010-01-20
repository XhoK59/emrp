//Serverside file for spectating. Have to kill the spectater, else he will get bugged.

AddCSLuaFile("spectate_cl_init.lua")
local function spectate(ply, cmd, args)
	if ply:IsAdmin() then
		local index = args[1]
		local target = ents.GetByIndex(index)
		if(target) then
			ply:Spectate( OBS_MODE_IN_EYE )
			ply:SpectateEntity( target )
		end
	end
end
concommand.Add("spectate", spectate)

local function unspectate(ply, cmd, args)
	if ply:IsAdmin() then
		ply:UnSpectate()
		ply:Kill()
	end
end
concommand.Add("unspectate", unspectate)