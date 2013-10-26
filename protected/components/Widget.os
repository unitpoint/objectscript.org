Widget = extends Controller {
	controller = null,
	
	__construct = function(controller){
		super(controller.owner)
		@controller = controller
	},
	
	run = function(){
		
	},
}