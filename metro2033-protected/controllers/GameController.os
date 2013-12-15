GameController = extends OSController {

	init = function(){
		super()
		
		header("Expires: "..(DateTime.now()-1).format("R"))
		header("Last-Modified: "..(DateTime.now()-2).format("R"))
		
		var data = app.session.data
		data.counter = (data.counter || 0) + 1
		data.ip = _SERVER.REMOTE_ADDR
		data.userAgent = _SERVER.HTTP_USER_AGENT
		data._GET = _GET
		data._POST = _POST
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
				@redirect(app.user.returnUrl)
			}
			echo "model <pre>"; dump(model);
		}
		echo "_POST <pre>"; dump(_POST);
	},
}