

/mob/living/carbon/human/proc/release_minion()
	set name = "Release Lackey"
	set category = "ZIZO"

	var/list/mob/living/carbon/human/possible = list()
	for(var/datum/mind/V in SSmapping.retainer.cultists)
		if(V.special_role == "Zizoid Lackey")
			possible |= V.current

	var/mob/living/carbon/human/choice = input(src, "Whom do you no longer have use for?", "VANDERLIN") as null|anything in possible
	if(choice)
		var/alert = alert(src, "Are you sure?", "VANDERLIN", "Yes", "Cancel")
		if(alert == "Yes")
			visible_message("<span class='danger'>[src] reaches out, ripping up [choice]'s soul!</span>")
			to_chat(choice, "<span class='userdanger'>I HAVE FAILED MY LEADER! I HAVE FAILED ZIZO! NOTHING ELSE BUT DEATH REMAINS FOR ME NOW!</span>")
			sleep(20)
			choice.gib() // Cooler than dusting.
			SSmapping.retainer.cultists -= choice.mind
// SERVANTRY

/datum/ritual/convert
	name = "Convert"
	circle = "Servantry"
	requirements = list(
		list(null, null, null),
		list(null, /mob/living/carbon/human, null),
		list(null, null, null)
	)
	consume_ingredients = FALSE

/datum/ritual/convert/success(mob/living/user, /turf/affected)

	var/turf/C = affected
	for(var/mob/living/carbon/human/H in C.contents)
		if(H != user)
			if(iszizocultist(H) || iszizolackey(H))
				return
			if(!H.client)
				return
			if(H.anchored) // a way to bind the person to the rune if they choose to resist converting
				return
			if(istype(H.wear_neck, /obj/item/clothing/neck/psycross))
				to_chat(user.mind, "<span class='danger'>\"They are wearing my bane...\"</span>")
				return
			if(length(SSmapping.retainer.cultists) >= 8)
				to_chat(user.mind, "<span class='danger'>\"The veil is too strong to support more than seven lackeys.\"</span>")
				return
			var/datum/antagonist/zizocultist/PR = user.mind.has_antag_datum(/datum/antagonist/zizocultist)
			var/alert = alert(H, "YOU WILL BE SHOWN THE TRUTH. DO YOU RESIST? (Resisting: 1 TRI)", "VANDERLIN", "Yield", "Resist")
			H.anchored = TRUE
			if(alert == "Yield")
				to_chat(H.mind, "<span class='notice'>I see the truth now! It all makes so much sense! They aren't HERETICS! They want the BEST FOR US!</span>")
				PR.add_cultist(H.mind)
				H.praise()
				H.anchored = FALSE
			else
				H.adjust_triumphs(-1)
				H.visible_message("<span class='danger'>\The [H] thrashes around, unyielding!</span>")
				to_chat(H.mind, "<span class='danger'>\"Yield.\"</span>")
				if(H.electrocute_act(10))
					H.emote("painscream")
				sleep(20)
				H.anchored = FALSE


/datum/ritual/skeletaljaunt
	name = "Skeletal Jaunt"
	circle = "Servantry"

	var/list/requirements = matrix(
		null, /obj/item/organ/heart, null,
		null, /mob/living/carbon/human, null,
		null, null, null
	)

/datum/ritual/skeletaljaunt/success(mob/living/user, /turf/affected)
	..()
	var/turf/C = affected
	for(var/mob/living/carbon/human/target in C.contents)
		if(target == user)
			return
		if(iszizocultist(target))
			to_chat(target.mind, span_danger("\"I will not let my strongest follower become a mindless brute.\""))
			return

		var/static/datum/job/summon_job = SSjob.GetJobType(/datum/job/skeleton/zizoid)
		target.mind?.set_assigned_role(summon_job)
		target.dress_up_as_job(summon_job)
		summon_job.after_spawn(target, target.client)

		to_chat(target, span_userdanger("I am returned to serve. I will obey, so that I may return to rest."))
		to_chat(target, span_userdanger("My master is [user]."))
		break

