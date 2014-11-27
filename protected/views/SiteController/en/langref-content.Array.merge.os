return {
	ret = "array",
	retDesc = <<<END'
Текущий массив, слитый с параметрами.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L169",
	desc = <<<END"
Делает слияние текущего массива и всех параметров (массивов или объектов). Добавляет значения
элементов параметров к текущему массиву.
END,
	rest = true,
}