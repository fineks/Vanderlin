GLOBAL_VAR(lordsurname)
GLOBAL_LIST_EMPTY(lord_titles)

/datum/job/lord
	title = "Князь"
	f_title = "Княгиня"
	var/ruler_title = "Knyaz"
	tutorial = "Твой родитель оставил этот город и престол для тебя, а сам уехал отдыхать в Царьград. Последнее что он сказал 'Я думаю ты достаточно взрослый'. \
	С тех пор прошло уже лет эдак тридцать, или больше, или меньше. За кутежом и наслаждением властью тебе это уже позабылось \
	однако у тебя действительно был и есть талант! Ты превратил некогда среднего пошиба село, в настоящий город защищённый скалами! \
	Вместо людей тяжёлым трудом занимаются гоблины, и даже канализационные крысы ради общего дела научились вкалывать. Твои заслуги трудно переоценить... \
	Но неблагодарные холопы и заграничные соседи всегда найдут в чем тебя обвинить. Так-что тебе до сих пор стоит крепко держатся за престол"
	flag = LORD
	department_flag = NOBLEMEN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	display_order = JDO_LORD
	faction = FACTION_TOWN
	total_positions = 0
	spawn_positions = 1
	min_pq = 0

	spells = list(
		/obj/effect/proc_holder/spell/self/grant_title,
		/obj/effect/proc_holder/spell/self/grant_nobility,
	)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_sexes = list(MALE, FEMALE)`
	allowed_races = list(
		"Humen",
	)
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
	H.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)
	else
		H.adjust_skillrank(/datum/skill/combat/polearms, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/crossbows, 4, TRUE)
		H.adjust_skillrank(/datum/skill/combat/wrestling, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/unarmed, 2, TRUE)
		H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/knives, 5, TRUE)
		H.adjust_skillrank(/datum/skill/misc/swimming, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
		H.adjust_skillrank(/datum/skill/misc/athletics, 3, TRUE)
		H.adjust_skillrank(/datum/skill/combat/firearms, 3, TRUE)
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
		ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
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

/proc/give_lord_surname(mob/living/carbon/human/family_guy, preserve_original = FALSE)
	if(!GLOB.lordsurname)
		return
	if(preserve_original)
		family_guy.fully_replace_character_name(family_guy.real_name, family_guy.real_name + " " + GLOB.lordsurname)
		return family_guy.real_name
	var/list/chopped_name = splittext(family_guy.real_name, " ")
	if(length(chopped_name) > 1)
		family_guy.fully_replace_character_name(family_guy.real_name, chopped_name[1] + " " + GLOB.lordsurname)
	else
		family_guy.fully_replace_character_name(family_guy.real_name, family_guy.real_name + " " + GLOB.lordsurname)
	return family_guy.real_name

/obj/effect/proc_holder/spell/self/grant_title
	name = "Grant Title"
	desc = "Grant someone a title of honor... Or shame."
	overlay_state = "recruit_titlegrant"
	antimagic_allowed = TRUE
	recharge_time = 100
	/// Maximum range for title granting
	var/title_range = 3
	/// Maximum length for the title
	var/title_length = 42

/obj/effect/proc_holder/spell/self/grant_title/cast(list/targets, mob/user = usr)
	. = ..()
	var/granted_title = input(user, "What title do you wish to grant?", "[name]") as null|text
	granted_title = reject_bad_text(granted_title, title_length)
	if(!granted_title)
		return
	var/list/recruitment = list()
	for(var/mob/living/carbon/human/village_idiot in (get_hearers_in_view(title_range, user) - user))
		//not allowed
		if(!can_title(village_idiot))
			continue
		recruitment[village_idiot.name] = village_idiot
	if(!length(recruitment))
		to_chat(user, span_warning("There are no potential honoraries in range."))
		return
	var/inputty = input(user, "Select an honorary!", "[name]") as anything in recruitment
	if(inputty)
		var/mob/living/carbon/human/recruit = recruitment[inputty]
		if(!QDELETED(recruit) && (recruit in get_hearers_in_view(title_range, user)))
			INVOKE_ASYNC(src, PROC_REF(village_idiotify), recruit, user, granted_title)
		else
			to_chat(user, span_warning("Honorific failed!"))
	else
		to_chat(user, span_warning("Honorific cancelled."))

/obj/effect/proc_holder/spell/self/grant_title/proc/can_title(mob/living/carbon/human/recruit)
	//wtf
	if(QDELETED(recruit))
		return FALSE
	//need a mind
	if(!recruit.mind)
		return FALSE
	//need to see their damn face
	if(!recruit.get_face_name(null))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/grant_title/proc/village_idiotify(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter, granted_title)
	if(QDELETED(recruit) || QDELETED(recruiter) || !granted_title)
		return FALSE
	if(GLOB.lord_titles[recruit.real_name])
		recruiter.say("I HEREBY STRIP YOU, [uppertext(recruit.name)], OF THE TITLE OF [uppertext(GLOB.lord_titles[recruit.real_name])]!")
		GLOB.lord_titles -= recruit.real_name
		return FALSE
	recruiter.say("I HEREBY GRANT YOU, [uppertext(recruit.name)], THE TITLE OF [uppertext(granted_title)]!")
	GLOB.lord_titles[recruit.real_name] = granted_title
	return TRUE


/obj/effect/proc_holder/spell/self/grant_nobility
	name = "Grant Nobility"
	desc = "Make someone a noble, or strip them of their nobility."
	antimagic_allowed = TRUE
	recharge_time = 100
	/// Maximum range for nobility granting
	var/nobility_range = 3

/obj/effect/proc_holder/spell/self/grant_nobility/cast(list/targets, mob/user = usr)
	. = ..()
	var/list/recruitment = list()
	for(var/mob/living/carbon/human/village_idiot in (get_hearers_in_view(nobility_range, user) - user))
		//not allowed
		if(!can_nobility(village_idiot))
			continue
		recruitment[village_idiot.name] = village_idiot
	if(!length(recruitment))
		to_chat(user, span_warning("There are no potential honoraries in range."))
		return
	var/inputty = input(user, "Select an honorary!", "[name]") as anything in recruitment
	if(inputty)
		var/mob/living/carbon/human/recruit = recruitment[inputty]
		if(!QDELETED(recruit) && (recruit in get_hearers_in_view(nobility_range, user)))
			INVOKE_ASYNC(src, PROC_REF(grant_nobility), recruit, user)
		else
			to_chat(user, span_warning("Honorific failed!"))
	else
		to_chat(user, span_warning("Honorific cancelled."))

/obj/effect/proc_holder/spell/self/grant_nobility/proc/can_nobility(mob/living/carbon/human/recruit)
	//wtf
	if(QDELETED(recruit))
		return FALSE
	//need a mind
	if(!recruit.mind)
		return FALSE
	//need to see their damn face
	if(!recruit.get_face_name(null))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/grant_nobility/proc/grant_nobility(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter)
	if(QDELETED(recruit) || QDELETED(recruiter))
		return FALSE
	if(HAS_TRAIT(recruit, TRAIT_NOBLE))
		recruiter.say("I HEREBY STRIP YOU, [uppertext(recruit.name)], OF NOBILITY!!")
		REMOVE_TRAIT(recruit, TRAIT_NOBLE, TRAIT_GENERIC)
		return FALSE
	recruiter.say("I HEREBY GRANT YOU, [uppertext(recruit.name)], NOBILITY!")
	ADD_TRAIT(recruit, TRAIT_NOBLE, TRAIT_GENERIC)
	return TRUE