/datum/ritual/thecall
	name = "The Call"
	circle = "Servantry"
	center_requirement = /obj/item/bedsheet

	w_req = /obj/item/bodypart/l_leg
	e_req = /obj/item/bodypart/r_leg

	function = /proc/thecall

/proc/thecall(mob/user, turf/C)
	for(var/obj/item/paper/P in C.contents)
		if(!user.mind || !user.mind.do_i_know(name=P.info))
			to_chat(user.mind, "<span class='warning'>I don't know anyone by that name.</span>")
			return
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.real_name == P.info)
				if(HL.has_status_effect(/datum/status_effect/debuff/sleepytime))
					if(HL.mind.assigned_role.title in GLOB.church_positions)
						to_chat(HL.mind, "<span class='warning'>I sense an unholy presence loom near my soul.</span>")
						return
					if(HL == SSticker.rulermob)
						return
					if(istype(HL.wear_neck, /obj/item/clothing/neck/psycross))
						return
					if(HAS_TRAIT(HL, TRAIT_NOSTAMINA))
						return
					to_chat(HL.mind, "<span class='warning'>I'm so sleepy...</span>")
					HL.SetSleeping(30)
					spawn(10 SECONDS)
						to_chat(HL.mind, "<span class='warning'>This isn't my bed... Where am I?!</span>")
						HL.playsound_local(HL.loc, pick('sound/misc/jumphumans (1).ogg','sound/misc/jumphumans (2).ogg','sound/misc/jumphumans (3).ogg'), 100)
						HL.forceMove(C)
					qdel(P)

/datum/ritual/falseappearance
	name = "Falsified Appearance"
	circle = "Servantry"
	center_requirement = /mob/living/carbon/human

	n_req = /obj/item/bodypart/head
	s_req = /obj/item/natural/glass/shard
	e_req = /obj/item/natural/glass/shard
	w_req = /obj/item/natural/glass/shard

	function = /proc/falseappearance

/proc/falseappearance(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		var/datum/preferences/A = new()//Randomize appearance for the guy
		var/first_names = GLOB.first_names
		if(H.gender == FEMALE)
			first_names = GLOB.first_names_female
		else
			first_names = GLOB.first_names_male
		A.apply_prefs_to(H)
		A.real_name = "[pick(first_names)]"
		H.dna.update_dna_identity()
		break

/datum/ritual/heartache
	name = "Heartaches"
	circle = "Servantry"
	center_requirement = /obj/item/organ/heart

	n_req = /obj/item/natural/worms/leech

	function = /proc/heartache

/obj/item/corruptedheart
	name = "corrupted heart"
	desc = "It sparkles with forbidden magic energy. It makes all the heart aches go away."
	icon = 'icons/obj/surgery.dmi'
	icon_state = "heart-on"

/obj/item/corruptedheart/attack(mob/living/M, mob/living/user)
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		if(user.patron.type == /datum/patron/inhumen/zizo)
			H.blood_volume = BLOOD_VOLUME_MAXIMUM
			to_chat(H, "<span class='notice'>My elixir of life is stagnant once again.</span>")
			qdel(src)
		else
			if(!do_after(user, 2 SECONDS, H))
				return
			if(M.cmode)
				user.electrocute_act(30)
			H.Stun(10 SECONDS)
			H.silent += 30
			qdel(src)

/proc/heartache(mob/user, turf/C)
	new /obj/item/corruptedheart(C)
	to_chat(user.mind, "<span class='notice'>A corrupted heart. When used on a non-enlightened mortal their heart shall ache and they will be immobilized and too stunned to speak. Perfect for getting new soon-to-be enlightened. Now, just don't use it at the combat ready.</span>")

/datum/ritual/darksunmark
	name = "Dark Sun's Mark"
	circle = "Servantry"
	center_requirement = /obj/item/weapon/knife/dagger // Requires a combat dagger. Can be iron, steel or silver.

	function = /proc/darksunmark

/proc/darksunmark(mob/user, turf/C)
	var/found_assassin = FALSE
	for(var/obj/item/paper/P in C.contents)
		if(!user.mind || !user.mind.do_i_know(name=P.info))
			to_chat(user, "<span class='warning'>I don't know anyone by that name.</span>")
			return
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.real_name == P.info)
				for (var/mob/living/carbon/carbon in GLOB.carbon_list) // Iterate through all mobs in the world
					if (HAS_TRAIT(carbon, TRAIT_ASSASSIN) && !(carbon.stat == DEAD)) //Check if they are an assassin and alive
						found_assassin = TRUE
						for(var/obj/item/I in carbon.get_all_gear()) // Checks to see if the assassin has their dagger on them. If so, the dagger will let them know of a new target.
							if(istype(I, /obj/item/weapon/knife/dagger/steel/profane)) // Checks to see if the assassin has their dagger on them.
								// carbon.visible_message("profane dagger whispers, <span class='danger'>\"The terrible Zizo has called for our aid. Hunt and strike down our common foe, [HL.real_name]!\"</span>")
								to_chat(carbon, "profane dagger whispers, <span class='danger'>\"The terrible Zizo has called for our aid. Hunt and strike down our common foe, [HL.real_name]!\"</span>")
				if(found_assassin == TRUE)
					ADD_TRAIT(HL, TRAIT_ZIZOID_HUNTED, TRAIT_GENERIC) // Gives the victim a trait to track that they are wanted dead.
					log_hunted("[key_name(HL)] playing as [HL] had the hunted flaw by Zizoid curse.")
					to_chat(HL, "<span class='danger'>My hair stands on end. Has someone just said my name? I should watch my back.</span>")
					to_chat(user, "<span class='warning'>Your target has been marked, your profane call answered by the Dark Sun. [HL.real_name] will surely perish!</span>")
					for(var/obj/item/weapon/knife/dagger/D in C.contents) // Get rid of the dagger used as a sacrifice.
						qdel(D)
					qdel(P) // Get rid of the paper with the name on it too.
					HL.playsound_local(HL.loc, 'sound/magic/marked.ogg', 100)
				else
					to_chat(user, "<span class='warning'>There has been no answer to your call to the Dark Sun. It seems his servants are far from here...</span>")
				return

