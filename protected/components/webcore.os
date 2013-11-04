require "std"

BR = "<br />"
BEGIN_PRE = "<pre>"
END_PRE = "</pre>"

var function removeRootPath(path){
	return path.replace(_SERVER.DOCUMENT_ROOT, "")
}

function unhandledException(e){
	echo BEGIN_PRE
	// dump _SERVER
	if(e is CompilerException){
		echo "${BR}Unhandled exception: '${removeRootPath(e.message)}' in ${removeRootPath(e.file)}(${e.line},${e.pos}), token: ${e.token}\n${e.lineString.trim()}${BR}${BR}"
	}else{
		echo "${BR}Unhandled exception: '${removeRootPath(e.message)}'${BR}${BR}"
	}
	if('trace' in e)
	for(var i, t in e.trace){
		printf("#${i} ${removeRootPath(t.file)}%s: %s, args: ${t.arguments}${BR}",
			t.line > 0 ? "(${t.line},${t.pos})" : "",
			t.object && t.object !== _G ? "{${typeOf(t.object)}#${t.object.__id}}.${t.func.__name}" : t.__name)

	}
	echo END_PRE
}

function printBackTrace(skipNumFuncs){
	echo BEGIN_PRE
	for(var i, t in debugBackTrace(skipNumFuncs + 1)){ // skip printBackTrace
		printf("#${i} ${removeRootPath(t.file)}%s: %s, args: ${t.arguments}${BR}",
			t.line > 0 ? "(${t.line},${t.pos})" : "",
			t.object && t.object !== _G ? "{${typeOf(t.object)}#${t.object.__id}}.${t.func.__name}" : t.__name)
	}
	echo END_PRE
}

if('HTTP_COOKIE' in _SERVER){
	var cookie = _SERVER.HTTP_COOKIE.trim()
	if(#cookie > 0)
		for(var k, v in cookie.split(';')){
			v = v.trim().split('=', 1)
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
			v = v.trim().split('=', 1)
			if(#v == 2){
				_GET.setSmartProperty(v[0], url.decode(v[1]))
			}else{
				_GET.setSmartProperty(v[0], '')
			}
		}	
}

var headerList, headerSent = {}, false
function header(str){
	var parts = str.split(":", 1)
	if(#parts == 2){
		headerList[parts[0].upper()] = str
	}else{
		headerList[str.upper()] = str
	}
}

// header "Content-type: text/html; charset=utf-8"

var cookiesList = []
function setCookie(name, value, expires, path, domain, secure, httponly){
	var cookie = Buffer()
	// value && value = stringOf(value) || throw "setCookie: value should be String"
	if(!value){ // deleted
		cookie.append("Set-Cookie: ${name}=deleted; expires="..DateTime(1970, 1, 1).format("D, d-M-Y H:i:s T"))
	}else{
		cookie.append("Set-Cookie: ${name}="..url.encode(value))
		if(expires is DateTime){
			cookie.append("; expires="..expires.format("D, d-M-Y H:i:s T"))
		}else if(expires){
			cookie.append("; expires="..(stringOf(expires) || throw "setCookie: expires should be DateTime, String or null"))
		}
		path && cookie.append("; path=${path}")
		domain && cookie.append("; path=${domain}")
		secure && cookie.append("; secure")
		httponly && cookie.append("; httponly")
	}
	// echo "cookie: "..toString(cookie).."<br />"
	cookiesList.push(toString(cookie))
}

var buffers, echoFuncs = [], []

var originEcho = echo
// var orgPrintf = printf

var function sendHeader(){
	if(!headerSent && (#headerList > 0 || #cookiesList > 0)){	
		headerSent = true
		triggerHeaderSent()
		for(var k, v in headerList){
			originEcho(v, "\r\n")
		}
		for(var _, v in cookiesList){
			originEcho(v, "\r\n")
		}
		originEcho "\r\n"
		header = function(){
			originEcho "HTTP headers are already sent"..BR
		}
		sendHeader = function(){}
	}
}

function echo(){
	echo = originEcho
	sendHeader()
	echo.apply(_E, arguments)
}

var function notBufferedEcho(){
	sendHeader()
	originEcho.apply(_E, arguments)
}

var function obEcho(){
	var oldEcho = echo
	echo = notBufferedEcho
	assert(#buffers > 0, "ob buffer is not exist")
	var buf = buffers[#buffers-1]
	buf.append.apply(buf, arguments)
	if(echo === notBufferedEcho){
		echo = oldEcho // obEcho
	}
}

ob = {
	push = function(){
		/* if(#buffers == 0){
			echo = obEcho
			// printf = obPrintf
		} */
		echoFuncs.push(echo)
		echo = obEcho
		buffers.push(Buffer())
	},

	pop = function(){
		assert(#buffers > 0, "ob buffer is not exist")
		var buf = buffers.pop()
		/* if(#buffers == 0){
			echo = originEcho
		} */
		echo = echoFuncs.pop()
		echo(buf)
	},

	popContent = function(){
		assert(#buffers > 0, "ob buffer is not exist")
		var buf = buffers.pop()
		/* if(#buffers == 0){
			echo = originEcho
		} */
		echo = echoFuncs.pop()
		return toString(buf)
	},

	getContent = function(){
		assert(#buffers > 0, "ob buffer is not exist")
		return toString(buffers[#buffers-1])
	}
}

registerShutdownFunction {||
	for(; #buffers > 0;){
		ob.pop()
	}
	sendHeader();
}

var savedTerminate = terminate
function terminate(){
	triggerShutdownFunctions()
	sendHeader();
	savedTerminate()
}
