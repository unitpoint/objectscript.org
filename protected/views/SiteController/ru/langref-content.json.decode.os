return {
	ret = "mixed",
	retDesc = <<<END'
Декодированная строка.
END,
	desc = <<<END"
Принимает закодированную в <b>JSON</b> строку и преобразует ее в переменную ObjectScript.
END,
	params = {
		data = {
			type = "string",
			desc = "Данные в формате <b>JSON</b>.",
		},
	},
}