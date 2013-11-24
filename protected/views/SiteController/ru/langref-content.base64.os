var dir = __DIR__
return {
	desc = <<<END'
Модуль для кодирования и декодирования данных методом base64.
END,
	methods = {
		encode = "${dir}/langref-content.base64.encode.os",
		decode = "${dir}/langref-content.base64.decode.os",
	},
}