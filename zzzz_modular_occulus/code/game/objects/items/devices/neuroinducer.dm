//Halcyonic NeuroInducer
// Designed to interrupt sanity break downs, fix max sanity, and restore sanity to 25.

/obj/item/device/neuroinducer
	name = "halcyonic neuroinducer"
	desc = "A device that fixes sanity."
	icon = 'zzzz_modular_occulus/icons/obj/device.dmi'
	icon_state = "neuroinducer"
	suitable_cell = /obj/item/weapon/cell/medium
	slot_flags = SLOT_BELT
	w_class = ITEM_SIZE_SMALL
	origin_tech = list(TECH_BIO = 5, TECH_COVERT = 2)
	matter = list(MATERIAL_STEEL = 4, MATERIAL_GLASS = 2)
	matter_reagents = list("uncap nanites" = 10)
	spawn_blacklisted = TRUE
	var/apply_sanity_damage = 30
	var/charge_per_use = 600

/obj/item/device/neuroinducer/proc/halcyon(mob/living/carbon/human/M, mob/user)
	if(user.incapacitated() || user.get_active_hand() != src)
		to_world("user is incapacitated")
		return
	to_chat(user, SPAN_DANGER("[user] begins to run the [src] over [M]'s Limbic cortex!"))
	if (do_mob(user, M, 20))
		to_world("Target zone not head")
		var/mob/living/carbon/human/affected = M
		for(var/datum/breakdown/B in affected.sanity.breakdowns)
			B.finished = TRUE
		if(M.sanity.max_level < 100)
			M.sanity.max_level = 100
			to_world("Max sanity now 100")
		if(M.sanity.level < 25)
			M.sanity.level = 25
			to_world("sanity level now 25")



/obj/item/device/neuroinducer/attack(mob/M, mob/living/carbon/human/user, target_zone)
	if(M == user)
		to_chat(user, SPAN_DANGER("You are unable to effectively use the Neuroinducer on yourself! Perhaps you should get some help?"))
		return ..()
	if(target_zone != BP_HEAD)
		to_world("Target zone not head")
		return ..()
	if(length(user.get_covering_equipped_items(HEAD)))
		to_chat(user, SPAN_WARNING("You need to remove the head covering first."))
		return ..()
	if(!cell_use_check(charge_per_use, user))
		return
	halcyon(M, user)
	to_world("afterhalcyonproc")


/obj/item/device/neuroinducer/traitor
	name = "halcyonic neuroinducer"
	desc = "A device that fixes sanity."
	icon = 'zzzz_modular_occulus/icons/obj/device.dmi'
	icon_state = "evilneuroinducer"
	suitable_cell = /obj/item/weapon/cell/medium
	slot_flags = SLOT_BELT
	w_class = ITEM_SIZE_SMALL
	origin_tech = list(TECH_BIO = 5, TECH_COVERT = 2)
	matter = list(MATERIAL_STEEL = 4, MATERIAL_GLASS = 2)
	matter_reagents = list("uncap nanites" = 10)
	spawn_blacklisted = TRUE
	var/stat_increase = 5
	var/apply_sanity_damage = 30
	var/spent = FALSE
	var/charge_per_use = 600

/obj/item/device/neuroinducer/traitor/proc/turmoil(mob/living/carbon/human/M, mob/user)
	if(user.incapacitated() || user.get_active_hand() != src)
		to_world("user is incapacitated")
		return
	to_chat(user, SPAN_DANGER("[user] begins to run the [src] over [M]'s Limbic cortex!"))
	if (do_mob(user, M, 20))
		to_world("Target zone not head")
		var/mob/living/carbon/human/affected = M
		for(var/datum/breakdown/B in affected.sanity.breakdowns)
			B.finished = TRUE
		if(M.sanity.max_level >= 50)
			M.sanity.max_level = 50
			to_world("Max sanity now 100")
		if(M.sanity.level >= 0)	//if sanity is
			M.sanity.level = -1	//causes a breakdown!
			to_world("sanity level now 25")



/obj/item/device/neuroinducer/traitor/attack(mob/M, mob/living/carbon/human/user, target_zone)
	if(M == user)
		to_chat(user, SPAN_DANGER("You are unable to effectively use the Neuroinducer on yourself! Perhaps you should get some help?"))
		return ..()
	if(target_zone != BP_HEAD)
		to_world("Target zone not head")
		return ..()
	if(length(user.get_covering_equipped_items(HEAD)))
		to_chat(user, SPAN_WARNING("You need to remove the head covering first."))
		return ..()
	if(!cell_use_check(charge_per_use, user))
		return
	turmoil(M, user)
	to_world("afterhalcyonproc")

