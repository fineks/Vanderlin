/datum/job/captain
	title = "Сотник"
	tutorial = "Ты служишь князю немало лет верой и правдой. \
	Он доверил тебе власть над всеми своими войсками в городе и в его округе, \
	дабы ты защищал его землю и его величество непосредственно."
	flag = CAPTAIN
	department_flag = NOBLEMEN
	display_order = JDO_CAPTAIN
	job_flags = (JOB_ANNOUNCE_ARRIVAL | JOB_SHOW_IN_CREDITS | JOB_EQUIP_RANK | JOB_NEW_PLAYER_JOINABLE)
	faction = FACTION_TOWN
	total_positions = 1
	spawn_positions = 1
	min_pq = 0
	bypass_lastclass = TRUE

	allowed_sexes = list(MALE)
	allowed_ages = list(AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
	allowed_races = list(
		"Humen",
		"Dwarf"
	)

	outfit = /datum/outfit/job/captain
	spells = list(/obj/effect/proc_holder/spell/self/convertrole/guard)
	give_bank_account = 120
	cmode_music = 'sound/music/cmode/antag/CombatSausageMaker.ogg'
	noble_income = 11

/datum/job/captain/after_spawn(mob/living/spawned, client/player_client)
	..()
	var/mob/living/carbon/human/H = spawned
	var/prev_real_name = H.real_name
	var/prev_name = H.name
	var/honorary = "Sotnik"
	H.real_name = "[honorary] [prev_real_name]"
	H.name = "[honorary] [prev_name]"

/datum/outfit/job/captain
	job_bitflag = BITFLAG_ROYALTY | BITFLAG_GARRISON

/datum/outfit/job/captain/pre_equip(mob/living/carbon/human/H)
	..()
	head = /obj/item/clothing/head/helmet/visored/captain
	gloves = /obj/item/clothing/gloves/chain
	pants = /obj/item/clothing/pants/platelegs/captain
	armor = /obj/item/clothing/armor/captain
	neck = /obj/item/clothing/neck/gorget
	shirt = /obj/item/clothing/armor/chainmail/hauberk
	shoes = /obj/item/clothing/shoes/boots
	backl = /obj/item/storage/backpack/satchel
	belt = /obj/item/storage/belt/leather/steel
	beltl = /obj/item/weapon/axe/battle
	beltr = /obj/item/weapon/mace/steel
	cloak = /obj/item/clothing/cloak/captain
	backpack_contents = list(/obj/item/storage/keyring/captain = 1, /obj/item/signal_horn = 1)
	H.adjust_skillrank(/datum/skill/combat/swords, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/wrestling, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/axesmaces, 5, TRUE)
	H.adjust_skillrank(/datum/skill/combat/shields, 3, TRUE)
	H.adjust_skillrank(/datum/skill/combat/unarmed, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/knives, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/polearms, 4, TRUE)
	H.adjust_skillrank(/datum/skill/combat/whipsflails, 2, TRUE)

	H.adjust_skillrank(/datum/skill/combat/crossbows, 1, TRUE)
	H.adjust_skillrank(/datum/skill/combat/firearms, 2, TRUE)

	H.adjust_skillrank(/datum/skill/misc/athletics, 4, TRUE)

	H.adjust_skillrank(/datum/skill/misc/swimming, 3, TRUE)
	H.adjust_skillrank(/datum/skill/misc/climbing, 2, TRUE)
	H.adjust_skillrank(/datum/skill/misc/riding, 5, TRUE)
	H.adjust_skillrank(/datum/skill/misc/reading, 3, TRUE)

	H.adjust_skillrank(/datum/skill/labor/mathematics, 3, TRUE)

	H.change_stat(STATKEY_STR, 4)
	H.change_stat(STATKEY_INT, 1)
	H.change_stat(STATKEY_CON, 3)
	H.change_stat(STATKEY_END, 3)

	if(H.age == AGE_OLD)
		H.change_stat(STATKEY_STR, 2)
		H.change_stat(STATKEY_CON, 3)

	ADD_TRAIT(H, TRAIT_HEAVYARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_MEDIUMARMOR, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_KNOWBANDITS, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_BREADY, TRAIT_GENERIC)
	ADD_TRAIT(H, TRAIT_STEELHEARTED, TRAIT_GENERIC)
	H.verbs |= /mob/proc/haltyell

	if(H.dna?.species?.id == "human")
		H.dna.species.soundpack_m = new /datum/voicepack/male/knight()

/obj/effect/proc_holder/spell/self/convertrole
	name = "Recruit Beggar"
	desc = "Recruit someone to your cause."
	overlay_state = "recruit_bog"
	antimagic_allowed = TRUE
	recharge_time = 100
	/// Role given if recruitment is accepted
	var/new_role = "Beggar"
	/// Faction shown to the user in the recruitment prompt
	var/recruitment_faction = "Beggars"
	/// Message the recruiter gives
	var/recruitment_message = "Serve the beggars, %RECRUIT!"
	/// Range to search for potential recruits
	var/recruitment_range = 3
	/// Say message when the recruit accepts
	var/accept_message = "I will serve!"
	/// Say message when the recruit refuses
	var/refuse_message = "I refuse."

/obj/effect/proc_holder/spell/self/convertrole/cast(list/targets,mob/user = usr)
	. = ..()
	var/list/recruitment = list()
	for(var/mob/living/carbon/human/recruit in (get_hearers_in_view(recruitment_range, user) - user))
		//not allowed
		if(!can_convert(recruit))
			continue
		recruitment[recruit.name] = recruit
	if(!length(recruitment))
		to_chat(user, span_warning("There are no potential recruits in range."))
		return
	var/inputty = input(user, "Select a potential recruit!", "[name]") as null|anything in recruitment
	if(inputty)
		var/mob/living/carbon/human/recruit = recruitment[inputty]
		if(!QDELETED(recruit) && (recruit in get_hearers_in_view(recruitment_range, user)))
			INVOKE_ASYNC(src, PROC_REF(convert), recruit, user)
		else
			to_chat(user, span_warning("Recruitment failed!"))
	else
		to_chat(user, span_warning("Recruitment cancelled."))

/obj/effect/proc_holder/spell/self/convertrole/proc/can_convert(mob/living/carbon/human/recruit)
	//wtf
	if(QDELETED(recruit))
		return FALSE
	//need a mind
	if(!recruit.mind)
		return FALSE
	//already recruited
	if(HAS_TRAIT(recruit, TRAIT_RECRUITED))
		return FALSE
	//only migrants and peasants
	if(!(recruit.job in GLOB.peasant_positions) && \
		!(recruit.job in GLOB.allmig_positions))
		return FALSE
	//need to see their damn face
	if(!recruit.get_face_name(null))
		return FALSE
	return TRUE

/obj/effect/proc_holder/spell/self/convertrole/proc/convert(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter)
	if(QDELETED(recruit) || QDELETED(recruiter))
		return FALSE
	recruiter.say(replacetext(recruitment_message, "%RECRUIT", "[recruit]"), forced = "[name]")
	var/prompt = alert(recruit, "Do you wish to become a [new_role]?", "[recruitment_faction] Recruitment", "Yes", "No")
	if(QDELETED(recruit) || QDELETED(recruiter) || !(recruiter in get_hearers_in_view(recruitment_range, recruit)))
		return FALSE
	if(prompt != "Yes")
		if(refuse_message)
			recruit.say(refuse_message, forced = "[name]")
		return FALSE
	if(accept_message)
		recruit.say(accept_message, forced = "[name]")
		ADD_TRAIT(recruit, TRAIT_RECRUITED, TRAIT_GENERIC)
	if(new_role)
		recruit.job = new_role
		recruit.advjob = new_role
		recruit.migrant_type = null
		SEND_SIGNAL(SSdcs, COMSIG_GLOB_ROLE_CONVERTED, recruiter, recruit, new_role)
	return TRUE

/obj/effect/proc_holder/spell/self/convertrole/guard
	name = "Recruit Ratnik"
	new_role = "Ratnik recruit"
	overlay_state = "recruit_guard"
	recruitment_faction = "Garrison"
	recruitment_message = "Вступай в княжью рать, %RECRUIT!"
	accept_message = "Жизнь за царя! Жизнь за князя!"
	refuse_message = "Я недостоин этого."

/obj/effect/proc_holder/spell/self/convertrole/guard/convert(mob/living/carbon/human/recruit, mob/living/carbon/human/recruiter)
	. = ..()
	if(!.)
		return
	recruit.verbs |= /mob/proc/haltyell
