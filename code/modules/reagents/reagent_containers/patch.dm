/obj/item/weapon/reagent_containers/pill/patch
	name = "chemical patch"
	desc = "A chemical patch for touch based applications."
	icon = 'icons/obj/chemical.dmi'
	icon_state = "bandaid"
	item_state = "bandaid"
	possible_transfer_amounts = list()
	volume = 50
	apply_type = PATCH
	apply_method = "apply"

/obj/item/weapon/reagent_containers/pill/patch/New()
	..()
	icon_state = "bandaid" // thanks inheritance

/obj/item/weapon/reagent_containers/pill/patch/afterattack(obj/target, mob/user , proximity)
	return // thanks inheritance again

/obj/item/weapon/reagent_containers/pill/patch/canconsume(mob/eater, mob/user)
	if(!iscarbon(eater))
		return 0
	return 1 // Masks were stopping people from "eating" patches. Thanks, inheritance.

/obj/item/weapon/reagent_containers/pill/patch/styptic
	name = "brute patch"
	desc = "Helps with brute injuries."
	list_reagents = list("styptic_powder" = 30)

/obj/item/weapon/reagent_containers/pill/patch/silver_sulf
	name = "burn patch"
	desc = "Helps with burn injuries."
	list_reagents = list("silver_sulfadiazine" = 30)

/obj/item/weapon/reagent_containers/pill/patch/bandaid
	name = "Band-Aid� brand band-aid"
	desc = "Good for all manner of boo-boos, owwies, and cranial fractures."
	list_reagents = list("tricordrazine" = 5)

/obj/item/weapon/reagent_containers/pill/patch/bandageP
	name = "bandage"
	desc = "A beefed up baind-aid."
	list_reagents = list("tricordrazine" = 10)

/obj/item/weapon/reagent_containers/pill/patch/bandageM
	name = "tactical band-aid"
	desc = "An M3 combat dressing, meant for minor to moderate injuries. Apply only one."
	list_reagents = list("tricordrazine" = 20)
