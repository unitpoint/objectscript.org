return {
	ret = "mixed",
	retDesc = "Результат выполнения скрипта.",
	rest = true,
	desc = <<<END'
Функция компилирует и исполняет скрипт в заданном  <a href="@url(manual/langref.functions.env)">окружении функции</a>.
Скрипт запускается с параметрами, переданными начиная с третьего.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L21",
	params = {
		str = {
			type = "string",
			desc = "Текст скрипта.",
		},
		env = {
			type = "object",
			desc = "Окружение функции.",
		},
	},
}