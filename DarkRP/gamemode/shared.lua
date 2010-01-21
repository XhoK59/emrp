RPExtraTeams = {}
function AddExtraTeam( Name, color, model, Description, Weapons, command, maximum_amount_of_this_class, Salary, admin, Vote, Haslicense, NeedToChangeFrom)
	if not Name or not color or not model or not Description or not Weapons or not command or not maximum_amount_of_this_class or not Salary or not admin or Vote == nil then
		local text = "One of the custom teams is wrongly made! Attempt to give name of the wrongly made team!(if it's nil then I failed):\n" .. tostring(Name)
		print(text)
		hook.Add("PlayerSpawn", "TeamError", function(ply)
			if ply:IsAdmin() then ply:ChatPrint("WARNING: "..text) end
		end)	
	end
	local CustomTeam = {name = Name, model = model, Des = Description, Weapons = Weapons, command = command, max = maximum_amount_of_this_class, salary = Salary, admin = admin or 0, Vote = tobool(Vote), NeedToChangeFrom = NeedToChangeFrom, Haslicense = Haslicense}
	table.insert(RPExtraTeams, CustomTeam)
	team.SetUp(#RPExtraTeams, Name, color)
	local Team = #RPExtraTeams
	if SERVER then
		timer.Simple(0.1, function(CustomTeam) AddTeamCommands(CustomTeam) end, CustomTeam)
	end
	return Team
end

hook.Add("InitPostEntity", "AddTeams", function()
	if file.Exists("CustomTeams.txt") then
		RunString(file.Read("CustomTeams.txt"))
		if SERVER then resource.AddFile("data/CustomTeams.txt") end
		if CLIENT and not LocalPlayer():IsSuperAdmin() then file.Delete("CustomTeams.txt") end
	end
end)

/*--------------------------------------------------------
Default teams. If you make a team above the citizen team, people will spawn with that team!
--------------------------------------------------------*/
TEAM_CITIZEN = AddExtraTeam("Citizen", Color(20, 150, 20, 255), "models/player/group01/male_01.mdl", [[The Citizen is the most basic level of society you can hold
besides being a hobo. 
You have no specific role in city life.]], {}, "citizen", 0, 45, 0, false, false)

TEAM_UNDERCOVERCOP = AddExtraTeam("UnderCover Cop", Color(20, 150, 20, 255), "models/player/group01/male_01.mdl", [[Fight the law from the underground.
]], {"arrest_stick", "unarrest_stick", "weapon_real_cs_glock18", "stunstick", "door_ram", "weaponchecker", "item_ammo_pistol"}, "undercovercop", 2, 50, 0, false, false, TEAM_POLICE)

TEAM_HOBO = AddExtraTeam("Hobo", Color(80, 45, 0, 255), "models/player/corpse1.mdl", [[The lowest member of society. All people see you laugh. 
You have no home.
Beg for your food and money
Sing for everyone who passes to get money
Make your own wooden home somewhere in a corner or 
outside someone else's door]], {""}, "hobo", 5, 0, 0, false)

TEAM_POLICE = AddExtraTeam("Civil Protection", Color(25, 25, 170, 255), "models/player/police.mdl", [[The protector of every citizen that lives in the city . 
You have the power to arrest criminals and protect innocents. 
Hit them with your arrest baton to put them in jail
Bash them with a stunstick and they might learn better than to disobey 
the law.
The Battering Ram can break down the door of a criminal with a warrant 
for his/her arrest.
The Battering Ram can also unfreeze frozen props(if enabled).
Type /wanted <name> to alert the public to this criminal
OR go to tab and warrant someone by clicking the warrant button]], {"arrest_stick", "unarrest_stick", "weapon_real_cs_glock18", "stunstick", "door_ram", "weaponchecker", "item_ammo_pistol"}, "cp", 5, 65, 0, true, true)

TEAM_GANG = AddExtraTeam("Gangster", Color(75, 75, 75, 255), "models/player/group03/male_01.mdl", [[The lowest person of crime. 
A gangster generally works for the Mobboss who runs the crime family. 
The Mobboss sets your agenda and you follow it or you might be punished.]], {}, "gangster", 5, 45, 0, false, false)

TEAM_MOB = AddExtraTeam("Mob boss", Color(25, 25, 25, 255), "models/player/gman_high.mdl", [[The Mobboss is the crimboss in the city. 
With his power he coordinates the gangsters and forms an efficent crime
organization. 
He has the ability to break into houses by using a lockpick. 
The Mobboss also can unarrest you.]], {"lockpick", "unarrest_stick"}, "mobboss", 1, 60, 0, false, false)

TEAM_GUN = AddExtraTeam("Gun Dealer", Color(255, 140, 0, 255), "models/player/monk.mdl", [[A gun dealer is the only person who can sell guns to other 
people. 
However, make sure you aren't caught selling guns that are illegal to 
the public.
/Buyshipment <name> to Buy a  weapon shipment
/Buygunlab to Buy a gunlab that spawns P228 pistols]], {}, "gundealer", 3, 45, 0, false, false)

TEAM_MEDIC = AddExtraTeam("Medic", Color(47, 79, 79, 255), "models/player/kleiner.mdl", [[With your medical knowledge, you heal players to proper 
health. 
Without a medic, people can not be healed. 
Left click with the Medical Kit to heal other players.
Right click with the Medical Kit to heal yourself.]], {"med_kit"}, "medic", 3, 45, 0, false, false)

TEAM_COOK = AddExtraTeam("Cook", Color(238, 99, 99, 255), "models/player/mossman.mdl", [[As a cook, it is your responsibility to feed the other members 
of your city. 
You can spawn a microwave and sell the food you make:
/Buymicrowave]], {}, "cook", 2, 45, 0, 0, false)

TEAM_CHIEF = AddExtraTeam("Civil Protection Chief", Color(20, 20, 255, 255), "models/player/combine_soldier_prisonguard.mdl", [[The Chief is the leader of the Civil Protection unit. 
Coordinate the police forces to bring law to the city
Hit them with arrest baton to put them in jail
Bash them with a stunstick and they might learn better than to 
disobey the law.
The Battering Ram can break down the door of a criminal with a 
warrant for his/her arrest.
Type /wanted <name> to alert the public to this criminal
Type /jailpos to set the Jail Position]], {"arrest_stick", "unarrest_stick", "weapon_real_cs_desert_eagle", "stunstick", "door_ram", "weaponchecker", "item_ammo_pistol"}, "chief", 1, 75, 0, false, true, TEAM_POLICE)

TEAM_MAYOR = AddExtraTeam("Mayor", Color(150, 20, 20, 255), "models/player/breen.mdl", [[The Mayor of the city creates laws to serve the greater good 
of the people.
If you are the mayor you may create and accept warrants.
Type /wanted <name>  to warrant a player
Type /jailpos to set the Jail Position
Type /lockdown initiate a lockdown of the city. 
Everyone must be inside during a lockdown. 
The cops patrol the area
/unlockdown to end a lockdown]], {"item_ammo_pistol"}, "mayor", 1, 85, 0, true, false/*, {TEAM_CHIEF, TEAM_POLICE}*/)

TEAM_BURG = AddExtraTeam("Burglar", Color(205, 201, 201, 255), "models/player/leet.mdl", [[Burglarize peoples houes, steal all you want.
But, it is AGAINST THE LAW.
You will be arrest if a cop SEES you do it.
(in JRRP atleast)]], {"lockpick", "keypad_cracker"}, "burglar", 2, 50, 0, false)

TEAM_NINJA = AddExtraTeam("Ninja", Color(51, 204, 255, 255), "models/player/urban.mdl", [[Rope around.
Be a ninja.]], {}, "ninja", 1, 50, 3, false, false)

TEAM_DRUGDEALER = AddExtraTeam("Drug Dealer", Color(0, 102, 0, 255), "models/player/guerilla.mdl", [[Sell drugs to the local inhabitants,
 but dont get caught they are illegal!]], {}, "drugdealer", 2, 50, 0, false, false)
 
TEAM_BAROWNER = AddExtraTeam("Bar Owner", Color(51, 0, 0, 255), "models/player/magnusson.mdl", [[Sell beer and cigarettes to the local inhabitants.
]], {}, "barowner", 2, 50, 0, false, false)

TEAM_STRIPPER = AddExtraTeam("Stripper", Color(255, 102, 255, 255), "models/player/alyx.mdl", [[Shake that ass and earn a living.
It is not illegal to strip in a bar.
(Yes, you should get tips from watchers.)]], {}, "stripper", 2, 50, 0, false, false)

TEAM_ADMIN = AddExtraTeam("Admin", Color(255, 0, 0, 255), "models/player/combine_super_soldier.mdl", [[Admin.
Enough said.]], {""}, "admin", 1, 100, 3, false, true)

TEAM_HIT = AddExtraTeam("Hitman", Color(20, 150, 20, 255), "models/player/group01/male_01.mdl", [[Kill people for money.
It is aganst the law to murder, you will be arrested.
Only kill people if someone pays you to kill them. Or else its RDM]], {"weapon_real_cs_knife"}, "hitman", 1, 50, 0, false, false)


TEAM_BODYGUARD = AddExtraTeam("Body Guard", Color(0, 204, 204, 255), "models/player/odessa.mdl", [[Guard people or stores be on either side of the law but be careful,
your not on the police force.]], {"stunstick"}, "bodyguard", 2, 50, 0, false, false)

TEAM_JUNKSELLER = AddExtraTeam("Junk Seller", Color(102, 51, 0, 255), "models/player/eli.mdl", [[Sell asprin,keypad crackers, lockpicks, and more.
]], {}, "junkseller", 2, 50, 0, false, false)

TEAM_BOXER = AddExtraTeam("Boxer", Color(255, 102, 0, 255), "models/player/barney.mdl", [[Fight in the ring for prize money.
Be sure to consult your bookie to set up fights.]], {"hl2_combo_fists"}, "boxer", 2, 50, 0, false, false)

TEAM_BOOKIE = AddExtraTeam("Bookie", Color(204, 51, 0, 255), "models/player/group01/Male_09.mdl", [[Set up fights and take a commission from the boxers.
Be careful not to get caught by the cops!]], {"med_kit"}, "bookie", 1, 60, 0, false, false)

TEAM_MAYORSPROTECTOR = AddExtraTeam("Mayor's Protector", Color(153, 0, 0, 255), "models/player/swat.mdl", [[Protect they mayor with your life.
]], {"weapon_real_cs_desert_eagle", "weaponchecker"}, "mayorsprotector", 1, 50, 0, true, true)

TEAM_TERRORIST = AddExtraTeam("Terrorist", Color(204, 102, 0, 255), "models/player/charple01.mdl", [[Your job is simple take over the police department and kill 
the mayor at any cost.
ANY CIVILIANS KILLED WILL BE CONNCIDERED RDM
ALL TERRORIST ATTACKS MUST BE ORGANIZED]], {}, "terrorist", 3, 45, 0, true, false)

TEAM_TEST = AddExtraTeam("Test", Color(255, 102, 255, 255), "models/player/combine_super_soldier.mdl", [[Shake that ass and earn a living.
It is not illegal to strip in a bar.
(Yes, you should get tips from watchers.)]], {}, "test", 2, 50, 3, false, false)


TEAM_CARDEALER = AddExtraTeam("Cardealer", Color(0, 204, 0, 255), "models/player/Hostage/Hostage_02.mdl", [[Sell cars to the local population]], {}, "cardealer", 1, 45, 0, false, false)

TEAM_TLEAD = AddExtraTeam("Osama ", Color(255, 120, 0, 255), "models/player/charple01.mdl" , [[You leads the terrorist forces.
Controll your terrorist minions to take over the city.
Your you must take the mayor hostage and give the CP demands for his safe return.
Should the CP fail to comply with your demands, the mayor is free game.
THIS CLASS IS NOT TO BE USED TO KILL THE MAYOR WITH REDICULOUS DEMANDS
Only raid the CP building/take the mayor hostage every 20-25 minutes because constant raids ruin the RP. ]] , {"unarrest_stick", "lockpick"} , "osama", 1, 75, 0, false, true, TEAM_TERRORIST)
