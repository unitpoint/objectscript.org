// print "load Application"

function Object.attrs(params){
	for(var k, v in params){
		@[k] = v
	}
}

function String.ucfirst(){
	return @sub(0, 1).upper() .. @sub(1)
}

Application = {
	__object = {
		components = {}
	}
	
	run = function(){
		@processRequest()
	}
	
	__get@controllerPath = {||}
	
	getCompoment = function(name){
		if(name in @components){
			return @components[name]
		}
	
		if(!(name in @config.components)){
			throw sprintf("Component '%s' is not defined in config.components", name)
		}
		var config = @config.components[name].clone()
		if(!("enabled" in config) || config.enabled){
			delete config.enabled
			
			var classname = "class" in config ? config.class : name.ucfirst()
			delete config.class
			
			var component = @createComponent(classname, config)
			@components[name] = component
			return component
		}
	}
	
	processRequest = function(){
		throw "abstract method"
	}
	
	createComponent = function(classname, config){
		var component = _G[classname]()
		component || throw sprintf("Component '%s' is not created", classname)
		config && component.attrs(config)
		component.init()
		return component
	}
}