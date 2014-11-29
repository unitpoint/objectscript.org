return {
	ret = "DateTime",
	retDesc = <<<END'
Новый экземпляр даты и времени или разница дат в днях.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L203",
	desc = <<<END"
Оператор разности (<code>-</code>) возвращает новую дату и время или разницу дат в днях в зависимости
от типа параметра.  
END,
	params = {
		value = {
			type = "mixed",
			desc = <<<END'
<p>
Если <code>value</code> имеет значение типа <code>DateTime</code>, то возвращается разница дат в количестве дней.
<p>
Если <code>value</code> имеет значение типа <code>number</code>, то возвращается 
новая дата и время со смещением на заданное количества дней.
<p>
Иначе вызывается исключение.
END,			
		},
	},
}