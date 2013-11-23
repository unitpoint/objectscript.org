return {
	ret = "object",
	retDesc = <<<END'
Новый объект, содержащий все свойства, для которых функция обратного вызова возвращает 
<code>true</code>.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L132",
	desc = <<<END"
Возвращает свойства объекта, удовлетворяющие условию, указанному в функции обратного вызова.
END,
	params = {
		func = {
			type = "function",
			desc = "Функция обратного вызова.",
		},
	},
}