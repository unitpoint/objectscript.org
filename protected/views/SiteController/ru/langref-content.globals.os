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

		printf = __DIR__ .. "/langref-content.printf.os",
		sprintf = __DIR__ .. "/langref-content.sprintf.os",
		
		require = __DIR__ .. "/langref-content.require.os",
		
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
		
		numberOf = __DIR__ .. "/langref-content.numberOf.os",
		stringOf = __DIR__ .. "/langref-content.stringOf.os",
		arrayOf = __DIR__ .. "/langref-content.arrayOf.os",
		objectOf = __DIR__ .. "/langref-content.objectOf.os",
		userdataOf = __DIR__ .. "/langref-content.userdataOf.os",
		functionOf = __DIR__ .. "/langref-content.functionOf.os",
		
		toBoolean = __DIR__ .. "/langref-content.toBoolean.os",
		toNumber = __DIR__ .. "/langref-content.toNumber.os",
		toString = __DIR__ .. "/langref-content.toString.os",
		
		compileText = __DIR__ .. "/langref-content.compileText.os",
		compileFile = __DIR__ .. "/langref-content.compileFile.os",
		debugBackTrace = __DIR__ .. "/langref-content.debugBackTrace.os",
		terminate = __DIR__ .. "/langref-content.terminate.os",
		unhandledException = __DIR__ .. "/langref-content.unhandledException.os",
		assert = __DIR__ .. "/langref-content.assert.os",
		eval = __DIR__ .. "/langref-content.eval.os",
		evalEnv = __DIR__ .. "/langref-content.evalEnv.os",
		toArray = __DIR__ .. "/langref-content.toArray.os",
		toObject = __DIR__ .. "/langref-content.toObject.os",
		registerShutdownFunction = __DIR__ .. "/langref-content.registerShutdownFunction.os",
		unregisterShutdownFunction = __DIR__ .. "/langref-content.unregisterShutdownFunction.os",
		// triggerShutdownFunctions = __DIR__ .. "/langref-content.triggerShutdownFunctions.os",
		registerCleanupFunction = __DIR__ .. "/langref-content.registerCleanupFunction.os",
		unregisterCleanupFunction = __DIR__ .. "/langref-content.unregisterCleanupFunction.os",
		// triggerCleanupFunctions = __DIR__ .. "/langref-content.triggerCleanupFunctions.os",
		printBackTrace = __DIR__ .. "/langref-content.printBackTrace.os",
		header = __DIR__ .. "/langref-content.header.os",
		setCookie = __DIR__ .. "/langref-content.setCookie.os",
		// dump = __DIR__ .. "/langref-content.dump.os",
	},
	
	classes = {
		Object = __DIR__ .. "/langref-content.Object.os",
		Boolean = __DIR__ .. "/langref-content.Boolean.os",
		Number = __DIR__ .. "/langref-content.Number.os",
		String = __DIR__ .. "/langref-content.String.os",
		Array = __DIR__ .. "/langref-content.Array.os",
		Function = __DIR__ .. "/langref-content.Function.os",
		Userdata = __DIR__ .. "/langref-content.Userdata.os",
		Buffer = __DIR__ .. "/langref-content.Buffer.os",
		Exception = __DIR__ .. "/langref-content.Exception.os",
		File = __DIR__ .. "/langref-content.File.os",
		CompilerException = __DIR__ .. "/langref-content.CompilerException.os",
		DateTime = __DIR__ .. "/langref-content.DateTime.os",
		Curl = __DIR__ .. "/langref-content.Curl.os",
		CurlException = __DIR__ .. "/langref-content.CurlException.os",
		SqliteConnection = __DIR__ .. "/langref-content.SqliteConnection.os",
		SqliteStatement = __DIR__ .. "/langref-content.SqliteStatement.os",
		SqliteException = __DIR__ .. "/langref-content.SqliteException.os",
		Regexp = __DIR__ .. "/langref-content.Regexp.os",
		RegexpException = __DIR__ .. "/langref-content.RegexpException.os",
		ODBO = __DIR__ .. "/langref-content.ODBO.os",
		ODBOStatement = __DIR__ .. "/langref-content.ODBOStatement.os",
		ODBOException = __DIR__ .. "/langref-content.ODBOException.os",
	},
	
	modules = {
		path = __DIR__ .. "/langref-content.path.os",
		json = __DIR__ .. "/langref-content.json.os",
		math = __DIR__ .. "/langref-content.math.os",
		gc = __DIR__ .. "/langref-content.gc.os",
		process = __DIR__ .. "/langref-content.process.os",
		fs = __DIR__ .. "/langref-content.fs.os",
		hashlib = __DIR__ .. "/langref-content.hashlib.os",
		url = __DIR__ .. "/langref-content.url.os",
		base64 = __DIR__ .. "/langref-content.base64.os",
		hashlib = __DIR__ .. "/langref-content.hashlib.os",
		iconv = __DIR__ .. "/langref-content.iconv.os",
		zlib = __DIR__ .. "/langref-content.zlib.os",
		ob = __DIR__ .. "/langref-content.ob.os",
	},
	
	props = {
		_SERVER = __DIR__ .. "/langref-content._SERVER.os",
		_POST = __DIR__ .. "/langref-content._POST.os",
		_GET = __DIR__ .. "/langref-content._GET.os",
		_FILES = __DIR__ .. "/langref-content._FILES.os",
		_COOKIE = __DIR__ .. "/langref-content._COOKIE.os",
		_ENV = __DIR__ .. "/langref-content._ENV.os",
	
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