﻿return {
	ret = "string",
	retDesc = <<<END'
Соединенные значения свойств объект.
END,
	desc = <<<END"
Объединяет значения всех свойств объекта, вставляя между ними заданную строку-разделитель.
END,
	params = {
		separator = {
			type = "string",
			def = '""',
			desc = "Разделитель",
		},
	},
}