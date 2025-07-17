/datum/job/prince
	title = "Княжич"
	f_title = "Княжна"
	tutorial = "Ты родился в жестокой и грубой семье, \
	в семье князя Крыльска. Но даже так ты не знал тяжести работы и нужды в чём-то. \
	Тебе стоило только учится защищать себя и престол от посягательств. \
	И пускай сейчас твой отец или мать правит этой землёй, и обеспечивает тебя всем что нужно: \
	однажды тебе придётся самостоятельно занять престол. И твоя репутация бездельника может сподвигнуть крепостных к чему-то..."
	flag = PRINCE
	department_flag = APPRENTICES
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE )
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2
	allowed_races = list(
		"Humen",
		"Half-Elf",
		"Tiefling",
		"Dwarf"
	)

	spells = list(
		/obj/effect/proc_holder/spell/self/grant_title,
	)

	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_ADULT, AGE_CHILD)
	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'
	advclass_cat_rolls = list(CTAG_HEIR = 20)

	display_order = JDO_PRINCE
	give_bank_account = TRUE
	bypass_lastclass = TRUE
	min_pq = 0

	can_have_apprentices = FALSE
	noble_income = 20

/datum/job/prince/after_spawn(mob/living/carbon/spawned, client/player_client)
	. = ..()
	var/mob/living/carbon/human/H = spawned
	addtimer(CALLBACK(SSfamilytree, TYPE_PROC_REF(/datum/controller/subsystem/familytree, AddRoyal), H, FAMILY_PROGENY), 5 SECONDS)
	if(GLOB.keep_doors.len > 0)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(know_keep_door_password), H), 5 SECONDS)
	ADD_TRAIT(H, TRAIT_KNOWKEEPPLANS, TRAIT_GENERIC)

/datum/advclass/heir
	displays_adv_job = FALSE

/datum/advclass/heir/daring
	name = "Будущий воевода"
	tutorial = "Твой родитель своими деяниями сподвиг тебя учится военному делу. В первую очередь дабы не повторить судьбы твоего второго родителя..."
	outfit = /datum/outfit/job/heir/daring
	category_tags = list(CTAG_HEIR)

/datum/outfit/job/heir/daring/pre_equip(mob/living/carbon/human/H)
	..()
	pants = /obj/item/clothing/pants/tights
	shirt = /obj/item/clothing/shirt/undershirt/guard
	armor = /obj/item/clothing/armor/chainmail
	shoes = /obj/item/clothing/shoes/nobleboot
	belt = /obj/item/storage/belt/leather/black
	beltl = /obj/item/weapon/sword
	beltr = /obj/item/key/manor
	head = /obj/item/clothing/head/crown/circlet
	neck = /obj/item/storage/belt/pouch/coins/rich
	backr = /obj/item/storage/backpack/satchel
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_SPD, -1) //сохраняй позцию. не метайся по полю бою как угорелый
	H.change_stat(STATKEY_LCK, -2) //если у тебя здохла мать или ты рос без отца - удачей это не назвать
	ADD_TRAIT(H, TRAIT_SHARPER_BLADES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BREADY, TRAIT_GENERIC)

/datum/advclass/heir/aristocrat
	name = "Дитя производства"
	tutorial = "Родители были больше заняты склоками между собой, чем твоим воспитанием. Ты часто убегал в дом ключника, где ел  его пряники с чаем. А он учил тебя уму-разуму."
	outfit = /datum/outfit/job/heir/aristocrat
	category_tags = list(CTAG_HEIR)

/datum/outfit/job/heir/aristocrat/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_AMAZING_BACK, TRAIT_GENERIC)
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/key/manor
	beltr = /obj/item/storage/belt/pouch/coins/rich
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/trou/leather
		shirt = /obj/item/clothing/shirt/dress/royal/prince
		belt = /obj/item/storage/belt/leather
		shoes = /obj/item/clothing/shoes/nobleboot
	if(H.gender == FEMALE)
		belt = /obj/item/storage/belt/leather/cloth/lady
		head = /obj/item/clothing/head/articap
		shirt = /obj/item/clothing/shirt/dress/royal/princess
		shoes = /obj/item/clothing/shoes/shortboots
		pants = /obj/item/clothing/pants/trou/leather
		H.virginity = TRUE
	H.adjust_skillrank(/datum/skill/combat/bows, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, pick(0,1), TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, pick(0,1), TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 5, TRUE)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_LCK, -2)
	H.change_stat(STATKEY_SPD, 1)

/datum/advclass/heir/inbred
	name = "Авантюрист"
	tutorial = "Ветер шальной гонит туман мыслей твоих, ой, хулиган вслед за грозой мчит хитрый лис, он как и ты - авантюрист! Плевать на родителей. Дорога приключений зовёт!."
	outfit = /datum/outfit/job/heir/inbred
	category_tags = list(CTAG_HEIR)

/datum/outfit/job/heir/inbred/pre_equip(mob/living/carbon/human/H)
	..()
	ADD_TRAIT(H, TRAIT_ZJUMP, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/key/manor
	beltr = /obj/item/storage/belt/pouch/coins/rich
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/trou/leather/advanced
		shirt = /obj/item/clothing/shirt/undershirt/fancy
		head = /obj/item/clothing/head/crown/nyle
		belt = /obj/item/storage/belt/leather
		shoes = /obj/item/clothing/shoes/boots
	if(H.gender == FEMALE)
		belt = /obj/item/storage/belt/leather/cloth/lady
		head = /obj/item/clothing/head/crown/nyle
		shirt = /obj/item/clothing/shirt/ornate/tunic
		shoes = /obj/item/clothing/shoes/boots
		pants = /obj/item/clothing/pants/trou/leather/advanced
		H.virginity = TRUE

	H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, pick(1,2), TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, pick(4,4,5), TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, pick(2,3), TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	if(H.gender == FEMALE)
		H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)

	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_PER, 3)
	H.change_stat(STATKEY_CON, 1)
	H.change_stat(STATKEY_END, 3)
	H.change_stat(STATKEY_SPD, 2)
	H.change_stat(STATKEY_LCK, -3) //Ты вообще отверг своих родителей. Сама судьба на тебя в обиде
