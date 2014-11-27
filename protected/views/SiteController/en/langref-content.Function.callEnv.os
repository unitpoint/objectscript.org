return {
	ret = "mixed",
	retDesc = <<<END'
Результат выполнения функции.
END,
	rest = true,
	desc = <<<END"
Вызывает функцию в заданном  <a href="@url(manual/langref.functions.env)">окружении функции</a>, 
подставляя указанный объект вместо значения this функции, а остальные параметры вместо аргументов функции.
END,
	params = {
		self = {
			type = "mixed",
			def = "null",
			desc = "Объект для использования в качестве объекта this.",
		},
		env = {
			type = "object",
			def = "_G",
			desc = "Окружение функции.",
		},
	},
}