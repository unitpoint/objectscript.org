return {
	ret = "void",
	desc = <<<END'
Удаляет функцию, предварительно зарегистрированную через 
<a href="@url(globals.registerCleanupFunction)">registerCleanupFunction</a>.
END,
	params = {
		func = {
			type = "function",
			desc = "Функция для выполнения при завершении скрипта в фазе отчистки данных.",
		},
	},
}