/datum/job/armorsmith
	title = "Коваль"
	tutorial = "На твоей родине, гренцельхофте, ты как-то сильно нагрешил. \
	И что хуже всего - у тебя не хватило проффессиональных навыков, дабы на это закрыли глаза.\
	С тех пор ты был в бегах, пока не настиг Царьземли, и города Крыльска в частности.\
	Главное не напоминать местным лишний раз о своей исключительно верной вере"
	flag = BLACKSMITH
	department_flag = SERFS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0
	bypass_lastclass = TRUE

	allowed_races = list("Humen","Dwarf","Elf")

	outfit = /datum/outfit/job/armorsmith
	display_order = JDO_ARMORER
	give_bank_account = 30
	cmode_music = 'sound/music/cmode/towner/CombatTowner2.ogg'

/datum/outfit/job/armorsmith
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/armorsmith/pre_equip(mob/living/carbon/human/H)
	..()
	ring = /obj/item/clothing/ring/silver/makers_guild
	head = /obj/item/clothing/head/hatfur
	if(prob(50))
		head = /obj/item/clothing/head/hatblu
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/blacksmithing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/smelting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/traps, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 4, TRUE)
	ADD_TRAIT(H, TRAIT_MALUMFIRE, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/blacksmithing, pick(1,2), TRUE)
		H.adjust_skillrank(/datum/skill/craft/armorsmithing, pick(1), TRUE)
		H.adjust_skillrank(/datum/skill/craft/weaponsmithing, pick(1), TRUE)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/trou
		shoes = /obj/item/clothing/shoes/simpleshoes/buckle
		shirt = /obj/item/clothing/shirt/shortshirt
		belt = /obj/item/storage/belt/leather
		beltl = /obj/item/storage/belt/pouch/coins/poor
		backl =	/obj/item/weapon/hammer/sledgehammer
		beltr = /obj/item/key/blacksmith
		cloak = /obj/item/clothing/cloak/apron/brown
		H.change_stat(STATKEY_STR, 4)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -2)
	else
		pants = /obj/item/clothing/pants/trou
		armor = /obj/item/clothing/shirt/dress/gen/random
		shoes = /obj/item/clothing/shoes/shortboots
		belt = /obj/item/storage/belt/leather
		cloak = /obj/item/clothing/cloak/apron/brown
		beltl = /obj/item/storage/belt/pouch/coins/poor
		beltr = /obj/item/key/blacksmith
		backl =	/obj/item/weapon/hammer/sledgehammer
		H.change_stat(STATKEY_STR, 3)
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, -1)
	backpack_contents = list(/obj/item/recipe_book/blacksmithing = 1)
