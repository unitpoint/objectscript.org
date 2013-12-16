GameController = extends BaseController {

	init = function(){
		super()
		
		/* var data = app.session.data
		data.counter = (data.counter || 0) + 1
		data.ip = _SERVER.REMOTE_ADDR
		data.userAgent = _SERVER.HTTP_USER_AGENT
		data._GET = _GET
		data._POST = _POST */
		
		if(!app.user.loginBySession()){
			@redirect{controller="site", action="index"}
		}
	},

	actionIndex = function(){
		echo @render("index")
	},
}