return {
	ret = "mixed",
	retDesc = "Результат выполнения скрипта.",
	rest = true,
	desc = <<<END'
Функция компилирует и исполняет скрипт.
Скрипт запускается с параметрами, переданными начиная с третьего.
END.
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L17",
	params = {
		str = {
			type = "string",
			desc = "Текст скрипта.",
		},
	},
}