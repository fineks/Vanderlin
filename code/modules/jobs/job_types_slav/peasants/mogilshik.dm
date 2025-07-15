/datum/job/undertaker
	title = "Mogilshik"
	tutorial = "Подлая отцеубийца Некра лишилась власти. \
	Зизо обретя новую силу, забрала у неё все пленённый в мёртвом мире души, \
	и дала им наконец заслуженный покой, и перерождение. В кару за свои деяния \
	относительно душ смертных, Некра была сама закрыта в своём мире уже воскресшим Псидоном, на едине с собой... \
	Теперь ты заменяешь Некритов, и помогаешь душам упокоится. Придавая их земле, либо выполняя последние желания."
	flag = GRAVETENDER
	department_flag = CHURCHMEN
	display_order = JDO_GRAVETENDER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 3
	spawn_positions = 3
	min_pq = -10
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Humen","Dwarf","Elf","Harpy","Dark Elf")
	allowed_patrons = list(/datum/patron/divine/zizo)

	outfit = /datum/outfit/job/undertaker
	give_bank_account = TRUE
	cmode_music = 'sound/music/cmode/church/CombatGravekeeper.ogg'

/datum/outfit/job/undertaker
	allowed_patrons = list(/datum/patron/divine/zizo)
	job_bitflag = BITFLAG_CHURCH

/datum/outfit/job/undertaker/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/roguehood/black
	neck = /obj/item/clothing/neck/highcollier/iron
	pants = /obj/item/clothing/pants/tights/black
	armor = /obj/item/clothing/armor/leather/jacket/leathercoat/black
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather/black
	beltl = /obj/item/storage/keyring/gravetender
	beltr = /obj/item/storage/belt/pouch/coins/poor
	backr = /obj/item/weapon/shovel
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_END, 2)

	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC) // Operating with corpses every day.
	ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC) // In case they need to move tombs or anything.
	ADD_TRAIT(H, TRAIT_SOUL_EXAMINE, TRAIT_GENERIC)
	var/datum/devotion/cleric_holder/C = new /datum/devotion/cleric_holder(H, H.patron)
	H.verbs += list(/mob/living/carbon/human/proc/devotionreport, /mob/living/carbon/human/proc/clericpray)
	C.grant_spells(H)
