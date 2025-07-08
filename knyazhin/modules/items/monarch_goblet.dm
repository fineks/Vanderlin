#define STANDART_COOLDOWN 5 MINUTES

/obj/item/reagent_containers/glass/monarch_goblet
	name = "Старый кубок"
	desc = "Пыльный кубок из темного металла"
	icon = 'icons/roguetown/items/cooking.dmi'
	icon_state = "cup_steel"
	sellprice = VALUE_EXTREME
	resistance_flags = FIRE_PROOF|ACID_PROOF|LAVA_PROOF|UNACIDABLE|INDESTRUCTIBLE
	amount_per_transfer_from_this = 30
	possible_item_intents = list(INTENT_GENERIC, INTENT_POUR)

	var/list/followers = list()
	var/mob/living/carbon/human/coronated

	var/using_cooldown

/obj/item/reagent_containers/glass/monarch_goblet/attack_self(mob/living/user)
	var/mob/living/carbon/human/H = user
	var/mob/living/carbon/human/old_monarch = get_monarch()

	if(coronated)
		var/answer = input(user, "Что ты хочешь сделать?", "") in list("Сбросить ритуал", "Добавить свою кровь")
		if(answer == "Сбросить ритуал")
			coronated = null
			clearlist(followers)
			return
		handle_follower_blood(H)
	else
		handle_coronated_blood(H, old_monarch)

/obj/item/reagent_containers/glass/monarch_goblet/proc/handle_follower_blood(var/mob/living/carbon/human/H)
	if(H in followers)
		return
	if(H == coronated)
		return to_chat(H, "Ищи сообщников")
	if(length(followers) >= 3)
		return visible_message("Довольно люду")
	if(!istype(H.get_inactive_held_item(), /obj/item/weapon/knife))
		to_chat(H, "Без ножа не получится выдавить кровь")
		return
	if(do_after(H, 2 SECONDS, src))
		handle_blood_transfer(H)
		followers+=H

/obj/item/reagent_containers/glass/monarch_goblet/proc/handle_coronated_blood(var/mob/living/carbon/human/H, mob/living/carbon/human/old_monarch)
	if(!istype(H.get_inactive_held_item(), /obj/item/weapon/knife))
		to_chat(H, "Без ножа не получится выдавить кровь")
		return
	if(old_monarch)
		if(old_monarch.stat != DEAD)
			to_chat("Кубок холодеет в твоей руке. Князь еще жив")
			return
	if(do_after(H, 2 SECONDS, src))
		to_chat(H, "Ты делаешь надрез и капаешь каплю крови в кубок. Теперь дело за твоими сообщниками")
		handle_blood_transfer(H)
		coronated = H

/obj/item/reagent_containers/glass/monarch_goblet/proc/handle_blood_transfer(mob/living/user)
	playsound(user, "sound/combat/hits/bladed/genslash (1).ogg", 75)
	var/obj/item/bodypart/arm = user.get_bodypart(pick(BODY_ZONE_R_ARM, BODY_ZONE_L_ARM))
	arm.receive_damage(15)
	arm.add_wound(/datum/wound/slash/small)
	user.transfer_blood_to(src, 3)

/obj/item/reagent_containers/glass/monarch_goblet/pour(mob/living/M, mob/living/user)
	var/mob/living/carbon/human/H = user
	if(coronated == user)
		if(!istype(H.head, /obj/item/clothing/head/crown/serpcrown))
			visible_message("Корона есмь символ твой, надень его")
			return
		if(length(followers) >= 3)
			if(coronated != M)
				visible_message("Не венчай чуждаго")
				return
			if(do_after(H, 5 SECONDS, src))
				var/datum/job/lord_job = SSjob.GetJobType(/datum/job/lord)
				coronate(H)
				visible_message("Велика слава тебе, княже родовыи")
				priority_announce("[coronated.real_name] есть новый князь [SSmapping.config.map_name] земель !", \
				title = "Да заживешь на веки, [lord_job.get_informed_title(coronated)] [coronated.real_name]!", sound = 'sound/misc/gods/zizo_omen.ogg')
				coronated = null
				clearlist(followers)
		else
			visible_message("Мало избранных к делу сему")
	else
		visible_message("Лишь будущему князю дозволено пить")

#undef STANDART_COOLDOWN
