return {
	ret = "DateTime",
	retDesc = <<<END'
Новый экземпляр даты и времени.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L203",
	desc = <<<END"
Создает новый экземпляр даты и времени.  
END,
	params = {
		year = {
			type = "mixed",
			def = "null",
			desc = <<<END'
<p>
Если <code>year</code> имеет значение типа <code>number</code>, то устанавливает год.
<p>
Если <code>year</code> имеет значение типа <code>object</code>, то свойства объекта
используются для установки свойств даты и времени. Остальные параметры в этом случае игнорируются.
<p>
Если <code>year</code> - пустое значение (<code>null</code>), то остальные параметры тоже должны
быть <code>null</code>. В этом случае дата и время устанавливаются в <code>0000-00-00 00:00:00.000</code> 
END,			
		},
		month = {
			type = "number",
			def = "null",
			desc = "Месяц даты (начиная с 1).",
		},
		day = {
			type = "number",
			def = "null",
			desc = "День месяца (начиная с 1).",
		},
		hour = {
			type = "number",
			def = "null",
			desc = "Час времени (начиная с 0).",
		},
		minute = {
			type = "number",
			def = "null",
			desc = "Минута времени (начиная с 0).",
		},
		second = {
			type = "number",
			def = "null",
			desc = "Секунды времени (начиная с 0).",
		},
	},
}