return {
	ret = "void",
	desc = <<<END'
<p>
Функция используется для отправки HTTP заголовка. В <a href="http://www.faqs.org/rfcs/rfc2616" 
target="_blank">спецификации HTTP</a> есть подробное описание HTTP заголовков.
<p>
Функцию <code>header</code> можно вызывать только если клиенту еще не передавались данные. 
То есть, она должна идти первой в выводе, перед ее вызовом не должно быть никаких HTML тэгов, пустых строк и т.п. 
<p>
Если заголовки HTTP уже были отправлены, то будет вызвано исключение.	
Узнать, были ли отправлены заголовки, можно прочитав свойство <a href="@url(globals.headersSent)">headersSent</a>.
END,
	params = {
		str = {
			type = "string",
			desc = <<<END'
<p>			
Строка заголовка, например, <code>Content-type: text/html; charset=utf-8</code>. Если заголовок с таким именем 
уже существует, то он будет заменен.
<p>
ObjectScript работает по протоколу FastCGI. В этом случае для установки кода 
состояния HTTP, необходимо использовать заголовок Status, например: 
<pre class="prettyprint">
    header("Status: 404 Not Found")
</pre>
END,			
		},
	},
}