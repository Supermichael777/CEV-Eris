/obj/item/weapon/implant/carrion_spider/breeding
	name = "breeding spider"
	icon_state = "spiderling_breeding"
	spider_price = 30
	var/number_of_spiders
	var/active = FALSE

/obj/item/weapon/implant/carrion_spider/breeding/Initialize()
	..()
	number_of_spiders = rand(10, 15)

/obj/item/weapon/implant/carrion_spider/breeding/activate()
	..()
	if(!wearer)
		to_chat(owner_mob, SPAN_WARNING("[src] doesn't have a host"))
		return
	if(!istype(wearer.species, /datum/species/human))
		to_chat(owner_mob, SPAN_WARNING("[src] only works on humans"))
		return	

	if(!(wearer.stat == DEAD))
		to_chat(owner_mob, SPAN_WARNING("The host must be dead!"))
		return
	
	if(active)
		to_chat(owner_mob, SPAN_WARNING("[src] is already active!"))
		return
	
	active = TRUE
	spawn(1 MINUTES)
		active = FALSE
		if(wearer?.stat == DEAD)
			while(number_of_spiders)
				new /obj/random/mob/spiders(wearer.loc)
				number_of_spiders--
			wearer.gib()
			die()
