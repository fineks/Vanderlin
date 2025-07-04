/datum/job/merchant
	title = "Kupec"
	tutorial = "Ты прибыл в город из далёких земель. Возможно из золотых земель, а возможно из морозных гор.\
	Здесь, в Крыльске, молвят водятся деньги. Вокруг полно диковинок, крепостные рассматривают товар давясь слюной, так и жаждая весь его скупить...\
	Теперь дело за малым - покупаешь дёшево, продаёшь дорого, и помнить что здесь ты всего-лишь гость. И в случаи чего - тебе есть куда бежать."
	flag = MERCHANT
	department_flag = COMPANY
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE )
	display_order = JDO_MERCHANT
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0
	bypass_lastclass = TRUE
	selection_color = "#192bc2"
	cmode_music = 'sound/music/cmode/towner/CombatTowner2.ogg'

	allowed_races = list(
		RACE_ELF,
		RACE_DWARF,
		RACE_TIEFLING,
		RACE_DROW,
	)

	outfit = /datum/outfit/job/merchant
	give_bank_account = 100

/datum/outfit/job/merchant/pre_equip(mob/living/carbon/human/H)
	..()

	neck = /obj/item/clothing/neck/horus
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/veryrich = 1, /obj/item/merctoken = 1)
	beltr = /obj/item/weapon/sword/rapier
	belt = /obj/item/storage/belt/leather/plaquegold
	beltl = /obj/item/storage/keyring/merchant
	armor = /obj/item/clothing/shirt/robe/merchant
	head = /obj/item/clothing/head/chaperon/greyscale/silk/random
	ring = /obj/item/clothing/ring/gold/guild_mercator

	if(H.gender == MALE)
		shirt = /obj/item/clothing/shirt/undershirt/sailor
		pants = /obj/item/clothing/pants/tights/sailor
		shoes = /obj/item/clothing/shoes/boots/leather
	else
		shirt = /obj/item/clothing/shirt/tunic/blue
		shoes = /obj/item/clothing/shoes/gladiator

	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	ADD_TRAIT(H, TRAIT_TOLERANT, type)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, type)

	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_PER, 1)
	H.change_stat(STATKEY_SPD, 1)

	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 6, TRUE)
