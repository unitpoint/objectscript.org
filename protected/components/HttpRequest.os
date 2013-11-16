HttpRequest = extends Component {
	_baseUrl = null,
	_scriptUrl = null,
	_hostInfo = null,
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
			var scriptName = path.basename(_SERVER['SCRIPT_FILENAME'])
			if(path.basename(_SERVER['SCRIPT_NAME']) === scriptName)
				@_scriptUrl = _SERVER['SCRIPT_NAME']
			else if(_SERVER['DOCUMENT_ROOT'] && _SERVER['SCRIPT_FILENAME'].find(_SERVER['DOCUMENT_ROOT']) === 0)
				@_scriptUrl = _SERVER['SCRIPT_FILENAME'].sub(#_SERVER['DOCUMENT_ROOT'])
			else
				throw _T('HttpRequest is unable to determine the entry script URL.')
			// echo "scriptUrl: "..@_scriptUrl.."<br />"
		}
		return @_scriptUrl
	},
	
	__get@isSecureConnection = function(){
		return @_isSecureConnection || @_isSecureConnection = _SERVER['HTTPS'].lower().find("on") !== null
	},
	
	__get@port = function(){
		return @_port || @_port = (!@isSecureConnection && numberOf(_SERVER['SERVER_PORT'])) || 80
	},

	__set@port = function(value){
		@_port = value
		@_hostInfo = null
	},

	__get@securePort = function(){
		return @_securePort || @_securePort = (@isSecureConnection && numberOf(_SERVER['SERVER_PORT'])) || 443
	},
	
	__set@securePort = function(value){
		@_securePort = value
		@_hostInfo = null
	},
	
	__get@hostInfo = function(){
		if(!@_hostInfo){
			var secure = @isSecureConnection
			var http = secure ? 'https' : 'http'
			if(_SERVER['HTTP_HOST']){
				@_hostInfo = http..'://'.._SERVER['HTTP_HOST']
			}else{
				@_hostInfo = http..'://'.._SERVER['SERVER_NAME']
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