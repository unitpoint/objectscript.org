var dir = __DIR__
return {
	extension = "datetime",
	sourceFile = "https://github.com/unitpoint/objectscript/tree/master/src/ext-datetime",
	desc = <<<END'
Класс даты и времени григорианского календаря.
END,
	props = {
		absdays = "${dir}/langref-content.DateTime.absdays.os",
		GMTOffset = "${dir}/langref-content.DateTime.GMTOffset.os",
		// GMTicks = "${dir}/langref-content.DateTime.GMTicks.os",
		// ticks = "${dir}/langref-content.DateTime.ticks.os",
		comdate = "${dir}/langref-content.DateTime.comdate.os",
		abstime = "${dir}/langref-content.DateTime.abstime.os",
		absdate = "${dir}/langref-content.DateTime.absdate.os",
		isLeapyear = "${dir}/langref-content.DateTime.isLeapyear.os",
		year = "${dir}/langref-content.DateTime.year.os",
		month = "${dir}/langref-content.DateTime.month.os",
		day = "${dir}/langref-content.DateTime.day.os",
		hour = "${dir}/langref-content.DateTime.hour.os",
		minute = "${dir}/langref-content.DateTime.minute.os",
		second = "${dir}/langref-content.DateTime.second.os",
		dayOfWeek = "${dir}/langref-content.DateTime.dayOfWeek.os",
		dayOfYear = "${dir}/langref-content.DateTime.dayOfYear.os",
		// calendar = "${dir}/langref-content.DateTime.calendar.os",
	},
	methods = {
		// getGMTicksWithOffset = "${dir}/langref-content.DateTime.getGMTicksWithOffset.os",
		// getTicksWithOffset = "${dir}/langref-content.DateTime.getTicksWithOffset.os",
		// addAbsDateTimeOffset = "${dir}/langref-content.DateTime.addAbsDateTimeOffset.os",
		// setAbsDateTime = "${dir}/langref-content.DateTime.setAbsDateTime.os",
		// setDateAndTime = "${dir}/langref-content.DateTime.setDateAndTime.os",
		now = "${dir}/langref-content.DateTime.now.os",
		clone = "${dir}/langref-content.DateTime.clone.os",
		valueOf = "${dir}/langref-content.DateTime.valueOf.os",
		toJson = "${dir}/langref-content.DateTime.toJson.os",
		format = "${dir}/langref-content.DateTime.format.os",
	},
	magics = {
		__construct = "${dir}/langref-content.DateTime.__construct.os",
		__add = "${dir}/langref-content.DateTime.__add.os",
		__sub = "${dir}/langref-content.DateTime.__sub.os",
	},
}