/datum/ritual/skeletaljaunt
	name = "Skeletal Jaunt"
	consume_on_success = FALSE
	trait_to_use = TRAIT_RITUALS_VEDMA

	requirements = list(
		list(null, null, null),
		list(null, /mob/living/carbon/human, null),
		list(null, null, null)
	)

/datum/ritual/skeletaljaunt/success(mob/living/user, turf/affected)
	. = ..()
	var/turf/C = affected
	for(var/mob/living/carbon/human/target in C.contents)
		if(target == user)
			return
		target.make_skeleton()

/datum/ritual/test
	name = "test"
	trait_to_use = TRAIT_RITUALS_VEDMA
	requirements = list(
		list(null, null, null),
		list(null, /obj/item/bedsheet, null),
		list(null, null, null)
	)

/datum/ritual/test/success(mob/living/user, turf/affected)
	. = ..()
	to_chat(user, "Test")
