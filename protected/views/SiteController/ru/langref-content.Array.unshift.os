return {
	ret = "mixed",
	retDesc = <<<END'
Добавленное значение.
END,
	desc = <<<END"
Добавляет значение в начало массива сдвигая все элементы.
END,
	params = {
		value = {
			type = "mixed",
			desc = "Значения для добавления.",
		},
	},
}