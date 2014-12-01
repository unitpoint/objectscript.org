OSMultiLangHttpRequest = extends HttpRequest {
	_originPathInfo = null,
	_fixedPathInfo = null,
	
	__get@originPathInfo = function(){
		return @_originPathInfo || @{
			var pathInfo = @pathInfo // touch pathInfo
			return @_originPathInfo
		}
	},
	
	__get@pathInfo = function(){
		var pathInfo = super()
		if(@_originPathInfo !== pathInfo){
			@_originPathInfo = pathInfo
			var parts = pathInfo.split('/')
			if(parts[0] in app.params.languages){
				app.lang = parts.shift()
				pathInfo = parts.join('/')
			}else{
				app.lang = app.request.getPreferredLanguage(app.params.preferredLanguages)
			}
			@_fixedPathInfo = pathInfo
		}
		return @_fixedPathInfo
	},
}
