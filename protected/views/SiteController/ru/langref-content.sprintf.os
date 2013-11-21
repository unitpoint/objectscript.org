return {
	// name = 'sprintf',
	ret = 'string',
	rest = true,
	desc = <<<END'
Функция преобразует параметры по формату, переданному в первом параметре. 
Идентична <a href="@url(globals.printf)">printf</a> за исключением того, что возвращает результат,
а не выводит его в стандартный канал вывода.
END,
	retDesc = <<<END'
Возвращает результат преобразования параметров.
END,
	params = {
		format = {
			type = "string",
			desc = <<<END'
Строка преобразования. См. <a href="@url(globals.printf)">printf</a>
END,
		},
	},
}