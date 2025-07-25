/obj/effect/proc_holder/spell/targeted/ethereal_jaunt
	name = "Ethereal Jaunt"
	desc = ""
	overlay_state = "jaunt"
	school = "transmutation"
	recharge_time = 300
	invocation = "ГНИЛОЁБЛЫЙ ХУЕПЕРД!"
	invocation_type = "shout"
	range = -1
	cooldown_min = 550 //50 deciseconds reduction per rank
	include_user = TRUE
	nonabstract_req = TRUE
	var/jaunt_duration = 25 //in deciseconds
	var/jaunt_in_time = 5
	var/jaunt_in_type = /obj/effect/temp_visual/wizard
	var/jaunt_out_type = /obj/effect/temp_visual/wizard/out
	associated_skill = /datum/skill/magic/arcane
	attunements = list(
		/datum/attunement/arcyne = 0.4,
	)

/obj/effect/proc_holder/spell/targeted/ethereal_jaunt/cast(list/targets,mob/user = usr) //magnets, so mostly hardcoded
	. = ..()
	playsound(get_turf(user), 'sound/swap.ogg', 50, TRUE, -1)
	for(var/mob/living/target in targets)
		INVOKE_ASYNC(src, PROC_REF(do_jaunt), target)

/obj/effect/proc_holder/spell/targeted/ethereal_jaunt/proc/do_jaunt(mob/living/target)
	target.notransform = 1
	var/turf/mobloc = get_turf(target)
	var/obj/effect/dummy/phased_mob/spell_jaunt/holder = new /obj/effect/dummy/phased_mob/spell_jaunt(mobloc)
	new jaunt_out_type(mobloc, target.dir)
	target.ExtinguishMob()
	target.forceMove(holder)
	target.reset_perspective(holder)
	target.notransform=0 //mob is safely inside holder now, no need for protection.
	jaunt_steam(mobloc)
	ADD_TRAIT(target, TRAIT_IMPERCEPTIBLE, MAGIC_TRAIT)

	sleep(jaunt_duration)

	if(target.loc != holder) //mob warped out of the warp
		qdel(holder)
		return
	mobloc = get_turf(target.loc)
	jaunt_steam(mobloc)
	ADD_TRAIT(target, TRAIT_IMMOBILIZED, type)
	holder.reappearing = 1
	playsound(get_turf(target), 'sound/swap.ogg', 50, TRUE, -1)
	sleep(25 - jaunt_in_time)
	new jaunt_in_type(mobloc, holder.dir)
	target.setDir(holder.dir)
	sleep(jaunt_in_time)
	REMOVE_TRAIT(target, TRAIT_IMPERCEPTIBLE, MAGIC_TRAIT)
	qdel(holder)
	if(!QDELETED(target))
		if(mobloc.density)
			for(var/direction in GLOB.alldirs)
				var/turf/T = get_step(mobloc, direction)
				if(T)
					if(target.Move(T))
						break
		REMOVE_TRAIT(target, TRAIT_IMMOBILIZED, type)

/obj/effect/proc_holder/spell/targeted/ethereal_jaunt/proc/jaunt_steam(mobloc)
	var/datum/effect_system/steam_spread/steam = new /datum/effect_system/steam_spread()
	steam.set_up(10, 0, mobloc)
	steam.start()

/obj/effect/dummy/phased_mob/spell_jaunt
	name = "water"
	icon = 'icons/effects/effects.dmi'
	icon_state = "nothing"
	var/reappearing = FALSE
	var/movedelay = 0
	var/movespeed = 2
	density = FALSE
	anchored = TRUE
	invisibility = 60
	resistance_flags = LAVA_PROOF | FIRE_PROOF | UNACIDABLE | ACID_PROOF
	flags_1 = PREVENT_CONTENTS_EXPLOSION_1

/obj/effect/dummy/phased_mob/spell_jaunt/Destroy()
	// Eject contents if deleted somehow
	for(var/atom/movable/AM in src)
		AM.forceMove(get_turf(src))
	return ..()

/obj/effect/dummy/phased_mob/spell_jaunt/relaymove(mob/user, direction)
	if ((movedelay > world.time) || reappearing || !direction)
		return
	var/turf/newLoc = get_step(src,direction)
	setDir(direction)

	movedelay = world.time + movespeed

	if(newLoc.flags_1 & NOJAUNT_1)
		to_chat(user, "<span class='warning'>Some strange aura is blocking the way.</span>")
		return
	if (locate(/obj/effect/blessing, newLoc))
		to_chat(user, "<span class='warning'>Holy energies block your path!</span>")
		return

	forceMove(newLoc)

/obj/effect/dummy/phased_mob/spell_jaunt/ex_act(blah)
	return

/obj/effect/dummy/phased_mob/spell_jaunt/bullet_act(blah)
	return BULLET_ACT_FORCE_PIERCE
