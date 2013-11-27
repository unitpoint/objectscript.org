return {
	ret = "object",
	retDesc = <<<END'
Возвращает <i>перевернутый</i> объект.
END,
	package = "std.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L92",
	desc = <<<END"
<p>
Функция возвращает <i>перевернутый</i> объект, то есть названия свойств становятся значениями, 
а значения свойств становятся названиями.
<p>
Если значение встречается несколько раз, то в результате сохранится последнее <i>перевернутое</i> свойство.
END,
}