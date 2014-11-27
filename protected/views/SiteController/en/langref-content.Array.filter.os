return {
	ret = "array",
	retDesc = <<<END'
Новый массив, содержащий все элементы, для которых функция обратного вызова возвращает 
<code>true</code>.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L140",
	desc = <<<END"
Возвращает элементы массива, удовлетворяющие условию, указанному в функции обратного вызова.
END,
	params = {
		func = {
			type = "function",
			desc = "Функция обратного вызова.",
		},
	},
}