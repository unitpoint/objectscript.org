HttpRequest = extends Component {
	_baseUrl = null,
	_scriptUrl = null,
	
	getParam = function(name){
		return _POST[name] || _GET[name]
	},
	
	__get@baseUrl = function(){
		if(!@_baseUrl){
			@_baseUrl = path.dirname(@scriptUrl).replace(Regexp("#/+$#"), "")
			// echo "baseUrl: "..@_baseUrl.."<br />"
		}
		return @_baseUrl
	},
	
	__get@scriptUrl = function(){
		if(!@_scriptUrl){
			var scriptName = path.basename(_SERVER['SCRIPT_FILENAME']);
			if(path.basename(_SERVER['SCRIPT_NAME']) === scriptName)
				@_scriptUrl = _SERVER['SCRIPT_NAME'];
			else if(_SERVER['DOCUMENT_ROOT'] && _SERVER['SCRIPT_FILENAME'].find(_SERVER['DOCUMENT_ROOT']) === 0)
				@_scriptUrl = _SERVER['SCRIPT_FILENAME'].sub(#_SERVER['DOCUMENT_ROOT']);
			else
				throw _T('HttpRequest is unable to determine the entry script URL.');
			// echo "scriptUrl: "..@_scriptUrl.."<br />"
		}
		return @_scriptUrl
	},
}