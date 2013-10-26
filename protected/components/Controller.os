Controller = extends Component {
	/* __object = {
		owner = null,
		actionId = "",
	}, */
	
	controllerId = null,
	actionId = null,
	layout = "main",
	pageTitle = "ObjectScript Title",
	pageAuthor = "Evgeniy Golovin",
	pageDesc = "ObjectScript это новый, встраиваемый, бесплатный с открытым исходным кодом язык программирования, сочетает преимущества языков программирования JavaScript, Lua, Ruby, Python, PHP",

	__construct = function(owner, controllerId){
		super()
		@owner = owner
		@controllerId = controllerId
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
	
	renderPartial = function(name, params){
		return @owner.renderView(this, name, params);
	},
	
	createUrl = function(url){
		return app.createUrl({controller = @controllerId, action = @actionId}.merge(url))
	},
	
	redirect = function(url){
		app.redirect({controller = @controllerId, action = @actionId}.merge(url))
	},
}