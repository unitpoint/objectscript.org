require "std"

BR = "<br />"
BEGIN_PRE = "<pre>"
END_PRE = "</pre>"

var function removeRootPath(path){
	return toString(path).replace(_SERVER.DOCUMENT_ROOT, "")
}

function unhandledException(e){
	// ob.popAll()
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

function printBackTrace(skipFuncs){
	echo BEGIN_PRE
	for(var i, t in objectOf(skipFuncs) || debugBackTrace((skipFuncs || 0) + 1)){ // skip printBackTrace
		printf("#${i} ${removeRootPath(t.file)}%s: %s, args: ${removeRootPath(t.arguments)}${BR}",
			t.line > 0 ? "(${t.line},${t.pos})" : "",
			t.object && t.object !== _G ? "{${typeOf(t.object)}#${t.object.__id}}.${t.func.__name}" : t.func.__name)
	}
	echo END_PRE
}

if('HTTP_COOKIE' in _SERVER){
	for(var k, v in _SERVER.HTTP_COOKIE.trim().split(';')){
		v == '' && continue
		v = v.trim().split('=', 2)
		if(#v == 2){
			_COOKIE.setSmartProperty(url.decode(v[0]), url.decode(v[1]))
		}else{
			_COOKIE.setSmartProperty(url.decode(v[0]), '')
		}
	}	
}

if('QUERY_STRING' in _SERVER){
	for(var k, v in _SERVER.QUERY_STRING.trim().split('&')){
		v == '' && continue
		v = v.trim().split('=', 2)
		if(#v == 2){
			_GET.setSmartProperty(url.decode(v[0]), url.decode(v[1]))
		}else{
			_GET.setSmartProperty(url.decode(v[0]), '')
		}
	}	
}

var headerList, headersSent = {}, false
function header(str){
	var parts = str.split(":", 2)
	headerList[parts[0].trim().upper()] = str
}

function __get@headersSent(){
	return headersSent
}

function __set@headersSent(){
	throw "headersSent is readonly property"
}

var cookieList = {}
function setCookie(name, value, expires, path, domain, secure, httponly){
	headersSent && header() // header throws exception in this situation
	
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
	cookieList[str] = str
}

var buffers, echoFuncs = [], []

var originEcho = echo
// var orgPrintf = printf

HttpHeadersSentException = extends Exception {
}

var function sendHeader(){
	if(!headersSent){ // && (#headerList > 0 || #cookieList > 0)){	
		headersSent = true
		notifyHeadersSent()
		if(#headerList == 0){
			headerList[] = "Content-type: text/html; charset=utf-8"
		}
		for(var _, v in headerList){
			originEcho(v, "\r\n")
		}
		for(var _, v in cookieList){
			originEcho(v, "\r\n")
		}
		originEcho "\r\n"
		var trace = debugBackTrace(2)
		header = function(){
			var e = HttpHeadersSentException("HTTP headers are already sent")
			e.trace = trace
			throw e			
			// originEcho "HTTP headers are already sent"..BR
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
	},
	
	popAll = function(){
		for(; #buffers > 0;){
			@pop()
		}	
	}
}

registerShutdownFunction {||
	ob.popAll()
	sendHeader()
}

var savedTerminate = terminate
function terminate(){
	triggerShutdownFunctions()
	sendHeader();
	savedTerminate()
}
