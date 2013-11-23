return {
	ret = "void",
	desc = "Функция выводит стек вызовов функций в ObjectScript.",
	package = "webcore.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/webcore.os#L29",
	params = {
		skipFuncs = {
			type = "mixed",
			desc = <<<END'
Допустимые типы значения: объект или число.
<ul>
<li><p>Если объект (<code>object</code>), то интерпретируется, как результат функции 
<a href="@url(globals.debugBackTrace)">debugBackTrace</a>.
<li><p>Если число (<code>number</code>), то интерпретируется, как 
количество функций на вершине стека, которые нужно пропустить и не включать в вывод.
В этом случае вызывается функця <a href="@url(globals.debugBackTrace)">debugBackTrace</a> для
получения стека вызовов функций.
END,
		},
	},
}