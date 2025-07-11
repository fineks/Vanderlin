/datum/job/grabber
	title = "Chumak"
	tutorial = "Ранее ты занимался перевозками товаров меж городами и деревнями чем и зарабатывал на жизнь. \
	Однако со временем магия стала замещать твой труд мгновеным перемещением. И тебе пришлось искать работу в ином месте. \
	И так-уж вышло что ты попал на рабоут к иностранному купцу. Ну, куда деватся?"
	flag = GRABBER
	department_flag = COMPANY
	display_order = JDO_GRABBER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 4
	spawn_positions = 4
	min_pq = -50
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Humen","Dwarf","Elf","Dark Elf","Tiefling")

	outfit = /datum/outfit/job/grabber
	give_bank_account = TRUE
	cmode_music = 'sound/music/cmode/towner/CombatTowner2.ogg'

/datum/outfit/job/grabber/pre_equip(mob/living/carbon/human/H)
	..()

	H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE) // Ломать лица разбойникам тоже надо уметь
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE) // Иногда надо читать контракты
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE) // Переправы строить не легко
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE) // Иногда надо искать новые маршруты
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 1, TRUE) // как казаки соль покупали

	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 1)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_INT, -1)
	backr = /obj/item/storage/backpack/satchel
	wrists = /obj/item/clothing/wrists/bracers/leather
	gloves = /obj/item/clothing/gloves/fingerless
	neck = /obj/item/storage/belt/pouch/coins/poor
	shirt = /obj/item/clothing/armor/gambeson/light
	pants = /obj/item/clothing/pants/tights/sailor
	belt = /obj/item/storage/belt/leather/rope
	beltr = /obj/item/weapon/mace/cudgel
	beltl = /obj/item/weapon/sword/sabre
	backpack_contents = list(/obj/item/storage/keyring/stevedore)
	if(H.gender == MALE)
		shoes = /obj/item/clothing/shoes/boots
		head = /obj/item/clothing/head/headband/red
		H.change_stat(STATKEY_CON, 1)
		H.change_stat(STATKEY_STR, 1)//thug bodytype
	else
		shoes = /obj/item/clothing/boots
		head = /obj/item/clothing/head/headband
		H.change_stat(STATKEY_LCK, 1)
		H.change_stat(STATKEY_SPD, 1)
	ADD_TRAIT(H, TRAIT_CRATEMOVER, type)
