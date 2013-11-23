var dir = __DIR__
return {
	desc = <<<END'
<p>
Класс исключения компилятора.
<p>
Если в ходе компиляции скрипта происходит ошибка, то ObjectScript вызывает исключение данного типа.
END,
	props = {
		message = "${dir}/langref-content.CompilerException.message.os",
		file = "${dir}/langref-content.CompilerException.file.os",
		line = "${dir}/langref-content.CompilerException.line.os",
		pos = "${dir}/langref-content.CompilerException.pos.os",
		token = "${dir}/langref-content.CompilerException.token.os",
		lineString = "${dir}/langref-content.CompilerException.lineString.os",
	},
}