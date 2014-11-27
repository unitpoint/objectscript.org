return {
	ret = "string",
	retDesc = <<<END'
Декодированная строка.
END,
	desc = <<<END"
Декодирует строку <code>data</code>, закодированную при помощи <code>base64.encode</code>.
END,
	params = {
		data = {
			type = "string",
			desc = "Закодированные данные.",
		},
	},
}