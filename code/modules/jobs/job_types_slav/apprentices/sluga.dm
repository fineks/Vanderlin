/datum/job/servant
	title = "Sluga"
	tutorial = "Ты всю жизнь прорывался через сложности и неуладицы, и смог стать прислугой в усадьбе князя. \
	Житие твоё теперь принадлежит всецело владыке в обмен на его защиту. Не подведи его, и тебе воздастся"
	flag = SERVANT
	department_flag = APPRENTICES
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_SERVANT
	faction = FACTION_TOWN
	total_positions = 4
	spawn_positions = 4
	min_pq = -20
	bypass_lastclass = TRUE

	allowed_races = list("Humen","Dwarf","Elf","Dark Elf","Tiefling","Harpy","Triton","Kobold")
	allowed_sexes = list(MALE)

	outfit = /datum/outfit/job/servant
	give_bank_account = TRUE

	can_have_apprentices = FALSE

/datum/outfit/job/servant/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/simpleshoes
	pants = /obj/item/clothing/pants/tights/uncolored
	shirt = /obj/item/clothing/shirt/undershirt/uncolored
	belt = /obj/item/storage/belt/leather/rope
	beltl = /obj/item/storage/belt/pouch/coins/poor
	neck = /obj/item/key/manor
	armor = /obj/item/clothing/armor/leather/vest/black

	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/stealing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/music, 3, TRUE)
	H.change_stat(STATKEY_SPD, 2)
	H.change_stat(STATKEY_END, 1)
	backpack_contents = list(/obj/item/recipe_book/cooking = 1)
