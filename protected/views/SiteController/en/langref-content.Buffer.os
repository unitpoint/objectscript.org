var dir = __DIR__
return {
	desc = <<<END'
Буферный класс для обработки данных в памяти. Совместим с бинарными данными.
Буферный класс наследует все свойства и методы класса <a href="@url(globals.String)">String</a>.
END,
	magics = {
		__construct = "${dir}/langref-content.Buffer.__construct.os",
		__len = "${dir}/langref-content.Buffer.__len.os",
		__lshift = "${dir}/langref-content.Buffer.__lshift.os",
	},
	methods = {
		append = "${dir}/langref-content.Buffer.append.os",
		clear = "${dir}/langref-content.Buffer.clear.os",
		valueOf = "${dir}/langref-content.Buffer.valueOf.os",
		printf = "${dir}/langref-content.Buffer.printf.os",
	},
}