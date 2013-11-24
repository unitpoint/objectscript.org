var dir = __DIR__
return {
	desc = <<<END'
Класс функции. Любая функция в ObjectScript имеет данный тип.
END,
	methods = {
		apply = "${dir}/langref-content.Function.apply.os",
		applyEnv = "${dir}/langref-content.Function.applyEnv.os",
		call = "${dir}/langref-content.Function.call.os",
		callEnv = "${dir}/langref-content.Function.callEnv.os",
	},
}