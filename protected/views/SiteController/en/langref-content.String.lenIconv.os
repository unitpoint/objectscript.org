return {
	ret = "number",
	retDesc = <<<END'
Количество символов.
END,	
	desc = <<<END"
<p>
Функция возвращает количество символов в строке.
<p>
Данная функция предназначена для работы с кодировкой, переданной в параметре <code>charset</code>.
END,
	extension = "iconv",
	params = {
		charset = {
			type = "string",
			def = "null",
			desc = <<<END'
Кодировка символов. Если не задано, то берется <a href="@url(globals.iconv.defaultCharset)">iconv.defaultCharset</a>.
END,
		},
	},
}