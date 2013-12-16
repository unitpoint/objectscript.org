SiteController = extends BaseController {

	init = function(){
		super()
	},
	
	actionLogout = function(){
		app.session.open()
		app.session.delete()
		// app.session.close()
		// app.session.data = {}
		@redirect{controller="site", action="index"}
	},

	actionIndex = function(){
		if(app.user.isLogged){
			@redirect{controller="game", action="index"}
		}
		echo @render("index", {
			form = "sign-in",
			model = LoginForm(),
		})
	},
	
	actionLogin = function(){
		var model = LoginForm()
		if(_POST.LoginForm){
            model.scenario = "sign-in"
			model.attributes = _POST.LoginForm
			if(model.login()){
				@redirect{controller="game", action="index"}
			}
		}
		model.password = ""
		echo @render{"index",
			form = "sign-in",
			model = model,
		}
	},
	
	actionRegister = function(){
		var model = LoginForm()
		if(_POST.LoginForm){
            model.scenario = "register"
			model.attributes = _POST.LoginForm
			if(model.register()){
				@redirect{controller="game", action="index"}
			}
		}
		echo @render{"index",
			form = "register",
			model = model,
		}
	},
	
	actionRememberPassword = function(){
		var model = LoginForm()
		if(_POST.LoginForm){
            model.scenario = "remember-password"
			model.attributes = _POST.LoginForm
			if(model.rememberPassword()){
				model.addMessage("email", _T("Your password has been successfully sent to your email"))
				model.email = ""
			}else{
				model.addError("email", _T("The email address you entered was not found"))
			}
		}
		echo @render{"index",
			form = "remember-password",
			model = model,
		}
	},
}