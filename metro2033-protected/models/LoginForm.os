LoginForm = extends Model {
	email = null,
	password = null,
	invite_code = null,
	// rememberMe = true,
	
	_user = null,
	_invite = null,

	__get@rules = function(){
		return {
			{{'email', 'password'}, 'required', on = 'sign-in'},
			{{'email', 'password', 'invite_code'}, 'required', on = 'register'},
			{'email', 'required', on = 'remember-password'},
			{'password', 'validateUserPassword', on = 'sign-in'},
			{'email', 'validateRegisterEmail', on = 'register'},
			{'invite_code', 'validateRegisterInviteCode', on = 'register'},
		}
	},
	
	__get@labels = function(){
		return {
			email = _T.EMAIL,
			password = _T.PASSWORD,
			invite_code = _T.INVITE_CODE,
		}
	},
	
	__get@placeHolders = function(){
		return {
			invite_code = _T.INVITE_CODE_PLACEHOLDER,
		}
	},
	
	__get@user = function(){
		return @_user || @_user = User.find{email = @email}
	},
	
	__get@invite = function(){
		return @_invite || @_invite = Invite.find{code = @invite_code}
	},
	
	validateUserPassword = function(){
		if(!@user.validatePassword(@password)){
			@addError("password", _T("Wrong email or password"))
		}
		// echo "validatePassword <pre>"; dump(this)
	},
	
	validateRegisterEmail = function(){
		if(@user){
			@addError("email", _T("Email is already registered"))
		}
	},
	
	validateRegisterInviteCode = function(){
		if(!@invite){
			@addError("invite_code", _T("Invitation code is not found"))
		}elseif(@invite.user_id){
			@addError("invite_code", _T("Invitation code has already used"))
		}
	},
	
	login = function(){
		return @validate() && app.user.login(@user) // , @rememberMe ? 3600*24*30 : 0)
	},
	
	register = function(){
		return @validate() && @{
			var invite = @invite
			
			var user_id = User.insert{
				email = @email,
				password_crc = User.hashPassword(@password),
				reg_time = DateTime.now(),
			}
			
			app.db.execute("update {{invite}} set user_id=:user_id where id=:id", {
				user_id = user_id,
				id = invite.id,
			})
			
			var user = User.find{id=user_id}
			if(app.user.login(user)){
				app.redirect{controller="game", action="index"}
			}else{
				@addError("email", _T("Error to register user"))
			}
		}
	},
	
	rememberPassword = function(){
		return @validate() && math.random() < 0.5
	},
}
