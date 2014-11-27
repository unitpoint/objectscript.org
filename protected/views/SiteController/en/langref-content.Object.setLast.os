return {
	ret = "void",
	desc = <<<END"
Устанавливает значение последнего добавленого свойства в объекте 
(аналог <code>obj.last = value</code>).
END,
	params = {
		value = {
			type = "mixed",
			desc = "Новое значение свойства.",
		},
	},
}