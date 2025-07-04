/datum/job/guardsman
	title = "Ratnik"
	tutorial = "Войны истощили человеческий ресурс Крыльска. \
	Новобранец-ли ты, али старик что пережил бойню, но теперь ты ратник \
	Тебе не хватает навыков, знаний, сил... Но есть вера в себя. И вера твоих соотечественников в тебя."
	flag = GUARDSMAN
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_CITYWATCHMEN
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2
	min_pq = 0
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE)
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
	allowed_races = list(
		"Humen",
		"Half-Elf",
		"Elf",
		"Dwarf"
	)

	outfit = /datum/outfit/job/guardsman	//Простой новобранец.
	advclass_cat_rolls = list(CTAG_GARRISON = 20)	//Handles class selection.
	give_bank_account = 30
	cmode_music = 'sound/music/cmode/garrison/CombatGarrison.ogg'

//................. City Watchmen Base .............. //
/datum/outfit/job/guardsman/pre_equip(mob/living/carbon/human/H)
	. = ..()
	cloak = pick(/obj/item/clothing/cloak/half/guard, /obj/item/clothing/cloak/half/guardsecond)
	pants = /obj/item/clothing/pants/trou/leather
	wrists = /obj/item/rope/chain
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather
	gloves = /obj/item/clothing/gloves/leather

/datum/outfit/job/guardsman/post_equip(mob/living/carbon/human/H)
	. = ..()
	if(H.cloak)
		if(!findtext(H.cloak.name,"([H.real_name])"))
			H.cloak.name = "[H.cloak.name]"+" "+"([H.real_name])"

// EVERY TOWN GUARD SHOULD HAVE AT LEAST THREE CLUB SKILL

//................. Подклассы обычного ратника .............. //
/datum/advclass/garrison/footman
	name = "Ратник новобранец"
	tutorial = "Ты недавно поступил на службу. \
	Тебя обучили пользоватся копьём и не боятся оружия. Твой путь как воина только начинается."
	outfit = /datum/outfit/job/guardsman/footman
	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/guardsman/footman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/skullcap
	neck = /obj/item/clothing/neck/chaincoif
	armor = /obj/item/clothing/armor/chainmail
	shirt = /obj/item/clothing/armor/gambeson
	backr = /obj/item/weapon/polearm/spear
	backl = /obj/item/storage/backpack/satchel/cloth
	beltl = /obj/item/weapon/axe/iron
	backpack_contents = list(/obj/item/storage/keyring/guard, /obj/item/weapon/knife/dagger/steel/special)


	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE) // Второе оружие
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE) // Основное оружие
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE) // Стена щитов основная тактика
	H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE) // Базовый уровень для любого бойца
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE) // Бывший деревенский дебошир пошёл в стражу
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_END, 3) // просто копья и прочая двуручка требует  уйму выносливости
	H.change_stat(STATKEY_CON, 1)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE) // Тренировки дали свои плоды.
	H.adjust_skillrank(/datum/skill/misc/sneaking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell

//................. Archer .............. //
/datum/advclass/garrison/archer
	name = "Ратник Застрельщик"
	tutorial = "Когда-то ты промышлял отстрелом бутылок на спор. Но судьба дала тебе шанс, реализовать себя в более полезной стезе."
	outfit = /datum/outfit/job/guardsman/archer
	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/guardsman/archer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/winged
	neck = /obj/item/clothing/neck/coif/cloth
	armor = /obj/item/clothing/armor/gambeson/light
	shirt = pick(/obj/item/clothing/shirt/undershirt/guard, /obj/item/clothing/shirt/undershirt/guardsecond)
	backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
	backl = /obj/item/storage/backpack/satchel/cloth
	beltr = /obj/item/ammo_holder/quiver/arrows
	beltl = /obj/item/weapon/mace/cudgel
	backpack_contents = list(/obj/item/storage/keyring/guard, /obj/item/weapon/knife/dagger/steel/special)
	if(H.mind)
		H.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE) // Основное оружие
		H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE) // Основное оружие на случай везения
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE) //Будь достаточно быстр дабы это тебе не пригодилось
		H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.change_stat(STATKEY_PER, 2)
		H.change_stat(STATKEY_END, 1)
		H.change_stat(STATKEY_SPD, 2)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 4, TRUE) // ищи места для стрельбы где тебе угодно
		H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
		H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
		ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
		H.verbs |= /mob/proc/haltyell

/datum/advclass/garrison/pikeman
	name = "Ратник ветеран"
	tutorial = "Ты пережил ту бойню... Война оставила тебя в живых. Ты благодарен ей, и готов показать себя вновь."
	outfit = /datum/outfit/job/guardsman/pikeman

	category_tags = list(CTAG_GARRISON)

/datum/outfit/job/guardsman/pikeman/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/heavy/rust
	armor = /obj/item/clothing/armor/chainmail
	shirt = /obj/item/clothing/armor/gambeson
	neck = /obj/item/clothing/neck/highcollier/iron
	backl = /obj/item/storage/backpack/satchel/cloth
	backr = /obj/item/weapon/shield/heater
	beltl = /obj/item/weapon/axe/battle
	backpack_contents = list(/obj/item/storage/keyring/guard, /obj/item/weapon/knife/dagger/steel/special)

	//Stats for class
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE) // Ветеран князевской войны имеет навыки в использовании топора
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE) //Однако в мобильности ты реально плох. Ничего сложнее чем бежать по следу и махать палкой ты не можешь
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE) // Долгие тренировки сделали тебя выносливым
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_SPD, -2) // Ты пережил войну не потому-что умел убегать!
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell


/mob/proc/haltyell()
	set name = "HALT!"
	set category = "Noises"
	emote("haltyell")
