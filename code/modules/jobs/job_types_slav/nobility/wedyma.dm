/datum/job/magician
	title = "Wedyma"
	tutorial = "Много лет ты провела на болоте совершенствуясь в своей стезе магии.\
	Но с приходом тёмной госпожи всё изменилось. Ты заслужила своё место в княжей усадьбе, в качестве его колдуньи\
	Теперь у тебя есть свой уголок в этом мире. А вместе с этим свой ученик в виде ведуна, и подопечные в виде новеньких послушников.\
	Теперь ты уважаемая женщина, с твоим мнением должны считатся. Главное помнить что от охотников на ведьм тебя защищает только князь..."
	flag = WIZARD
	department_flag = NOBLEMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_MAGICIAN
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0
	bypass_lastclass = TRUE

	allowed_races = list(
		"Humen"
	)
	allowed_ages = list(AGE_OLD)
	allowed_sexes = list(FEMALE)

	outfit = /datum/outfit/job/magician
	give_bank_account = 120
	cmode_music = 'sound/music/cmode/nobility/CombatCourtMagician.ogg'
	magic_user = TRUE

/datum/job/magician/New()
	if(prob(5))
		cmode_music = 'sound/music/cmode/antag/combat_evilwizard.ogg'

/datum/outfit/job/magician
	job_bitflag = BITFLAG_ROYALTY
	allowed_patrons = list(/datum/patron/divine/noc, /datum/patron/inhumen/zizo)

/datum/outfit/job/magician/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/wizhat/witch
	backr = /obj/item/storage/backpack/satchel
	shirt = /obj/item/clothing/shirt/undershirt/priest
	cloak = /obj/item/clothing/cloak/matron
	neck = /obj/item/clothing/neck/mana_star
	ring = /obj/item/clothing/ring/gold
	belt = /obj/item/storage/belt/leather/plaquesilver
	beltr = /obj/item/storage/magebag
	backl = /obj/item/weapon/polearm/woodstaff
	shoes = /obj/item/clothing/boots
	backpack_contents = list(/obj/item/scrying = 1, /obj/item/chalk = 1,/obj/item/reagent_containers/glass/bottle/killersice = 1, /obj/item/book/granter/spellbook/master = 1, /obj/item/weapon/knife/dagger/silver/arcyne = 1, /obj/item/storage/keyring/mage = 1)
	if(!(H.patron == /datum/patron/inhumen/zizo || /datum/patron/inhumen/zizo))
		H.set_patron(/datum/patron/inhumen/zizo)

	H.adjust_skillrank(/datum/skill/misc/reading, 6, TRUE)
	H.adjust_skillrank(/datum/skill/magic/arcane, 6, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 6, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 5, TRUE)

	H.grant_language(/datum/language/hellspeak)

	ADD_TRAIT(H, TRAIT_SEEPRICES, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_LEGENDARY_ALCHEMIST, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_OLDPARTY, TRAIT_GENERIC)
	H.virginity = TRUE
	H.change_stat(STATKEY_STR, -1)
	H.change_stat(STATKEY_INT, 7)
	H.change_stat(STATKEY_CON, -1)
	H.change_stat(STATKEY_SPD, 2)
	H.mind?.adjust_spellpoints(20)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/aoe_turf/knock)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/invoked/raise_undead)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/self/learnspell)
	H.mind?.AddSpell(new /obj/effect/proc_holder/spell/targeted/touch/prestidigitation)

	H?.generate_random_attunements(rand(4,6))
