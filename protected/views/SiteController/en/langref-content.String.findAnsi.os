return {
	ret = "number",
	retDesc = <<<END'
Индекс символа первого вхождения <code>searchStr</code> в строке или <code>null</code>, если строка <code>searchStr</code> не найдена. 
END,	
	desc = <<<END"
<p>
Возвращает индекс первого вхождения строки. Индекс начинается с <code>0</code>. 
<p>
Данная функция работает с однобайтовыми символами.
END,
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
	},
}