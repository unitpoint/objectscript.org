return {
	ret = "void",
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L214",
	desc = <<<END'
<p>
Регистрирует функцию, которая будет вызвана при завершении скрипта. 
В этой фазе стандартный канал вывода еще открыт. Таким образом
данные, выведенные с помощью <a href="@url(globals.echo)">echo</a> и др. подобных
функций будут доставлены клиенту.
<p>
В этой фазе не рекомендуется выполнять фоновые задания, такие как, чистка таблиц в базе данных.
Для этого более подходит фаза отчистки данных и функция 
<a href="@url(globals.registerCleanupFunction)">registerCleanupFunction</a>.
<p>
Функции завершения вызываются в обратном порядке от порядка их регистрации.
END,
	params = {
		func = {
			type = "function",
			desc = "Функция для выполнения при завершении скрипта.",
		},
	},
}