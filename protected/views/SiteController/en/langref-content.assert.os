return {
	ret = "mixed",
	retDesc = "Возвращает параметр <code>value</code>",
	desc = "Проверяет первый параметр на булево значение. Если первый параметр - <code>false</code>, то вызывает исключение с сообщением из второго параметра.",
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L13",
	params = {
		value = {
			type = "mixed",
			desc = "Проверяемое значение.",
		},
		message = {
			type = "string",
			def = '"assert failed"',
			desc = "Сообщение об ошибке.",
		},
	},
}