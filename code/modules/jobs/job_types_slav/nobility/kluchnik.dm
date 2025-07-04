/datum/job/steward
	title = "Kluchnik"
	tutorial = "Служение князю, и управление его хозяйством: \
	твой главный долг. Князь положился на тебя и даровал тебе право управления над челядью. \
	Ты превращаешь голое поле в посевы, лес в доски, детей в беспплатных рабочих, а обыкновенные вещи в деньги. \
	Тебе предстоит наполнение казны его величества, и нахождение работы для каждого крепостного. Крыльск - не место для бездельников."
	flag = STEWARD
	department_flag = NOBLEMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_STEWARD
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED

	outfit = /datum/outfit/job/steward
	give_bank_account = 140
	noble_income = 16
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'

/datum/outfit/job/steward
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/steward/pre_equip(mob/living/carbon/human/H)
	..()
	H.virginity = TRUE

	ADD_TRAIT(H, TRAIT_SEEPRICES, type)
	shoes = /obj/item/clothing/shoes/simpleshoes/buckle
	head = /obj/item/clothing/head/stewardtophat
	shirt = /obj/item/clothing/shirt/ornate/tunic
	cloak = /obj/item/clothing/cloak/raincloak/furcloak
	armor = /obj/item/clothing/armor/gambeson/steward
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltr = /obj/item/storage/keyring/steward
	beltl = /obj/item/weapon/knife/dagger/steel
	backr = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/belt/pouch/coins/rich = 1, /obj/item/lockpickring/mundane = 1)

	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 6, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 5, TRUE)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_INT, 5)
	H.change_stat(STATKEY_CON, -1)
	ADD_TRAIT(H, TRAIT_MATTHIOS_EYES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEDKNOW , TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEPRICES , TRAIT_GENERIC)
