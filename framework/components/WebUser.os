WebUser = extends Component {
	_user = null,
	
	__get@isLogged = function(){
		return !!@_user
	},
	
	__get@user = function(){
		return @_user
	},
	
	__get = function(name) {
		return @getState(name) || super(name)
	},

	init = function(){
		super()
		if(app.session.data.identity.id){
			if(!(@_user = User.find{id = app.session.data.identity.id})){
				app.session.delete()
			}
		}
	},
	
	login = function(user, duration){
		if(user){
			@_user = user
			@setState{id = user.id}
			return true
		}
	},

	logout = function(user, duration){
		app.session.delete()
	},

	hasState = function(key) {
		return !!app.session.data.identity[key]
	},

	getState = function(key) {
		return app.session.data.identity[key]
	},

	setState = function(state) {
		(app.session.data.identity || app.session.new().identity = {}).merge(state)
	}

}
