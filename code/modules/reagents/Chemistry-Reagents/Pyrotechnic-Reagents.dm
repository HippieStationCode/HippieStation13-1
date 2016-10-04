
/datum/reagent/thermite
	name = "Thermite"
	id = "thermite"
	description = "Thermite produces an aluminothermic reaction known as a thermite reaction. Can be used to melt walls."
	reagent_state = SOLID
	color = "#673910" // rgb: 103, 57, 16

/datum/reagent/thermite/reaction_turf(turf/T, reac_volume)
	if(reac_volume >= 1 && istype(T, /turf/simulated/wall))
		var/turf/simulated/wall/Wall = T
		if(istype(Wall, /turf/simulated/wall/r_wall))
			Wall.thermite = Wall.thermite+(reac_volume*2.5)
		else
			Wall.thermite = Wall.thermite+(reac_volume*10)
		Wall.overlays = list()
		Wall.overlays += image('icons/effects/effects.dmi',"thermite")

/datum/reagent/thermite/on_mob_life(mob/living/M)
	M.adjustFireLoss(1)
	..()

/datum/reagent/nitroglycerin
	name = "Nitroglycerin"
	id = "nitroglycerin"
	description = "Nitroglycerin is a heavy, colorless, oily, explosive liquid obtained by nitrating glycerol."
	color = "#808080" // rgb: 128, 128, 128

/datum/reagent/stabilizing_agent
	name = "Stabilizing Agent"
	id = "stabilizing_agent"
	description = "Keeps unstable chemicals stable. This does not work on everything."
	reagent_state = LIQUID
	color = "#FFFFFF"

/datum/reagent/clf3
	name = "Chlorine Trifluoride"
	id = "clf3"
	description = "Makes a temporary 3x3 fireball when it comes into existence, so be careful when mixing. ClF3 applied to a surface burns things that wouldn't otherwise burn, sometimes through the very floors of the station and exposing it to the vacuum of space."
	reagent_state = LIQUID
	color = "#FF0000"
	metabolization_rate = 4

/datum/reagent/clf3/on_mob_life(mob/living/M)
	M.adjust_fire_stacks(2)
	var/burndmg = max(0.3*M.fire_stacks, 0.3)
	M.adjustFireLoss(burndmg)
	..()

/datum/reagent/clf3/reaction_turf(turf/simulated/T, reac_volume)
	if(istype(T, /turf/simulated/floor/plating))
		var/turf/simulated/floor/plating/F = T
		if(prob(1 + F.burnt + 5*F.broken)) //broken or burnt plating is more susceptible to being destroyed
			F.ChangeTurf(F.baseturf)
	if(istype(T, /turf/simulated/floor/))
		var/turf/simulated/floor/F = T
		if(prob(reac_volume/10))
			F.make_plating()
		else if(prob(reac_volume))
			F.burn_tile()
		if(istype(F, /turf/simulated/floor/))
			PoolOrNew(/obj/effect/hotspot, F)
	if(istype(T, /turf/simulated/wall/))
		var/turf/simulated/wall/W = T
		if(prob(reac_volume/10))
			W.ChangeTurf(/turf/simulated/floor/plating)

/datum/reagent/clf3/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	if(istype(M))
		if(method != INGEST && method != INJECT)
			M.adjust_fire_stacks(min(reac_volume/5, 10))
			M.IgniteMob()
			PoolOrNew(/obj/effect/hotspot, M.loc)

/datum/reagent/sorium
	name = "Sorium"
	id = "sorium"
	description = "Sends everything flying from the detonation point."
	reagent_state = LIQUID
	color = "#FFA500"

/datum/reagent/liquid_dark_matter
	name = "Liquid Dark Matter"
	id = "liquid_dark_matter"
	description = "Sucks everything into the detonation point."
	reagent_state = LIQUID
	color = "#800080"

/datum/reagent/blackpowder
	name = "Black Powder"
	id = "blackpowder"
	description = "Explodes. Violently."
	reagent_state = LIQUID
	color = "#000000"
	metabolization_rate = 0.05

/datum/reagent/blackpowder/on_ex_act()
	var/location = get_turf(holder.my_atom)
	var/datum/effect_system/reagents_explosion/e = new()
	e.set_up(1 + round(volume/6, 1), location, 0, 0, message = 0)
	e.start()
	holder.clear_reagents()

