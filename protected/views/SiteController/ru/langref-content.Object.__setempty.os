return {
	ret = "mixed",
	retDesc = <<<END'
Добавленное значение.
END,
	desc = <<<END"
Добавляет значение в объект с конца. В качестве ключа используется автоинкрементный индекс
(аналог метода <a href="@url(globals.Object.push)">push</a>). 
Вызывается в конструкции вида <code>obj[] = value</code>.
END,
	params = {
		value = {
			type = "mixed",
			desc = "Значения для добавления.",
		},
	},
}