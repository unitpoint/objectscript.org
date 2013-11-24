return {
	// name = 'numberOf',
	desc = "Функция проверки совместимости значения на число.",
	ret = 'number',
	retDesc = <<<END"
<p>Возвращает результат проверки параметра на числовой тип.
<ul>
<li><p>Если параметр имеет числовой тип, то его значение будет возвращено.
<li><p>Если параметр имеет булев тип, то для <code>true</code> возвращается <code>1</code>, а
для <code>false</code> - <code>0</code>.
<li><p>Если параметр имеет строковый тип, то его значение будет преобразовано в число и возвращено. ObjectScript поддерживает
запись числа в разных системах счисления, наример, шестнадцатеричное число должно начинаться с 
<span class="str">0x</span>. Если строка целиком не может быть преобразована в число, то возвращается
<code>null</code>.
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