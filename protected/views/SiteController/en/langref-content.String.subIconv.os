return {
	ret = "string",
	retDesc = <<<END'
Новая подстрока.
END,	
	extension = "iconv",
	desc = <<<END"
<p>
Возвращает строку с символами, начинающимися с позиции <code>start</code> 
и в количестве <code>length</code>. 
<p>
Данная функция предназначена для работы с кодировкой, переданной в параметре <code>charset</code>.
END,
	params = {
		start = {
			type = "number",
			desc = <<<END'
<p>			
Позиция первого символа (начиная с <code>0</code>).
<p>
Если значение отрицательное, то стартовая позиция символа определяется, как отстоящая
на <code>start</code> позиций с конца.
END,
		},
		length = {
			type = "number",
			def = "null",
			desc = <<<END'
<p>			
Количество символов для обработки.
<p>
Если значение отрицательное, то обрабатывается до символа, отстоящего на
<code>length</code> позиций с конца.
<p>
Если значение не задано (<code>null</code>), то обрабатываются все символы до конца.
END,
		},
		charset = {
			type = "string",
			def = "null",
			desc = <<<END'
Кодировка символов. Если не задано, то берется <a href="@url(globals.iconv.defaultCharset)">iconv.defaultCharset</a>.
END,
		},		
	},
}