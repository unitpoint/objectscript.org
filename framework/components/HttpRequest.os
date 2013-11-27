HttpRequest = extends Component {
	_baseUrl = null,
	_scriptUrl = null,
	_url = null,
	_hostInfo = null,
	_pathInfo = null,
	_port = null,
	_securePort = null,
	_isSecureConnection = null,
	
	getParam = function(name){
		return _POST[name] || _GET[name]
	},
	
	getBaseUrl = function(absolute){
		return absolute ? @hostInfo .. @baseUrl : @baseUrl
	},
	
	__get@baseUrl = function(){
		return @_baseUrl || @_baseUrl = path.dirname(@scriptUrl)
	},
	
	__get@scriptUrl = function(){
		if(!@_scriptUrl){
			var scriptName = path.basename(_SERVER.SCRIPT_FILENAME)
			if(path.basename(_SERVER.SCRIPT_NAME) === scriptName)
				@_scriptUrl = _SERVER.SCRIPT_NAME
			else if(_SERVER.DOCUMENT_ROOT && _SERVER.SCRIPT_FILENAME.find(_SERVER.DOCUMENT_ROOT) === 0)
				@_scriptUrl = _SERVER.SCRIPT_FILENAME.sub(#_SERVER.DOCUMENT_ROOT)
			else
				throw 'HttpRequest is unable to determine the entry script URL.'
			// echo "scriptUrl: "..@_scriptUrl.."<br />"
		}
		return @_scriptUrl
	},

	__get@url = function(){
		return @_url || @_url = @{
			var requestUri
			if (_SERVER.HTTP_X_REWRITE_URL) { // IIS
				requestUri = _SERVER.HTTP_X_REWRITE_URL
			} elseif (_SERVER.REQUEST_URI) {
				requestUri = _SERVER.REQUEST_URI
				if (requestUri !== '' && requestUri.sub(0, 1) !== '/') {
					requestUri = requestUri.replace(Regexp('/^(http|https):\/\/[^\/]+/i'), '')
				}
			} elseif (_SERVER.ORIG_PATH_INFO) { // IIS 5.0 CGI
				requestUri = _SERVER.ORIG_PATH_INFO
				if (_SERVER.QUERY_STRING) {
					requestUri = requestUri..'?'.._SERVER.QUERY_STRING
				}
			} else {
				throw 'Unable to determine the request URI.'
			}
			return requestUri
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
			/* if (!preg_match('%^(?:
					[\x09\x0A\x0D\x20-\x7E]              # ASCII
					| [\xC2-\xDF][\x80-\xBF]             # non-overlong 2-byte
					| \xE0[\xA0-\xBF][\x80-\xBF]         # excluding overlongs
					| [\xE1-\xEC\xEE\xEF][\x80-\xBF]{2}  # straight 3-byte
					| \xED[\x80-\x9F][\x80-\xBF]         # excluding surrogates
					| \xF0[\x90-\xBF][\x80-\xBF]{2}      # planes 1-3
					| [\xF1-\xF3][\x80-\xBF]{3}          # planes 4-15
					| \xF4[\x80-\x8F][\x80-\xBF]{2}      # plane 16
					)*$%xs', $pathInfo)) {
				$pathInfo = utf8_encode($pathInfo);
			} */

			var scriptUrl = @scriptUrl
			var baseUrl = @baseUrl
			if (pathInfo.find(scriptUrl) === 0) {
				pathInfo = pathInfo.sub(#scriptUrl)
			} elseif (baseUrl === '' || pathInfo.find(baseUrl) === 0) {
				pathInfo = pathInfo.sub(#baseUrl)
			} else {
				throw 'Unable to determine the path info of the current request.'
			}

			return pathInfo.replace(Regexp("#^/+#"), '')
		}
	},
	
	__get@isSecureConnection = function(){
		return @_isSecureConnection || @_isSecureConnection = _SERVER.HTTPS.lower().find("on") !== null
	},
	
	__get@port = function(){
		return @_port || @_port = (!@isSecureConnection && numberOf(_SERVER.SERVER_PORT)) || 80
	},

	__set@port = function(value){
		@_port = value
		@_hostInfo = null
	},

	__get@securePort = function(){
		return @_securePort || @_securePort = (@isSecureConnection && numberOf(_SERVER.SERVER_PORT)) || 443
	},
	
	__set@securePort = function(value){
		@_securePort = value
		@_hostInfo = null
	},
	
	__get@hostInfo = function(){
		if(!@_hostInfo){
			var secure = @isSecureConnection
			var http = secure ? 'https' : 'http'
			if(_SERVER.HTTP_HOST){
				@_hostInfo = http..'://'.._SERVER.HTTP_HOST
			}else{
				@_hostInfo = http..'://'.._SERVER.SERVER_NAME
				var port = secure ? @securePort : @port
				if((port != 80 && !secure) || (port != 443 && secure))
					@_hostInfo = @_hostInfo..':'..port
			}
		}
		return @_hostInfo
	},
	
	getHostInfo = function(schema){
		var hostInfo = @hostInfo
		if(schema){
			var secure = @isSecureConnection
			if(secure && schema === 'https' || !secure && schema === 'http'){
				return hostInfo
			}
			var port = schema === 'https' ? @securePort : @port
			if(port != 80 && schema === 'http' || port != 443 && schema === 'https')
				port = ':'..port
			else
				port = ''

			return 	hostInfo.replace(Regexp("#^(\w+)://#"), schema.."://")..port
		}
		return hostInfo
	},
	
	redirect = function(url, end, statusCode){
		// echo "redirect: ${end}<br>"
		url = stringOf(url) || throw "required string url"
		header("Status: "..(statusCode || 302))
		header("Location: "..(url.sub(0, 1) == '/' ? @hostInfo..url : url))
		;(end || end === null) && app.end()
	},
}