/datum/job/innkeep
	title = "Корчмарь"
	tutorial = "Авторитетный и умелый боярин что заведует трактиром. \
	Именно к нему приходят все голодающие, путники, и любители слухов. А он и рад их принять. \
	Но махать кулаками и мечём тоже порой приходится. И корчмарь готов к этому как никто"
	flag = INNKEEP
	department_flag = SERFS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_INNKEEP
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = -10
	bypass_lastclass = TRUE

	allowed_races = list("Humen","Dwarf","Elf","Tiefling","Harpy","Triton")


	outfit = /datum/outfit/job/innkeep
	give_bank_account = 60
	cmode_music = 'sound/music/cmode/towner/CombatInn.ogg'

/datum/outfit/job/innkeep
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/innkeep/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/cooking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 2, TRUE)

	pants = /obj/item/clothing/pants/tights/random
	shirt = /obj/item/clothing/shirt/shortshirt/random
	shoes = /obj/item/clothing/shoes/shortboots
	belt = /obj/item/storage/belt/leather/black
	beltl = /obj/item/storage/belt/pouch/coins/rich
	beltr = /obj/item/reagent_containers/glass/bottle/beer/blackgoat
	neck = /obj/item/storage/keyring/innkeep
	cloak = /obj/item/clothing/cloak/apron/waist
	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_END, 1)
	backpack_contents = list(/obj/item/recipe_book/cooking)
	ADD_TRAIT(H, TRAIT_DREAM_WATCHER, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BLACKLEG, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
