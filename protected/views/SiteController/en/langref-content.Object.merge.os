return {
	ret = "object",
	retDesc = <<<END'
Текущий объект, слитый с параметрами.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L169",
	desc = <<<END"
Делает слияние текущего объекта и всех параметров. Для параметров-объектов делает
перезапись существующих свойств. Для параметров-массивов делает добавление значений
к объекту.
END,
	rest = true,
}