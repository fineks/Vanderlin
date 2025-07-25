/obj/effect/proc_holder/spell/invoked/strengthen_undead
	name = "Strengthen Undead"
	overlay_state = "raiseskele"
	releasedrain = 30
	chargetime = 5
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	sound = 'sound/magic/whiteflame.ogg'
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	recharge_time = 15 SECONDS
	miracle = FALSE
	attunements = list(
		/datum/attunement/dark = 0.4,
		/datum/attunement/death = 0.5,
	)

/obj/effect/proc_holder/spell/invoked/strengthen_undead/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/target = targets[1]
		if(target.mob_biotypes & MOB_UNDEAD) //negative energy helps the undead
			var/obj/item/bodypart/affecting = target.get_bodypart(check_zone(user.zone_selected))
			if(affecting)
				if(affecting.heal_damage(50, 50))
					target.update_damage_overlays()
				if(affecting.heal_wounds(50))
					target.update_damage_overlays()
			target.visible_message(span_danger("[target] reforms under the vile energy!"), span_notice("I'm remade by dark magic!"))
			return TRUE
		target.visible_message(span_info("Necrotic energy floods over [target]!"), span_userdanger("I feel colder as the dark energy floods into me!"))
		if(iscarbon(target))
			target.Paralyze(50)
		else
			target.adjustBruteLoss(20)
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/eyebite
	name = "Eyebite"
	overlay_state = "raiseskele"
	releasedrain = 30
	chargetime = 15
	range = 7
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	sound = 'sound/items/beartrap.ogg'
	associated_skill = /datum/skill/magic/arcane
	antimagic_allowed = TRUE
	recharge_time = 15 SECONDS
	miracle = FALSE
	attunements = list(
		/datum/attunement/dark = 0.4,
	)

/obj/effect/proc_holder/spell/invoked/eyebite/cast(list/targets, mob/living/user)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/carbon/target = targets[1]
		target.visible_message(span_info("A loud crunching sound has come from [target]!"), span_userdanger("I feel arcane teeth biting into my eyes!"))
		target.adjustBruteLoss(30)
		target.blind_eyes(2)
		target.blur_eyes(10)
		return TRUE
	return FALSE

/obj/effect/proc_holder/spell/invoked/raise_undead
	name = "Raise Undead"
	desc = ""
	range = 7
	overlay_state = "raiseskele"
	sound = list('sound/magic/magnet.ogg')
	releasedrain = 40
	chargetime = 60
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	recharge_time = 30 SECONDS
	attunements = list(
		/datum/attunement/dark = 0.4,
		/datum/attunement/death = 1,
	)


/**
 * Raises a minion from a corpse. Prioritizing ownership to original player > ghosts > npc.
 *
 * Vars:
 * * targets: list of mobs that are targetted.
 * * user: spell caster.
 */
/obj/effect/proc_holder/spell/invoked/raise_undead/cast(list/targets, mob/living/carbon/human/user)
	. = ..()

	user.say("ХУЕРЫЛКА МЁРТВОВЫКИДЫШЬ!")

	var/obj = targets[1]

	if(!obj || !istype(obj, /mob/living/carbon/human))
		to_chat(user, span_warning("I need to cast this spell on a corpse."))
		return FALSE

	// bandaid until goblin skeleton immortality is fixed
	if(istype(obj, /mob/living/carbon/human/species/goblin))
		to_chat(user, span_warning("I cannot raise goblins."))
		return FALSE

	var/mob/living/carbon/human/target = obj

	if(target.stat != DEAD)
		to_chat(user, span_warning("I cannot raise the living."))
		return FALSE

	var/obj/item/bodypart/target_head = target.get_bodypart(BODY_ZONE_HEAD)
	if(!target_head)
		to_chat(user, span_warning("This corpse is headless."))
		return FALSE

	var/offer_refused = FALSE

	target.visible_message(span_warning("[target.real_name]'s body is engulfed by dark energy..."), runechat_message = TRUE)

	if(target.ckey) //player still inside body

		var/offer = alert(target, "Жаждешь ожить в качестве мертвеца?", "ТЕБЯ ЖДЁТ НОВАЯ ЖИЗНЬ", "Да", "Нет")
		var/offer_time = world.time

		if(offer == "Нет" || world.time > offer_time + 5 SECONDS)
			to_chat(target, span_danger("Твоё тело достанется иным."))
			offer_refused = TRUE

		else if(offer == "Да")
			to_chat(target, span_danger("Жизнь принимает тебя обратно."))
			target.turn_to_minion(user, target.ckey)
			target.visible_message(span_warning("[target.real_name] просыпается. Его очи сияют осознанностью."), runechat_message = TRUE)
			return TRUE

	if(!target.ckey || offer_refused) //player is not inside body or has refused, poll for candidates

		var/list/candidates = pollCandidatesForMob("Хочешь занять чьё-то тело?", null, null, null, 100, target, POLL_IGNORE_NECROMANCER_SKELETON)

		// theres at least one candidate
		if(LAZYLEN(candidates))
			var/mob/C = pick(candidates)
			target.turn_to_minion(user, C.ckey)
			target.visible_message(span_warning("[target.real_name] просыпается. Его очи сияют триумфом."), runechat_message = TRUE)

		//no candidates, raise as npc
		else
			target.turn_to_minion(user)
			target.visible_message(span_warning("[target.real_name] просыпается. Его очи сияют блаженностью."), runechat_message = TRUE)

		return TRUE

	return FALSE

