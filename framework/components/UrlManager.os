UrlManager = extends Component {
	routeVar = "r",
	rules = null,
	ruleConfig = 'UrlRule',
	suffix = null,
	enablePrettyUrl = true,
	indexScriptName = "index.osh",
	
	owner = null,
	_showScriptName = true,
	_baseUrl = null,
	
	__construct = function(owner){
		super()
		@owner = owner
	},
	
	init = function(){
		super()
		@compileRules()
	},
	
	compileRules = function(){
		var rules = []
		for(var key, rule in @rules){
			if(!objectOf(rule)){
				rule = {route = rule}
				var matches = Regexp('/^((?:(GET|HEAD|POST|PUT|PATCH|DELETE),)*(GET|HEAD|POST|PUT|PATCH|DELETE))\s+(.*)$/').exec(key)
				if(matches){
					rule.verb = matches[1].split(",")
					rule.mode = UrlRule.PARSING_ONLY
					key = matches[4]
				}
				rule.pattern = key
			}else{
				rule.route || rule.route = rule.shift()
				rule.pattern = key
			}
			rules[] = @owner.createComponent(@ruleConfig, rule)
			// echo "<pre>"; ob.push(); dump(rules.last); echo html.encode(ob.popContents()); echo "</pre>"
		}
		@rules = rules
	},
	
	parseRequest = function(request){
		return request.getParam(@routeVar) || @enablePrettyUrl && @{
			// echo "<pre>"; dump(_SERVER); echo "</pre>";
			for(var _, rule in @rules){
				var route, params = rule.parseRequest(this, request)
				if(route){
					_GET.merge(params)
					// echo "<pre>FOUND parseRequest: ${route}, ${_GET} \n"
					// echo "createUrl: "..rule.createUrl(this, route, params)
					// terminate()
					return route
				}
			}
			// echo "<pre>NOT FOUND parseRequest: ${request} <br />"; terminate()
		}
	},
	
	createUrl = function(p){
		stringOf(p) && return p
		
		delete p.params[@routeVar]
		
		var controller = p.controller || app.defaultController
		var action = p.action || app.defaultAction
		
		if(@enablePrettyUrl){
			var route = "${controller}/${action}"
			for(var _, rule in @rules){
				var url = rule.createUrl(this, route, p.params)
				if(url){
					var scriptUrl = app.request.hostInfo .. app.request.scriptUrl
					if(@indexScriptName && path.basename(scriptUrl) === ''){
						scriptUrl = scriptUrl.replace(Regexp("#/+$#"), "").."/"..@indexScriptName
					}
					url = scriptUrl.."/"..url
					return p["#"] ? url.."#".._E.url.encode(p["#"]) : url
				}
			}
		}
		
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
			urlParams[] = _E.url.encode(name).."=".._E.url.encode(value)
		}
		if(#urlParams > 0){
			url = url.."?"..urlParams.join(p.amp || "&")
		}
		return p["#"] ? url.."#".._E.url.encode(p["#"]) : url
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
}