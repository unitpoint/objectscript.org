return {
	ret = "void",
	desc = <<<END"
Устанавливает значение первого добавленого свойства в объекте 
(аналог <code>obj.first = value</code>).
END,
	params = {
		value = {
			type = "mixed",
			desc = "Новое значение свойства.",
		},
	},
}