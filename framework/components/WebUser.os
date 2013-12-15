WebUser = extends Component {
	
	login = function(identity, duration){
		identity || return; // throw "Identity is not set"
		app.session.new.identity = {
			id = identity.id,
			// expires = DateTime.now() + duration/(60*60*24),
		}
	},
	
}
