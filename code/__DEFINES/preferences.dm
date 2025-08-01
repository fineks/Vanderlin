
//Preference toggles
#define SOUND_ADMINHELP			(1<<0)
#define SOUND_MIDI				(1<<1)
#define SOUND_AMBIENCE			(1<<2)
#define SOUND_LOBBY				(1<<3)
#define MEMBER_PUBLIC			(1<<4)
#define INTENT_STYLE			(1<<5)
#define MIDROUND_ANTAG			(1<<6)
#define SOUND_INSTRUMENTS		(1<<7)
#define SOUND_SHIP_AMBIENCE		(1<<8)
#define SOUND_PRAYERS			(1<<9)
#define ANNOUNCE_LOGIN			(1<<10)
#define SOUND_ANNOUNCEMENTS		(1<<11)
#define DISABLE_DEATHRATTLE		(1<<12)
#define DISABLE_ARRIVALRATTLE	(1<<13)
#define COMBOHUD_LIGHTING		(1<<14)

#define DEADMIN_ALWAYS			(1<<15)
#define DEADMIN_ANTAGONIST		(1<<16)
#define DEADMIN_POSITION_HEAD	(1<<17)
#define DEADMIN_POSITION_SECURITY	(1<<18)
#define DEADMIN_POSITION_SILICON	(1<<19)

#define TOGGLE_FULLSCREEN		(1<<20)
#define SCHIZO_VOICE			(1<<21)

#define TOGGLES_DEFAULT (SOUND_ADMINHELP|SOUND_MIDI|SOUND_AMBIENCE|SOUND_LOBBY|MEMBER_PUBLIC|INTENT_STYLE|MIDROUND_ANTAG|SOUND_INSTRUMENTS|SOUND_SHIP_AMBIENCE|SOUND_PRAYERS|SOUND_ANNOUNCEMENTS|TOGGLE_FULLSCREEN)

//Chat toggles
#define CHAT_OOC			(1<<0)
#define CHAT_DEAD			(1<<1)
#define CHAT_GHOSTEARS		(1<<2)
#define CHAT_GHOSTSIGHT		(1<<3)
#define CHAT_PRAYER			(1<<4)
#define CHAT_RADIO			(1<<5)
#define CHAT_PULLR			(1<<6)
#define CHAT_GHOSTWHISPER	(1<<7)
#define CHAT_GHOSTPDA		(1<<8)
#define CHAT_GHOSTRADIO 	(1<<9)
#define CHAT_BANKCARD  (1<<10)

#define TOGGLES_DEFAULT_CHAT (CHAT_OOC|CHAT_PRAYER|CHAT_RADIO|CHAT_PULLR|CHAT_GHOSTPDA|CHAT_BANKCARD)

#define PARALLAX_INSANE -1 //for show offs
#define PARALLAX_HIGH    0 //default.
#define PARALLAX_MED     1
#define PARALLAX_LOW     2
#define PARALLAX_DISABLE 3 //this option must be the highest number

#define PARALLAX_DELAY_DEFAULT world.tick_lag
#define PARALLAX_DELAY_MED     1
#define PARALLAX_DELAY_LOW     2

// Playtime tracking system, see jobs_exp.dm
#define EXP_TYPE_LIVING			"Living"
#define EXP_TYPE_GHOST			"Ghost"
#define EXP_TYPE_ADMIN			"Admin"

#define EXP_TYPE_ANTAG			"Antag"

#define EXP_TYPE_TOWNER			"Towner"
#define EXP_TYPE_NOBLE			"Noble"
#define EXP_TYPE_ADVENTURER		"Adventurer"
#define EXP_TYPE_CHURCH			"Church"
#define EXP_TYPE_GUARDS			"Guards"

//Flags in the players table in the db
#define DB_FLAG_EXEMPT 1

//Job preferences levels
#define JP_LOW 1
#define JP_MEDIUM 2
#define JP_HIGH 3

