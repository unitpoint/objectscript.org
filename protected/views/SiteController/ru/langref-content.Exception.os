var dir = __DIR__
return {
	desc = <<<END'
<p>
Базовый класс исключения в ObjectScript. Все исключения должны наследоваться от <code>Exception</code>.
END,
	props = {
		message = "${dir}/langref-content.Exception.message.os",
		trace = "${dir}/langref-content.Exception.trace.os",
	},
	magics = {
		__construct = "${dir}/langref-content.Exception.__construct.os",
	},
}