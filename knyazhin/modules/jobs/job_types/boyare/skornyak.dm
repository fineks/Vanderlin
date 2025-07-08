/datum/job/skornyak
	title = "Skornyak"
	tutorial = "Такие как ты - становятся именитыми мастерами, что служат при царе. \
	Но ты смог отличится на фоне всех остальных, и застрял в этом затхлом городке где пропиваешь свой талант в близжайшей корчме. \
	Твои руки способны творить шедевры, или даже могучие артефакты. Именно тебе предстоит свежевать тела могучих тварей которых тебе носят всяческие заправские герои. \
	К сожалению, в Крыльске почти не осталось достойных врагов из которых можно сделать хотя-бы плащ..."
	flag = FELDSHER
	department_flag = NOBLEMEN
	display_order = JDO_FELDSHER
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0

	//Reason all races allowed is you are basically a very talented court physician; even 'lower races' would find this to be one of the only ways to obtain a sort of nobility.
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONEXOTIC


	outfit = /datum/outfit/job/feldsher
	give_bank_account = 100
	cmode_music = 'sound/music/cmode/nobility/combat_physician.ogg'

/datum/outfit/job/feldsher
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/feldsher/pre_equip(mob/living/carbon/human/H)
	..()
	shoes = /obj/item/clothing/shoes/boots
	shirt = /obj/item/clothing/shirt/undershirt/green
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/storage/backpack
	pants = /obj/item/clothing/pants/trou/leather
	gloves = /obj/item/clothing/gloves/leather
	armor = /obj/item/clothing/armor/gambeson/light
	head = /obj/item/clothing/head/helmet/medium/decorated/skullmet
	neck = /obj/item/clothing/neck/menears
	belt = /obj/item/storage/belt/leather
	cloak = /obj/item/clothing/cloak/wardencloak
	backpack_contents = list(/obj/item/weapon/knife/hunting)

	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/tanning, 4, TRUE)
	H.adjust_skillrank(/datum/skill/labor/taming, 5, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 5, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 6, TRUE)

	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/craft/alchemy, 1, TRUE)
		H.adjust_skillrank(/datum/skill/craft/tanning, 1, TRUE)
	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_CON, 1)

	ADD_TRAIT(H, TRAIT_LEGENDARY_ALCHEMIST, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