//randomised elements
#define RANDOM_NAME "random_name"
#define RANDOM_NAME_ANTAG "random_name_antag"
#define RANDOM_BODY "random_body"
#define RANDOM_BODY_ANTAG "random_body_antag"
#define RANDOM_SPECIES "random_species"
#define RANDOM_GENDER "random_gender"
#define RANDOM_GENDER_ANTAG "random_gender_antag"
#define RANDOM_AGE "random_age"
#define RANDOM_AGE_ANTAG "random_age_antag"
#define RANDOM_UNDERWEAR "random_underwear"
#define RANDOM_UNDERWEAR_COLOR "random_underwear_color"
#define RANDOM_UNDERSHIRT "random_undershirt"
#define RANDOM_SKIN_TONE "random_skin_tone"
#define RANDOM_EYE_COLOR "random_eye_color"

// randomise_appearance_prefs() and randomize_human_appearance() proc flags
#define RANDOMIZE_GENDER (1<<0)
#define RANDOMIZE_SPECIES (1<<1)
#define RANDOMIZE_NAME (1<<2)
#define RANDOMIZE_AGE (1<<3)
#define RANDOMIZE_UNDERWEAR (1<<4)
#define RANDOMIZE_HAIRSTYLE (1<<5)
#define RANDOMIZE_FACIAL_HAIRSTYLE (1<<6)
#define RANDOMIZE_HAIR_COLOR (1<<7)
#define RANDOMIZE_FACIAL_HAIR_COLOR (1<<8)
#define RANDOMIZE_SKIN_TONE (1<<9)
#define RANDOMIZE_EYE_COLOR (1<<10)
#define RANDOMIZE_FEATURES (1<<11)

#define RANDOMIZE_HAIR_FEATURES (RANDOMIZE_HAIRSTYLE | RANDOMIZE_FACIAL_HAIRSTYLE)
#define RANDOMIZE_HAIR_COLORS (RANDOMIZE_HAIR_COLOR | RANDOMIZE_HAIR_COLORS)
#define RANDOMIZE_HAIR_ALL (RANDOMIZE_HAIR_FEATURES | RANDOMIZE_HAIR_COLORS)

//Age ranges
#define AGE_CHILD			"Молодняк"
#define AGE_ADULT			"Взрослый"
#define AGE_MIDDLEAGED		"Средних Лет"
#define AGE_OLD				"Престарелый"
#define AGE_IMMORTAL		"Бессмертный"

#define NORMAL_AGES_LIST			list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
#define NORMAL_AGES_LIST_CHILD		list(AGE_CHILD, AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD)
#define ALL_AGES_LIST				list(AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)
#define ALL_AGES_LIST_CHILD			list(AGE_CHILD, AGE_ADULT, AGE_MIDDLEAGED, AGE_OLD, AGE_IMMORTAL)

//alignment
#define ALIGNMENT_LG		"Lawful Good"
#define ALIGNMENT_NG		"Neutral Good"
#define ALIGNMENT_CG		"Chaotic Good"
#define ALIGNMENT_LN		"Lawful Neutral"
#define ALIGNMENT_TN		"True Neutral"
#define ALIGNMENT_CN		"Chaotic Neutral"
#define ALIGNMENT_LE		"Lawful Evil"
#define ALIGNMENT_NE		"Neutral Evil"
#define ALIGNMENT_CE		"Chaotic Evil"

#define ALL_ALIGNMENTS_LIST list(ALIGNMENT_LG,\
							ALIGNMENT_NG,\
							ALIGNMENT_CG,\
							ALIGNMENT_LN,\
							ALIGNMENT_TN,\
							ALIGNMENT_CN,\
							ALIGNMENT_LE,\
							ALIGNMENT_NE,\
							ALIGNMENT_CE)

#define UI_PREFERENCE_LIGHT_MODE "light mode"
#define UI_PREFERENCE_DARK_MODE "dark mode"
