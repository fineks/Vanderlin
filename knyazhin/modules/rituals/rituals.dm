/datum/ritual
	var/name = "ritual"
	var/consume_on_success = TRUE
	var/trait_to_use = TRAIT_RITUALIST
	var/list/requirements = list(
		list(null, null, null),
		list(null, null, null),
		list(null, null, null)
	)

/datum/ritual/proc/success(mob/living/user, turf/affected, list/ingredients)
	if(consume_on_success)
		consume_ingredients(ingredients)

/datum/ritual/proc/fail(mob/living/user, turf/affected, atom/req)
	say_missing_ingredients(user, req)
	return

/datum/ritual/proc/say_missing_ingredients(mob/living/user, atom/req)
	var/row
	var/elem
	for(var/i = 1, i <= 3, i++)
		var/list/row_list = requirements[i]
		var/found_req_index = row_list.Find(req)
		if(found_req_index)
			row = i
			elem = found_req_index
			break
	to_chat(user, "Не хватает [req.name] в направлении [get_req_dir(row, elem)]")

/datum/ritual/proc/consume_ingredients(list/ingredients)
	for(var/I in ingredients)
		playsound(src, 'sound/foley/flesh_rem2.ogg', 30)
		qdel(I)
/datum/ritual/proc/get_req_dir(row, elem)
	if(row == 2 && elem == 2)
		return "Центр"
	else if(row == 2 && elem == 2)
		return "Север"
	else if(row == 2 && elem == 1)
		return "Запад"
	else if(row == 2 && elem == 3)
		return "Восток"
	else if(row == 3 && elem == 2)
		return "Юг"
	else if(row == 1 && elem == 1)
		return "Северо-запад"
	else if(row == 1 && elem == 3)
		return "Северо-восток"
	else if(row == 3 && elem == 1)
		return "Юго-запад"
	else if(row == 3 && elem == 3)
		return "Юго-восток"
