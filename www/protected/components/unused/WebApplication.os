// print "load WebApplication"

WebApplication = extends Application {
	__object = {
		defaultController = "site"
		layout = "main"
		controllerMap = {}
		
		config = {
			components = {
				urlManager = {
				
				}
				
				request = {
				
				}
			}
		}
		controller = null
	}
	
	hasComponent = function(name){
		throw this
		return name in @components || name in @config.components
	}
	
	setComponent = function(name, component){
		@components[name] = component
	}
	
	__get@urlManager 	= {||@getCompoment('urlManager')}
	__get@db 			= {||@getCompoment('db')}
	__get@request		= {||@getCompoment('request')}
	
	__isset = {|name|@hasComponent(name) || super(name)}
	
	__get = function(name){
		if(@hasComponent(name)){
			return @getCompoment(name)
		}
		return super(name)
	}

	__set = function(name, val){
		if(@hasComponent(name)){
			@setCompoment(name, val)
			return
		}
		super(name, val)
	}
	
	processRequest = function(){
		var route = @urlManager.parseUrl(@request)
		@runController route
	}
	
	runController = function(route){
		var controller, actionId = @createController(route)
		controller || throw "Error to create controller for route: "..route
		var oldController = @controller
		@controller = controller
		controller.init()
		controller.run(actionId)
		@controller = oldController
	}
	
	createController = function(route, owner){
		// stringOf(route) || throw "Route params must be string"
		owner = owner || this
		route = route.trim()
		if(#route == 0){
			route = @defaultController
		}
		var routePaths = route.split("/")
		var controllerId, actionId = routePaths[0].ucfirst(), routePaths[1]
		return @createComponent(controllerId .. "Controller"), actionId
	}
	
}