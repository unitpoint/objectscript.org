var dir = __DIR__
return {
	desc = <<<END'
<p>
Класс строки.
<p>
В ObjectScript строка создается конструкцией вида <span class="str">"Hello World!"</span>

END,
	props = {
		length = "${dir}/langref-content.String.length.os",
	},
	magics = {
		__len = "${dir}/langref-content.String.__len.os",
		__mul = "${dir}/langref-content.String.__mul.os",
		__div = "${dir}/langref-content.String.__div.os",
	},
	methods = {
		lenAnsi = "${dir}/langref-content.String.lenAnsi.os",
		lenUtf8 = "${dir}/langref-content.String.lenUtf8.os",
		sub = "${dir}/langref-content.String.sub.os",
		subAnsi = "${dir}/langref-content.String.subAnsi.os",
		subUtf8 = "${dir}/langref-content.String.subUtf8.os",
		find = "${dir}/langref-content.String.find.os",
		findAnsi = "${dir}/langref-content.String.findAnsi.os",
		findUtf8 = "${dir}/langref-content.String.findUtf8.os",
		replace = "${dir}/langref-content.String.replace.os",
		trim = "${dir}/langref-content.String.trim.os",
		upper = "${dir}/langref-content.String.upper.os",
		upperAnsi = "${dir}/langref-content.String.upperAnsi.os",
		lower = "${dir}/langref-content.String.lower.os",
		lowerAnsi = "${dir}/langref-content.String.lowerAnsi.os",
		split = "${dir}/langref-content.String.split.os",
		pack = "${dir}/langref-content.String.pack.os",
		unpack = "${dir}/langref-content.String.unpack.os",
		lenIconv = "${dir}/langref-content.String.lenIconv.os",
		subIconv = "${dir}/langref-content.String.subIconv.os",
		findIconv = "${dir}/langref-content.String.findIconv.os",
		reverse = "${dir}/langref-content.String.reverse.os",
		flower = "${dir}/langref-content.String.flower.os",
	},
}