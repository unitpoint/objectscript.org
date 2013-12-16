GameController = extends BaseController {

	init = function(){
		super()
		if(!app.user.isLogged){
			@redirect{controller="site", action="index"}
		}
	},

	actionIndex = function(){
		echo @render("index")
	},
}