return {
	// name = 'toString',
	desc = "Функция преобразует значение в строку.",
	ret = 'string',
	retDesc = <<<END"
<p>Возвращает результат преобразования в строковый тип.
<ul>
<li><p>Если параметр имеет строковый тип, то его значение будет возвращено.
<li><p>Если параметр имеет булев тип, то для <code>true</code> возвращается строка <span class="str">true</span>, а
для <code>false</code> - <span class="str">false</span>.
<li><p>Если параметр имеет числовой тип, то число будет преобразовано в строку и возвращено.
<li><p>Если параметр имеет пустое значение <code>null</code>, то возвращается <span class="str">null</span>.
<li><p>Для др. типов вызывается метод <code>valueOf</code> их прототипа, который должен вернуть значение простого типа.
Это значение будет преобразовано в строку по выше описанным правилам.
</ul>
<h3>Пример</h3>
<p>${app.controller.renderWidget{'SourceWidget', source="examples/tutorial.string.convert.osh", width=12}}
<p>${app.controller.renderPartial("_table.stringOf.osh")}
END,			
	params = {
		value = {
			type = 'mixed',
			desc = 'Значение для преобразования типа',
		},
	},			
}