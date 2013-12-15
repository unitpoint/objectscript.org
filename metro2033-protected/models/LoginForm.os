LoginForm = extends Model {
	// email = null,
	username = null,
	password = null,
	rememberMe = true,
	
	_user = null,

	__get@rules = function(){
		return {
			// username and password are both required
			{{'username', 'password'}, 'required', requiredValue=123},
			// password is validated by validatePassword()
			{'password', 'validatePassword'},
			// rememberMe must be a boolean value
			{'rememberMe', 'boolean'},
			{'email', 'safe'},
		}
	},
	
	__get@user = function(){
		return @_user || @_user = User.findByUsername(@username)
	},
	
	validatePassword = function(){
		// echo "validatePassword <pre>"; dump(this)
	},
	
	login = function(){
		@password = true
		return @validate() && app.user.login(@user, @rememberMe ? 3600*24*30 : 0)
	},
}
