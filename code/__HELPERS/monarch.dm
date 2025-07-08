/proc/get_monarch()
	var/mob/living/carbon/human/monarch = SSticker.rulermob
	return monarch

/proc/coronate(mob/living/carbon/human/coronated)
	var/datum/job/lord_job = SSjob.GetJobType(/datum/job/lord)
	var/mob/living/carbon/human/old_monarch = SSticker.rulermob

	//Remove spells old monarch
	lord_job?.remove_spells(old_monarch)

	//Add new monarch
	coronated.mind.set_assigned_role(/datum/job/lord)
	coronated.job = "Monarch"
	lord_job?.add_spells(coronated)
	SSticker.rulermob = coronated
	GLOB.badomens -= OMEN_NOLORD
