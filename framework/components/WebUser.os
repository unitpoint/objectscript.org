WebUser = extends Component {
	_user = null,
	
	__get@isLogged = function(){
		return !!@_user
	},
	
	__get@user = function(){
		return @_user
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
			app.session.new().identity = {
				id = user.id,
				// expires = DateTime.now() + duration/(60*60*24),
			}
			return true
		}
	},
}
