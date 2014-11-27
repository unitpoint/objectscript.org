var dir = __DIR__
return {
	desc = <<<END'
Модуль для кодирования и декодирования данных в формате <b>JSON</b>.
END,
	methods = {
		encode = "${dir}/langref-content.json.encode.os",
		decode = "${dir}/langref-content.json.decode.os",
	},
}