var app_alias = path.dirname(__FILE__) .. "/.."
// require.paths.push(app_alias)

require "common"


app = null
Application = extends Component {
	__get@defaultAliases = function(){
		return {
			"{app}" = app_alias,
		}
	},
	
	__get@defaultComponents = function(){
		return {
			
		}
	},
	
	__get@defaultController = function(){
		return @config.defaultController || "site"
	},
	
	__get@defaultAction = function(){
		return @config.defaultAction || "index"
	},
	
	__object = {
		_aliases = {},
		_components = {},
		_strings = {},
		_controller = null,
	},
	
	__construct = function(config){
		app ? throw "App is already created" : app = this

		@config = config || {}
		header "Content-type: text/html; charset=${@charset}"
		// echo "Content-type: text/html; charset=${@charset}"
		
		@config.components = (@defaultComponents || {}).merge(@config.components)
		
		// dump(@config);
		@addAliases((@defaultAliases || {}).merge(@config.aliases))
		@addPaths(@paths)
		// dump(@config); terminate()
	},
	
	processRequest = function(){
		var route = @urlManager.parseUrl(@request)
		@runController(route);
	},
	
	runController = function(route){
		var ca, old = @createController(route)
		if(ca){
			old, @_controller = @_controller, ca.controller
			@_controller.init()
			@_controller.runAction(ca.action)
			@_controller = old
		}else{
			throw "Unable to resolve the request \"${route}\""
		}
	},
	
	createController = function(route){
		var p = route.split("/")
		var count, action = #p
		if(!count){
			p = [@defaultController]
		}
		if(count > 1){
			action = p[--count]
			delete p[count]
		}
		p[count-1] = p[count-1].flower() .. "Controller"
		var controller = _G[@resolveClass(p.join("."))](this) // @getComponent(p[0])
		if(controller){
			controller is Controller || throw "Error controller class: ${controller.classname}"
			return {
				controller = controller,
				action = action
			}
		}
	},
	
	getComponent = function(name){
		name || throw "Attempt to create \"null\" component"
		return @_components[name] || {||
			var config, component = @config.components[name] || throw "Component \"${name}\" is not registered"
			if(config.enabled === false){
				throw "Component \"${name}\" is disabled"
			}else{
				@_components[name] = component = _G[@resolveClass(config.classname || name)](this)
				for(var name, value in config){
					if(name != "classname"){
						component[name] = value
					}
				}
				component.init()
				return component
			}
		}.call(this)
	},
	
	setComponent = function(nane, value){
		@_components[name] = value
	},
	
	__get@urlManager = function(){
		return @getComponent("urlManager")
	},
	
	__get@request = function(){
		return @getComponent("request")
	},
	
	resolvePath = function(path){
		var r = {}
		var aliases = @_aliases
		var function replace(path){
			return path.replace(Regexp("#^{[\w\d\._]+?}#"), {|m| 
				var alias = m[0]
				if(alias in r){
					throw "app.resolvePath recursion error: "..path
				}
				r[alias] = true
				return replace(aliases[alias])
			})
		}
		return replace(path)
	},
	
	resolveClass = function(classname){
		var p = classname.split(".")
		var count = #p
		assert(count > 0)
		if(count > 1){
			p[0] = @_aliases["{${p[0]}}"] || p[0]
		}
		p[count-1] = p[count-1].flower()
		// dump([classname, p.join("/")])
		require(p.join("/"), false)
		return p[count-1]
	},
	
	addAliases = function(aliases){
		for(var alias, path in aliases){
			@_aliases[alias] = @resolvePath(path)
		}
	},
	
	addPaths = function(paths){
		for(var _, path in paths){
			path = @resolvePath(path)
			// echo path .. BR
			if(!(path in require.paths)){
				require.paths.push(path)
			}
		}
		// terminate()
	},
	
	__get@paths = function(){
		return @config.paths || []
	},
	
	__set@paths = function(){
		throw "Error to set app.paths, use app.addPaths method"
	},
	
	__get@charset = function(){
		return @config.charset || "utf8"
	},
	
	__set@charset = function(value){
		@config.charset = value
	},
	
	__get@lang = function(){
		return @config.lang || "en"
	},
	
	__set@lang = function(value){
		if(@lang != value){
			@config.lang, @_strings = value, {}
		}
	},
	
	loadStrings = function(group){
		group || group = "strings"
		// echo "app.loadStrings: ${group}${BR}"
		return @_strings[group] = require("${@lang}/${group}")
	},
	
	getStringsGroup = function(group){
		group || group = "strings"
		return @_strings[group] || @loadStrings(group)
	},
	
	setStringsGroup = function(group, value){
		@_strings[group || "strings"] = value
	},
	
	getString = function(name, group){
		return @getStringsGroup(group)[name]
	},
	
	__get@strings = function(){
		return @getStringsGroup("strings")
	},
	
	__set@strings = function(value){
		@setStringsGroup("strings", value)
	},
	
}

function _T(name, group){
	return app.getString(name, group) || name
}
