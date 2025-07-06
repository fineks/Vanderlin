/datum/job/bapprentice
	title = "Krisolyud pomoshnik"
	tutorial = "Ты был обычной канализационной крысой, не многим лучше тех что ползают на четвереньках до момента знакомства с ковалем. \
	Он научил тебя уму-разуму, какой стороной держать молоток, и какого бога стоит славить! Слава Псидону всеотцу! \
	Теперь в благодарность ты обязан ему служить."
	flag = APPRENTICE
	department_flag = APPRENTICES
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2

	allowed_races = RACES_PLAYER_ALL
	allowed_ages = list(AGE_ADULT, AGE_MIDDLEAGED)
	allowed_sexes = list(MALE)

	outfit = /datum/outfit/job/bapprentice
	display_order = JDO_BAPP
	give_bank_account = TRUE
	min_pq = -10
	bypass_lastclass = TRUE

	can_have_apprentices = FALSE

/datum/outfit/job/bapprentice
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/bapprentice/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/blacksmithing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/armorsmithing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/weaponsmithing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/craft/smelting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
		belt = /obj/item/storage/belt/leather/rope
		beltr = /obj/item/key/blacksmith
		backr = /obj/item/storage/backpack/satchel
		H.change_stat(STATKEY_END, 2)
		H.change_stat(STATKEY_SPD, 1)
