return {
	// name = "zlib",
	desc = "Этот модуль позволяет распаковывать и запаковывать данные.",
	
	funcs = {
	
		/* encode = {
			desc
		},
		decode = {}, */
		gzdeflate = {
			desc = "Данная функция сжимает строку, используя формат данных DEFLATE.",
			ret = "string",
			retDesc = "Сжатая строка или <code>null</code> в случае ошибки.",
			params = {
				data = {
					type = "string",
					desc = "Данные для сжатия.",
				},
				level = {
					type = "number",
					desc = <<<END'
Уровень сжатия. 0 - без сжатия, 9 - максимум. Если не указан, будет использоваться уровень сжатия 
по умолчанию библиотеки zlib.
END,
				},
			},
		},
		gzencode = {
			desc = "Возвращает сжатую версию входных данных data, аналогично выводу программы GZIP.",
			ret = "string",
			retDesc = "Сжатая строка или <code>null</code> в случае ошибки.",
			params = {
				data = {
					type = "string",
					desc = "Данные для сжатия.",
				},
				level = {
					type = "number",
					desc = <<<END'
Уровень сжатия. 0 - без сжатия, 9 - максимум. Если не указан, будет использоваться уровень сжатия 
по умолчанию библиотеки zlib.
END,
				},
			},
		},
		gzcompress = {
			desc = "Данная функция сжимает строку используя формат данных ZLIB.",
			ret = "string",
			retDesc = "Сжатая строка или <code>null</code> в случае ошибки.",
			params = {
				data = {
					type = "string",
					desc = "Данные для сжатия.",
				},
				level = {
					type = "number",
					desc = <<<END'
Уровень сжатия. 0 - без сжатия, 9 - максимум. Если не указан, будет использоваться уровень сжатия 
по умолчанию библиотеки zlib.
END,
				},
			},
		},
		gzinflate = {
			desc = "Данная функция распаковывает строку, используя метод DEFLATE.",
			ret = "string",
			retDesc = "Распакованные данные или <code>null</code> в случае ошибки.",
			params = {
				data = {
					type = "string",
					desc = "Данные для сжатия.",
				},
				length = {
					type = "number",
					desc = <<<END'
Максимальный размер данных для распаковки. Можно не указывать.
END,
				},
			},
		},
		gzdecode = {
			desc = "Данная функция распаковывает строку, используя метод GZIP.",
			ret = "string",
			retDesc = "Распакованные данные или <code>null</code> в случае ошибки.",
			params = {
				data = {
					type = "string",
					desc = "Данные для сжатия.",
				},
				length = {
					type = "number",
					desc = <<<END'
Максимальный размер данных для распаковки. Можно не указывать.
END,
				},
			},
		},
		gzuncompress = {
			desc = "Данная функция распаковывает строку, используя метод ZLIB.",
			ret = "string",
			retDesc = "Распакованные данные или <code>null</code> в случае ошибки.",
			params = {
				data = {
					type = "string",
					desc = "Данные для сжатия.",
				},
				length = {
					type = "number",
					desc = <<<END'
Максимальный размер данных для распаковки. Можно не указывать.
END,
				},
			},
		},		
	
	},
}