return {
	type = "array",
	desc = <<<END"
<p>
Массив стека вызовов функций на момент возникновения исключения. Каждый элемент массива содержит
объект со следующими свойствами:

<table class="table">
  <thead>
	<tr>
	  <th>Название</th>
	  <th>Описание</th>
	</tr>
  </thead>
  <tbody>
	<tr>
	  <td><code>arguments</code></td>
	  <td width="100%">Объект с параметрами, с которыми была запущена функция, в которой произошло исключение.</td>
	</tr>
	<tr>
	  <td><code>func</code></td>
	  <td width="100%">Ссылка на функцию, в которой произошло исключение.</td>
	</tr>
	<tr>
	  <td><code>name</code></td>
	  <td width="100%">Название функции, в которой произошло исключение.</td>
	</tr>
	<tr>
	  <td><code>object</code></td>
	  <td width="100%">Контекст функции, в которой произошло исключение.</td>
	</tr>
	<tr>
	  <td><code>file</code></td>
	  <td width="100%">Имя компилируемого файла. Если компилируется не файл, а текст 
(см. <a href="@url(globals.compileText)">compileText</a>, <a href="@url(globals.eval)">eval</a>), 
то данное свойство равно <code>null</code>.</td>
	</tr>
	<tr>
	  <td><code>line</code></td>
	  <td width="100%">Номер строки (начиная с <code>1</code>), на которой прооизошла ошибка.</td>
	</tr>
	<tr>
	  <td><code>pos</code></td>
	  <td width="100%">Позиция символа в строке (начиная с <code>1</code>), на котором прооизошла ошибка.</td>
	</tr>
  </tbody>
</table>
END,	
}