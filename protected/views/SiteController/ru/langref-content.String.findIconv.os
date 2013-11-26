return {
	ret = "number",
	retDesc = <<<END'
Индекс символа первого вхождения <code>searchStr</code> в строке или <code>null</code>, если строка <code>searchStr</code> не найдена. 
END,	
	desc = <<<END"
<p>
Возвращает индекс первого вхождения строки. Индекс начинается с <code>0</code>. 
<p>
Данная функция предназначена для работы с кодировкой, переданной в параметре <code>charset</code>.
END,
	extension = "iconv",
	params = {
		searchStr = {
			type = "string",
			desc = "Строка, которую требуется найти.",
		},
		fromIndex = {
			type = "number",
			def = "null",
			desc = "Индекс символа, с которого начинается поиск. Если параметр не задан, то поиск начинается с индекса 0.",
		},
		charset = {
			type = "string",
			def = "null",
			desc = <<<END'
Кодировка символов. Если не задано, то берется <a href="@url(globals.iconv.defaultCharset)">iconv.defaultCharset</a>.
END,
		},
	},
}