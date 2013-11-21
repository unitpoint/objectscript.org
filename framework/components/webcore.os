require "std"

BR = "<br />"
BEGIN_PRE = "<pre>"
END_PRE = "</pre>"

var function removeRootPath(path){
	return toString(path).replace(_SERVER.DOCUMENT_ROOT, "")
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
		printf("#${i} ${removeRootPath(t.file)}%s: %s, args: ${removeRootPath(t.arguments)}${BR}",
			t.line > 0 ? "(${t.line},${t.pos})" : "",
			t.object && t.object !== _G ? "{${typeOf(t.object)}#${t.object.__id}}.${t.func.__name}" : t.func.__name)

	}
	echo END_PRE
}

function printBackTrace(skipNumFuncs){
	echo BEGIN_PRE
	for(var i, t in debugBackTrace((skipNumFuncs || 0) + 1)){ // skip printBackTrace
		printf("#${i} ${removeRootPath(t.file)}%s: %s, args: ${removeRootPath(t.arguments)}${BR}",
			t.line > 0 ? "(${t.line},${t.pos})" : "",
			t.object && t.object !== _G ? "{${typeOf(t.object)}#${t.object.__id}}.${t.func.__name}" : t.func.__name)
	}
	echo END_PRE
}

if('HTTP_COOKIE' in _SERVER){
	var cookie = _SERVER.HTTP_COOKIE.trim()
	if(#cookie > 0)
		for(var k, v in cookie.split(';')){
			v = v.trim().split('=', 2)
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
			v = v.trim().split('=', 2)
			if(#v == 2){
				_GET.setSmartProperty(v[0], url.decode(v[1]))
			}else{
				_GET.setSmartProperty(v[0], '')
			}
		}	
}

var headerList, headerSent = {}, false
function header(str){
	var parts = str.split(":", 2)
	headerList[parts[0].upper()] = str
}

// header "Content-type: text/html; charset=utf-8"

var cookiesList = {}
function setCookie(name, value, expires, path, domain, secure, httponly){
	var buf = Buffer()
	// value && value = stringOf(value) || throw "setCookie: value should be String"
	if(!value){ // deleted
		buf.append("Set-Cookie: ${url.encode(name)}=deleted; expires="..DateTime(1970, 1, 1).format("R"))
	}else{
		buf.append("Set-Cookie: ${url.encode(name)}=${url.encode(value)}")
		if(expires is DateTime){
			buf.append("; expires="..expires.format("R"))
		}else if(expires){
			buf.append("; expires="..(stringOf(expires) || throw "setCookie: expires should be DateTime, String or null"))
		}
		path && buf.append("; path=${path}")
		domain && buf.append("; path=${domain}")
		secure && buf.append("; secure")
		httponly && buf.append("; httponly")
	}
	// echo "cookie: "..toString(buf).."<br />"
	var str = toString(buf)
	cookiesList[name] = str
}

var buffers, echoFuncs = [], []

var originEcho = echo
// var orgPrintf = printf

var function sendHeader(){
	if(!headerSent && (#headerList > 0 || #cookiesList > 0)){	
		headerSent = true
		triggerHeaderSent()
		for(var _, v in headerList){
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
	var buf = buffers.last || throw "ob buffer is not exist"
	buf.append.apply(buf, arguments)
	if(echo === notBufferedEcho){
		echo = oldEcho // obEcho
	}
}

ob = {
	push = function(){
		echoFuncs.push(echo)
		echo = obEcho
		buffers.push(Buffer())
	},

	pop = function(){
		echo = echoFuncs.pop()
		echo(buffers.pop() || throw "ob buffer is not exist")
	},

	popContents = function(){
		echo = echoFuncs.pop()
		return toString(buffers.pop() || throw "ob buffer is not exist")
	},

	getContents = function(){
		return toString(buffers.last  || throw "ob buffer is not exist")
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
