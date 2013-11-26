return {
	ret = "void",
	desc = <<<END"
Устанавливает значение последнего элемента массива 
(аналог <code>arr.last = value</code>).
END,
	params = {
		value = {
			type = "mixed",
			desc = "Новое значение свойства.",
		},
	},
}