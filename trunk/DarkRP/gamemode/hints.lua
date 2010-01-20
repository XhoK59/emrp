local hints = {}
table.insert(hints, "Roleplay according to the Server Rules!")
table.insert(hints, "You can be arrested for buying or owning an illegal weapon!")
table.insert(hints, "Type /sleep to fall asleep.")
table.insert(hints, "You may own a handgun, but use it only in self defence.")
table.insert(hints, "Whatever you job is, do is properly or you could get demoted.")
table.insert(hints, "You can buy pistol, rifle, and shotgun ammo in the F4 menu.")
table.insert(hints, "Press F1 to see RP help.")
table.insert(hints, "If you are a chief or admin, type /jailpos or /addjail to set the positions of the first (and extra) jails.")
table.insert(hints, "You will be teleported to jail if you get arrested!")
table.insert(hints, "Type /buyhealth to refil your health to 100% unless there are medics")
table.insert(hints, "Press F2 or reload with keys to open the keys menu")
table.insert(hints, "Type /warrant [Nick|SteamID|UserID] to get a search warrant for a player.")
table.insert(hints, "Type /wanted or /unwanted [Nick|SteamID|UserID] to set a player as wanted/unwanted by the Police.")
table.insert(hints, "Type /drop to drop the weapon you are holding.")
table.insert(hints, "Type /dropmoney <Amount> to drop a money amount.")
table.insert(hints, "Type /cophelp to see what you need to do as a cop.")
table.insert(hints, "Type /rpname <Name> to choose your roleplay name.")
table.insert(hints, "Type /hitlist as a hitman to see who has hits on them.")
table.insert(hints, "Type /hit <Name> to place a hit on someone.")
table.insert(hints, "If /rpname does not change your name, that name is either too long or already taken by another player.")
table.insert(hints, "RDM, or Random Death-Matching, is when you kill for no reason.  It is not tollerated by the admins and you will be punished for it.")
table.insert(hints, "New Life Rule means you forget everything that happened when you die.  You are not allowed to seek revenge on the person who caused your death.")
table.insert(hints, "Type !motd to view the Message of the Day to read the rules for the server.")


local function GiveHint()
	if CfgVars["advertisements"] ~= 1 then return end
	local text = hints[math.random(1, #hints)]

	for k,v in pairs(player.GetAll()) do
		TalkToPerson(v, Color(150,150,150,150), text)
	end
end

timer.Create("hints", 60, 0, GiveHint)