/**
 * Turns a mob into a skeletonized minion. Used for raising undead minions.
 * If a ckey is provided, the minion will be controlled by the player, NPC otherwise.
 *
 * Vars:
 * * master: master of the minion.
 * * ckey (optional): ckey of the player that will control the minion.
 */
/mob/living/carbon/human/proc/turn_to_minion(mob/living/carbon/human/master, ckey)

	if(!master)
		return FALSE

	src.revive(TRUE, TRUE)

	if(ckey) //player
		src.ckey = ckey
	else //npc
		ai_controller = new /datum/ai_controller/human_npc(src)
		AddComponent(/datum/component/ai_aggro_system)
		wander = TRUE

	if(!mind)
		mind_initialize()

	clamped_adjust_skillrank(/datum/skill/combat/axesmaces, 2, 3, TRUE)
	clamped_adjust_skillrank(/datum/skill/combat/crossbows, 2, 3, TRUE)
	clamped_adjust_skillrank(/datum/skill/combat/wrestling, 2, 3, TRUE)
	clamped_adjust_skillrank(/datum/skill/combat/unarmed, 1, 3, TRUE)
	clamped_adjust_skillrank(/datum/skill/combat/swords, 2, 3, TRUE)
	mind.current.job = null

	dna.species.species_traits |= NOBLOOD
	dna.species.soundpack_m = new /datum/voicepack/skeleton()
	dna.species.soundpack_f = new /datum/voicepack/skeleton()

	src.base_strength = 10
	src.base_perception = 10
	src.base_endurance = 10
	src.base_constitution = 11
	src.base_intelligence = 8
	src.base_speed = 10
	src.base_fortune = 10


	cmode_music = 'sound/music/cmode/antag/combat_cult.ogg'

	set_patron(master.patron)
	copy_known_languages_from(master,FALSE)
	mob_biotypes = MOB_UNDEAD
	faction = list(FACTION_UNDEAD)
	ambushable = FALSE

	skeletonize(FALSE)
	skele_look()
	grant_undead_eyes()

	if(charflaw)
		QDEL_NULL(charflaw)

	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_EASYDISMEMBER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_LIMBATTACHMENT, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSLEEP, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_CRITICAL_WEAKNESS, TRAIT_GENERIC)

	update_body()

	to_chat(src, span_userdanger("В это мир меня вернул [master.real_name]."))

	master.minions += src

	return TRUE

/obj/effect/proc_holder/spell/invoked/projectile/sickness
	name = "Ray of Sickness"
	desc = ""
	range = 15
	projectile_type = /obj/projectile/magic/sickness
	overlay_state = "raiseskele"
	sound = list('sound/misc/portal_enter.ogg')
	active = FALSE
	releasedrain = 30
	chargetime = 10
	warnie = "spellwarning"
	no_early_release = TRUE
	charging_slowdown = 1
	chargedloop = /datum/looping_sound/invokegen
	associated_skill = /datum/skill/magic/arcane
	recharge_time = 15 SECONDS
	attunements = list(
		/datum/attunement/dark = 0.4,
		/datum/attunement/blood = 0.5,
	)

/obj/effect/proc_holder/spell/self/command_undead
	name = "Command Undead"
	desc = "!"
	overlay_state = "raiseskele"
	sound = list('sound/magic/magnet.ogg')
	invocation = "Zuth'gorash vel'thar dral'oth!"
	invocation_type = "shout"
	antimagic_allowed = TRUE
	recharge_time = 15 SECONDS

/obj/effect/proc_holder/spell/self/command_undead/cast(mob/user = usr)
	. = ..()

	var/message = input(user, "Speak to your minions!", "LICH") as text|null

	if(!message)
		return

	var/mob/living/carbon/human/lich_player = user

	to_chat(lich_player, span_boldannounce("Lich [lich_player.real_name] commands: [message]"))
	message_admins("[lich_player.real_name], the Lich, commands his minions: [message]")
	lich_player.log_message("[lich_player.real_name], the Lich, commands his minions: [message]", LOG_GAME)

	for(var/mob/player in lich_player.minions)
		if(player.mind)
			to_chat(player, span_boldannounce("Lich [lich_player.real_name] commands: [message]"))


/obj/projectile/magic/sickness
	name = "Bolt of Sickness"
	icon_state = "xray"
	damage = 10
	damage_type = BURN
	flag = "magic"

/obj/projectile/magic/sickness/on_hit(atom/target, blocked = FALSE)
	. = ..()
	if(iscarbon(target))
		var/mob/living/carbon/M = target
		M.reagents.add_reagent(/datum/reagent/toxin, 3)
