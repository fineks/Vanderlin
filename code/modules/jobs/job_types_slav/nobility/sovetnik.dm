/datum/job/hand
	title = "Sovetnik"
	tutorial = "Жизнь за царя! Жизнь за князя!. \
	Ты верный, мудрый и умелый слуга князя что наставляет его на путь процветания. \
	Также ты его главный агент и наблюдатель. Твои выходы из усадьбы в виде инкогнито помогают собрать немало информации. \
	Также ты являешся его дланью над головой каждого неверного. Твои навыки владения кинжалом и арбалетом неоспоримы."
	flag = HAND
	department_flag = NOBLEMEN
	display_order = JDO_HAND
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	spells = list(
		/obj/effect/proc_holder/spell/self/grant_title,
	)
	min_pq = 0
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list(
		"Humen",
		"Elf",
		"Tiefling",
		"Dwarf"
	)

	outfit = /datum/outfit/job/hand
	advclass_cat_rolls = list(CTAG_HAND = 20)
	give_bank_account = 120
	noble_income = 22

/datum/outfit/job/hand
		job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/hand/pre_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()

	shoes = /obj/item/clothing/shoes/nobleboot/thighboots
	belt = /obj/item/storage/belt/leather/steel
	shirt = /obj/item/clothing/shirt/undershirt/fancy
	backr = /obj/item/storage/backpack/satchel/black
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel = 1, /obj/item/storage/keyring/hand = 1, /obj/item/paper/scroll/frumentarii/roundstart = 1)
	armor = /obj/item/clothing/armor/leather/jacket/handjacket
	pants = /obj/item/clothing/pants/tights/black
	beltr = /obj/item/weapon/sword/rapier/dec

	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives 6, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_SPD, 3)
	H.change_stat(STATKEY_PER, 3)
	H.change_stat(STATKEY_INT, 4)
	ADD_TRAIT(H, TRAIT_HEARING_SENSITIVE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
