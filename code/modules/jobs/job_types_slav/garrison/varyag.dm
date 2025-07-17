/datum/advclass/combat/vikingr
	name = "Варяг"
	tutorial = "Отец князя оставил тебя как своего гвардейца приглядеть за потомком. Ты решил что чадо уже выросло и ушёл кутить... Твоя форма уже не та"
	outfit = /datum/outfit/job/adventurer/vikingr
	category_tags = list(CTAG_ADVENTURER)
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2
	min_pq = 0
	cmode_music = 'sound/music/cmode/adventurer/CombatWarrior.ogg'

	allowed_sexes = list(MALE, FEMALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	allowed_races = list("Humen","Dwarf","Tiefling","Elf")

	give_bank_account = 30
/datum/outfit/job/adventurer/vikingr/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/knives, pick(1,1,2), TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)

	if(H.gender == FEMALE)
		H.underwear = "Femleotard"
		H.underwear_color = CLOTHING_SOOT_BLACK
		H.update_body()
	shoes = /obj/item/clothing/shoes/boots/armor/light
	gloves = /obj/item/clothing/gloves/leather
	wrists = /obj/item/clothing/wrists/bracers/leather
	neck = /obj/item/clothing/neck/highcollier/iron
	armor = /obj/item/clothing/armor/chainmail/iron
	belt = /obj/item/storage/belt/leather/steel
	pants = /obj/item/clothing/pants/trou/leather
	backl = /obj/item/weapon/shield/wood
	backr = /obj/item/weapon/polearm/halberd/bardiche/woodcutter
	beltr = /obj/item/storage/belt/pouch/coins/rich //Ты ещё не успел пропить ВСЁ
	head = /obj/item/clothing/head/helmet/nasal
	beltl = /obj/item/weapon/axe/battle
	backpack_contents = list(/obj/item/key/manor, /obj/item/key/garrison)

	H.change_stat(STATKEY_STR, 2) // Варяги сильные... но ты весьма ослаб
	H.change_stat(STATKEY_END, 2) //Всё ещё хватит сил залпом выжрать пару бочек пива
	H.change_stat(STATKEY_CON, 1) // Бронепивное пузо
	H.change_stat(STATKEY_INT, -2) // Сила есть ума не надо
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC) //Варяг относительно лёгкая пехота
	ADD_TRAIT(H, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BETTER_SLEEP, TRAIT_GENERIC) //солдат спит служба идёт
