/atom/movable/screen/human

/atom/movable/screen/human/toggle
	name = "toggle"
	icon_state = "toggle"

/atom/movable/screen/human/toggle/Click()

	var/mob/targetmob = usr

	if(isobserver(usr))
		if(ishuman(usr.client.eye) && (usr.client.eye != usr))
			var/mob/M = usr.client.eye
			targetmob = M

	if(usr.hud_used.inventory_shown && targetmob.hud_used)
		usr.hud_used.inventory_shown = FALSE
		usr.client.screen -= targetmob.hud_used.toggleable_inventory
	else
		usr.hud_used.inventory_shown = TRUE
		usr.client.screen += targetmob.hud_used.toggleable_inventory

	targetmob.hud_used.hidden_inventory_update(usr)

/atom/movable/screen/human/equip
	name = "equip"
	icon_state = "act_equip"

/atom/movable/screen/human/equip/Click()
	var/mob/living/carbon/human/H = usr
	H.quick_equip()

/atom/movable/screen/devil
	invisibility = INVISIBILITY_ABSTRACT

/atom/movable/screen/devil/soul_counter
	icon = 'icons/mob/screen_gen.dmi'
	name = "souls owned"
	icon_state = "Devil-6"
	screen_loc = ui_devilsouldisplay

/atom/movable/screen/devil/soul_counter/proc/update_counter(souls = 0)
	invisibility = 0
	maptext = "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'><font color='#FF0000'>[souls]</font></div>"
	switch(souls)
		if(0,null)
			icon_state = "Devil-1"
		if(1,2)
			icon_state = "Devil-2"
		if(3 to 5)
			icon_state = "Devil-3"
		if(6 to 8)
			icon_state = "Devil-4"
		if(9 to INFINITY)
			icon_state = "Devil-5"
		else
			icon_state = "Devil-6"

/atom/movable/screen/devil/soul_counter/proc/clear()
	invisibility = INVISIBILITY_ABSTRACT

/datum/hud/human/New(mob/living/carbon/human/owner)

	..()
	owner.overlay_fullscreen("see_through_darkness", /atom/movable/screen/fullscreen/see_through_darkness)
/*
	var/widescreen_layout = FALSE
	if(owner.client?.prefs?.widescreenpref)
		widescreen_layout = FALSE
*/
	var/atom/movable/screen/using
	var/atom/movable/screen/inventory/inv_box

	ui_style = ui_style

	//Rogue Slots /////////////////////////////////

	scannies = new /atom/movable/screen/scannies
	scannies.hud = src
	static_inventory += scannies
	if(owner.client?.prefs?.crt == TRUE)
		scannies.alpha = 70

	action_intent = new /atom/movable/screen/act_intent/rogintent
	action_intent.hud = src
	action_intent.screen_loc = rogueui_intents
	static_inventory += action_intent