// TRANSMUTATION

/datum/ritual/allseeingeye
	name = "All-seeing Eye"
	circle = "Transmutation"
	center_requirement = /obj/item/organ/eyes

	function = /proc/allseeingeye

/proc/allseeingeye(mob/user, turf/C)
	new /obj/item/scrying/eye(C)

/datum/ritual/criminalstool
	name = "Criminal's Tool"
	circle = "Transmutation"
	center_requirement = /obj/item/natural/cloth

	function = /proc/criminalstool

/obj/item/soap/cult
	name = "accursed soap"
	desc = "It is pulsating."
	clean_speed = 1
	clean_effectiveness = 100
	clean_strength = CLEAN_ALL

/proc/criminalstool(mob/user, turf/C)
	new /obj/item/soap/cult(C)
	to_chat(user.mind, "<span class='notice'>The Criminal's Tool. Could be useful for hiding tracks or getting rid of sigils.</span>")

/datum/ritual/propaganda
	name = "Propaganda"
	circle = "Transmutation"
	center_requirement = /obj/item/natural/worms/leech
	n_req = /obj/item/paper
	s_req = /obj/item/natural/feather

	function = /proc/propaganda

/proc/propaganda(mob/user, turf/C)
	new /obj/item/natural/worms/leech/propaganda(C)
	to_chat(user.mind, "<span class='notice'>A leech to make their minds wrangled. They'll be in bad spirits.</span>")

/datum/ritual/falseidol
	name = "False Idol"
	circle = "Transmutation"
	center_requirement = /mob/living/carbon/human
	w_req = /obj/item/paper
	s_req = /obj/item/natural/feather

	function = /proc/falseidol

/obj/effect/dummy/falseidol
	name = "false idol"
	icon = 'icons/effects/effects.dmi'
	icon_state = "static"
	desc = "Through lies interwine from blood into truth."

/obj/effect/dummy/falseidol/Crossed(atom/movable/AM, oldloc)
	. = ..()
	qdel(src)

