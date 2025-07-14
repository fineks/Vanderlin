/datum/job/rihtarzh
	title = "Rihtarzh"
	tutorial = "Ты много лет был на службе у князя. Взамен ты получил один из высших постов. \
	Рихтарж занимается управлением землёй своего князя, пока тому нет до неё дела. Ты охранник порядка, судья и палач. \
	Люди считают тебя своим первым защитником и своим худшим карателем. Пока князь устанавливает законы - ты заставляешь всех повиноватся \
	этим законам за любую цену. Князь расчитывает на тебя и твои силы. А крепостные расчитывают на твоё чувство справедливости."
	flag = DUNGEONEER
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_DUNGEONEER
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list (RACE_HUMEN)
	allowed_ages = list(AGE_OLD, AGE_IMMORTAL)

	outfit = /datum/outfit/job/dungeoneer
	give_bank_account = 50

	cmode_music = 'sound/music/cmode/nobility/CombatDungeoneer.ogg'

/datum/outfit/job/dungeoneer
	job_bitflag = BITFLAG_GARRISON

/datum/outfit/job/dungeoneer/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/townwatch/gatemaster
	neck = /obj/item/clothing/neck/coif/cloth
	pants = /obj/item/clothing/pants/chainlegs
	shoes = /obj/item/clothing/shoes/boots/armor/light
	wrists = /obj/item/clothing/wrists/bracers/leather
	gloves = /obj/item/clothing/gloves/chain
	cloak = /obj/item/clothing/cloak/half/vet
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/weapon/flail/sflail
	shirt = /obj/item/clothing/armor/gambeson
	armor = /obj/item/clothing/armor/leather/jacket/gatemaster_jacket/armored
	beltl = /obj/item/storage/keyring/dungeoneer
	backr = /obj/item/storage/backpack/satchel


	H.adjust_skillrank(/datum/skill/combat/whipsflails, 6, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 3, TRUE)
	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_INT, 3)
	H.change_stat(STATKEY_END, 3)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_SPD, 1)
	H.change_stat(STATKEY_PER, 1)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)

	if(H.dna?.species)
		if(H.dna.species.id == "human")
			H.dna.species.soundpack_m = new /datum/voicepack/male/warrior()
	H.verbs |= /mob/living/carbon/human/proc/torture_victim
