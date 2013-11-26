return {
	ret = "mixed",
	retDesc = <<<END'
Добавленное значение.
END,
	desc = <<<END"
Добавляет значение в массив с конца (аналог метода <a href="@url(globals.Array.push)">push</a>). 
Вызывается в конструкции вида <code>arr[] = value</code>.
END,
	params = {
		value = {
			type = "mixed",
			desc = "Значения для добавления.",
		},
	},
}