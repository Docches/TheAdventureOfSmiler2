extends Node

func set_language(locale: String):
	if locale in GlobalVar.supported_languages:
		GlobalVar.current_language = locale
		TranslationServer.set_locale(locale)
	else:
		TranslationServer.set_locale("en")

func get_language() -> String:
	return GlobalVar.current_language
