return {
	ret = "void",
	package = "webcore.os",
	sourceFile = "https://github.com/unitpoint/objectscript.org/blob/master/framework/components/webcore.os#L11",
	desc = <<<END'
<p>
Функция вызывается при обработке никем не перехваченного исключения. После выполнения этой функции,
работа скрипта прекращается. Программист может присвоить <code>unhandledException</code>
свою функцию для обработки такого исключения, например, записать информацию об ошибке в 
базу данных. 
<p>
При подключении файла <code>webcore.os</code> (этот файл используется в веб приложениях)
эта функция выводит информацию об исключении в стандартный канал вывода.
END,	
}