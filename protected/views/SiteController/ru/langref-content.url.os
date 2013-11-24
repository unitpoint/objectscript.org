var dir = __DIR__
return {
	desc = <<<END'
Модуль для кодирования и декодирования данных, которые используются в HTTP-запросах, например, в <b>URL</b>.
END,
	methods = {
		encode = "${dir}/langref-content.url.encode.os",
		decode = "${dir}/langref-content.url.decode.os",
	},
}