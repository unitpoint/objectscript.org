require "common"

app = null

Application = extends Component {
	__get@defaultAliases = function(){
		return {
			"{framework}" = path.dirname(__DIR__),
		}
	},
	
	__get@defaultPaths = function(){
		return {
			"{framework}/components",
			"{framework}/helpers",
			"{framework}/controllers",
			"{framework}/widgets",
			"{framework}/langs",
			"{framework}/views",
		}
	},
	
	__get@defaultComponents = function(){
		return {
			session = {
				classname = "FileSession",
			},
			urlManager = {
				classname = "UrlManager",
			},
			request = {
				classname = "HttpRequest",
			},			
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
		
		@config.components = {}.merge(@defaultComponents, @config.components)
		
		// dump(@config);
		@addAliases({}.merge(@defaultAliases, @config.aliases))
		
		// paths is array
		@addPaths([].merge(@defaultPaths, @config.paths))
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
	
	__get@controller = function(){
		return @_controller
	},
	
	runController = function(route){
		var controller, actionId, old = @createController(route)
		if(controller){
			old, @_controller = @_controller, controller
			// controller.init()
			controller.runAction(actionId)
			@_controller = old
		}else{
			throw "Unable to resolve the request \"${route}\""
		}
	},
	
	createController = function(route){
		var p = (stringOf(route) || @defaultController).split("/")
		var actionId = #p > 1 ? p.pop() : null
		var controllerId = p.last
		p.last = controllerId.flower() .. "Controller"
		var controller = _G[@resolveClass(p.join("."))](this, controllerId) // @getComponent(p[0])
		if(controller){
			controller is Controller || throw "Error controller class: ${controller.classname}"
			controller.init()
			return controller, actionId
		}
	},
	
	createWidget = function(classname, params, controller){
		if(objectOf(classname)){
			params && throw "2rd argument should be null here"
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
		return @_components[name || throw "Attempt to create empty component"] || @{
			config || config = @config.components[name] || throw "Component \"${name}\" is not configured"
			config.enabled === false && throw "Component \"${name}\" is disabled"
			var component
			@_components[name] = component = _G[@resolveClass(config.classname || name)](this)
			component is Component || throw "Error component class: ${component.classname}"
			for(var key, value in config){
				if(key != "classname" && key != "enabled"){
					component[key] = value
				}
			}
			component.init()
			return component
		}
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
		if(#p > 1){
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
		var newPaths = require.paths.flip()
		for(var _, path in paths){
			path = @resolveAliases(path)
			newPaths[path] = path
		}
		require.paths = newPaths.values
	},

	resolveView = function(name, controller){
		if(!fs.exists(name) && !path.absolute(name)){
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
		var dirname, basename = path.dirname(filename), path.basename(filename)
		return require.resolve("${dirname}/${@lang}/${basename}") 
			|| (@lang != @baseLang ? require.resolve("${dirname}/${@baseLang}/${basename}") : null)
			|| filename
	},
	
	renderView = function(filename, params, controller){
		ob.push()
		var view = @_compiledViews[filename] || @_compiledViews[filename] = compileFile(filename, true, null, true)
		view.call({controller = controller}.merge(params))
		return ob.popContents()
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
		@config.lang = value
	},
	
	__get@baseLang = function(){
		return @config.baseLang || "en"
	},
	
	__set@baseLang = function(value){
		@config.baseLang = value
	},
	
	getLangStrings = function(lang){
		lang || lang = @lang
		return @_strings[lang] || @_strings[lang] = {}
	},
	
	loadStrings = function(group, lang, required){
		group || group = "strings"
		lang || lang = @lang
		// echo "app.loadStrings: ${group}${BR}"
		return @getLangStrings(lang)[group] = require(@resolveAliases("{langs}/${lang}/${group}"), required) || {}
	},
	
	getStringsGroup = function(group, lang, required){
		group || group = "strings"
		lang || lang = @lang
		return @getLangStrings(lang)[group] || @loadStrings(group, lang, required)
	},
	
	setStringsGroup = function(group, value, lang){
		@getLangStrings(lang)[group || "strings"] = value
	},
	
	getString = function(name, group, lang){
		return @getStringsGroup(group, lang)[name] 
			|| ((lang || @lang) != @baseLang ? @getStringsGroup(group, @baseLang, false)[name] : null)
	},
	
	__get@strings = function(){
		return @getStringsGroup("strings")
	},
	
	__set@strings = function(value){
		@setStringsGroup("strings", value)
	},
	
}

function _T(name, group, lang){
	return app.getString(name, group, lang) || name
}

_T.__get = _T