/datum/reagent/flash_powder
	name = "Flash Powder"
	id = "flash_powder"
	description = "Makes a very bright flash."
	reagent_state = LIQUID
	color = "#FFFF00"

/datum/reagent/smoke_powder
	name = "Smoke Powder"
	id = "smoke_powder"
	description = "Makes a large cloud of smoke that can carry reagents."
	reagent_state = LIQUID
	color = "#808080"

/datum/reagent/sonic_powder
	name = "Sonic Powder"
	id = "sonic_powder"
	description = "Makes a deafening noise."
	reagent_state = LIQUID
	color = "#0000FF"

/datum/reagent/phlogiston
	name = "Phlogiston"
	id = "phlogiston"
	description = "Catches you on fire and makes you ignite."
	reagent_state = LIQUID
	color = "#FF9999"

/datum/reagent/phlogiston/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	M.IgniteMob()
	..()

/datum/reagent/phlogiston/on_mob_life(mob/living/M)
	M.adjust_fire_stacks(1)
	var/burndmg = max(0.3*M.fire_stacks, 0.3)
	M.adjustFireLoss(burndmg)
	..()

/datum/reagent/napalm
	name = "Napalm"
	id = "napalm"
	description = "Very flammable."
	reagent_state = LIQUID
	color = "#FF9999"

/datum/reagent/napalm/on_mob_life(mob/living/M)
	M.adjust_fire_stacks(1)
	..()

/datum/reagent/napalm/reaction_mob(mob/living/M, method=TOUCH, reac_volume)
	if(istype(M))
		if(method != INGEST && method != INJECT)
			M.adjust_fire_stacks(min(reac_volume/4, 20))

/datum/reagent/cryostylane
	name = "Cryostylane"
	id = "cryostylane"
	description = "Comes into existence at 20K. As long as there is sufficient oxygen for it to react with, Cryostylane slowly cools all other reagents in the mob down to 0K."
	color = "#B2B2FF" // rgb: 139, 166, 233
	metabolization_rate = 0.5 * REAGENTS_METABOLISM


/datum/reagent/cryostylane/on_mob_life(mob/living/M) //TODO: code freezing into an ice cube
	if(M.reagents.has_reagent("oxygen"))
		M.reagents.remove_reagent("oxygen", 0.5)
		M.bodytemperature -= 15
	..()

/datum/reagent/cryostylane/on_tick()
	if(holder.has_reagent("oxygen"))
		holder.remove_reagent("oxygen", 1)
		holder.chem_temp -= 10
		holder.handle_reactions()
	..()

/datum/reagent/cryostylane/reaction_turf(turf/simulated/T, reac_volume)
	if(reac_volume >= 5)
		for(var/mob/living/simple_animal/slime/M in T)
			M.adjustToxLoss(rand(15,30))

/datum/reagent/pyrosium
	name = "Pyrosium"
	id = "pyrosium"
	description = "Comes into existence at 500K. As long as there is sufficient oxygen for it to react with, Pyrosium slowly heats all other reagents in the container up. Useful for delayed reactions."
	color = "#B20000" // rgb: 139, 166, 233
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/pyrosium/on_mob_life(mob/living/M)
	if(M.reagents.has_reagent("oxygen"))
		M.reagents.remove_reagent("oxygen", 0.5)
		M.bodytemperature += 15
	..()

/datum/reagent/pyrosium/on_tick()
	if(holder.has_reagent("oxygen"))
		holder.remove_reagent("oxygen", 1)
		holder.chem_temp += 10
		holder.handle_reactions()
	..()


/datum/reagent/cryogenic_fluid
	name = "Cryogenic Fluid"
	id = "cryogenic_fluid"
	description = "Extremely cold superfluid used to put out fires that will viciously freeze people on contact causing severe pain and burn damage, weak if ingested."
	color = "#b3ffff" // rgb: 0, 255, 255
	metabolization_rate = 2

/datum/reagent/cryogenic_fluid/on_tick()
	holder.chem_temp -= 5
	..()
