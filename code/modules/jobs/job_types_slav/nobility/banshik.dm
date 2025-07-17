/datum/job/apothecary
	title = "Банщик"
	tutorial = "Народ требует соблюдения гигиены, а ты требуешь за это денег. \
	В твоих банях всегда царит празднецтво и чистота. Алкоголь и мужские посиделки под паром и вениками \
	всегда помогали народу расслабтся. А ты и рад старатся, занимаясь столь благим делом. \
	Главное не забывай что в банях - не место спорам. В банях все равны. А кто не согласен - того ждёт ошпаривание, будь то чернь иль будь то князь."
	flag = NIGHTMAN
	department_flag = NOBLEMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_APOTHECARY
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE)
	allowed_races = list("Humen","Dwarf","Tiefling")
	outfit = /datum/outfit/job/apothecary
	give_bank_account = 130
	cmode_music = 'sound/music/cmode/towner/CombatBeggar.ogg'

/datum/outfit/job/apothecary
	job_bitflag = BITFLAG_ROYALTY | BITFLAG_CONSTRUCTOR

/datum/outfit/job/apothecary/pre_equip(mob/living/carbon/human/H)
	..()
	armor = /obj/item/clothing/shirt/robe/white
	shoes = /obj/item/clothing/shoes/shortboots
	pants = /obj/item/clothing/pants/loincloth/pink
	belt = /obj/item/storage/belt/leather/cloth
	beltr = /obj/item/key/bathhouse
	beltl = /obj/item/storage/belt/pouch/coins/mid
	ADD_TRAIT(H, TRAIT_EMPATH, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BARDIC_TRAINING, TRAIT_GENERIC)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 6, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/sneaking, 4, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/craft/alchemy, 3, TRUE)
	H.adjust_skillrank(/datum/skill/craft/crafting, 1, TRUE)
	H.adjust_skillrank(/datum/skill/misc/medicine, 2, TRUE)
	H.adjust_skillrank(/datum/skill/labor/farming, 3, TRUE)
	H.change_stat(STATKEY_STR, 3)
	H.change_stat(STATKEY_INT, 2)

	if(H.gender == MALE)
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/zeth()
