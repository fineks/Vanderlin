/datum/job/minor_noble
	title = "Boyarin"
	tutorial = "Вельможа у которого нет здесь работы но есть некоторая власть. Князь даровал им сие звание за заслуги. \
	Они вполне себе могут найти тут кем по-управлять дабы это принесло пользу и им, и князю! \
	Внимание! Эта роль требует от вас инициативности. Никто не осудит вас если вы захотите просто пробухивать всё в корчме. \
	Но все кранйе надеятся на то что вы начнёте привлекать людей в какое-то своё дело"
	display_order = JDO_MINOR_NOBLE
	flag = MINOR_NOBLE
	department_flag = NOBLEMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2
	min_pq = 0

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_NONDISCRIMINATED

	outfit = /datum/outfit/job/noble
	give_bank_account = 60
	noble_income = 16

/datum/outfit/job/noble
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/noble/pre_equip(mob/living/carbon/human/H)
	..()
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Pann"
	if(H.gender == FEMALE)
		honorary = "Panna"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"

	H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/music, rand(1,3), TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	H.change_stat(STATKEY_INT, 2)
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/satchel
	neck = /obj/item/storage/belt/pouch/coins/veryrich
	belt = /obj/item/storage/belt/leather
	ring = /obj/item/clothing/ring/silver
	switch(H.patron?.type)
		if(/datum/patron/inhumen/baotha)
			H.cmode_music = 'sound/music/cmode/antag/CombatBaotha.ogg'
	if(H.gender == FEMALE)
		H.change_stat(STATKEY_LCK, 2)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 3, TRUE)
		shirt = /obj/item/clothing/shirt/dress/silkdress/random
		head = /obj/item/clothing/head/hatfur
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow/recurve
		beltr = /obj/item/weapon/knife/dagger/steel/special
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
	if(H.gender == MALE)
		H.change_stat(STATKEY_CON, 2)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/bows, 2, TRUE)
		pants = /obj/item/clothing/pants/tights/black
		shirt = /obj/item/clothing/shirt/tunic/random
		cloak = /obj/item/clothing/cloak/raincloak/furcloak
		head = /obj/item/clothing/head/hatblu
		backr = /obj/item/gun/ballistic/revolver/grenadelauncher/bow
		beltr = /obj/item/weapon/mace/cudgel/carpenter
		beltl = /obj/item/ammo_holder/quiver/arrows
		backpack_contents = list(/obj/item/reagent_containers/glass/bottle/wine = 1, /obj/item/reagent_containers/glass/cup/silver = 1)
	ADD_TRAIT(H, TRAIT_NOBLE, TRAIT_GENERIC)
