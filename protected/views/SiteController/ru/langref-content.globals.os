var dir = __DIR__
return { 
	desc = <<<END'
В разделе справочник функций ObjectScript есть полное описание всех стандартных функций, классов, своств и модулей языка.
END,
	funcs = {
		echo = "${dir}/langref-content.echo.os",
		print = "${dir}/langref-content.print.os",
		printf = "${dir}/langref-content.printf.os",
		sprintf = "${dir}/langref-content.sprintf.os",
		
		require = "${dir}/langref-content.require.os",
		
		typeOf = "${dir}/langref-content.typeOf.os",
		
		booleanOf = "${dir}/langref-content.booleanOf.os",
		numberOf = "${dir}/langref-content.numberOf.os",
		stringOf = "${dir}/langref-content.stringOf.os",
		arrayOf = "${dir}/langref-content.arrayOf.os",
		objectOf = "${dir}/langref-content.objectOf.os",
		userdataOf = "${dir}/langref-content.userdataOf.os",
		functionOf = "${dir}/langref-content.functionOf.os",
		
		toBoolean = "${dir}/langref-content.toBoolean.os",
		toNumber = "${dir}/langref-content.toNumber.os",
		toString = "${dir}/langref-content.toString.os",
		
		compileText = "${dir}/langref-content.compileText.os",
		compileFile = "${dir}/langref-content.compileFile.os",
		debugBackTrace = "${dir}/langref-content.debugBackTrace.os",
		terminate = "${dir}/langref-content.terminate.os",
		unhandledException = "${dir}/langref-content.unhandledException.os",
		assert = "${dir}/langref-content.assert.os",
		eval = "${dir}/langref-content.eval.os",
		evalEnv = "${dir}/langref-content.evalEnv.os",
		toArray = "${dir}/langref-content.toArray.os",
		toObject = "${dir}/langref-content.toObject.os",
		registerShutdownFunction = "${dir}/langref-content.registerShutdownFunction.os",
		unregisterShutdownFunction = "${dir}/langref-content.unregisterShutdownFunction.os",
		// triggerShutdownFunctions = "${dir}/langref-content.triggerShutdownFunctions.os",
		registerCleanupFunction = "${dir}/langref-content.registerCleanupFunction.os",
		unregisterCleanupFunction = "${dir}/langref-content.unregisterCleanupFunction.os",
		// triggerCleanupFunctions = "${dir}/langref-content.triggerCleanupFunctions.os",
		printBackTrace = "${dir}/langref-content.printBackTrace.os",
		header = "${dir}/langref-content.header.os",
		setCookie = "${dir}/langref-content.setCookie.os",
		// dump = "${dir}/langref-content.dump.os",
	},
	
	classes = {
		Object = "${dir}/langref-content.Object.os",
		Boolean = "${dir}/langref-content.Boolean.os",
		Number = "${dir}/langref-content.Number.os",
		String = "${dir}/langref-content.String.os",
		Array = "${dir}/langref-content.Array.os",
		Function = "${dir}/langref-content.Function.os",
		Userdata = "${dir}/langref-content.Userdata.os",
		Buffer = "${dir}/langref-content.Buffer.os",
		Exception = "${dir}/langref-content.Exception.os",
		File = "${dir}/langref-content.File.os",
		CompilerException = "${dir}/langref-content.CompilerException.os",
		DateTime = "${dir}/langref-content.DateTime.os",
		Curl = "${dir}/langref-content.Curl.os",
		CurlException = "${dir}/langref-content.CurlException.os",
		SqliteConnection = "${dir}/langref-content.SqliteConnection.os",
		SqliteStatement = "${dir}/langref-content.SqliteStatement.os",
		SqliteException = "${dir}/langref-content.SqliteException.os",
		Regexp = "${dir}/langref-content.Regexp.os",
		RegexpException = "${dir}/langref-content.RegexpException.os",
		ODBO = "${dir}/langref-content.ODBO.os",
		ODBOStatement = "${dir}/langref-content.ODBOStatement.os",
		ODBOException = "${dir}/langref-content.ODBOException.os",
	},
	
	modules = {
		path = "${dir}/langref-content.path.os",
		json = "${dir}/langref-content.json.os",
		math = "${dir}/langref-content.math.os",
		gc = "${dir}/langref-content.gc.os",
		process = "${dir}/langref-content.process.os",
		fs = "${dir}/langref-content.fs.os",
		hashlib = "${dir}/langref-content.hashlib.os",
		url = "${dir}/langref-content.url.os",
		base64 = "${dir}/langref-content.base64.os",
		hashlib = "${dir}/langref-content.hashlib.os",
		iconv = "${dir}/langref-content.iconv.os",
		zlib = "${dir}/langref-content.zlib.os",
		ob = "${dir}/langref-content.ob.os",
	},
	
	props = {
		_SERVER = "${dir}/langref-content._SERVER.os",
		_POST = "${dir}/langref-content._POST.os",
		_GET = "${dir}/langref-content._GET.os",
		_FILES = "${dir}/langref-content._FILES.os",
		_COOKIE = "${dir}/langref-content._COOKIE.os",
		_ENV = "${dir}/langref-content._ENV.os",
	
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
		
		headersSent = "${dir}/langref-content.headersSent.os",
  },
	
}