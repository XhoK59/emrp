//Much like the normal "status" command, but this one shows the RPName instead of the real Steam name
function playeridentify(ply, cmd, args)
	print("# userid name uniqueid")
	for k,v in pairs(player.GetAll()) do
		if ply:IsAdmin() then
			ply:PrintMessage(HUD_PRINTCONSOLE, "# "..v:UserID().." "..v:Name().." "..v:SteamID())
		end
	end
end
concommand.Add("playerid", playeridentify)

//-By Wantor