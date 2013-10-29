Controller = extends Component {
	/* __object = {
		owner = null,
		actionId = "",
	}, */
	
	controllerId = null,
	controller = null,
	actionId = null,
	layout = "main",
	pageTitle = "ObjectScript Title",
	pageAuthor = "Evgeniy Golovin",
	pageDesc = "ObjectScript это новый, встраиваемый, бесплатный с открытым исходным кодом язык программирования, сочетает преимущества языков программирования JavaScript, Lua, Ruby, Python, PHP",
	
	_widgetStack = null,

	__construct = function(owner, controllerId){
		super()
		@owner = owner
		@controller = this
		@controllerId = controllerId
		@_widgetStack = []
	},

	runAction = function(name){
		var old
		old, @actionId = @actionId, name || @owner.defaultAction
		this["action${@actionId.flower()}"].apply(this, {}.merge(_GET, _POST))
		@actionId = old
	},
	
	render = function(name, params){
		var content = @renderPartial(name, params)
		if(@layout){
			var layout = @layout.sub(0, 1) == "/" ? @layout : "/layouts/${@layout}"
			content = @renderPartial(layout, {content = content})
		}
		return content
	},
	
	resolveView = function(name){
		return @owner.resolveView(@controller, name)
	},
	
	renderPartial = function(name, params){
		return @owner.renderView(@controller, @resolveView(name), params);
	},
	
	createUrl = function(url){
		return @owner.createUrl({controller = @controller.controllerId, action = @controller.actionId}.merge(url))
	},
	
	redirect = function(url){
		@owner.redirect({controller = @controller.controllerId, action = @controller.actionId}.merge(url))
	},
	
	createWidget = function(classname, params){
		return @owner.createWidget(@controller, classname, params)
	},
	
	renderWidget = function(classname, params){
		ob.push()
		@createWidget(classname, params).run()
		return ob.popContent()
	},
	
	widget = function(classname, params){
		var widget = @createWidget(classname, params)
		widget.run()
		return widget
	},
	
	beginWidget = function(classname, params){
		var widget = @createWidget(classname, params)
		@_widgetStack.push(widget)
		return widget
	},
	
	endWidget = function(){
		var widget = @_widgetStack.pop() || throw "${@classname} has an extra endWidget call in its view"
		widget.run()
		return widget
	},
}