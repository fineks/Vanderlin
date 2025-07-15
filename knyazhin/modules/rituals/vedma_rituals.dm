/datum/ritual/skeletaljaunt
	name = "Skeletal Jaunt"
	consume_on_success = FALSE
	do_announce = FALSE
	trait_to_use = TRAIT_RITUALS_VEDMA

	requirements = list(
		list(list(), list(), list()),
		list(list(), /mob/living/carbon/human, list()),
		list(list(), list(), list())
	)

/datum/ritual/skeletaljaunt/success(mob/living/user, turf/affected)
	. = ..()
	var/turf/C = affected
	for(var/mob/living/carbon/human/target in C.contents)
		if(target == user)
			return
		target.make_skeleton()

// /datum/ritual/test
// 	name = "test"
// 	trait_to_use = TRAIT_RITUALS_VEDMA
// 	requirements = list(
// 		list(list(), list(), list()),
// 		list(list(), list(/obj/item/bedsheet), list()),
// 		list(list(), list(), list())
// 	)

// /datum/ritual/test/success(mob/living/user, turf/affected)
// 	. = ..()
// 	to_chat(user, "Test")

/datum/ritual/fertility
	name = "Fertility"
	consume_on_success = FALSE
	trait_to_use = TRAIT_RITUALS_VEDMA

	requirements = list(
		list(list(), list(), list()),
		list(list(), list(/mob/living/simple_animal/hostile/retaliate/trufflepig,/mob/living/simple_animal/hostile/retaliate/goat,/mob/living/simple_animal/hostile/retaliate/cow,/mob/living/simple_animal/hostile/retaliate/chicken), list()),
		list(list(), list(), list())
	)

/datum/ritual/fertility/check(mob/living/user, turf/affected_turf, list/ingredients)
	for(var/mob/sacrifice in ingredients)
		if(sacrifice.stat != CONSCIOUS)
			return
		sacrifice.death()
	success(user,affected_turf,ingredients)

/datum/ritual/fertility/success(mob/living/user, turf/affected_turf, list/ingredients)
	. = ..()
	for(var/obj/structure/soil/s in GLOB.weather_act_upon_list)
		if(s.plant)
			s.add_growth(s.plant.maturation_time)
			s.add_growth(s.plant.produce_time)
			s.update_appearance()



/datum/ritual/triumphant_sacrifice
	name = "Triumphant sacrifice"
	consume_on_success = TRUE
	dontdeletelist = list(/mob/living/carbon/human)
	trait_to_use = TRAIT_RITUALS_VEDMA
	requirements = list(
		list(list(/obj/item/reagent_containers/glass/cup/golden), list(/obj/item/kitchen/spoon/iron), list(/obj/item/reagent_containers/glass/cup/golden)),
		list(list(/obj/item/plate/gold), list(/mob/living/carbon/human), list(/obj/item/plate/gold)),
		list(list(/obj/item/kitchen/fork/iron), list(/obj/item/kitchen/spoon/iron), list(/obj/item/kitchen/fork/iron))
	)

/datum/ritual/triumphant_sacrifice/check(mob/living/user, turf/affected_turf, list/ingredients)
	for(var/mob/living/carbon/human/sacrifice in ingredients)
		if(sacrifice.stat == CONSCIOUS)
			sacrifice.death()
		else
			return
	success(user,affected_turf,ingredients)

/datum/ritual/triumphant_sacrifice/success(mob/living/user, turf/affected_turf, list/ingredients)
	. = ..()
	for(var/mob/p in GLOB.player_list)
		p.adjust_triumphs(rand(2,5),reason="Ведьмин ритуал")



/datum/ritual/transmutation
	name = "Transmutation"
	do_announce = FALSE
	consume_on_success = TRUE
	trait_to_use = TRAIT_RITUALS_VEDMA
	dontdeletelist = list(/mob/living/simple_animal/hostile/retaliate/goat)
	requirements = list(
		list(list(/obj/item/ingot/copper), list(/obj/item/ingot/copper), list(/obj/item/ingot/copper)),
		list(list(/obj/item/ingot/copper), list(/mob/living/simple_animal/hostile/retaliate/goat), list(/obj/item/ingot/copper)),
		list(list(/obj/item/ingot/copper), list(/obj/item/ingot/copper), list(/obj/item/ingot/copper))
	)

/datum/ritual/transmutation/check(mob/living/user, turf/affected_turf, list/ingredients)
	var/mob/living/simple_animal/hostile/retaliate/goat/goat = ingredients[5]
	if(goat.stat == CONSCIOUS)
		goat.death()
	else
		return
	success(user,affected_turf,ingredients)


/datum/ritual/transmutation/success(mob/living/user, turf/affected_turf, list/ingredients)
	. = ..()
	new /obj/item/ingot/steel(affected_turf)
	new /obj/item/ingot/steel(affected_turf)
	new /obj/item/ingot/steel(affected_turf)
	new /obj/item/ingot/steel(affected_turf)
	new /obj/item/ingot/steel(affected_turf)
	new /obj/item/ingot/steel(affected_turf)
	new /obj/item/ingot/steel(affected_turf)
	new /obj/item/ingot/steel(affected_turf)

/datum/ritual/zizosacrifice
	name = "Zizo sacrifice"
	do_announce = TRUE
	consume_on_success = TRUE
	trait_to_use = TRAIT_RITUALS_VEDMA
	dontdeletelist = list(/mob/living/carbon/human)
	requirements = list(
		list(list(), list(/obj/item/clothing/head/helmet/heavy/frog), list()),
		list(list(/obj/item/clothing/armor/plate), list(/mob/living/carbon/human), list(/obj/item/clothing/gloves/plate)),
		list(list(/obj/item/clothing/pants/platelegs), list(), list(/obj/item/clothing/shoes/boots/armor))
	)

/datum/ritual/zizosacrifice/check(mob/living/user, turf/affected_turf, list/ingredients)
	for(var/mob/living/carbon/human/sacrifice in ingredients)
		if(sacrifice.stat == CONSCIOUS)
			sacrifice.death()
		else
			return
	success(user,affected_turf,ingredients)

/datum/ritual/zizosacrifice/success(mob/living/user, turf/affected_turf, list/ingredients)
	. = ..()
	new /obj/item/clothing/head/helmet/heavy/zizo(affected_turf)
	new /obj/item/clothing/armor/plate/full/zizo(affected_turf)
	new /obj/item/clothing/pants/platelegs/zizo(affected_turf)
	new /obj/item/clothing/gloves/plate/zizo(affected_turf)
	new /obj/item/clothing/shoes/boots/armor/zizo(affected_turf)

