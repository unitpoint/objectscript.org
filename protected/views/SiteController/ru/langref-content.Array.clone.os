return {
	ret = "array",
	retDesc = "Новая копия массива.",
	desc = <<<END"
<p>
Клонирует объект.
END,
	extDesc = <<<END"
<p>
Метод <code>clone</code> делает не глубокое клонирование массива, т.е. элементы массива не клонируются.

<h3>Пример клонирования</h3>
${app.controller.renderWidget{'SourceWidget', source="examples/tutorial.oop.clone-sub-by-ref.osh"}}

<p>
В выше приведенном примере <code>"Greate"</code> отобразится только в массиве <code>b</code>, 
а <code>"Hi"</code> - в обоих массивах. Это потому, что оба массива ссылаются на одно и то же 
значение вложенного массива.

<p>
Если нужно сделать глубокое (рекурсивное) клонирование, то используйте метод <code>deepClone</code>. 
Этот метод добавляется при подключении <a href="https://github.com/unitpoint/objectscript.org/blob/master/framework/components/std.os#L78" 
target="_blank" rel="nofollow">библиотеки std</a> 

<h3>Пример глубокого клонирования</h3>
${app.controller.renderWidget{'SourceWidget', source="examples/tutorial.oop.clone-deep.osh"}}
END,
}