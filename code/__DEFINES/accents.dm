#define ACCENT_NONE "Без Акцента"
#define ACCENT_DEFAULT "Акцент Расы"
#define ACCENT_DWARF "Дворфийский"
#define ACCENT_DELF "Дроу"
#define ACCENT_ELF "Эльфийский"
#define ACCENT_TIEFLING "Тифлингский"
#define ACCENT_HORC "Полуорочий"
#define ACCENT_GRENZ "Гренцельхофтский"
#define ACCENT_ZYBANTINE "Зибантинский"
#define ACCENT_PIRATE "Пиратский"
#define ACCENT_MIDDLE_SPEAK "Средний Говор (Старый Полуорочий)"

GLOBAL_LIST_INIT(accent_list, list(
	ACCENT_NONE = list(),
	ACCENT_DEFAULT = list(),
	ACCENT_DWARF = strings("accents/dwarf_replacement.json", "dwarf"),
	ACCENT_DELF = strings("accents/french_replacement.json", "french"),
	ACCENT_ELF = strings("accents/russian_replacement.json", "russian"),
	ACCENT_TIEFLING = strings("accents/spanish_replacement.json", "spanish"),
	ACCENT_HORC = strings("accents/halforc_replacement.json", "halforc"),
	ACCENT_GRENZ = strings("accents/grenz_replacement.json", "grenz"),
	ACCENT_ZYBANTINE = strings("accents/zybantine_replacement.json", "arabic"),
	ACCENT_PIRATE = strings("accents/pirate_replacement.json", "pirate"),
	ACCENT_MIDDLE_SPEAK = strings("accents/middlespeak.json", "full"),
))
