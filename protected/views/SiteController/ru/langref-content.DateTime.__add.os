return {
	ret = "DateTime",
	retDesc = <<<END'
Новый экземпляр даты и времени.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L197",
	desc = <<<END"
Оператор сложения (<code>+</code>) возвращает новую дату и время со смещением на 
заданное количества дней.  
END,
	params = {
		days = {
			type = "number",
			desc = "Количество дней.",
		},
	},
}