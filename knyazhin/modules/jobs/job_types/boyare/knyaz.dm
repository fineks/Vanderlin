/datum/job/knyaz
	title = "Knyaz"
	var/ruler_title = "Knyaz"
	tutorial = "Elevated to your throne through a web of intrigue, political maneuvering, and divine sanction, you are the \
	unquestioned authority of these lands. The Church has bestowed upon you the legitimacy of the gods themselves, and now \
	you sit at the center of every plot, and every whisper of ambition. Every man, woman, and child may envy your power and \
	would replace you in the blink of an eye. But remember, its not envy that keeps you in place, it is your will. Show them \
	the error of their ways."
	flag = LORD
	department_flag = NOBLEMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_LORD
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0

	spells = list(
		/obj/effect/proc_holder/spell/self/grant_title,
		/obj/effect/proc_holder/spell/self/grant_nobility,
	)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_sexes = list(MALE, FEMALE)
	allowed_races = list("Humen")
	outfit = /datum/outfit/job/lord
	bypass_lastclass = TRUE
	give_bank_account = 500
	selection_color = "#7851A9"

	cmode_music = 'sound/music/cmode/nobility/combat_noble.ogg'
	can_have_apprentices = FALSE

/datum/job/lord/get_informed_title(mob/mob)
	return "[ruler_title]"

//TODO: MOVE THIS INTO TICKER INIT
/datum/job/lord/after_spawn(mob/living/spawned, client/player_client)
	..()
	SSticker.rulermob = spawned
	var/mob/living/carbon/human/H = spawned
	addtimer(CALLBACK(H, TYPE_PROC_REF(/mob, lord_color_choice)), 5 SECONDS)
	if(spawned.gender == MALE)
		SSfamilytree.AddRoyal(H, FAMILY_FATHER)
		ruler_title = "[SSmapping.config.monarch_title]"
	else
		SSfamilytree.AddRoyal(H, FAMILY_MOTHER)
		ruler_title = "[SSmapping.config.monarch_title_f]"
	to_chat(world, "<b>[span_notice(span_big("[H.real_name] is [ruler_title] of [SSmapping.config.map_name]."))]</b>")
	to_chat(world, "<br>")
	if(GLOB.keep_doors.len > 0)
		addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(know_keep_door_password), H), 7 SECONDS)

/datum/outfit/job/lord
	job_bitflag = BITFLAG_ROYALTY

/datum/outfit/job/lord/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/crown/serpcrown
	backr = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/plaquegold
	backpack_contents = list(/obj/item/weapon/knife/dagger/steel/special = 1)
	l_hand = /obj/item/weapon/lordscepter

	if(H.gender == MALE)
		H.adjust_skillrank(/datum/skill/combat/polearms, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 1, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 3, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	else
		H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 4, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/misc/reading, 5, TRUE)
		H.adjust_skillrank(/datum/skill/misc/riding, 6, TRUE)
		H.adjust_skillrank(/datum/skill/labor/mathematics, 4, TRUE)

	if(H.age == AGE_OLD)
		H.adjust_skillrank(/datum/skill/combat/axesmaces, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 1, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)

	H.change_stat(STATKEY_STR, 1)
	H.change_stat(STATKEY_INT, 3)
	H.change_stat(STATKEY_END, 3)
	H.change_stat(STATKEY_SPD, 2)
	H.change_stat(STATKEY_PER, 3)
	H.change_stat(STATKEY_LCK, 5)
	if(H.gender == MALE)
		pants = /obj/item/clothing/pants/tights/black
		shirt = /obj/item/clothing/armor/gambeson/arming
		armor = /obj/item/clothing/armor/cuirass/grenzelhoft
		shoes = /obj/item/clothing/shoes/nobleboot
		gloves = /obj/item/clothing/gloves/angle
		ring = /obj/item/clothing/ring/gold/rontz
		cloak = /obj/item/clothing/cloak/lordcloak
		if(H.dna?.species)
			if(H.dna.species.id == "human")
				H.dna.species.soundpack_m = new /datum/voicepack/male/evil()
	else
		pants = /obj/item/clothing/pants/tights/random
		shirt = /obj/item/clothing/shirt/tunic/noblecoat
		shoes = /obj/item/clothing/shoes/nobleboot
		gloves = /obj/item/clothing/gloves/angle
		ring = /obj/item/clothing/ring/silver/saffira
		cloak = /obj/item/clothing/cloak/lordcloak/ladycloak
		wrists = /obj/item/clothing/wrists/royalsleeves

		if(H.wear_mask)
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/lordmask
			if(istype(H.wear_mask, /obj/item/clothing/face/eyepatch/left))
				qdel(H.wear_mask)
				mask = /obj/item/clothing/face/lordmask/l

	if(H.gender == MALE)
		ADD_TRAIT(H, TRAIT_XENOPHOBIC, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_KNOWKEEPPLANS, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_HATEWOMEN, TRAIT_GENERIC)
	else
		ADD_TRAIT(H, TRAIT_KITTEN_MOM, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NOSEGRAB, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_DODGEEXPERT, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_KNOWKEEPPLANS, TRAIT_GENERIC)
		ADD_TRAIT(H, TRAIT_NUTCRACKER, TRAIT_GENERIC)

/datum/job/exlord //just used to change the lords title
	title = "Padshiy Knyaz"
	flag = LORD
	department_flag = NOBLEMEN
	faction = FACTION_TOWN
	total_positions = 0
	spawn_positions = 0
	display_order = JDO_LORD
