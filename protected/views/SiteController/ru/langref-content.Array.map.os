return {
	ret = "array",
	retDesc = <<<END'
Новый массив, в котором каждый элемент равен возвращаемому значению функции обратного вызова 
для связанного исходного элемента.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L124",
	desc = <<<END"
Вызывает заданную функцию обратного вызова для каждого элемента массива и возвращает массив, содержащий результаты.
END,
	params = {
		func = {
			type = "function",
			desc = "Функция обратного вызова.",
		},
	},
}