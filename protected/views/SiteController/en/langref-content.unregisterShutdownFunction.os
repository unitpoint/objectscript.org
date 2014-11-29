return {
	ret = "void",
	desc = <<<END'
Удаляет функцию, предварительно зарегистрированную через 
<a href="@url(globals.registerShutdownFunction)">registerShutdownFunction</a>.
END,
	params = {
		func = {
			type = "function",
			desc = "Функция для выполнения при завершении скрипта.",
		},
	},
}