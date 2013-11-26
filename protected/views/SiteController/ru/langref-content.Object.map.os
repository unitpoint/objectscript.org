return {
	ret = "object",
	retDesc = <<<END'
Новый объект, в котором каждое свойство равно возвращаемому значению функции обратного вызова 
для связанного исходного свойства объекта.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L116",
	desc = <<<END"
Вызывает заданную функцию обратного вызова для каждого элемента массива и возвращает объект, содержащий результаты.
END,
	params = {
		func = {
			type = "function",
			desc = "Функция обратного вызова.",
		},
	},
}