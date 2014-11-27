return {
	ret = "mixed",
	retDesc = "Результат выполнения функции обратного вызова или <code>null</code>.",
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L148",
	desc = <<<END"
Вызывает функцию обратного вызова для каждого свойства объекта со следующими параметрами: значение свойства, 
название свойства, сам объект. Если функция обратного вызова вернет <i>истину</i> (не <code>null</code> и не <code>false</code>),
то обработка прекратится и это значение будет возвращено.
END,
	params = {
		func = {
			type = "function",
			desc = "Функция обратного вызова.",
		},
	},
}
