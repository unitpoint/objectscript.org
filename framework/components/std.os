var filesChecked = {}
function __get(name){
	if(!(name in filesChecked)){
		filesChecked[name] = true
		require(name, false)
		if(name in this){
			return this[name]
		}
	}
	throw "unknown class or global property \"${name}\""
}

function assert(a, message){
	return a || throw(message || "assert failed")
}

function eval(str){
	return compileText(str).apply(null, ...)
}

function evalEnv(str, env){
	return compileText(str).applyEnv(env || _G, null, ...)
}

function toArray(a){
	arrayOf(a) && return a;
	var type = typeOf(a)
	if(type == "object"){
		var arr = []
		for(var i, v in a){
			arr.push(v)
		}
		return arr
	}
	if(type == "null"){
		return null
	}
	return [a]
}

function toObject(a){
	objectOf(a) && return a;
	var type = typeOf(a)
	if(type == "array"){
		var object = {}
		for(var i, v in a){
			object.push(v)
		}
		return object
	}
	if(type == "null"){
		return null
	}
	return {a}
}

function File.readContents(filename)
{
	var f = File(filename, "rb")
	var content = f.read()
	f.close()
	return content
}

function File.writeContents(filename, content)
{
	var f = File(filename, "wb")
	f.write(content)
	f.close()
}

Buffer.__lshift = Buffer.append	// make alias to << operator

function Object.do(func){
	return func() || this
}

function Object.deepClone(){
	var recurs = {}
	var clone = function(value){
		recurs[value] && return value
		recurs[value] = true
		var copy = value.clone()
		for(var k, v in copy){
			copy[k] = clone(v)
		}
		return copy
	}
	return clone(this)
}

function Object.flip(){
	var r = {}
	for(var k, v in this){
		r[v] = k
	}
	return r
}

function Object.reverse(){
	var r = {}
	for(var k, v in @reverseIter()){
		r[k] = v
	}
	return r
}

function Array.reverse(){
	var r = []
	for(var k, v in @reverseIter()){
		r[] = v
	}
	return r
}

function Object.map(func){
	var r = {}
	for(var k, v in this){
		r[k] = func(v, k, this)
	}
	return r
}

function Array.map(func){
	var r = []
	for(var k, v in this){
		r[] = func(v, k, this)
	}
	return r
}

function Object.filter(func){
	var r = {}
	for(var k, v in this){
		func(v, k, this) && r[k] = v
	}
	return r
}

function Array.filter(func){
	var r = []
	for(var k, v in this){
		func(v, k, this) && r[] = v
	}
	return r
}

function Object.each(func){
	for(var k, v in this){
		return func(v, k, this) || continue
	}
	return this
}

function Object.reduce(func, value){
	for(var k, v in this){
		value = func(value, v, k, this)
	}
	return value
}

function Object.reduceRight(func, value){
	for(var k, v in @reverseIter()){
		value = func(value, v, k, this)
	}
	return value
}

function Object.merge(){
	for(var _, arg in arguments){
		if(arrayOf(arg)){
			for(var k, v in arg){
				this[] = v
			}
		}else{
			for(var k, v in arg){
				this[k] = v
			}
		}
	}
	return this
}

function Array.merge(){
	for(var _, param in arguments){
		for(var k, v in param){
			this[] = v
		}
	}
	return this
}

DateTime || throw "DateTime required"

appStartTime = DateTime.now()

function DateTime.__add(b){
	return DateTime {
		comdate = @comdate + (numberOf(b) || throw "DateTime.__add requires Number")
	}
}

function DateTime.__sub(b){
	b is DateTime && return @comdate - b.comdate
	return DateTime {
		comdate = @comdate - (numberOf(b) || throw "DateTime.__sub requires DateTime or Number")
	}
}

var shutdownFunctions, cleanupFunctions = {}, {}

function registerShutdownFunction(func){
	shutdownFunctions[functionOf(func) || throw "function required"] = true
}

function unregisterShutdownFunction(func){
	delete shutdownFunctions[func]
}

function triggerShutdownFunctions(){
	var funcs = shutdownFunctions
	shutdownFunctions = {}
	for(var func, _ in funcs.reverseIter()){
		func()
	}
}

function registerCleanupFunction(func){
	cleanupFunctions[functionOf(func) || throw "function required"] = true
}

function unregisterCleanupFunction(func){
	delete cleanupFunctions[func]
}

function triggerCleanupFunctions(){
	var funcs = cleanupFunctions
	cleanupFunctions = {}
	for(var func, _ in funcs.reverseIter()){
		func()
	}
}

function String.reverse(){
	var buf = Buffer()
	for(var i = #this-1; i >= 0; i--){
		buf.append(@sub(i, 1))
	}
	return toString(buf)
}

function String.__mul(count){
	count < 0 && return this.reverse() * -count
	count == 1 && return this
	var buf = Buffer()
	for(; count >= 1; count--){
		buf.append(this)
	}
	if(count > 0){
		buf.append(@sub(0, #this * count))
	}
	return toString(buf)
}

function String.__div(count){
	return this * (1 / count)
}

/*
function String.__add(b){
	return this .. b
}

function String.__radd(b){
	return b .. this
}
*/

function String.flower(){
	return @sub(0, 1).upper() .. @sub(1)
}
	
url || throw "url module required"

function url.buildQuery(p, amp){
	var r = []
	for(var k, v in p){
		r[] = url.encode(k)..'='..url.encode(v)
	}
	return r.join(amp || '&')
}

path || throw "path module required"

function path.normalize(path){
	var r = []
	for(var _, p in (stringOf(path) || throw "string required").split(Regexp("#[/\\\\]#"))){
		if(p == "" || p == "."){
			continue
		}
		if(p == ".."){
			delete r.last
			continue
		}
		r[] = p
	}
	return r.join("/").replace(Regexp("#^\w+:/#s"), "$0/")
}
