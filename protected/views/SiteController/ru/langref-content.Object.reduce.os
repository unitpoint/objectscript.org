return {
	ret = "mixed",
	retDesc = <<<END'
Накопленный результат последнего вызова функции обратного вызова.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L155",
	desc = <<<END"
Вызывает заданную функцию обратного вызова для всех свойств в объекте. 
Возвращаемое значение функции обратного вызова представляет собой накопленный результат и 
предоставляется как аргумент в следующем вызове функции обратного вызова.
END,
	params = {
		func = {
			type = "function",
			desc = "Функция обратного вызова.",
		},
		initialValue = {
			type = "mixed",
			def = "null",
			desc = <<<END'
Значение используется в качестве начального значения, с которого начинается накопление. 
END,			
		},
	},
}