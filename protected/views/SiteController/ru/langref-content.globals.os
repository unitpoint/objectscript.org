return { 
	desc = <<<END'
В разделе справочник функций Вы найдете полное описание всех стандартных функций, классов и модулей в OS.
END,
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
Функция <code>print</code> выводит аргументы с помощью функции <a href="@url(globals.echo)">echo</a>. 
Между аргументами добавляет "\t" (символ табуляции), а после последнего аргумента - "\n" (символ новой строки). 
В случае отсутствия аргументов, выводит "\n".
END,
		},

		printf = __DIR__ .. "/langref-content.globals.printf.os",
		sprintf = __DIR__ .. "/langref-content.globals.sprintf.os",
		
		require = __DIR__ .. "/langref-content.globals.require.os",
		
		typeOf = {
			desc = <<<END'
Фукнция позволяет получить базовый тип значения, переданного в параметре.
END,
			ret = 'string',
			retDesc = <<<END'
<p>Возвращает строку, показывающую тип параметра.
<ul>
<li><p>Если параметр - строка, то возвращает <span class="str">"string"</span>
<li><p>Если число, то возвращает <span class="str">"number"</span>
<li><p>Если булев, то возвращает <span class="str">"boolean"</span>
<li><p>Если объект, то возвращает <span class="str">"object"</span>
<li><p>Если пользовательские данные, то возвращает <span class="str">"userdata"</span>
<li><p>Если пустое значение, то возвращает <span class="str">"null"</span>
</ul>
END,			
			params = {
				value = {
					type = 'mixed',
					desc = 'Тестируемое значение',
				},
			},
		},
		
		booleanOf = {
			desc = "Функция проверки совместимости значения на булев тип.",
			ret = 'boolean',
			retDesc = <<<END'
<p>Возвращает результат проверки параметра на булев тип.
<ul>
<li><p>Если параметр имеет булев тип, то его значение будет возвращено.
<li><p>Если параметр имеет числовой тип, то возвращается результат сравнения числа с нулем, если равен нулю,
то будет возвращено значение <code>false</code>, иначе - <code>true</code>.
<li><p>Для др. типов параметра возвращается <code>null</code>.
</ul>
END,			
			params = {
				value = {
					type = 'mixed',
					desc = 'Тестируемое значение',
				},
			},
		},
		
		numberOf = __DIR__ .. "/langref-content.globals.numberOf.os",
		stringOf = __DIR__ .. "/langref-content.globals.stringOf.os",
		arrayOf = __DIR__ .. "/langref-content.globals.arrayOf.os",
		objectOf = __DIR__ .. "/langref-content.globals.objectOf.os",
		userdataOf = __DIR__ .. "/langref-content.globals.userdataOf.os",
		functionOf = __DIR__ .. "/langref-content.globals.functionOf.os",
		
		toBoolean = __DIR__ .. "/langref-content.globals.toBoolean.os",
		toNumber = __DIR__ .. "/langref-content.globals.toNumber.os",
		toString = __DIR__ .. "/langref-content.globals.toString.os",
	},
	
	props = {
		// modulesLoaded = {}
		modulesLoaded = {
			type = "object",
			desc = "Список загруженных модулей.",
		},
		
		OS_VERSION = {
			type = "string",
			def = json.encode(OS_VERSION),
		},
		
		SOURCECODE_AUTO = {
			type = "number",
			def = SOURCECODE_AUTO,
		},
		
		SOURCECODE_PLAIN = {
			type = "number",
			def = SOURCECODE_PLAIN,
		},
		
		SOURCECODE_TEMPLATE = {
			type = "number",
			def = SOURCECODE_TEMPLATE,
		},
  },
	
}