//	clock = new /atom/movable/screen/time
//	clock.hud = src
//	clock.screen_loc = rogueui_clock
//	static_inventory += clock

	stressies = new /atom/movable/screen/stress
	stressies.hud = src
	stressies.screen_loc = rogueui_stress
	static_inventory += stressies
	stressies.update_appearance(UPDATE_OVERLAYS)

	rmb_intent = new /atom/movable/screen/rmbintent(owner.client)
	rmb_intent.hud = src
	rmb_intent.screen_loc = rogueui_rmbintents
	static_inventory += rmb_intent
	rmb_intent.update_appearance(UPDATE_OVERLAYS)

	bloods = new /atom/movable/screen/healths/blood
	bloods.hud = src
	bloods.screen_loc = rogueui_blood
	static_inventory += bloods

	quad_intents = new /atom/movable/screen/quad_intents
	quad_intents.hud = src
	static_inventory += quad_intents

	def_intent = new /atom/movable/screen/def_intent
	def_intent.hud = src
	static_inventory += def_intent

	cmode_button = new /atom/movable/screen/cmode
	cmode_button.hud = src
	static_inventory += cmode_button

	give_intent = new /atom/movable/screen/give_intent
	give_intent.hud = src
	static_inventory += give_intent

	backhudl =  new /atom/movable/screen/backhudl()
	backhudl.hud = src
	static_inventory += backhudl

	hsover =  new /atom/movable/screen/heatstamover()
	hsover.hud = src
	static_inventory += hsover

	mana_over =  new /atom/movable/screen/mana_over()
	mana_over.hud = src
	static_inventory += mana_over

	fov = new /atom/movable/screen/fov()
	fov.hud = src
	static_inventory += fov

	fov_blocker = new /atom/movable/screen/fov_blocker()
	fov_blocker.hud = src
	static_inventory += fov_blocker

	cdleft = new /atom/movable/screen/action_bar/clickdelay/left()
	cdleft.hud = src
	cdleft.screen_loc = "WEST-3:-16,SOUTH+7"
	static_inventory += cdleft

	cdright = new /atom/movable/screen/action_bar/clickdelay/right()
	cdright.hud = src
	cdright.screen_loc = "WEST-2:-16,SOUTH+7"
	static_inventory += cdright

	cdmid = new /atom/movable/screen/action_bar/clickdelay()
	cdmid.hud = src
	cdmid.screen_loc = "WEST-3:0,SOUTH+7"
	static_inventory += cdmid

	build_hand_slots()

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "ring"
	inv_box.icon = ui_style
	inv_box.icon_state = "ring"
	inv_box.screen_loc = rogueui_ringr
	inv_box.slot_id = ITEM_SLOT_RING
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "wrists"
	inv_box.icon = ui_style
	inv_box.icon_state = "wrist"
	inv_box.screen_loc = rogueui_wrists
	inv_box.slot_id = ITEM_SLOT_WRISTS
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "mask"
	inv_box.icon = ui_style
	inv_box.icon_state = "mask"
	inv_box.screen_loc = rogueui_mask
	inv_box.slot_id = ITEM_SLOT_MASK
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "neck"
	inv_box.icon = ui_style
	inv_box.icon_state = "neck"
	inv_box.screen_loc = rogueui_neck
	inv_box.slot_id = ITEM_SLOT_NECK
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "backl"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.screen_loc = rogueui_backl
	inv_box.slot_id = ITEM_SLOT_BACK_L
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "backr"
	inv_box.icon = ui_style
	inv_box.icon_state = "back"
	inv_box.screen_loc = rogueui_backr
	inv_box.slot_id = ITEM_SLOT_BACK_R
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "gloves"
	inv_box.icon = ui_style
	inv_box.icon_state = "gloves"
	inv_box.screen_loc = rogueui_gloves
	inv_box.slot_id = ITEM_SLOT_GLOVES
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "head"
	inv_box.icon = ui_style
	inv_box.icon_state = "head"
	inv_box.screen_loc = rogueui_head
	inv_box.slot_id = ITEM_SLOT_HEAD
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "shoes"
	inv_box.icon = ui_style
	inv_box.icon_state = "shoes"
	inv_box.screen_loc = rogueui_shoes
	inv_box.slot_id = ITEM_SLOT_SHOES
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "belt"
	inv_box.icon = ui_style
	inv_box.icon_state = "belt"
	inv_box.screen_loc = rogueui_belt
	inv_box.slot_id = ITEM_SLOT_BELT
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "hip r"
	inv_box.icon = ui_style
	inv_box.icon_state = "hip"
	inv_box.screen_loc = rogueui_beltr
	inv_box.slot_id = ITEM_SLOT_BELT_R
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "hip l"
	inv_box.icon = ui_style
	inv_box.icon_state = "hip"
	inv_box.screen_loc = rogueui_beltl
	inv_box.slot_id = ITEM_SLOT_BELT_L
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "shirt"
	inv_box.icon = ui_style
	inv_box.icon_state = "shirt"
	inv_box.screen_loc = rogueui_shirt
	inv_box.slot_id = ITEM_SLOT_SHIRT
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "trou"
	inv_box.icon = ui_style
	inv_box.icon_state = "pants"
	inv_box.screen_loc = rogueui_pants
	inv_box.slot_id = ITEM_SLOT_PANTS
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "armor"
	inv_box.icon = ui_style
	inv_box.icon_state = "armor"
	inv_box.screen_loc = rogueui_armor
	inv_box.slot_id = ITEM_SLOT_ARMOR
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "cloak"
	inv_box.icon = ui_style
	inv_box.icon_state = "cloak"
	inv_box.screen_loc = rogueui_cloak
	inv_box.slot_id = ITEM_SLOT_CLOAK
	inv_box.hud = src
	static_inventory += inv_box

	inv_box = new /atom/movable/screen/inventory()
	inv_box.name = "mouth"
	inv_box.icon = ui_style
	inv_box.icon_state = "mouth"
	inv_box.screen_loc = rogueui_mouth
	inv_box.slot_id = ITEM_SLOT_MOUTH
	inv_box.hud = src
	static_inventory += inv_box

	using = new /atom/movable/screen/drop()
	using.icon = ui_style
	using.screen_loc = rogueui_drop
	using.hud = src
	static_inventory += using

	throw_icon = new /atom/movable/screen/throw_catch()
	throw_icon.icon = ui_style
	throw_icon.screen_loc = rogueui_throw
	throw_icon.hud = src
	hotkeybuttons += throw_icon

	using = new /atom/movable/screen/restup()
	using.icon = ui_style
	using.screen_loc = rogueui_stance
	using.hud = src
	static_inventory += using

	using = new /atom/movable/screen/restdown()
	using.icon = ui_style
	using.screen_loc = rogueui_stance
	using.hud = src
	static_inventory += using

	using = new/atom/movable/screen/skills
	using.icon = ui_style
	using.screen_loc = rogueui_skills
	static_inventory += using

	using = new/atom/movable/screen/craft
	using.icon = ui_style
	using.screen_loc = rogueui_craft
	static_inventory += using


