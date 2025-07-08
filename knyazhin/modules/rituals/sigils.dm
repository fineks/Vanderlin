GLOBAL_LIST_EMPTY(ritualslist)


/obj/effect/decal/cleanable/sigil
	name = "sigils"
	desc = "Strange runics."
	icon_state = "center"
	icon = 'icons/obj/sigils.dmi'
	clean_type = CLEAN_TYPE_HARD_DECAL
	var/sigil_type

/obj/effect/decal/cleanable/sigil/examine(mob/user)
	. = ..()
	if(!sigil_type)
		return

	if(ishuman(user))
		var/mob/living/carbon/human/H = user
		if(can_use_sigil(H))
			to_chat(user, "It is of the [sigil_type] circle.")

/obj/effect/decal/cleanable/sigil/Initialize(mapload)
	. = ..()
	if(!LAZYLEN(GLOB.ritualslist))
		GLOB.ritualslist = list()
		var/static/list/rituals = subtypesof(/datum/ritual)
		for(var/path in rituals)
			var/datum/ritual/G = path
			GLOB.ritualslist[G.name] = G

/obj/effect/decal/cleanable/sigil/attack_hand(mob/living/user)
	. = ..()
	if(icon_state != "center")
		return
	if(can_use_sigil(user))
		return
	var/list/rituals = get_accessed_rituals(user)

	var/ritual = input(user, "Rituals", "VANDERLIN") as null|anything in rituals

	if(!ritual)
		return

	var/datum/ritual/pickritual = new ritual

	var/turf/start_turf = get_step(src, NORTHWEST)
	var/turf/current_turf = start_turf
	var/list/ingredients = list()
	for(var/list/row in pickritual.requirements)
		for(var/req in row)
			if(req == null)
				current_turf = get_step(current_turf, EAST)
				continue
			var/I = locate(req) in current_turf
			if(I)
				ingredients+=I
				current_turf = get_step(current_turf, EAST)
				continue
			else
				pickritual.fail(user, get_turf(src), req)
				return
		start_turf = get_step(start_turf, SOUTH)
		current_turf = start_turf

	user.playsound_local(user, 'sound/vo/cult/tesa.ogg', 25)
	pickritual.success(user, get_turf(src), ingredients)

/obj/effect/decal/cleanable/sigil/proc/can_use_sigil(mob/living/user)
	if(HAS_TRAIT(user, TRAIT_RITUALIST))
		return TRUE
	else
		return FALSE

/obj/effect/decal/cleanable/sigil/proc/get_accessed_rituals(mob/living/user)
	var/list/rituals = list()
	for(var/G in GLOB.ritualslist)
		var/datum/ritual/path = GLOB.ritualslist[G]
		if(HAS_TRAIT(user, path.trait_to_use))
			rituals += path
	return rituals

/obj/effect/decal/cleanable/sigil/N
	icon_state = "N"

/obj/effect/decal/cleanable/sigil/NE
	icon_state = "NE"

/obj/effect/decal/cleanable/sigil/E
	icon_state = "E"

/obj/effect/decal/cleanable/sigil/SE
	icon_state = "SE"

/obj/effect/decal/cleanable/sigil/S
	icon_state = "S"

/obj/effect/decal/cleanable/sigil/SW
	icon_state = "SW"

/obj/effect/decal/cleanable/sigil/W
	icon_state = "W"

/obj/effect/decal/cleanable/sigil/NW
	icon_state = "NW"
