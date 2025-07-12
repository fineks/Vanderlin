/datum/job/royalknight
	title = "Стрелец"
	tutorial = "Ты элита элит. Царский стрелец, принёс обет верности в первую очередь царю. \
	Великий Царь повелел тебе ЛЮБОЙ ЦЕНОЙ защищать князя тьмы, что правит в сих землях своей стальной рукой. \
	Вернее и исполнительней тебя нету никого. Ты даже не знаешь такого слова как 'СОМНЕНИЕ'. Ты исполнишь любой приказ. \
	И приказ князя в том числе."
	flag = GUARDSMAN
	department_flag = GARRISON
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_ROYALKNIGHT
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2
	min_pq = 0
	bypass_lastclass = TRUE
	selection_color = "#920909"

	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD)
	allowed_sexes = list(MALE)
	allowed_races = list (
		"Humen"
)

	advclass_cat_rolls = list(CTAG_ROYALKNIGHT = 20)
	give_bank_account = 60
	cmode_music = 'sound/music/cmode/nobility/CombatKnight.ogg'

/datum/advclass/royalknight/knight
	name = "Стрелец"
	tutorial = "Шикарный и стильный стрелец что жаждет служить Князю. Это его стандартная униформа."

	outfit = /datum/outfit/job/royalknight/knight

	category_tags = list(CTAG_ROYALKNIGHT)

/datum/outfit/job/royalknight
	job_bitflag = BITFLAG_GARRISON
	var/reduced_skill = FALSE

/datum/outfit/job/royalknight/pre_equip(mob/living/carbon/human/H)
	..()
	neck = /obj/item/clothing/neck/chaincoif
	pants = /obj/item/clothing/pants/chainlegs
	cloak = /obj/item/clothing/cloak/tabard/knight/guard  // Табард с княжими цветами
	shirt = /obj/item/clothing/shirt/tunic/red
	belt = /obj/item/storage/belt/leather
	mask = /obj/item/clothing/face/facemask/steel
	beltr = /obj/item/weapon/sword/arming
	beltl = /obj/item/gun/ballistic/revolver/grenadelauncher/pistol
	backl = /obj/item/storage/backpack/satchel
	backpack_contents = list(/obj/item/storage/keyring/manorguard = 1, /obj/item/reagent_containers/powder/blastpowder = 1, /obj/item/ammo_casing/caseless/bullet = 1 )

	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)

	H.adjust_skillrank(/datum/skill/combat/firearms, 6, TRUE)
	H.adjust_skillrank(/datum/skill/combat/bows, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/crossbows, 5, TRUE)

	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 1, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)

	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_PER, 2)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 6) // Когда выставляешь своё тело без брони - учишся держать удар
	H.change_stat(STATKEY_INT, 2)

	H.verbs |= /mob/proc/haltyell
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_CRITICAL_RESISTANCE, TRAIT_GENERIC)
	if(H.dna?.species?.id == "human")
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

/datum/outfit/job/royalknight/post_equip(mob/living/carbon/human/H, visualsOnly)
	. = ..()
	if(H.cloak)
		if(!findtext(H.cloak.name,"([H.real_name])"))
			H.cloak.name = "[H.cloak.name]"+" "+"([H.real_name])"

	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Pann"
	if(H.gender == FEMALE)
		honorary = "Panna"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"

	var/static/list/selectable = list( \
		"Flail" = /obj/item/weapon/flail/sflail, \
		"Bardiche" = /obj/item/weapon/polearm/halberd/bardiche, \
		"Sabre" = /obj/item/weapon/sword/sabre/dec, \
		"Battle axe" = /obj/item/weapon/axe/battle \
		)
	var/choice = H.select_equippable(H, selectable, message = "Choose Your Specialisation", title = "KNIGHT")
	if(!choice)
		return
	var/grant_shield = TRUE
	var/modifier = reduced_skill
	switch(choice)
		if("Flail")
			H.adjust_skillrank(/datum/skill/combat/whipsflails, 1 - modifier, TRUE)
		if("Bardiche")
			H.adjust_skillrank(/datum/skill/combat/polearms, 1 - modifier, TRUE)
			grant_shield = FALSE
		if("Sabre")
			if(!reduced_skill)
				H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		if("Battle axe")
			if(!reduced_skill)
				H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
			H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
	if(grant_shield)
		H.adjust_skillrank(/datum/skill/combat/shields, 1, TRUE)
		var/shield = new /obj/item/weapon/shield/tower/metal()
		if(!H.equip_to_appropriate_slot(shield))
			qdel(shield)

/datum/outfit/job/royalknight/knight/pre_equip(mob/living/carbon/human/H)
	. = ..()
	armor = /obj/item/clothing/armor/cuirass
	head = /obj/item/clothing/head/papakha
	gloves = /obj/item/clothing/gloves/plate
	shoes = /obj/item/clothing/shoes/boots/armor
