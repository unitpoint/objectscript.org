return {
	// name = 'toNumber',
	desc = "Функция преобразует значение в число.",
	ret = 'number',
	retDesc = <<<END"
<p>Возвращает результат преобразования в числовой тип.
<ul>
<li><p>Если параметр имеет числовой тип, то его значение будет возвращено.
<li><p>Если параметр имеет булев тип, то для <code>true</code> возвращается <code>1</code>, а
для <code>false</code> - <code>0</code>.
<li><p>Если параметр имеет строковый тип, то его значение будет преобразовано в число и возвращено.
<li><p>Если параметр имеет пустое значение <code>null</code>, то возвращается <code>0</code>.
<li><p>Для др. типов вызывается метод <code>valueOf</code>, который должен вернуть значение простого типа.
Это значение будет преобразовано в число по выше описанным правилам.
</ul>
<h3>Пример</h3>
<p>${app.controller.renderWidget{'SourceWidget', source="examples/tutorial.number.convert.osh", width=12}}
<p>${app.controller.renderPartial("_table.numberOf.osh")}
END,			
	params = {
		value = {
			type = 'mixed',
			desc = 'Значение для преобразования типа',
		},
	},			
}