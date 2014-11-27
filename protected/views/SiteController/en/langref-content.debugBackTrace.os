return {
	ret = "array",
	retDesc = <<<END'
Стек вызовов функций. Каждый элемент массива содержит
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
	  <td width="100%">Ссылка на функцию в стеке вызовов.</td>
	</tr>
	<tr>
	  <td><code>name</code></td>
	  <td width="100%">Название функции.</td>
	</tr>
	<tr>
	  <td><code>object</code></td>
	  <td width="100%">Контекст функции.</td>
	</tr>
	<tr>
	  <td><code>file</code></td>
	  <td width="100%">Имя компилируемого файла. Если компилируется не файл, а текст 
(см. <a href="@url(globals.compileText)">compileText</a>, <a href="@url(globals.eval)">eval</a>), 
то данное свойство равно <code>null</code>.</td>
	</tr>
	<tr>
	  <td><code>line</code></td>
	  <td width="100%">Номер строки (начиная с <code>1</code>), на которой прооизошел вызов функции.</td>
	</tr>
	<tr>
	  <td><code>pos</code></td>
	  <td width="100%">Позиция символа в строке (начиная с <code>1</code>), на котором прооизошел вызов функции.</td>
	</tr>
  </tbody>
</table>
END,
	desc = "Функция возвращает стек вызовов функций в ObjectScript.",
	params = {
		skipFuncs = {
			type = "number",
			desc = "Количество функций на вершине стека, которые нужно пропустить и не включать в результат.",
		},
		maxFuncs = {
			type = "number",
			def	= 20,
			desc = "Максимальное количество элементов, которые требуется вернуть.",
		},
	},
}