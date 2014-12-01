HttpRequest = extends Component {
	_baseUrl = null,
	_scriptUrl = null,
	_url = null,
	_hostInfo = null,
	_pathInfo = null,
	_port = null,
	_securePort = null,
	_isSecureConnection = null,
	_acceptableLanguages = null,
	
	getParam = function(name){
		return _POST[name] || _GET[name]
	},
	
	getBaseUrl = function(absolute){
		return absolute ? @fullBaseUrl : @baseUrl
	},
	
	__get@baseUrl = function(){
		return @_baseUrl || @_baseUrl = path.dirname(@scriptUrl)
	},
	
	__get@fullBaseUrl = function(){
		return @hostInfo .. @baseUrl
	},
	
	__get@scriptUrl = function(){
		return @_scriptUrl || @_scriptUrl = @{
			var scriptName = path.basename(_SERVER.SCRIPT_FILENAME)
			if(path.basename(_SERVER.SCRIPT_NAME) === scriptName)
				return _SERVER.SCRIPT_NAME
			if(_SERVER.DOCUMENT_ROOT && _SERVER.SCRIPT_FILENAME.find(_SERVER.DOCUMENT_ROOT) === 0)
				return _SERVER.SCRIPT_FILENAME.sub(#_SERVER.DOCUMENT_ROOT)
			throw 'HttpRequest is unable to determine the entry script URL.'
		}
	},

	__get@url = function(){
		return @_url || @_url = @{
			if(_SERVER.HTTP_X_REWRITE_URL) // IIS
				return _SERVER.HTTP_X_REWRITE_URL
			if(_SERVER.REQUEST_URI){
				requestUri = _SERVER.REQUEST_URI
				return requestUri !== '' && requestUri.sub(0, 1) !== '/'
					? requestUri.replace(Regexp('/^(http|https):\/\/[^\/]+/i'), '')
					: requestUri
			}
			if(_SERVER.ORIG_PATH_INFO){ // IIS 5.0 CGI
				requestUri = _SERVER.ORIG_PATH_INFO
				return _SERVER.QUERY_STRING ? requestUri..'?'.._SERVER.QUERY_STRING : requestUri
			}
			throw 'Unable to determine the request URI.'
		}
	},
	
	__get@pathInfo = function(){
		return @_pathInfo || @_pathInfo = @{
			var pathInfo = @url
			
			var pos = pathInfo.find("?")
			pos && pathInfo = pathInfo.sub(0, pos)
			
			pathInfo = url.decode(pathInfo)

			// try to encode in UTF8 if not so
			// http://w3.org/International/questions/qa-forms-utf-8.html
			/* if(!preg_match('%^(?:
					[\x09\x0A\x0D\x20-\x7E]              # ASCII
					| [\xC2-\xDF][\x80-\xBF]             # non-overlong 2-byte
					| \xE0[\xA0-\xBF][\x80-\xBF]         # excluding overlongs
					| [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2}  # straight 3-byte
					| \xED[\x80-\x9F][\x80-\xBF]         # excluding surrogates
					| \xF0[\x90-\xBF][\x80-\xBF]{2}      # planes 1-3
					| [\xF1-\xF3][\x80-\xBF]{3}          # planes 4-15
					| \xF4[\x80-\x8F][\x80-\xBF]{2}      # plane 16
					)*$%xs', $pathInfo)){
				$pathInfo = utf8_encode($pathInfo);
			} */

			var scriptUrl, baseUrl = @scriptUrl, @baseUrl
			if(pathInfo.find(scriptUrl) === 0){
				pathInfo = pathInfo.sub(#scriptUrl)
			}elseif(baseUrl === '' || pathInfo.find(baseUrl) === 0){
				pathInfo = pathInfo.sub(#baseUrl)
			}else{
				throw 'Unable to determine the path info of the current request.'
			}
			return pathInfo.replace(Regexp("#^/+#"), '')
		}
	},
	
	__get@isSecureConnection = function(){
		return @_isSecureConnection || @_isSecureConnection = _SERVER.HTTPS.lower().find("on") !== null
	},
	
	__get@port = function(){
		return @_port || @_port = (!@isSecureConnection && parseInt(_SERVER.SERVER_PORT)) || 80
	},

	__set@port = function(value){
		@_port = value
		@_hostInfo = null
	},

	__get@securePort = function(){
		return @_securePort || @_securePort = (@isSecureConnection && parseInt(_SERVER.SERVER_PORT)) || 443
	},
	
	__set@securePort = function(value){
		@_securePort = value
		@_hostInfo = null
	},
	
	__get@hostInfo = function(){
		return @_hostInfo || @_hostInfo = @{
			var secure = @isSecureConnection
			var http = secure ? 'https' : 'http'
			_SERVER.HTTP_HOST && return http..'://'.._SERVER.HTTP_HOST
			var hostInfo = http..'://'.._SERVER.SERVER_NAME
			var port = secure ? @securePort : @port
			return port != 80 && !secure || port != 443 && secure
				? hostInfo..':'..port
				: hostInfo
		}
	},
	
	getHostInfo = function(schema){
		if(schema){
			var secure = @isSecureConnection
			if(secure && schema === 'https' || !secure && schema === 'http'){
				return @hostInfo
			}
			var port = schema === 'https' ? @securePort : @port
			return 	@hostInfo.replace(Regexp("#^(\w+)://#"), schema.."://") 
				.. (port != 80 && schema === 'http' || port != 443 && schema === 'https'
						? ':'..port	: '')
		}
		return @hostInfo
	},
	
	__get@isAjax = function(){
		return _SERVER.HTTP_X_REQUESTED_WITH === 'XMLHttpRequest'
	},
	
	__get@acceptableLanguages = function(){
        return @_acceptableLanguages || @_acceptableLanguages = @{
            if(_SERVER.HTTP_ACCEPT_LANGUAGE){
				return @parseAcceptHeader(_SERVER.HTTP_ACCEPT_LANGUAGE).keys
            }
			return []
        }
    },

	__set@acceptableLanguages = function(value){
        @_acceptableLanguages = value
    },
	
    parseAcceptHeader = function(header){
        var accepts = []
		for(var i, part in header.split(',')){
            var params = part.trim().split(Regexp('/\s*;\s*/'), -1, Regexp.SPLIT_NO_EMPTY)
            if(#params == 0){
                continue
            }
            var values = {
                'q' = [i, params.shift(), 1],
            }
			for(var _, param in params){
                if(param.find('=')){
                    var key, value = param.split('=', 2).unpack()
                    if(key === 'q'){
                        values.q[2] = toNumber(value)
                    } else {
                        values[key] = value
                    }
                }else{
                    values[] = param
                }
            }
            accepts[] = values
        }
		// echo "parseAcceptHeader #1 (${header}) <pre>"; dump(accepts); echo "</pre>"

        accepts.sort(function(a, b){
            a = a.q // index, name, q
            b = b.q
            if(a[2] > b[2]){
                return -1
            }elseif(a[2] < b[2]){
                return 1
            }elseif(a[1] === b[1]) {
                return a[0] <=> b[0]
            }elseif(a[1] === '*/*'){
                return 1
            }elseif(b[1] === '*/*'){
                return -1
            }else{
                var wa = a[1].sub(#a[1] - 1) === '*'
                var wb = b[1].sub(#b[1] - 1) === '*'
                if(wa != wb){
                    return wa ? 1 : -1
                }else{
                    return a[0] <=> b[0]
                }
            }
        })
		// echo "parseAcceptHeader #2 (${header}) <pre>"; dump(accepts); echo "</pre>"

        var result = {}
		for(var _, accept in accepts){
			// echo "parseAcceptHeader before "; dump(accept); echo "</pre> <br />"
            var name = accept.q[1]
            accept.q = accept.q[2]
            result[name] = accept
			// echo "parseAcceptHeader after ${name} = "; dump(accept); echo "</pre> <br />"
        }
		// echo "parseAcceptHeader #3 (${header}) <pre>"; dump(result); echo "</pre>"
        return result
    },
	
	getPreferredLanguage = function(languages){
        languages || app.lang
		arrayOf(languages) || throw "array required"
        for(var _, acceptableLanguage in @acceptableLanguages){
            acceptableLanguage = acceptableLanguage.lower().replace('_', '-')
            for(var language in languages){
                var normalizedLanguage = language.lower().replace('_', '-')
                if(normalizedLanguage === acceptableLanguage || // en-us==en-us
                    acceptableLanguage.find(normalizedLanguage..'-') === 0 || // en==en-us
                    normalizedLanguage.find(acceptableLanguage..'-') === 0){  // en-us==en
                    return language
                }
            }
        }
        return languages.first
    },
	
	redirect = function(url, end, statusCode){
		// echo "redirect: ${end}<br>"
		url = stringOf(url) || throw "required string url"
		header("Status: "..(statusCode || 302))
		header("Location: "..(url.sub(0, 1) == '/' ? @hostInfo..url : url))
		end !== false && app.end()
	},
}