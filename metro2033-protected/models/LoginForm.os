LoginForm = extends Model {
	email = null,
	// username = null,
	password = null,
	// rememberMe = true,
	
	_user = null,

	__get@rules = function(){
		return {
			{{'email', 'password'}, 'required'},
			{'password', 'validatePassword'},
			// {'rememberMe', 'boolean'},
			// {'email', 'safe'},
		}
	},
	
	__get@user = function(){
		return @_user || @_user = User.find{email = @email}
	},
	
	validatePassword = function(){
		if(!@user.validatePassword(@password)){
			@addError("password", _T("Wrong email or password"))
		}
		// echo "validatePassword <pre>"; dump(this)
	},
	
	login = function(){
		return @validate() && app.user.login(@user) // , @rememberMe ? 3600*24*30 : 0)
	},
}
