/datum/job/artificer
	title = "Masterovoi"
	tutorial = "Ты прибыл в Царьземье со своей разрушенной родины - Хартфельта. \
	Ты великий инженер, и впринципе мозговитая персона. Жаль что местным не всегда понятны твои изыскания. \
	Тебе известно как работает машина, и знаешь как заставить её работать на себя. Если постаратся - то добьёшся у местных признания."
	flag = ARTIFICER
	department_flag = SERFS
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_ARTIFICER
	faction = FACTION_TOWN
	total_positions = 2
	spawn_positions = 2
	min_pq = -50
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE, FEMALE)
	allowed_races = RACES_PLAYER_ALL

	outfit = /datum/outfit/job/artificer
	give_bank_account = 40
	cmode_music = 'sound/music/cmode/towner/CombatTowner2.ogg'

/datum/outfit/job/artificer
	job_bitflag = BITFLAG_CONSTRUCTOR

/datum/outfit/job/artificer/pre_equip(mob/living/carbon/human/H)
	..()
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 2, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, pick(2,3), TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, pick(3,3,3,4), TRUE) // Лондон
	H.adjust_skillrank(/datum/skill/combat/unarmed, pick(2,3), TRUE)
	H.adjust_skillrank(/datum/skill/labor/lumberjacking, pick(1,1,2), TRUE)
	H.adjust_skillrank(/datum/skill/craft/masonry, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/engineering, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/lockpicking, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mining, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/smelting, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 2, TRUE)

	head = /obj/item/clothing/head/articap
	armor = /obj/item/clothing/armor/leather/jacket/artijacket
	pants = /obj/item/clothing/pants/trou/artipants
	shirt = /obj/item/clothing/shirt/undershirt/artificer
	shoes = /obj/item/clothing/shoes/simpleshoes/buckle
	belt = /obj/item/storage/belt/leather
	beltr = /obj/item/storage/belt/pouch/coins/mid
	beltl = /obj/item/storage/keyring/artificer
	mask = /obj/item/clothing/face/goggles
	backl = /obj/item/storage/backpack/backpack
	ring = /obj/item/clothing/ring/silver/makers_guild
	backpack_contents = list(/obj/item/weapon/hammer/steel = 1, /obj/item/flashlight/flare/torch/lantern = 1, /obj/item/weapon/knife/villager = 1, /obj/item/weapon/chisel = 1)

	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_INT, 4)
	H.change_stat(STATKEY_END, 2)
	H.change_stat(STATKEY_CON, 1)

	if(H.dna.species.id == "dwarf")
		head = /obj/item/clothing/head/helmet/leather/minershelm
		H.cmode_music = 'sound/music/cmode/combat_dwarf.ogg'
