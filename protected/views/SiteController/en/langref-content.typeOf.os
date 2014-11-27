return 	{
	desc = <<<END'
Фукнция позволяет получить базовый тип значения, переданного в параметре.
END,
	ret = 'string',
	retDesc = <<<END'
<p>Возвращает строку, показывающую тип параметра.
<ul>
<li><p>Если параметр - строка, то возвращает <span class="str">"string"</span>
<li><p>Если число, то возвращает <span class="str">"number"</span>
<li><p>Если булев, то возвращает <span class="str">"boolean"</span>
<li><p>Если объект, то возвращает <span class="str">"object"</span>
<li><p>Если пользовательские данные, то возвращает <span class="str">"userdata"</span>
<li><p>Если пустое значение, то возвращает <span class="str">"null"</span>
</ul>
END,			
	params = {
		value = {
			type = 'mixed',
			desc = 'Тестируемое значение',
		},
	},
}
