//Gun Dealer
//AddCustomShipment("M249", "models/weapons/w_mach_m249para.mdl", "weapon_real_cs_m249", 3500, 10, true, 400, false, {TEAM_GUN})
AddCustomShipment("Galil", "models/weapons/w_rif_galil.mdl", "weapon_real_cs_galil", 4000, 10, true, 450, false, {TEAM_GUN})
AddCustomShipment("AK47", "models/weapons/w_rif_ak47.mdl", "weapon_real_cs_ak47", 2800, 10, true, 330, false, {TEAM_GUN})
AddCustomShipment("M4A1", "models/weapons/w_rif_m4a1.mdl", "weapon_real_cs_m4a1", 2800, 10, true, 330, false, {TEAM_GUN})
//AddCustomShipment("Famas", "models/weapons/w_rif_famas.mdl", "weapon_real_cs_famas", 3000, 10, true, 350, false, {TEAM_GUN})
//AddCustomShipment("AWP", "models/weapons/w_snip_awp.mdl", "weapon_real_cs_awp", 4500, 10, true, 500, false, {TEAM_GUN})
AddCustomShipment("Scout", "models/weapons/w_snip_scout.mdl", "weapon_real_cs_scout", 3700, 10, true, 420, false, {TEAM_GUN})
AddCustomShipment("SteyrAug", "models/weapons/w_rif_aug.mdl", "weapon_real_cs_aug", 3600, 10, true, 410, false, {TEAM_GUN})
AddCustomShipment("UMP45", "models/weapons/w_smg_ump45.mdl", "weapon_real_cs_ump_45", 3000, 10, true, 350, false, {TEAM_GUN})
AddCustomShipment("P90", "models/weapons/w_smg_p90.mdl", "weapon_real_cs_p90", 3200, 10, true, 370, false, {TEAM_GUN})
AddCustomShipment("TMP", "models/weapons/w_smg_tmp.mdl", "weapon_real_cs_tmp", 3500, 10, true, 400, false, {TEAM_GUN})
AddCustomShipment("MP5", "models/weapons/w_smg_mp5.mdl", "weapon_real_cs_mp5a5", 3200, 10, true, 370, false, {TEAM_GUN})
AddCustomShipment("Mac10", "models/weapons/w_smg_mac10.mdl", "weapon_real_cs_mac10", 2800, 10, true, 330, false, {TEAM_GUN})
//AddCustomShipment("AutoShotgun", "models/weapons/w_shot_xm1014.mdl", "weapon_real_cs_xm1014", 3200, 10, true, 370, false, {TEAM_GUN})
AddCustomShipment("Shotgun", "models/weapons/w_shot_m3super90.mdl", "weapon_real_cs_pumpshotgun", 4500, 10, true, 500, false, {TEAM_GUN})
//AddCustomShipment("Flash", "models/weapons/w_eq_flashbang_thrown.mdl", "weapon_real_cs_flash", 5000, 10, false, 0, false, {TEAM_GUN})
//AddCustomShipment("DualElites", "models/weapons/w_pist_elite_dropped.mdl", "weapon_real_cs_elites", 2500, 10, true, 300, false, {TEAM_GUN})
AddCustomShipment("Deagle", "models/weapons/w_pist_deagle.mdl", "weapon_real_cs_desert_eagle", 2600, 10, true, 310, false, {TEAM_GUN})
AddCustomShipment("USP", "models/weapons/w_pist_usp.mdl", "weapon_real_cs_usp", 2200, 10, true, 270, false, {TEAM_GUN})
AddCustomShipment("P228", "models/weapons/w_pist_p228.mdl", "weapon_real_cs_p228", 2000, 10, true, 250, false, {TEAM_GUN})
AddCustomShipment("Glock", "models/weapons/w_pist_glock18.mdl", "weapon_real_cs_glock18", 1800, 10, true, 230, false, {TEAM_GUN})
AddCustomShipment("FiveSeven", "models/weapons/w_pist_fiveseven.mdl", "weapon_real_cs_five-seven", 2000, 10, true, 250, false, {TEAM_GUN})
AddCustomShipment("Knife", "models/weapons/w_knife_t.mdl", "weapon_real_cs_knife", 2000, 10, true, 250, false, {TEAM_GUN, TEAM_JUNKSELLER})
AddEntity("Ammo Crate", "sent_AmmoCrate", "models/items/ammocrate_smg1.mdl", 600, 1, "/buyammocrate", TEAM_GUN)

//Hitman & UnderCover Cop

