SiteController = extends BaseController {

	init = function(){
		super()
		
		/* var data = app.session.data
		data.counter = (data.counter || 0) + 1
		data.ip = _SERVER.REMOTE_ADDR
		data.userAgent = _SERVER.HTTP_USER_AGENT
		data._GET = _GET
		data._POST = _POST */
		if(app.user.loginBySession()){
			@redirect{controller="game", action="index"}
		}
	},

	actionIndex = function(){
		echo @render("index")
	},
	
	actionLogin = function(){
		var model = LoginForm()
		if(_POST.LoginForm){
            // model.scenario = 'generic'
			model.attributes = _POST.LoginForm
			if(model.login()){
				@redirect{controller="game", action="index"}
			}
			// echo "model is not logged <pre>"; dump(model._errors);
		}
		// echo "_POST <pre>"; dump(_POST);
		model.password = ""
		echo @render("index", {
			form = "sign-in",
			model = model,
		})
	},
	
	actionLogout = function(){
		app.session.delete()
		// app.session.close()
		// app.session.data = {}
		@redirect{controller="site", action="index"}
	},
}