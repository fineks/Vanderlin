#define DARK_SIGIL "dark"
#define LIGHT_SIGIL "light"

/turf/open/floor/proc/generateSigils(mob/M, sigil_type)
	var/turf/T = get_turf(M.loc)
	for(var/obj/A in T)
		if(istype(A, /obj/effect/decal/cleanable/sigil))
			to_chat(M, "<span class='warning'>There is already a sigil here.</span>")
			return
		if(A.density && !(A.flags_1 & ON_BORDER_1))
			to_chat(M, "<span class='warning'>There is already something here!</span>")
			return
	if(do_after(M, 5 SECONDS, src))
		var/obj/effect/decal/cleanable/sigil/C = new(src)
		C.sigil_type = sigil_type
		playsound(M, 'sound/items/write.ogg', 100)
		var/list/sigilsPath = list(
			/obj/effect/decal/cleanable/sigil/N,
			/obj/effect/decal/cleanable/sigil/S,
			/obj/effect/decal/cleanable/sigil/E,
			/obj/effect/decal/cleanable/sigil/W,
			/obj/effect/decal/cleanable/sigil/NE,
			/obj/effect/decal/cleanable/sigil/NW,
			/obj/effect/decal/cleanable/sigil/SE,
			/obj/effect/decal/cleanable/sigil/SW
		)

		for(var/i = 1; i <= GLOB.alldirs.len; i++)
			var/turf/floor = get_step(src, GLOB.alldirs[i])
			var/sigil = sigilsPath[i]

			new sigil(floor)

/obj/effect/proc_holder/spell/self/draw_sigil
	name = "Draw sigil"
	desc = "Draw a new sigil"
	overlay_state = "recruit_bog"
	antimagic_allowed = TRUE
	recharge_time = 50
	var/sigil_type = DARK_SIGIL

/obj/effect/proc_holder/spell/self/draw_sigil/cast(list/targets, mob/user)
	. = ..()

	var/turf/open/floor/T = get_turf(user)
	if(istype(T, /turf/open/floor/))
		T.generateSigils(user, sigil_type)

/obj/effect/proc_holder/spell/self/draw_sigil/light
	overlay_state = "recruit_bog"
	sigil_type = LIGHT_SIGIL

#undef DARK_SIGIL
#undef LIGHT_SIGIL
