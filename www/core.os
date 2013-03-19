function assert(a, message){
	a || throw (message || "assert failed")
}

BR = "<br />"
BEGIN_PRE = "<pre>"
END_PRE = "</pre>"

function unhandledException(e){
	echo BEGIN_PRE
	if(e is CompilerException){
		echo "${BR}Unhandled exception: '${e.message}' in ${e.file}(${e.line},${e.pos}), token: ${e.token}\n${e.lineString.trim()}${BR}${BR}"
	}else{
		echo "${BR}Unhandled exception: '${e.message}'${BR}${BR}"
	}
	if('trace' in e)
	for(var i, t in e.trace){
		printf("#${i} ${t.file}%s: %s, args: ${t.arguments}${BR}",
			t.line > 0 ? "(${t.line},${t.pos})" : "",
			t.object && t.object !== _G ? "<${typeOf(t.object)}#${t.object.id}>.${t.name}" : t.name)

	}
	echo END_PRE
}

function printBackTrace(skipNumFuncs){
	echo BEGIN_PRE
	for(var i, t in debugBackTrace(skipNumFuncs + 1)){ // skip printBackTrace
		printf("#${i} ${t.file}%s: %s, args: ${t.arguments}${BR}",
			t.line > 0 ? "(${t.line},${t.pos})" : "",
			t.object && t.object !== _G ? "<${typeOf(t.object)}#${t.object.id}>.${t.name}" : t.name)
	}
	echo END_PRE
}

function eval(str, env){
	return compileText(str).applyEnv(env || _G, null, ...)
}

if('HTTP_COOKIE' in _SERVER){
	var cookie = _SERVER.HTTP_COOKIE.trim()
	if(#cookie > 0)
		for(var k, v in cookie.split(';')){
			v = v.trim().split('=')
			if(#v == 2){
				_COOKIE.setSmartProperty(v[0], v[1])
			}else{
				_COOKIE.setSmartProperty(v[0], '')
			}
		}	
}

if('QUERY_STRING' in _SERVER){
	var query = _SERVER.QUERY_STRING.trim()
	if(#query > 0)
		for(var k, v in query.split('&')){
			v = v.trim().split('=')
			if(#v == 2){
				_GET.setSmartProperty(v[0], url.decode(v[1]))
			}else{
				_GET.setSmartProperty(v[0], '')
			}
		}	
}

var header_list, header_sent = {}, false
function header(str){
	var parts = str.split(":", 1)
	if(#parts == 2){
		header_list[parts[0].upper()] = str
	}else{
		header_list[str.upper()] = str
	}
}

header "Content-type: text/html; charset=utf8"

var realEcho = echo

;{
	var buffers = []
	
	var orgEcho = echo
	// var orgPrintf = printf
	
	function echo(){
		echo = orgEcho
		header_sent = true
		triggerHeaderSent();
		for(var k, v in header_list){
			realEcho(v, "\r\n")
		}
		realEcho "\r\n"
		header = function(){
			realEcho "HTTP headers are already sent\n"
		}
		echo.apply(_E, arguments)
	}
	
	var function notBufferedEcho(){
		orgEcho.apply(_E, arguments)
	}
	
	var function obEcho(){
		echo = notBufferedEcho
		assert(#buffers > 0, "ob buffer is not exist")
		var buf = buffers[#buffers-1]
		buf.append.apply(buf, arguments)
		if(echo === notBufferedEcho){
			echo = obEcho
		}
	}
	
	ob = {}
	function ob.push(){
		if(#buffers == 0){
			echo = obEcho
			// printf = obPrintf
		}
		buffers.push(Buffer())
	}
	
	function ob.pop(){
		assert(#buffers > 0, "ob buffer is not exist")
		var buf = buffers.pop()
		if(#buffers == 0){
			echo = orgEcho
		}
		echo(buf)
	}
	
	function ob.popContent(){
		assert(#buffers > 0, "ob buffer is not exist")
		var buf = buffers.pop()
		if(#buffers == 0){
			echo = orgEcho
		}
		return toString(buf)
	}
	
	function ob.getContent(){
		assert(#buffers > 0, "ob buffer is not exist")
		return toString(buffers[#buffers-1])
	}
	
	registerShutdownFunction {||
		for(; #buffers > 0;){
			ob.pop()
		}
	}
}

var strReplace = String.replace
function String.replace(search, replace){
	if(!(search is Regexp) && objectOf(search)){
		var str = this
		for(search, replace in search){
			str = strReplace.call(str, search, replace)
		}
		return str
	}else{
		return strReplace.call(this, search, replace)
	}
}

function String.__mul(count){
	count == 1 && return this
	count <= 0 && return ""
	var buf = Buffer()
	for(; count >= 1; count--){
		buf.append(this)
	}
	if(count > 0){
		buf.append(this.sub(0, #this * count))
	}
	return toString(buf)
}

function String.__div(count){
	return this * (1 / count)
}

function String.__add(b){
	return this .. b
}

function dump(val){
	var dump_recurse_check = {}
	var function checkProps(val){
		if(val.hasOwnProperty()){ 
			printf("<%s:%d> ", typeOf(val), val.id)
			return true
		}
	}
	function(val, deep, is_key){
		echo is_key ? "  " * deep : ""
		if(objectOf(val) || checkProps(val)){
			if(val in dump_recurse_check){
				echo "<<RECURSE>>\n"
			}else{
				dump_recurse_check[val] = true
				echo "{\n"
				for(var k, v in val.dumpIter()){
					_F(k, deep+1, true)
					echo " = "
					_F(v, deep+1)
				}
				echo("  " * deep, "}\n")
			}
		}else{
			echo(val, !is_key ? "\n" : "")
		}
	}(val, 0)
}

var modules_checked = {}
function __get(name){
	if(!(name in modules_checked)){
		modules_checked[name] = true
		require(name)
		if(name in this){
			return this[name]
		}
	}
	throw("unknown class or global property "..name)
}

