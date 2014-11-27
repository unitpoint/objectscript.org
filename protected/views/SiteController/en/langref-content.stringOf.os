return {
	// name = 'numberOf',
	desc = "Функция проверки совместимости значения на строку.",
	ret = 'string',
	retDesc = <<<END"
<p>Возвращает результат проверки параметра на строковый тип.
<ul>
<li><p>Если параметр имеет строковый тип, то его значение будет возвращено.
<li><p>Для др. типов возвращается <code>null</code>.
</ul>
<h3>Пример</h3>
<p>${app.controller.renderWidget{'SourceWidget', source="examples/tutorial.string.convert.osh", width=12}}
<p>${app.controller.renderPartial("_table.stringOf.osh")}
END,			
	params = {
		value = {
			type = 'mixed',
			desc = 'Тестируемое значение',
		},
	},			
}