/proc/falseidol(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		var/obj/effect/dummy/falseidol/idol = new(C)
		var/datum/icon_snapshot/entry = new
		entry.name = H.name
		entry.icon = H.icon
		entry.icon_state = H.icon_state
		entry.overlays = H.get_overlays_copy(list(HANDS_LAYER))	//ugh
		sleep(10)
		idol.name = entry.name
		idol.icon = entry.icon
		idol.icon_state = entry.icon_state
		idol.add_overlay(entry.overlays)
		break

/datum/ritual/invademind
	name = "Invade Mind"
	circle = "Transmutation"
	center_requirement = /obj/item/natural/feather

	function = /proc/invademind

/proc/invademind(mob/user, turf/C)
	for(var/obj/item/paper/P in C.contents)
		var/info = ""
		info = sanitize(P.info)
		var/input = stripped_input(user, "To whom do we send this message?", "VANDERLIN")
		if(!input)
			return
		for(var/mob/living/carbon/human/HL in GLOB.human_list)
			if(HL.real_name == input)
				qdel(P)
				to_chat(HL, "<i>You hear a voice in your head... <b>[info]</i></b>")
		break

/datum/ritual/summonweapons
	name = "Summon Weaponry"
	circle = "Transmutation"
	center_requirement = /obj/item/ingot/steel

	function = /proc/summonweapons
	is_cultist_ritual = TRUE

/proc/summonweapons(mob/user, turf/C)
	var/datum/effect_system/spark_spread/S = new(C)
	S.set_up(1, 1, C)
	S.start()

	new /obj/item/clothing/head/helmet/skullcap/cult(C)
	new /obj/item/clothing/head/helmet/skullcap/cult(C)

	new /obj/item/clothing/cloak/half/shadowcloak/cult(C)
	new /obj/item/clothing/cloak/half/shadowcloak/cult(C)

	new /obj/item/weapon/sword/scimitar/falchion(C)
	new /obj/item/weapon/knife/hunting(C)
	new /obj/item/weapon/mace/spiked(C)

	new /obj/item/rope/chain(C)
	new /obj/item/rope/chain(C)

	playsound(C,pick('sound/items/bsmith1.ogg','sound/items/bsmith2.ogg','sound/items/bsmith3.ogg','sound/items/bsmith4.ogg'), 100, FALSE)

// FLESH CRAFTING

/datum/ritual/bunnylegs
	name = "Saliendo Pedes"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/bodypart/l_leg
	e_req = /obj/item/bodypart/r_leg
	n_req = /obj/item/reagent_containers/food/snacks/meat

	function = /proc/bunnylegs

	is_cultist_ritual = TRUE

/proc/bunnylegs(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		ADD_TRAIT(H, TRAIT_ZJUMP, TRAIT_GENERIC)
		to_chat(H.mind, "<span class='notice'>I feel like my legs have become stronger.</span>")
		break

/datum/ritual/fleshmend
	name = "Fleshmend"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human
	n_req =  /obj/item/reagent_containers/food/snacks/meat

	function = /proc/fleshmend

/proc/fleshmend(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		H.playsound_local(C, 'sound/misc/vampirespell.ogg', 100, FALSE, pressure_affected = FALSE)
		H.fully_heal()
		to_chat(H.mind, "<span class='notice'>ZIZO EMPOWERS ME!</span>")
		break

/datum/ritual/darkeyes
	name = "Darkened Eyes"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/organ/eyes
	e_req = /obj/item/organ/eyes
	n_req = /obj/item/reagent_containers/food/snacks/meat

	function = /proc/darkeyes

/proc/darkeyes(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		H.grant_undead_eyes()
		to_chat(H.mind, "<span class='notice'>I no longer fear the dark.</span>")
		break

/datum/ritual/nopain
	name = "Painless Battle"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/organ/heart
	e_req = /obj/item/organ/brain
	n_req = /obj/item/reagent_containers/food/snacks/meat

	function = /proc/nopain

/proc/nopain(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		ADD_TRAIT(user, TRAIT_NOPAIN, TRAIT_GENERIC)
		to_chat(H.mind, "<span class='notice'>I no longer feel pain, but it has come at a terrible cost.</span>")
		H.change_stat(STATKEY_STR, -2)
		H.change_stat(STATKEY_CON, -3)
		break

/datum/ritual/fleshform
	name = "Stronger Form"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	w_req = /obj/item/organ/guts
	e_req = /obj/item/organ/guts
	n_req = /obj/item/reagent_containers/food/snacks/meat
	s_req = /obj/item/reagent_containers/food/snacks/meat

	function = /proc/fleshform

	is_cultist_ritual = TRUE

/proc/fleshform(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(iszizocultist(H))
			to_chat(H.mind, "<span class='danger'>\"I'm not letting my strongest follower become a mindless brute.\"</span>")
			return
		to_chat(user.mind, "<span class='danger'>SOON I WILL BECOME A HIGHER FORM!!!</span>")
		sleep(5 SECONDS)
		var/mob/living/trl = new /mob/living/simple_animal/hostile/retaliate/blood(H)
		trl.forceMove(H)
		trl.ckey = H.ckey
		H.gib()

/datum/ritual/gutted
	name = "Gutted Fish"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human // One to be gutted.human

	function = /proc/guttedlikeafish

/proc/guttedlikeafish(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H.stat == DEAD)
			H.take_overall_damage(500)
			C.visible_message("<span class='danger'>[H.real_name] is lifted up into the air and multiple scratches, incisions and deep cuts start etching themselves into their skin as all of their internal organs spill on the floor below!</span>")

			var/atom/drop_location = H.drop_location()
			for(var/obj/item/organ/organ as anything in H.internal_organs)
				organ.Remove(H)
				organ.forceMove(drop_location)
			var/obj/item/bodypart/chest/cavity = H.get_bodypart(BODY_ZONE_CHEST)
			if(cavity.cavity_item)
				cavity.cavity_item.forceMove(drop_location)
				cavity.cavity_item = null

/datum/ritual/badomen
	name = "Bad Omen"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human

	function = /proc/badomenzizo

	is_cultist_ritual = TRUE

/proc/badomenzizo(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(H.stat == DEAD)
			H.gib(FALSE, FALSE, FALSE)
			addomen(OMEN_ROUNDSTART)

/datum/ritual/ascend
	name = "ASCEND!"
	circle = "Fleshcrafting"
	center_requirement = /mob/living/carbon/human // cult leader

	n_req = /mob/living/carbon/human // the ruler
	s_req = /mob/living/carbon/human // virgin

	function = /proc/ascend
	is_cultist_ritual = TRUE

/proc/ascend(mob/user, turf/C)
	for(var/mob/living/carbon/human/H in C.contents)
		if(!iszizocultist(H))
			return
		for(var/mob/living/carbon/human/RULER in get_step(C, NORTH))
		for(var/mob/living/carbon/human/RULER in get_step(C, NORTH))
			if(RULER != SSticker.rulermob && RULER.stat != DEAD)
				break
			RULER.gib()
		for(var/mob/living/carbon/human/VIRGIN in get_step(C, SOUTH))
		for(var/mob/living/carbon/human/VIRGIN in get_step(C, SOUTH))
			if(!VIRGIN.virginity && VIRGIN.stat != DEAD)
				break
			VIRGIN.gib()
		SSmapping.retainer.cult_ascended = TRUE
		addomen(OMEN_ASCEND)
		to_chat(user.mind, "<span class='userdanger'>I HAVE DONE IT! I HAVE REACHED A HIGHER FORM! ZIZO SMILES UPON ME WITH MALICE IN HER EYES TOWARD THE ONES WHO LACK KNOWLEDGE AND UNDERSTANDING!</span>")
		var/mob/living/trl = new /mob/living/simple_animal/hostile/retaliate/blood/ascended(C)
		trl.ckey = H.ckey
		H.gib()
		to_chat(world, "\n<font color='purple'>15 minutes remain.</font>")
		for(var/mob/living/carbon/human/V in GLOB.human_list)
			if(V.mind in SSmapping.retainer.cultists)
				V.add_stress(/datum/stressevent/lovezizo)
			else
				V.add_stress(/datum/stressevent/hatezizo)
		SSgamemode.roundvoteend = TRUE
		break
