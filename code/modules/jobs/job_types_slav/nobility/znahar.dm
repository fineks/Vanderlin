/datum/job/courtphys
	title = "Znahar"
	tutorial = "Ты старался пол жизни, из кожи вон лез за своей мечтой, и всё-таки смог попасть в ученики скорняка. \
	Пускай он особо не делится с тобой своими знаниями, пускай он порой проклинает тебя за твои умственные способности, но ты веришь - однажды достигнешь его уровня. \
	А пока тебе не доверяют разделку тварей, варку отваров и сотворение артефактов - ты растишь для мастера ингредиенты, и лечишь народ от хворей дабы заработать."
	flag = PHYSICIAN
	department_flag = NOBLEMEN
	display_order = JDO_PHYSICIAN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0

	allowed_ages = list(AGE_ADULT)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED

	outfit = /datum/outfit/job/courtphys
	give_bank_account = 100
	cmode_music = 'sound/music/cmode/nobility/combat_physician.ogg'

/datum/outfit/job/courtphys
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/courtphys/pre_equip(mob/living/carbon/human/H)
	. = ..()
	H.virginity = TRUE
	shoes = /obj/item/clothing/shoes/shortboots
	shirt = /obj/item/clothing/shirt/tunic/green
	backr = /obj/item/storage/backpack/satchel
	backl = /obj/item/storage/backpack/satchel/surgbag
	gloves = /obj/item/clothing/gloves/leather/feld
	head = /obj/item/clothing/head/helmet/leather/volfhelm
	mask = /obj/item/clothing/face/skullmask
	neck = /obj/item/clothing/neck/bogcowl
	belt = /obj/item/storage/belt/leather
	beltl = /obj/item/storage/keyring/physician
	cloak = /obj/item/clothing/cloak/wickercloak
	pants = /obj/item/clothing/pants/skirt/green

	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sewing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 4, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/butchering, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 1, TRUE)

	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_INT, 2)
	H.change_stat(STATKEY_CON, -1)
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSTINK, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_FORAGER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SEEDKNOW, TRAIT_GENERIC)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/diagnose/secular)