/*	using = new /atom/movable/screen/resist()
	using.icon = ui_style
	using.screen_loc = rogueui_resist
	using.hud = src
	hotkeybuttons += using
*/
//sneak button
	using = new /atom/movable/screen/rogmove
	using.screen_loc = rogueui_moves
	using.hud = src
	static_inventory += using
	using.update_appearance(UPDATE_ICON_STATE)
//sprint button
	using = new /atom/movable/screen/rogmove/sprint
	using.screen_loc = rogueui_moves
	using.hud = src
	static_inventory += using
	using.update_appearance(UPDATE_ICON_STATE)

	using = new /atom/movable/screen/eye_intent
	using.icon = ui_style
	using.icon_state = "eye"
	using.screen_loc = rogueui_eye
	using.hud = src
	static_inventory += using
	using.update_appearance(UPDATE_OVERLAYS)

	set_advclass()

	zone_select =  new /atom/movable/screen/zone_sel()
	zone_select.icon = 'icons/mob/roguehud64.dmi'
	zone_select.screen_loc = rogueui_targetdoll
	zone_select.update_appearance()
	zone_select.hud = src
	static_inventory += zone_select

	zone_select.update_appearance()

	stamina = new /atom/movable/screen/stamina()
	infodisplay += stamina

	energy = new /atom/movable/screen/energy()
	infodisplay += energy

	mana = new /atom/movable/screen/mana()
	infodisplay += mana


	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			inv.hud = src
			inv_slots[TOBITSHIFT(inv.slot_id) + 1] = inv
			inv.update_appearance()

	update_locked_slots()
	mymob.update_a_intents()

/datum/hud/human/update_locked_slots()
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob
	if(!istype(H) || !H.dna)
		return
	var/datum/species/S = H.dna.species
	if(!S)
		return
	for(var/atom/movable/screen/inventory/inv in (static_inventory + toggleable_inventory))
		if(inv.slot_id)
			if(inv.slot_id in S.no_equip)
				inv.alpha = 128
			else
				inv.alpha = initial(inv.alpha)

