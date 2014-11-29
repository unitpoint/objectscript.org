var dir = __DIR__
return {
	extension = "base64",
	sourceFile = "https://github.com/unitpoint/objectscript/tree/master/src/ext-base64",
	desc = <<<END'
Модуль для кодирования и декодирования данных методом base64.
END,
	methods = {
		encode = "${dir}/langref-content.base64.encode.os",
		decode = "${dir}/langref-content.base64.decode.os",
	},
}