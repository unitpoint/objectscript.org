return { 
	desc = "В разделе справочник функций Вы найдете полное описание всех стандартных функций, классов и модулей в OS.",
	funcs = {
		echo = {
			// show = 'void echo( arg1 [, arg2 ...] )'
			ret = 'void',
			rest = true,
			desc = <<<END'
Функция <code>echo</code> преобразует аргументы в строку и выводит их в стандартный 
канал вывода без дополнительного форматирования. Эта функция безопасна для вывода двоичных данных. 
В случае отсутствия аргументов, ничего не выводит.
END,
		},
		
		print = {
			ret = 'void',
			rest = true,
			desc = <<<END'
Функция <code>print</code> выводит аргументы с помощью функции <a href="#url(globals.echo)">echo</a>. 
Между аргументами добавляет "\t" (символ табуляции), а после последнего аргумента - "\n" (символ новой строки). 
В случае отсутствия аргументов, выводит "\n".
END,
		},

		printf = __DIR__ .. "/langref-content.globals.printf.os",
		require = __DIR__ .. "/langref-content.globals.require.os",
	},
	
	props = {
		// modulesLoaded = {}
		modulesLoaded = {
			type = "object",
			desc = "Список загруженных модулей.",
		},
		
		OS_SOURCECODE_AUTO = {
			type = "number",
			def = "0",
		},
		
		OS_SOURCECODE_PLAIN = {
			type = "number",
			def = "1",
		},
		
		OS_SOURCECODE_TEMPLATE = {
			type = "number",
			def = "2",
		},
  },
	
}