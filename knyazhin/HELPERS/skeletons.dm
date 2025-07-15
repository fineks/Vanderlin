/mob/living/carbon/human/proc/make_skeleton()
	if(mind)
		mind.special_role = "Skeleton"
		job = null
	if(dna && dna.species)
		dna.species.species_traits |= NOBLOOD
		dna.species.soundpack_m = new /datum/voicepack/skeleton()
		dna.species.soundpack_f = new /datum/voicepack/skeleton()
	var/obj/item/bodypart/O = get_bodypart(BODY_ZONE_R_ARM)
	if(O)
		O.drop_limb()
		qdel(O)
	O = get_bodypart(BODY_ZONE_L_ARM)
	if(O)
		O.drop_limb()
		qdel(O)
	regenerate_limb(BODY_ZONE_R_ARM)
	regenerate_limb(BODY_ZONE_L_ARM)
	skeletonize()
	base_intents = list(INTENT_HELP, INTENT_DISARM, INTENT_GRAB, /datum/intent/simple/claw)
	update_a_intents()

	grant_undead_eyes()
	ambushable = FALSE
	underwear = "Nude"
	if(charflaw)
		QDEL_NULL(charflaw)
	update_body()
	mob_biotypes = MOB_UNDEAD
	faction = list(FACTION_UNDEAD)
	ADD_TRAIT(src, TRAIT_NOMOOD, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSTAMINA, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOLIMBDISABLE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOHUNGER, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOBREATH, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOPAIN, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_TOXIMMUNE, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_NOSLEEP, TRAIT_GENERIC)
	ADD_TRAIT(src, TRAIT_SHOCKIMMUNE, TRAIT_GENERIC)
