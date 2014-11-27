return {
	ret = "mixed",
	retDesc = <<<END'
Добавленное значение.
END,
	desc = <<<END"
<p>
Добавляет значение в массив с конца.
<p>
Методы <code>push</code> и <a href="@url(globals.Array.pop)">pop</a> позволяют моделировать стек типа <b>LIFO</b>.
END,
	params = {
		value = {
			type = "mixed",
			desc = "Значения для добавления.",
		},
	},
}