/datum/hud/human/hidden_inventory_update(mob/viewer)
	if(!mymob)
		return
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used.inventory_shown && screenmob.hud_used.hud_shown)
		if(H.shoes)
			H.shoes.screen_loc = rogueui_shoes
			screenmob.client.screen += H.shoes
		if(H.gloves)
			H.gloves.screen_loc = rogueui_gloves
			screenmob.client.screen += H.gloves
		if(H.wear_mask)
			H.wear_mask.screen_loc = rogueui_mask
			screenmob.client.screen += H.wear_mask
		if(H.mouth)
			H.mouth.screen_loc = rogueui_mouth
			screenmob.client.screen += H.mouth
		if(H.wear_neck)
			H.wear_neck.screen_loc = rogueui_neck
			screenmob.client.screen += H.wear_neck
		if(H.cloak)
			H.cloak.screen_loc = rogueui_cloak
			screenmob.client.screen += H.cloak
		if(H.wear_armor)
			H.wear_armor.screen_loc = rogueui_armor
			screenmob.client.screen += H.wear_armor
		if(H.wear_pants)
			H.wear_pants.screen_loc = rogueui_pants
			screenmob.client.screen += H.wear_pants
		if(H.wear_shirt)
			H.wear_shirt.screen_loc = rogueui_shirt
			screenmob.client.screen += H.wear_shirt
		if(H.wear_ring)
			H.wear_ring.screen_loc = rogueui_ringr
			screenmob.client.screen += H.wear_ring
		if(H.wear_wrists)
			H.wear_wrists.screen_loc = rogueui_wrists
			screenmob.client.screen += H.wear_wrists
		if(H.backr)
			H.backr.screen_loc = rogueui_backr
			screenmob.client.screen += H.backr
		if(H.backl)
			H.backl.screen_loc = rogueui_backl
			screenmob.client.screen += H.backl
		if(H.beltr)
			H.beltr.screen_loc = rogueui_beltr
			screenmob.client.screen += H.beltr
		if(H.belt)
			H.belt.screen_loc = rogueui_belt
			screenmob.client.screen += H.belt
		if(H.beltl)
			H.beltl.screen_loc = rogueui_beltl
			screenmob.client.screen += H.beltl
		if(H.head)
			H.head.screen_loc = rogueui_head
			screenmob.client.screen += H.head
	else
		return



/datum/hud/human/persistent_inventory_update(mob/viewer)
	if(!mymob)
		return
	..()
	var/mob/living/carbon/human/H = mymob

	var/mob/screenmob = viewer || H

	if(screenmob.hud_used)
		if(screenmob.hud_used.hud_shown)
			if(H.wear_ring)
				H.wear_ring.screen_loc = ui_id
				screenmob.client.screen += H.wear_ring
			if(H.belt)
				H.belt.screen_loc = ui_belt
				screenmob.client.screen += H.belt
		else
			if(H.wear_ring)
				screenmob.client.screen -= H.wear_ring
			if(H.belt)
				screenmob.client.screen -= H.belt

	if(hud_version != HUD_STYLE_NOHUD)
		for(var/obj/item/I in H.held_items)
			I.screen_loc = ui_hand_position(H.get_held_index_of_item(I))
			screenmob.client.screen += I
	else
		for(var/obj/item/I in H.held_items)
			I.screen_loc = null
			screenmob.client.screen -= I


/mob/living/carbon/human/verb/toggle_hotkey_verbs()
	set category = "OOC"
	set name = "Toggle hotkey buttons"
	set desc = ""
	set hidden = 1
	if(hud_used.hotkey_ui_hidden)
		client.screen += hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = FALSE
	else
		client.screen -= hud_used.hotkeybuttons
		hud_used.hotkey_ui_hidden = TRUE

/datum/hud/proc/set_advclass()
	var/atom/movable/screen/using

	using = new /atom/movable/screen/advsetup
	using.screen_loc = rogueui_advsetup
	using.hud = src
	static_inventory += using