//Bar Owner
AddCustomShipment("Water", "models/drug_mod/the_bottle_of_water.mdl", "durgz_water", 75, 10, false, 10, false, {TEAM_BAROWNER, TEAM_JUNKSELLER})
AddCustomShipment("Beer", "models/drug_mod/alcohol_can.mdl", "durgz_alcohol", 100, 10, false, 10, false, {TEAM_BAROWNER})
//Drug Dealer.
AddCustomShipment("Aspirin", "models/jaanus/aspbtl.mdl", "durgz_aspirin", 100, 10, false, 10, false, {TEAM_MEDIC, TEAM_JUNKSELLER})
AddCustomShipment("Cigarettes", "models/boxopencigshib.mdl", "durgz_cigarette", 100, 10, false, 10, false, {TEAM_DRUGDEALER})
AddCustomShipment("Cocaine", "models/cocn.mdl", "durgz_cocaine", 800, 10, false, 10, false, {TEAM_DRUGDEALER})
AddCustomShipment("Heroine", "models/katharsmodels/syringe_out/syringe_out.mdl", "durgz_heroine", 10, 10, false, 10, false, {TEAM_DRUGDEALER})
AddCustomShipment("Lsd", "models/smile/smile.mdl", "durgz_lsd", 150, 10, false, 10, false, {TEAM_DRUGDEALER})
AddCustomShipment("Mushrooms", "models/ipha/mushroom_small.mdl", "durgz_mushroom", 400, 10, false, 10, false, {TEAM_DRUGDEALER})
AddCustomShipment("Weed", "models/katharsmodels/contraband/zak_wiet/zak_wiet.mdl", "durgz_weed", 200, 10, false, 10, false, {TEAM_DRUGDEALER})
//Junk Seller.
AddCustomShipment("Lock Pick", "models/weapons/w_crowbar.mdl", "lockpick", 2000, 10, false, 200, false, {TEAM_JUNKSELLER})
AddCustomShipment("Keypad Cracker", "models/weapons/w_c4.mdl", "keypad_cracker", 2200, 10, false, 220, false, {TEAM_JUNKSELLER})
AddCustomShipment("Grenades", "models/weapons/w_eq_fraggrenade.mdl", "weapon_real_cs_grenade", 5000, 10, false, 500, false, {TEAM_JUNKSELLER})
//Misc
//AddEntity("Drug lab", "drug_lab", "models/props_lab/crematorcase.mdl", 400, 3, "/buydruglab", {TEAM_GANG, TEAM_MOB})
AddEntity("Money printer", "money_printer", "models/props_c17/consolebox01a.mdl", 1000, 2, "/buymoneyprinter")
AddEntity("Microwave", "microwave", "models/props/cs_office/microwave.mdl", 400, 1, "/buymicrowave", TEAM_COOK)
//AddEntity("Gun lab", "gunlab", "models/props_c17/TrapPropeller_Engine.mdl", 500, 1, "/buygunlab", TEAM_GUN)
//AddEntity("XL Money printer", "xlmoney_printer", "models/pcmod/kopierer.mdl", 2000, 2, "/buyxlmoneyprinter")
//AddCustomVehicle("Trabbi", "models/trabbi.mdl", 2500 )
//AddCustomVehicle("Copcar", "models/copcar.mdl", 1000 {TEAM_POLICE, TEAM_CHIEF})
//AddCustomVehicle("Ferrari", "models/ferrari.mdl", 10000 )
//AddCustomVehicle("Truck", "models/tideslkw.mdl", 4000 )
//AddCustomVehicle("Jeep", "models/buggy.mdl", 2000, TEAM_CARDEALER )
//AddCustomVehicle("Airboat", "models/airboat.mdl", 5000 )

/*
How to add custom vehicles:
FIRST
go ingame, type rp_getvehicles for available vehicles!
then:
AddCustomVehicle(<One of the vehicles from the rp_getvehicles list>, <Price of the vehicle>, <OPTIONAL jobs that can buy the vehicle>)
Examples:
AddCustomVehicle("Jeep", "models/buggy.mdl", 4000 )
AddCustomVehicle("Airboat", "models/airboat.mdl", 600, {TEAM_GUN})
AddCustomVehicle("Airboat", "models/airboat.mdl", 600, {TEAM_GUN, TEAM_MEDIC})

Add those lines under your custom shipments. At the bottom of this file or in data/CustomShipments.txt

HOW TO ADD CUSTOM SHIPMENTS:
AddCustomShipment("<Name of the shipment(no spaces)>"," <the model that the shipment spawns(should be the world model...)>", "<the classname of the weapon>", <the price of one shipment>, <how many guns there are in one shipment>, <OPTIONAL: true/false sold seperately>, <OPTIONAL: price when sold seperately>, < true/false OPTIONAL: /buy only = true> , OPTIONAL which classes can buy the shipment, OPTIONAL: the model of the shipment)

Notes:
MODEL: you can go to Q and then props tab at the top left then search for w_ and you can find all world models of the weapons!
CLASSNAME OF THE WEAPON
there are half-life 2 weapons you can add:
weapon_pistol
weapon_smg1
weapon_ar2
weapon_rpg
weapon_crowbar
weapon_physgun
weapon_357
weapon_crossbow
weapon_slam
weapon_bugbait
weapon_frag
weapon_physcannon
weapon_shotgun
gmod_tool

But you can also add the classnames of Lua weapons by going into the weapons/ folder and look at the name of the folder of the weapon you want.
Like the player possessor swep in addons/Player Possessor/lua/weapons You see a folder called weapon_posessor 
This means the classname is weapon_posessor

YOU CAN ADD ITEMS/ENTITIES TOO! but to actually make the entity you have to press E on the thing that the shipment spawned, BUT THAT'S OK!
YOU CAN MAKE GUNDEALERS ABLE TO SELL MEDKITS!

true/false: Can the weapon be sold seperately?(with /buy name) if you want yes then say true else say no

the price of sold seperate is the price it is when you do /buy name. Of course you only have to fill this in when sold seperate is true.


EXAMPLES OF CUSTOM SHIPMENTS(remove the // to activate it): */

//AddCustomShipment("HL2pistol", "models/weapons/W_pistol.mdl", "weapon_pistol", 500, 10, false, 200, false, {TEAM_GUN, TEAM_MEDIC})

--EXAMPLE OF AN ENTITY(in this case a medkit)
--AddCustomShipment("bball", "models/Combine_Helicopter/helicopter_bomb01.mdl", "sent_ball", 100, 10, false, 10, false, {TEAM_GUN}, "models/props_c17/oildrum001_explosive.mdl")
--EXAMPLE OF A BOUNCY BALL:   		NOTE THAT YOU HAVE TO PRESS E REALLY QUICKLY ON THE BOMB OR YOU'LL EAT THE BALL LOL
--AddCustomShipment("bball", "models/Combine_Helicopter/helicopter_bomb01.mdl", "sent_ball", 100, 10, true, 10, true)
-- ADD CUSTOM SHIPMENTS HERE(next line):