/datum/reagent/cryogenic_fluid/reaction_mob(mob/living/M, method=TOUCH, reac_volume, show_message = 1)
	if(iscarbon(M) && M.stat != DEAD)
		if(method in list(INGEST,INJECT))
			M.adjust_fire_stacks(-(reac_volume))
			M.adjustStaminaLoss(reac_volume)
			M.adjustFireLoss(reac_volume)
			M.bodytemperature = max(M.bodytemperature - 50, TCMB)
			if(show_message)
				M << "<span class='warning'>You feel like you are freezing from the inside!</span>"
		else
			if (reac_volume >= 5)
				if(show_message)
					M << "<span class='danger'>You can feel your body freezing up and your metabolism slow DEAR GOD THE PAIN!!</span>"
				M.bodytemperature = max(M.bodytemperature - 10*reac_volume, TCMB)
				M.adjust_fire_stacks(-(3*reac_volume))
				M.adjustFireLoss(0.125*reac_volume) //Sorry for snowflakey numbers~
				M.adjustOxyLoss(0.375*reac_volume)
				M.drowsyness +=3
				M.confused +=12

			else
			 M.bodytemperature = max(M.bodytemperature - 5, TCMB)
			 M.adjust_fire_stacks(-(2*reac_volume))
	 ..()

/datum/reagent/cryogenic_fluid/reaction_turf(turf/simulated/T)
	if (!istype(T)) return
	var/obj/effect/hotspot/hotspot = (locate(/obj/effect/hotspot) in T)
	if(hotspot && !istype(T, /turf/space))
		if(T.air)
			var/datum/gas_mixture/G = T.air
			G.temperature = 0
			G.react()
			hotspot.Kill()
	return



/datum/reagent/foof
	name = "Dioxygen Difluoride"
	id = "foof"
	description = "Absurdly dangerous fluorine compound which reacts violently with everything it touches: toxic and highly reactive this will burn you outside in and inside out. Will decay unless stabilised with cryogenic fluid which it slowly consumes"
	reagent_state = LIQUID
	color = "#FF9933"
	metabolization_rate = 0.5

/datum/reagent/foof/on_mob_life(mob/living/M)
	M.adjust_fire_stacks(2) //very effective fuel chem when ingested
	M.adjustFireLoss(4)
	M.adjustToxLoss(1)
	M.bodytemperature += 30
	..()

/datum/reagent/foof/reaction_turf(turf/simulated/T, reac_volume)
	if(istype(T, /turf/simulated/floor/plating))
		var/turf/simulated/floor/plating/F = T
		if(prob(reac_volume + F.burnt*15 + F.broken*25)) //broken or burnt plating is much more susceptible to being destroyed
			F.ChangeTurf(F.baseturf)
	if(istype(T, /turf/simulated/floor/))
		var/turf/simulated/floor/F = T
		if(prob(reac_volume*10))
			F.make_plating()
		else if(prob(reac_volume*5))
			F.burn_tile()
		if(istype(F, /turf/simulated/floor/))
			PoolOrNew(/obj/effect/hotspot, F) //ignites surfaces
	if(istype(T, /turf/simulated/wall/))
		var/turf/simulated/wall/W = T
		if(prob(reac_volume*10))
			W.ChangeTurf(/turf/simulated/floor/plating)
	if(istype(T))
		T.atmos_spawn_air(SPAWN_HEAT | SPAWN_TOXINS, (reac_volume*0.5)) //spawns heat and plasma on contact with surfaces

/datum/reagent/foof/reaction_mob(mob/living/M, method=TOUCH,reac_volume)//less lethal on touch but still nasty
	if(istype(M))
		if(method != INGEST && method != INJECT)
			M.adjust_fire_stacks(reac_volume)
			M.IgniteMob()
			M.bodytemperature += 600
			var/turf/T = get_turf(holder.my_atom) //spawns small fireball around victim
			for(var/turf/turf in range(1,T))
				PoolOrNew(/obj/effect/hotspot, turf)


/datum/chemical_reaction/foof/on_reaction(datum/reagents/holder, created_volume)//makes a giant fireball on creation, currently unused as there is no recipe
	var/turf/T = get_turf(holder.my_atom)
	for(var/turf/turf in range(3,T))
		PoolOrNew(/obj/effect/hotspot, turf)

/datum/reagent/foof/on_tick() //decay code
	holder.chem_temp = 10

	if(holder.has_reagent("cryogenic_fluid"))
		holder.remove_reagent("cryogenic_fluid" , 0.05)

	if(!holder.has_reagent("cryogenic_fluid"))
		holder.remove_reagent("foof", 1)
		holder.add_reagent("fluorine", 0.5)
		holder.add_reagent("oxygen", 0.5)

