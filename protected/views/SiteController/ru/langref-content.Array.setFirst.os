return {
	ret = "void",
	desc = <<<END"
Устанавливает значение первого элемента массива 
(аналог <code>arr.first = value</code>).
END,
	params = {
		value = {
			type = "mixed",
			desc = "Новое значение элемента.",
		},
	},
}