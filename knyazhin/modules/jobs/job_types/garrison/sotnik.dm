/datum/job/sotnik
	title = "Sotnik"
	tutorial = "Ты служишь князю немало лет верой и правдой. \
	Он доверил тебе власть над всеми своими войсками в городе и в его округе, \
	дабы ты защищал его землю и его величество непосредственно."
	flag = CAPTAIN
	department_flag = NOBLEMEN
	display_order = JDO_CAPTAIN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_races = list(
		"Humen",
		"Dwarf"
	)

	outfit = /datum/outfit/job/captain
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/guard)
	give_bank_account = 120
	cmode_music = 'sound/music/cmode/antag/CombatSausageMaker.ogg'
	noble_income = 11

/datum/job/captain/after_spawn(mob/living/spawned, client/player_client)
	..()
	var/mob/living/carbon/human/H = spawned
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Sotnik"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"

/datum/outfit/job/captain
	job_bitflag = BITFLAG_ROYALTY | BITFLAG_GARRISON

/datum/outfit/job/captain/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/visored/captain
	gloves = /obj/item/clothing/gloves/chain
	pants = /obj/item/clothing/pants/platelegs/captain
	armor = /obj/item/clothing/armor/captain
	neck = /obj/item/clothing/neck/gorget
	shirt = /obj/item/clothing/armor/chainmail/hauberk
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/steel
	beltl = /obj/item/weapon/axe/battle
	beltr = /obj/item/weapon/mace/steel
	cloak = /obj/item/clothing/cloak/captain
	backpack_contents = list(/obj/item/storage/keyring/captain = 1, /obj/item/signal_horn = 1)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)

	H.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)

	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)

	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)

	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)

	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_CON, 3)
	H.change_stat(STATKEY_END, 3)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell

	if(H.dna?.species?.id == "human")
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

/obj/effect/proc_holder/spell/self/convertrole/guard
	name = "Recruit Strelec"
	new_role = "Strelec recruit"
	overlay_state = "recruit_guard"
	recruitment_faction = "Garrison"
	recruitment_message = "Вступай в ряды стрельцов, %RECRUIT!"
	accept_message = "Жизнь за царя!"
	refuse_message = "Я недостоин этого."

