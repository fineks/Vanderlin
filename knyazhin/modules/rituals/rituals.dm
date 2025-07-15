/datum/ritual
	var/name = "ritual"
	var/consume_on_success = TRUE
	var/trait_to_use = TRAIT_RITUALIST
	var/do_announce = TRUE
	var/list/dontdeletelist

	//Ингредиенты для ритуала. В листы можешь вкладывать не 1 объект а несколько, тогда для рецепта пойдёт любой из перечисленных и его подклассы
	var/list/requirements = list(
		list(list(), list(), list()),
		list(list(), list(), list()),
		list(list(), list(), list())
	)

//Проверочка на разные условия, должна вызывать либо success либо fail
/datum/ritual/proc/check(mob/living/user, turf/affected_turf, list/ingredients)
	success(user,affected_turf,ingredients)

/datum/ritual/proc/success(mob/living/user, turf/affected_turf, list/ingredients)
	if(do_announce)
		priority_announce("Ритуал завершён. Боги довольны!","Ведьмин ритуал",'sound/magic/forgotten_bell.ogg')
	if(consume_on_success)
		consume_ingredients(ingredients,affected_turf)

/datum/ritual/proc/fail(mob/living/user, turf/affected_turf, list/req)
	return

/datum/ritual/proc/say_missing_ingredients(mob/living/user, turf/affected_turf, list/req)
	var/row
	var/elem
	for(var/i = 1, i <= 3, i++)
		var/list/row_list = requirements[i]
		var/found_req_index = row_list.Find(req)
		if(found_req_index)
			row = i
			elem = found_req_index
			break

	var/whereplace = affected_turf
	var/step = get_req_dir(row,elem)
	if(step)
		whereplace = get_step(whereplace,step)
	new /obj/effect/ritual_missing_ingredient(whereplace,req)

/datum/ritual/proc/consume_ingredients(list/ingredients,turf/affected_turf)
	for(var/atom/I in ingredients)
		if(!(I in dontdeletelist))
			playsound(affected_turf, 'sound/foley/flesh_rem2.ogg', 30)
			qdel(I)

/datum/ritual/proc/get_req_dir(row, elem)
	if(row == 2 && elem == 2)
		return null
	else if(row == 1 && elem == 1)
		return NORTHWEST
	else if(row == 1 && elem == 2)
		return NORTH
	else if(row == 1 && elem == 3)
		return NORTHEAST
	else if(row == 2 && elem == 1)
		return WEST
	else if(row == 2 && elem == 3)
		return EAST
	else if(row == 3 && elem == 1)
		return SOUTHWEST
	else if(row == 3 && elem == 2)
		return SOUTH
	else if(row == 3 && elem == 3)
		return SOUTHEAST

/obj/effect/ritual_missing_ingredient
	name=""
	desc=""
	icon_state = null
	alpha = 0
	color = COLOR_MAGENTA

	var/list/possible_ingredients

/obj/effect/ritual_missing_ingredient/Initialize(mapload, ...)
	. = ..()
	change()
	animate(src,alpha=170,time=2)
	animate(alpha=0,time=30)
	spawn(31)
		qdel(src)

/obj/effect/ritual_missing_ingredient/New(loc, var/list/req)
	possible_ingredients = req
	. = ..()

/obj/effect/ritual_missing_ingredient/proc/change()
	var/atom/chosen_ingredient = pick(possible_ingredients)
	name = chosen_ingredient.name
	desc = chosen_ingredient.desc
	icon = chosen_ingredient.icon
	icon_state = chosen_ingredient.icon_state
	update_appearance()
	spawn(3)
		change()

