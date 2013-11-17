CUrlManager = extends CComponent {
	routeVar = "r",
	_showScriptName = true,
	_baseUrl = null,
	
	__construct = function(){
		super()
	},
	
	init = function(){
		super()
	},
	
	parseUrl = function(request){
		return request.getParam(@routeVar)
	},
	
	__get@showScriptName = function(){
		return @_showScriptName
	},
	
	__set@showScriptName = function(value){
		@_showScriptName = value
		@_baseUrl = null
	},
	
	__get@baseUrl = function(){
		return @_baseUrl || @_baseUrl = @showScriptName ? app.request.scriptUrl : app.request.baseUrl
	},
	
	createUrl = function(p){
		stringOf(p) && return p
		
		delete p.params[@routeVar]
		
		var controller = p.controller || app.defaultController
		var action = p.action || app.defaultAction
		var urlParams = []
		if(action == app.defaultAction){
			if(controller != app.defaultController){
				urlParams[] = "${@routeVar}=${controller}"
			}
		}else{
			urlParams[] = "${@routeVar}=${controller}/${action}"
		}
		var url = @showScriptName ? @baseUrl : @baseUrl.."/"
		for(var name, value in p.params){
			urlParams.push(_E.url.encode(name).."=".._E.url.encode(value))
		}
		if(#urlParams > 0){
			url = url.."?"..urlParams.join(p.amp || "&")
		}
		return p["#"] ? url.."#".._E.url.encode(p["#"]) : url
	},
}