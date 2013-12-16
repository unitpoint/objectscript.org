WebUser = extends Component {
	_user = null,
	
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
	
	loginBySession = function(){
		if(app.session.data.identity.id){
			@_user = User.find{id = app.session.data.identity.id}
			return !!@_user
		}
	},
	
}
