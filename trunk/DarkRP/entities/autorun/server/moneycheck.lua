//Allows admins to check the amount of DarkRP money on the players in the server.
function moneycheck(ply, cmd, args)
	for k,v in pairs(player.GetAll()) do
		if ply:IsAdmin() then
			ply:PrintMessage(HUD_PRINTCONSOLE, v:Name()..": "..DB.RetrieveMoney(v))
		end
	end
end
concommand.Add("moneycheck", moneycheck)

//-By Wantor