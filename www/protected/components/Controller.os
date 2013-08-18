Controller = extends Component {
	/* __object = {
		owner = null,
		actionId = "",
	}, */
	
	actionId = null,
	layout = "main",

	__construct = function(owner){
		super()
		@owner = owner
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
			content = @renderPartial("/layouts/${@layout}", {content = content})
		}
		return content
	},
	
	renderPartial = function(name, params){
		if(name.sub(0, 2) == "//"){
			name = "{views}/${name.sub(2)}"
		}else if(name.sub(0, 1) == "/"){
			name = "{views}/${name.sub(1)}"
		}else{
			name = "{views}/${@classname}/${name}"
		}
		var filename = @owner.resolvePath(name)
		// dump("filename: ${filename}")
		// filename = require.resolve(filename)
		ob.push()
		compileFile(filename, true, null, true).call({controller = this}.merge(params))
		return ob.popContent()
	},
}