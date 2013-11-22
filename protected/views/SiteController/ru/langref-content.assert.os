return {
	ret = "mixed",
	retDesc = "Возвращает параметр <code>value</code>",
	desc = "Проверяет первый параметр на булево значение. Если первый параметр - <code>false</code>, то вызывает исключение с сообщением из второго параметра.",
	params = {
		value = {
			type = "mixed",
			desc = "Проверяемое значение.",
		},
		message = {
			type = "string",
			desc = "Сообщение об ошибке.",
		},
	},
}