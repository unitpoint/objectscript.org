var dt = DateTime.now()
echo "${dt}, ${dt.year}, ${dt.second}, dayOfWeek: ${dt.dayOfWeek}, dayOfYear: ${dt.dayOfYear} <br />"

var dt2 = dt
dt = dt.clone()
dt.year = dt.year - 1
dt.hour = ((dt.hour + 24) - 1) % 24
echo "${dt}, ${dt.year}, ${dt.second}, dayOfWeek: ${dt.dayOfWeek}, dayOfYear: ${dt.dayOfYear} <br />"

/*
DateTimeDelta = {
	days = 0,
	
	__construct = function(days){
		@days = days || 0
	},
	
	valueOf: function(){
		return @days
	},
	
	__add: function(b){
		b is DateTimeDelta && return DateTimeDelta(@days + b.days)
		return DateTimeDelta(@days + (numberOf(b) || throw "DateTimeDelta.__add requires DateTimeDelta or Number"))
	},
	
	__sub: function(b){
		b is DateTimeDelta && return DateTimeDelta(@days - b.days)
		return DateTimeDelta(@days - (numberOf(b) || throw "DateTimeDelta.__sub requires DateTimeDelta or Number"))
	},
}

function DateTime.__add(b){
	var days = b is DateTimeDelta ? b.days : (numberOf(b) || throw "DateTime.__add requires DateTimeDelta or Number")
	var dt = DateTime()
	dt.comdate = @comdate - days
	return dt
}

function DateTime.__sub(b){
	b is DateTime && return DateTimeDelta(@comdate - b.comdate);
	var days = b is DateTimeDelta ? b.days : (numberOf(b) || throw "DateTime.__sub requires DateTime or DateTimeDelta or Number")
	var dt = DateTime()
	dt.comdate = @comdate - days
	return dt
}
*/

function DateTime.__add(b){
	// echo "DateTime.__add: ${this} + ${b} <br />"
	b is DateTime && throw "DateTime.__add requires Number"
	return DateTime {
		comdate = @comdate + (numberOf(b) || throw "DateTime.__add requires Number")
	}
}

function DateTime.__sub(b){
	// echo "DateTime.__sub: ${this} - ${b} <br />"
	b is DateTime && return @comdate - b.comdate;
	return DateTime {
		comdate = @comdate - (numberOf(b) || throw "DateTime.__sub requires DateTime or Number")
	}
}

echo "cur date: ${DateTime.now()} <br />"

echo "1.5 days before: ${DateTime.now() - 1.5} <br />"

var next_day = DateTime.now() + 1
echo "next day: ${next_day} <br />"

echo "after 40 days: ${DateTime.now() + 40} <br />"

var delta = (DateTime.now() + 10) - DateTime.now()
echo "delta, should be 10 days: ${delta} days <br />"

