var dir = __DIR__
return {
	desc = <<<END'
<p>
Класс массива. Массив наследует все свойства и методы класса <a href="@url(globals.Object)">Object</a>.
Для массива вместо названия свойства используется числовой индекс. При удалении элемента
массива, все элементы, следующие за удаленным, сдвигаются, занимая образовавшуюся дырку.
<p>
В ObjectScript массив создается конструкцией вида <code>[1, 2, 3]</code>.
END,
	props = {
		length = "${dir}/langref-content.Array.length.os",
		keys = "${dir}/langref-content.Array.keys.os",
		values = "${dir}/langref-content.Array.values.os",
		first = "${dir}/langref-content.Array.first.os",
		last = "${dir}/langref-content.Array.last.os",
	},
	magics = {
		__len = "${dir}/langref-content.Array.__len.os",
		__iter = "${dir}/langref-content.Array.__iter.os",
		__setempty = "${dir}/langref-content.Array.__setempty.os",
		__getempty = "${dir}/langref-content.Array.__getempty.os",
	},
	methods = {
		indexOf = "${dir}/langref-content.Array.indexOf.os",
		lastIndexOf = "${dir}/langref-content.Array.lastIndexOf.os",
		reverseIter = "${dir}/langref-content.Array.reverseIter.os",
		valueOf = "${dir}/langref-content.Array.valueOf.os",
		clone = "${dir}/langref-content.Array.clone.os",
		toJson = "${dir}/langref-content.Array.toJson.os",
		sort = "${dir}/langref-content.Array.sort.os",
		push = "${dir}/langref-content.Array.push.os",
		pop = "${dir}/langref-content.Array.pop.os",
		unshift = "${dir}/langref-content.Array.unshift.os",
		shift = "${dir}/langref-content.Array.shift.os",
		sub = "${dir}/langref-content.Array.sub.os",
		join = "${dir}/langref-content.Array.join.os",
		clear = "${dir}/langref-content.Array.clear.os",
		getKeys = "${dir}/langref-content.Array.getKeys.os",
		getValues = "${dir}/langref-content.Array.getValues.os",
		unpack = "${dir}/langref-content.Array.unpack.os",
		getFirst = "${dir}/langref-content.Array.getFirst.os",
		setFirst = "${dir}/langref-content.Array.setFirst.os",
		deleteFirst = "${dir}/langref-content.Array.deleteFirst.os",
		getLast = "${dir}/langref-content.Array.getLast.os",
		setLast = "${dir}/langref-content.Array.setLast.os",
		deleteLast = "${dir}/langref-content.Array.deleteLast.os",
		deepClone = "${dir}/langref-content.Array.deepClone.os",
		flip = "${dir}/langref-content.Array.flip.os",
		reverse = "${dir}/langref-content.Array.reverse.os",
		map = "${dir}/langref-content.Array.map.os",
		filter = "${dir}/langref-content.Array.filter.os",
		each = "${dir}/langref-content.Array.each.os",
		reduce = "${dir}/langref-content.Array.reduce.os",
		reduceRight = "${dir}/langref-content.Array.reduceRight.os",
		merge = "${dir}/langref-content.Array.merge.os",
	},
}