var appAlias = path.dirname(__DIR__)

require "common"

app = null
Application = extends Component {
	__get@defaultAliases = function(){
		return {
			"{app}" = appAlias,
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
	
	__get@params = function(){
		return @config.params
	},
	
	__object = {
		_aliases = {},
		_components = {},
		_strings = {},
		_controller = null,
		_compiledViews = {},
	},
	
	__construct = function(config){
		app ? throw "App is already created" : app = this

		@config = config || {}
		// echo "Content-type: text/html; charset=${@charset}"
		
		@config.components = (@defaultComponents || {}).merge(@config.components)
		
		// dump(@config);
		@addAliases((@defaultAliases || {}).merge(@config.aliases))
		@addPaths(@paths)
		// dump(@config); terminate()
	},
	
	run = function(){
		header "Content-type: text/html; charset=${@charset}"
		@processRequest()
	},
	
	processRequest = function(){
		var route = @urlManager.parseUrl(@request)
		@runController(route);
	},
	
	runController = function(route){
		var controller, actionId, old = @createController(route)
		if(controller){
			old, @_controller = @_controller, controller
			controller.init()
			controller.runAction(actionId)
			@_controller = old
		}else{
			throw "Unable to resolve the request \"${route}\""
		}
	},
	
	createController = function(route){
		var p = (stringOf(route) || @defaultController).split("/")
		var count, actionId = #p
		if(count > 1){
			actionId = p.pop()
			count--
		}
		var controllerId = p.last
		p.last = controllerId.flower() .. "Controller"
		var controller = _G[@resolveClass(p.join("."))](this, controllerId) // @getComponent(p[0])
		if(controller){
			controller is Controller || throw "Error controller class: ${controller.classname}"
			return controller, actionId
		}
	},
	
	createWidget = function(controller, classname, params){
		if(objectOf(classname)){
			params && throw "3rd argument should not be used here"
			classname, params = classname.shift(), classname
		}
		var widget = _G[@resolveClass(classname)](controller)
		widget is Widget || throw "Error widget class: ${widget.classname}"
		for(var key, value in params){
			widget[key] = value
		}
		widget.init()
		return widget
	},
	
	getComponent = function(name, config){
		name || throw "Attempt to create \"null\" component"
		return @_components[name] || {||
			config || config = @config.components[name] || throw "Component \"${name}\" is not configured"
			config.enabled === false && throw "Component \"${name}\" is disabled"
			var component
			@_components[name] = component = _G[@resolveClass(config.classname || name)](this)
			for(var key, value in config){
				if(key != "classname" && key != "enabled"){
					component[key] = value
				}
			}
			component.init()
			return component
		}.call(this)
	},
	
	setComponent = function(name, value){
		@_components[name] = value
	},
	
	__get = function(name){
		return @getComponent(name)
	},
	
	__get@urlManager = function(){
		return @getComponent("urlManager")
	},
	
	__get@request = function(){
		return @getComponent("request")
	},
	
	__get@db = function(){
		return @getComponent("db")
	},
	
	createUrl = function(url){
		return @urlManager.createUrl(url)
	},
	
	end = function(){
		terminate()
	},
	
	redirect = function(url){
		@request.redirect(@createUrl(url))
	},
	
	resolveAliases = function(path){
		var r, aliases = {}, @_aliases
		var function replace(path){
			return path.replace(Regexp("#{[\w\d\._]+?}#"), {|m| 
				var alias = m[0]
				r[alias] && throw "app.resolveAliases recursion error: ${path}"
				r[alias] = true
				return replace(aliases[alias] || throw "Alias \"${alias}\" is not resolved")
			})
		}
		return replace(path)
	},
	
	resolveClass = function(classname){
		var p = (stringOf(classname) || throw "classname required").split(".")
		var count = #p
		// assert(count > 0)
		if(count > 1){
			p[0] = @_aliases["{${p[0]}}"] || p[0]
		}
		p.last = p.last.flower()
		// dump([classname, p.join("/")])
		require(p.join("/"), false)
		return p.last
	},
	
	addAliases = function(aliases){
		for(var alias, path in aliases){
			@_aliases[alias] = @resolveAliases(path)
		}
	},
	
	addPaths = function(paths){
		for(var _, path in paths){
			path = @resolveAliases(path)
			// echo path .. BR
			if(!(path in require.paths)){
				require.paths.push(path)
			}
		}
		// terminate()
	},

	resolveView = function(controller, name){
		if(!path.exists(name) && !path.absolute(name)){
			if(name.sub(0, 2) == "//"){
				name = "{views}/${name.sub(2)}"
			}else{ 
				var start = name.sub(0, 1)
				if(start == "/"){
					name = "{views}${name}"
				}else if(start != "{"){
					name = "{views}/${controller.classname}/${name}"
				}else{
					// echo "renderView: ${name} <br />"
				}
			}
		}
		var filename = @resolveAliases(name)
		return require.resolve(path.dirname(filename).."/${@lang}/"..path.basename(filename)) || filename
	},
	
	renderView = function(controller, filename, params){
		ob.push()
		var view = @_compiledViews[filename] || @_compiledViews[filename] = compileFile(filename, true, null, true)
		view.call({controller = controller}.merge(params))
		return ob.popContents()
	},
	
	__get@paths = function(){
		return @config.paths || []
	},
	
	__set@paths = function(){
		throw "Error to set app.paths, use app.addPaths method"
	},
	
	__get@charset = function(){
		return @config.charset || "utf-8"
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
		return @_strings[group] = require(@resolveAliases("{langs}/${@lang}/${group}"))
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

_T.__get = _T
