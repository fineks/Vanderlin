/datum/job/archivist
	title = "Wedun"
	tutorial = "Ты собирал и хранил знания много десятков лет. Ты желал пронести их с собой через века,\
	и поэтому пошёл на сделку с ведьмой - ты лишился своей свободы и воли. Но взамен получил бессмертие.\
	Теперь тебя ждёт увлекательнейшее тысячелетие которое ты наполнишь открытиями и знаниями."
	flag = ARCHIVIST
	department_flag = NOBLEMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = 19 //lol?
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/archivist
	spells = list(/obj/effect/proc_holder/spell/self/learnspell, /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)
	give_bank_account = 100

/datum/outfit/job/archivist
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/archivist/pre_equip(mob/living/carbon/human/H)
	..()
	H.mana_pool?.set_intrinsic_recharge(MANA_ALL_LEYLINES)
	if(H.dna.species.id == "Dwarf")
		shirt = /obj/item/clothing/shirt/undershirt/puritan
		armor = /obj/item/clothing/armor/leather/jacket/apothecary
		pants = /obj/item/clothing/pants/tights/black
	else
		if(H.gender == FEMALE)
			armor = /obj/item/clothing/shirt/robe/necromancer
		else
			shirt = /obj/item/clothing/shirt/undershirt/puritan
			armor = /obj/item/clothing/shirt/robe/necromancer
			pants = /obj/item/clothing/pants/tights/black
	H.virginity = TRUE
	shoes = /obj/item/clothing/shoes/boots
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltl = /obj/item/storage/keyring/archivist
	beltr = /obj/item/book/granter/spellbook/apprentice
	backl = /obj/item/storage/backpack/satchel
	neck = /obj/item/clothing/neck/blkknight
	backpack_contents = list(/obj/item/textbook = 1, /obj/item/natural/feather)

	if(H.patron != /datum/patron/inhumen/zizo)
		H.set_patron(/datum/patron/inhumen/zizo)

	H.grant_language(/datum/language/elvish)
	H.grant_language(/datum/language/dwarvish)
	H.grant_language(/datum/language/zybantine)
	H.grant_language(/datum/language/celestial)
	H.grant_language(/datum/language/hellspeak)
	H.grant_language(/datum/language/oldpsydonic)
	H.grant_language(/datum/language/orcish)
	H.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 4, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 4, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 6, TRUE)
	H.change_stat(STATKEY_STR, 2)
	H.change_stat(STATKEY_INT, 10)
	H.change_stat(STATKEY_CON, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_SPD, 2)
	ADD_TRAIT(H, TRAIT_GRAVEROBBER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_DEATHSIGHT, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)

	H.mind?.adjust_spellpoints(14)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/mimicry)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_undead)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/self/learnspell)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)

	H?.generate_random_attunements(rand(4,6))
