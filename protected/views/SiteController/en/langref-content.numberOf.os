return {
	// name = 'numberOf',
	desc = "Функция проверки совместимости значения на число.",
	ret = 'number',
	retDesc = <<<END"
<p>Возвращает результат проверки параметра на числовой тип.
<ul>
<li><p>Если параметр имеет числовой тип, то его значение будет возвращено.
<li><p>Для др. типов параметра возвращается <code>null</code>.
</ul>
<h3>Пример</h3>
<p>${app.controller.renderWidget{'SourceWidget', source="examples/tutorial.number.convert.osh", width=12}}
<p>${app.controller.renderPartial("_table.numberOf.osh")}
END,			
	params = {
		value = {
			type = 'mixed',
			desc = 'Тестируемое значение',
		},
	},			
}