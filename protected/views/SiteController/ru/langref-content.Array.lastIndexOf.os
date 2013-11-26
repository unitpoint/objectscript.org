return {
	ret = "number",
	retDesc = <<<END'
Индекс последнего вхождения <code>searchElement</code> в массиве или <code>null</code>, если <code>searchElement</code> не найден.
END,
	desc = <<<END"
Возвращает индекс последнего вхождения указанного значения в массиве.
END,
	params = {
		searchElement = {
			type = "mixed",
			desc = "Значение, которое требуется найти.",
		},
		fromIndex = {
			type = "number",
			def = "null",
			desc = "Индекс массива, с которого начинается поиск. Если параметр fromIndex не задан, то поиск начинается с последнего индекса в массиве.",
		},
	},
}