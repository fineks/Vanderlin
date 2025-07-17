/datum/job/miner
	title = "Подёнщик"
	tutorial = "Ваше племя было на грани уничтожения более сильными племенами. Вы решили совершить нечто очень безумное - \
	обратится за помощью к людям. К удивлению они пустили вас в город! И даже дали вам уголок где царят ваши правила!\
	Главное слушатся вождя-князя и босса-ключника!."
	flag = MINER
	department_flag = PEASANTS
	display_order = JDO_MINER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 12
	spawn_positions = 12
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/miner
	cmode_music = 'sound/music/cmode/towner/CombatTowner2.ogg'

/datum/outfit/job/miner
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/miner/pre_equip(mob/living/carbon/human/H)
	..()
	belt = /obj/item/storage/belt/leather
	neck = /obj/item/storage/belt/pouch/coins/poor
	backl = /obj/item/storage/backpack/backpack
	backpack_contents = list(/obj/item/flint = 1, /obj/item/weapon/knife/villager = 1, /obj/item/storage/keyring/artificer = 1)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/lumberjacking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_INT, -3)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 1)
