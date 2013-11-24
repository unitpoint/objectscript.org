return {
	ret = "string",
	retDesc = <<<END'
Декодированная строка.
END,
	desc = <<<END"
Возвращает строку, содержащую <b>JSON</b>-представление <code>value</code>.
END,
	params = {
		value = {
			type = "mixed",
			desc = "Значение, которое будет закодировано.",
		},
	},
}