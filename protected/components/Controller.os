Controller = extends Component {
	/* __object = {
		owner = null,
		actionId = "",
	}, */
	
	controllerId = null,
	actionId = null,
	layout = "main",
	pageTitle = "ObjectScript Title",
	pageDesc = "ObjectScript Desc",
	pageAuthor = "Evgeniy Golovin",

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
		return app.createUrl({controller = @controllerId}.merge(url))
	},
}